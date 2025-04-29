defmodule OpenRtbEcto.DiscardInvalid do
  @moduledoc """
  Helper functions for handling invalid optional fields in OpenRTB schemas.

  This module helps ensure that invalid data in optional fields is discarded
  rather than marking the entire changeset as invalid.

  NOTE: This module is superseded by OpenRtbEcto.SafeSchema. Use that module
  instead in all new schemas.
  """

  import Ecto.Changeset

  @doc """
  Safely casts a field, discarding invalid values instead of marking the changeset as invalid.

  When the field's value is invalid, it simply won't be included in the changeset changes.
  """
  def safe_cast(changeset, fields, _opts \\ []) when is_list(fields) do
    Enum.reduce(fields, changeset, fn field, acc ->
      case get_change(acc, field) do
        # Skip if the field is not in the changes or already nil
        nil ->
          acc

        value ->
          type = changeset.types[field]

          case Ecto.Type.cast(type, value) do
            {:ok, _} -> acc
            :error -> delete_change(acc, field)
          end
      end
    end)
  end
end
