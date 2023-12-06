defmodule Connect4.Game do
  alias Connect4.Game.Message
  alias Connect4.Game.Checker
  alias Connect4.Game.Dropper
  alias Connect4.Game.CurrentPlayer
  alias Connect4.Game.Players
  alias Connect4.Game.Player
  alias Connect4.Game
  alias Connect4.Game.Board

  defstruct name: "",
            board: %Board{},
            players: [],
            current_player: 0,
            status: :lobby,
            winning_length: 0

  use GenServer, restart: :temporary

  def start_link(init_arg) do
    code = Keyword.fetch!(init_arg, :code)
    GenServer.start_link(__MODULE__, init_arg, name: via_tuple(code))
  end

  # Client API
  def state(code) do
    GenServer.call(via_tuple(code), :state)
  end

  def create(pid, name, code) do
    DynamicSupervisor.start_child(
      Connect4.Game.Supervisor.DynamicSupervisor,
      {Connect4.Game, pid: pid, name: name, code: code}
    )
  end

  def join(code, pid) do
    case Connect4.Game.Registry.game_exists?(code) do
      false ->
        {:error, "Game not found"}

      true ->
        GenServer.call(via_tuple(code), {:join, pid})
    end
  end

  def play(code) do
    GenServer.call(via_tuple(code), :play)
  end

  def restart(code) do
    GenServer.cast(via_tuple(code), :restart)
  end

  def drop_piece(code, pid, col) do
    GenServer.call(via_tuple(code), {:drop_piece, pid, col})
  end

  def leave(code, pid) do
    GenServer.call(via_tuple(code), {:leave, pid})
  end

  def configure(code, params) do
    GenServer.call(via_tuple(code), {:configure, params})
  end

  def configure_player(code, pid, params) do
    GenServer.call(via_tuple(code), {:configure_player, pid, params})
  end

  # Uses Registry to register the game in the state.
  #
  # via tuple is a way to tell Elixir that we'll use a custom module to register our processes. In
  # this case, I'm using Registry to do this work.
  defp via_tuple(code) do
    {:via, Registry, {Connect4.Game.Registry, code}}
  end

  # Server callbacks
  def init(init_arg) do
    Process.flag(:trap_exit, true)

    # Initialize the game
    name = Keyword.fetch!(init_arg, :name)
    random_symbol = Players.generate_random_symbol()

    pid = Keyword.fetch!(init_arg, :pid)

    new_player = %Player{
      pid: pid,
      username: "Player 1",
      symbol: random_symbol
    }

    case Connect4.Game.Initializer.init(%Connect4.Game.Initializer.Args{
           name: name,
           players: [new_player]
         }) do
      {:ok, game} ->
        # Monitor the player
        Process.link(pid)

        {:ok, game}

      {:error, error} ->
        {:stop, error}
    end
  end

  def handle_call(:state, _from, state) do
    {:reply, {:ok, state}, state}
  end

  def handle_call({:join, pid}, _from, %Game{status: :lobby} = state) do
    %Game{players: players} = state
    random_symbol = Players.generate_random_symbol(players)

    new_player = %Player{
      pid: pid,
      username: "Player #{length(players) + 1}",
      symbol: random_symbol
    }

    case Connect4.Game.Players.add(players, new_player) do
      {:ok, players} ->
        game = %Game{state | players: players}

        # Monitor the player
        Process.link(pid)

        Message.broadcast(
          game,
          "A player (#{new_player.username} | #{new_player.symbol}) has joined the game"
        )

        {:reply, {:ok, game}, game}

      {:error, error} ->
        {:reply, {:error, error}, state}
    end
  end

  def handle_call(:play, _from, %Game{status: :lobby} = state) do
    new_state = %Game{state | status: :playing}

    Message.broadcast(new_state, "Game started")
    Message.broadcast(new_state, Board.display(new_state.board))
    {:ok, current_player} = CurrentPlayer.get_current_player(new_state)
    Message.broadcast(new_state, "It's #{current_player.username}'s turn")

    {:reply, {:ok, new_state}, new_state}
  end

  def handle_call({:drop_piece, pid, column_input}, _from, %Game{status: :playing} = state) do
    %Game{board: board, players: players} = state
    player_who_want_to_play = Players.get_by_pid(players, pid)

    with {:ok, current_player} <- CurrentPlayer.get_current_player(state),
         {:ok, player} <-
           (if player_who_want_to_play == current_player do
              {:ok, player_who_want_to_play}
            else
              {:error, :not_your_turn}
            end),
         {:ok, column_index} <- Board.find_col_index(board, column_input),
         {:ok, row_index} <- Board.find_row_index(board, column_index) do
      pos = %{x: column_index, y: row_index}

      new_state =
        state
        |> Dropper.drop_piece(player, pos)
        |> Checker.check_win(pos)
        |> CurrentPlayer.switch()

      Message.broadcast(new_state, Board.display(new_state.board))

      case new_state.status do
        :game_over ->
          Message.broadcast(new_state, """
          Game over !!!
          #{player.username} has won the game
          """)

        :playing ->
          {:ok, current_player} = CurrentPlayer.get_current_player(new_state)
          Message.broadcast(new_state, "It's #{current_player.username}'s turn")
      end

      {:reply, {:ok, new_state}, new_state}
    else
      {:error, error} ->
        {:reply, {:error, error}, state}
    end
  end

  def handle_call({:drop_piece, _, _}, _from, state) do
    {:reply, {:error, "Couldn't play status is #{state.status}"}, state}
  end

  def handle_call({:leave, pid}, _from, state) do
    %Game{players: players} = state
    %Player{username: username} = Players.get_by_pid(players, pid)
    new_players = Connect4.Game.Players.remove(players, pid)
    new_state = %Game{state | players: new_players}

    Message.broadcast(new_state, "#{username} has left the game")

    if Game.Players.without?(new_players) do
      {:stop, :normal, {:closed, new_state}, new_state}
    else
      {:reply, {:ok, new_state}, new_state}
    end
  end

  def handle_call({:configure, params}, _from, %Game{status: :lobby} = state) do
    new_name = params[:name]
    new_cols = params[:board_cols]
    new_rows = params[:board_rows]
    new_winning_length = params[:winning_length]

    %Game{
      board: %Board{cols: cols, rows: rows},
      name: name,
      players: players,
      winning_length: winning_length
    } =
      state

    params = %Connect4.Game.Initializer.Args{
      name: new_name || name,
      board: %Board{rows: new_rows || rows, cols: new_cols || cols},
      winning_length: new_winning_length || winning_length,
      players: players
    }

    case Connect4.Game.Initializer.init(params) do
      {:ok, game} ->
        Message.broadcast(game, """
        Game configured correctly:
        name: #{game.name},
        board: #{game.board.cols}x#{game.board.rows},
        winning_length: #{game.winning_length}
        """)

        {:reply, {:ok, game}, game}

      {:error, error} ->
        {:reply, {:error, error}, state}
    end
  end

  def handle_call({:configure_player, pid, params}, _from, %Game{status: :lobby} = state) do
    %Game{players: players} = state

    player = Players.get_by_pid(players, pid)

    username = params[:username]
    symbol = params[:symbol]

    with {:ok, new_player} <- Player.set_username(player, username || player.username, players),
         {:ok, new_player} <- Player.set_symbol(new_player, symbol || player.symbol, players) do
      new_players = Players.remove(players, pid) ++ [new_player]
      new_state = %Game{state | players: new_players}

      Message.broadcast(
        new_state,
        "Player #{player.username} has been updated: username: #{new_player.username}, symbol: #{new_player.symbol}"
      )

      {:reply, {:ok, new_state}, new_state}
    else
      {:error, error} ->
        {:reply, {:error, error}, state}
    end
  end

  def handle_cast(:restart, %Game{status: :game_over} = state) do
    %Game{board: board} = state
    new_state = %Game{state | status: :lobby, board: %Board{board | table: Board.clear(board)}}

    Message.broadcast(new_state, "Game restarted -> Go to lobby")

    {:noreply, new_state}
  end

  def handle_info({:EXIT, pid, _}, %Game{players: players} = state) do
    %Player{username: username} = Players.get_by_pid(players, pid)
    new_players = Players.remove(players, pid)
    new_state = %Game{state | players: new_players}

    Message.broadcast(new_state, "#{username} has crashed so we kicked him from the game")

    if Game.Players.without?(new_players) do
      {:stop, :normal, {:closed, new_state}, new_state}
    else
      {:noreply, new_state}
    end
  end
end
