defmodule Mix.Tasks.Compile.Setuid do
  def run(_) do
    File.rm_rf! "priv"
    File.mkdir "priv"

    {result, _errcode} = System.cmd("make", [])

    IO.binwrite(result)
  end
end

defmodule Setuid.Mixfile do
  use Mix.Project

  @version "0.1.0"

  @description """
  OS module extention for setting and getting uid/gid
  """

  def project do
    [app: :setuid,
     name: "Setuid",
     version: @version,
     compilers: [:setuid] ++ Mix.compilers,
     elixir: "~> 1.3",
     description: @description,
     package: package,
     deps: deps,
     source_url: "https://github.com/plus3x/setuid",
     homepage_url: "https://github.com/plus3x/setuid"]
  end

  def application do
    [applications: [:logger]]
  end

  defp deps do
    [{:credo, "~> 0.4", only: [:dev, :test]}]
  end

  defp package do
    [maintainers: ["Vladislav Petrov"],
     licenses: ["MIT"],
     links: %{github: "https://github.com/plus3x/setuid"},
     files: ~w(lib priv web LICENSE.md mix.exs README.md)]
  end
end
