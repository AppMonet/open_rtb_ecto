defmodule OpenRtbEcto.V2.BidRequest.Video do
  @moduledoc """
  This object represents an in-stream video impression. Many of the fields are non-essential for
  minimally viable transactions, but are included to offer fine control when needed. Video in
  OpenRTB generally assumes compliance with the VAST standard. As such, the notion of companion ads
  is supported by optionally including an array of Banner objects (refer to the Banner object in
  Section 3.2.6) that define these companion ads.

  The presence of a Video as a subordinate of the Imp object indicates that this impression is
  offered as a video type impression. At the publisher's discretion, that same impression may also
  be offered as banner, audio, and/or native by also including as Imp subordinates objects of those
  types. However, any given bid for the impression must conform to one of the offered types.
  """

  use OpenRtbEcto.SafeSchema

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
    field(:plcmt, :integer)
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
    |> safe_cast(attrs, [
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
      :plcmt,
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
    |> safe_cast_embed(:companionad)
    |> validate_required([:mimes])

    # Range validations are removed, but basic type casting is maintained through safe_cast
    # This means fields with invalid types will be discarded,
    # but we won't validate numeric ranges, etc.
  end
end
