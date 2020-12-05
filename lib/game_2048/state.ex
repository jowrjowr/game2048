defmodule Game2048.State do
  use GenServer

  def start_link(_) do
    {:ok, pid} = GenServer.start_link(__MODULE__, [])

    {:ok, pid}
  end

  def init(init_arg) do
    # build out the ETS that will contain the game state

    :ets.new(:game, [:set, :public, :named_table])
    {:ok, init_arg}
  end

end
