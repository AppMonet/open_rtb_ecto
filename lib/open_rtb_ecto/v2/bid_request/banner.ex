defmodule OpenRtbEcto.V2.BidRequest.Banner do
  @moduledoc """
  The “banner” object must be included directly in the impression object if the impression offered
  for auction is display or rich media, or it may be optionally embedded in the video object to
  describe the companion banners available for the linear or non-linear video ad. The banner
  object may include a unique identifier; this can be useful if these IDs can be leveraged in the
  VAST response to dictate placement of the companion creatives when multiple companion ad
  opportunities of the same size are available on a page.
  """

  use Ecto.Schema
  import Ecto.Changeset

  @primary_key false
  embedded_schema do
    field(:w, :integer)
    field(:h, :integer)
    field(:id)
    field(:pos, :integer)
    field(:btype, {:array, :integer})
    field(:battr, {:array, :integer})
    field(:mimes, {:array, :string})
    field(:topframe, :integer, default: 0)
    field(:expdir, {:array, :integer})
    field(:api, {:array, :integer})
  end

  def changeset(banner, attrs \\ %{}) do
    banner
    |> cast(attrs, [:w, :h, :id, :pos, :btype, :battr, :mimes, :topframe, :expdir, :api])
    |> validate_number(:topframe, greater_than_or_equal_to: 0, less_than_or_equal_to: 1)
    |> validate_number(:btype, greater_than_or_equal_to: 1, less_than_or_equal_to: 4)
    |> validate_number(:battr, greater_than_or_equal_to: 1, less_than_or_equal_to: 16)
    |> validate_number(:expdir, greater_than_or_equal_to: 1, less_than_or_equal_to: 4)
  end
end
