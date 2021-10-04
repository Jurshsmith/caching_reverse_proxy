defmodule CachingReverseProxy.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      CachingReverseProxy.Cache.Supervisor,
      {Plug.Cowboy, scheme: :http, plug: CachingReverseProxy.Router, port: 4040},
      CachingReverseProxy.Application.AfterInit
    ]

    opts = [strategy: :one_for_all, name: CachingReverseProxy.Supervisor]

    Supervisor.start_link(children, opts)
  end
end
