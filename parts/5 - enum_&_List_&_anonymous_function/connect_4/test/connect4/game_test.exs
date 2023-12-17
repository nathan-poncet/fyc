defmodule Connect4.GameTest do
  use ExUnit.Case

  test "create" do
    player = %{name: "Player 1", symbol: "X"}
    name = "Game 1"
    settings = %{board: %{cols: 7, rows: 6}}

    expected_board = [
      [nil, nil, nil, nil, nil, nil, nil],
      [nil, nil, nil, nil, nil, nil, nil],
      [nil, nil, nil, nil, nil, nil, nil],
      [nil, nil, nil, nil, nil, nil, nil],
      [nil, nil, nil, nil, nil, nil, nil],
      [nil, nil, nil, nil, nil, nil, nil]
    ]

    assert %{board: ^expected_board, status: :lobby} =
             Connect4.Game.create(player, name, settings)
  end

  test "start" do
    assert %{status: :playing} = Connect4.Game.start(%{status: :lobby})
  end

  test "start with wrong status" do
    assert_raise FunctionClauseError, fn -> Connect4.Game.start(%{status: nil}) end
  end

  test "stop" do
    assert %{status: :game_over} = Connect4.Game.stop(%{status: :playing})
  end

  test "stop with wrong status" do
    assert_raise FunctionClauseError, fn -> Connect4.Game.stop(%{status: nil}) end
  end

  test "move" do
    game = %{board: [[nil, nil, nil], [nil, nil, nil], [nil, nil, nil]]}
    player = %{symbol: "X"}
    col_index = 0

    expected_board = [
      ["X", nil, nil],
      [nil, nil, nil],
      [nil, nil, nil]
    ]

    assert %{board: ^expected_board} = Connect4.Game.move(game, player, col_index)
  end
end
