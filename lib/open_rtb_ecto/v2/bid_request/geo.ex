defmodule OpenRtbEcto.V2.BidRequest.Geo do
  @moduledoc """
  The geo object itself and all of its parameters are optional, so default values are not provided. If
  an optional parameter is not specified, it should be considered unknown.
  Note that the Geo Object may appear in one or both the Device Object and the User Object.
  This is intentional, since the information may be derived from either a device-oriented source
  (such as IP geo lookup), or by user registration information (for example provided to a publisher
  through a user registration). If the information is in conflict, it’s up to the bidder to determine
  which information to use.
  """

  use Ecto.Schema
  import Ecto.Changeset

  @primary_key false
  embedded_schema do
    field(:lat, :float)
    field(:lon, :float)
    field(:country)
    field(:region)
    field(:regionfips104)
    field(:metro)
    field(:city)
    field(:zip)
    field(:type, :integer)
  end

  # TODO ?
  # validate country is ISO-3166-1 Alpha=3 ?
  # validate region is ISO-3166-2
  # validate regionfips104 is fips 10-4
  # validate metro is metro code from https://developers.google.com/adwords/api/docs/appendix/geotargeting?csw=1
  def changeset(geo, attrs \\ %{}) do
    geo
    |> cast(attrs, [:lat, :lon, :country, :region, :regionfips104, :metro, :city, :zip, :type])
    |> validate_number(:lat, greater_than_or_equal_to: -90, less_than_or_equal_to: 90)
    |> validate_number(:lon, greater_than_or_equal_to: -180, less_than_or_equal_to: 180)
    |> validate_number(:type, greater_than_or_equal_to: 1, less_than_or_equal_to: 3)
  end
end
