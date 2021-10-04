defmodule CachingReverseProxyTest.SimpleIdNewValueMock do
  # test cache functionality
  def resolve(id) do
    id
    |> CachingReverseProxy.resolve_with_caching(fn -> resolve_from_source(id) end)
  end

  defp resolve_from_source(id) do
    case id do
      "simple-id" -> {:ok, "new-value"}
      _ -> {:error, "failed"}
    end
  end
end
