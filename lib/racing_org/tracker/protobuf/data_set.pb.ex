defmodule RacingOrg.Tracker.Protobuf.AngleReference do
  @moduledoc false

  use Protobuf,
    enum: true,
    full_name: "AngleReference",
    protoc_gen_elixir_version: "0.17.0",
    syntax: :proto3

  field(:ANGLE_REFERENCE_NONE, 0)
  field(:ANGLE_REFERENCE_TRUE_NORTH, 1)
  field(:ANGLE_REFERENCE_MAGNETIC_MORTH, 2)
end

defmodule RacingOrg.Tracker.Protobuf.SpeedReference do
  @moduledoc false

  use Protobuf,
    enum: true,
    full_name: "SpeedReference",
    protoc_gen_elixir_version: "0.17.0",
    syntax: :proto3

  field(:SPEED_REFERENCE_NONE, 0)
  field(:SPEED_REFERENCE_GROUND, 1)
  field(:SPEED_REFERENCE_WATER, 2)
end

defmodule RacingOrg.Tracker.Protobuf.WindReference do
  @moduledoc false

  use Protobuf,
    enum: true,
    full_name: "WindReference",
    protoc_gen_elixir_version: "0.17.0",
    syntax: :proto3

  field(:WIND_REFERENCE_NONE, 0)
  field(:WIND_REFERENCE_TRUE_NORTH, 1)
  field(:WIND_REFERENCE_MAGNETIC_NORTH, 2)
  field(:WIND_REFERENCE_APPARENT, 3)
  field(:WIND_REFERENCE_BOAT_TRUE_NORTH, 4)
  field(:WIND_REFERENCE_WATER_TRUE_NORTH, 5)
end

defmodule RacingOrg.Tracker.Protobuf.DataSet.DataPoint do
  @moduledoc false

  use Protobuf,
    full_name: "DataSet.DataPoint",
    protoc_gen_elixir_version: "0.17.0",
    syntax: :proto3

  oneof(:sample, 0)

  field(:timestamp, 1, type: Google.Protobuf.Timestamp)
  field(:hw_id, 2, type: :uint64, json_name: "hwId")
  field(:heading, 16, type: RacingOrg.Tracker.Protobuf.HeadingSample, oneof: 0)
  field(:speed, 17, type: RacingOrg.Tracker.Protobuf.SpeedSample, oneof: 0)
  field(:velocity, 18, type: RacingOrg.Tracker.Protobuf.VelocitySample, oneof: 0)

  field(:wind_velocity, 19,
    type: RacingOrg.Tracker.Protobuf.WindVelocitySample,
    json_name: "windVelocity",
    oneof: 0
  )

  field(:water_depth, 20,
    type: RacingOrg.Tracker.Protobuf.WaterDepthSample,
    json_name: "waterDepth",
    oneof: 0
  )

  field(:position, 21, type: RacingOrg.Tracker.Protobuf.PositionSample, oneof: 0)
  field(:tracker, 22, type: RacingOrg.Tracker.Protobuf.TrackerSample, oneof: 0)
  field(:attitude, 23, type: RacingOrg.Tracker.Protobuf.AttitudeSample, oneof: 0)
end

defmodule RacingOrg.Tracker.Protobuf.DataSet do
  @moduledoc false

  use Protobuf, full_name: "DataSet", protoc_gen_elixir_version: "0.17.0", syntax: :proto3

  field(:counter, 1, type: :uint32)

  field(:data_points, 2,
    repeated: true,
    type: RacingOrg.Tracker.Protobuf.DataSet.DataPoint,
    json_name: "dataPoints"
  )

  field(:ref, 3, type: :string)
  field(:boat_identifier, 4, type: :string, json_name: "boatIdentifier")

  field(:network_devices, 5,
    repeated: true,
    type: RacingOrg.Tracker.Protobuf.NetworkDevice,
    json_name: "networkDevices"
  )

  field(:ack, 6, type: RacingOrg.Tracker.Protobuf.CommandAck)

  field(:sample_mode, 7,
    type: RacingOrg.Tracker.Protobuf.SampleMode,
    json_name: "sampleMode",
    enum: true
  )

  field(:race_phase, 8,
    type: RacingOrg.Tracker.Protobuf.RacePhase,
    json_name: "racePhase",
    enum: true
  )

  field(:manifest, 9, type: RacingOrg.Tracker.Protobuf.RaceManifest)
end

