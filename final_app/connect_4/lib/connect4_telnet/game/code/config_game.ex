defmodule Connect4Telnet.Game.Code.ConfigGame do
  alias Connect4Telnet.Conn

  def start(%Conn{} = conn) do
    %Conn{path: [:game, code, :actions, :configure_game], params: params} = conn

    case Connect4.Game.configure(code, params) do
      {:ok, _} ->
        %Conn{
          conn
          | path: [:game, code, :actions],
            status: :ok,
            resp: "game configured correctly: #{code}"
        }

      {:error, reason} ->
        %Conn{conn | path: [:game, code, :actions], status: :error, resp: reason}
    end
  end
end
