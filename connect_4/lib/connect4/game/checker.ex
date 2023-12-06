defmodule Connect4.Game.Checker do
  alias Connect4.Game.Board
  alias Connect4.Game

  def check_win(%Game{} = game, pos) do
    if horizontal_win?(game, pos) ||
         vertical_win?(game, pos) ||
         diagonal_win?(game, pos) do
      %Game{game | status: :game_over}
    else
      game
    end
  end

  defp horizontal_win?(%Game{} = game, %{x: x, y: y}) do
    %Game{board: %Board{table: table, cols: cols}, winning_length: winning_length} = game

    start = max(x - (winning_length - 1), 0)
    range = min(x + (winning_length - 1) * 2, cols - 1)

    table
    |> Enum.at(y)
    |> Enum.slice(start, range)
    |> (&has_winning_sequence?(game, &1)).()
  end

  defp vertical_win?(%Game{} = game, %{x: x, y: y}) do
    %Game{board: %Board{table: table, rows: rows}, winning_length: winning_length} = game

    start = max(y - (winning_length - 1), 0)
    range = min(y + (winning_length - 1) * 2, rows - 1)

    table
    |> transpose()
    |> Enum.at(x)
    |> Enum.slice(start, range)
    |> (&has_winning_sequence?(game, &1)).()
  end

  defp diagonal_win?(%Game{} = game, pos) do
    {main_diagonal, anti_diagonal} = extract_diagonals(game, pos)

    has_winning_sequence?(game, main_diagonal) || has_winning_sequence?(game, anti_diagonal)
  end

  defp transpose(matrix) do
    matrix
    |> Enum.zip()
    |> Enum.map(&Tuple.to_list/1)
  end

  def extract_diagonals(%Game{} = game, pos) do
    main_diagonal = extract_diagonal(game, pos, fn x, y, i -> {x + i, y + i} end)
    anti_diagonal = extract_diagonal(game, pos, fn x, y, i -> {x - i, y + i} end)
    {main_diagonal, anti_diagonal}
  end

  defp extract_diagonal(%Game{} = game, %{x: x, y: y}, delta_fun) do
    %Game{board: %Board{table: table}, winning_length: winning_length} = game

    Enum.reduce(-(winning_length - 1)..(winning_length - 1), [], fn i, acc ->
      {x, y} = delta_fun.(x, y, i)

      [table |> Enum.at(y, []) |> Enum.at(x) | acc]
    end)
  end

  defp has_winning_sequence?(%Game{} = game, sequence) when is_list(sequence) do
    %Game{winning_length: winning_length} = game

    sequence
    |> Enum.chunk_by(& &1)
    |> Enum.filter(fn chunk -> !Enum.any?(chunk, &(&1 == nil)) end)
    |> Enum.any?(fn chunk -> length(chunk) >= winning_length end)
  end
end
