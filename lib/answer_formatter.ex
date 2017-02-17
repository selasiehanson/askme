defmodule Askme.AnswerFormatter do

  def format_answers(answers \\ []) do
    formatted = answers
    |> (Enum.map fn a -> "#{a.position}. #{a.text}" end)
    |> Enum.join("\n")
    formatted
  end
end
