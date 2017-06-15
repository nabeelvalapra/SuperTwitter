defmodule TweetServer do
  @consumer_key Application.get_env(:tweet_server, :consumer_key)
  @consumer_secret Application.get_env(:tweet_server, :consumer_secret)
  @access_token Application.get_env(:tweet_server, :access_token)
  @access_token_secret Application.get_env(:tweet_server, :access_token_secret)
  
  def fetchr(hashtag) do
    ExTwitter.configure(
      consumer_key: @consumer_key,
      consumer_secret: @consumer_secret,
      access_token: @access_token,
      access_token_secret: @access_token_secret
    )
    tweets = ExTwitter.search(hashtag)
    IO.inspect tweets
    :ok
  end
end
