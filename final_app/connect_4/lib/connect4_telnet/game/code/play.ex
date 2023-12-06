defmodule Connect4Telnet.Game.Code.Play do
  alias Connect4Telnet.Conn

  def start(conn) do
    %Conn{path: [:game, code, :actions, :play]} = conn

    case Connect4.Game.play(code) do
      {:ok, _} ->
        %Conn{conn | path: [:game, code, :actions], status: :ok, resp: ""}

      {:error, reason} ->
        %Conn{conn | path: [:game, code, :actions], status: :error, resp: reason}
    end
  end
end
