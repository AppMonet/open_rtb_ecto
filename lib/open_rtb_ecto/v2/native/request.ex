defmodule OpenRtbEcto.V2.Native.Request do
  @moduledoc """
  The Native Object defines the native advertising opportunity available for bid via this bid request.
  """

  use Ecto.Schema
  import Ecto.Changeset
  alias OpenRtbEcto.V2.Native.Request.{Asset, EventTracker}

  @type t :: %__MODULE__{}

  embedded_schema do
    field(:ver, :string, default: "1.2")
    field(:context, :integer)
    field(:contextsubtype, :integer)
    field(:plcmttype, :integer)
    field(:plcmtcnt, :integer, default: 1)
    field(:seq, :integer, default: 0)
    embeds_many(:assets, Asset)
    field(:aurlsupport, :integer, default: 0)
    field(:durlsupport, :integer, default: 0)
    embeds_many(:eventtrackers, EventTracker)
    field(:privacy, :integer, default: 0)
    field(:ext, :map, default: %{})
  end

  def changeset(request, attrs \\ %{}) do
    request
    |> cast(attrs, [
      :ver,
      :context,
      :contextsubtype,
      :plcmttype,
      :plcmtcnt,
      :seq,
      :aurlsupport,
      :durlsupport,
      :privacy,
      :ext
    ])
    |> cast_embed(:assets, required: true)
    |> cast_embed(:eventtrackers)
  end
end
