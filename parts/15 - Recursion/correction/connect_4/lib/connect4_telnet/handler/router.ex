defmodule Connect4Telnet.Handler.Router do
  alias Connect4Telnet.Conn

  def route(%Conn{path: []} = conn) do
    %Conn{conn | path: [:game], status: :ok}
  end

  def route(%Conn{path: [:game]} = conn) do
    response = """
    Bienvue sur Connect4
    Voici les commandes disponibles:
    1. create <game_name> | (Create a Game)
    2. join <game_code>   | (Join a Game)
    3. exit               | (Exit the Game)
    """

    %Conn{conn | path: [:game, :actions], response: response, status: :ok}
  end

  def route(%Conn{path: [:game, :actions, :create]} = conn) do
    code = 1234
    %Conn{conn | path: [:game, code], status: :ok}
  end

  def route(%Conn{path: [:game, :actions, :join], params: %{"code" => code}} = conn) do
    %Conn{conn | path: [:game, code], status: :ok}
  end

  def route(%Conn{path: [:game, :actions, :exit]} = conn) do
    %Conn{conn | status: :closed}
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
    %Conn{conn | path: [:game, game_code, :actions], status: :ok}
  end

  def route(%Conn{path: [:game, game_code, :actions, :lobby]} = conn) do
    %Conn{conn | path: [:game, game_code, :actions], status: :ok}
  end

  def route(%Conn{path: [:game, game_code, :actions, :move, _column_index]} = conn) do
    %Conn{conn | path: [:game, game_code, :actions], status: :ok}
  end

  def route(%Conn{path: [:game, _game_code, :actions, :leave]} = conn) do
    %Conn{conn | path: [:game], status: :ok}
  end

  def route(%Conn{} = conn) do
    conn |> route_not_found()
  end

  defp route_not_found(%Conn{} = conn) do
    %Conn{conn | response: "Command not found"}
  end
end
