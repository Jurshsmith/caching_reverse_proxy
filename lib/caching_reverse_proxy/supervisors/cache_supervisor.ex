defmodule CachingReverseProxy.Cache.Supervisor do
  use DynamicSupervisor

  def start_link(_init_arg) do
    DynamicSupervisor.start_link(__MODULE__, [], name: __MODULE__)
  end

  def start_child() do
    DynamicSupervisor.start_child(
      __MODULE__,
      Application.get_env(:caching_reverse_proxy, :caching_strategy)
    )
  end

  @impl true
  def init(_init_arg) do
    DynamicSupervisor.init(
      strategy: :one_for_one,
      extra_arguments: []
    )
  end
end
