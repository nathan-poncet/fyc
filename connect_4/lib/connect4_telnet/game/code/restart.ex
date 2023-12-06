defmodule Connect4Telnet.Game.Code.Restart do
  alias Connect4Telnet.Conn

  def start(%Conn{path: [:game, code, :actions, :restart]} = conn) do
    Connect4.Game.restart(code)
    %Conn{conn | path: [:game, code], status: :ok, resp: ""}
  end
end
