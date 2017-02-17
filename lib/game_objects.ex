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
  game_state: :not_started | :started | :game_over
  """
  defstruct title: "", questions: [], score: 0, players: [], game_mode: "",
            answers: [], game_state: ""
end
