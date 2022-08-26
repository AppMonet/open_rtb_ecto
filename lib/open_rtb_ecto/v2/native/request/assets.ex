defmodule OpenRtbEcto.V2.Native.Request.Assets do
  @moduledoc """
  The main container object for each asset requested or supported by Exchange on behalf of the rendering client.
  """

  use Ecto.Schema
  import Ecto.Changeset
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

  def changeset(request, attrs \\ %{}) do
    request
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
    |> validate_media()
  end

  defp validate_media(request) do
    # Each asset object may contain only one of title, img, data or video.
    media = [:title, :img, :data, :video]

    total =
      media
      |> Enum.each(fn field -> if get_field(request, field), do: 1, else: 0 end)
      |> Enum.sum()

    if total > 1,
      do:
        add_error(
          request,
          :media,
          "asset object may contain only one of title, img, data or video"
        )
  end
end
