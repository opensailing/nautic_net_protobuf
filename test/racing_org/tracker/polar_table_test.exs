defmodule RacingOrg.Tracker.PolarTableTest do
  use ExUnit.Case

  alias RacingOrg.Tracker.Protobuf.DeviceCommand
  alias RacingOrg.Tracker.Protobuf.PolarCell
  alias RacingOrg.Tracker.Protobuf.PolarOptimum
  alias RacingOrg.Tracker.Protobuf.PolarRow
  alias RacingOrg.Tracker.Protobuf.PolarTable

  describe "PolarTable round-trip through a DeviceCommand" do
    test "encodes and decodes a polar table on the :polar_table oneof tag" do
      polar = %PolarTable{
        polar_id: "j70-2024",
        version: 7,
        rows: [
          %PolarRow{
            tws_mps: 3.0,
            cells: [
              %PolarCell{twa_deg: 45.0, boat_speed_mps: 1.8},
              %PolarCell{twa_deg: 90.0, boat_speed_mps: 2.9},
              %PolarCell{twa_deg: 150.0, boat_speed_mps: 2.1}
            ]
          },
          %PolarRow{
            tws_mps: 6.0,
            cells: [
              %PolarCell{twa_deg: 45.0, boat_speed_mps: 3.4},
              %PolarCell{twa_deg: 90.0, boat_speed_mps: 5.1},
              %PolarCell{twa_deg: 150.0, boat_speed_mps: 4.0}
            ]
          }
        ],
        optima: [
          %PolarOptimum{
            tws_mps: 3.0,
            beat_twa: 42.5,
            beat_vmg: 1.3,
            run_twa: 150.0,
            run_vmg: 1.9
          },
          %PolarOptimum{
            tws_mps: 6.0,
            beat_twa: 40.0,
            beat_vmg: 2.6,
            run_twa: 155.0,
            run_vmg: 3.6
          }
        ]
      }

      command = %DeviceCommand{
        command_id: "cmd-polar-1",
        assignment_id: "assignment-1",
        assignment_version: 3,
        payload: {:polar_table, polar}
      }

      decoded = command |> DeviceCommand.encode() |> DeviceCommand.decode()

      # The polar rides on the new oneof tag and the envelope is untouched.
      assert decoded.command_id == "cmd-polar-1"
      assert decoded.assignment_id == "assignment-1"
      assert decoded.assignment_version == 3
      assert {:polar_table, decoded_polar} = decoded.payload

      # Identity/structure fields are exact (string + uint32 + repeated counts).
      assert decoded_polar.polar_id == "j70-2024"
      assert decoded_polar.version == 7
      assert length(decoded_polar.rows) == 2
      assert length(decoded_polar.optima) == 2

      # Row ordering and the float grid round-trip with float32 fidelity. We assert
      # within float32 tolerance because protobuf `float` is 32-bit IEEE-754: only
      # exactly-representable values (e.g. 45.0, 3.0, 42.5) survive bit-for-bit,
      # while arbitrary decimals (1.8 -> 1.7999999523) are quantized on encode.
      assert_polar_close(decoded_polar, polar)

      # Spot-check ordering/values explicitly on exactly-representable fields.
      [row0, row1] = decoded_polar.rows
      assert row0.tws_mps == 3.0
      assert row1.tws_mps == 6.0
      assert Enum.map(row0.cells, & &1.twa_deg) == [45.0, 90.0, 150.0]

      [opt0, opt1] = decoded_polar.optima
      assert opt0.beat_twa == 42.5
      assert opt1.tws_mps == 6.0
    end
  end

  # Largest float32 ULP across the magnitudes used here is well under 1.0e-4.
  @float32_tol 1.0e-4

  defp assert_polar_close(decoded, expected) do
    assert decoded.polar_id == expected.polar_id
    assert decoded.version == expected.version

    for {drow, erow} <- Enum.zip(decoded.rows, expected.rows) do
      assert_close(drow.tws_mps, erow.tws_mps)

      for {dcell, ecell} <- Enum.zip(drow.cells, erow.cells) do
        assert_close(dcell.twa_deg, ecell.twa_deg)
        assert_close(dcell.boat_speed_mps, ecell.boat_speed_mps)
      end
    end

    for {dopt, eopt} <- Enum.zip(decoded.optima, expected.optima) do
      assert_close(dopt.tws_mps, eopt.tws_mps)
      assert_close(dopt.beat_twa, eopt.beat_twa)
      assert_close(dopt.beat_vmg, eopt.beat_vmg)
      assert_close(dopt.run_twa, eopt.run_twa)
      assert_close(dopt.run_vmg, eopt.run_vmg)
    end
  end

  defp assert_close(actual, expected) do
    assert abs(actual - expected) <= @float32_tol,
           "expected #{inspect(actual)} to be within #{@float32_tol} of #{inspect(expected)}"
  end
end
