defmodule Connect4.Games.GameTest do
  use ExUnit.Case
  doctest Connect4.Games.Game

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
             Connect4.Games.Game.create(player, name, settings)
  end

  test "create with cols and rows settings negative value" do
    player = %{id: "Player 1", symbol: "X"}
    name = "Game 1"
    settings = %{board: %{cols: -42, rows: -42}}

    %{settings: %{board: %{cols: cols, rows: rows}}, status: :lobby} =
      Connect4.Games.Game.create(player, name, settings)

    assert cols == 7 and rows == 6
  end

  test "create with easter eggs" do
    player = %{id: "Player 1", symbol: "X"}
    name = "Game 1"
    settings = %{board: %{cols: 42, rows: 42}}

    %{settings: %{board: %{cols: cols, rows: rows}}, status: :lobby} =
      Connect4.Games.Game.create(player, name, settings)

    assert cols > 0 and cols <= 20 and rows > 0 and rows <= 20
  end

  test "join" do
    game = %{players: [%{id: "Player 1", symbol: "X"}]}
    player = %{id: "Player 2", symbol: "O"}

    expected_players = [
      %{id: "Player 1", symbol: "X"},
      %{id: "Player 2", symbol: "O"}
    ]

    assert %{players: ^expected_players} = Connect4.Games.Game.join(game, player)
  end

  test "join with player already in the game" do
    game = %{players: [%{id: "Player 1", symbol: "X"}]}
    player = %{id: "Player 1", symbol: "X"}

    assert %{players: [%{id: "Player 1", symbol: "X"}]} = Connect4.Games.Game.join(game, player)
  end

  test "leave" do
    player_1 = %{id: "Player 1", symbol: "X"}
    player_2 = %{id: "Player 2", symbol: "O"}
    game = %{players: [player_1, player_2]}

    expected_players = [player_1]

    assert %{players: ^expected_players} = Connect4.Games.Game.leave(game, player_2.id)
  end

  test "start" do
    assert %{status: :playing} = Connect4.Games.Game.start(%{status: :lobby})
  end

  test "start with wrong status" do
    assert_raise FunctionClauseError, fn -> Connect4.Games.Game.start(%{status: nil}) end
  end

  test "lobby" do
    assert %{status: :lobby} = Connect4.Games.Game.lobby(%{status: :game_over})
  end

  test "lobby with wrong status" do
    assert_raise FunctionClauseError, fn -> Connect4.Games.Game.lobby(%{status: nil}) end
  end

  test "move" do
    player_1 = %{id: "Player 1", symbol: "X"}
    player_2 = %{id: "Player 2", symbol: "O"}

    game = %{
      board: [[nil, nil, nil], [nil, nil, nil], [nil, nil, nil]],
      players: [player_1, player_2],
      settings: %{board: %{cols: 3, rows: 3}, winning_length: 3}
    }

    col_index = 1

    expected_board = [
      [nil, "X", nil],
      [nil, nil, nil],
      [nil, nil, nil]
    ]

    assert %{board: ^expected_board} = Connect4.Games.Game.move(game, player_1.id, col_index)
  end

  test "move with wrong column index" do
    game = %{
      board: [[nil, nil, nil], [nil, nil, nil], [nil, nil, nil]],
      settings: %{board: %{cols: 3, rows: 3}}
    }

    player = %{id: "Player 1", symbol: "X"}
    col_index = 3

    assert_raise FunctionClauseError, fn ->
      Connect4.Games.Game.move(game, player.id, col_index)
    end
  end

  test "move with wrong player" do
    player_1 = %{id: "Player 1", symbol: "X"}
    player_2 = %{id: "Player 2", symbol: "O"}

    game = %{
      board: [[nil, nil, nil], [nil, nil, nil], [nil, nil, nil]],
      players: [player_1, player_2],
      settings: %{board: %{cols: 3, rows: 3}}
    }

    col_index = 1

    assert_raise FunctionClauseError, fn ->
      Connect4.Games.Game.move(game, player_2.id, col_index)
    end
  end
end
