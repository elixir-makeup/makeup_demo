defmodule MakeupDemo.Mixfile do
  use Mix.Project

  def project do
    [
      app: :makeup_demo,
      version: "0.1.0",
      elixir: "~> 1.5-rc",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      docs: [extras: ["README.md"]]
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger, :makeup]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:makeup, "~> 1.1"},
      {:makeup_elixir, "~> 0.16"},
      {:makeup_html, "~> 0.1"},
      {:makeup_erlang, "~> 0.1"},
      {:makeup_c, "~> 0.1"},
      {:makeup_diff, "~> 0.1"},
      {:makeup_eex, "~> 0.1"},
      {:makeup_json, "~> 0.1"}
    ]
  end
end
