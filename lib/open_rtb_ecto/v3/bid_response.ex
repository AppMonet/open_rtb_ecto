defmodule OpenRtbEcto.V3.BidResponse do
  @moduledoc """
  ### Bid Response Payload
  The response object contains minimal high-level attributes (e.g., reference to the request ID, bid
  currency, etc.) and an array of seat bids, each of which is a set of bids on behalf of a buyer seat.

  The individual bid references the item in the request to which it pertains and buying information
  such as the price, a deal ID if applicable, and notification URLs. The media related to a bid is
  conveyed via Layer-4 domain objects (i.e., ad creative, markup) included in each bid.
  """
end
