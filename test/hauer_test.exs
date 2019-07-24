defmodule HauerTest do
  use ExUnit.Case
  doctest Hauer

  test "greets the world" do
    assert Hauer.hello() == :world
  end
end
