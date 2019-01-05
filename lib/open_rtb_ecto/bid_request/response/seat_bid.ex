defmodule OpenRtbEcto.BidRequest.Response.SeatBid do
  @moduledoc """
  A bid response can contain multiple “Seatbid” objects, each on behalf of a different buyer seat
  and each containing one or more individual bids. If multiple items are presented in the request
  offer, the “package” attribute can be used to specify if a seat is willing to accept any
  impressions that it can win (default) or if it is interested in winning any only if it can win them all
  as a group.

  |Attribute|Type|Definition|
  |seat|string|ID of the buyer seat on whose behalf this bid is made.|
  |package|integer; default 0|For offers with multiple items, this flag Indicates if the bidder is willing to accept wins on a subset of bids or requires the full group as a package, where 0 = individual wins accepted; 1 = package win or loss only.|
  |bid|object array; required|Array of 1+ “Bid” objects each related to an item. Multiple bids can relate to the same item.|
  |ext|object|Optional demand source specific extensions.|
  """

  use Ecto.Schema
  import Ecto.Changeset

  @primary_key false
  embedded_schema do
    field(:seat)
    field(:package, :integer, default: 0)
    field(:ext, :map)
    embeds_many(:bid, Bid)
  end
end
