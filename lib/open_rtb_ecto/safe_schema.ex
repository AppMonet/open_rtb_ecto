defmodule OpenRtbEcto.SafeSchema do
  @moduledoc """
  Provides helper macros and functions for creating schemas that discard invalid optional fields
  rather than marking the entire changeset as invalid.

  This module is designed to be used with `use OpenRtbEcto.SafeSchema` in schema modules.
  """

  defmacro __using__(_) do
    quote do
      use Ecto.Schema
      import Ecto.Changeset
      import OpenRtbEcto.SafeSchema

      @before_compile OpenRtbEcto.SafeSchema
    end
  end

  defmacro __before_compile__(_env) do
    quote do
      @doc """
      A version of cast_embed that discards invalid optional embeds instead of invalidating the changeset.

      This should be used for optional embeds where you want to discard invalid data rather than
      marking the entire changeset as invalid.
      """
      def safe_cast_embed(changeset, field, opts \\ []) do
        # If required, use normal cast_embed
        if Keyword.get(opts, :required, false) do
          cast_embed(changeset, field, opts)
        else
          # Try to cast the embed
          result = cast_embed(changeset, field, opts)

          # If errors were added for this field, discard the embed
          case result.errors do
            errors when is_list(errors) ->
              field_errors = Enum.filter(errors, fn {err_field, _} -> err_field == field end)

              if field_errors != [] do
                # Remove the errors and the field from changes
                %{result | errors: result.errors -- field_errors}
                |> delete_change(field)
              else
                result
              end

            _ ->
              result
          end
        end
      end

      @doc """
      A version of cast that discards invalid optional fields instead of invalidating the changeset.

      This should be used for fields where you want to discard invalid data rather than
      marking the entire changeset as invalid.
      """
      def safe_cast(changeset, attrs, permitted) when is_map(attrs) do
        # List of fields that are required (should not be discarded)
        required = Keyword.get(permitted, :required, [])

        permitted_fields =
          if is_list(permitted), do: permitted, else: Keyword.get(permitted, :fields, [])

        # First do a normal cast
        result = cast(changeset, attrs, permitted_fields)

        # For each field with an error that's not required, discard it
        case result.errors do
          errors when is_list(errors) ->
            Enum.reduce(errors, result, fn {field, _}, acc ->
              # Only discard errors for fields that are not required
              if field not in required and field in permitted_fields do
                # Remove this error and delete the change
                %{
                  acc
                  | errors: acc.errors -- Enum.filter(acc.errors, fn {f, _} -> f == field end)
                }
                |> delete_change(field)
              else
                acc
              end
            end)

          _ ->
            result
        end
      end
    end
  end
end
