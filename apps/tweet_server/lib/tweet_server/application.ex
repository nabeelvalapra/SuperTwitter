defmodule TweetServer.Application do
  use Application

  def start(_type, _args) do
    import Supervisor.Spec
    
    children = [
      supervisor(TweetServer.Fetchr.Supervisor, []),
      supervisor(Task.Supervisor, [[name: TweetServer.WorkerSupervisor]]),
      worker(TweetServer.TweetQ, []),
      worker(Task, [TweetServer.Worker, :start_process, [Worker1]]),
    ]
    opts = [strategy: :one_for_one, name: TweetServer.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
