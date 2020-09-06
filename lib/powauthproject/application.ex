defmodule Powauthproject.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      Powauthproject.Repo,
      # Start the Telemetry supervisor
      PowauthprojectWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: Powauthproject.PubSub},
      # Start the Endpoint (http/https)
      PowauthprojectWeb.Endpoint
      # Start a worker by calling: Powauthproject.Worker.start_link(arg)
      # {Powauthproject.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Powauthproject.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    PowauthprojectWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
