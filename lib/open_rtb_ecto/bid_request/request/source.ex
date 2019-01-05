defmodule OpenRtbEcto.BidRequest.Request.Source do
  @moduledoc """
  This object describes the nature and behavior of the entity that is the source of the bid request
  upstream from the exchange. The primary purpose of this object is to define post-auction or
  upstream decisioning when the exchange itself does not control the final decision. A common
  example of this is header bidding, but it can also apply to upstream server entities such as
  another RTB exchange, a mediation platform, or an ad server that combines direct campaigns
  with third party demand in decisioning.

  ### Fields
  |Attribute|Type|Definition|
  |fd|integer; recommended|Entity responsible for the final sale decision, where 0 = exchange, 1 = upstream source.|
  |tid|string; recommended|Transaction ID that must be common across all participants in this bid request (e.g., potentially multiple exchanges).|
  |pchain|string; recommended|Payment ID chain string containing embedded syntax described in the TAG Payment ID Protocol.|
  |ext|object|Optional exchange-specific extensions.|
  """
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key false
  embedded_schema do
    field(:fd, :integer)
    field(:tid)
    field(:pchain)
    field(:ext, :map)
  end
end
