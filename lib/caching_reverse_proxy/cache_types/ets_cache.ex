defmodule CachingReverseProxy.CacheTypes.ETSCache do
  @behaviour CachingReverseProxy.Cache
  @root_registry :request_cache

  use GenServer

  def start_link(opts) do
    GenServer.start_link(__MODULE__, opts, name: __MODULE__)
  end

  @impl true
  def init(_opts) do
    :ets.new(@root_registry, [:named_table, read_concurrency: true])
    {:ok, nil}
  end

  @impl true
  def handle_call({:cache, cache_key, cache_value}, _from, _state) do
    :ets.insert(@root_registry, {cache_key, cache_value})
    {:reply, nil, nil}
  end

  @impl true
  def handle_call({:empty}, _from, _state) do
    :ets.delete(@root_registry)
    :ets.new(@root_registry, [:named_table, read_concurrency: true])
    {:reply, nil, nil}
  end

  @impl true
  def insert(key, value) do
    GenServer.call(__MODULE__, {:cache, key, value})
    {:ok, true}
  end

  @impl true
  def lookup(cache_key) do
    case :ets.lookup(@root_registry, cache_key) do
      [{^cache_key, cache_value}] -> cache_value
      [] -> nil
    end
  end

  @impl true
  def empty do
    GenServer.call(__MODULE__, {:empty})
    {:ok, true}
  end
end
