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
  def cast(_), do: :error

  def embed_as(type), do: type

  def equal?(a, b), do: a == b

  def load(val), do: val

  def dump(val), do: val
end
