defmodule OpenRtbEcto.V3.BidRequest.Item do
  @moduledoc """
  This object represents a unit of goods being offered for sale either on the open market or in
  relation to a private marketplace deal. The “id” attribute is required since there may be multiple
  items being offered in the same bid request and bids must reference the specific item of
  interest. This object interfaces to Layer-4 domain objects for deeper specification of the item
  being offered (e.g., an impression).
  """

  use Ecto.Schema
  import Ecto.Changeset

  alias OpenRtbEcto.V3.BidRequest.Pmp

  @primary_key false
  embedded_schema do
    field(:id)
    field(:qty, :integer, default: 1)
    field(:flr, :float)
    field(:flrcur, :string, default: "USD")
    field(:seq, :integer)
    field(:domain, :map)
    field(:ext, :map)
    embeds_one(:pmp, Pmp)
  end

  def changeset(item, attrs \\ %{}) do
    item
    |> cast(attrs, [:id, :qty, :flr, :flrcur, :seq, :domain, :ext])
    |> cast_embed(:pmp)
    |> validate_required([:id, :domain])
  end
end
