defmodule OpenRtbEcto.V2.Native.Request.Video do
  @moduledoc """
  The video object to be used for all video elements supported in the Native Ad.
  This corresponds to the Video object of OpenRTB.
  """

  use OpenRtbEcto.SafeSchema

  @type t :: %__MODULE__{}

  embedded_schema do
    field(:mimes, {:array, :string})
    field(:minduration, :integer)
    field(:maxduration, :integer)
    field(:protocols, {:array, :integer})
    field(:ext, :map, default: %{})
  end

  def changeset(video, attrs \\ %{}) do
    video
    |> safe_cast(attrs, [
      :mimes,
      :minduration,
      :maxduration,
      :protocols,
      :ext
    ])
    |> validate_required([
      :mimes,
      :minduration,
      :maxduration,
      :protocols
    ])
  end
end
