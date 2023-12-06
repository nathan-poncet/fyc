defmodule Connect4Telnet.Game do
  alias Connect4Telnet.Conn

  def start(%Conn{} = conn) do
    %Conn{
      conn
      | path: [:game, :actions],
        resp: """
        Bienvue sur Connect4
        Voici les commandes disponibles:
        1. create <game_name> | (Create a Game)
        2. join <game_code>   | (Join a Game)
        3. exit               | (Exit the Game)
        """
    }
  end
end
