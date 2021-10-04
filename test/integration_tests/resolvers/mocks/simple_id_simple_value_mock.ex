defmodule CachingReverseProxyTest.SimpleIdSimpleValueMock do
  # test cache functionality
  def resolve(id) do
    id
    |> CachingReverseProxy.resolve_with_caching(fn -> resolve_from_source(id) end)
  end

  def resolve_from_source(id) do
    case id do
      "simple-id" -> {:ok, "simple-value"}
      _ -> {:error, "failed"}
    end
  end
end
