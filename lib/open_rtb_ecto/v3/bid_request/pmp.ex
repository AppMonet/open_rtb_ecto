defmodule OpenRtbEcto.V3.BidRequest.Pmp do
  @moduledoc """
  This object is the private marketplace container for direct deals between sellers and buyers that
  may pertain to this item. The actual deals are represented as a collection of “Deal” objects.
  """

  use Ecto.Schema
  import Ecto.Changeset

  alias OpenRtbEcto.V3.BidRequest.Deal

  @primary_key false
  embedded_schema do
    field(:private, :integer, default: 0)
    field(:ext, :map)
    embeds_many(:deal, Deal)
  end

  def changeset(pmp, attrs \\ %{}) do
    pmp
    |> cast(attrs, [:private, :deal, :ext])
    |> cast_embed(:deal)
    |> validate_inclusion(:private, 0..1)
  end
end
