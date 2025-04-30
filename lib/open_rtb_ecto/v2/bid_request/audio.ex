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

  use OpenRtbEcto.SafeSchema

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

  def changeset(video, attrs \\ %{}) do
    video
    |> safe_cast(attrs, [
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
      :nvol,
      :ext
    ])
    |> safe_cast_embed(:companionad)
    |> validate_required([:mimes])
  end
end
