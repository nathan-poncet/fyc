defmodule Game.InitializerTest do
  alias Connect4.Game.Initializer.Args
  alias Connect4.Game
  alias Connect4.Game.Player
  alias Connect4.Game.Initializer
  alias Connect4.Game.Board
  use ExUnit.Case

  test "init function return a tuple with a game state" do
    players = [
      %Player{username: "player1", status: :online, symbol: "X"},
      %Player{username: "player2", status: :online, symbol: "O"}
    ]

    {:ok, %Game{}} =
      Initializer.init(%Args{players: players, board: %Board{rows: 6, cols: 7}})
  end

  test "init function generate a board with right dimention" do
    players = [
      %Player{username: "player1", status: :online, symbol: "X"},
      %Player{username: "player2", status: :online, symbol: "O"}
    ]

    {:ok, game} =
      Initializer.init(%Args{players: players, board: %Board{rows: 6, cols: 7}})

    expexted_board = %Board{
      rows: 6,
      cols: 7,
      table: [
        [nil, nil, nil, nil, nil, nil, nil],
        [nil, nil, nil, nil, nil, nil, nil],
        [nil, nil, nil, nil, nil, nil, nil],
        [nil, nil, nil, nil, nil, nil, nil],
        [nil, nil, nil, nil, nil, nil, nil],
        [nil, nil, nil, nil, nil, nil, nil]
      ]
    }

    assert game.board == expexted_board
  end

  test "init function return an error if no players" do
    {:error, :no_players} =
      Initializer.init(%Args{players: []})
  end

  test "init function return an error if winning length is invalid" do
    players = [
      %Player{username: "player1", status: :online, symbol: "X"},
      %Player{username: "player2", status: :online, symbol: "O"}
    ]

    assert {:error, :invalid_winning_length} ==
             Initializer.init(%Args{players: players, winning_length: 0})
  end

  test "init function return an error if board size is invalid" do
    players = [
      %Player{username: "player1", status: :online, symbol: "X"},
      %Player{username: "player2", status: :online, symbol: "O"}
    ]

    assert {:error, :invalid_board_size} ==
             Initializer.init(%Args{players: players, board: %Board{rows: 0, cols: 0}})
  end

  test "init function return an error if board size could't container winning length" do
    players = [
      %Player{username: "player1", status: :online, symbol: "X"},
      %Player{username: "player2", status: :online, symbol: "O"}
    ]

    assert {:error, :invalid_board_size_for_winning_length} ==
             Initializer.init(%Args{
               board: %Board{rows: 3, cols: 3},
               players: players,
               winning_length: 4
             })
  end
end
