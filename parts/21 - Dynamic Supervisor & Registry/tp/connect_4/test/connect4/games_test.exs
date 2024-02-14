defmodule Connect4.GamesTest do
  alias Connect4.Games
  alias Connect4.Games.Player
  use ExUnit.Case

  setup_all %{} do
    {:ok, _} = Games.Supervisor.start_link([])
    {:ok, %{}}
  end

  test "game_create" do
    assert {:ok, _code} =
             Games.game_create(
               %Player{id: "Player 1", symbol: "X"},
               "ABCD",
               %{board: %{cols: 7, rows: 6}}
             )
  end

  test "game_join" do
    {:ok, code} =
      Games.game_create(%Player{id: "Player 1", symbol: "X"}, "ABCD", %{
        board: %{cols: 7, rows: 6}
      })

    assert {:ok, _} = Games.game_join(code, %Player{id: "Player 2", symbol: "O"})
  end
end
