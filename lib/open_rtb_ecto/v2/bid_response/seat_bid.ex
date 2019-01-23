defmodule OpenRtbEcto.V2.BidResponse.SeatBid do
  @moduledoc """
  A bid response can contain multiple SeatBid objects, each on behalf of a different bidder seat and
  each containing one or more individual bids. If multiple impressions are presented in the request,
  the group attribute can be used to specify if a seat is willing to accept any impressions that it
  can win (default) or if it is only interested in winning any if it can win them all as a group.
  """

  use Ecto.Schema
  import Ecto.Changeset

  alias OpenRtbEcto.Types.TinyInt
  alias OpenRtbEcto.V2.BidResponse.Bid

  @type t :: %__MODULE__{}

  @primary_key false
  embedded_schema do
    embeds_many(:bid, Bid)
    field(:seat)
    field(:group, TinyInt, default: 0)
    field(:ext, :map, default: %{})
  end

  def changeset(seat_bid, attrs \\ %{}) do
    seat_bid
    |> cast(attrs, [:seat, :group, :ext])
    |> cast_embed(:bid, required: true)
  end
end
