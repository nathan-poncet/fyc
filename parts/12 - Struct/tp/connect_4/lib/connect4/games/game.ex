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

  iex> Connect4.Games.Game.start(%{status: :lobby})
  {:ok, %{status: :playing}}
  """
  def start(%{status: :lobby} = game) do
    {:ok, %{game | status: :playing}}
  end

  def start(%{}) do
    {:error, :wrong_status}
  end

  @doc """
  Go to lobby.

  ## Examples

  iex> Connect4.Games.Game.lobby(%{status: :game_over})
  {:ok, %{status: :lobby}}
  """
  def lobby(%{status: :game_over} = game) do
    {:ok, %{game | status: :lobby}}
  end

  def lobby(%{}) do
    {:error, :wrong_status}
  end

  @doc """
  Makes a move in the game.

  ## Examples

  iex> Connect4.Games.Game.move(%{
  ...>   board: [[nil, nil, nil], [nil, nil, nil], [nil, nil, nil]],
  ...>   players: [%{id: "Player 1", symbol: "X"}, %{id: "Player 2", symbol: "O"}],
  ...>   settings: %{board: %{cols: 3, rows: 3}, winning_length: 3},
  ...>   status: :playing
  ...> }, "Player 1", 1)
  {:ok, %{
    board: [[nil, "X", nil], [nil, nil, nil], [nil, nil, nil]],
    players: [%{id: "Player 2", symbol: "O"}, %{id: "Player 1", symbol: "X"}],
    settings: %{
      board: %{rows: 3, cols: 3},
      winning_length: 3
    },
    status: :playing
  }}
  """
  def move(
        %{players: [%{id: current_player_id} | _], status: :playing} = game,
        player_id,
        col_index
      )
      when is_integer(col_index) and current_player_id == player_id and 0 <= col_index and
             col_index < game.settings.board.cols do
    %{board: board} = game

    row_index = Board.find_row_index_from_col_index(board, col_index)

    move(game, %{x: col_index, y: row_index})
  end

  def move(%{status: status}, _player_id, _col_index)
      when status != :playing,
      do: {:error, :wrong_status}

  def move(%{players: []}, _player_id, _col_index), do: {:error, :no_players}

  def move(%{players: [%{id: current_player_id} | _]}, player_id, _col_index)
      when current_player_id != player_id,
      do: {:error, :not_your_turn}

  def move(%{settings: %{board: %{cols: cols}}}, _player, col_index)
      when col_index < 0 or cols <= col_index,
      do: {:error, :invalid_column}

  def move(game, %{x: _, y: row_index} = pos) when is_integer(row_index) do
    %{board: board, players: [%{symbol: symbol} | _]} = game

    game =
      %{game | board: Board.put_piece(board, pos, symbol)}
      |> update_status(pos)
      |> next_player()

    {:ok, game}
  end

  def move(_game, %{x: _, y: nil}), do: {:error, :column_full}

  defp update_status(game, pos) do
    %{board: board} = game

    case {Board.win(board, game.settings, pos), Board.is_full?(board)} do
      {true, _} ->
        %{game | board: board, status: :game_over}

      {_, true} ->
        %{game | board: board, status: :game_over}

      _ ->
        %{game | board: board}
    end
  end

  defp next_player(%{status: :playing} = game) do
    %{players: [first_player | other_players]} = game

    %{game | players: other_players ++ [first_player]}
  end

  defp next_player(game), do: game
end
