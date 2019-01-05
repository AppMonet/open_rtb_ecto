defmodule OpenRtbEcto.BidRequest.Request.Item do
  @moduledoc """
  This object represents a unit of goods being offered for sale either on the open market or in
  relation to a private marketplace deal. The “id” attribute is required since there may be multiple
  items being offered in the same bid request and bids must reference the specific item of
  interest. This object interfaces to Layer-4 domain objects for deeper specification of the item
  being offered (e.g., an impression).

  |Attribute|Type|Definition|
  |id|string; required|A unique identifier for this item within the context of the offer (typically starts with 1 and increments).|
  |qty|integer; default 1|The number of instances of this item being offered (e.g., multiple identical impressions in a digital out-of-home scenario).|
  |flr|float|Minimum bid price for this item expressed in CPM.|
  |flrcur|string; default “USD”|Currency of the “flr” attribute specified using ISO-4217 alpha codes.|
  |seq|integer|If multiple items are offered in the same bid request, the sequence number allows for the coordinated delivery.|
  |pmp|object|A “Pmp” object containing any private marketplace deals for this item.|
  |domain|object; required|Layer-4 domain object structure that specifies the item being offered (e.g., impression) conforming to the specification and version referenced in “openrtb.domainspec” and “openrtb.domainver”.|
  |ext|object Optional|exchange-specific extensions.|
  """

  use Ecto.Schema
  import Ecto.Changeset

  alias OpenRtbEcto.BidRequest.Pmp

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
end
