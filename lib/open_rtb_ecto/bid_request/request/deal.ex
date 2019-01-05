defmodule OpenRtbEcto.BidRequest.Request.Deal do
  @moduledoc """
  This object constitutes a specific deal that was struck a priori between a seller and a buyer. Its
  presence within the “Pmp” collection indicates that this impression is available under the terms of
  that deal.

  |Attribute|Type|Definition|
  |id|string; required|A unique identifier for the deal.|
  |qty|integer|Number of instances of the item to which the deal applies. Default is the full quantity specified in the “item.qty” attribute.|
  |flr|float|Minimum deal price for this item expressed in CPM|
  |flrcur|string; default “USD”|Currency of the “flr” attribute specified using ISO-4217 alpha codes. at integer Optional override of the overall auction type of the request, where 1 = First Price, 2 = Second Price Plus, 3 = the value passed in “flr” is the agreed upon deal price. Additional auction types can be defined by the exchange.|
  |seat|string array|Whitelist of buyer seats allowed to bid on this deal. IDs of seats and the buyer’s customers to which they refer must be coordinated between bidders and the exchange a priori. Omission implies no restrictions.|
  |wadomain|string array|Array of advertiser domains (e.g., advertiser.com) allowed to bid on this deal. Omission implies no restrictions.|
  |ext|object|Optional exchange-specific extensions.|
  """

  use Ecto.Schema
  import Ecto.Changeset

  @primary_key false
  embedded_schema do
    field(:id)
    field(:qty, :integer)
    field(:flr, :float)
    field(:flrcur, :string, default: "USD")
    field(:seat, {:array, :string})
    field(:wadomain, {:array, :string})
    field(:ext, :map)
  end
end
