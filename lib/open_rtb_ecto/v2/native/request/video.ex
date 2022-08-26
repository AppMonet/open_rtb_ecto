defmodule OpenRtbEcto.V2.Native.Request.Video do
  @moduledoc """
  The video object to be used for all video elements supported in the Native Ad. This corresponds to the Video object of OpenRTB.
  """

  use Ecto.Schema
  import Ecto.Changeset

  embedded_schema do
    field(:mimes, {:array, :string})
    field(:minduration, :integer)
    field(:maxduration, :integer)
    field(:protocols, {:array, :integer})
    field(:ext, :map, default: %{})
  end

  def changeset(request, attrs \\ %{}) do
    request
    |> cast(attrs, [
      :mimes,
      :minduration,
      :maxduration,
      :protocols,
      :ext
    ])
  end
end
