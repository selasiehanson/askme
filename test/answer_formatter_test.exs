defmodule Askme.AnswerFormatterTest do
  use ExUnit.Case

  test "" do
    answers = [
      %Askme.Answer{position: 1, text: "True"},
      %Askme.Answer{position: 2, text: "False"}
    ]

  result = """
  1. True
  2. False
  """

  assert Askme.AnswerFormatter.format_answers(answers) == result
  end

end
