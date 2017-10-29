defmodule CldrTerritories.Mixfile do
  use Mix.Project

  @version "0.0.1"

  def project do
    [
      app: :ex_cldr_territories,
      version: @version,
      elixir: "~> 1.5",
      name: "Cldr_Territories",
      source_url: "https://github.com/schultzer/cldr_territories",
      description: description(),
      package: package(),
      docs: docs(),
      start_permanent: Mix.env == :prod,
      deps: deps()
    ]
  end

  defp description do
    """
    Terrritory formatting functions for the Common Locale Data Repository (CLDR)
    package ex_cldr
    """
  end


  def application do
    [
      extra_applications: [:logger]
    ]
  end

  defp deps do
    [
      {:ex_cldr, "~> 0.8.1"},
      {:ex_doc, ">= 0.18.1", only: :dev}
    ]
  end

  defp package do
    [
      maintainers: ["Benjamin Schultzer"],
      licenses: ["MIT"],
      links: links(),
      files: [
        "lib", "config", "mix.exs", "README*", "CHANGELOG*", "LICENSE*"
      ]
    ]
  end

  def docs do
    [
      source_ref: "v#{@version}",
      main: "readme",
      extras: ["README.md", "CHANGELOG.md"]
    ]
  end

  def links do
    %{
      "GitHub"    => "https://github.com/schultzer/cldr_territories",
      "Readme"    => "https://github.com/schultzer/cldr_territories/blob/v#{@version}/README.md",
      "Changelog" => "https://github.com/schultzer/cldr_territories/blob/v#{@version}/CHANGELOG.md"
    }
  end

end
