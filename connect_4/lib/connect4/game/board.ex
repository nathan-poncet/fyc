defmodule Connect4.Game.Board do
  alias Connect4.Game.Board

  defstruct table: [], rows: 0, cols: 0

  def find_col_index(%Board{cols: cols}, column) do
    if column in 1..cols, do: {:ok, column - 1}, else: {:error, :invalid_column}
  end

  def find_row_index(%Board{table: table, cols: cols}, column) when column in 0..(cols - 1) do
    case Enum.find_index(table, &(Enum.at(&1, column) == nil)) do
      nil -> {:error, :row_full}
      row_index -> {:ok, row_index}
    end
  end

  def find_row_index(%Board{}, _) do
    {:error, :invalid_row}
  end

  def display(%Board{table: table}) do
    table
    |> Enum.map(&Enum.map(&1, fn cell -> if cell == nil, do: " ", else: cell end))
    |> Enum.reverse()
    |> inspect()
    |> String.replace("[[", " [")
    |> String.replace("]]", "]")
    |> String.replace("],", "]\n")
  end

  def clear(%Board{table: table}) do
    Enum.map(table, &Enum.map(&1, fn _ -> nil end))
  end
end
