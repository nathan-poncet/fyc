defmodule Connect4.Games.Game do
  alias Connect4.Games.Board

  @moduledoc """
  This module contains the game logic.
  """

  @doc """
  Creates a game with the given player, name and settings.

  ## Examples

  iex> Connect4.Games.Game.create(%{id: "Player 1", symbol: "X"}, "Game 1", %{board: %{cols: 7, rows: 6}})
  %{
    board:
      [
        [nil, nil, nil, nil, nil, nil, nil],
        [nil, nil, nil, nil, nil, nil, nil],
        [nil, nil, nil, nil, nil, nil, nil],
        [nil, nil, nil, nil, nil, nil, nil],
        [nil, nil, nil, nil, nil, nil, nil],
        [nil, nil, nil, nil, nil, nil, nil]
      ],
    name: "Game 1",
    players: [%{id: "Player 1", symbol: "X"}],
    settings: %{board: %{cols: 7, rows: 6}},
    status: :lobby
  }
  """
  def create(player, name, settings) do
    %{board: %{cols: cols, rows: rows}} = settings

    {board, cols, rows} = Board.generate(cols, rows)

    %{
      name: name,
      board: board,
      players: [player],
      settings: %{settings | board: %{settings.board | cols: cols, rows: rows}},
      status: :lobby
    }
  end

  @doc """
  Joins a player to the game.

  ## Examples

  iex> Connect4.Games.Game.join(%{players: [%{id: "Player 1", symbol: "X"}]}, %{id: "Player 2", symbol: "O"})
  %{
    players: [
      %{id: "Player 1", symbol: "X"},
      %{id: "Player 2", symbol: "O"}
    ]
  }
  """
  def join(game, player) do
    id_available = Enum.all?(game.players, fn p -> p.id != player.id end)
    symbol_available = Enum.all?(game.players, fn p -> p.symbol != player.symbol end)

    case {id_available, symbol_available} do
      {false, _} ->
        game

      {_, false} ->
        game

      {true, true} ->
        %{game | players: game.players ++ [player]}
    end
  end

  @doc """
  Leaves the game.

  ## Examples

  iex> Connect4.Games.Game.leave(%{players: [%{id: "Player 1", symbol: "X"}, %{id: "Player 2", symbol: "O"}]}, "Player 1")
  %{players: [%{id: "Player 2", symbol: "O"}]}
  """
  def leave(game, player_id) do
    %{players: players} = game

    players = Enum.filter(players, fn p -> p.id != player_id end)

    %{game | players: players}
  end

  @doc """
  Starts the game.

  ## Examples

  iex> Connect4.Games.Game.start(%{status: :lobby})
  %{status: :playing}
  """
  def start(%{status: :lobby} = game) do
    %{game | status: :playing}
  end

  @doc """
  Go to lobby.

  ## Examples

  iex> Connect4.Games.Game.lobby(%{status: :game_over})
  %{status: :lobby}
  """
  def lobby(%{status: :game_over} = game) do
    %{game | status: :lobby}
  end

  @doc """
  Makes a move in the game.

  ## Examples

  iex> Connect4.Games.Game.move(%{
  ...>   board: [[nil, nil, nil], [nil, nil, nil], [nil, nil, nil]],
  ...>   settings: %{board: %{cols: 3, rows: 3}, winning_length: 3}
  ...> }, %{symbol: "X"}, 1)
  %{
    settings: %{
      board: %{rows: 3, cols: 3},
      winning_length: 3
    },
    board: [
      [nil, "X", nil],
      [nil, nil, nil],
      [nil, nil, nil]
    ]
  }
  """
  def move(game, player, col_index)
      when 0 <= col_index and col_index < game.settings.board.cols do
    board = game.board

    # Try to find the first empty cell in the column
    row_index = Board.find_row_index_from_col_index(board, col_index)

    board = Board.put_piece(board, %{x: col_index, y: row_index}, player.symbol)

    case {Board.win(board, game.settings, %{x: col_index, y: row_index}), Board.is_full?(board)} do
      {true, _} ->
        %{game | board: board, status: :game_over}

      {_, true} ->
        %{game | board: board, status: :game_over}

      _ ->
        %{game | board: board}
    end
  end
end
