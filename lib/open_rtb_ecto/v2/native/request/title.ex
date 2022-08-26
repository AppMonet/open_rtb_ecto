defmodule OpenRtbEcto.V2.Native.Request.Title do
  @moduledoc """
  The Title object is to be used for title element of the Native ad.
  """

  use Ecto.Schema
  import Ecto.Changeset

  embedded_schema do
    field(:len, :integer)
    field(:ext, :map, default: %{})
  end

  def changeset(request, attrs \\ %{}) do
    request
    |> cast(attrs, [:len, :ext])
    |> validate_required(:len)
  end
end
