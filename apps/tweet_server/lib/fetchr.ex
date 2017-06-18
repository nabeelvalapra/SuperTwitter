defmodule TweetServer.Fetchr do
  use GenServer

  @consumer_key Application.get_env(:tweet_server, :consumer_key)
  @consumer_secret Application.get_env(:tweet_server, :consumer_secret)
  @access_token Application.get_env(:tweet_server, :access_token)
  @access_token_secret Application.get_env(:tweet_server, :access_token_secret)
  
  # Client API.
  def start_link(hashtag) do
    GenServer.start_link(__MODULE__, hashtag)
  end

  # Server API.
  def init(hashtag) do
    ExTwitter.configure(
      consumer_key: @consumer_key,
      consumer_secret: @consumer_secret,
      access_token: @access_token,
      access_token_secret: @access_token_secret
    )
    fetch_tweets(hashtag)
    {:ok, nil}
  end

  def handle_info({:fetch, hashtag}, state) do
    tweets = ExTwitter.search(hashtag)
    IO.inspect tweets
    {:noreply, state}
  end

  # Private Functions.
  defp fetch_tweets(hashtag) do
    Process.send_after(self, {:fetch, hashtag}, 1000)
  end
end
