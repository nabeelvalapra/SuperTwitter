defmodule TweetServer.Worker do
  alias TweetServer.TweetQ
  
  def start_link(name, interval) do
    Process.register(self(), name)
    process(interval)
  end

  def process(interval) do
    case TweetQ.pop() do
      {:empty} ->
        nil
      %{:p_id => p_id, :tweet => tweet} -> 
        Process.send(p_id, {:io_put, {TweetQ.count, tweet.text}}, [])
    end

    :timer.sleep(interval)
    process(interval)
  end
end
