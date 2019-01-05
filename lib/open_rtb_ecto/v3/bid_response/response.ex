defmodule OpenRtbEcto.V3.BidResponse.Response do
  @moduledoc """
  This object is the bid response object under the “Openrtb” root. Its “id” attribute is a reflection
  of the bid request ID. The “bidid” attribute is an optional response tracking ID for bidders. If
  specified, it will be available for use in substitution macros placed in markup and notification
  URLs. At least one “Seatbid” object is required, which contains at least one “Bid” for an item.
  Other attributes are optional.
  To express a “no-bid”, the most compact option is simply to return an empty response with
  HTTP 204. However, if the bidder wishes to convey a reason for not bidding, a “Response”
  object can be returned with just a reason code in the “nbr” attribute.
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

  def changeset(response, attrs \\ %{}) do
    response
    |> cast(attrs, [:id, :bidid, :nbr, :cur, :cdata, :ext])
    |> cast_embed(:seatbid)
    |> validate_required(:id)
  end
end
