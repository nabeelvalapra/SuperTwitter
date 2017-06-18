defmodule TweetServer.Fetchr do
  use GenServer

  @consumer_key Application.get_env(:tweet_server, :consumer_key)
  @consumer_secret Application.get_env(:tweet_server, :consumer_secret)
  @access_token Application.get_env(:tweet_server, :access_token)
  @access_token_secret Application.get_env(:tweet_server, :access_token_secret)
  
  # Client API.
  def start_link do
    GenServer.start_link(__MODULE__, [])
  end

  def fetch_tweets(pid, hashtag) do
    GenServer.cast(pid, {:fetch, hashtag})
  end

  # Server API.
  def init([]) do
    ExTwitter.configure(
      consumer_key: @consumer_key,
      consumer_secret: @consumer_secret,
      access_token: @access_token,
      access_token_secret: @access_token_secret
    )
    {:ok, []}
  end

  def handle_cast({:fetch, hashtag}, state) do
    tweets = ExTwitter.search(hashtag)
    {:noreply, state}
  end
end
