defmodule Connect4.Games.BoardTest do
  use ExUnit.Case
  doctest Connect4.Games.Board

  test "generate" do
    expected_board = [
      [nil, nil, nil, nil, nil, nil],
      [nil, nil, nil, nil, nil, nil],
      [nil, nil, nil, nil, nil, nil],
      [nil, nil, nil, nil, nil, nil],
      [nil, nil, nil, nil, nil, nil]
    ]

    assert {expected_board, 6, 5} == Connect4.Games.Board.generate(6, 5)
  end
end
