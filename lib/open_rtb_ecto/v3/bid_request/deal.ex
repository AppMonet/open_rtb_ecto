defmodule OpenRtbEcto.V3.BidRequest.Deal do
  @moduledoc """
  This object constitutes a specific deal that was struck a priori between a seller and a buyer. Its
  presence within the “Pmp” collection indicates that this impression is available under the terms of
  that deal.
  """

  use Ecto.Schema
  import Ecto.Changeset

  @primary_key false
  embedded_schema do
    field(:id)
    field(:qty, :integer)
    field(:flr, :float)
    field(:flrcur, :string, default: "USD")
    field(:at, :integer)
    field(:seat, {:array, :string})
    field(:wadomain, {:array, :string})
    field(:ext, :map)
  end

  def changeset(deal, attrs \\ %{}) do
    deal
    |> cast(attrs, [:id, :qty, :flr, :flrcur, :at, :seat, :wadomain, :ext])
    |> validate_required(:id)
    |> validate_number(:qty, greater_than: 0)
    |> validate_number(:flr, greater_than: 0)
  end
end
