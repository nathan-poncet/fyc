defmodule Connect4.GameTest do
  use ExUnit.Case
  doctest Connect4.Game

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

  test "create with cols and rows settings negative value" do
    player = %{name: "Player 1", symbol: "X"}
    name = "Game 1"
    settings = %{board: %{cols: -42, rows: -42}}

    %{board: board, settings: %{board: %{cols: cols, rows: rows}}, status: :lobby} =
      Connect4.Game.create(player, name, settings)

    assert cols == 7 and rows == 6
  end

  test "create with easter eggs" do
    player = %{name: "Player 1", symbol: "X"}
    name = "Game 1"
    settings = %{board: %{cols: 42, rows: 42}}

    %{board: board, settings: %{board: %{cols: cols, rows: rows}}, status: :lobby} =
      Connect4.Game.create(player, name, settings)

    assert cols > 0 and cols <= 20 and rows > 0 and rows <= 20
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
    game = %{
      board: [[nil, nil, nil], [nil, nil, nil], [nil, nil, nil]],
      settings: %{board: %{cols: 3, rows: 3}, winning_length: 3}
    }

    player = %{symbol: "X"}
    col_index = 1

    expected_board = [
      [nil, "X", nil],
      [nil, nil, nil],
      [nil, nil, nil]
    ]

    assert %{board: ^expected_board} = Connect4.Game.move(game, player, col_index)
  end

  test "move with wrong column index" do
    game = %{
      board: [[nil, nil, nil], [nil, nil, nil], [nil, nil, nil]],
      settings: %{board: %{cols: 3, rows: 3}}
    }

    player = %{symbol: "X"}
    col_index = 3

    assert_raise FunctionClauseError, fn -> Connect4.Game.move(game, player, col_index) end
  end
end
