defmodule Askme.GameLibrary do  
  use GenServer

  def start_link do 
    store = %{}
    games = Askme.GameLoader.all_games
            |> Enum.into(%{}, fn game -> {game.title, game } end)

    {:ok, pid } = GenServer.start_link(__MODULE__, games, name: __MODULE__)
  end

  def list_games  do  
    GenServer.call __MODULE__, :list_games
  end

  def handle_call(:list_games, _from, state) do
    games = Map.keys state
    {:reply, games, state} 
  end
end
