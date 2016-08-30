defmodule PrivilegexTest do
  use ExUnit.Case
  doctest Privilegex

  test "#getuid" do
    assert {:ok, _} = Privilegex.getuid
  end

  test "#getgid" do
    assert {:ok, _} = Privilegex.getgid
  end

  test "#getpwnam" do
    user_name = String.strip(elem(System.cmd("whoami", []), 0))

    assert {:ok, %{gecos: _, gid: _, name: _, passwd: _, uid: _}} = Privilegex.getpwnam(user_name)
  end
end
