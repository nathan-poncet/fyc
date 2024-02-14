defmodule Connect4Telnet.Handler.Parser do
  alias Connect4Telnet.Conn

  @allowed_commands [
    "game",
    "create",
    "join",
    "exit",
    "play",
    "lobby",
    "move",
    "leave",
    "funfacts"
  ]

  def parse(%Conn{request: request} = conn) do
    splited_request =
      String.split(request, " ")
      |> Enum.map(&(String.trim(&1) |> String.downcase()))

    path =
      splited_request
      |> Enum.filter(&(&1 in @allowed_commands))
      |> Enum.map(&String.to_existing_atom/1)

    params =
      splited_request
      |> Enum.filter(&String.starts_with?(&1, "--"))
      |> Enum.map(&String.trim_leading(&1, "--"))
      |> parse_params(%{})

    %Conn{conn | path: conn.path ++ path, params: params}
  end

  def parse_params([head | tail], params) do
    [key, value] = String.split(head, "=")
    params = Map.put(params, key, value)
    parse_params(tail, params)
  end

  def parse_params([], params), do: params
end
