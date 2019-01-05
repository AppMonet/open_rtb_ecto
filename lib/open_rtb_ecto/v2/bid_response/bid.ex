defmodule OpenRtbEcto.V2.BidResponse.Bid do
  @moduledoc """
  For each bid, the “nurl” attribute contains the win notice URL. If the bidder wins the impression,
  the exchange calls this notice URL a) to inform the bidder of the win and b) to convey certain
  information using substitution macros (see Section 4.6 Substitution Macros).
  The “adomain” attribute can be used to check advertiser block list compliance. The “iurl”
  attribute can provide a link to an image that is representative of the campaign’s content
  (irrespective of whether the campaign may have multiple creatives). This enables human review
  for spotting inappropriate content. The “cid” attribute can be used to block ads that were
  previously identified as inappropriate; essentially a safety net beyond the block lists. The “crid”
  attribute can be helpful in reporting creative issues back to bidders. Finally, the “attr” array
  indicates the creative attributes that describe the ad to be served.

  #### BEST PRACTICE:
  Substitution macros may allow a bidder to use a static notice URL for all of its
  bids. Thus, exchanges should offer the option of a default notice URL that can be preconfigured
  per bidder to reduce redundant data transfer.
  """

  use Ecto.Schema
  import Ecto.Changeset

  @primary_key false
  embedded_schema do
    field(:id)
    field(:impid)
    field(:price, :float)
    field(:adid)
    field(:nurl)
    field(:adm)
    field(:adomain, {:array, :string})
    field(:iurl)
    field(:cid)
    field(:crid)
    field(:attr, {:array, :integer})
    field(:ext, :map)
  end

  def changeset(bid, attrs \\ %{}) do
    bid
    |> cast(attrs, [
      :id,
      :impid,
      :price,
      :adid,
      :nurl,
      :adm,
      :adomain,
      :iurl,
      :cid,
      :crid,
      :attr,
      :ext
    ])
    |> validate_required([:id, :impid, :price])
    |> validate_number(:attr, greater_than_or_equal_to: 1, less_than_or_equal_to: 16)
  end
end
