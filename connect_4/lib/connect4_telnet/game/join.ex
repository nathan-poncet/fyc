defmodule Connect4Telnet.Game.Join do
  alias Connect4Telnet.Conn

  def start(%Conn{path: [:game, :actions, :join, code]} = conn) do
    %Conn{listen_pid: listen_pid} = conn

    case Connect4.Game.join(code, listen_pid) do
      {:ok, _} ->
        %Conn{conn | path: [:game, code], status: :ok, resp: "game joined: #{code}"}

      {:error, reason} ->
        %Conn{conn | path: [:game, :actions], status: :error, resp: reason}
    end
  end
end
