defmodule OpenRtbEcto.V2.BidRequest.Impression do
  @moduledoc """
  The “imp” object describes the ad position or impression being auctioned. A single bid request
  can include multiple “imp” objects, a use case for which might be an exchange that supports
  selling all ad positions on a given page as a bundle. Each “imp” object has a required ID so that
  bids can reference them individually. An exchange can also conduct private auctions by
  restricting involvement to specific subsets of seats within bidders
  """

  use Ecto.Schema
  import Ecto.Changeset

  alias OpenRtbEcto.V2.BidRequest.{Banner, Video}

  @primary_key false
  embedded_schema do
    field(:id)
    embeds_one(:banner, Banner)
    embeds_one(:video, Video)
    field(:displaymanager)
    field(:displaymanagerver)
    field(:instl, :integer, default: 0)
    field(:tagid)
    field(:bidfloor, :float, default: 0.0)
    field(:bidfloorcur, :string, default: "USD")
    field(:iframebuster, {:array, :string})
    field(:ext, :map)
  end

  # TODO
  # validate impression has a banner or a video? the spec seems to contradict itself:
  #   Either a banner or video object
  #  (or both if the impression could
  #  be either) must be included in
  #  an impression object; both
  #  objects may not be included.
  # validate bidfloorcur is valid currency?
  def changeset(impression, attrs \\ %{}) do
    impression
    |> cast(attrs, [
      :id,
      :displaymanager,
      :displaymanagerver,
      :instl,
      :tagid,
      :bidfloor,
      :bidfloorcur,
      :iframebuster,
      :ext
    ])
    |> cast_embed(:banner)
    |> cast_embed(:video)
    |> validate_required([:id])
    |> validate_inclusion(:instl, 0..1)
  end
end
