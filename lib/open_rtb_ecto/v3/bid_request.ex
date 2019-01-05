defmodule OpenRtbEcto.V3.BidRequest do
  @moduledoc """
  ### Bid Request Payload
  The request object contains minimal high-level attributes (e.g., its ID, test mode, auction type,
  maximum auction time, buyer restrictions, etc.) and subordinate objects that cover the source of
  the request and the actual offer of sale. The latter includes the item(s) being offered and any
  applicable deals.

  There are two points in this model that interface to Layer-4 domain objects: the “Request”
  object and the “Item” object. Domain objects included under “Request” would include those
  that provide context for the overall offer. These would include objects that describe the site or
  app, the device, the user, and others. Domain objects included in an “Item” object would
  specify details about the item being offered (e.g., the impression opportunity) and specifications
  and restrictions on the media that can be associated with acceptable bids.
  """
end
