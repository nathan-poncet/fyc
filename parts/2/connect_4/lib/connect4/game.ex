defmodule Connect4.Game do
  def create() do
    %{status: :lobby}
  end

  def start(%{status: :lobby} = game) do
    IO.puts("Let's play! Connect 4!")
    %{game | status: :playing}
  end

  def stop(%{status: :playing} = game) do
    IO.puts("Thanks for playing!")
    %{game | status: :game_over}
  end
end
