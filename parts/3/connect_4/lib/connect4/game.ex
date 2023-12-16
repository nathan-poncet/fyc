defmodule Connect4.Game do
  def create(player, name, settings) do
    %{board: %{cols: cols, rows: rows}} = settings

    {board, cols, rows} = board_generate(cols, rows)

    %{
      name: name,
      board: board,
      players: [player],
      settings: %{settings | board: %{settings.board | cols: cols, rows: rows}},
      status: :lobby
    }
  end

  def start(%{status: :lobby} = game) do
    IO.puts("Let's play! Connect 4!")
    %{game | status: :playing}
  end

  def stop(%{status: :playing} = game) do
    IO.puts("Thanks for playing!")
    %{game | status: :game_over}
  end

  ###  First method ###

  #  defp board_generate(cols, rows) do
  #    if cols == 42 and rows == 42 do
  #      IO.puts("""
  #      Life, the Universe and Everything
  #      You discovered the easter egg!
  #      """)
  #
  #      random_cols = Enum.random(1..20)
  #      random_rows = Enum.random(1..20)
  #  
  #      Enum.map(1..random_rows, fn _ -> Enum.map(1..random_cols, fn _ -> nil end) end)
  #    else
  #      Enum.map(1..rows, fn _ -> Enum.map(1..cols, fn _ -> nil end) end)
  #    end
  #  end

  ### Second method ###

  defp board_generate(42, 42) do
    IO.puts("""
    Life, the Universe and Everything
    You discovered the easter egg!
    """)

    random_cols = Enum.random(1..20)
    random_rows = Enum.random(1..20)

    {Enum.map(1..random_rows, fn _ -> Enum.map(1..random_cols, fn _ -> nil end) end), random_cols,
     random_rows}
  end

  defp board_generate(cols, rows),
    do: {Enum.map(1..rows, fn _ -> Enum.map(1..cols, fn _ -> nil end) end), cols, rows}
end