defmodule RacingOrg.Tracker.Protobuf.NetworkDevice do
  @moduledoc false

  use Protobuf, full_name: "NetworkDevice", protoc_gen_elixir_version: "0.17.0", syntax: :proto3

  field(:hw_id, 1, type: :uint64, json_name: "hwId")
  field(:name, 2, type: :string)
end

defmodule RacingOrg.Tracker.Protobuf.CommandAck do
  @moduledoc false

  use Protobuf, full_name: "CommandAck", protoc_gen_elixir_version: "0.17.0", syntax: :proto3

  field(:command_id, 1, type: :string, json_name: "commandId")
  field(:assignment_id, 2, type: :string, json_name: "assignmentId")
  field(:assignment_version, 3, type: :uint32, json_name: "assignmentVersion")
end

defmodule RacingOrg.Tracker.Protobuf.HeadingSample do
  @moduledoc false

  use Protobuf, full_name: "HeadingSample", protoc_gen_elixir_version: "0.17.0", syntax: :proto3

  field(:angle_reference, 1,
    type: RacingOrg.Tracker.Protobuf.AngleReference,
    json_name: "angleReference",
    enum: true
  )

  field(:angle_mrad, 2, type: :int32, json_name: "angleMrad")
end

defmodule RacingOrg.Tracker.Protobuf.SpeedSample do
  @moduledoc false

  use Protobuf, full_name: "SpeedSample", protoc_gen_elixir_version: "0.17.0", syntax: :proto3

  field(:speed_reference, 1,
    type: RacingOrg.Tracker.Protobuf.SpeedReference,
    json_name: "speedReference",
    enum: true
  )

  field(:speed_cm_s, 2, type: :int32, json_name: "speedCmS")
end

defmodule RacingOrg.Tracker.Protobuf.VelocitySample do
  @moduledoc false

  use Protobuf, full_name: "VelocitySample", protoc_gen_elixir_version: "0.17.0", syntax: :proto3

  field(:speed_reference, 1,
    type: RacingOrg.Tracker.Protobuf.SpeedReference,
    json_name: "speedReference",
    enum: true
  )

  field(:angle_reference, 2,
    type: RacingOrg.Tracker.Protobuf.AngleReference,
    json_name: "angleReference",
    enum: true
  )

  field(:speed_cm_s, 3, type: :int32, json_name: "speedCmS")
  field(:angle_mrad, 4, type: :int32, json_name: "angleMrad")
end

defmodule RacingOrg.Tracker.Protobuf.WindVelocitySample do
  @moduledoc false

  use Protobuf,
    full_name: "WindVelocitySample",
    protoc_gen_elixir_version: "0.17.0",
    syntax: :proto3

  field(:wind_reference, 1,
    type: RacingOrg.Tracker.Protobuf.WindReference,
    json_name: "windReference",
    enum: true
  )

  field(:speed_cm_s, 2, type: :int32, json_name: "speedCmS")
  field(:angle_mrad, 3, type: :int32, json_name: "angleMrad")
end

defmodule RacingOrg.Tracker.Protobuf.WaterDepthSample do
  @moduledoc false

  use Protobuf,
    full_name: "WaterDepthSample",
    protoc_gen_elixir_version: "0.17.0",
    syntax: :proto3

  field(:depth_cm, 1, type: :uint32, json_name: "depthCm")
end

defmodule RacingOrg.Tracker.Protobuf.PositionSample do
  @moduledoc false

  use Protobuf, full_name: "PositionSample", protoc_gen_elixir_version: "0.17.0", syntax: :proto3

  field(:latitude, 1, type: :float)
  field(:longitude, 2, type: :float)
end

defmodule RacingOrg.Tracker.Protobuf.TrackerSample do
  @moduledoc false

  use Protobuf, full_name: "TrackerSample", protoc_gen_elixir_version: "0.17.0", syntax: :proto3

  field(:rssi, 1, type: :sint32)
  field(:rover_data, 2, type: RacingOrg.Tracker.Protobuf.RoverData, json_name: "roverData")
end

defmodule RacingOrg.Tracker.Protobuf.AttitudeSample do
  @moduledoc false

  use Protobuf, full_name: "AttitudeSample", protoc_gen_elixir_version: "0.17.0", syntax: :proto3

  field(:yaw_mrad, 1, type: :sint32, json_name: "yawMrad")
  field(:pitch_mrad, 2, type: :sint32, json_name: "pitchMrad")
  field(:roll_mrad, 3, type: :sint32, json_name: "rollMrad")
end
