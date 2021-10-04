defmodule CachingReverseProxy.Utils.Date do
  def current_time_stamp do
    :os.system_time(:millisecond)
  end
end
