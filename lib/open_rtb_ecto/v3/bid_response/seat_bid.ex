defmodule OpenRtbEcto.V3.BidResponse.SeatBid do
  @moduledoc """
  A bid response can contain multiple `Seatbid` objects, each on behalf of a different buyer seat and each containing one or more individual bids.  If multiple items are presented in the request offer, the `package` attribute can be used to specify if a seat is willing to accept any impressions that it can win (default) or if it is interested in winning any only if it can win them all as a group.

  <table>
    <tr>
       <td><strong>Attribute&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</strong></td>
      <td><strong>Type&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</strong></td>
     <td><strong>Definition</strong></td>
    </tr>
    <tr>
      <td><code>seat</code></td>
      <td>string, recommended</td>
      <td>ID of the buyer seat on whose behalf this bid is made.</td>
    </tr>
    <tr>
      <td><code>package</code></td>
      <td>integer;<br/>default&nbsp;0</td>
      <td>For offers with multiple items, this flag Indicates if the bidder is willing to accept wins on a subset of bids or requires the full group as a package, where 0 = individual wins accepted; 1 = package win or loss only.</td>
    </tr>
    <tr>
      <td><code>bid</code></td>
      <td>object&nbsp;array; required</td>
      <td>Array of 1+ <code>Bid</code> objects each related to an item.  Multiple bids can relate to the same item.  Refer to <a href="#object_bid">Object: Bid</a>.</td>
    </tr>
    <tr>
      <td><code>ext</code></td>
      <td>object</td>
      <td>Optional demand source specific extensions.</td>
    </tr>
  </table>
  """

  use Ecto.Schema
  import Ecto.Changeset

  alias OpenRtbEcto.Types.TinyInt
  alias OpenRtbEcto.BidResponse.Bid

  embedded_schema do
    field(:seat)
    field(:package, TinyInt, default: 0)
    embeds_many(:bid, Bid)
    field(:ext, :map, default: %{})
  end

  def changeset(seat_bid, attrs \\ %{}) do
    seat_bid
    |> cast(attrs, [:seat, :package, :ext])
    |> cast_embed(:bid, required: true)
  end
end
