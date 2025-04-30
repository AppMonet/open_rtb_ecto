defmodule OpenRtbEcto.V2.BidRequest.BrandVersion do
  @moduledoc """
  Further identification based on User-Agent Client Hints, the BrandVersion object is used to identify a
  device’s browser or similar software component, and the user agent’s execution platform or operating
  system.
  """
  use OpenRtbEcto.SafeSchema

  @type t :: %__MODULE__{}

  @primary_key false
  embedded_schema do
    field(:brand)
    field(:version, {:array, :string})
    field(:ext, :map, default: %{})
  end

  def changeset(version, attrs \\ %{}) do
    version
    |> safe_cast(attrs, [:brand, :version, :ext])
    |> validate_required([:brand])
  end
end
