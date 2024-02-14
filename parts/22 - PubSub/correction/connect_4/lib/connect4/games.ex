defmodule Connect4.Games do
  @moduledoc """
  This module contains the games logic.
  """
  alias Connect4.Games.Supervisor
  alias Connect4.Games.Info
  alias Connect4.Games.Server

  @doc """
  Creates a new game.
  """
  defdelegate game_create(player, name, settings), to: Supervisor

  @doc """
  This function is used to join a game.
  """
  defdelegate game_join(code, player), to: Server

  @doc """
  This function is used to leave a game.
  """
  defdelegate game_leave(code, player_id), to: Server

  @doc """
  This function is used to get the lobby.
  """
  defdelegate game_lobby(code), to: Server

  @doc """
  This function is used to make a move.
  """
  defdelegate game_move(code, player_id, col), to: Server

  @doc """
  This function is used to start a new game.
  """
  defdelegate game_start(code), to: Server

  @doc """
  This function is used to get the game state.
  """
  defdelegate game(code), to: Server

  @doc """
  This function is used to get a funfact.
  """
  defdelegate get_random_funfacts_async(method, number), to: Info
end
