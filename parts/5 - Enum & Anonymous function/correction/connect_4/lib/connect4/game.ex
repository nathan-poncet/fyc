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

  def join(game, player) do
    %{game | players: game.players ++ [player]}
  end

  def leave(game, player_id) do
    %{players: players} = game

    players = Enum.filter(players, fn p -> p.id != player_id end)

    %{game | players: players}
  end

  def start(%{status: :lobby} = game) do
    %{game | status: :playing}
  end

  def lobby(%{status: :game_over} = game) do
    %{game | status: :lobby}
  end

  def move(game, player, col_index) do
    board = game.board

    # Try to find the first empty cell in the column
    row_index = board_find_row_index_from_col_index(board, col_index)

    board = board_put_piece(board, %{x: col_index, y: row_index}, player.symbol)

    %{game | board: board}
  end

  defp board_generate(cols, rows),
    do: {Enum.map(1..rows, fn _ -> Enum.map(1..cols, fn _ -> nil end) end), cols, rows}

  defp board_find_row_index_from_col_index(board, col_index),
    do: Enum.find_index(board, fn row -> Enum.at(row, col_index) == nil end)

  defp board_put_piece(board, %{x: col_index, y: row_index}, piece) do
    List.update_at(board, row_index, fn row ->
      List.update_at(row, col_index, fn _ -> piece end)
    end)
  end
end
