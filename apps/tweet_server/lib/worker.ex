defmodule TweetServer.Worker do
  alias TweetServer.TweetQ
  
  def start_process name do
    Process.register self, name
    process
  end

  def process do
    case TweetQ.pop do
      {:empty} ->
        nil
      %{:p_id => _, :tweet => tweet} -> 
        IO.puts tweet.text
        :timer.sleep(500)
    end
    process()
  end
end
