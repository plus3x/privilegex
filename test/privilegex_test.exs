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

  test "#getgrnam" do
    group_name = String.strip(elem(System.cmd("id", ["-gn"]), 0))

    assert {:ok, %{gid: _, name: _, passwd: _}} = Privilegex.getgrnam(group_name)
  end
end
