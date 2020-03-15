defmodule CompilerTest do
  use ExUnit.Case
  import Bfc.Compiler

  test "clean bf code" do
    assert clean("+ - [ ] , . < > AA?") == '+-[],.<>'
  end

  test "evaluate empty string" do
    assert evaluate("", 0, [0], "") == {0, [0], ""}
  end
end
