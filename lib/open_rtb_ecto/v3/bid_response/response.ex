defmodule OpenRtbEcto.V3.BidResponse.Response do
  @moduledoc """
  This object is the bid response object under the `Openrtb` root.  Its `id` attribute is a reflection of the bid request ID.  The `bidid` attribute is an optional response tracking ID for bidders.  If specified, it will be available for use in substitution macros placed in markup and notification URLs.  At least one `Seatbid` object is required, which contains at least one `Bid` for an item.  Other attributes are optional.

  To express a “no-bid”, the most compact option is simply to return an empty response with HTTP 204.  However, if the bidder wishes to convey a reason for not bidding, a `Response` object can be returned with just a reason code in the `nbr` attribute.

  <table>
    <tr>
      <td><strong>Attribute&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</strong></td>
      <td><strong>Type&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</strong></td>
      <td><strong>Definition</strong></td>
    </tr>
    <tr>
      <td><code>id</code></td>
      <td>string; required</td>
      <td>ID of the bid request to which this is a response; must match the <code>request.id</code> attribute.</td>
    </tr>
    <tr>
      <td><code>bidid</code></td>
      <td>string</td>
      <td>Bidder generated response ID to assist with logging/tracking.</td>
    </tr>
    <tr>
      <td><code>nbr</code></td>
      <td>integer</td>
      <td>Reason for not bidding if applicable (see <a href="#list_nobidreasoncodes">List: No-Bid Reason Codes</a>).  Note that while many exchanges prefer a simple HTTP 204 response to indicate a no-bid, responses indicating a reason code can be useful in debugging scenarios.</td>
    </tr>
    <tr>
      <td><code>cur</code></td>
      <td>string;<br/>default&nbsp;“USD”</td>
      <td>Bid currency using ISO-4217 alpha codes.</td>
    </tr>
    <tr>
      <td><code>cdata</code></td>
      <td>string</td>
      <td>Allows bidder to set data in the exchange’s cookie, which can be retrieved on bid requests (refer to <code>cdata</code> in <a href="#object_request">Object: Request</a>) if supported by the exchange.  The string must be in base85 cookie-safe characters.</td>
    </tr>
    <tr>
      <td><code>seatbid</code></td>
      <td>object&nbsp;array</td>
      <td>Array of <code>Seatbid</code> objects; 1+ required if a bid is to be made.  Refer to <a href="#object_seatbid">Object: Seatbid</a>.</td>
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

  @primary_key false
  embedded_schema do
    field(:id)
    field(:bidid)
    field(:nbr, :integer)
    field(:cur, :string, default: "USD")
    field(:cdata)
    embeds_many(:seatbid, Seatbid)
    field(:ext, :map)
  end

  def changeset(response, attrs \\ %{}) do
    response
    |> cast(attrs, [:id, :bidid, :nbr, :cur, :cdata, :ext])
    |> cast_embed(:seatbid)
    |> validate_required(:id)
    |> validate_nbr()
  end

  defp validate_nbr(changeset) do
    case get_change(changeset, :nbr) do
      nil -> changeset
      val when (val >= 0 and val <= 15) or val > 500 -> changeset
      _ -> add_error(changeset, :at, "must equal 1, 2 or be greater than 500")
    end
  end
end
