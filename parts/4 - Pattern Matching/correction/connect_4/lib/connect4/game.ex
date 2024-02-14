defmodule Connect4.Game do
  def create() do
    %{status: :lobby}
  end

  def start(%{status: :lobby} = game) do
    IO.puts("Let's play! Connect 4!")
    %{game | status: :playing}
  end

  def lobby(%{status: :game_over} = game) do
    IO.puts("Go to lobby!")
    %{game | status: :lobby}
  end
end
