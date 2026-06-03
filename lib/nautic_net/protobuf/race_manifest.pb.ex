defmodule NauticNet.Protobuf.ChunkDescriptor do
  @moduledoc false

  use Protobuf, syntax: :proto3, protoc_gen_elixir_version: "0.12.0"

  field(:chunk_id, 1, type: :string, json_name: "chunkId")
  field(:byte_count, 2, type: :uint64, json_name: "byteCount")
  field(:checksum, 3, type: :string)
  field(:sample_count, 4, type: :uint32, json_name: "sampleCount")
end

defmodule NauticNet.Protobuf.RaceManifest do
  @moduledoc false

  use Protobuf, syntax: :proto3, protoc_gen_elixir_version: "0.12.0"

  field(:race_recording_id, 1, type: :string, json_name: "raceRecordingId")
  field(:device_id, 2, type: :string, json_name: "deviceId")
  field(:assignment_id, 3, type: :string, json_name: "assignmentId")
  field(:assignment_version, 4, type: :uint32, json_name: "assignmentVersion")
  field(:started_at, 5, type: Google.Protobuf.Timestamp, json_name: "startedAt")
  field(:finished_at, 6, type: Google.Protobuf.Timestamp, json_name: "finishedAt")
  field(:chunks, 7, repeated: true, type: NauticNet.Protobuf.ChunkDescriptor)
  field(:total_sample_count, 8, type: :uint32, json_name: "totalSampleCount")
  field(:course_hash, 9, type: :string, json_name: "courseHash")
  field(:route_hash, 10, type: :string, json_name: "routeHash")
  field(:device_status, 11, type: :string, json_name: "deviceStatus")
end
