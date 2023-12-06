defmodule Connect4Telnet.Game.Actions do
  alias Connect4Telnet.Conn

  def start(%Conn{} = conn) do
    %Conn{socket: socket} = conn

    {:ok, data} = :gen_tcp.recv(socket, 0)

    parsed_data =
      data
      |> String.trim()
      |> String.split(" ")
      |> Enum.filter(&(&1 != ""))
      |> Enum.map(&String.downcase(&1))

    action = Enum.at(parsed_data, 0)

    case action do
      "create" ->
        %Conn{
          conn
          | path: [:game, :actions, :create],
            params: [name: Enum.at(parsed_data, 1)],
            status: :ok,
            resp: ""
        }

      "join" ->
        %Conn{
          conn
          | path: [:game, :actions, :join, Enum.at(parsed_data, 1)],
            status: :ok,
            resp: ""
        }

      "exit" ->
        %Conn{conn | path: [:game, :actions, :exit], status: :ok, resp: ""}

      _ ->
        %Conn{conn | status: :error, resp: "invalid action"}
    end
  end
end
