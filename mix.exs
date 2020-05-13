defmodule IdSet.MixProject do
  use Mix.Project

  def project do
    [
      app: :id_set,
      version: "0.1.0",
      elixir: "~> 1.10",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      aliases: aliases(),
      preferred_cli_env: [
        ci: :test
      ],
      name: "IdSet",
      description: "An IdSet allows you to manage lists containing structs uniquely by id",
      source_url: "https://github.com/kidbombay/id_set",
      package: [
        maintainers: ["Ketan Anjaria"],
        licenses: ["MIT"],
        links: %{"GitHub" => "https://github.com/kidbombay/id_set"}
      ],

      # Dialyzer
      dialyzer: [
        plt_add_apps: [:ex_unit],
        plt_core_path: "_build/#{Mix.env()}",
        flags: [:error_handling, :race_conditions, :underspecs]
      ],

      # Docs
      docs: [
        # The main page in the docs
        main: "IdSet",
        extras: ["README.md"],
        canonical: "http://hexdocs.pm/id_set"
      ]
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:ex_doc, "~> 0.21", only: :dev, runtime: false},
      {:credo, "~> 1.0", only: [:test, :dev], runtime: false},
      {:dialyxir, "~> 1.0", only: [:test, :dev], runtime: false}
    ]
  end

  defp aliases do
    [
      ci: [
        "format --check-formatted",
        "credo --strict",
        "test --raise"
        # "dialyzer --halt-exit-status"
      ]
    ]
  end
end
