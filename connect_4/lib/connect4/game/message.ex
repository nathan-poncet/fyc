defmodule Connect4.Game.Message do
  def broadcast(game, message) do
    Enum.each(game.players, fn player ->
      send(player.pid, {:send, message})
    end)
  end
end
