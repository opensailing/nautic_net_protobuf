defmodule RagingOrg.Tracker.ProtoTest do
  use ExUnit.Case

  alias RagingOrg.Tracker.Protobuf
  alias RagingOrg.Tracker.Protobuf.DataSet
  alias RagingOrg.Tracker.Protobuf.DataSet.DataPoint
  alias RagingOrg.Tracker.Protobuf.PositionSample
  alias RagingOrg.Tracker.Protobuf.SpeedSample

  describe "chunk_into_data_sets/3" do
    test "works for single packets" do
      samples = build_speed_points(10)
      max_bytes = 512
      counter = 100

      assert [data_set] = Protobuf.chunk_into_data_sets(samples, max_bytes, counter: counter)

      assert data_set.counter == 100
      assert length(data_set.data_points) == 10
      assert byte_size(DataSet.encode(data_set)) <= max_bytes
    end

    test "works for multiple packets" do
      samples =
        build_speed_points(:rand.uniform(100) + 100) ++
          build_position_points(:rand.uniform(100) + 100)

      max_bytes = 512
      counter = 100

      assert data_sets = [_ | _] = Protobuf.chunk_into_data_sets(samples, max_bytes, counter: counter)

      for {data_set, index} <- Enum.with_index(data_sets) do
        assert data_set.counter == 100 + index
        assert length(data_set.data_points) < 100
        assert byte_size(DataSet.encode(data_set)) <= max_bytes
      end
    end
  end

  defp build_speed_points(count) do
    for _ <- 1..count do
      %DataPoint{
        timestamp: Protobuf.utc_now(),
        sample: {:speed, %SpeedSample{speed_cm_s: :rand.uniform(100)}}
      }
    end
  end

  defp build_position_points(count) do
    for _ <- 1..count do
      %DataPoint{
        timestamp: Protobuf.utc_now(),
        sample:
          {:position,
           %PositionSample{
             latitude: (:rand.uniform() - 0.5) * 180,
             longitude: (:rand.uniform() - 0.5) * 360
           }}
      }
    end
  end
end
