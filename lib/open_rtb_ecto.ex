defmodule OpenRtbEcto do
  @moduledoc """
  Ecto schemas for OpenRTB 2.x & 3.0 according to the following specifications:

  [OpenRTB 2.0 Spec](https://www.iab.com/wp-content/uploads/2015/06/OpenRTB_API_Specification_Version2_0_FINAL.pdf)
  [OpenRTB 2.5 Spec](https://www.iab.com/wp-content/uploads/2016/03/OpenRTB-API-Specification-Version-2-5-FINAL.pdf)
  [OpenRTB 2.6 Spec](https://iabtechlab.com/wp-content/uploads/2022/04/OpenRTB-2-6_FINAL.pdf)

  [OpenRTB 3.0 Spec](https://iabtechlab.com/wp-content/uploads/2017/09/OpenRTB-3.0-Draft-Framework-for-Public-Comment.pdf)
  """

  @typedoc "Any of the schemas defined in the library"
  @type open_rtb_schema :: term()

  @spec cast(open_rtb_schema(), map() | binary()) :: {:ok, struct()} | {:error, map()}
  def cast(schema, %{} = data) do
    changeset = schema.changeset(struct(schema, %{}), data)

    if changeset.valid? do
      {:ok, Ecto.Changeset.apply_changes(changeset)}
    else
      # Check if errors are only on optional fields
      if has_required_field_errors?(changeset) do
        {:error, format_invalid_changeset(changeset)}
      else
        # If only optional fields had errors, they've been discarded
        # by our safe_cast functions, so we can apply the changes
        {:ok, Ecto.Changeset.apply_changes(changeset)}
      end
    end
  end

  def cast(schema, json) when is_binary(json) do
    with {:ok, decoded} <- JSON.decode(json) do
      cast(schema, decoded)
    end
  end

  defp has_required_field_errors?(changeset) do
    # First, get all fields marked as required via validate_required
    required_fields = changeset.required
    
    # Special case: Treat media validation errors as required field errors
    # This ensures that assets with multiple media types are considered invalid
    has_media_error = Enum.any?(changeset.errors, fn {field, _error} -> 
      field == :media
    end)
    
    # Check for either required field errors or media errors
    has_media_error || Enum.any?(changeset.errors, fn {field, _error} ->
      field in required_fields
    end)
  end

  defp format_invalid_changeset(changeset) do
    Ecto.Changeset.traverse_errors(changeset, fn chg, atom, {msg, opts} ->
      input = Ecto.Changeset.get_field(chg, atom)
      msg = msg <> ", got #{inspect(input, charlists: :as_lists)}"

      Enum.reduce(opts, msg, fn
        {key, value}, acc ->
          String.replace(acc, "%{#{key}}", inspect(value))
      end)
    end)
  end
end
