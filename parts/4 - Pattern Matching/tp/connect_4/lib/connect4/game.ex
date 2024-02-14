defmodule Connect4.Game do
  def create() do
    %{status: :lobby}
  end

  def start(game) do
    IO.puts("Let's play! Connect 4!")
    %{game | status: :playing}
  end

  def lobby(game) do
    IO.puts("Go to lobby!")
    %{game | status: :lobby}
  end
end
