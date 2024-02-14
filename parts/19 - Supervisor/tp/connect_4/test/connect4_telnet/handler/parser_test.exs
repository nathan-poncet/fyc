defmodule Connect4Telnet.Handler.ParserTest do
  alias Connect4Telnet.Handler.Parser
  alias Connect4Telnet.Conn
  use ExUnit.Case

  test "parse" do
    conn = %Conn{path: [:game, :actions], request: "create --name=foo"}
    expexted_conn = %Conn{conn | path: [:game, :actions, :create], params: %{"name" => "foo"}}

    assert expexted_conn == Parser.parse(conn)
  end

  test "parse_params" do
    assert %{"name" => "foo"} = Parser.parse_params(["name=foo"], %{})
  end
end
