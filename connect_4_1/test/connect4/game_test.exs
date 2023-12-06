defmodule Connect4.GameTest do
  alias Connect4.Game.Player
  alias Connect4.Game.Board
  alias Connect4.Game
  use ExUnit.Case
  use Patch, only: [:expose]

  describe "drop_piece/3" do
    test "drop piece add piece at right place" do
      expose(Game, drop_piece: 3)

      game = %Game{
        board: %Board{
          table: [
            [" ", " ", " ", " ", " ", " ", " "],
            [" ", " ", " ", " ", " ", " ", " "],
            [" ", " ", " ", " ", " ", " ", " "],
            [" ", " ", " ", " ", " ", " ", " "],
            [" ", " ", " ", " ", " ", " ", " "],
            [" ", " ", " ", " ", " ", " ", " "]
          ],
          rows: 6,
          cols: 7
        },
        players: [
          %Player{username: "player1", status: :online, symbol: "X"},
          %Player{username: "player2", status: :online, symbol: "O"}
        ],
        current_player: 0,
        status: :playing
      }

      %Game{board: %Board{table: table}} =
        private(Game.drop_piece(game, Enum.at(game.players, 0), %{x: 0, y: 0}))

      assert table == [
               ["X", " ", " ", " ", " ", " ", " "],
               [" ", " ", " ", " ", " ", " ", " "],
               [" ", " ", " ", " ", " ", " ", " "],
               [" ", " ", " ", " ", " ", " ", " "],
               [" ", " ", " ", " ", " ", " ", " "],
               [" ", " ", " ", " ", " ", " ", " "]
             ]
    end
  end

  describe "switch_current_player/1" do
    test "Switch current player go to next player if game status is :playing" do
      expose(Game, switch_current_player: 1)

      game = %Connect4.Game{
        players: [
          %Connect4.Game.Player{username: "player1", status: :online, symbol: "X"},
          %Connect4.Game.Player{username: "player2", status: :online, symbol: "O"}
        ],
        current_player: 0,
        status: :playing
      }

      %Game{current_player: current_player} = private(Game.switch_current_player(game))

      assert current_player == 1
    end

    test "Switch current player go back to 0 if game status is :playing and current player is the last" do
      expose(Game, switch_current_player: 1)

      game = %Connect4.Game{
        players: [
          %Connect4.Game.Player{username: "player1", status: :online, symbol: "X"},
          %Connect4.Game.Player{username: "player2", status: :online, symbol: "O"}
        ],
        current_player: 1,
        status: :playing
      }

      %Game{current_player: current_player} = private(Game.switch_current_player(game))

      assert current_player == 0
    end

    test "Switch current player does not change current player if game status is :game_over" do
      expose(Game, switch_current_player: 1)

      game = %Connect4.Game{
        players: [
          %Connect4.Game.Player{username: "player1", status: :online, symbol: "X"},
          %Connect4.Game.Player{username: "player2", status: :online, symbol: "O"}
        ],
        current_player: 1,
        status: :game_over
      }

      %Game{current_player: current_player} = private(Game.switch_current_player(game))

      assert current_player == 1
    end
  end
end
