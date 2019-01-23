defmodule OpenRtbEcto.V3.BidResponse.Bid do
  @moduledoc """
  A `Seatbid` object contains one or more `Bid` objects, each of which relates to a specific item in the bid request offer via the “item” attribute and constitutes an offer to buy that item for a given price.

  <table>
    <tr>
      <td><strong>Attribute&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</strong></td>
      <td><strong>Type&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</strong></td>
      <td><strong>Definition</strong></td>
    </tr>
    <tr>
      <td><code>id</code></td>
      <td>string; recommended</td>
      <td>Bidder generated bid ID to assist with logging/tracking.</td>
    </tr>
    <tr>
      <td><code>item</code></td>
      <td>string; required</td>
      <td>ID of the item object in the related bid request; specifically <code>item.id</code>.</td>
    </tr>
    <tr>
      <td><code>price</code></td>
      <td>float; required</td>
      <td>Bid price expressed as CPM although the actual transaction is for a unit item only.  Note that while the type indicates float, integer math is highly recommended when handling currencies (e.g., BigDecimal in Java).</td>
    </tr>
    <tr>
      <td><code>deal</code></td>
      <td>string</td>
      <td>Reference to a deal from the bid request if this bid pertains to a private marketplace deal; specifically <code>deal.id</code>.</td>
    </tr>
    <tr>
      <td><code>cid</code></td>
      <td>string</td>
      <td>Campaign ID or other similar grouping of brand-related ads.  Typically used to increase the efficiency of audit processes.</td>
    </tr>
    <tr>
      <td><code>tactic</code></td>
      <td>string</td>
      <td>Tactic ID to enable buyers to label bids for reporting to the exchange the tactic through which their bid was submitted.  The specific usage and meaning of the tactic ID should be communicated between buyer and exchanges <em>a priori</em>.</td>
    </tr>
    <tr>
      <td><code>purl</code></td>
      <td>string</td>
      <td>Pending notice URL called by the exchange when a bid has been declared the winner within the scope of an OpenRTB compliant supply chain (i.e., there may still be non-compliant decisioning such as header bidding).  Substitution macros may be included.</td>
    </tr>
    <tr>
      <td><code>burl</code></td>
      <td>string; recommended</td>
      <td>Billing notice URL called by the exchange when a winning bid becomes billable based on exchange-specific business policy (e.g., markup rendered).  Substitution macros may be included.</td>
    </tr>
    <tr>
      <td><code>lurl</code></td>
      <td>string</td>
      <td>Loss notice URL called by the exchange when a bid is known to have been lost.  Substitution macros may be included.  Exchange-specific policy may preclude support for loss notices or the disclosure of winning clearing prices resulting in <code>${OPENRTB_PRICE}</code> macros being removed (i.e., replaced with a zero-length string).</td>
    </tr>
    <tr>
      <td><code>exp</code></td>
      <td>integer</td>
      <td>Advisory as to the number of seconds the buyer is willing to wait between auction and fulfilment.</td>
    </tr>
    <tr>
      <td><code>mid</code></td>
      <td>string</td>
      <td>ID to enable media to be specified by reference if previously uploaded to the exchange rather than including it by value in the domain objects.</td>
    </tr>
    <tr>
      <td><code>macro</code></td>
      <td>object&nbsp;array</td>
      <td>Array of <code>Macro</code> objects that enable bid specific values to be substituted into markup; especially useful for previously uploaded media referenced via the <code>mid</code> attribute.  Refer to <a href="#object_macro">Object: Macro</a>.</td>
    </tr>
    <tr>
      <td><code>media</code></td>
      <td>object</td>
      <td>Layer-4 domain object structure that specifies the media to be presented if the bid is won conforming to the specification and version referenced in <code>openrtb.domainspec</code> and <code>openrtb.domainver</code>.
    For AdCOM v1.x, the objects allowed here are “Ad” and any objects subordinate thereto as specified by AdCOM.</td>
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

  alias OpenRtbEcto.V3.BidResponse.Macro

  @primary_key false
  embedded_schema do
    field(:id)
    field(:item)
    field(:price, :float)
    field(:deal)
    field(:cid)
    field(:tactic)
    field(:purl)
    field(:burl)
    field(:lurl)
    field(:exp, :integer)
    field(:mid)
    embeds_many(:macro, Macro)
    # TODO finsih domain obj
    field(:media, :map)
    field(:ext, :map, default: %{})
  end

  def changeset(bid, attrs \\ %{}) do
    bid
    |> cast(attrs, [
      :id,
      :item,
      :price,
      :deal,
      :cid,
      :tactic,
      :purl,
      :burl,
      :lurl,
      :exp,
      :mid,
      :media,
      :ext
    ])
    |> cast_embed(:macro)
    |> validate_required([:item, :price])
  end
end
