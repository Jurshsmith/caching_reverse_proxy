defmodule CachingReverseProxy do
  @moduledoc """
  Documentation for `CachingReverseProxy`.
  """

  # Every cache needs to implement a private resolve_from_source function
  alias CachingReverseProxy.Cache

  def resolve_with_caching(key, resolve_from_source) do
    Cache.lookup(key)
    |> resolve_cache(key, resolve_from_source)
  end

  defp resolve_cache(
         %{time_stamp: cache_time_stamp, value: cache_value},
         _key,
         resolve_from_source
       ) do
    with true <- Cache.has_expired?(cache_time_stamp), {:ok, data} <- resolve_from_source.() do
      {:ok, data}
    else
      _ -> {:ok, cache_value}
    end
  end

  defp resolve_cache(nil, key, resolve_from_source) do
    case resolve_from_source.() do
      {:ok, data} ->
        Cache.cache(key, data)
        {:ok, data}

      {:error, _} ->
        {:error, "failed"}
    end
  end
end
