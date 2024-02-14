defmodule Connect4.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  require Logger

  @impl true
  def start(_type, _args) do
    Logger.info("Starting the application...")

    children = [
      # Start the pubsub supervisor
      Connect4.Utils.PubSub,
      # Start the game supervisor
      Connect4.Games.Supervisor,
      # Start the server supervisor
      {Connect4Telnet.Endpoint, name: Connect4Telnet.Endpoint}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Connect4.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
