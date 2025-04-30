defmodule OpenRtbEcto.V2.Native.Request.Title do
  @moduledoc """
  The Title object is to be used for title element of the Native ad.
  """

  use OpenRtbEcto.SafeSchema

  @type t :: %__MODULE__{}

  embedded_schema do
    field(:len, :integer)
    field(:ext, :map, default: %{})
  end

  def changeset(title, attrs \\ %{}) do
    title
    |> safe_cast(attrs, [:len, :ext])
    |> validate_required(:len)
  end
end
