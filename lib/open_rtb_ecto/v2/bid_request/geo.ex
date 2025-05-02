defmodule OpenRtbEcto.V2.BidRequest.Geo do
  @moduledoc """
  This object encapsulates various methods for specifying a geographic location. When subordinate
  to a Device object, it indicates the location of the device which can also be interpreted as the
  user’s current location. When subordinate to a User object, it indicates the location of the 
  user’s home base (i.e., not necessarily their current location).

  The lat/lon attributes should only be passed if they conform to the accuracy depicted in the type
  attribute. For example, the centroid of a geographic region such as postal code should not be 
  passed.
  """

  use Ecto.Schema
  import Ecto.Changeset

  @type t :: %__MODULE__{}

  @primary_key false
  embedded_schema do
    field(:lat, :float)
    field(:lon, :float)
    field(:type, :integer)
    field(:accuracy, :integer)
    field(:lastfix, :integer)
    field(:ipservice, :integer)
    field(:country)
    field(:region)
    field(:regionfips104)
    field(:metro)
    field(:city)
    field(:zip)
    field(:utcoffset, :integer)
    field(:ext, :map, default: %{})
  end

  def changeset(geo, attrs) when is_map(attrs) do
    geo
    |> cast(attrs, [
      :lat,
      :lon,
      :type,
      :accuracy,
      :lastfix,
      :ipservice,
      :country,
      :region,
      :regionfips104,
      :metro,
      :city,
      :zip,
      :type,
      :utcoffset,
      :ext
    ])
    |> validate_number(:lat, greater_than_or_equal_to: -90, less_than_or_equal_to: 90)
    |> validate_number(:lon, greater_than_or_equal_to: -180, less_than_or_equal_to: 180)
    |> validate_inclusion(:type, 1..3)
    |> validate_inclusion(:ipservice, 1..4)
  end

  def changeset(geo, _), do: change(geo)
end
