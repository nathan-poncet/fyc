defmodule Connect4Telnet.Game.Code.Actions do
  alias Connect4Telnet.Conn

  def start(%Conn{} = conn) do
    %Conn{path: [:game, code, :actions], socket: socket} = conn

    {:ok, data} = :gen_tcp.recv(socket, 0)

    data =
      data
      |> String.trim()
      |> String.downcase()

    case data do
      "start" ->
        %Conn{conn | path: [:game, code, :actions, :play], status: :ok}

      "configure player " <> args ->
        params =
          args
          |> String.split("--")
          |> Enum.filter(&(&1 != ""))
          |> Enum.map(&String.trim(&1))
          |> Enum.map(fn arg ->
            arg = arg |> String.split(" ")

            {Enum.at(arg, 0) |> String.to_existing_atom(), Enum.at(arg, 1)}
          end)

        %Conn{
          conn
          | path: [:game, code, :actions, :configure_player],
            params: params,
            status: :ok,
            resp: ""
        }

      "configure game " <> args ->
        params =
          args
          |> String.split("--")
          |> Enum.filter(&(&1 != ""))
          |> Enum.map(&String.trim(&1))
          |> Enum.map(fn arg ->
            arg = arg |> String.split(" ")
            key = Enum.at(arg, 0) |> String.to_existing_atom()

            value =
              if key in [:board_cols, :board_rows, :winning_length],
                do: Enum.at(arg, 1) |> String.to_integer(),
                else: Enum.at(arg, 1)

            {key, value}
          end)

        %Conn{
          conn
          | path: [:game, code, :actions, :configure_game],
            params: params,
            status: :ok,
            resp: ""
        }

      "leave" ->
        %Conn{conn | path: [:game, code, :actions, :leave], status: :ok, resp: ""}

      "restart" ->
        %Conn{conn | path: [:game, code, :actions, :restart], status: :ok, resp: ""}

      column_input ->
        case validate_input(column_input) do
          {:ok, column_input} ->
            %Conn{
              conn
              | path: [:game, code, :actions, :drop_piece, column_input],
                status: :ok,
                resp: ""
            }

          {:error, :invalid_input} ->
            %Conn{conn | status: :error, resp: "invalid action"}
        end
    end
  end

  defp validate_input(column_input) when is_bitstring(column_input) do
    case column_input |> String.trim() |> Integer.parse() do
      {column_input, ""} ->
        {:ok, column_input}

      _ ->
        {:error, :invalid_input}
    end
  end
end
