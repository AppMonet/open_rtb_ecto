defmodule OpenRtbEcto.V2.BidResponse do
  @moduledoc """
  This object is the top-level bid response object (i.e., the unnamed outer JSON object). The id attribute
  is a reflection of the bid request ID for logging purposes. Similarly, bidid is an optional response
  tracking ID for bidders. If specified, it can be included in the subsequent win notice call if the bidder
  wins. At least one seatbid object is required, which contains at least one bid for an impression. Other
  attributes are optional.

  To express a “no-bid”, the options are to return an empty response with HTTP 204. Alternately if the
  bidder wishes to convey to the exchange a reason for not bidding, just a BidResponse object is
  returned with a reason code in the nbr attribute.
  """

  use Ecto.Schema
  import Ecto.Changeset

  alias OpenRtbEcto.V2.BidResponse.SeatBid

  @primary_key false
  embedded_schema do
    field(:id)
    embeds_many(:seatbid, SeatBid)
    field(:bidid)
    field(:cur)
    field(:customdata)
    field(:nbr, :integer)
    field(:ext, :map)
  end

  def changeset(response, attrs \\ %{}) do
    response
    |> cast(attrs, [:id, :bidid, :cur, :customdata, :ext])
    |> cast_embed(:seatbid)
    |> validate_required(:id)
    |> validate_inclusion(:nbr, 0..10)
  end
end
