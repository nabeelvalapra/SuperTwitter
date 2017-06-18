defmodule TweetServer.Fetchr.Supervisor do 
  use Supervisor 

  def start_link do
    Supervisor.start_link(__MODULE__, :ok, name: __MODULE__)
  end

  def start_fetchr(hashtag) do
    Supervisor.start_child(__MODULE__, [])
  end
  
  def init(:ok) do
    children = [
      worker(TweetServer.Fetchr, []),
    ]
    opts = [strategy: :simple_one_for_one]
    supervise(children, opts)
  end
end
