defmodule OpenRtbEcto.V3.BidRequest.Metric do
  @moduledoc """
  This object is associated with an item as an array of metrics. These metrics can offer insight to assist with decisioning such as average recent viewability, click-through rate, etc.  Each metric is identified by its type, reports the value of the metric, and optionally identifies the source or vendor measuring the value.

  <table>
    <tr>
      <td><strong>Attribute&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</strong></td>
      <td><strong>Type&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</strong></td>
      <td><strong>Definition</strong></td>
    </tr>
    <tr>
      <td><code>type</code></td>
      <td>string; required</td>
      <td>Type of metric being presented using exchange curated string names which should be published to bidders <em>a priori</em>.</td>
    </tr>
    <tr>
      <td><code>value</code></td>
      <td>float; required</td>
      <td>Number representing the value of the metric.  Probabilities must be in the range 0.0 – 1.0.</td>
    </tr>
    <tr>
      <td><code>vendor</code></td>
      <td>string; recommended</td>
      <td>Source of the value using exchange curated string names which should be published to bidders <em>a priori</em>.  If the exchange itself is the source versus a third party, “EXCHANGE” is recommended.</td>
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
    field(:type)
    field(:value, :float)
    field(:vendor)
    field(:ext, :map, default: %{})
  end

  def changeset(metric, attrs \\ %{}) do
    metric
    |> safe_cast(attrs, [:type, :value, :vendor, :ext])
    |> validate_required([:type, :value])
  end
end
