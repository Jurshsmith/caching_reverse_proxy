defmodule CachingReverseProxy.NPM.Resolver do
  alias CachingReverseProxy.NPM.Adapter

  def resolve(_parent, %{name: name}, _resolution) do
    name
    |> CachingReverseProxy.resolve_with_caching(fn -> resolve_from_source!(name) end)
  end

  defp resolve_from_source!(name) do
    Adapter.fetch_npm_package_description(name)
  end
end
