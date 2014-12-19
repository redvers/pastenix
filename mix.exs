defmodule Pastenix.Mixfile do
  use Mix.Project

  def project do
    [app: :pastenix,
     version: "0.0.1",
     elixir: "~> 1.0",
     elixirc_paths: ["lib", "web"],
     compilers: [:phoenix] ++ Mix.compilers,
     deps: deps]
  end

  # Configuration for the OTP application
  #
  # Type `mix help compile.app` for more information
  def application do
    [mod: {Pastenix, []},
     applications: [:phoenix, :cowboy, :logger, :amnesia]]
  end

  # Specifies your project dependencies
  #
  # Type `mix help deps` for examples and options
  defp deps do
    [{:phoenix, "~> 0.7.2"},
     {:amnesia, git: "https://github.com/meh/amnesia.git"},
     {:timex, "~> 0.13.2"},
     {:uuid, "~> 0.1.5"},
     {:ex_doc, "~> 0.6", only: :docs},
     {:inch_ex, "~> 0.2", only: :docs},
     {:cowboy, "~> 1.0"}]
  end
end
