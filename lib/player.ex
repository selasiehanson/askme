defmodule Askme.Player do
  defstruct name: "", games_played: [], state: ""
end

defmodule Askme.Answer do
  defstruct position: 0, text: ""
end

defmodule Askme.PlayerAnswer do
  defstruct position: 1
end

defmodule Askme.Question do 
  defstruct id: 0, text: "", possible_answers: [], answer_position: 0
end

defmodule Askme.Quizz do
  defstruct questions: []
end

defmodule Askme.Game do

  @doc """
  game_mode: :single_play | :double_play
  game_state: :started | :over
  """
  defstruct title: "", questions: [], score: 0, players: [], game_mode: "",
            answers: [], game_state: ""
end


defmodule Askme.GameManager do
  use GenServer

  def start_game(game_id) do

    game = %Askme.Game {
      title: "Basic Maths",
      questions: get_questions(),
      score: 0,
      game_mode: :single_player,
      answers: [],
      game_state: :started
    }

    {:ok, pid } = GenServer.start_link(__MODULE__, game, name: game_id)
  end

  def save_answer(answer_position) do

  end

  def next do

  end

  defp next_screen() do

  end

  def get_questions do
    q1 = %Askme.Question{
      text: "1 + 1 = 3",
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
      text: "3x + 5 = 11. The value of x is ?",
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
    |> Enum.map fn {x, y} ->  Map.put(x, :id, y) end
  end

end