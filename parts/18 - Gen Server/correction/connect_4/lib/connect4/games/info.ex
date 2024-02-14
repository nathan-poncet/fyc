defmodule Connect4.Games.Info do
  alias Connect4.Utils.Job

  @funfacts [
    "Connect Four was invented in 1974 by Howard Wexler.",
    "The game is also known as Connect Four in the United States.",
    "The name 'Connect Four' comes from the goal of connecting four pieces in a row to win.",
    "The game is played on a 7x6 grid.",
    "There are over 4.5 trillion possible ways to fill a Connect Four board.",
    "Connect Four is a simple yet deep strategy game.",
    "The first player to connect four pieces horizontally, vertically, or diagonally wins.",
    "Connect Four is often used as an educational tool to teach strategy.",
    "In 1988, Connect Four was included in the 'Games Magazine' list of 'Games of the Century.'",
    "There are professional Connect Four players who compete in tournaments.",
    "Some Connect Four players have become famous for their skills.",
    "There are advanced strategies for playing Connect Four, such as the 'Trap' strategy to trap your opponent.",
    "Connect Four is a popular board game worldwide.",
    "It is often played with family and friends.",
    "Connect Four is suitable for both kids and adults.",
    "Giant versions of Connect Four are available for outdoor play.",
    "Connect Four was marketed by Milton Bradley.",
    "Some editions of Connect Four feature custom designs.",
    "Wooden versions of Connect Four are available for those who prefer wooden board games.",
    "Connect Four competitions are held in various countries.",
    "Connect Four is sometimes used as a strategy game to teach children.",
    "There are tactics for blocking your opponent and winning at Connect Four.",
    "Connect Four is a game of both chance and strategy.",
    "Connect Four competitions attract players of all ages.",
    "Connect Four can be played online with friends.",
    "There are mobile apps for playing Connect Four.",
    "Connect Four is a fast-paced game that can be completed in a few minutes.",
    "Some versions of Connect Four have special rules to make the game more interesting.",
    "Connect Four is sometimes used as a brain-teaser in schools.",
    "There are Connect Four tournaments with cash prizes.",
    "Connect Four competitions have strict rules to prevent cheating.",
    "Online forums exist where players share tips and strategies for Connect Four.",
    "Connect Four is sometimes used as a brain game to enhance problem-solving skills.",
    "There are advanced strategies for predicting your opponent's moves.",
    "Connect Four can be played in real-time multiplayer mode online.",
    "There are online leaderboards for Connect Four players.",
    "Connect Four competitions have referees to ensure fair play.",
    "There are videos of Connect Four strategy discussions on the internet.",
    "Connect Four is sometimes used as a strategy game to teach decision-making.",
    "Recorded videos of Connect Four matches are available online.",
    "There are tactics for gaining control of the center of the board in Connect Four.",
    "Connect Four can be played online against strangers.",
    "Online communities dedicated to Connect Four exist.",
    "Connect Four is sometimes used as a strategy game to teach communication.",
    "There are recorded videos of Connect Four gameplay online.",
    "There are tricks to force your opponent to make mistakes in Connect Four.",
    "Connect Four can be played online in real-time with opponents from around the world."
  ]

  @doc """
  Returns syncronously a random funfact about Connect Four.
  """
  def get_random_funfacts_sync(number) do
    funfacts = Enum.map(1..number, fn _ -> call_funfact_api() end)
    {:ok, funfacts}
  end

  @doc """
  Returns asyncronously a random funfact about Connect Four.
  """
  # Spawn method
  def get_random_funfacts_async(:spawn, number) do
    parent = self()

    async_funfacts =
      Enum.map(1..number, fn _ ->
        spawn(fn -> send(parent, {self(), :result, call_funfact_api()}) end)
      end)

    Enum.map(async_funfacts, fn pid ->
      receive do
        {^pid, :result, value} -> value
      end
    end)
  end

  # Job method
  def get_random_funfacts_async(:job, number) do
    async_funfacts = Enum.map(1..number, fn _ -> Job.async(&call_funfact_api/0) end)
    Enum.map(async_funfacts, &Job.await/1)
  end

  # Task.async method
  def get_random_funfacts_async(:task_async, number) do
    async_funfacts = Enum.map(1..number, fn _ -> Task.async(&call_funfact_api/0) end)
    Enum.map(async_funfacts, &Task.await/1)
  end

  # Task.async_stream method
  def get_random_funfacts_async(:task_async_stream, number) do
    Task.async_stream(1..number, fn _ -> call_funfact_api() end) |> Enum.to_list()
  end

  defp call_funfact_api() do
    unless Mix.env() == :test do
      Process.sleep(1000)
    end

    Enum.random(@funfacts)
  end
end
