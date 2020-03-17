defmodule Bfc.Compiler do
  @moduledoc """
  Brainfuck Compiler
  """

  def compile(filepath) do
    {_, _, output} = read_file(filepath)
    IO.puts(output)
  end

  def read_file(filepath) do
    case File.read(filepath) do
      {:ok, body} -> execute(body)
      {:error, reason} -> IO.warn("ERROR (#{reason}): #{filepath} not found.")
    end
  end

  def execute(code) do
    code
    |> clean
    |> evaluate(0, [0], "")
  end

  def clean(code) do
    code
    |> String.to_charlist()
    |> Enum.filter(fn char -> Enum.member?([?., ?,, ?[, ?], ?<, ?>, ?+, ?-], char) end)
    |> List.to_string()
  end

  def evaluate("", pointer, memory, output) do
    {pointer, memory, output}
  end

  def evaluate("+" <> code, pointer, memory, output) do
    evaluate(code, pointer, memory |> List.update_at(pointer, &(&1 + 1)), output)
  end

  def evaluate("-" <> code, pointer, memory, output) do
    evaluate(code, pointer, memory |> List.update_at(pointer, &(&1 - 1)), output)
  end

  def evaluate(">" <> code, pointer, memory, output) when pointer + 1 < length(memory) do
    evaluate(code, pointer + 1, memory, output)
  end

  def evaluate(">" <> code, pointer, memory, output) do
    evaluate(code, pointer + 1, memory ++ [0], output)
  end

  def evaluate("<" <> code, pointer, memory, output) when pointer - 1 >= 0 do
    evaluate(code, pointer - 1, memory, output)
  end

  def evaluate("." <> code, pointer, memory, output) do
    evaluate(code, pointer, memory, output <> to_string([Enum.at(memory, pointer)]))
  end

  def evaluate("[" <> code, pointer, memory, output) do
    case Enum.at(memory, pointer) do
      0 ->
        # run on the rest of the code 
        evaluate(code |> skip_loop, pointer, memory, output)

      _ ->
        # evaluate loop body including nested loop if any
        {pointer, memory, output} = evaluate(code |> run_loop, pointer, memory, output)
        # start the loop again
        evaluate("[" <> code, pointer, memory, output)
    end
  end

  defp skip_loop(code) do
    String.slice(code, find_loop(code)..-1)
  end

  defp run_loop(code) do
    String.slice(code, 0..(find_loop(code) - 2))
  end

  defp find_loop(code) do
    count =
      Enum.reduce(String.to_charlist(code), [1, 0], fn char, acc ->
        if Enum.at(acc, 0) != 0 do
          case char do
            ?[ ->
              acc
              |> List.replace_at(0, Enum.at(acc, 0) + 1)
              |> List.replace_at(1, Enum.at(acc, 1) + 1)

            ?] ->
              acc
              |> List.replace_at(0, Enum.at(acc, 0) - 1)
              |> List.replace_at(1, Enum.at(acc, 1) + 1)

            _ ->
              acc
              |> List.replace_at(1, Enum.at(acc, 1) + 1)
          end
        else
          acc
        end
      end)

    if Enum.at(count, 0) != 0 do
      raise RuntimeError, "Braces mismatch"
    end

    Enum.at(count, 1)
  end
end
