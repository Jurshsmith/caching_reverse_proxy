defmodule CachingReverseProxyTest.SimpleIdErrorMock do
  # Tests integration with resolvers

  def resolve(id) do
    id
    |> CachingReverseProxy.resolve_with_caching(fn -> resolve_from_source(id) end)
  end

  def resolve_from_source(id) do
    case id do
      "simple-id" -> {:error, "simple-value"}
      _ -> {:ok, "test working"}
    end
  end
end
