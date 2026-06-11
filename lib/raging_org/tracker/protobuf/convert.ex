defmodule RagingOrg.Tracker.Protobuf.Convert do
  @moduledoc """
  Unit conversion functions explicitly designed for working with Protobuf samples.

  Protobufs encode the int32 type more efficiently than a float, so we use fixed-point precision wherever it will
  save us a few bytes in transit.
  """

  @doc """
  Convert a measurement value for setting to a Protobuf field.

  Some precision may be lost in the conversion to fixed-point int32 values.
  """
  def encode_unit(value, standard_unit, protobuf_unit)
  def encode_unit(value, :rad, :mrad), do: trunc(value * 1000)
  def encode_unit(value, :m_s, :cm_s), do: trunc(value * 100)
  def encode_unit(value, :m, :cm), do: trunc(value * 100)

  @doc """
  Convert a Protobuf field back into more-useful units.
  """
  def decode_unit(value, protobuf_unit, standard_unit)
  def decode_unit(value, :mrad, :rad), do: value / 1000
  def decode_unit(value, :cm_s, :m_s), do: value / 100
  def decode_unit(value, :cm, :m), do: value / 100

  # :dkn is deciknots: one tenth of a knot
  def decode_unit(value, :dkn, :m_s), do: value / 10 / 1.94384

  # :ddeg is decidegrees: one tenth of a degree
  def decode_unit(value, :ddeg, :rad), do: value / 10 * :math.pi() / 180
end
