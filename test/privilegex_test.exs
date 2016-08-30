defmodule PrivilegexTest do
  use ExUnit.Case
  doctest Privilegex

  test "#getuid" do
    assert Privilegex.getuid != 0
  end

  test "#getgid" do
    assert Privilegex.getgid != 0
  end
end
