defmodule TweetServer do
  use GenServer

  # Client APIs.
  def start_link do
    GenServer.start_link(__MODULE__, :ok, [])
  end

  # Server APIs.
  def init(:ok) do
    {:ok, []}
  end
end
