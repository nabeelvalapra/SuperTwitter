defmodule TweetQ do 
  use GenServer

  # Client API.
  def start_link do
    GenServer.start_link(__MODULE__, [], name: __MODULE__)
  end

  def append(value) do
    GenServer.cast(__MODULE__, {:append, value})
  end

  def pop do
    GenServer.call(__MODULE__, {:pop})
  end

  # Server API.
  def init([]) do
    queue = :queue.new
    {:ok, queue}
  end

  def handle_cast({:append, value}, queue) do
    queue = :queue.in(value, queue)
    {:noreply, queue}
  end

  def handle_call({:pop}, _from, queue) do
    {{:value, item}, queue} = :queue.out(queue)
    {:reply, item, queue}
  end
end
