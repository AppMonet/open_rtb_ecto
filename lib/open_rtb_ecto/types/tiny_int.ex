defmodule OpenRtbEcto.Types.TinyInt do
  @moduledoc """
  In some cases, partners will send boolean values in the JSON payloads for fields that
  are defined as integers in the spec. This type can handle those cases and properly cast the
  values.
  """

  @behaviour Ecto.Type

  def type, do: :tiny_int

  def cast(true), do: {:ok, 1}
  def cast("1"), do: {:ok, 1}
  def cast(1), do: {:ok, 1}
  def cast(false), do: {:ok, 0}
  def cast("0"), do: {:ok, 0}
  def cast(0), do: {:ok, 0}
  # Return nil for invalid values to allow our cast functions to discard them
  def cast(nil), do: {:ok, nil}
  # Error is used for invalid values - will be discarded for optional fields
  def cast(_), do: :error

  def embed_as(_), do: :self

  def equal?(a, b), do: a == b

  def load(val), do: {:ok, val}

  def dump(nil), do: {:ok, nil}
  def dump(val), do: {:ok, val}
end
