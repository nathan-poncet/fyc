defmodule Connect4Telnet.Router do
  alias Connect4Telnet.Conn

  def route(%Conn{path: [:game]} = conn) do
    Connect4Telnet.Game.start(conn)
  end

  def route(%Conn{path: [:game, :actions]} = conn) do
    Connect4Telnet.Game.Actions.start(conn)
  end

  def route(%Conn{path: [:game, :actions, :create]} = conn) do
    Connect4Telnet.Game.Create.start(conn)
  end

  def route(%Conn{path: [:game, :actions, :join, _]} = conn) do
    Connect4Telnet.Game.Join.start(conn)
  end

  def route(%Conn{path: [:game, :actions, :exit]} = conn) do
    Connect4Telnet.Game.Exit.start(conn)
  end

  # Game Code
  def route(%Conn{path: [:game, _]} = conn) do
    Connect4Telnet.Game.Code.start(conn)
  end

  def route(%Conn{path: [:game, _, :actions]} = conn) do
    Connect4Telnet.Game.Code.Actions.start(conn)
  end

  def route(%Conn{path: [:game, _, :actions, :play]} = conn) do
    Connect4Telnet.Game.Code.Play.start(conn)
  end

  def route(%Conn{path: [:game, _, :actions, :configure_game]} = conn) do
    Connect4Telnet.Game.Code.ConfigGame.start(conn)
  end

  def route(%Conn{path: [:game, _, :actions, :configure_player]} = conn) do
    Connect4Telnet.Game.Code.ConfigPlayer.start(conn)
  end

  def route(%Conn{path: [:game, _, :actions, :leave]} = conn) do
    Connect4Telnet.Game.Code.Leave.start(conn)
  end

  def route(%Conn{path: [:game, _, :actions, :restart]} = conn) do
    Connect4Telnet.Game.Code.Restart.start(conn)
  end

  def route(%Conn{path: [:game, _, :actions, :drop_piece, _]} = conn) do
    Connect4Telnet.Game.Code.DropPiece.start(conn)
  end

  def route(conn) do
    %Conn{conn | status: :error, resp: "invalid router action"}
  end
end
