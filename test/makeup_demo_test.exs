defmodule MakeupDemoTest do
  use ExUnit.Case
  doctest MakeupDemo

  test "greets the world" do
    assert MakeupDemo.hello() == :world
  end
end
