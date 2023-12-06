defmodule Connect4Telnet.Endpoint do
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
        listen_pid = spawn_link(fn -> listen_loop(client) end)
        serve(%Conn{socket: client, listen_pid: listen_pid})
      end)

    :ok = :gen_tcp.controlling_process(client, pid)

    loop_acceptor(socket)
  end

  defp serve(%Conn{status: :close} = conn) do
    conn
  end

  defp serve(%Conn{} = conn) do
    conn |> Connect4Telnet.Router.route() |> send_response() |> serve()
  end

  defp send_response(%Conn{resp: ""} = conn) do
    conn
  end

  defp send_response(%Conn{socket: socket, status: :error, resp: resp} = conn) do
    :gen_tcp.send(socket, "Error: #{resp}}\n")
    conn
  end

  defp send_response(%Conn{socket: socket, resp: resp} = conn) do
    :gen_tcp.send(socket, "#{resp}\n")
    conn
  end

  defp listen_loop(socket) do
    receive do
      {:send, message} ->
        :ok = :gen_tcp.send(socket, "#{message}\n")
        listen_loop(socket)
    end
  end
end
