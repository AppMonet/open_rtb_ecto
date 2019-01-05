defmodule OpenRtbEcto.V3.BidResponse.SeatBid do
  @moduledoc """
  A bid response can contain multiple “Seatbid” objects, each on behalf of a different buyer seat
  and each containing one or more individual bids. If multiple items are presented in the request
  offer, the “package” attribute can be used to specify if a seat is willing to accept any
  impressions that it can win (default) or if it is interested in winning any only if it can win them all
  as a group.
  """

  use Ecto.Schema
  import Ecto.Changeset

  alias OpenRtbEcto.BidResponse.Bid

  @primary_key false
  embedded_schema do
    field(:seat)
    field(:package, :integer, default: 0)
    field(:ext, :map)
    embeds_many(:bid, Bid)
  end

  def changeset(seat_bid, attrs \\ %{}) do
    seat_bid
    |> cast(attrs, [:seat, :package, :ext])
    |> validate_inclusion(:package, 0..1)
    |> cast_embed(:bid, required: true)
    |> validate_length(:bid, min: 1)
  end
end
