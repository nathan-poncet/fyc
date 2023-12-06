defmodule Connect4Telnet.Game.Code do
  alias Connect4.Game.Players
  alias Connect4.Game
  alias Connect4Telnet.Conn

  def start(%Conn{} = conn) do
    %Conn{listen_pid: listen_pid, path: [:game, code] = path} = conn

    # Get the game
    {:ok, %Game{players: players}} = Connect4.Game.state(code)

    # Get the player
    player = Players.get_by_pid(players, listen_pid)

    %Conn{
      conn
      | path: path ++ [:actions],
        resp: """
        Welcome #{player.username} (#{player.symbol})!

        Here are your options:
        1. start
        2. configure player --username <name> --symbol <symbol (one letter character)>
        3. configure game --name <name> --board_cols <number of cols> --board_rows <number of rows> --winning_length <number of pieces in a row to win>
        4. leave
        """
    }
  end
end
