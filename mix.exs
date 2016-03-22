defmodule Snapshot.Mixfile do
  use Mix.Project

  def project do
    [ app: :snapshot,
      version: "0.0.1",
      description: "",
      source_url: "",
      homepage_url: "",
      package: package,
      deps: deps,
      docs: [
        readme: true,
        main: "README"
      ]
    ]
  end

  # Configuration for the OTP application
  def application do
    [
      mod: { Snapshot, []},
      applications: [ :httpotion, :cowboy, :hound, :plug ]
    ]
  end

  # Returns the list of dependencies in the format:
  # { :foobar, "0.1", git: "https://github.com/elixir-lang/foobar.git" }
  defp deps do
    [
      {:ibrowse, github: "cmullaparthi/ibrowse", tag: "v4.1.2", override: true},
      {:httpotion, "~> 2.1"},
      {:floki, "~> 0.7.2"},
      {:hound, "~> 0.8"},
      {:cowboy, "~> 1.0.4"},
      {:plug, "~> 1.1.2"}
     ]
  end

  defp package do
    [
      contributors: ["Chase McCarthy"],
      licenses: [],
      links: %{"GitHub" => "",
               "Docs" => ""}
    ]
  end
end
