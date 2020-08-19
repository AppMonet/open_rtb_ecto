defmodule OpenRtbEcto.V2.BidResponse.Bid do
  @moduledoc """
  A SeatBid object contains one or more Bid objects, each of which relates to a specific impression
  in the bid request via the impid attribute and constitutes an offer to buy that impression for a 
  given price.
  """

  use Ecto.Schema
  import Ecto.Changeset

  @type t :: %__MODULE__{}

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
    field(:crid)
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
    |> validate_inclusion(:api, 1..6)
    |> validate_inclusion(:protocol, 1..10)
    |> validate_inclusion(:qagmediarating, 1..3)
  end
end
