defmodule Askme.IdStore do
  use GenServer

  def setup() do
    {:ok, pid}  = GenServer.start_link(__MODULE__, %{}, name: __MODULE__)
  end

  def add_player(player_id, game_id) do
    GenServer.call(__MODULE__, {:add_player, player_id, game_id})
  end

  def get_players_game(player_id) do
    GenServer.call __MODULE__, {:get_game_id, player_id}
  end

  def end_player_session(player_id) do
    GenServer.call __MODULE__, {:end_game, player_id}
  end

  def handle_call({:add_player, player_id, game_id}, _from, store) do
    if(Map.has_key?(store, player_id)) do
      {:reply, :player_in_game}
    else
      new_store = Map.put(store, player_id, game_id)
      {:reply, :ok, new_store}
    end
  end

  def handle_call({:get_game_id, player_id}, _from, store) do
    game_id = Map.fetch(store, player_id)
    {:reply, game_id, store}
  end

  def handle_call({:end_game, player_id}, _from, store) do
    if(Map.has_key?(store, player_id)) do
      new_store =  Map.delete(store, player_id)
      {:reply, :ok, new_store}
    else
      {:reply, :player_not_in_game}
    end
  end
end
