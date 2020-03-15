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
    evaluate("", 0, [0], "")
  end

  def clean(code) do
    code
    |> String.to_charlist()
    |> Enum.filter(fn char -> Enum.member?([?., ?,, ?[, ?], ?<, ?>, ?+, ?-], char) end)
  end

  def evaluate("", pointer, memory, output) do
    {pointer, memory, output}
  end
end
