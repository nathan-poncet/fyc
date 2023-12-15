defmodule Connect4.Game do
  def move(game, player, col_index) do
    IO.puts("Make your move!")

    board = game.board

    board = board_put_piece(board, player, col_index)

    %{game | board: board}
  end

  defp board_put_piece(board, player, col_index) do
    symbol = player.symbol

    # Try to find the first empty cell in the column
    row_index = Enum.find_index(board, fn row -> Enum.at(row, col_index) == nil end)

    # Place the piece in the cell
    board =
      List.update_at(board, row_index, fn row ->
        List.update_at(row, col_index, fn _ -> symbol end)
      end)

    board
  end
end
