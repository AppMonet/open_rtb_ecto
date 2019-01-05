defmodule OpenRtbEcto.V3.BidResponse.Bid do
  @moduledoc """
  A “Seatbid” object contains one or more “Bid” objects, each of which relates to a specific item
  in the bid request offer via the “item” attribute and constitutes an offer to buy that item for a
  given price.
  """

  use Ecto.Schema
  import Ecto.Changeset

  @primary_key false
  embedded_schema do
    field(:id)
    field(:item)
    field(:deal)
    field(:price, :float)
    field(:cid)
    field(:tactic)
    field(:burl)
    field(:lurl)
    field(:domain, :map)
    field(:ext, :map)
  end

  def changeset(bid, attrs \\ %{}) do
    bid
    |> cast(attrs, [:id, :item, :deal, :price, :cid, :tactic, :burl, :lurl, :domain, :ext])
    |> validate_required([:item, :price, :domain])
  end
end
