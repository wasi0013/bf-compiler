defmodule BfcTest do
  use ExUnit.Case
  doctest Bfc

  test "greets the world" do
    assert Bfc.hello() == :world
  end
end
