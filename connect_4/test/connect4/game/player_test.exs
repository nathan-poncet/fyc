defmodule Connect4.Game.PlayerTest do
  use ExUnit.Case

  test "valid current player return right player" do
    game = %Connect4.Game{
      players: [
        %Connect4.Game.Player{username: "player1", status: :online, symbol: "X"},
        %Connect4.Game.Player{username: "player2", status: :online, symbol: "O"}
      ],
      current_player: 0
    }

    assert {:ok, %Connect4.Game.Player{username: "player1", status: :online, symbol: "X"}} ==
             Connect4.Game.Player.get_current_player(game)
  end

  test "invalid current player return nil" do
    game = %Connect4.Game{
      players: [
        %Connect4.Game.Player{username: "player1", status: :online, symbol: "X"},
        %Connect4.Game.Player{username: "player2", status: :online, symbol: "O"}
      ],
      current_player: 2
    }

    assert {:error, :player_not_found} == Connect4.Game.Player.get_current_player(game)
  end
end
