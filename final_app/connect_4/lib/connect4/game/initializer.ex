defmodule Connect4.Game.Initializer do
  alias Connect4.Game
  alias Connect4.Game.Board

  defmodule Args do
    @default_winning_length 4
    @default_board_rows 6
    @default_board_cols 7

    defstruct name: "",
              players: [],
              board: %Board{rows: @default_board_rows, cols: @default_board_cols},
              winning_length: @default_winning_length
  end

  def init(%Args{players: []}) do
    {:error, :no_players}
  end

  def init(%Args{winning_length: winning_length})
      when winning_length <= 0 do
    {:error, :invalid_winning_length}
  end

  def init(%Args{board: %Board{rows: rows, cols: cols}})
      when rows <= 0 or cols <= 0 do
    {:error, :invalid_board_size}
  end

  def init(%Args{board: %Board{rows: rows, cols: cols}, winning_length: winning_length})
      when rows < winning_length or cols < winning_length do
    {:error, :invalid_board_size_for_winning_length}
  end

  def init(
        %Args{
          name: name,
          players: players,
          board: %Board{rows: rows, cols: cols},
          winning_length: winning_length
        } =
          args
      )
      when is_bitstring(name) and is_list(players) and is_integer(rows) and is_integer(cols) and
             is_integer(winning_length) do
    %Args{board: board} = args

    board = %Board{
      board
      | table: Enum.map(1..rows, fn _ -> Enum.map(1..cols, fn _ -> nil end) end)
    }

    {:ok, %Game{name: name, board: board, players: players, winning_length: winning_length}}
  end
end
