defmodule Connect4Telnet.Handler.Router do
  alias Connect4.Games.Player
  alias Connect4.Games
  alias Connect4Telnet.Conn

  def route(%Conn{path: []} = conn) do
    %Conn{conn | path: [:game], status: :ok}
  end

  def route(%Conn{path: [:game]} = conn) do
    response = """
    Bienvue sur Connect4
    Voici les commandes disponibles:
    1. create --name=<game name>            | (Create a Game)
    2. join --code=<game code> --symbol=O   | (Join a Game)
    3. exit                                 | (Exit the Game)
    """

    %Conn{conn | path: [:game, :actions], response: response, status: :ok}
  end

  def route(%Conn{path: [:game, :actions, :create], params: %{"name" => name}} = conn) do
    player = %Player{id: conn.pid, symbol: "X"}

    case Games.game_create(player, name, %{board: %{cols: 7, rows: 6}}) do
      {:ok, code} ->
        %Conn{conn | path: [:game, code], response: "Game created!", status: :ok}

      {:error, reason} ->
        %Conn{conn | path: [:game, :actions], response: reason, status: :error}
    end
  end

  def route(
        %Conn{
          path: [:game, :actions, :join],
          params: %{"code" => code, "symbol" => symbol},
          pid: pid
        } = conn
      ) do
    symbol = symbol |> String.first() |> String.upcase()
    player = %Player{id: pid, symbol: symbol}

    case Games.game_join(code, player) do
      {:ok, _} ->
        %Conn{conn | path: [:game, code], response: "Game joined!", status: :ok}

      {:error, reason} ->
        %Conn{conn | path: [:game, :actions], response: reason, status: :error}
    end
  end

  def route(%Conn{path: [:game, :actions, :exit]} = conn) do
    %Conn{conn | status: :closed}
  end

  def route(%Conn{path: [:game, :actions, :funfacts], params: %{"number" => number}} = conn) do
    res =
      Games.get_random_funfacts_async(:task_async_stream, number)
      |> Enum.map(fn {:ok, funfact} -> "#{funfact}" end)
      |> Enum.join("\n")

    %Conn{conn | path: [:game, :actions], response: res, status: :ok}
  end

  def route(%Conn{path: [:game, game_code]} = conn) do
    response = """
    Voici les commandes disponibles:
    1. play   | (Play a Game)
    2. leave  | (Leave the Game)
    """

    %Conn{conn | path: [:game, game_code, :actions], response: response, status: :ok}
  end

  def route(%Conn{path: [:game, game_code, :actions, :play]} = conn) do
    {:ok, _} = Games.game_start(game_code)

    %Conn{conn | path: [:game, game_code, :actions], response: "Game started!", status: :ok}
  end

  def route(%Conn{path: [:game, game_code, :actions, :lobby]} = conn) do
    case Games.game_lobby(game_code) do
      {:ok, _} ->
        %Conn{conn | path: [:game, game_code, :actions], response: "Go to lobby", status: :ok}

      {:error, reason} ->
        %Conn{conn | path: [:game, game_code, :actions], response: reason, status: :error}
    end

    %Conn{conn | path: [:game, game_code, :actions], status: :ok}
  end

  def route(
        %Conn{
          path: [:game, game_code, :actions, :move],
          params: %{"col" => col_index},
          pid: pid
        } = conn
      ) do
    col_index = String.to_integer(col_index)

    case Games.game_move(game_code, pid, col_index) do
      {:ok, _} ->
        %Conn{conn | path: [:game, game_code, :actions], status: :ok}

      {:error, reason} ->
        %Conn{conn | path: [:game, game_code, :actions], response: reason, status: :error}
    end
  end

  def route(%Conn{path: [:game, game_code, :actions, :leave], pid: pid} = conn) do
    case Games.game_leave(game_code, pid) do
      {:ok, _} ->
        %Conn{conn | path: [:game], status: :ok}

      {:error, reason} ->
        %Conn{conn | path: [:game, game_code, :actions], response: reason, status: :error}
    end
  end

  def route(%Conn{} = conn) do
    conn |> route_not_found()
  end

  defp route_not_found(%Conn{} = conn) do
    %Conn{conn | response: "Command not found"}
  end
end
