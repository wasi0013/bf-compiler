defmodule Bfc.CLI do
  @moduledoc """
  Handle the command line parsing and the dispatch to the various functions
  """
  def main(argv) do
    argv
    |> parse_args
    |> process

  end

  def process(:help) do
    IO.puts """
    usage: bfc "/path/to/bf/code.bf" 
    """
    System.halt(0)
  end
  
  def process(file_path) do
    Bfc.Compiler.compile(file_path)
  end


  @doc """
  `argv` can be a file path or -h / --help which returns :help.
  """
  def parse_args(argv) do
    OptionParser.parse(argv, switches: [help: :boolean], aliases: [h: :help])
    |> elem(1)
    |> process_args
  end

  def process_args([file_path]) do
    file_path
  end

  def process_args(_) do
    :help
  end

end
