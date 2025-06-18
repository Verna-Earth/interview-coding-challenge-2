defmodule Verna.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      VernaWeb.Telemetry,
      Verna.Repo,
      {DNSCluster, query: Application.get_env(:verna, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: Verna.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: Verna.Finch},
      # Start a worker by calling: Verna.Worker.start_link(arg)
      # {Verna.Worker, arg},
      # Start to serve requests, typically the last entry
      VernaWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Verna.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    VernaWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
