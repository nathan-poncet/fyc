defmodule Connect4Telnet.Endpoint do
  use Supervisor

  require Logger

  def start_link(opts) do
    Supervisor.start_link(__MODULE__, :ok, opts)
  end

  def init(:ok) do
    Logger.info("Starting the HTTP server...")

    port = Application.get_env(:servy, :port) || 4040

    children = [
      {DynamicSupervisor, name: __MODULE__.DynamicSupervisor, strategy: :one_for_one},
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

    start_connection(client)

    loop_acceptor(socket)
  end

  defp start_connection(client) do
    case DynamicSupervisor.start_child(
           __MODULE__.DynamicSupervisor,
           {Connect4Telnet.Conn, client}
         ) do
      {:ok, pid} ->
        :ok = :gen_tcp.controlling_process(client, pid)
        Logger.info("Started a new connection: #{inspect(pid)}")

      {:error, reason} ->
        Logger.error("Failed to start a new connection: #{inspect(reason)}")
    end
  end
end
