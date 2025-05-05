defmodule OpenRtbEcto.V2.BidRequest.Channel do
  @moduledoc """
  This object describes the channel an ad will be displayed on. A Channel is defined as the entity that curates
  a content library, or stream within a brand name for viewers. Examples are specific view selectable
  ‘channels’ within linear and streaming television (MTV, HGTV, CNN, BBC One, etc) or a specific stream of
  audio content commonly called ‘stations.’ Name is a human-readable field while domain and id can be used
  for reporting and targeting purposes. See 7.6 for further examples.
  """
  use Ecto.Schema
  import Ecto.Changeset

  @type t :: %__MODULE__{}

  @primary_key false
  embedded_schema do
    field(:id)
    field(:name)
    field(:domain)
    field(:ext, :map, default: %{})
  end

  def changeset(channel, attrs) when is_map(attrs) do
    channel
    |> cast(attrs, [
      :id,
      :name,
      :domain
    ])
    |> OpenRtbEcto.safe_cast_ext(attrs)
  end

  def changeset(channel, _), do: change(channel)
end
