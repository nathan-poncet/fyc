defmodule Connect4.Games do
  @moduledoc """
  This module contains the games logic.
  """
  alias Connect4.Games.Info
  alias Connect4.Games.Server

  @doc """
  This function is used to join a game.
  """
  defdelegate game_join(pid, player), to: Server

  @doc """
  This function is used to leave a game.
  """
  defdelegate game_leave(pid, player_id), to: Server

  @doc """
  This function is used to get the lobby.
  """
  defdelegate game_lobby(pid), to: Server

  @doc """
  This function is used to make a move.
  """
  defdelegate game_move(pid, player_id, col), to: Server

  @doc """
  This function is used to start a new game.
  """
  defdelegate game_start(pid), to: Server

  @doc """
  This function is used to get the game state.
  """
  defdelegate game(pid), to: Server

  @doc """
  This function is used to get a funfact.
  """
  defdelegate get_random_funfacts_async(method, number), to: Info
end
