defmodule Connect4Telnet.Conn do
  use GenServer, restart: :temporary
  alias Connect4.Games.Board
  alias Connect4.Games.Game
  alias Connect4.Games.Player
  alias Connect4Telnet.Handler
  require Logger

  defstruct params: [],
            path: [],
            pid: nil,
            response: "",
            request: "",
            socket: nil,
            status: :ok

  # Client Interface

  def start_link(socket) do
    GenServer.start_link(__MODULE__, socket)
  end

  def state(pid) do
    GenServer.call(pid, :state)
  end

  def set_state(pid, state) do
    GenServer.call(pid, {:set_state, state})
  end

  def exec(pid, command) do
    GenServer.cast(pid, {:exec, command})
  end

  # Server Callbacks

  def init(socket) do
    pid = self()
    state = %__MODULE__{pid: pid, socket: socket}
    spawn_link(fn -> serve(pid) end)
    {:ok, state}
  end

  def handle_call(:state, _from, state) do
    {:reply, state, state}
  end

  def handle_call({:set_state, new_state}, _from, _state) do
    {:reply, :ok, new_state}
  end

  def handle_cast({:exec, command}, state) do
    command.()
    {:noreply, state}
  end

  def handle_info({:broadcast, {:join, %Player{} = player}}, state) do
    send_response(%__MODULE__{state | response: "Player #{player.symbol} has joined the game."})
    {:noreply, state}
  end

  def handle_info({:broadcast, {:leave, player_id, %Game{} = game}}, state) do
    player = Enum.find(game.players, fn p -> p.id == player_id end)
    send_response(%__MODULE__{state | response: "Player #{player.symbol} has left the game."})
    {:noreply, state}
  end

  def handle_info({:broadcast, {:move, player_id, %Game{} = game}}, state) do
    %Game{players: [current_player | _]} = game
    player = Enum.find(game.players, fn p -> p.id == player_id end)

    res = """
    Player #{player.symbol} has played!

    #{Board.to_string(game.board)}

    #{(game.status == :game_over && "Game finished!") || ""}
    #{(game.status == :playing && """
       It's player #{current_player.symbol}'s turn.
       --- Tap "move --col=<column_index>" to play. ---
       """) || ""}
    """

    send_response(%__MODULE__{state | response: res})

    {:noreply, state}
  end

  def handle_info({:broadcast, {:start, %Game{} = game}}, state) do
    %Game{players: [current_player | _]} = game

    res = """
    Game #{game.name} has started!

    #{Board.to_string(game.board)}

    #{(game.status == :game_over && "Game finished!") || ""}
    #{(game.status == :playing && """
       It's player #{current_player.symbol}'s turn.
       --- Tap "move --col=<column_index>" to play. ---
       """) || ""}
    """

    send_response(%__MODULE__{state | response: res})

    {:noreply, state}
  end

  # Privates

  defp serve(pid) do
    state(pid) |> do_serve() |> (&set_state(pid, &1)).()
    serve(pid)
  end

  defp do_serve(%__MODULE__{socket: socket, status: :closed} = conn) do
    :gen_tcp.close(socket)
    {:stop, :normal, conn}
  end

  defp do_serve(%__MODULE__{} = conn) do
    conn |> read_request() |> Handler.handle() |> send_response()
  end

  defp read_request(%__MODULE__{path: path, socket: socket} = conn) do
    case :actions in path do
      true ->
        {:ok, data} = :gen_tcp.recv(socket, 0)
        %__MODULE__{conn | request: data}

      false ->
        %__MODULE__{conn | request: ""}
    end
  end

  defp send_response(%__MODULE__{socket: socket, response: resp} = conn) do
    :gen_tcp.send(socket, "#{resp}\n")
    conn
  end
end
