defmodule MakeupDemo.Mixfile do
  use Mix.Project

  def project do
    [
      app: :makeup_demo,
      version: "0.1.0",
      elixir: "~> 1.5-rc",
      start_permanent: Mix.env == :prod,
      deps: deps()
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
      {:makeup, path: "../makeup"}
    ]
  end
end
