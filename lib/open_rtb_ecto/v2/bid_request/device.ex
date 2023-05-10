defmodule OpenRtbEcto.V2.BidRequest.Device do
  @moduledoc """
  This object provides information pertaining to the device through which the user is interacting.
  Device information includes its hardware, platform, location, and carrier data. The device can
  refer to a mobile handset, a desktop computer, set top box, or other digital device.
  """

  use Ecto.Schema
  import Ecto.Changeset

  alias OpenRtbEcto.Types.TinyInt
  alias OpenRtbEcto.V2.BidRequest.Geo
  alias OpenRtbEcto.V2.BidRequest.UserAgent

  @type t :: %__MODULE__{}

  @primary_key false
  embedded_schema do
    field(:ua)
    embeds_one(:geo, Geo)
    embeds_one(:sua, UserAgent)
    field(:dnt, TinyInt)
    field(:lmt, TinyInt)
    field(:ip)
    field(:ipv6)
    field(:devicetype, :integer)
    field(:make)
    field(:model)
    field(:os)
    field(:osv)
    field(:hwv)
    field(:h, :integer)
    field(:w, :integer)
    field(:ppi, :integer)
    field(:pxratio, :float)
    field(:js, TinyInt)
    field(:geofetch, TinyInt)
    field(:flashver)
    field(:language)
    field(:langb)
    field(:carrier)
    field(:mccmnc)
    field(:connectiontype, :integer)
    field(:ifa)
    field(:didsha1)
    field(:didmd5)
    field(:dpidsha1)
    field(:dpidmd5)
    field(:macsha1)
    field(:macmd5)
    field(:ext, :map, default: %{})
  end

  def changeset(device, attrs \\ %{}) do
    device
    |> cast(attrs, [
      :ua,
      :dnt,
      :lmt,
      :ip,
      :ipv6,
      :devicetype,
      :make,
      :model,
      :os,
      :osv,
      :hwv,
      :h,
      :w,
      :ppi,
      :pxratio,
      :js,
      :geofetch,
      :flashver,
      :language,
      :langb,
      :carrier,
      :mccmnc,
      :connectiontype,
      :ifa,
      :didsha1,
      :didmd5,
      :dpidsha1,
      :dpidmd5,
      :macsha1,
      :macmd5,
      :ext
    ])
    |> cast_embed(:geo)
    |> cast_embed(:sua)
    |> validate_inclusion(:devicetype, 1..7)
    |> validate_inclusion(:connectiontype, 0..6)
  end
end
