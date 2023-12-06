defmodule Connect4Telnet.Game.Exit do
  alias Connect4Telnet.Conn

  def start(%Conn{} = conn) do
    %Conn{conn | status: :close, resp: "bye!"}
  end
end
