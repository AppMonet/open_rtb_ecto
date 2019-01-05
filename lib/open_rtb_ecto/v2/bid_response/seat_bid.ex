defmodule OpenRtbEcto.V2.BidResponse.SeatBid do
  @moduledoc """
  A bid response can contain multiple “seatbid” objects, each on behalf of a different bidder seat.
  Since a bid request can include multiple impressions, each “seatbid” object can contain multiple
  bids each pertaining to a different impression on behalf of a seat. Thus, each “bid” object must
  include the impression ID to which it pertains as well as the bid price. The “group” attribute can
  be used to specify if a seat is willing to accept any impressions that it can win (default) or if it is
  only interested in winning any if it can win them all (i.e., all or nothing).
  """

  use Ecto.Schema
  import Ecto.Changeset

  alias OpenRtbEcto.V2.BidResponse.Bid

  @primary_key false
  embedded_schema do
    embeds_many(:bid, Bid)
    field(:seat)
    field(:group, :integer, default: 0)
  end

  def changeset(seat_bid, attrs \\ %{}) do
    seat_bid
    |> cast(attrs, [:seat, :group])
    |> cast_embed(:bid)
    |> validate_required([:bid])
    |> validate_inclusion(:group, 0..1)
  end
end
