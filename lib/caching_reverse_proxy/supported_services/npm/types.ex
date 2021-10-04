defmodule CachingReverseProxy.NPM.Types do
  use Absinthe.Schema.Notation

  @desc "NPM Package Description Response Type"
  object :npm_package_response do
    field(:description, :string)
  end

  object :npm_service_queries do
    field :ping_caching_reverse_proxy_npm_endpoint, :string do
      resolve(fn _, _ -> {:ok, "Welcome to Caching Proxy NPM GraphQL Endpoint"} end)
    end

    @desc "Get a package description"
    field :npm_package, :npm_package_response do
      arg(:name, non_null(:string))

      resolve(&CachingReverseProxy.NPM.Resolver.resolve/3)
    end
  end
end
