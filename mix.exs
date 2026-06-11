defmodule RagingOrgTrackerProtobuf.MixProject do
  use Mix.Project

  def project do
    [
      app: :raging_org_tracker_protobuf,
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
      {:protobuf, "~> 0.17"}
    ]
  end
end
