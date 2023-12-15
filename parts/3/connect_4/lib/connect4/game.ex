defmodule Connect4.Game do
  def create(player, name, settings) do
    %{board: %{cols: cols, rows: rows}} = settings

    board = board_generate(cols, rows)

    %{name: name, board: board, players: [player], settings: settings, status: :lobby}
  end

  def start(%{status: :lobby} = game) do
    IO.puts("Let's play! Connect 4!")
    %{game | status: :playing}
  end

  def stop(%{status: :playing} = game) do
    IO.puts("Thanks for playing!")
    %{game | status: :game_over}
  end

  def move(game, player, col_index) do
    IO.puts("Make your move!")

    board = game.board

    board = board_put_piece(board, player, col_index)

    %{game | board: board}
  end

  defp board_generate(cols, rows),
    do: Enum.map(1..rows, fn _ -> Enum.map(1..cols, fn _ -> nil end) end)

  defp board_put_piece(board, player, col_index) do
    symbol = player.symbol

    # Try to find the first empty cell in the column
    row_index = Enum.find_index(board, fn row -> Enum.at(row, col_index) == nil end)

    # Place the piece in the cell
    List.update_at(board, row_index, fn row ->
      List.update_at(row, col_index, fn _ -> symbol end)
    end)
  end
end
