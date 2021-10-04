defmodule CachingReverseProxyTest.CacheTypesTest do
  use ExUnit.Case
  @cache_type Application.get_env(:caching_reverse_proxy, :caching_strategy)

  describe "Cache types - cache functionalities" do
    test "caching data" do
      assert @cache_type.insert(
               "simple-id",
               "simple-cache-data"
             ) == {:ok, true}

      assert @cache_type.lookup("simple-id") ==
               "simple-cache-data"
    end

    test "updating cache data" do
      assert @cache_type.insert(
               "simple-id",
               "simple-cache-updated-data"
             ) == {:ok, true}

      assert @cache_type.lookup("simple-id") ==
               "simple-cache-updated-data"
    end

    test "emptying cache data" do
      assert @cache_type.empty() ===
               {:ok, true}

      assert @cache_type.lookup("simple-id") ==
               nil
    end
  end
end
