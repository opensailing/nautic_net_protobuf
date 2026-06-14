# RacingOrg.Tracker.Protobuf

Shared protobuf definitions and Elixir modules for RacingOrg Tracker wire
payloads.

This package contains the schema contracts for telemetry data sets, LoRa packets,
device commands, and race manifests. The generated Elixir modules are checked in
so consuming projects can use the package without running `protoc`.

## Package

- Mix app: `:racing_org_tracker_protobuf`
- Elixir namespace: `RacingOrg.Tracker.Protobuf`
- Proto files: `lib/racing_org/tracker/protobuf/*.proto`
- Generated Elixir files: `lib/racing_org/tracker/protobuf/*.pb.ex`

## Setup

```sh
mix deps.get

# Required when changing .proto files
brew install protobuf
mix escript.install hex protobuf 0.17.0
asdf reshim

# Check installation
protoc --version
protoc-gen-elixir --version
```

Full install directions [here](https://grpc.io/docs/protoc-installation/) and [here](https://github.com/elixir-protobuf/protobuf)

## Usage

```elixir
alias RacingOrg.Tracker.Protobuf
alias RacingOrg.Tracker.Protobuf.{DataSet, LoRaPacket}

data_set = Protobuf.new_data_set([], counter: 1, ref: "example")
encoded_data_set = DataSet.encode(data_set)

packet =
  "0D55BC15F512120DB674274215634190C220F40128FC0C3001"
  |> Base.decode16!()
  |> LoRaPacket.decode()
```

## Development

Run the test suite:

```sh
mix test
```

## Updating Definitions

Before changing any message type, read the
[proto3 rules for updating message types](https://developers.google.com/protocol-buffers/docs/proto3#updating).
Field numbers are part of the wire contract and must not be reused.

Do not manually edit generated `.pb.ex` files. Change the `.proto` files, then
regenerate the Elixir modules:

```sh
./generate_ex.sh
mix test
```

The generator emits modules with the `RacingOrg.Tracker.Protobuf` package prefix
and writes them back into `lib/racing_org/tracker/protobuf/`.

After merging a schema change, update dependent projects:

```sh
mix deps.update racing_org_tracker_protobuf
```
