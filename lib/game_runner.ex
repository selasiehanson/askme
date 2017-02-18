defmodule Askme.GameRunner do

  alias Askme.GameManager

  use GenServer

  def play do
    # do setup things
    Askme.IdStore.setup

    IO.puts("Welcome to Ask Me\n")
    name = IO.gets("what is your name\n")

    IO.puts "Welcome #{name}!!!, Let's play"
    player_id = String.to_atom UUID.uuid4()

    %Askme.Player {name: name, id: player_id}

    # generate game id for player
    game_id = generate_game_id()

    # store game_id of player in id server
    Askme.IdStore.add_player(player_id, game_id)

    GameManager.setup(game_id)
    {result, game_state} = GameManager.start_game(game_id)
    IO.puts result
    IO.gets "Press Enter to begin...\n"
    run(game_id, game_state, "", "")
  end

  defp generate_game_id do
    String.to_atom UUID.uuid4
  end

  defp run(game_id, :started, _, input) do
    {next_question, game_state} = GameManager.next(game_id, input)
    next_display_string = extract_display(next_question)
    new_input = next_item(next_display_string, game_state)
    run(game_id, game_state, next_display_string, new_input)
  end

  defp run(game_id, :game_over, response, input) do
    IO.puts response
  end

  defp extract_display(%Askme.Question{text: text, possible_answers: possible_answers})  do
    text <> "\n" <> Askme.AnswerFormatter.format_answers(possible_answers) <> "\n"
  end

  defp extract_display(text)  do
    text
  end

  defp next_item(text, :started) do
    IO.puts  "\n" <> text
    IO.gets ("\nSelect a choice: ")
  end

  defp next_item(text, :game_over) do
    IO.puts text
  end

end
