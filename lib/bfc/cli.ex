defmodule Bfc.CLI do
  @moduledoc """
  Handle the command line parsing and the dispatch to the various functions
  """
  def run(argv) do
    parse_args(argv)
  end

  @doc """
  `argv` can be -h or --help which returns :help.
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
