use Mix.Config

config :caching_reverse_proxy,
  caching_strategy: CachingReverseProxy.CacheTypes.ETSCache,
  expiration_period: 2_000
