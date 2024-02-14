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
    id_available = Enum.all?(game.players, fn p -> p.id != player.id end)
    symbol_available = Enum.all?(game.players, fn p -> p.symbol != player.symbol end)

    case {id_available, symbol_available} do
      {false, _} ->
        game

      {_, false} ->
        game

      {true, true} ->
        %{game | players: game.players ++ [player]}
    end
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

  def move(game, player, col_index)
      when 0 <= col_index and col_index < game.settings.board.cols do
    board = game.board

    # Try to find the first empty cell in the column
    row_index = board_find_row_index_from_col_index(board, col_index)

    board = board_put_piece(board, %{x: col_index, y: row_index}, player.symbol)

    %{game | board: board}
  end

  defp board_generate(42, 42) do
    random_cols = Enum.random(1..20)
    random_rows = Enum.random(1..20)

    {Enum.map(1..random_rows, fn _ -> Enum.map(1..random_cols, fn _ -> nil end) end), random_cols,
     random_rows}
  end

  defp board_generate(cols, rows) when cols > 0 and rows > 0,
    do: {Enum.map(1..rows, fn _ -> Enum.map(1..cols, fn _ -> nil end) end), cols, rows}

  defp board_generate(_, _),
    do: {Enum.map(1..6, fn _ -> Enum.map(1..7, fn _ -> nil end) end), 7, 6}

  defp board_find_row_index_from_col_index(board, col_index),
    do: Enum.find_index(board, fn row -> Enum.at(row, col_index) == nil end)

  defp board_put_piece(board, %{x: col_index, y: row_index}, piece) do
    List.update_at(board, row_index, fn row ->
      List.update_at(row, col_index, fn _ -> piece end)
    end)
  end
end
