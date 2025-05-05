defmodule OpenRtbEcto.V2.BidRequest.Audio do
  @moduledoc """
  This object represents an audio type impression. Many of the fields are non-essential for minimally
  viable transactions, but are included to offer fine control when needed. Audio in OpenRTB generally
  assumes compliance with the DAAST standard. As such, the notion of companion ads is supported by
  optionally including an array of Banner objects (refer to the Banner object in Section 3.2.6) that define
  these companion ads.

  The presence of a Audio as a subordinate of the Imp object indicates that this impression is offered as
  an audio type impression. At the publisher’s discretion, that same impression may also be offered as
  banner, video, and/or native by also including as Imp subordinates objects of those types. However, any
  given bid for the impression must conform to one of the offered types.
  """

  use Ecto.Schema
  import Ecto.Changeset

  alias OpenRtbEcto.Types.TinyInt
  alias OpenRtbEcto.V2.BidRequest.Banner

  @type t :: %__MODULE__{}

  @primary_key false
  embedded_schema do
    field(:mimes, {:array, :string})
    field(:minduration, :integer)
    field(:maxduration, :integer)
    field(:rqddurs, {:array, :integer})
    field(:protocols, {:array, :integer})
    field(:startdelay, :integer)
    field(:maxseq, :integer)
    field(:poddur, :integer)
    field(:podid, :integer)
    field(:podseq, :integer)
    field(:mincpmpersec, :float)
    field(:slotinpod, :integer)
    field(:sequence, :integer)
    field(:battr, {:array, :integer})
    field(:maxextended, :integer)
    field(:minbitrate, :integer)
    field(:maxbitrate, :integer)
    field(:delivery, {:array, :integer})
    embeds_many(:companionad, Banner)
    field(:api, {:array, :integer})
    field(:companiontype, {:array, :integer})
    field(:feed, :integer)
    field(:stitched, TinyInt)
    field(:nvol, :integer)
    field(:ext, :map, default: %{})
  end

  def changeset(video, attrs) when is_map(attrs) do
    video
    |> cast(attrs, [
      :mimes,
      :minduration,
      :maxduration,
      :rqddurs,
      :protocols,
      :startdelay,
      :maxseq,
      :poddur,
      :podid,
      :podseq,
      :mincpmpersec,
      :slotinpod,
      :sequence,
      :battr,
      :maxextended,
      :minbitrate,
      :maxbitrate,
      :delivery,
      :api,
      :companiontype,
      :feed,
      :stitched,
      :nvol
    ])
    |> OpenRtbEcto.safe_cast_ext(attrs)
    |> cast_embed(:companionad)
    |> validate_required([:mimes])
    |> validate_subset(:protocols, 1..10)
    |> validate_number(:startdelay, greater_than_or_equal_to: -2)
    |> validate_number(:maxextended, greater_than_or_equal_to: -1)
    |> validate_subset(:battr, 1..17)
    |> validate_subset(:delivery, 1..3)
    |> validate_subset(:api, 1..6)
    |> validate_subset(:companiontype, 1..3)
    |> validate_inclusion(:feed, 1..3)
    |> validate_inclusion(:nvol, 0..4)
  end

  def changeset(audio, _), do: change(audio)
end
