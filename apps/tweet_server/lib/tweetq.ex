defmodule TweetServer.TweetQ do 
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

  def count do
    GenServer.call(__MODULE__, {:count})
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
    case :queue.out(queue) do
      {{:value, item}, queue} -> 
        {:reply, item, queue}
      {:empty, queue} ->
        {:reply, nil, queue}
    end  
  end

  def handle_call({:count}, _from, queue) do
    {:reply, :queue.len(queue), queue}
  end
end
