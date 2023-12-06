defmodule Connect4.Game.Registry do
  @doc """
  Checks if there is a `Game` process running with the given name.
  """
  def game_exists?(code) do
    case Registry.lookup(__MODULE__, code) do
      [] -> false
      _ -> true
    end
  end
end
