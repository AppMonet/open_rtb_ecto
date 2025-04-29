defmodule OpenRtbEcto.V2.Native.Helper do
  import Ecto.Changeset

  @doc """
  Validates that there is max one item from the media list present in the changeset of the response and request
  asset objects.

  If multiple media items are present, keeps only the first one encountered in the priority order.
  """
  @spec validate_media(Ecto.Changeset.t()) :: Ecto.Changeset.t()
  def validate_media(changeset) do
    media = [:title, :img, :data, :video]

    present_media =
      media
      |> Enum.filter(fn field -> get_field(changeset, field) end)

    if length(present_media) > 1 do
      # Keep only the first media item and remove the rest
      [_to_keep | to_remove] = present_media

      # Remove all media items except the first one
      Enum.reduce(to_remove, changeset, fn field, acc ->
        delete_change(acc, field)
      end)
    else
      changeset
    end
  end
end
