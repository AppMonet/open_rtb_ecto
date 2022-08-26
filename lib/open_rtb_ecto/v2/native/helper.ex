defmodule OpenRtbEcto.V2.Native.Helper do
  import Ecto.Changeset

  # Each object may contain only one of title, img, data or video.
  def validate_media(asset) do
    media = [:title, :img, :data, :video]

    total =
      media
      |> Enum.map(fn field -> if get_field(asset, field), do: 1, else: 0 end)
      |> Enum.sum()

    if total > 1 do
      add_error(
        asset,
        :media,
        "asset object may contain only one of title, img, data or video"
      )
    else
      asset
    end
  end
end
