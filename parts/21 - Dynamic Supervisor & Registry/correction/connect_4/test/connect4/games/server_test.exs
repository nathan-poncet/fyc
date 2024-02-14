defmodule Connect4.Games.ServerTest do
  use ExUnit.Case, async: true

  alias Connect4.Games.Game
  alias Connect4.Games.Player
  alias Connect4.Games.Server

  @moduletag timeout: 4000

  setup_all %{} do
    {:ok, _pid} = Registry.start_link(keys: :unique, name: Connect4.Games.Registry)
    {:ok, %{}}
  end

  setup %{} do
    player_1 = %Player{id: "Player 1", symbol: "X"}
    player_2 = %Player{id: "Player 2", symbol: "O"}
    name = "Game 1"
    settings = %{board: %{cols: 7, rows: 6}}

    {:ok, %{player_1: player_1, player_2: player_2, name: name, settings: settings}}
  end

  test "Registry is available and operational" do
    assert :undefined != Registry.lookup(Connect4.Games.Registry, :some_key)
  end

  test "start_link", %{player_1: player_1, name: name, settings: settings} do
    {:ok, pid} = Server.start_link(player: player_1, name: name, settings: settings)

    assert is_pid(pid)
  end

  test "game_start", %{player_1: player_1, name: name, settings: settings} do
    {:ok, pid} = Server.start_link(player: player_1, name: name, settings: settings)
    assert is_pid(pid)

    [code] = Registry.keys(Connect4.Games.Registry, pid)

    {:ok, game} = Server.game_start(code)
    assert %Game{} = game
  end

  test "game_join", %{player_1: player_1, player_2: player_2, name: name, settings: settings} do
    {:ok, pid} = Server.start_link(player: player_1, name: name, settings: settings)
    assert is_pid(pid)

    [code] = Registry.keys(Connect4.Games.Registry, pid)

    assert {:ok, %Game{}} = Server.game_join(code, player_2)
  end

  test "game_join with already player inside", %{
    player_1: player_1,
    name: name,
    settings: settings
  } do
    {:ok, pid} = Server.start_link(player: player_1, name: name, settings: settings)
    assert is_pid(pid)

    [code] = Registry.keys(Connect4.Games.Registry, pid)

    assert {:error, :id_already_taken} = Server.game_join(code, player_1)
  end

  test "game_leave", %{player_1: player_1, name: name, settings: settings} do
    {:ok, pid} = Server.start_link(player: player_1, name: name, settings: settings)
    assert is_pid(pid)

    [code] = Registry.keys(Connect4.Games.Registry, pid)

    assert {:ok, %Game{}} = Server.game_leave(code, player_1)
  end

  test "game_move", %{player_1: player_1, name: name, settings: settings} do
    {:ok, pid} = Server.start_link(player: player_1, name: name, settings: settings)
    assert is_pid(pid)

    [code] = Registry.keys(Connect4.Games.Registry, pid)

    assert {:ok, %Game{}} = Server.game_start(code)

    assert {:ok, %Game{}} = Server.game_move(code, player_1.id, 1)
  end

  test "game_move with invalid column", %{player_1: player_1, name: name, settings: settings} do
    {:ok, pid} = Server.start_link(player: player_1, name: name, settings: settings)
    assert is_pid(pid)

    [code] = Registry.keys(Connect4.Games.Registry, pid)

    assert {:ok, %Game{}} = Server.game_start(code)

    assert {:error, :invalid_column} = Server.game_move(code, player_1.id, -1)
  end

  test "game_move with invalid player", %{player_1: player_1, name: name, settings: settings} do
    {:ok, pid} = Server.start_link(player: player_1, name: name, settings: settings)
    assert is_pid(pid)

    [code] = Registry.keys(Connect4.Games.Registry, pid)

    assert {:ok, %Game{}} = Server.game_start(code)

    assert {:error, :not_your_turn} = Server.game_move(code, "Player 2", 1)
  end

  test "game_move with invalid status", %{player_1: player_1, name: name, settings: settings} do
    {:ok, pid} = Server.start_link(player: player_1, name: name, settings: settings)
    assert is_pid(pid)

    [code] = Registry.keys(Connect4.Games.Registry, pid)

    assert {:error, :wrong_status} = Server.game_move(code, player_1.id, 1)
  end
end
