defmodule Connect4.Game.Player do
  alias Connect4.Game.Player

  defstruct pid: nil, username: "", symbol: ""

  def set_symbol(player, symbol, players \\ []) do
    case Enum.any?(players, fn p ->
           p.symbol |> String.downcase() == symbol and p.pid != player.pid
         end) do
      true ->
        {:error, :symbol_already_taken}

      false ->
        {:ok, %Player{player | symbol: symbol |> String.upcase()}}
    end
  end

  def set_username(player, username, players \\ []) do
    case Enum.any?(players, fn p ->
           p.username |> String.downcase() == username and
             p.pid != player.pid
         end) do
      true ->
        {:error, :username_already_taken}

      false ->
        {:ok, %Player{player | username: username}}
    end
  end
end
