defmodule NauticNetInterop.MixProject do
  use Mix.Project

  def project do
    [
      app: :nautic_net_protobuf,
      version: "0.1.0",
      elixir: "~> 1.13",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger, :crypto]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      # Telemetry transport
      {:protobuf, "~> 0.16"}
    ]
  end
end
