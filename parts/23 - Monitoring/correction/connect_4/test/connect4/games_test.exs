defmodule Connect4.GamesTest do
  alias Connect4.Games
  alias Connect4.Games.Player
  use ExUnit.Case

  setup_all %{} do
    {:ok, _} = Games.Supervisor.start_link([])
    {:ok, _} = Connect4.Utils.PubSub.start_link([])
    {:ok, %{}}
  end

  test "game_create" do
    player_1_pid = spawn(fn -> :timer.sleep(1000) end)

    assert {:ok, _code} =
             Games.game_create(
               %Player{id: player_1_pid, symbol: "X"},
               "ABCD",
               %{board: %{cols: 7, rows: 6}}
             )
  end

  test "game_join" do
    player_1_pid = spawn(fn -> :timer.sleep(1000) end)
    player_2_pid = spawn(fn -> :timer.sleep(1000) end)

    {:ok, code} =
      Games.game_create(%Player{id: player_1_pid, symbol: "X"}, "ABCD", %{
        board: %{cols: 7, rows: 6}
      })

    assert {:ok, _} = Games.game_join(code, %Player{id: player_2_pid, symbol: "O"})
  end
end
