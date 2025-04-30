defmodule OpenRtbEcto.V2.Native.Helper do
  import Ecto.Changeset

  @doc """
  Validates that there is max one item from the media list present in the changeset of the response and request
  asset objects.
  """
  @spec validate_media(Ecto.Changeset.t()) :: Ecto.Changeset.t()
  def validate_media(changeset) do
    media = [:title, :img, :data, :video]

    total =
      media
      |> Enum.map(fn field -> if get_field(changeset, field), do: 1, else: 0 end)
      |> Enum.sum()

    if total > 1 do
      add_error(
        changeset,
        :media,
        "changeset object may contain only one of title, img, data or video"
      )
    else
      changeset
    end
  end
end
