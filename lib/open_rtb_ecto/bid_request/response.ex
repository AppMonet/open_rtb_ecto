defmodule OpenRtbEcto.BidRequest.Response do
  @moduledoc """
  This object is the bid response object under the “Openrtb” root. Its “id” attribute is a reflection
  of the bid request ID. The “bidid” attribute is an optional response tracking ID for bidders. If
  specified, it will be available for use in substitution macros placed in markup and notification
  URLs. At least one “Seatbid” object is required, which contains at least one “Bid” for an item.
  Other attributes are optional.
  To express a “no-bid”, the most compact option is simply to return an empty response with
  HTTP 204. However, if the bidder wishes to convey a reason for not bidding, a “Response”
  object can be returned with just a reason code in the “nbr” attribute.


  |Attribute|Type|Definition|
  |id|string; required|ID of the bid request to which this is a response; must match the “request.id” attribute.|
  |bidid|string|Bidder generated response ID to assist with logging/tracking.|
  |nbr|integer|Reason for not bidding if applicable (see Enumerations).|
  |cur|string|Bid currency using ISO-4217 alpha codes.|
  |cdata|string|Allows bidder to set data in the exchange’s cookie if supported by the exchange. The string must be in base85 cookie-safe characters. JSON encoding must be used to include “escaped” quotation marks.|
  |seatbid|object array|Array of “Seatbid” objects; 1+ required if a bid is to be made.|
  |ext|object|Optional demand source specific extensions.|
  """

  use Ecto.Schema
  import Ecto.Changeset

  @primary_key false
  embedded_schema do
    field(:id)
    field(:bidid)
    field(:nbr, :integer)
    field(:cur)
    field(:cdata)
    field(:ext, :map)
    embeds_many(:seatbid, Seatbid)
  end
end
