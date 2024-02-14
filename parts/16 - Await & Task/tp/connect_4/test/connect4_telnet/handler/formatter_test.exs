defmodule Connect4Telnet.Handler.FormatterTest do
  alias Connect4Telnet.Handler.Formatter
  alias Connect4Telnet.Conn
  use ExUnit.Case

  test "format with ok status" do
    conn = %Conn{response: "foo"}
    expected_conn = %Conn{conn | response: "foo"}

    assert expected_conn == Formatter.format_response(conn)
  end

  test "format with closed status" do
    conn = %Conn{response: "foo", status: :closed}
    expected_conn = %Conn{conn | response: "Bye!", status: :closed}

    assert expected_conn == Formatter.format_response(conn)
  end

  test "format with error status" do
    conn = %Conn{response: "foo", status: :error}
    expected_conn = %Conn{conn | response: "Error: foo", status: :error}

    assert expected_conn == Formatter.format_response(conn)
  end
end
