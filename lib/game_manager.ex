
defmodule Askme.GameManager do
  use GenServer

  def setup(game_id) do

    game = %Askme.Game {
      title: "Basic Maths",
      questions: [],
      score: 0,
      game_mode: :single_player,
      answers: [],
      game_state: :not_started,
      expects_answer: false
    }

    {:ok, pid } = GenServer.start_link(__MODULE__, game, name: game_id)
  end

  # Public Api

  def load_game(game_id, questions) do 

    GenServer.call game_id, {:load, questions}
  end

  def start_game(game_id) do
    GenServer.call game_id, :start_game
  end

  def save_answer(answer_position) do

  end

  def next(game_id, previous_input) do
    GenServer.call game_id, {:next_screen, previous_input}
  end

  def handle_call({:load_game, questions}, _from, game) do 
    new_game = Map.put(game, :questions, questions)
    {:reply, {:ok, true}, new_game }
  end

  @doc """
  Starts the game
  """
  def handle_call(:start_game, _from, game) do
    game_state = :started
    # modified_game = Map.put(game ,:game_state, game_state)
    modified_game = %Askme.Game{game | game_state: game_state}
    {:reply, {"Welcome to #{game.title}", game_state}, modified_game }
  end

  def handle_call({:next_screen, previous_input}, _from, game) do
    %{questions: qs, game_state: game_state, current_question: current_question,
      answers: answers, expects_answer: expects_answer} = game

    modified_answers = retrieve_ans(expects_answer, current_question, previous_input, answers)

    {result, new_questions ,new_game_state} =  next_screen qs, game_state

    game = %Askme.Game{ game | game_state: new_game_state,
                               questions: new_questions,
                               current_question: result,
                               expects_answer: true ,
                               answers: modified_answers}
    IO.inspect game
    {:reply, {result, new_game_state}, game}
  end

  defp retrieve_ans(true, current_question, input, previous_answers) do
    answer = {current_question.id, current_question.answer_position, input}
    previous_answers ++ [answer]
  end

  defp retrieve_ans(false, _, _, answers) do
    answers
  end

  defp next_screen([head | tail], game_state) do
    {head, tail,game_state}
  end

  defp next_screen([], game_state) do
    # game is over
    {"You win", [],:game_over}
  end

  defp calulate_score do
    0
  end

  defp get_questions do
    q1 = %Askme.Question{
      text: "1 + 1 = 3. \nDo you agree?",
      possible_answers: [
        %Askme.Answer{position: 1, text: "True"},
        %Askme.Answer{position: 2, text: "False"}
      ],
      answer_position: 2
    }

    q2 = %Askme.Question{
      text: "11 + 21 = ?",
      possible_answers: [
        %Askme.Answer{position: 1, text: "20"},
        %Askme.Answer{position: 2, text: "21"},
        %Askme.Answer{position: 3, text: "22"},
        %Askme.Answer{position: 4, text: "23"},
        %Askme.Answer{position: 5, text: "None of the above"}
      ],
      answer_position: 2
    }

    q3 = %Askme.Question{
      text: "3x + 5 = 11. \nThe value of x is ?",
      possible_answers: [
        %Askme.Answer{position: 1, text: "10"},
        %Askme.Answer{position: 2, text: "2"},
        %Askme.Answer{position: 3, text: "3"},
        %Askme.Answer{position: 4, text: "1"},
        %Askme.Answer{position: 5, text: "None of the above"}
      ],
      answer_position: 2
    }

    [q1,q2,q3]
    |> Enum.with_index( 1)
    |> Enum.map fn {x, y} -> Map.put(x, :id, y) end
  end

end
