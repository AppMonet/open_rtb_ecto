defmodule OpenRtbEcto.BidRequest.Response.Bid do
  @moduledoc """
  A “Seatbid” object contains one or more “Bid” objects, each of which relates to a specific item
  in the bid request offer via the “item” attribute and constitutes an offer to buy that item for a
  given price.

  |Attribute|Type|Definition|
  |id|string; recommended|Bidder generated bid ID to assist with logging/tracking.|
  |item|string; required|ID of the item object in the related bid request; specifically “item.id”.|
  |deal|string|Reference to a deal from the bid request if this bid pertains to a private marketplace deal; specifically “deal.id”.|
  |price|float; required|Bid price expressed as CPM although the actual transaction is for a unit item only. Note that while the type indicates float, integer math is highly recommended when handling currencies (e.g., BigDecimal in Java).|
  |cid|string|ID of a campaign of other logical grouping to which the media to be presented if the bid is won belongs.|
  |tactic|string|Tactic ID to enable buyers to label bids for reporting to the exchange the tactic through which their bid was submitted. The specific usage and meaning of the tactic ID should be communicated between buyer and exchanges a priori.|
  |burl|string|Billing notice URL called by the supply partner when a winning bid becomes billable based on exchange-specific business policy (e.g., markup rendered). Substitution macros may be included. One of burl in the response or dburl in the request must be present (exception for VAST).|
  |lurl|string|Loss notice URL called by the supply partner when a bid is known to have been lost. Substitution macros may be included. Exchange-specific policy may preclude support for loss notices or the disclosure of winning clearing prices resulting in ${OPENRTB_PRICE} macros being removed (i.e., replaced with a zero-length string).|
  |domain|object; required|Layer-4 domain object structure that specifies the media to be presented if the bid is won (e.g., creative) conforming to the specification and version referenced in “openrtb.domainspec” and “openrtb.domainver”.|
  |ext|object|Optional demand source specific extensions.|
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
end
