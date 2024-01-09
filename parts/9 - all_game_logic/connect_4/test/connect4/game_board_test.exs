defmodule Connect4.GameBoardTest do
  use ExUnit.Case
  doctest Connect4.GameBoard

  test "board_generate" do
    expected_board = [
      [nil, nil, nil, nil, nil, nil],
      [nil, nil, nil, nil, nil, nil],
      [nil, nil, nil, nil, nil, nil],
      [nil, nil, nil, nil, nil, nil],
      [nil, nil, nil, nil, nil, nil]
    ]

    assert {expected_board, 6, 5} ==
             Connect4.GameBoard.board_generate(6, 5)
  end
end
