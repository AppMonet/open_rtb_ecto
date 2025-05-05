defmodule OpenRtbEcto.V2.BidRequest.Imp do
  @moduledoc """
  This object describes an ad placement or impression being auctioned. A single bid request can
  include multiple Imp objects, a use case for which might be an exchange that supports selling all
  ad positions on a given page. Each Imp object has a required ID so that bids can reference them
  individually.

  The presence of Banner (Section 3.2.6), Video (Section 3.2.7), and/or Native (Section 3.2.9)
  objects subordinate to the Imp object indicates the type of impression being offered. The
  publisher can choose one such type which is the typical case or mix them at their discretion.
  However, any given bid for the impression must conform to one of the offered types.
  """

  use Ecto.Schema
  import Ecto.Changeset

  alias OpenRtbEcto.Types.TinyInt
  alias OpenRtbEcto.V2.BidRequest.{Metric, Banner, Video, Audio, Native, Pmp}

  @type t :: %__MODULE__{}

  @primary_key false
  embedded_schema do
    field(:id)
    embeds_many(:metric, Metric)
    embeds_one(:banner, Banner)
    embeds_one(:video, Video)
    embeds_one(:audio, Audio)
    embeds_one(:native, Native)
    embeds_one(:pmp, Pmp)
    field(:displaymanager)
    field(:displaymanagerver)
    field(:instl, TinyInt, default: 0)
    field(:tagid)
    field(:bidfloor, :float, default: 0.0)
    field(:bidfloorcur, :string)
    field(:clickbrowser, TinyInt)
    field(:secure, TinyInt)
    field(:iframebuster, {:array, :string})
    field(:rwdd, TinyInt)
    field(:ssai, :integer)
    field(:exp, :integer)
    field(:ext, :map, default: %{})
  end

  def changeset(impression, attrs) when is_map(attrs) do
    impression
    |> cast(attrs, [
      :id,
      :displaymanager,
      :displaymanagerver,
      :instl,
      :tagid,
      :bidfloor,
      :bidfloorcur,
      :clickbrowser,
      :secure,
      :iframebuster,
      :rwdd,
      :ssai,
      :exp
    ])
    |> OpenRtbEcto.safe_cast_ext(attrs)
    |> cast_embed(:metric)
    |> cast_embed(:banner)
    |> cast_embed(:video)
    |> cast_embed(:audio)
    |> cast_embed(:native)
    |> cast_embed(:pmp)
    |> validate_required(:id)
  end

  def changeset(imp, _), do: change(imp)
end
