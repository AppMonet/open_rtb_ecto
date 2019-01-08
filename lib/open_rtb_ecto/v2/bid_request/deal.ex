defmodule OpenRtbEcto.V2.BidRequest.Deal do
  @moduledoc """
  This object constitutes a specific deal that was struck a priori between a buyer and a seller. Its presence
  with the Pmp collection indicates that this impression is available under the terms of that deal. Refer to
  Section 7.3 for more details.
  """

  use Ecto.Schema
  import Ecto.Changeset

  @primary_key false
  embedded_schema do
    field(:id)
    field(:bidfloor, :float, default: 0.0)
    field(:bidfloorcur, :string, default: "USD")
    field(:at, :integer)
    field(:wseat, {:array, :integer})
    field(:wadomain, {:array, :string})
    field(:ext, :map)
  end

  def changeset(deal, attrs \\ %{}) do
    deal
    |> cast(attrs, [:id, :bidfloor, :bidfloorcur, :at, :wseat, :wadomain, :ext])
    |> validate_inclusion(:at, 1..3)
  end
end
