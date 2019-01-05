defmodule OpenRtbEcto.V2.BidResponse do
  @moduledoc """
  The top-level bid response object is defined below. The “id” attribute is a reflection of the bid
  request ID for logging purposes. Similarly, “bidid” is an optional response tracking ID for
  bidders. If specified, it can be included in the subsequent win notice call if the bidder wins. At
  least one “seatbid” object is required, which contains a bid on at least one impression. Other
  attributes are optional since an exchange may establish default values.
  No-Bids on all impressions should be indicated as a HTTP 204 response. For no-bids on specific
  impressions, the bidder should omit these from the bid response.
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
    field(:ext, :map)
  end

  def changeset(response, attrs \\ %{}) do
    response
    |> cast(attrs, [:id, :bidid, :cur, :customdata, :ext])
    |> cast_embed(:seatbid)
    |> validate_required([:id, :seatbid])
  end
end
