defmodule Connect4Telnet.Endpoint do
  alias Connect4Telnet.Handler
  alias Connect4Telnet.Conn

  require Logger

  def accept(port) do
    {:ok, socket} =
      :gen_tcp.listen(port, [:binary, packet: :line, active: false, reuseaddr: true])

    Logger.info("Accepting conns on port #{port}")
    loop_acceptor(socket)
  end

  defp loop_acceptor(socket) do
    {:ok, client} = :gen_tcp.accept(socket)

    pid = spawn(fn -> serve(%Conn{pid: self(), socket: client}) end)

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

  defp read_request(%Conn{socket: socket} = conn) do
    {:ok, data} = :gen_tcp.recv(socket, 0)
    %Conn{conn | request: data}
  end

  defp send_response(%Conn{socket: socket, response: resp} = conn) do
    :gen_tcp.send(socket, "#{resp}\n")
    conn
  end
end
