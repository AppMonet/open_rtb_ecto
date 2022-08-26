defmodule OpenRtbEcto.V2.Native.Response.Data do
  @moduledoc """
  Corresponds to the Data Object in the request, with the value filled in.
  The Data Object is to be used for all miscellaneous elements of the native unit such as
  Brand Name, Ratings, Review Count, Stars, Downloads, Price count etc. It is also generic for
  future native elements not contemplated at the time of the writing of this document.
  """

  use Ecto.Schema
  import Ecto.Changeset

  @type t :: %__MODULE__{}

  embedded_schema do
    field(:type, :integer)
    field(:len, :integer)
    field(:value, :string)
    field(:ext, :map, default: %{})
  end

  def changeset(data, attrs \\ %{}) do
    data
    |> cast(attrs, [
      :type,
      :len,
      :value,
      :ext
    ])
    |> validate_required(:value)
  end
end
