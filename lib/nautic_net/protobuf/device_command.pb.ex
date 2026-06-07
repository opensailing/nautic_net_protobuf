defmodule NauticNet.Protobuf.SampleMode do
  @moduledoc false

  use Protobuf,
    enum: true,
    full_name: "SampleMode",
    protoc_gen_elixir_version: "0.16.1",
    syntax: :proto3

  field(:SAMPLE_MODE_UNSPECIFIED, 0)
  field(:SAMPLE_MODE_OUTING_1HZ, 1)
  field(:SAMPLE_MODE_RACE_5HZ, 2)
  field(:SAMPLE_MODE_EVENT_10HZ, 3)
end

defmodule NauticNet.Protobuf.RacePhase do
  @moduledoc false

  use Protobuf,
    enum: true,
    full_name: "RacePhase",
    protoc_gen_elixir_version: "0.16.1",
    syntax: :proto3

  field(:RACE_PHASE_UNSPECIFIED, 0)
  field(:RACE_PHASE_IDLE, 1)
  field(:RACE_PHASE_PRE_START, 2)
  field(:RACE_PHASE_RACING, 3)
  field(:RACE_PHASE_ROUNDING, 4)
  field(:RACE_PHASE_FINISH, 5)
  field(:RACE_PHASE_COMPLETE, 6)
end

defmodule NauticNet.Protobuf.MarkRounding do
  @moduledoc false

  use Protobuf,
    enum: true,
    full_name: "MarkRounding",
    protoc_gen_elixir_version: "0.16.1",
    syntax: :proto3

  field(:MARK_ROUNDING_UNSPECIFIED, 0)
  field(:MARK_ROUNDING_PORT, 1)
  field(:MARK_ROUNDING_STARBOARD, 2)
  field(:MARK_ROUNDING_GATE, 3)
end

defmodule NauticNet.Protobuf.LatLon do
  @moduledoc false

  use Protobuf, full_name: "LatLon", protoc_gen_elixir_version: "0.16.1", syntax: :proto3

  field(:latitude, 1, type: :double)
  field(:longitude, 2, type: :double)
end

defmodule NauticNet.Protobuf.LineGeometry do
  @moduledoc false

  use Protobuf, full_name: "LineGeometry", protoc_gen_elixir_version: "0.16.1", syntax: :proto3

  field(:end_a, 1, type: NauticNet.Protobuf.LatLon, json_name: "endA")
  field(:end_b, 2, type: NauticNet.Protobuf.LatLon, json_name: "endB")
end

defmodule NauticNet.Protobuf.CourseMark do
  @moduledoc false

  use Protobuf, full_name: "CourseMark", protoc_gen_elixir_version: "0.16.1", syntax: :proto3

  field(:code, 1, type: :string)
  field(:position, 2, type: NauticNet.Protobuf.LatLon)
  field(:rounding, 3, type: NauticNet.Protobuf.MarkRounding, enum: true)
  field(:sequence, 4, type: :uint32)
end

defmodule NauticNet.Protobuf.SamplingRules do
  @moduledoc false

  use Protobuf, full_name: "SamplingRules", protoc_gen_elixir_version: "0.16.1", syntax: :proto3

  field(:default_mode, 1,
    type: NauticNet.Protobuf.SampleMode,
    json_name: "defaultMode",
    enum: true
  )

  field(:race_mode, 2, type: NauticNet.Protobuf.SampleMode, json_name: "raceMode", enum: true)
  field(:event_mode, 3, type: NauticNet.Protobuf.SampleMode, json_name: "eventMode", enum: true)
  field(:start_window_seconds, 4, type: :uint32, json_name: "startWindowSeconds")
  field(:mark_proximity_meters, 5, type: :uint32, json_name: "markProximityMeters")
  field(:finish_window_seconds, 6, type: :uint32, json_name: "finishWindowSeconds")
end

defmodule NauticNet.Protobuf.ServerReply do
  @moduledoc false

  use Protobuf, full_name: "ServerReply", protoc_gen_elixir_version: "0.16.1", syntax: :proto3

  field(:protocol_version, 1, type: :uint32, json_name: "protocolVersion")
  field(:device_id, 2, type: :string, json_name: "deviceId")
  field(:command, 3, type: NauticNet.Protobuf.DeviceCommand)
end

defmodule NauticNet.Protobuf.DeviceCommand do
  @moduledoc false

  use Protobuf, full_name: "DeviceCommand", protoc_gen_elixir_version: "0.16.1", syntax: :proto3

  oneof(:payload, 0)

  field(:command_id, 1, type: :string, json_name: "commandId")
  field(:assignment_id, 2, type: :string, json_name: "assignmentId")
  field(:assignment_version, 3, type: :uint32, json_name: "assignmentVersion")
  field(:assignment_hash, 4, type: :string, json_name: "assignmentHash")
  field(:issued_at, 5, type: Google.Protobuf.Timestamp, json_name: "issuedAt")
  field(:expires_at, 6, type: Google.Protobuf.Timestamp, json_name: "expiresAt")
  field(:noop, 16, type: NauticNet.Protobuf.NoopCommand, oneof: 0)

  field(:race_assignment, 17,
    type: NauticNet.Protobuf.RaceAssignment,
    json_name: "raceAssignment",
    oneof: 0
  )

  field(:route_update, 18,
    type: NauticNet.Protobuf.RouteUpdate,
    json_name: "routeUpdate",
    oneof: 0
  )

  field(:active_waypoint_update, 19,
    type: NauticNet.Protobuf.ActiveWaypointUpdate,
    json_name: "activeWaypointUpdate",
    oneof: 0
  )

  field(:cancel_assignment, 20,
    type: NauticNet.Protobuf.CancelAssignment,
    json_name: "cancelAssignment",
    oneof: 0
  )

  field(:manifest_verification_result, 21,
    type: NauticNet.Protobuf.ManifestVerificationResult,
    json_name: "manifestVerificationResult",
    oneof: 0
  )

  field(:missing_chunk_request, 22,
    type: NauticNet.Protobuf.MissingChunkRequest,
    json_name: "missingChunkRequest",
    oneof: 0
  )

  field(:server_time_config, 23,
    type: NauticNet.Protobuf.ServerTimeConfig,
    json_name: "serverTimeConfig",
    oneof: 0
  )
