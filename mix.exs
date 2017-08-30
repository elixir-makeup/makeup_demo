defmodule MakeupDemo.Mixfile do
  use Mix.Project

  def project do
    [
      app: :makeup_demo,
      version: "0.1.0",
      elixir: "~> 1.5-rc",
      start_permanent: Mix.env == :prod,
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
      {:makeup, "~> 0.2.0"},
      {:makeup_elixir, "~> 0.2.0"},
      {:makeup_html5, "~> 0.2.0"},
      #{:ex_doc, path: "../ex_doc", only: :dev, runtime: false}
    ]
  end
end
