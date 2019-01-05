defmodule OpenRtbEcto.V2.BidRequest.Device do
  @moduledoc """
  The “device” object provides information pertaining to the device including its hardware,
  platform, location, and carrier. This device can refer to a mobile handset, a desktop computer,
  set top box or other digital device.
  The device object itself and all of its parameters are optional, so default values are not provided.
  If an optional parameter is not specified, it should be considered unknown.
  In general, the most essential fields are either the IP address (to enable geo-lookup for the
  bidder), or providing geo information directly in the geo object.
  """

  use Ecto.Schema
  import Ecto.Changeset

  alias OpenRtbEcto.V2.BidRequest.Geo

  @primary_key false
  embedded_schema do
    field(:dnt, :integer)
    field(:ua)
    field(:ip)
    embeds_one(:geo, Geo)
    field(:didsha1)
    field(:didmd5)
    field(:dpidsha1)
    field(:dpidmd5)
    field(:ipv6)
    field(:carrier)
    field(:language)
    field(:make)
    field(:model)
    field(:os)
    field(:osv)
    field(:js)
    field(:connectiontype)
    field(:devicetype)
    field(:flashver)
  end

  # TODO:
  # validate language is alpha-2/ISO 639-1?
  def changeset(device, attrs \\ %{}) do
    device
    |> cast(attrs, [
      :dnt,
      :ua,
      :ip,
      :didsha1,
      :didmd5,
      :dpidsha1,
      :dpidmd5,
      :ipv6,
      :carrier,
      :language,
      :make,
      :model,
      :os,
      :osv,
      :js,
      :connectiontype,
      :devicetype,
      :flashver
    ])
    |> cast_embed(:geo)
    |> validate_number(:dnt, greater_than_or_equal_to: 0, less_than_or_equal_to: 1)
    |> validate_number(:js, greater_than_or_equal_to: 0, less_than_or_equal_to: 1)
    |> validate_number(:connectiontype, greater_than_or_equal_to: 0, less_than_or_equal_to: 6)
    |> validate_number(:devicetype, greater_than_or_equal_to: 1, less_than_or_equal_to: 3)
  end
end
