defmodule CachingReverseProxyTest.CacheTest do
  use ExUnit.Case
  alias CachingReverseProxy.Cache
  alias CachingReverseProxy.Utils.Date

  describe "Cache - cache expiry" do
    test "storing cache data with initial timestamp" do
      assert Cache.cache("simple-cache-key", "simple-cache-data") == {:ok, true}

      assert %{time_stamp: time_stamp, value: "simple-cache-data"} =
               Cache.lookup("simple-cache-key")

      assert time_stamp > 0
    end

    test "evaluating cache expiry accurately" do
      assert Cache.has_expired?(Date.current_time_stamp()) == false

      assert Cache.has_expired?(Date.current_time_stamp() - 2_001) == true
    end
  end
end
