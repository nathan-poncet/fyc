defmodule Connect4.GameTest do
  use ExUnit.Case

  test "create" do
    player = %{id: "Player 1", symbol: "X"}
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

  test "join" do
    game = %{players: [%{id: "Player 1", symbol: "X"}]}
    player = %{id: "Player 2", symbol: "O"}

    expected_players = [
      %{id: "Player 1", symbol: "X"},
      %{id: "Player 2", symbol: "O"}
    ]

    assert %{players: ^expected_players} = Connect4.Game.join(game, player)
  end

  test "leave" do
    player_1 = %{id: "Player 1", symbol: "X"}
    player_2 = %{id: "Player 2", symbol: "O"}
    game = %{players: [player_1, player_2]}

    expected_players = [player_1]

    assert %{players: ^expected_players} = Connect4.Game.leave(game, player_2.id)
  end

  test "start" do
    assert %{status: :playing} = Connect4.Game.start(%{status: :lobby})
  end

  test "start with wrong status" do
    assert_raise FunctionClauseError, fn -> Connect4.Game.start(%{status: nil}) end
  end

  test "lobby" do
    assert %{status: :lobby} = Connect4.Game.lobby(%{status: :game_over})
  end

  test "lobby with wrong status" do
    assert_raise FunctionClauseError, fn -> Connect4.Game.lobby(%{status: nil}) end
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
