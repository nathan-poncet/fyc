defmodule Connect4.Game.Players do
  alias Connect4.Game.Player

  def get_by_pid(players, pid) do
    Enum.find(players, fn player -> player.pid == pid end)
  end

  def add(players, new_player) do
    %Player{pid: pid, symbol: symbol, username: username} = new_player

    with {:ok, _} <- pid_available(players, pid),
         {:ok, _} <- symbol_available(players, symbol),
         {:ok, _} <- username_available(players, username) do
      {:ok, [new_player] ++ players}
    end
  end

  def remove(players, pid), do: Enum.filter(players, fn player -> player.pid != pid end)

  def without?(players) do
    length(players) == 0
  end

  defp pid_available(players, pid) do
    case Enum.any?(players, fn player -> player.pid == pid end) do
      true ->
        {:error, :pid_in_use}

      false ->
        {:ok, pid}
    end
  end

  defp symbol_available(players, symbol) do
    case Enum.any?(players, fn player -> player.symbol == symbol and symbol != nil end) do
      true ->
        {:error, :symbol_in_use}

      false ->
        {:ok, symbol}
    end
  end

  defp username_available(players, username) do
    case Enum.any?(players, fn player -> player.username == username and username != nil end) do
      true ->
        {:error, :username_in_use}

      false ->
        {:ok, username}
    end
  end

  def generate_random_symbol(players \\ []) do
    symbols =
      "abcdefghijklmnopqrstuvwxyz"
      |> String.upcase()
      |> String.graphemes()
      |> Enum.filter(fn s -> !Enum.any?(players, fn p -> p.symbol == s end) end)

    Enum.random(symbols)
  end
end
