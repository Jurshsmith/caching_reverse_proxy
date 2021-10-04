defmodule CachingReverseProxy.Application.AfterInit do
  use GenServer

  def start_link(opts) do
    GenServer.start_link(__MODULE__, :ok, opts)
  end

  def init(_opts) do
    # after init tasks
    CachingReverseProxy.Cache.Supervisor.start_child()
    {:ok, nil}
  end
end
