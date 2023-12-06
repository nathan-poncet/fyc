defmodule Connect4Telnet.Game.Code.DropPiece do
  alias Connect4Telnet.Conn

  def start(conn) do
    %Conn{listen_pid: listen_pid, path: [:game, code, :actions, :drop_piece, col_input]} =
      conn

    case Connect4.Game.drop_piece(code, listen_pid, col_input) do
      {:ok, _} ->
        %Conn{conn | path: [:game, code, :actions], status: :ok, resp: ""}

      {:error, reason} ->
        %Conn{conn | path: [:game, code, :actions], status: :error, resp: reason}
    end
  end
end
