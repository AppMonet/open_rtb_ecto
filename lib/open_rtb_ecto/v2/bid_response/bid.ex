defmodule OpenRtbEcto.V2.BidResponse.Bid do
  @moduledoc """
  A SeatBid object contains one or more Bid objects, each of which relates to a specific impression
  in the bid request via the impid attribute and constitutes an offer to buy that impression for a 
  given price.
  """

  use Ecto.Schema
  import Ecto.Changeset

  @type t :: %__MODULE__{}
  @default_crid "1"

  @primary_key false
  embedded_schema do
    field(:id)
    field(:impid)
    field(:price, :float)
    field(:nurl)
    field(:burl)
    field(:lurl)
    field(:adm)
    field(:adid)
    field(:adomain, {:array, :string})
    field(:bundle)
    field(:iurl)
    field(:cid)
    field(:crid, :string, default: @default_crid)
    field(:tactic)
    field(:cat, {:array, :string})
    field(:attr, {:array, :integer})
    field(:api, :integer)
    field(:protocol, :integer)
    field(:qagmediarating, :integer)
    field(:language)
    field(:dealid)
    field(:w, :integer)
    field(:h, :integer)
    field(:wratio, :integer)
    field(:hratio, :integer)
    field(:exp, :integer)
    field(:ext, :map, default: %{})
  end

  def changeset(bid, attrs \\ %{}) do
    bid
    |> cast(attrs, [
      :id,
      :impid,
      :price,
      :nurl,
      :burl,
      :lurl,
      :adm,
      :adid,
      :adomain,
      :bundle,
      :iurl,
      :cid,
      :crid,
      :tactic,
      :cat,
      :attr,
      :api,
      :protocol,
      :qagmediarating,
      :language,
      :dealid,
      :w,
      :h,
      :wratio,
      :hratio,
      :exp,
      :ext
    ])
    |> validate_required([:id, :impid, :price])
    |> ensure_crid()
  end

  defp ensure_crid(changeset) do
    case get_field(changeset, :crid) do
      nil -> put_change(changeset, :crid, @default_crid)
      _ -> changeset
    end
  end
end
