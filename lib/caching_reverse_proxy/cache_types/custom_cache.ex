defmodule CachingReverseProxy.CacheTypes.CustomCache do
  @behaviour CachingReverseProxy.Cache

  use GenServer

  def start_link(opts) do
    GenServer.start_link(__MODULE__, opts, name: __MODULE__)
  end

  @impl true
  def init(_opts) do
    {:ok, %{}}
  end

  @impl true
  def handle_call({:lookup, cache_key}, _from, cache_data_map) do
    case Map.fetch(cache_data_map, cache_key) do
      {:ok, cache_data} -> {:reply, cache_data, cache_data_map}
      _ -> {:reply, nil, cache_data_map}
    end
  end

  @impl true
  def handle_cast({:empty}, _cache_data_map) do
    {:noreply, %{}}
  end

  @impl true
  def handle_cast({:cache, cache_key, cache_value}, cache_data_map) do
    {:noreply, Map.put(cache_data_map, cache_key, cache_value)}
  end

  @impl true
  def insert(key, value) do
    GenServer.cast(__MODULE__, {:cache, key, value})
    {:ok, true}
  end

  @impl true
  def lookup(cache_key) do
    GenServer.call(__MODULE__, {:lookup, cache_key})
  end

  @impl true
  def empty do
    GenServer.cast(__MODULE__, {:empty})
    {:ok, true}
  end
end
