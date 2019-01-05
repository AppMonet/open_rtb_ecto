defmodule OpenRtbEcto.BidRequest.Request do
  @moduledoc """
  The “Request” object contains a globally unique bid request ID. This “id” attribute is required
  as is an “Offer” with at least one “Item” object. Other attributes establish rules and
  restrictions that apply to all items being offered. This object also interfaces to Layer-4 domain
  objects for context such as the user, device, site or app, etc.

  ### Fields
  |Attribute|Type|Definition|
  |id|string; required|Unique ID of the bid request; provided by the exchange.|
  |test|integer; default 0|Indicator of test mode in which auctions are not billable, where 0 = live mode, 1 = test mode.|
  |tmax|integer|Maximum time in milliseconds the exchange allows for bids to be received including Internet latency to avoid timeout. This value supersedes any a priori guidance from the exchange.|
  |at|integer; default 2|Auction type, where 1 = First Price, 2 = Second Price Plus. Values greater than 500 can be used for exchange-specific auction types.|
  |curs|string array, default [“USD”]|Array of currencies for bids on this bid request using ISO-4217 alpha codes. Recommended if the exchange accepts multiple currencies. If omitted, the single currency of “USD” is assumed.|
  |wcurs|integer; default 0|Flag that determines the restriction interpretation of the “curs” array, where 0 = block list, 1 = whitelist.|
  |seats|string array|Restriction list of buyer seats for bidding on this item. Knowledge of buyer’s customers and their seat IDs must be coordinated between parties a priori. Omission implies no restrictions.|
  |wseats|integer; default 0|Flag that determines the restriction interpretation of the “seats” array, where 0 = block list, 1 = whitelist.|
  |source|object|A “Source” object that provides data about the inventory source and which entity makes the final decision.|
  |offer|object; required|An “Offer” object that conveys the item(s) being offered for sale.|
  |domain|object; recommended|Layer-4 domain object structure that provides context for the items being offered (e.g., user, device, site or app, etc.) conforming to the specification and version referenced in “openrtb.domainspec” and “openrtb.domainver”.|
  |ext|object|Optional exchange-specific extensions.|
  """

  use Ecto.Schema
  import Ecto.Changeset

  alias OpenRtbEcto.BidRequest.{Source, Offer}

  @primary_key false
  embedded_schema do
    field(:id)
    field(:test, :integer)
    field(:tmax, :integer)
    field(:at, :integer)
    field(:curs, {:array, :string}, default: ["USD"])
    field(:wcurs, :integer)
    field(:seats, {:array, :string})
    field(:wseats, :integer, default: 0)
    field(:domain, :map)
    field(:ext, :map)
    embeds_one(:source, Source)
    embeds_one(:offer, Offer)
  end
end
