defmodule Connect4.Games.Server do
  alias Connect4.Games.Game
  alias Connect4.Utils.GenericServer

  # Client Interface
  def start(init_args) do
    code = uuid()
    init_args = Keyword.put(init_args, :code, code)

    GenericServer.start(__MODULE__, init_args, String.to_atom(code))
  end

  def game_join(pid, player) do
    GenericServer.call(pid, {:join, player})
  end

  def game_leave(pid, player_id) do
    GenericServer.call(pid, {:leave, player_id})
  end

  def game_move(pid, player_id, col) do
    GenericServer.call(pid, {:move, player_id, col})
  end

  def game_start(pid) do
    GenericServer.call(pid, :start)
  end

  def game(pid) do
    GenericServer.call(pid, :game)
  end

  # Server Callbacks
  def init(init_args) do
    player = Keyword.get(init_args, :player)
    code = Keyword.get(init_args, :code)
    name = Keyword.get(init_args, :name)
    settings = Keyword.get(init_args, :settings)

    {:ok, Game.create(player, code, name, settings)}
  end

  def handle_call({:join, player}, state) do
    case Game.join(state, player) do
      {:ok, new_state} ->
        {{:ok, new_state}, new_state}

      {:error, error} ->
        {{:error, error}, state}
    end
  end

  def handle_call({:leave, player_id}, state) do
    new_state = Game.leave(state, player_id)
    {{:ok, new_state}, new_state}
  end

  def handle_call(:lobby, state) do
    case Game.lobby(state) do
      {:ok, new_state} ->
        {{:ok, new_state}, new_state}

      {:error, error} ->
        {{:error, error}, state}
    end
  end

  def handle_call({:move, player_id, col}, state) do
    case Game.move(state, player_id, col) do
      {:ok, new_state} ->
        {{:ok, new_state}, new_state}

      {:error, error} ->
        {{:error, error}, state}
    end
  end

  def handle_call(:start, state) do
    case Game.start(state) do
      {:ok, new_state} ->
        {{:ok, new_state}, new_state}

      {:error, error} ->
        {{:error, error}, state}
    end
  end

  def handle_call(:game, state) do
    {{:ok, state}, state}
  end

  @id_length 16
  defp uuid() do
    @id_length
    |> :crypto.strong_rand_bytes()
    |> Base.url_encode64()
    |> binary_part(0, @id_length)
  end
end
