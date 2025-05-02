defmodule OpenRtbEcto.V2.BidRequest.SupplyChain do
  @moduledoc """
  This object is composed of a set of nodes where each node represents a specific entity that participates in
  the transacting of inventory. The entire chain of nodes from beginning to end represents all entities who
  are involved in the direct flow of payment for inventory. Detailed implementation examples can be found
  here: https://github.com/InteractiveAdvertisingBureau/openrtb/blob/master/supplychainobject.md
  """
  alias OpenRtbEcto.Types.TinyInt
  alias OpenRtbEcto.V2.BidRequest.SupplyChainNode

  use OpenRtbEcto.SafeSchema

  @type t :: %__MODULE__{}

  @primary_key false
  embedded_schema do
    field(:complete, TinyInt)
    field(:ver)
    embeds_many(:nodes, SupplyChainNode)
    field(:ext, :map, default: %{})
  end

  def changeset(schain, attrs \\ %{}) do
    schain
    |> safe_cast(attrs, [:complete, :ver, :ext])
    # Make nodes optional
    |> safe_cast_embed(:nodes)
    |> validate_required([:complete, :ver])
  end
end
