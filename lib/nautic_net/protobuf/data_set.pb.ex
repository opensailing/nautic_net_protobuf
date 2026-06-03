defmodule NauticNet.Protobuf.AngleReference do
  @moduledoc false

  use Protobuf, enum: true, syntax: :proto3, protoc_gen_elixir_version: "0.12.0"

  field(:ANGLE_REFERENCE_NONE, 0)
  field(:ANGLE_REFERENCE_TRUE_NORTH, 1)
  field(:ANGLE_REFERENCE_MAGNETIC_MORTH, 2)
end

defmodule NauticNet.Protobuf.SpeedReference do
  @moduledoc false

  use Protobuf, enum: true, syntax: :proto3, protoc_gen_elixir_version: "0.12.0"

  field(:SPEED_REFERENCE_NONE, 0)
  field(:SPEED_REFERENCE_GROUND, 1)
  field(:SPEED_REFERENCE_WATER, 2)
end

defmodule NauticNet.Protobuf.WindReference do
  @moduledoc false

  use Protobuf, enum: true, syntax: :proto3, protoc_gen_elixir_version: "0.12.0"

  field(:WIND_REFERENCE_NONE, 0)
  field(:WIND_REFERENCE_TRUE_NORTH, 1)
  field(:WIND_REFERENCE_MAGNETIC_NORTH, 2)
  field(:WIND_REFERENCE_APPARENT, 3)
  field(:WIND_REFERENCE_BOAT_TRUE_NORTH, 4)
  field(:WIND_REFERENCE_WATER_TRUE_NORTH, 5)
end

defmodule NauticNet.Protobuf.DataSet.DataPoint do
  @moduledoc false

  use Protobuf, syntax: :proto3, protoc_gen_elixir_version: "0.12.0"

  oneof(:sample, 0)

  field(:timestamp, 1, type: Google.Protobuf.Timestamp)
  field(:hw_id, 2, type: :uint64, json_name: "hwId")
  field(:heading, 16, type: NauticNet.Protobuf.HeadingSample, oneof: 0)
  field(:speed, 17, type: NauticNet.Protobuf.SpeedSample, oneof: 0)
  field(:velocity, 18, type: NauticNet.Protobuf.VelocitySample, oneof: 0)

  field(:wind_velocity, 19,
    type: NauticNet.Protobuf.WindVelocitySample,
    json_name: "windVelocity",
    oneof: 0
  )

  field(:water_depth, 20,
    type: NauticNet.Protobuf.WaterDepthSample,
    json_name: "waterDepth",
    oneof: 0
  )

  field(:position, 21, type: NauticNet.Protobuf.PositionSample, oneof: 0)
  field(:tracker, 22, type: NauticNet.Protobuf.TrackerSample, oneof: 0)
  field(:attitude, 23, type: NauticNet.Protobuf.AttitudeSample, oneof: 0)
end

defmodule NauticNet.Protobuf.DataSet do
  @moduledoc false

  use Protobuf, syntax: :proto3, protoc_gen_elixir_version: "0.12.0"

  field(:counter, 1, type: :uint32)

  field(:data_points, 2,
    repeated: true,
    type: NauticNet.Protobuf.DataSet.DataPoint,
    json_name: "dataPoints"
  )

  field(:ref, 3, type: :string)
  field(:boat_identifier, 4, type: :string, json_name: "boatIdentifier")

  field(:network_devices, 5,
    repeated: true,
    type: NauticNet.Protobuf.NetworkDevice,
    json_name: "networkDevices"
  )

  field(:ack, 6, type: NauticNet.Protobuf.CommandAck)
end

defmodule NauticNet.Protobuf.NetworkDevice do
  @moduledoc false

  use Protobuf, syntax: :proto3, protoc_gen_elixir_version: "0.12.0"

  field(:hw_id, 1, type: :uint64, json_name: "hwId")
  field(:name, 2, type: :string)
end

defmodule NauticNet.Protobuf.CommandAck do
  @moduledoc false

  use Protobuf, syntax: :proto3, protoc_gen_elixir_version: "0.12.0"

  field(:command_id, 1, type: :string, json_name: "commandId")
  field(:assignment_id, 2, type: :string, json_name: "assignmentId")
  field(:assignment_version, 3, type: :uint32, json_name: "assignmentVersion")
end

defmodule NauticNet.Protobuf.HeadingSample do
  @moduledoc false

  use Protobuf, syntax: :proto3, protoc_gen_elixir_version: "0.12.0"

  field(:angle_reference, 1,
    type: NauticNet.Protobuf.AngleReference,
    json_name: "angleReference",
    enum: true
  )

  field(:angle_mrad, 2, type: :int32, json_name: "angleMrad")
end

defmodule NauticNet.Protobuf.SpeedSample do
  @moduledoc false

  use Protobuf, syntax: :proto3, protoc_gen_elixir_version: "0.12.0"

  field(:speed_reference, 1,
    type: NauticNet.Protobuf.SpeedReference,
    json_name: "speedReference",
    enum: true
  )

  field(:speed_cm_s, 2, type: :int32, json_name: "speedCmS")
end

defmodule NauticNet.Protobuf.VelocitySample do
  @moduledoc false

  use Protobuf, syntax: :proto3, protoc_gen_elixir_version: "0.12.0"

  field(:speed_reference, 1,
    type: NauticNet.Protobuf.SpeedReference,
    json_name: "speedReference",
    enum: true
  )

  field(:angle_reference, 2,
    type: NauticNet.Protobuf.AngleReference,
    json_name: "angleReference",
    enum: true
  )

  field(:speed_cm_s, 3, type: :int32, json_name: "speedCmS")
  field(:angle_mrad, 4, type: :int32, json_name: "angleMrad")
end

defmodule NauticNet.Protobuf.WindVelocitySample do
  @moduledoc false

  use Protobuf, syntax: :proto3, protoc_gen_elixir_version: "0.12.0"

  field(:wind_reference, 1,
    type: NauticNet.Protobuf.WindReference,
    json_name: "windReference",
    enum: true
  )

  field(:speed_cm_s, 2, type: :int32, json_name: "speedCmS")
  field(:angle_mrad, 3, type: :int32, json_name: "angleMrad")
end

defmodule NauticNet.Protobuf.WaterDepthSample do
  @moduledoc false

  use Protobuf, syntax: :proto3, protoc_gen_elixir_version: "0.12.0"

  field(:depth_cm, 1, type: :uint32, json_name: "depthCm")
end

defmodule NauticNet.Protobuf.PositionSample do
  @moduledoc false

  use Protobuf, syntax: :proto3, protoc_gen_elixir_version: "0.12.0"

  field(:latitude, 1, type: :float)
  field(:longitude, 2, type: :float)
end

defmodule NauticNet.Protobuf.TrackerSample do
  @moduledoc false

  use Protobuf, syntax: :proto3, protoc_gen_elixir_version: "0.12.0"

  field(:rssi, 1, type: :sint32)
  field(:rover_data, 2, type: NauticNet.Protobuf.RoverData, json_name: "roverData")
end

defmodule NauticNet.Protobuf.AttitudeSample do
  @moduledoc false

  use Protobuf, syntax: :proto3, protoc_gen_elixir_version: "0.12.0"

  field(:yaw_mrad, 1, type: :sint32, json_name: "yawMrad")
  field(:pitch_mrad, 2, type: :sint32, json_name: "pitchMrad")
  field(:roll_mrad, 3, type: :sint32, json_name: "rollMrad")
end
