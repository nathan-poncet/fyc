defmodule Connect4.Games.ServerTest do
  use ExUnit.Case, async: true

  alias Connect4.Games.Game
  alias Connect4.Games.Player
  alias Connect4.Games.Server

  @moduletag timeout: 4000

  setup %{} do
    player_1 = %Player{id: "Player 1", symbol: "X"}
    player_2 = %Player{id: "Player 2", symbol: "O"}
    name = "Game 1"
    settings = %{board: %{cols: 7, rows: 6}}

    {:ok, %{player_1: player_1, player_2: player_2, name: name, settings: settings}}
  end

  test "start_link", %{player_1: player_1, name: name, settings: settings} do
    {:ok, pid} = Server.start_link(player: player_1, name: name, settings: settings)

    assert is_pid(pid)
  end

  test "game_start", %{player_1: player_1, name: name, settings: settings} do
    {:ok, pid} = Server.start_link(player: player_1, name: name, settings: settings)
    assert is_pid(pid)

    {:ok, game} = Server.game_start(pid)
    assert %Game{} = game
  end

  test "game_join", %{player_1: player_1, player_2: player_2, name: name, settings: settings} do
    {:ok, pid} = Server.start_link(player: player_1, name: name, settings: settings)
    assert is_pid(pid)

    assert {:ok, %Game{}} = Server.game_join(pid, player_2)
  end

  test "game_join with already player inside", %{
    player_1: player_1,
    name: name,
    settings: settings
  } do
    {:ok, pid} = Server.start_link(player: player_1, name: name, settings: settings)
    assert is_pid(pid)

    assert {:error, :id_already_taken} = Server.game_join(pid, player_1)
  end

  test "game_leave", %{player_1: player_1, name: name, settings: settings} do
    {:ok, pid} = Server.start_link(player: player_1, name: name, settings: settings)
    assert is_pid(pid)

    assert {:ok, %Game{}} = Server.game_leave(pid, player_1)
  end

  test "game_move", %{player_1: player_1, name: name, settings: settings} do
    {:ok, pid} = Server.start_link(player: player_1, name: name, settings: settings)
    assert is_pid(pid)

    assert {:ok, %Game{}} = Server.game_start(pid)

    assert {:ok, %Game{}} = Server.game_move(pid, player_1.id, 1)
  end

  test "game_move with invalid column", %{player_1: player_1, name: name, settings: settings} do
    {:ok, pid} = Server.start_link(player: player_1, name: name, settings: settings)
    assert is_pid(pid)

    assert {:ok, %Game{}} = Server.game_start(pid)

    assert {:error, :invalid_column} = Server.game_move(pid, player_1.id, -1)
  end

  test "game_move with invalid player", %{player_1: player_1, name: name, settings: settings} do
    {:ok, pid} = Server.start_link(player: player_1, name: name, settings: settings)
    assert is_pid(pid)

    assert {:ok, %Game{}} = Server.game_start(pid)

    assert {:error, :not_your_turn} = Server.game_move(pid, "Player 2", 1)
  end

  test "game_move with invalid status", %{player_1: player_1, name: name, settings: settings} do
    {:ok, pid} = Server.start_link(player: player_1, name: name, settings: settings)
    assert is_pid(pid)

    assert {:error, :wrong_status} = Server.game_move(pid, player_1.id, 1)
  end
end
