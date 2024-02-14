defmodule Connect4Telnet.Handler.Formatter do
  alias Connect4Telnet.Conn

  def format_response(%Conn{status: :error} = conn) do
    %Conn{conn | response: "Error: #{conn.response}"}
  end

  def format_response(%Conn{status: :closed} = conn) do
    %Conn{conn | response: "Bye!"}
  end

  def format_response(%Conn{status: :ok} = conn) do
    %Conn{conn | response: conn.response}
  end
end
