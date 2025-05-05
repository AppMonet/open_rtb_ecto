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
    with %{valid?: true} = changeset <- schema.changeset(struct(schema, %{}), data) do
      {:ok, Ecto.Changeset.apply_changes(changeset)}
    else
      %Ecto.Changeset{} = invalid_changeset ->
        {:error, format_invalid_changeset(invalid_changeset)}
    end
  end

  def cast(schema, json) when is_binary(json) do
    with {:ok, decoded} <- JSON.decode(json) do
      cast(schema, decoded)
    end
  end

  def safe_cast_ext(changeset, attrs) do
    with {:ok, ext} when is_map(ext) <- fetch_ext(attrs),
         {:ok, casted} <- Ecto.Type.cast(:map, ext) do
      Ecto.Changeset.put_change(changeset, :ext, casted)
    else
      _ -> changeset
    end
  end

  def safe_cast_embeds_many(changeset, field, attrs) do
    with {:ok, embedded} when is_list(embedded) <- Map.fetch(attrs, field) do
      Ecto.Changeset.cast_embed(changeset, field, embedded)
    else
      _ -> changeset
    end
  end

  defp fetch_ext(attrs) do
    case attrs do
      %{"ext" => ext} -> {:ok, ext}
      %{ext: ext} -> {:ok, ext}
      _ -> :error
    end
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
