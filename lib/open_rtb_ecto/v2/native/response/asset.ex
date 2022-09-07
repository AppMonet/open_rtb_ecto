defmodule OpenRtbEcto.V2.Native.Response.Asset do
  @moduledoc """
  Corresponds to the Asset Object in the request. The main container object for each asset requested or
  supported by Exchange on behalf of the rendering client. Any object that is required is to be flagged as such.
  Only one of the {title,img,video,data} objects should be present in each object. All others should be null/absent.
  The id is to be unique within the AssetObject array so that the response can be aligned.
  """

  use Ecto.Schema
  import Ecto.Changeset

  alias OpenRtbEcto.V2.Native.Helper
  alias OpenRtbEcto.V2.Native.Response.{Title, Img, Video, Data, Link}

  @type t :: %__MODULE__{}

  @primary_key false
  embedded_schema do
    field(:id, :integer)
    field(:required, :integer, default: 0)
    embeds_one(:title, Title)
    embeds_one(:img, Img)
    embeds_one(:video, Video)
    embeds_one(:data, Data)
    embeds_one(:link, Link)
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
    |> cast_embed(:link)
    |> Helper.validate_media()
  end
end
