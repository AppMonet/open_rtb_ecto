defmodule OpenRtbEcto.V3.BidRequest.Request do
  @moduledoc """
  The `Request` object contains a globally unique bid request ID. This `id` attribute is required as is an `Item` array with at least one object (i.e., at least one item for sale).  Other attributes establish rules and restrictions that apply to all items being offered. This object also interfaces to Layer-4 domain objects for context such as the user, device, site or app, etc.

  <table>
    <tr>
      <td><strong>Attribute&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</strong></td>
      <td><strong>Type&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</strong></td>
      <td><strong>Definition</strong></td>
    </tr>
    <tr>
      <td><code>id</code></td>
      <td>string;&nbsp;required</td>
      <td>Unique ID of the bid request; provided by the exchange.</td>
    </tr>
    <tr>
      <td><code>test</code></td>
      <td>integer;<br/>default&nbsp;0</td>
      <td>Indicator of test mode in which auctions are not billable, where 0 = live mode, 1 = test mode.</td>
    </tr>
    <tr>
      <td><code>tmax</code></td>
      <td>integer</td>
      <td>Maximum time in milliseconds the exchange allows for bids to be received including Internet latency to avoid timeout. This value supersedes any <em>a priori</em> guidance from the exchange.  If an exchange acts as an intermediary, it should decrease the outbound <code>tmax</code> value from what it received to account for its latency and the additional internet hop.</td>
    </tr>
    <tr>
      <td><code>at</code></td>
      <td>integer;<br/>default&nbsp;2</td>
      <td>Auction type, where 1 = First Price, 2 = Second Price Plus.  Values greater than 500 can be used for exchange-specific auction types.</td>
    </tr>
    <tr>
      <td><code>cur</code></td>
      <td>string&nbsp;array;<br/>default&nbsp;[“USD”]</td>
      <td>Array of accepted currencies for bids on this bid request using ISO-4217 alpha codes. Recommended if the exchange accepts multiple currencies. If omitted, the single currency of “USD” is assumed.</td>
    </tr>
    <tr>
      <td><code>seat</code></td>
      <td>string&nbsp;array</td>
      <td>Restriction list of buyer seats for bidding on this item.  Knowledge of buyer’s customers and their seat IDs must be coordinated between parties <em>a priori</em>. Omission implies no restrictions.</td>
    </tr>
    <tr>
      <td><code>wseat</code></td>
      <td>integer;<br/>default&nbsp;1</td>
      <td>Flag that determines the restriction interpretation of the <code>seat</code> array, where 0 = block list, 1 = whitelist.</td>
    </tr>
    <tr>
      <td><code>cdata</code></td>
      <td>string</td>
      <td>Allows bidder to retrieve data set on its behalf in the exchange’s cookie (refer to <code>cdata</code> in <a href="#object_response">Object: Response</a>) if supported by the exchange. The string must be in base85 cookie-safe characters.</td>
    </tr>
    <tr>
      <td><code>source</code></td>
      <td>object</td>
      <td>A <code>Source</code> object that provides data about the inventory source and which entity makes the final decision. Refer to <a href="#object_source">Object: Source</a>.</td>
    </tr>
    <tr>
      <td><code>item</code></td>
      <td>object&nbsp;array; required</td>
      <td>Array of <code>Item</code> objects (at least one) that constitute the set of goods being offered for sale. Refer to <a href="#object_item">Object: Item</a>.</td>
    </tr>
    <tr>
      <td><code>package</code></td>
      <td>integer</td>
      <td>Flag to indicate if the Exchange can verify that the items offered represent all of the items available in context (e.g., all impressions on a web page, all video spots such as pre/mid/post roll) to support road-blocking, where 0 = no, 1 = yes.</td>
    </tr>
    <tr>
      <td><code>context</code></td>
      <td>object; recommended</td>
      <td>Layer-4 domain object structure that provides context for the items being offered conforming to the specification and version referenced in <code>openrtb.domainspec</code> and <code>openrtb.domainver</code>. <br />
    For AdCOM v1.x, the objects allowed here all of which are optional are one of the <code>DistributionChannel</code> subtypes (i.e., <code>Site</code>, <code>App</code>, or <code>Dooh</code>), <code>User</code>, <code>Device</code>, <code>Regs</code>, <code>Restrictions</code>, and any objects subordinate to these as specified by AdCOM.</td>
    </tr>
    <tr>
      <td><code>ext</code></td>
      <td>object</td>
      <td>Optional exchange-specific extensions.</td>
    </tr>
  </table>
  """

  use OpenRtbEcto.SafeSchema

  alias OpenRtbEcto.Types.TinyInt
  alias OpenRtbEcto.V3.BidRequest.{Source, Item}

  @primary_key false
  embedded_schema do
    field(:id)
    field(:test, TinyInt, default: 0)
    field(:tmax, TinyInt)
    field(:at, :integer, default: 2)
    field(:cur, {:array, :string}, default: ["USD"])
    field(:seat, {:array, :string})
    field(:wseat, TinyInt, default: 1)
    field(:cdata)
    embeds_one(:source, Source)
    embeds_many(:item, Item)
    field(:package, TinyInt)
    # TODO finish context
    field(:context)
  end

  def changeset(request, attrs \\ %{}) do
    request
    |> safe_cast(attrs, [:id, :test, :tmax, :at, :cur, :wcurs, :seat, :wseat, :cdata, :package])
    |> safe_cast_embed(:source)
    |> safe_cast_embed(:item, required: true)
    |> validate_required(:id)
    |> validate_auction_type()
  end

  defp validate_auction_type(changeset) do
    case get_change(changeset, :at) do
      nil -> changeset
      val when val == 1 or val == 2 or val > 500 -> changeset
      _ -> add_error(changeset, :at, "must equal 1, 2 or be greater than 500")
    end
  end
end
