defmodule NauticNet.Protobuf.LoRaPacket do
  @moduledoc false

  use Protobuf, syntax: :proto3, protoc_gen_elixir_version: "0.12.0"

  oneof(:payload, 0)

  field(:hardware_id, 1, type: :fixed32, json_name: "hardwareId")
  field(:serial_number, 5, type: :uint32, json_name: "serialNumber")
  field(:rover_data, 2, type: NauticNet.Protobuf.RoverData, json_name: "roverData", oneof: 0)

  field(:rover_discovery, 3,
    type: NauticNet.Protobuf.RoverDiscovery,
    json_name: "roverDiscovery",
    oneof: 0
  )

  field(:rover_configuration, 4,
    type: NauticNet.Protobuf.RoverConfiguration,
    json_name: "roverConfiguration",
    oneof: 0
  )

  field(:rover_reset, 6, type: NauticNet.Protobuf.RoverReset, json_name: "roverReset", oneof: 0)
end

defmodule NauticNet.Protobuf.RoverData do
  @moduledoc false

  use Protobuf, syntax: :proto3, protoc_gen_elixir_version: "0.12.0"

  field(:latitude, 1, type: :float)
  field(:longitude, 2, type: :float)
  field(:heading, 3, type: :uint32)
  field(:heel, 4, type: :uint32)
  field(:cog, 5, type: :uint32)
  field(:sog, 6, type: :uint32)
  field(:battery, 7, type: :uint32)
end

defmodule NauticNet.Protobuf.RoverDiscovery do
  @moduledoc false

  use Protobuf, syntax: :proto3, protoc_gen_elixir_version: "0.12.0"
end

defmodule NauticNet.Protobuf.RoverConfiguration do
  @moduledoc false

  use Protobuf, syntax: :proto3, protoc_gen_elixir_version: "0.12.0"

  field(:slots, 1, repeated: true, type: :int32)
  field(:sbw, 2, type: :uint32)
  field(:sf, 3, type: :uint32)
end

defmodule NauticNet.Protobuf.RoverReset do
  @moduledoc false

  use Protobuf, syntax: :proto3, protoc_gen_elixir_version: "0.12.0"
end
