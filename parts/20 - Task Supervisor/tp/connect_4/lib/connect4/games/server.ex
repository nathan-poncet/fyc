defmodule Connect4.Games.Server do
  use GenServer
  alias Connect4.Games.Game

  # Client Interface
  def start_link(init_args) do
    code = uuid()
    init_args = Keyword.put(init_args, :code, code)

    GenServer.start_link(__MODULE__, init_args, name: String.to_atom(code))
  end

  def game_join(pid, player) do
    GenServer.call(pid, {:join, player})
  end

  def game_leave(pid, player_id) do
    GenServer.call(pid, {:leave, player_id})
  end

  def game_lobby(pid) do
    GenServer.call(pid, :lobby)
  end

  def game_move(pid, player_id, col) do
    GenServer.call(pid, {:move, player_id, col})
  end

  def game_start(pid) do
    GenServer.call(pid, :start)
  end

  def game(pid) do
    GenServer.call(pid, :game)
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
        {:reply, {:ok, new_state}, new_state}

      {:error, error} ->
        {:reply, {:error, error}, state}
    end
  end

  def handle_call({:leave, player_id}, _from, state) do
    new_state = Game.leave(state, player_id)
    {:reply, {:ok, new_state}, new_state}
  end

  def handle_call(:lobby, _from, state) do
    case Game.lobby(state) do
      {:ok, game} ->
        {:reply, {:ok, game}, game}

      {:error, error} ->
        {:reply, {:error, error}, state}
    end
  end

  def handle_call({:move, player_id, col}, _from, state) do
    case Game.move(state, player_id, col) do
      {:ok, new_state} ->
        {:reply, {:ok, new_state}, new_state}

      {:error, error} ->
        {:reply, {:error, error}, state}
    end
  end

  def handle_call(:start, _from, state) do
    case Game.start(state) do
      {:ok, new_state} ->
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
