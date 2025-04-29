defmodule OpenRtbEcto.V2.BidRequest.Device do
  @moduledoc """
  This object provides information pertaining to the device through which the user is interacting.
  Device information includes its hardware, platform, location, and carrier data. The device can
  refer to a mobile handset, a desktop computer, set top box, or other digital device.
  """

  use OpenRtbEcto.SafeSchema

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
    |> safe_cast(attrs, [
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
    |> safe_cast_embed(:geo)
    |> safe_cast_embed(:sua)
    |> validate_device_type()
    |> validate_connection_type()
  end

  # Instead of validate_inclusion which adds errors and invalidates the changeset,
  # we'll use custom validators that discard invalid values
  defp validate_device_type(changeset) do
    case get_change(changeset, :devicetype) do
      nil -> changeset
      val when val in 1..7 -> changeset
      _ -> delete_change(changeset, :devicetype)
    end
  end

  defp validate_connection_type(changeset) do
    case get_change(changeset, :connectiontype) do
      nil -> changeset
      val when val in 0..6 -> changeset
      _ -> delete_change(changeset, :connectiontype)
    end
  end
end
