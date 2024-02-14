defmodule Connect4Telnet.Handler do
  alias Connect4Telnet.Handler.Formatter
  alias Connect4Telnet.Handler.Parser
  alias Connect4Telnet.Handler.Router
  alias Connect4Telnet.Conn

  def handle(%Conn{} = conn) do
    conn |> Parser.parse() |> Router.route() |> Formatter.format_response()
  end
end
