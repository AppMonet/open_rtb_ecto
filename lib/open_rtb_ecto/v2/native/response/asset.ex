defmodule OpenRtbEcto.V2.Native.Response.Asset do
  @moduledoc """
  Corresponds to the Asset Object in the request. The main container object for each asset requested or
  supported by Exchange on behalf of the rendering client. Any object that is required is to be flagged as such.
  Only one of the {title,img,video,data} objects should be present in each object. All others should be null/absent.
  The id is to be unique within the AssetObject array so that the response can be aligned.
  """

  use OpenRtbEcto.SafeSchema

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
    |> safe_cast(attrs, [
      :id,
      :required,
      :ext
    ])
    |> safe_cast_embed(:title)
    |> safe_cast_embed(:img)
    |> safe_cast_embed(:video)
    |> safe_cast_embed(:data)
    |> safe_cast_embed(:link)
    |> Helper.validate_media()
  end
end
