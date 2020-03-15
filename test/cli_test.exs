defmodule CliTest do
  use ExUnit.Case
  doctest Bfc.CLI

  import Bfc.CLI, only: [parse_args: 1]

  test ":help returned by option parsing with -h and --help options" do
    assert parse_args(["test/file.bf"]) == "test/file.bf"
    assert parse_args(["-h"]) == :help
    assert parse_args(["--help"]) == :help
  end
end
