defmodule OpenRtbEcto.V3.BidRequest.Deal do
  @moduledoc """
  This object constitutes a specific deal that was struck *a priori* between a seller and a buyer.  Its presence indicates that this item is available under the terms of that deal.

  <table>
    <tr>
      <td><strong>Attribute&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</strong></td>
      <td><strong>Type&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</strong></td>
      <td><strong>Definition</strong></td>
    </tr>
    <tr>
      <td><code>id</code></td>
      <td>string; required</td>
      <td>A unique identifier for the deal.</td>
    </tr>
    <tr>
      <td><code>flr</code></td>
      <td>float</td>
      <td>Minimum deal price for this item expressed in CPM.</td>
    </tr>
    <tr>
      <td><code>flrcur</code></td>
      <td>string;<br/>default&nbsp;"USD"</td>
      <td>Currency of the <code>flr</code> attribute specified using ISO-4217 alpha codes.</td>
    </tr>
    <tr>
      <td><code>at</code></td>
      <td>integer</td>
      <td>Optional override of the overall auction type of the request, where 1 = First Price, 2 = Second Price Plus, 3 = the value passed in <code>flr</code> is the agreed upon deal price.  Additional auction types can be defined by the exchange using 500+ values.</td>
    </tr>
    <tr>
      <td><code>wseat</code></td>
      <td>string&nbsp;array</td>
      <td>Whitelist of buyer seats allowed to bid on this deal.  IDs of seats and the buyer’s customers to which they refer must be coordinated between bidders and the exchange <em>a priori</em>.  Omission implies no restrictions.</td>
    </tr>
    <tr>
      <td><code>wadomain</code></td>
      <td>string&nbsp;array</td>
      <td>Array of advertiser domains (e.g., advertiser.com) allowed to bid on this deal.  Omission implies no restrictions.</td>
    </tr>
    <tr>
      <td><code>ext</code></td>
      <td>object</td>
      <td>Optional exchange-specific extensions.</td>
    </tr>
  </table>
  """

  use Ecto.Schema
  import Ecto.Changeset

  @primary_key false
  embedded_schema do
    field(:id)
    field(:flr, :float)
    field(:flrcur, :string, default: "USD")
    field(:at, :integer)
    field(:wseat, {:array, :string})
    field(:wadomain, {:array, :string})
    field(:ext, :map)
  end

  def changeset(deal, attrs \\ %{}) do
    deal
    |> cast(attrs, [:id, :qty, :flr, :flrcur, :at, :wseat, :wadomain, :ext])
    |> validate_required(:id)
    |> validate_number(:qty, greater_than: 0)
    |> validate_number(:flr, greater_than: 0)
    |> validate_auction_type()
  end

  defp validate_auction_type(changeset) do
    case get_change(changeset, :at) do
      nil -> changeset
      val when val in 1..3 or val > 500 -> changeset
      _ -> add_error(changeset, :at, "must equal 1, 2, 3 or be greater than 500")
    end
  end
end
