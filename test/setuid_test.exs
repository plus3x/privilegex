defmodule SetuidTest do
  use ExUnit.Case
  doctest Setuid

  test "#getuid" do
    assert Setuid.getuid != 0
  end

  test "#getgid" do
    assert Setuid.getgid != 0
  end
end
