defmodule Privilegex do
  @moduledoc false

  @on_load :load_nifs

  @doc false
  def load_nifs do
    path = :filename.join(:code.priv_dir(:privilegex), 'privilegex')
    :erlang.load_nif(path, 0)
  end

  @doc "Return current process owner user id"
  @spec getuid :: {atom, Integer.t}
  def getuid, do: raise "NIF getuid/0 not implemented"

  @doc "Set current process owner user id"
  @spec setuid(Integer.t) :: atom
  def setuid(_uid), do: raise "NIF setuid/1 not implemented"

  @doc "Return current process owner group id"
  @spec getuid :: {atom, Integer.t}
  def getgid, do: raise "NIF getgid/0 not implemented"

  @doc "Set current process owner group id"
  @spec setgid(Integer.t) :: atom
  def setgid(_gid), do: raise "NIF setgid/1 not implemented"

  @doc "Return system user map by user name"
  @spec getpwnam(String.t) :: {atom, Map.t}
  def getpwnam(_user_name), do: raise "NIF getpwnam/1 not implemented"

  @doc "Return system group map by group name"
  @spec getgrnam(String.t) :: {atom, Map.t}
  def getgrnam(_group_name), do: raise "NIF getgrnam/1 not implemented"

  @doc "Change process privilege to given user name with same group name"
  @spec change(String.t) :: atom
  def change(user_name), do: change(user_name, user_name)

  @doc "Change process privilege to given user name with group name"
  @spec change(String.t, String.t) :: atom
  def change(user_name, group_name) do
    {:ok, %{uid: uid}} = getpwnam(user_name)
    {:ok, %{gid: gid}} = getgrnam(group_name)

    :ok = setuid uid
    :ok = setgid gid

    :ok
  end
end
