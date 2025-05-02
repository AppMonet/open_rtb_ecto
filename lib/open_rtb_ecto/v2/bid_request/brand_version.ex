defmodule OpenRtbEcto.V2.BidRequest.BrandVersion do
  @moduledoc """
  Further identification based on User-Agent Client Hints, the BrandVersion object is used to identify a
  device’s browser or similar software component, and the user agent’s execution platform or operating
  system.
  """
  use Ecto.Schema
  import Ecto.Changeset

  @type t :: %__MODULE__{}

  @primary_key false
  embedded_schema do
    field(:brand)
    field(:version, {:array, :string})
    field(:ext, :map, default: %{})
  end

  def changeset(version, attrs) when is_map(attrs) do
    version
    |> cast(attrs, [:brand, :version, :ext])
    |> validate_required([:brand])
  end

  def changeset(version, _), do: change(version)
end
