defmodule Setuid.Mixfile do
  use Mix.Project

  def project do
    [app: :setuid,
     name: "Setuid",
     version: "0.1.0",
     elixir: "~> 1.3",
     description: description,
     package: package,
     deps: deps,
     source_url: "https://github.com/plus3x/setuid",
     homepage_url: "https://github.com/plus3x/setuid"]
  end

  def application do
    [applications: [:logger]]
  end

  defp description do
    """
    OS module extention for setting and getting uid/gid
    """
  end

  defp deps do
    []
  end

  defp package do
    [maintainers: ["Vladislav Petrov"],
     licenses: ["MIT"],
     links: %{github: "https://github.com/plus3x/setuid"},
     files: ~w(lib priv web LICENSE.md mix.exs README.md)]
  end
end
