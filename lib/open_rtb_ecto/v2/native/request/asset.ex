defmodule OpenRtbEcto.V2.Native.Request.Asset do
  @moduledoc """
  The main container object for each asset requested or supported by Exchange on behalf of the rendering client.
  """

  use Ecto.Schema
  import Ecto.Changeset

  alias OpenRtbEcto.V2.Native.Helper
  alias OpenRtbEcto.V2.Native.Request.{Title, Img, Video, Data}

  @type t :: %__MODULE__{}

  @primary_key false
  embedded_schema do
    field(:id, :integer)
    field(:required, :integer, default: 0)
    embeds_one(:title, Title)
    embeds_one(:img, Img)
    embeds_one(:video, Video)
    embeds_one(:data, Data)
    field(:ext, :map, default: %{})
  end

  def changeset(asset, attrs \\ %{}) do
    asset
    |> cast(attrs, [
      :id,
      :required,
      :ext
    ])
    |> cast_embed(:title)
    |> cast_embed(:img)
    |> cast_embed(:video)
    |> cast_embed(:data)
    |> validate_required(:id)
    |> Helper.validate_media()
    # Using regular Ecto.Schema and not SafeSchema for this module ensures that
    # media validation errors will cause the asset to be rejected
  end
end
