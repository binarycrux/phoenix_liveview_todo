defmodule Taskify.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      TaskifyWeb.Telemetry,
      Taskify.Repo,
      {DNSCluster, query: Application.get_env(:taskify, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: Taskify.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: Taskify.Finch},
      # Start a worker by calling: Taskify.Worker.start_link(arg)
      # {Taskify.Worker, arg},
      # Start to serve requests, typically the last entry
      TaskifyWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Taskify.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    TaskifyWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
