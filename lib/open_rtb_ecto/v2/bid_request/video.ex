defmodule OpenRtbEcto.V2.BidRequest.Video do
  @moduledoc """
  The “video” object must be included directly in the impression object if the impression offered
  for auction is an in-stream video ad opportunity.
  """

  use Ecto.Schema
  import Ecto.Changeset

  alias OpenRtbEcto.V2.BidRequest.Banner

  embedded_schema do
    field(:mimes, {:array, :string})
    field(:linearity, :integer)
    field(:minduration, :integer)
    field(:maxduration, :integer)
    field(:protocol, :integer)
    field(:w, :integer)
    field(:h, :integer)
    field(:startdelay, :integer)
    field(:sequence, :integer, default: 1)
    field(:battr, {:array, :integer})
    field(:maxextended, :integer)
    field(:minbitrate, :integer)
    field(:maxbitrate, :integer)
    field(:boxingallowed, :integer, default: 1)
    field(:playbackmethod, {:array, :integer})
    field(:delivery, {:array, :integer})
    field(:pos, :integer)
    embeds_many(:companionad, Banner)
    field(:api, {:array, :integer})
  end

  def changeset(video, attrs \\ %{}) do
    video
    |> cast(attrs, [
      :mimes,
      :linearity,
      :minduration,
      :maxduration,
      :protocol,
      :w,
      :h,
      :startdelay,
      :sequence,
      :battr,
      :maxextended,
      :minbitrate,
      :maxbitrate,
      :boxingallowed,
      :playbackmethod,
      :delivery,
      :pos,
      :api
    ])
    |> cast_embed(:companionad)
    |> validate_required([:mimes, :linearity, :minduration, :maxduration, :protocol])
    |> validate_inclusion(:linearity, 1..2)
    |> validate_inclusion(:protocol, 1..6)
    |> validate_inclusion(:startdelay, -2..0)
    |> validate_number(:battr, greater_than_or_equal_to: 1, less_than_or_equal_to: 16)
    |> validate_number(:maxextended, greater_than_or_equal_to: -1)
    |> validate_inclusion(:boxingallowed, 0..1)
    |> validate_inclusion(:playbackmethod, 1..4)
    |> validate_inclusion(:delivery, 1..2)
    |> validate_inclusion(:pos, 0..3)
    |> validate_inclusion(:api, 1..4)
  end
end
