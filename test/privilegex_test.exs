defmodule PrivilegexTest do
  use ExUnit.Case
  doctest Privilegex

  setup do
    user_name = String.strip(elem(System.cmd("whoami", []), 0))
    group_name = String.strip(elem(System.cmd("id", ["-gn"]), 0))

    {:ok, %{user_name: user_name, group_name: group_name}}
  end

  test "#getuid" do
    assert {:ok, _} = Privilegex.getuid
  end

  test "#getgid" do
    assert {:ok, _} = Privilegex.getgid
  end

  test "#getpwnam", %{user_name: user_name} do
    assert {:ok, %{gecos: _, gid: _, name: _, passwd: _, uid: _}} = Privilegex.getpwnam(user_name)
  end

  test "#getgrnam", %{group_name: group_name} do
    assert {:ok, %{gid: _, name: _, passwd: _}} = Privilegex.getgrnam(group_name)
  end

  test "#change", %{user_name: user_name, group_name: group_name} do
    assert :ok = Privilegex.change(user_name, group_name)
  end
end
