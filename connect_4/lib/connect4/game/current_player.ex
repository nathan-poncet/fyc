defmodule Connect4.Game.CurrentPlayer do
  alias Connect4.Game

  def get_current_player(%Game{players: players, current_player: current_player})
      when is_list(players) do
    case Enum.at(players, current_player) do
      nil -> {:error, :player_not_found}
      player -> {:ok, player}
    end
  end

  def switch(
        %Game{
          status: :playing,
          players: players,
          current_player: current_player
        } = game
      )
      when current_player + 1 > length(players) - 1 do
    %Game{game | current_player: 0}
  end

  def switch(%Game{status: :playing, current_player: current_player} = game) do
    %Game{game | current_player: current_player + 1}
  end

  def switch(%Game{status: :game_over, current_player: current_player} = game) do
    %Game{game | current_player: current_player}
  end
end
