defmodule OpenRtbEcto.V2.Native.Request.Data do
  @moduledoc """
  The Data Object is to be used for all non-core elements of the native unit such as Brand Name,
  Ratings, Review Count, Stars, Download count, descriptions etc. It is also generic for
  future native elements not contemplated at the time of the writing of this document. In some cases,
  additional recommendations are also included in the Data Asset Types table.
  """

  use Ecto.Schema
  import Ecto.Changeset

  @type t :: %__MODULE__{}

  embedded_schema do
    field(:type, :integer)
    field(:len, :integer)
    field(:ext, :map, default: %{})
  end

  def changeset(data, attrs \\ %{}) do
    data
    |> cast(attrs, [
      :type,
      :len,
      :ext
    ])
    |> validate_required(:type)
  end
end
