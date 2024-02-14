defmodule Connect4Telnet.Endpoint do
  alias Connect4Telnet.Handler
  alias Connect4Telnet.Conn
  use Supervisor

  require Logger

  def start_link(opts) do
    Supervisor.start_link(__MODULE__, :ok, opts)
  end

  def init(:ok) do
    Logger.info("Starting the HTTP server...")
    port = Application.get_env(:servy, :port) || 4040

    children = [
      {Task.Supervisor, name: Connect4Telnet.TaskSupervisor, strategy: :one_for_one},
      Supervisor.child_spec({Task, fn -> Connect4Telnet.Endpoint.accept(port) end},
        restart: :permanent
      )
    ]

    Supervisor.init(children, strategy: :one_for_one)
  end

  def accept(port) do
    {:ok, socket} =
      :gen_tcp.listen(port, [:binary, packet: :line, active: false, reuseaddr: true])

    Logger.info("Accepting conns on port #{port}")
    loop_acceptor(socket)
  end

  defp loop_acceptor(socket) do
    {:ok, client} = :gen_tcp.accept(socket)

    {:ok, pid} =
      Task.Supervisor.start_child(Connect4Telnet.TaskSupervisor, fn ->
        serve(%Conn{pid: self(), socket: client})
      end)

    :ok = :gen_tcp.controlling_process(client, pid)

    loop_acceptor(socket)
  end

  defp serve(%Conn{socket: socket, status: :closed} = conn) do
    :gen_tcp.close(socket)
    conn
  end

  defp serve(%Conn{} = conn) do
    conn |> read_request() |> Handler.handle() |> send_response() |> serve()
  end

  defp read_request(%Conn{path: path, socket: socket} = conn) do
    case :actions in path do
      true ->
        {:ok, data} = :gen_tcp.recv(socket, 0)
        %Conn{conn | request: data}

      false ->
        %Conn{conn | request: ""}
    end
  end

  defp send_response(%Conn{socket: socket, response: resp} = conn) do
    :gen_tcp.send(socket, "#{resp}\n")
    conn
  end
end
