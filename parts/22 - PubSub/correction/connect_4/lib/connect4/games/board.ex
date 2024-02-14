defmodule Connect4.Games.Board do
  @moduledoc """
  This module contains the game board logic.
  """

  @doc """
  Generates a board with the given number of columns and rows.

  ## Examples

  iex> Connect4.Games.Board.generate(3, 2)
  {[
    [nil, nil, nil],
    [nil, nil, nil]
  ], 3, 2}
  """
  def generate(42, 42) do
    random_cols = Enum.random(1..20)
    random_rows = Enum.random(1..20)

    {Enum.map(1..random_rows, fn _ -> Enum.map(1..random_cols, fn _ -> nil end) end), random_cols,
     random_rows}
  end

  def generate(cols, rows) when cols > 0 and rows > 0,
    do: {Enum.map(1..rows, fn _ -> Enum.map(1..cols, fn _ -> nil end) end), cols, rows}

  def generate(_, _),
    do: {Enum.map(1..6, fn _ -> Enum.map(1..7, fn _ -> nil end) end), 7, 6}

  @doc """
  Finds the first empty cell in the given column.

  ## Examples

  iex> Connect4.Games.Board.find_row_index_from_col_index([
  ...>   [nil, "X", nil],
  ...>   [nil, "X", nil],
  ...>   [nil, nil, nil]
  ...> ], 1)
  2
  """
  def find_row_index_from_col_index(board, col_index),
    do: Enum.find_index(board, fn row -> Enum.at(row, col_index) == nil end)

  @doc """
  Puts a piece in the given position.

  ## Examples

  iex> Connect4.Games.Board.put_piece([
  ...>   [nil, nil, nil],
  ...>   [nil, nil, nil],
  ...>   [nil, nil, nil]
  ...> ], %{x: 1, y: 1}, "X")
  [
    [nil, nil, nil],
    [nil, "X", nil],
    [nil, nil, nil]
  ]
  """
  def put_piece(board, %{x: col_index, y: row_index}, piece) do
    List.update_at(board, row_index, fn row ->
      List.update_at(row, col_index, fn _ -> piece end)
    end)
  end

  @doc """
  Transforms the given board into a string.
  """
  def to_string(board) do
    board
    |> Enum.map(fn row -> row |> Enum.map(fn cell -> cell || " " end) |> Enum.join(" | ") end)
    |> Enum.reverse()
    |> Enum.join("\n")
  end

  @doc """
  Checks if the given board has a winning sequence.

  ## Examples

  iex> Connect4.Games.Board.win([
  ...>   ["X", "X", "X", "X", nil],
  ...>   [nil, nil, nil, nil, nil]
  ...> ], %{board: %{cols: 6, rows: 5}, winning_length: 4}, %{x: 0, y: 0})
  true
  """
  def win(board, settings, pos) do
    win_horizontal?(board, settings, pos) or
      win_vertical?(board, settings, pos) or
      win_diagonal?(board, settings, pos)
  end

  @doc """
  Checks if the given board is full.

  ## Examples

  iex> Connect4.Games.Board.is_full?([
  ...>   ["X", "X", "X"],
  ...>   ["X", "X", "X"]
  ...> ])
  true
  """
  def is_full?(board) do
    Enum.all?(board, fn row -> Enum.all?(row, fn cell -> cell != nil end) end)
  end

  defp win_horizontal?(board, settings, pos) do
    %{board: %{cols: cols}, winning_length: winning_length} = settings
    %{x: x, y: y} = pos

    start = max(x - (winning_length - 1), 0)
    range = min(x + (winning_length - 1) * 2, cols - 1)

    board
    |> Enum.at(y)
    |> Enum.slice(start, range)
    |> has_winning_sequence?(winning_length)
  end

  defp win_vertical?(board, settings, pos) do
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

  defp win_diagonal?(board, settings, pos) do
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

  defp extract_diagonals(board, settings, pos) do
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
end
