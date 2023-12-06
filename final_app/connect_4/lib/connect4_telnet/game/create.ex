defmodule Connect4Telnet.Game.Create do
  alias Connect4Telnet.Conn

  def start(%Conn{} = conn) do
    %Conn{params: params, listen_pid: listen_pid} = conn

    name = (params[:name] || "") |> String.slice(0..10)
    code = generate_code()

    case Connect4.Game.create(listen_pid, name, code) do
      {:ok, _} ->
        %Conn{
          conn
          | path: [:game, code],
            status: :ok,
            resp: "The game #{name} has been created with code #{code}"
        }

      {:error, reason} ->
        %Conn{conn | path: [:game, :actions], status: :error, resp: reason}
    end
  end

  # Generates a random code to be used as the game name.
  defp generate_code() do
    :crypto.strong_rand_bytes(3)
    |> Base.encode16()
    |> String.downcase()
  end
end
