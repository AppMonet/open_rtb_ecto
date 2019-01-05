defmodule OpenRtbEcto.BidRequest.Request.Offer do
  @moduledoc """
  This object is a collection of one or more “Item” objects representing the goods being sold. In
  addition to the item array, this collection also includes an indicator as to whether this collection
  of items constitutes all items in a given context (e.g., all impressions on a web page).

  |Attribute|Type|Definition|
  |item|object array; required|Array of “Item” objects (at least one) that constitute the set of goods being offered for sale.|
  |package|integer; default 0|Flag to indicate if the Exchange can verify that the items offered represent all of the items available in context (e.g., all impressions on a web page, all video spots such as pre/mid/post roll) to support roadblocking, where 0 = no or unknown, 1 = yes.|
  |dburl|string|Billing notice URL called by the demand partner when a winning bid becomes billable based on partner-specific business policy. Substitution macros may be included. One of burl in response or dburl in request is required (exception for VAST).|
  |ext|object|Optional exchange-specific extensions.|
  """

  use Ecto.Schema
  import Ecto.Changeset

  alias OpenRtbEcto.BidRequest.Item

  @primary_key false
  embedded_schema do
    field(:item, {:array, Item})
    field(:package, :integer, default: 0)
    field(:dburl)
    field(:ext, :map)
  end
end
