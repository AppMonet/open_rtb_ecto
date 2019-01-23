defmodule OpenRtbEcto.V2.BidRequest.Pmp do
  @moduledoc """
  This object is the private marketplace container for direct deals between buyers and sellers that
  may pertain to this impression. The actual deals are represented as a collection of Deal objects.
  Refer to Section 7.3 for more details.
  """

  use Ecto.Schema
  import Ecto.Changeset

  alias OpenRtbEcto.V2.BidRequest.Deal

  @type t :: %__MODULE__{}

  @primary_key false
  embedded_schema do
    field(:private_auction, :integer, default: 0)
    embeds_many(:deals, Deal)
    field(:ext, :map, default: %{})
  end

  def changeset(pmp, attrs \\ %{}) do
    pmp
    |> cast(attrs, [:private_auction, :ext])
    |> cast_embed(:deals)
  end
end
