defmodule Privilegex do
  @on_load :load_nifs

  def load_nifs do
    path = :filename.join(:code.priv_dir(:privilegex), 'privilegex')
    :erlang.load_nif(path, 0)
  end

  def getuid,                do: raise "NIF getuid/0 not implemented"
  def setuid(_uid),          do: raise "NIF setuid/1 not implemented"
  def getgid,                do: raise "NIF getgid/0 not implemented"
  def setgid(_gid),          do: raise "NIF setgid/1 not implemented"
  def getpwnam(_user_name),  do: raise "NIF getpwnam/1 not implemented"
  def getgrnam(_group_name), do: raise "NIF getgrnam/1 not implemented"

  def change(user_name), do: change(user_name, user_name)
  def change(user_name, group_name) do
    {:ok, %{uid: uid}} = getpwnam(user_name)
    {:ok, %{gid: gid}} = getgrnam(group_name)

    :ok = setuid uid
    :ok = setgid gid

    :ok
  end
end
