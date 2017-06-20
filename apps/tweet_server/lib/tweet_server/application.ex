defmodule TweetServer.Application do
  use Application

  def start(_type, _args) do
    import Supervisor.Spec
    
    children = [
      supervisor(TweetServer.Fetchr.Supervisor, []),
      worker(TweetServer.TweetQ, []),
      worker(Task, [TweetServer.Worker, :start_link, [Worker1, 5000]], [id: Worker1]),
      worker(Task, [TweetServer.Worker, :start_link, [Worker2, 5000]], [id: Worker2]),
      worker(Task, [TweetServer.Worker, :start_link, [Worker3, 5000]], [id: Worker3]),
      worker(Task, [TweetServer.Worker, :start_link, [Worker4, 5000]], [id: Worker4]),
    ]
    opts = [strategy: :one_for_one, name: TweetServer.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
