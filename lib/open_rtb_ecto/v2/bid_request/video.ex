defmodule OpenRtbEcto.V2.BidRequest.Video do
  @moduledoc """
  This object represents an in-stream video impression. Many of the fields are non-essential for
  minimally viable transactions, but are included to offer fine control when needed. Video in
  OpenRTB generally assumes compliance with the VAST standard. As such, the notion of companion ads
  is supported by optionally including an array of Banner objects (refer to the Banner object in
  Section 3.2.6) that define these companion ads.

  The presence of a Video as a subordinate of the Imp object indicates that this impression is
  offered as a video type impression. At the publisher’s discretion, that same impression may also
  be offered as banner, audio, and/or native by also including as Imp subordinates objects of those
  types. However, any given bid for the impression must conform to one of the offered types.
  """

  use Ecto.Schema
  import Ecto.Changeset

  alias OpenRtbEcto.Types.TinyInt
  alias OpenRtbEcto.V2.BidRequest.Banner

  @type t :: %__MODULE__{}

  embedded_schema do
    field(:mimes, {:array, :string})
    field(:minduration, :integer)
    field(:maxduration, :integer)
    field(:rqddurs, {:array, :integer})
    field(:protocols, {:array, :integer})
    field(:protocol, :integer)
    field(:w, :integer)
    field(:h, :integer)
    field(:startdelay, :integer)
    field(:maxseq, :integer)
    field(:poddur, :integer)
    field(:podid, :integer)
    field(:podseq, :integer)
    field(:mincpmpersec, :float)
    field(:slotinpod, :integer)
    field(:placement, :integer)
    field(:linearity, :integer)
    field(:skip, TinyInt)
    field(:skipmin, :integer, default: 0)
    field(:skipafter, :integer, default: 0)
    field(:sequence, :integer)
    field(:battr, {:array, :integer})
    field(:maxextended, :integer)
    field(:minbitrate, :integer)
    field(:maxbitrate, :integer)
    field(:boxingallowed, TinyInt, default: 1)
    field(:playbackmethod, {:array, :integer})
    field(:playbackend, :integer)
    field(:delivery, {:array, :integer})
    field(:pos, :integer)
    embeds_many(:companionad, Banner)
    field(:api, {:array, :integer})
    field(:companiontype, {:array, :integer})
    field(:ext, :map, default: %{})
  end

  def changeset(video, attrs \\ %{}) do
    video
    |> cast(attrs, [
      :mimes,
      :minduration,
      :maxduration,
      :rqddurs,
      :protocols,
      :protocol,
      :w,
      :h,
      :startdelay,
      :maxseq,
      :poddur,
      :podid,
      :podseq,
      :mincpmpersec,
      :slotinpod,
      :placement,
      :linearity,
      :skip,
      :skipmin,
      :skipafter,
      :sequence,
      :battr,
      :maxextended,
      :minbitrate,
      :maxbitrate,
      :boxingallowed,
      :playbackmethod,
      :playbackend,
      :delivery,
      :pos,
      :api,
      :companiontype,
      :ext
    ])
    |> cast_embed(:companionad)
    |> validate_required([:mimes])
    |> validate_inclusion(:linearity, 1..2)
    |> validate_inclusion(:protocol, 1..10)
    |> validate_subset(:protocols, 1..10)
    |> validate_inclusion(:placement, 1..5)
    |> validate_number(:startdelay, greater_than_or_equal_to: -2)
    |> validate_number(:pos, greater_than: -1, less_than: 8)
    |> validate_number(:maxextended, greater_than_or_equal_to: -1)
    |> validate_subset(:battr, 1..17)
    |> validate_subset(:playbackmethod, 1..6)
    |> validate_inclusion(:playbackend, 1..3)
    |> validate_subset(:delivery, 1..3)
    |> validate_list_of_pos_ints(:api)
    |> validate_subset(:companiontype, 1..3)
  end

  defp validate_list_of_pos_ints(changeset, field) do
    case get_change(changeset, field) do
      nil ->
        changeset

      values ->
        if Enum.all?(values, fn v -> is_integer(v) and v > 0 end) do
          changeset
        else
          add_error(changeset, field, "has an invalid entry")
        end
    end
  end
end
