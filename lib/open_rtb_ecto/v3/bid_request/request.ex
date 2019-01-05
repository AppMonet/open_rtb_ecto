defmodule OpenRtbEcto.V3.BidRequest.Request do
  @moduledoc """
  The “Request” object contains a globally unique bid request ID. This “id” attribute is required
  as is an “Offer” with at least one “Item” object. Other attributes establish rules and
  restrictions that apply to all items being offered. This object also interfaces to Layer-4 domain
  objects for context such as the user, device, site or app, etc.
  """

  use Ecto.Schema
  import Ecto.Changeset

  alias OpenRtbEcto.V3.BidRequest.{Source, Offer}

  @primary_key false
  embedded_schema do
    field(:id)
    field(:test, :integer, default: 0)
    field(:tmax, :integer)
    field(:at, :integer, default: 2)
    field(:curs, {:array, :string}, default: ["USD"])
    field(:wcurs, :integer, default: 0)
    field(:seats, {:array, :string})
    field(:wseats, :integer, default: 0)
    field(:domain, :map)
    field(:ext, :map)
    embeds_one(:source, Source)
    embeds_one(:offer, Offer)
  end

  def changeset(request, attrs \\ %{}) do
    request
    |> cast(attrs, [:id, :test, :tmax, :at, :curs, :wcurs, :seats, :wseats, :domain, :ext])
    |> cast_embed(:source)
    |> cast_embed(:offer, required: true)
    |> validate_required(:id)
    |> validate_inclusion(:test, 0..1)
    |> validate_inclusion(:wcurs, 0..1)
    |> validate_inclusion(:wseats, 0..1)
    |> validate_auction_type()
  end

  defp validate_auction_type(changeset) do
    case get_change(changeset, :at) do
      nil -> changeset
      val when val in 0..1 or val > 500 -> changeset
      _ -> add_error(changeset, :at, "must equal 0, 1 or be greater than 500")
    end
  end
end
