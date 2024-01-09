defmodule Connect4.Game do
  alias Connect4.GameBoard

  @moduledoc """
  This module contains the game logic.
  """

  @doc """
  Creates a game with the given player, name and settings.

  ## Examples

  iex> Connect4.Game.create(%{name: "Player 1", symbol: "X"}, "Game 1", %{board: %{cols: 7, rows: 6}})
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
    players: [%{name: "Player 1", symbol: "X"}],
    settings: %{board: %{cols: 7, rows: 6}},
    status: :lobby
  }
  """
  def create(player, name, settings) do
    %{board: %{cols: cols, rows: rows}} = settings

    {board, cols, rows} = GameBoard.board_generate(cols, rows)

    %{
      name: name,
      board: board,
      players: [player],
      settings: %{settings | board: %{settings.board | cols: cols, rows: rows}},
      status: :lobby
    }
  end

  @doc """
  Starts the game.

  ## Examples

  iex> Connect4.Game.start(%{status: :lobby})
  %{status: :playing}
  """
  def start(%{status: :lobby} = game) do
    IO.puts("Let's play! Connect 4!")
    %{game | status: :playing}
  end

  @doc """
  Stop the game.

  ## Examples

  iex> Connect4.Game.stop(%{status: :playing})
  %{status: :game_over}
  """
  def stop(%{status: :playing} = game) do
    IO.puts("Thanks for playing!")
    %{game | status: :game_over}
  end

  @doc """
  Makes a move in the game.

  ## Examples

  iex> Connect4.Game.move(%{
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
    IO.puts("Make your move!")

    board = game.board

    # Try to find the first empty cell in the column
    row_index = GameBoard.board_find_row_index_from_col_index(board, col_index)

    board = GameBoard.board_put_piece(board, row_index, col_index, player.symbol)

    case {GameBoard.board_win(board, game.settings, %{x: col_index, y: row_index}),
          GameBoard.board_is_full?(board)} do
      {true, _} ->
        IO.puts("You win!")
        %{game | board: board, status: :game_over}

      {_, true} ->
        IO.puts("It's a draw!")
        %{game | board: board, status: :game_over}

      _ ->
        %{game | board: board}
    end
  end
end