end

defmodule NauticNet.Protobuf.NoopCommand do
  @moduledoc false

  use Protobuf, full_name: "NoopCommand", protoc_gen_elixir_version: "0.16.1", syntax: :proto3
end

defmodule NauticNet.Protobuf.RaceAssignment do
  @moduledoc false

  use Protobuf, full_name: "RaceAssignment", protoc_gen_elixir_version: "0.16.1", syntax: :proto3

  field(:boat_id, 1, type: :string, json_name: "boatId")
  field(:device_id, 2, type: :string, json_name: "deviceId")
  field(:race_plan_id, 3, type: :string, json_name: "racePlanId")
  field(:race_session_id, 4, type: :string, json_name: "raceSessionId")
  field(:race_recording_id, 5, type: :string, json_name: "raceRecordingId")
  field(:official_start_time, 6, type: Google.Protobuf.Timestamp, json_name: "officialStartTime")
  field(:expected_duration_seconds, 7, type: :uint32, json_name: "expectedDurationSeconds")
  field(:start_line, 8, type: NauticNet.Protobuf.LineGeometry, json_name: "startLine")
  field(:finish_line, 9, type: NauticNet.Protobuf.LineGeometry, json_name: "finishLine")

  field(:course_marks, 10,
    repeated: true,
    type: NauticNet.Protobuf.CourseMark,
    json_name: "courseMarks"
  )

  field(:shortened_course, 11, type: :bool, json_name: "shortenedCourse")
  field(:shortened_final_mark_code, 12, type: :string, json_name: "shortenedFinalMarkCode")
  field(:active_mark_code, 13, type: :string, json_name: "activeMarkCode")
  field(:sampling_rules, 14, type: NauticNet.Protobuf.SamplingRules, json_name: "samplingRules")
  field(:route_request_id, 15, type: :string, json_name: "routeRequestId")

  field(:route_geometry, 16,
    repeated: true,
    type: NauticNet.Protobuf.LatLon,
    json_name: "routeGeometry"
  )

  field(:route_hash, 17, type: :string, json_name: "routeHash")
end

defmodule NauticNet.Protobuf.RouteUpdate do
  @moduledoc false

  use Protobuf, full_name: "RouteUpdate", protoc_gen_elixir_version: "0.16.1", syntax: :proto3

  field(:route_request_id, 1, type: :string, json_name: "routeRequestId")

  field(:route_geometry, 2,
    repeated: true,
    type: NauticNet.Protobuf.LatLon,
    json_name: "routeGeometry"
  )

  field(:route_hash, 3, type: :string, json_name: "routeHash")
  field(:active_mark_code, 4, type: :string, json_name: "activeMarkCode")
end

defmodule NauticNet.Protobuf.ActiveWaypointUpdate do
  @moduledoc false

  use Protobuf,
    full_name: "ActiveWaypointUpdate",
    protoc_gen_elixir_version: "0.16.1",
    syntax: :proto3

  field(:active_mark_code, 1, type: :string, json_name: "activeMarkCode")
end

defmodule NauticNet.Protobuf.CancelAssignment do
  @moduledoc false

  use Protobuf,
    full_name: "CancelAssignment",
    protoc_gen_elixir_version: "0.16.1",
    syntax: :proto3

  field(:reason, 1, type: :string)
end

defmodule NauticNet.Protobuf.ManifestVerificationResult do
  @moduledoc false

  use Protobuf,
    full_name: "ManifestVerificationResult",
    protoc_gen_elixir_version: "0.16.1",
    syntax: :proto3

  field(:race_recording_id, 1, type: :string, json_name: "raceRecordingId")
  field(:complete, 2, type: :bool)
  field(:missing_chunk_ids, 3, repeated: true, type: :string, json_name: "missingChunkIds")
end

defmodule NauticNet.Protobuf.MissingChunkRequest do
  @moduledoc false

  use Protobuf,
    full_name: "MissingChunkRequest",
    protoc_gen_elixir_version: "0.16.1",
    syntax: :proto3

  field(:race_recording_id, 1, type: :string, json_name: "raceRecordingId")
  field(:chunk_ids, 2, repeated: true, type: :string, json_name: "chunkIds")
end

defmodule NauticNet.Protobuf.ServerTimeConfig do
  @moduledoc false

  use Protobuf,
    full_name: "ServerTimeConfig",
    protoc_gen_elixir_version: "0.16.1",
    syntax: :proto3

  field(:server_time, 1, type: Google.Protobuf.Timestamp, json_name: "serverTime")
end
