defmodule Connect4.Games.Game do
  alias Connect4.Games.Player
  alias Connect4.Games.Game
  alias Connect4.Games.Board

  @moduledoc """
  This module contains the game logic.
  """

  defstruct name: "",
            board: [],
            players: [],
            settings: %{},
            status: :lobby

  @doc """
  Creates a game with the given player, name and settings.

  ## Examples

  iex> Connect4.Games.Game.create(%Connect4.Games.Player{id: "Player 1", symbol: "X"}, "Game 1", %{board: %{cols: 7, rows: 6}})
  %Connect4.Games.Game{
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
    players: [%Connect4.Games.Player{id: "Player 1", symbol: "X"}],
    settings: %{board: %{cols: 7, rows: 6}},
    status: :lobby
  }
  """
  def create(%Player{} = player, name, settings) do
    %{board: %{cols: cols, rows: rows}} = settings

    {board, cols, rows} = Board.generate(cols, rows)

    %Game{
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
  {:ok, %{
    players: [
      %{id: "Player 1", symbol: "X"},
      %{id: "Player 2", symbol: "O"}
    ]
  }}
  """
  def join(game, player) do
    id_available = Enum.all?(game.players, fn p -> p.id != player.id end)
    symbol_available = Enum.all?(game.players, fn p -> p.symbol != player.symbol end)

    case {id_available, symbol_available} do
      {false, _} ->
        {:error, :id_already_taken}

      {_, false} ->
        {:error, :symbol_already_taken}

      {true, true} ->
        {:ok, %{game | players: game.players ++ [player]}}
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

  iex> Connect4.Games.Game.start(%Connect4.Games.Game{status: :lobby})
  {:ok, %Connect4.Games.Game{status: :playing}}
  """
  def start(%Game{status: :lobby} = game) do
    {:ok, %Game{game | status: :playing}}
  end

  def start(%Game{}) do
    {:error, :wrong_status}
  end

  @doc """
  Go to lobby.

  ## Examples

  iex> Connect4.Games.Game.lobby(%Connect4.Games.Game{status: :game_over})
  {:ok, %Connect4.Games.Game{status: :lobby}}
  """
  def lobby(%Game{status: :game_over} = game) do
    {:ok, %Game{game | status: :lobby}}
  end

  def lobby(%Game{}) do
    {:error, :wrong_status}
  end

  @doc """
  Makes a move in the game.

  ## Examples

  iex> Connect4.Games.Game.move(%Connect4.Games.Game{
  ...>   board: [[nil, nil, nil], [nil, nil, nil], [nil, nil, nil]],
  ...>   players: [%Connect4.Games.Player{id: "Player 1", symbol: "X"}, %Connect4.Games.Player{id: "Player 2", symbol: "O"}],
  ...>   settings: %{board: %{cols: 3, rows: 3}, winning_length: 3},
  ...>   status: :playing
  ...> }, "Player 1", 1)
  {:ok, %Connect4.Games.Game{
    board: [[nil, "X", nil], [nil, nil, nil], [nil, nil, nil]],
    players: [%Connect4.Games.Player{id: "Player 2", symbol: "O"}, %Connect4.Games.Player{id: "Player 1", symbol: "X"}],
    settings: %{
      board: %{rows: 3, cols: 3},
      winning_length: 3
    },
    status: :playing
  }}
  """
  def move(
        %Game{players: [%Player{id: current_player_id} | _], status: :playing} = game,
        player_id,
        col_index
      )
      when is_integer(col_index) and current_player_id == player_id and 0 <= col_index and
             col_index < game.settings.board.cols do
    %Game{board: board} = game

    row_index = Board.find_row_index_from_col_index(board, col_index)

    move(game, %{x: col_index, y: row_index})
  end

  def move(%Game{status: status}, _player_id, _col_index)
      when status != :playing,
      do: {:error, :wrong_status}

  def move(%Game{players: []}, _player_id, _col_index), do: {:error, :no_players}

  def move(%Game{players: [%Player{id: current_player_id} | _]}, player_id, _col_index)
      when current_player_id != player_id,
      do: {:error, :not_your_turn}

  def move(%Game{settings: %{board: %{cols: cols}}}, _player, col_index)
      when col_index < 0 or cols <= col_index,
      do: {:error, :invalid_column}

  def move(%Game{} = game, %{x: _, y: row_index} = pos) when is_integer(row_index) do
    %{board: board, players: [%{symbol: symbol} | _]} = game

    game =
      %Game{game | board: Board.put_piece(board, pos, symbol)}
      |> update_status(pos)
      |> next_player()

    {:ok, game}
  end

  def move(_game, %{x: _, y: nil}), do: {:error, :column_full}

  defp update_status(%Game{} = game, pos) do
    %Game{board: board, settings: settings} = game

    case {Board.win(board, settings, pos), Board.is_full?(board)} do
      {true, _} ->
        %Game{game | board: board, status: :game_over}

      {_, true} ->
        %Game{game | board: board, status: :game_over}

      _ ->
        %Game{game | board: board}
    end
  end

  defp next_player(%Game{status: :playing} = game) do
    %{players: [first_player | other_players]} = game

    %Game{game | players: other_players ++ [first_player]}
  end

  defp next_player(%Game{} = game), do: game
end
