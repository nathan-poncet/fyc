defmodule Connect4.Game.Dropper do
  alias Connect4.Game.Board
  alias Connect4.Game.Player
  alias Connect4.Game

  def drop_piece(%Game{} = game, %Player{} = player, %{x: x, y: y}) do
    %Game{board: %Board{table: table} = board} =
      game

    # Get the current player
    %Player{symbol: symbol} = player

    # Drop the piece
    updated_table =
      List.update_at(table, y, fn row_data ->
        List.update_at(row_data, x, fn _ -> symbol end)
      end)

    %Game{game | board: %Board{board | table: updated_table}}
  end
end
