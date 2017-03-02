defmodule Askme.GameLoader do 

  @game_path  "lib/games/"

  def load(game) do 
    game_path = @game_path <> game
    case File.read(game_path)  do
      {:ok, body } -> 
        Poison.decode(body, as: %Askme.Game{})
      {:error, reason } ->
        IO.puts reason
        {:error, nil }
    end
  end

  def all_games do
   case File.ls  ("./" <> @game_path ) do 
     {:ok, list} ->
        IO.puts  list
        list
        |> Enum.map fn game -> 
          {:ok, content } = load(game) 
          content
        end

      _ ->
   end
  end
end
