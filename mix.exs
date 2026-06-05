defmodule Mnth.MixProject do
  use Mix.Project

  def project do
    [
      app: :mnth,
      escript: escript(),
      version: "0.1.0",
      elixir: "~> 1.18",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: []
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:color, "~> 0.13.0"},
      {:optimus, "~> 0.6.1"}
    ]
  end

  defp escript do
    [
      main_module: Mnth.CLI
    ]
  end
end
