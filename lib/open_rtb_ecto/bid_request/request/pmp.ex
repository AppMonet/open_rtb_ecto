defmodule OpenRtbEcto.BidRequest.Request.Pmp do
  @moduledoc """
  This object is the private marketplace container for direct deals between sellers and buyers that
  may pertain to this item. The actual deals are represented as a collection of “Deal” objects.

  |Attribute|Type|Definition|
  |private|integer; default 0|Indicator of auction eligibility to seats named in “Deal” objects, where 0 = all bids are accepted, 1 = bids are restricted to the deals specified and the terms thereof.|
  |deal|object array|Array of “Deal” objects that convey special terms applicable to this item.|
  |ext|object|Optional exchange-specific extensions.|
  """

  use Ecto.Schema
  import Ecto.Changeset

  @primary_key false
  embedded_schema do
    field(:private, :integer, default: 0)
    field(:deal, {:array, Deal})
    field(:ext, :map)
  end
end
