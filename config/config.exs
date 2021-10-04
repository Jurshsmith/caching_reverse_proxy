use Mix.Config

config :caching_reverse_proxy,
  caching_strategy: CachingReverseProxy.CacheTypes.CustomCache,
  expiration_period: 36_000

import_config "#{Mix.env()}.exs"
