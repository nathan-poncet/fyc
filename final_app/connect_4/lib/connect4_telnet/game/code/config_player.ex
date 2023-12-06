defmodule Connect4Telnet.Game.Code.ConfigPlayer do
  alias Connect4Telnet.Conn

  def start(%Conn{} = conn) do
    %Conn{
      listen_pid: listen_pid,
      path: [:game, code, :actions, :configure_player],
      params: params
    } = conn

    case Connect4.Game.configure_player(code, listen_pid, params) do
      {:ok, _} ->
        %Conn{
          conn
          | path: [:game, code, :actions],
            status: :ok,
            resp: "player configured correctly"
        }

      {:error, reason} ->
        %Conn{conn | path: [:game, code, :actions], status: :error, resp: reason}
    end
  end
end
