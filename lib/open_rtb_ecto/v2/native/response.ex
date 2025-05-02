defmodule OpenRtbEcto.V2.Native.Response do
  @moduledoc """
  The native object is the top level JSON object which identifies a native response.
  """

  use Ecto.Schema
  import Ecto.Changeset
  alias OpenRtbEcto.V2.Native.Response.{Asset, EventTracker, Link}

  @type t :: %__MODULE__{}

  embedded_schema do
    field(:ver, :string, default: "1.2")
    embeds_many(:assets, Asset)
    field(:assetsurl, :string)
    field(:dcourl, :string)
    embeds_one(:link, Link)
    field(:imptrackers, {:array, :string})
    field(:jstracker, :string)
    embeds_many(:eventtrackers, EventTracker)
    field(:privacy, :string)
    field(:ext, :map, default: %{})
  end

  def changeset(response, attrs) when is_map(attrs) do
    response
    |> cast(attrs, [
      :ver,
      :assetsurl,
      :dcourl,
      :imptrackers,
      :jstracker,
      :privacy,
      :ext
    ])
    |> cast_embed(:assets)
    |> cast_embed(:link, required: true)
    |> cast_embed(:eventtrackers)
  end

  def changeset(response, _attrs), do: change(response)
end
