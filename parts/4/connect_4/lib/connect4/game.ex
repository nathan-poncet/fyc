defmodule Connect4.Game do
  def create(player, name, settings) do
    %{board: %{cols: cols, rows: rows}} = settings

    {board, cols, rows} = board_generate(cols, rows)

    %{
      name: name,
      board: board,
      players: [player],
      settings: %{settings | board: %{settings.board | cols: cols, rows: rows}},
      status: :lobby
    }
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

    # Try to find the first empty cell in the column
    row_index = board_find_row_index_from_col_index(board, col_index)

    board = board_put_piece(board, col_index, row_index, player.symbol)

    %{game | board: board}
  end

  defp board_generate(42, 42) do
    IO.puts("""
    Life, the Universe and Everything
    You discovered the easter egg!
    """)

    random_cols = Enum.random(1..20)
    random_rows = Enum.random(1..20)

    {Enum.map(1..random_rows, fn _ -> Enum.map(1..random_cols, fn _ -> nil end) end), random_cols,
     random_rows}
  end

  defp board_generate(cols, rows),
    do: {Enum.map(1..rows, fn _ -> Enum.map(1..cols, fn _ -> nil end) end), cols, rows}

  defp board_find_row_index_from_col_index(board, col_index),
    do: Enum.find_index(board, fn row -> Enum.at(row, col_index) == nil end)

  defp board_put_piece(board, row_index, col_index, piece) do
    List.update_at(board, row_index, fn row ->
      List.update_at(row, col_index, fn _ -> piece end)
    end)
  end
end
