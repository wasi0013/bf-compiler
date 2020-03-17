defmodule CompilerTest do
  use ExUnit.Case
  doctest Bfc.Compiler
  import Bfc.Compiler

  test "clean bf code" do
    assert clean("+ - [ ] , . < > AA?") == "+-[],.<>"
  end

  test "evaluate empty string" do
    assert evaluate("", 0, [0], "") == {0, [0], ""}
  end

  test "Increment operation" do
    assert evaluate("+++", 0, [0], "") == {0, [3], ""}
  end

  test "decrement operation" do
    assert evaluate("---", 0, [3], "") == {0, [0], ""}
  end

  test "left shift operation" do
    assert evaluate("<<", 2, [0, 0, 0], "") == {0, [0, 0, 0], ""}
  end

  test "right shift operation" do
    assert evaluate(">>>", 0, [0], "") == {3, [0, 0, 0, 0], ""}
  end

  test "output operation" do
    assert evaluate(".", 0, [65], "") == {0, [65], "A"}
  end

  test "loop operation" do
    assert evaluate("++++[-]", 0, [0], "") == {0, [0], ""}
  end
end
