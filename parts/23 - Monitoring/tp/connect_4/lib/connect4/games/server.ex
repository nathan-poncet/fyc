defmodule Connect4.Games.Server do
  use GenServer
  alias Connect4.Utils.PubSub
  alias Connect4.Games.Game

  # Client Interface
  def start_link(init_args) do
    code = uuid()
    init_args = Keyword.put(init_args, :code, code)

    GenServer.start_link(__MODULE__, init_args, name: via_tuple(code))
  end

  def game_join(code, player) do
    GenServer.call(via_tuple(code), {:join, player})
  end

  def game_leave(code, player_id) do
    GenServer.call(via_tuple(code), {:leave, player_id})
  end

  def game_lobby(code) do
    GenServer.call(via_tuple(code), :lobby)
  end

  def game_move(code, player_id, col) do
    GenServer.call(via_tuple(code), {:move, player_id, col})
  end

  def game_start(code) do
    GenServer.call(via_tuple(code), :start)
  end

  def game(code) do
    GenServer.call(via_tuple(code), :game)
  end

  # Uses Registry to register the game in the state.
  #
  # via tuple is a way to tell Elixir that we'll use a custom module to register our processes. In
  # this case, I'm using Registry to do this work.
  defp via_tuple(code) do
    {:via, Registry, {Connect4.Games.Registry, code}}
  end

  # Server Callbacks
  def init(init_args) do
    player = Keyword.get(init_args, :player)
    code = Keyword.get(init_args, :code)
    name = Keyword.get(init_args, :name)
    settings = Keyword.get(init_args, :settings)

    {:ok, Game.create(player, code, name, settings)}
  end

  def handle_call({:join, player}, _from, state) do
    case Game.join(state, player) do
      {:ok, new_state} ->
        PubSub.broadcast("game:#{state.code}", {:join, player})
        {:reply, {:ok, new_state}, new_state}

      {:error, error} ->
        {:reply, {:error, error}, state}
    end
  end

  def handle_call({:leave, player_id}, _from, state) do
    new_state = Game.leave(state, player_id)
    PubSub.broadcast("game:#{state.code}", {:leave, player_id, new_state})
    {:reply, {:ok, new_state}, new_state}
  end

  def handle_call(:lobby, _from, state) do
    case Game.lobby(state) do
      {:ok, new_state} ->
        PubSub.broadcast("game:#{state.code}", {:lobby, new_state})
        {:reply, {:ok, new_state}, new_state}

      {:error, error} ->
        {:reply, {:error, error}, state}
    end
  end

  def handle_call({:move, player_id, col}, _from, state) do
    case Game.move(state, player_id, col) do
      {:ok, new_state} ->
        PubSub.broadcast("game:#{state.code}", {:move, player_id, new_state})
        {:reply, {:ok, new_state}, new_state}

      {:error, error} ->
        {:reply, {:error, error}, state}
    end
  end

  def handle_call(:start, _from, state) do
    case Game.start(state) do
      {:ok, new_state} ->
        PubSub.broadcast("game:#{state.code}", {:start, new_state})
        {:reply, {:ok, new_state}, new_state}

      {:error, error} ->
        {:reply, {:error, error}, state}
    end
  end

  def handle_call(:game, _from, state) do
    {:reply, {:ok, state}, state}
  end

  @id_length 16
  defp uuid() do
    @id_length
    |> :crypto.strong_rand_bytes()
    |> Base.url_encode64()
    |> binary_part(0, @id_length)
  end
end
