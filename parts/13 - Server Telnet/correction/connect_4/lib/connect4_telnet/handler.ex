defmodule Connect4Telnet.Handler do
  alias Connect4Telnet.Conn

  def handle(%Conn{} = conn) do
    conn |> parse() |> route() |> format_response()
  end

  defp parse(%Conn{} = conn) do
    %Conn{conn | path: [:game, :exit]}
  end

  defp route(%Conn{path: [:game, :exit]} = conn) do
    %Conn{conn | status: :closed, response: "Bye!"}
  end

  defp format_response(%Conn{} = conn) do
    conn
  end
end
