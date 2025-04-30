defmodule OpenRtbEcto.V3.BidResponse.Macro do
  @moduledoc """
  This object constitutes a buyer defined key/value pair used to inject dynamic values into media markup.  While they apply to any media markup irrespective of how it is conveyed, the principle use case is for media that was uploaded to the exchange prior to the transaction (e.g., pre-registered for creative quality review) and referenced in bid.  The full form of the macro to be substituted at runtime is `${CUSTOM_KEY}`, where “`KEY`” is the name supplied in the `key` attribute.  This ensures no conflict with standard OpenRTB macros.

  <table>
    <tr>
      <td><strong>Attribute&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</strong></td>
      <td><strong>Type&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</strong></td>
      <td><strong>Definition</strong></td>
    </tr>
    <tr>
      <td><code>key</code></td>
      <td>string; required</td>
      <td>Name of a buyer specific macro.</td>
    </tr>
    <tr>
      <td><code>value</code></td>
      <td>string</td>
      <td>Value to substitute for each instance of the macro found in markup.</td>
    </tr>
    <tr>
      <td><code>ext</code></td>
      <td>object</td>
      <td>Optional demand source specific extensions.</td>
    </tr>
  </table>
  """

  use OpenRtbEcto.SafeSchema

  @primary_key false
  embedded_schema do
    field(:key)
    field(:value)
    field(:ext, :map, default: %{})
  end

  def changeset(macro, attrs \\ %{}) do
    macro
    |> safe_cast(attrs, [:key, :value, :ext])
    |> validate_required(:key)
  end
end
