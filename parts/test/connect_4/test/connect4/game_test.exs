defmodule Connect4.GameTest do
  use ExUnit.Case

  test "lobby" do
    assert %{status: :lobby} = Connect4.Game.lobby(%{status: nil})
  end

  test "start" do
    assert %{status: :playing} = Connect4.Game.start(%{status: nil})
  end

  test "stop" do
    assert %{status: :game_over} = Connect4.Game.stop(%{status: nil})
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
