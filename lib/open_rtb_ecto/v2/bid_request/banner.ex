defmodule OpenRtbEcto.V2.BidRequest.Banner do
  @moduledoc """
  This object represents the most general type of impression. Although the term “banner” may have
  very specific meaning in other contexts, here it can be many things including a simple static
  image, an expandable ad unit, or even in-banner video (refer to the Video object in Section 3.2.7
  for the more generalized and full featured video ad units). An array of Banner objects can also
  appear within the Video to describe optional companion ads defined in the VAST specification.

  The presence of a Banner as a subordinate of the Imp object indicates that this impression is
  offered as a banner type impression. At the publisher’s discretion, that same impression may
  also be offered as video, audio, and/or native by also including as Imp subordinates objects
  of those types. However, any given bid for the impression must conform to one of the offered
  types.
  """

  use Ecto.Schema
  import Ecto.Changeset

  alias OpenRtbEcto.Types.TinyInt
  alias OpenRtbEcto.V2.BidRequest.Format

  @type t :: %__MODULE__{}

  @primary_key false
  embedded_schema do
    embeds_many(:format, Format)
    field(:w, :integer)
    field(:h, :integer)
    field(:wmax, :integer)
    field(:hmax, :integer)
    field(:wmin, :integer)
    field(:hmin, :integer)
    field(:btype, {:array, :integer})
    field(:battr, {:array, :integer})
    field(:pos, :integer)
    field(:mimes, {:array, :string})
    field(:topframe, TinyInt, default: 0)
    field(:expdir, {:array, :integer})
    field(:api, {:array, :integer})
    field(:id)
    field(:vcm, TinyInt)
    field(:ext, :map)
  end

  def changeset(banner, attrs \\ %{}) do
    banner
    |> cast(attrs, [
      :w,
      :h,
      :wmax,
      :hmax,
      :wmin,
      :hmin,
      :btype,
      :battr,
      :pos,
      :mimes,
      :topframe,
      :expdir,
      :api,
      :id,
      :vcm,
      :ext
    ])
    |> cast_embed(:format)
    |> validate_subset(:btype, 1..4)
    |> validate_subset(:expdir, 1..4)
    |> validate_number(:pos, greater_than: -1, less_than: 8)

    # |> validate_subset(:battr, 1..17)
  end
end
