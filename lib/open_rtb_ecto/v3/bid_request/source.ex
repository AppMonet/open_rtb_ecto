defmodule OpenRtbEcto.V3.BidRequest.Source do
  @moduledoc """
  This object carries data about the source of the transaction including the unique ID of the transaction itself, source authentication information, and the chain of custody.

  NOTE:  Attributes `ds`, `dsmap`, `cert`, and `digest` support digitally signed bid requests as defined by the [Ads.cert: Signed Bid Requests specification](https://github.com/InteractiveAdvertisingBureau/openrtb/blob/master/ads.cert%201.0%20BETA.md).  As the Ads.cert specification is still in its BETA state, these attributes should be considered to be in a similar state.

  <table>
    <tr>
      <td><strong>Attribute&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</strong></td>
      <td><strong>Type&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</strong></td>
      <td><strong>Definition</strong></td>
    </tr>
    <tr>
      <td><code>tid</code></td>
      <td>string; recommended</td>
      <td>Transaction ID that must be common across all participants throughout the entire supply chain of this transaction.  This also applies across all participating exchanges in a header bidding or similar publisher-centric broadcast scenario.</td>
    </tr>
    <tr>
      <td><code>ts</code></td>
      <td>integer; recommended</td>
      <td>Timestamp when the request originated at the beginning of the supply chain in Unix format (i.e., milliseconds since the epoch).  This value must be held as immutable throughout subsequent intermediaries.</td>
    </tr>
    <tr>
      <td><code>ds</code></td>
      <td>string; recommended</td>
      <td>Digital signature used to authenticate the origin of this request computed by the publisher or its trusted agent from a digest string composed of a set of immutable attributes found in the bid request.  Refer to Section “<a href="#inventoryauthentication">Inventory Authentication</a>” for more details.</td>
    </tr>
    <tr>
      <td><code>dsmap</code></td>
      <td>string</td>
      <td>An ordered list of identifiers that indicates the attributes used to create the digest.  This map provides the essential instructions for recreating the digest from the bid request, which is a necessary step in validating the digital signature in the <code>ds</code> attribute.  Refer to Section “<a href="#inventoryauthentication">Inventory Authentication</a>” for more details.</td>
    </tr>
    <tr>
      <td><code>cert</code></td>
      <td>string; recommended</td>
      <td>File name of the certificate (i.e., the public key) used to generate the digital signature in the <code>ds</code> attribute.  Refer to Section “<a href="#inventoryauthentication">Inventory Authentication</a>” for more details.</td>
    </tr>
    <tr>
      <td><code>digest</code></td>
      <td>string</td>
      <td>The full digest string that was signed to produce the digital signature.  Refer to Section “<a href="#inventoryauthentication">Inventory Authentication</a>” for more details.<br/>
    NOTE:  This is only intended for debugging purposes as needed. It is not intended for normal Production traffic due to the bandwidth impact.</td>
    </tr>
    <tr>
      <td><code>pchain</code></td>
      <td>string</td>
      <td>Payment ID chain string containing embedded syntax described in the TAG Payment ID Protocol.<br/>
    NOTE: Authentication features in this Source object combined with the “ads.txt” specification may lead to the deprecation of this attribute.</td>
    </tr>
    <tr>
      <td><code>ext</code></td>
      <td>object</td>
      <td>Optional exchange-specific extensions.</td>
    </tr>
  </table>
  """
  use OpenRtbEcto.SafeSchema

  @primary_key false
  embedded_schema do
    field(:tid)
    field(:ts, :integer)
    field(:ds)
    field(:dsmap)
    field(:cert)
    field(:digest)
    field(:pchain)
    field(:ext, :map, default: %{})
  end

  def changeset(source, attrs \\ %{}) do
    source
    |> safe_cast(attrs, [:tid, :ts, :ds, :dsmap, :cert, :digest, :pchain, :ext])
  end
end
