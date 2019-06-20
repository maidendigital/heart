defmodule HeartTest do
  use ExUnit.Case
  doctest Heart

  test "greets the world" do
    assert Heart.hello() == :world
  end
end
