defmodule TweetServer.Supervisor do 
  use Supervisor 

  def start_link do
    Supervisor.start_link(__MODULE__, :ok, name: TweetServer.Supervisor)
  end
  
  def init(:ok) do
    children = [
    ]
    opts = [strategy: :one_for_one, name: TweetServer.Supervisor]

    supervise(children, opts)
  end
end
