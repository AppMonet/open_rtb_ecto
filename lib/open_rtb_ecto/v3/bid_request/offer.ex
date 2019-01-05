defmodule OpenRtbEcto.V3.BidRequest.Offer do
  @moduledoc """
  This object is a collection of one or more “Item” objects representing the goods being sold. In
  addition to the item array, this collection also includes an indicator as to whether this collection
  of items constitutes all items in a given context (e.g., all impressions on a web page).
  """

  use Ecto.Schema
  import Ecto.Changeset

  alias OpenRtbEcto.V3.BidRequest.Item

  @primary_key false
  embedded_schema do
    field(:package, :integer, default: 0)
    field(:dburl)
    field(:ext, :map)
    embeds_many(:item, Item)
  end

  def changeset(offer, attrs \\ %{}) do
    offer
    |> cast(attrs, [:package, :dburl, :ext])
    |> cast_embed(:item, required: true)
    |> validate_inclusion(:package, 0..1)
  end
end
