defmodule CachingReverseProxy.Schema do
  use Absinthe.Schema

  import_types(Absinthe.Type.Custom)
  import_types(CachingReverseProxy.NPM.Types)

  query do
    import_fields(:npm_service_queries)
  end
end
