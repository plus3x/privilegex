defmodule Setuid do
  @on_load :load_nifs

  def load_nifs, do: :erlang.load_nif('./priv/setuid', 0)

  def getuid,       do: raise "NIF getuid/0 not implemented"
  def setuid(_uid), do: raise "NIF setuid/1 not implemented"
  def getgid,       do: raise "NIF getgid/0 not implemented"
  def setgid(_gid), do: raise "NIF setgid/1 not implemented"
end
