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

  def move(game, player, col_index)
      when 0 <= col_index and col_index < game.settings.board.cols do
    IO.puts("Make your move!")

    board = game.board

    # Try to find the first empty cell in the column
    row_index = board_find_row_index_from_col_index(board, col_index)

    if row_index == nil do
      IO.puts("Invalid column index!")
    else
      board = board_put_piece(board, col_index, row_index, player.symbol)

      case {board_win(board, game.settings, %{x: col_index, y: row_index}), board_is_full?(board)} do
        {true, _} ->
          IO.puts("You win!")
          %{game | board: board, status: :game_over}

        {_, true} ->
          IO.puts("It's a draw!")
          %{game | board: board, status: :game_over}

        _ ->
          %{game | board: board}
      end
    end
  end

  defp board_generate(cols, rows) when cols > 0 and rows > 0,
    do: Enum.map(1..rows, fn _ -> Enum.map(1..cols, fn _ -> nil end) end)

  defp board_find_row_index_from_col_index(board, col_index),
    do: Enum.find_index(board, fn row -> Enum.at(row, col_index) == nil end)

  defp board_put_piece(board, row_index, col_index, piece) do
    List.update_at(board, row_index, fn row ->
      List.update_at(row, col_index, fn _ -> piece end)
    end)
  end

  def board_win(board, settings, pos) do
    board_win_horizontal?(board, settings, pos) or
      board_win_vertical?(board, settings, pos) or
      board_win_diagonal?(board, settings, pos)
  end

  defp board_win_horizontal?(board, settings, pos) do
    %{board: %{cols: cols}, winning_length: winning_length} = settings
    %{x: x, y: y} = pos

    start = max(x - (winning_length - 1), 0)
    range = min(x + (winning_length - 1) * 2, cols - 1)

    board
    |> Enum.at(y)
    |> Enum.slice(start, range)
    |> has_winning_sequence?(winning_length)
  end

  defp board_win_vertical?(board, settings, pos) do
    %{board: %{rows: rows}, winning_length: winning_length} = settings
    %{x: x, y: y} = pos

    start = max(y - (winning_length - 1), 0)
    range = min(y + (winning_length - 1) * 2, rows - 1)

    board
    |> transpose()
    |> Enum.at(x)
    |> Enum.slice(start, range)
    |> has_winning_sequence?(winning_length)
  end

  defp board_win_diagonal?(board, settings, pos) do
    %{winning_length: winning_length} = settings
    {main_diagonal, anti_diagonal} = extract_diagonals(board, settings, pos)

    has_winning_sequence?(main_diagonal, winning_length) or
      has_winning_sequence?(anti_diagonal, winning_length)
  end

  defp transpose(matrix) do
    matrix
    |> Enum.zip()
    |> Enum.map(&Tuple.to_list/1)
  end

  def extract_diagonals(board, settings, pos) do
    main_diagonal = extract_diagonal(board, settings, pos, fn x, y, i -> {x + i, y + i} end)
    anti_diagonal = extract_diagonal(board, settings, pos, fn x, y, i -> {x - i, y + i} end)
    {main_diagonal, anti_diagonal}
  end

  defp extract_diagonal(board, settings, pos, delta_fun) do
    %{winning_length: winning_length} = settings
    %{x: x, y: y} = pos

    Enum.reduce(-(winning_length - 1)..(winning_length - 1), [], fn i, acc ->
      {x, y} = delta_fun.(x, y, i)

      [board |> Enum.at(y, []) |> Enum.at(x) | acc]
    end)
  end

  defp has_winning_sequence?(sequence, winning_length) do
    sequence
    |> Enum.chunk_by(& &1)
    |> Enum.filter(fn chunk -> !Enum.any?(chunk, &(&1 == nil)) end)
    |> Enum.any?(fn chunk -> length(chunk) >= winning_length end)
  end

  defp board_is_full?(board) do
    Enum.all?(board, fn row -> Enum.all?(row, fn cell -> cell != nil end) end)
  end
end
