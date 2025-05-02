defmodule OpenRtbEcto.V2.BidRequest.SupplyChainNode do
  @moduledoc """
  This object is associated with a SupplyChain object as an array of nodes. These nodes define the identity of
  an entity participating in the supply chain of a bid request. Detailed implementation examples can be found
  here: https://github.com/InteractiveAdvertisingBureau/openrtb/blob/master/supplychainobject.md. The
  SupplyChainNode object contains the following attributes:
  """
  alias OpenRtbEcto.Types.TinyInt

  use Ecto.Schema
  import Ecto.Changeset

  @type t :: %__MODULE__{}

  @primary_key false
  embedded_schema do
    field(:asi)
    field(:sid)
    field(:rid)
    field(:name)
    field(:domain)
    field(:hp, TinyInt)
  end

  def changeset(node, attrs) when is_map(attrs) do
    node
    |> cast(attrs, [:asi, :sid, :rid, :name, :domain, :hp])
    |> validate_required([:asi, :sid])
  end

  def changeset(node, _), do: change(node)
end
