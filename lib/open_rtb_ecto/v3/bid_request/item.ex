defmodule OpenRtbEcto.V3.BidRequest.Item do
  @moduledoc """
  This object represents a unit of goods being offered for sale either on the open market or in relation to a private marketplace deal.  The `id` attribute is required since there may be multiple items being offered in the same bid request and bids must reference the specific item of interest.  This object interfaces to Layer-4 domain objects for deeper specification of the item being offered (e.g., an impression).

  <table>
    <tr>
      <td><strong>Attribute&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</strong></td>
      <td><strong>Type&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</strong></td>
      <td><strong>Definition</strong></td>
    </tr>
    <tr>
      <td><code>id</code></td>
      <td>string; required</td>
      <td>A unique identifier for this item within the context of the offer (typically starts with “1” and increments).</td>
    </tr>
    <tr>
      <td><code>qty</code></td>
      <td>integer;<br/>default&nbsp;1</td>
      <td>The number of instances (i.e., “quantity”) of this item being offered (e.g., multiple identical impressions in a digital out-of-home scenario).</td>
    </tr>
    <tr>
      <td><code>seq</code></td>
      <td>integer</td>
      <td>If multiple items are offered in the same bid request, the sequence number allows for the coordinated delivery.</td>
    </tr>
    <tr>
      <td><code>flr</code></td>
      <td>float</td>
      <td>Minimum bid price for this item expressed in CPM.</td>
    </tr>
    <tr>
      <td><code>flrcur</code></td>
      <td>string;<br/>default&nbsp;“USD”</td>
      <td>Currency of the <code>flr</code> attribute specified using ISO-4217 alpha codes.</td>
    </tr>
    <tr>
      <td><code>exp</code></td>
      <td>integer</td>
      <td>Advisory as to the number of seconds that may elapse between auction and fulfilment.</td>
    </tr>
    <tr>
      <td><code>dt</code></td>
      <td>integer</td>
      <td>Timestamp when the item is expected to be fulfilled (e.g. when a DOOH impression will be displayed) in Unix format (i.e., milliseconds since the epoch).</td>
    </tr>
    <tr>
      <td><code>dlvy</code></td>
      <td>integer;<br/>default&nbsp;0</td>
      <td>Item (e.g., an Ad object) delivery method required, where 0 = either method, 1 = the item must be sent as part of the transaction (e.g., by value in the bid itself, fetched by URL included in the bid), and 2 = an item previously uploaded to the exchange must be referenced by its ID.  Note that if an exchange does not supported prior upload, then the default of 0 is effectively the same as 1 since there can be no items to reference.</td>
    </tr>
    <tr>
      <td><code>metric</code></td>
      <td>object&nbsp;array</td>
      <td>An array of <code>Metric</code> objects.  Refer to <a href="#object_metric">Object: Metric</a>.</td>
    </tr>
    <tr>
      <td><code>deal</code></td>
      <td>object&nbsp;array</td>
      <td>Array of <code>Deal</code> objects that convey special terms applicable to this item.  Refer to <a href="#object_deal">Object: Deal</a>.</td>
    </tr>
    <tr>
      <td><code>private</code></td>
      <td>integer;<br/>default&nbsp;0</td>
      <td>Indicator of auction eligibility to seats named in <code>Deal</code> objects, where 0 = all bids are accepted, 1 = bids are restricted to the deals specified and the terms thereof.</td>
    </tr>
    <tr>
      <td><code>spec</code></td>
      <td>object; required</td>
      <td>Layer-4 domain object structure that provides specifies the item being offered conforming to the specification and version referenced in <code>openrtb.domainspec</code> and <code>openrtb.domainver</code>. <br />
    For AdCOM v1.x, the objects allowed here are <code>Placement</code> and any objects subordinate to these as specified by AdCOM.</td>
    </tr>
    <tr>
      <td><code>ext</code></td>
      <td>object</td>
      <td>Optional exchange-specific extensions.</td>
    </tr>
  </table>
  """

  use OpenRtbEcto.SafeSchema

  alias OpenRtbEcto.V3.BidRequest.{Deal, Metric}

  @primary_key false
  embedded_schema do
    field(:id)
    field(:qty, :integer, default: 1)
    field(:seq, :integer)
    field(:flr, :float)
    field(:flrcur, :string, default: "USD")
    field(:exp, :integer)
    field(:dt, :integer)
    field(:dlvy, :integer, default: 0)
    embeds_many(:metric, Metric)
    embeds_many(:deal, Deal)
    field(:private, :integer, default: 0)
    # TODO
    field(:spec)
    field(:ext, :map)
  end

  def changeset(item, attrs \\ %{}) do
    item
    |> safe_cast(attrs, [:id, :qty, :seq, :flr, :flrcur, :exp, :dt, :dlvy, :private, :spec, :ext])
    |> safe_cast_embed(:metric)
    |> safe_cast_embed(:deal)
    |> validate_required([:id, :spec])
    |> validate_inclusion(:dlvy, 0..2)
  end
end
