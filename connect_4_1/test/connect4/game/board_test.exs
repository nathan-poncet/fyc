defmodule Connect4.Game.BoardTest do
  use ExUnit.Case
  alias Connect4.Game.Board

  test "find column" do
    board = %Board{cols: 7}

    for i <- 1..7 do
      assert {:ok, i - 1} == Board.find_col_index(board, i)
    end

    assert {:error, :invalid_column} == Board.find_col_index(board, 0)
    assert {:error, :invalid_column} == Board.find_col_index(board, 8)
  end

  test "find row" do
    board = %Board{
      cols: 3,
      rows: 3,
      table: [
        [nil, "X", "X"],
        [nil, nil, "X"],
        [nil, nil, nil]
      ]
    }

    assert {:ok, 0} == Board.find_row_index(board, 0)
    assert {:ok, 1} == Board.find_row_index(board, 1)
    assert {:ok, 2} == Board.find_row_index(board, 2)
    assert {:error, :invalid_row} == Board.find_row_index(board, -2)
    assert {:error, :invalid_row} == Board.find_row_index(board, -1)
    assert {:error, :invalid_row} == Board.find_row_index(board, 3)
    assert {:error, :invalid_row} == Board.find_row_index(board, 4)
  end
end
