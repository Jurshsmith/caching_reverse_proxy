defmodule CachingReverseProxyTest do
  @simple_id "simple-id"
  @simple_value "simple-value"

  use ExUnit.Case
  alias CachingReverseProxy.Cache
  alias CachingReverseProxyTest.SimpleIdSimpleValueMock
  alias CachingReverseProxyTest.SimpleIdNewValueMock
  alias CachingReverseProxyTest.SimpleIdErrorMock

  @new_value "new-value"

  test "caches response in memory" do
    SimpleIdSimpleValueMock.resolve(@simple_id)

    {:ok, response} = SimpleIdSimpleValueMock.resolve_from_source(@simple_id)

    # for ets_cache strategy
    delay(200)

    %{time_stamp: _, value: cached_data} = Cache.lookup(@simple_id)

    Cache.empty()

    assert response == cached_data
  end

  test "returns cached response after first call" do
    CachingReverseProxyTest.SimpleIdSimpleValueMock.resolve(@simple_id)

    delay(200)

    {:ok, response} = CachingReverseProxyTest.SimpleIdNewValueMock.resolve(@simple_id)

    Cache.empty()

    # hopefully response is not @new_value
    assert response == @simple_value
  end

  test "returns new response after cache expires" do
    SimpleIdSimpleValueMock.resolve(@simple_id)

    expiration_period = Application.get_env(:caching_reverse_proxy, :expiration_period)

    delay(expiration_period + 200)
    {:ok, response} = SimpleIdNewValueMock.resolve(@simple_id)

    Cache.empty()

    assert response == @new_value
  end

  test "returns cached response if fetching new requests fail and cache is expired" do
    SimpleIdSimpleValueMock.resolve(@simple_id)

    expiration_period = Application.get_env(:caching_reverse_proxy, :expiration_period)

    delay(expiration_period + 200)

    {:ok, response} = SimpleIdErrorMock.resolve(@simple_id)

    Cache.empty()

    assert response == @simple_value
  end

  defp delay(milliseconds) do
    task = Task.async(fn -> :timer.sleep(milliseconds) end)
    Task.await(task)
  end
end
