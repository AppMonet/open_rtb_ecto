defmodule OpenRtbEcto.V2.Native.Response.Title do
  @moduledoc """
  Corresponds to the Title Object in the request, with the value filled in.
  """

  use OpenRtbEcto.SafeSchema

  @type t :: %__MODULE__{}

  embedded_schema do
    field(:text, :string)
    field(:len, :integer)
    field(:ext, :map, default: %{})
  end

  def changeset(title, attrs \\ %{}) do
    title
    |> safe_cast(attrs, [:text, :len, :ext])
    |> validate_required(:text)
  end
end
