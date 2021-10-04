defmodule CachingReverseProxy.Cache do
  alias CachingReverseProxy.Utils.Date

  @doc """
  Stores or update a cache data
  """
  @callback insert(String.t(), term) :: {:ok, boolean()}

  @doc """
  Returns cache data based on cache key
  """
  @callback lookup(String.t()) :: term

  @doc """
  Empties the cache
  """
  @callback empty() :: {:ok, boolean()}

  @cache_type Application.get_env(:caching_reverse_proxy, :caching_strategy)
  @cache_expiration_period Application.get_env(:caching_reverse_proxy, :expiration_period)

  def cache(key, value) do
    key
    |> @cache_type.insert(%{
      time_stamp: Date.current_time_stamp(),
      value: value
    })
  end

  def lookup(key) do
    key
    |> @cache_type.lookup()
  end

  def empty do
    @cache_type.empty()
  end

  def has_expired?(cache_time_stamp) do
    Date.current_time_stamp() - cache_time_stamp > @cache_expiration_period
  end
end
