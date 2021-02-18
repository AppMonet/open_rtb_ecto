defmodule OpenRtbEcto.MixProject do
  use Mix.Project

  @name "OpenRtbEcto"
  @version "0.1.1"
  @repo_url "https://github.com/AppMonet/open_rtb_ecto"

  def project do
    [
      app: :open_rtb_ecto,
      version: @version,
      elixir: "~> 1.7",
      description: "OpenRTB 2.5 Ecto schemas",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      elixirc_paths: elixirc_paths(Mix.env()),
      package: package(),
      docs: docs(),
      name: @name,
      source_url: @repo_url
    ]
  end

  defp elixirc_paths(:test), do: ["test/support", "lib"]
  defp elixirc_paths(_), do: ["lib"]

  def application do
    [
      extra_applications: [:logger]
    ]
  end

  defp deps do
    [
      {:ecto, "~> 3.0"},
      {:jason, "~> 1.1"},
      {:ex_doc, "~> 0.19", only: :dev, runtime: false}
    ]
  end

  def package do
    [
      licenses: ["MIT"],
      links: %{"GitHub" => @repo_url}
    ]
  end

  def docs do
    [
      source_ref: "v#{@version}",
      source_url: @repo_url,
      main: @name
    ]
  end
end
