defmodule Bfc.Compiler do
  @moduledoc """
  Brainfuck Compiler
  """

  def compile(filepath) do
    read_file(filepath)
  end

  def read_file(filepath) do
    case File.read(filepath) do
      {:ok, body} -> execute(body)
      {:error, reason} -> IO.warn("ERROR (#{reason}): #{filepath} not found.")
    end
  end

  def execute(code) do
    clean(code)
    evaluate(code, 0, [0], "")
  end

  def clean(code) do
    code
    |> String.to_charlist()
    |> Enum.filter(fn char -> Enum.member?([?., ?,, ?[, ?], ?<, ?>, ?+, ?-], char) end)
  end

  def evaluate("", pointer, memory, output) do
    {pointer, memory, output}
  end

  def evaluate("+"<>code, pointer, memory, output) do
    evaluate(code, pointer, memory |> List.update_at(pointer, &(&1 + 1)) , output)
  end

  def evaluate("-"<>code, pointer, memory, output) do
    evaluate(code, pointer, memory |> List.update_at(pointer, &(&1 - 1)) , output)
  end

  def evaluate(">"<>code, pointer, memory, output) do
    evaluate(code, pointer+1, memory, output)
  end
  def evaluate("<"<>code, pointer, memory, output) do
    evaluate(code, pointer-1, memory, output)
  end
  def evaluate("."<>code, pointer, memory, output) do
    evaluate(code, pointer, memory, output<>to_string([Enum.at(memory, pointer)]))
  end

end
