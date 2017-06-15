defmodule TweetServer.Application do
  use Application

  def start(_type, _args) do
    TweetServer.Supervisor.start_link()
  end
end
