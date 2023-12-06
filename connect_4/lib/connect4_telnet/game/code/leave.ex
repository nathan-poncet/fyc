defmodule Connect4Telnet.Game.Code.Leave do
  alias Connect4Telnet.Conn

  def start(%Conn{} = conn) do
    %Conn{
      listen_pid: listen_pid,
      path: [:game, code, :actions, :leave]
    } = conn

    case Connect4.Game.leave(code, listen_pid) do
      {:ok, _} ->
        %Conn{conn | path: [:game], status: :ok, resp: "game left: #{code}"}

      {:closed, _} ->
        %Conn{conn | path: [:game], status: :ok, resp: "game closed: #{code}"}

      {:error, reason} ->
        %Conn{conn | path: [:game, code, :actions], status: :error, resp: reason}
    end
  end
end
