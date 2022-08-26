defmodule OpenRtbEcto.V2.Native.Request do
  @moduledoc """
  The Native Object defines the native advertising opportunity available for bid via this bid request. It will be included as a JSON-encoded string in the bid request’s imp.native field or as a direct JSON object, depending on the choice of the exchange.
  """

  use Ecto.Schema
  import Ecto.Changeset
  alias OpenRtbEcto.V2.Native.Request.{Assets, EventTrackers}

  @type t :: %__MODULE__{}

  embedded_schema do
    field(:ver, :string, default: "1.2")
    field(:context, :integer)
    field(:contextsubtype, :integer)
    field(:plcmttype, :integer)
    field(:plcmtcnt, :integer, default: 1)
    field(:seq, :integer, default: 0)
    embeds_many(:assets, Assets)
    field(:aurlsupport, :integer, default: 0)
    field(:durlsupport, :integer, default: 0)
    embeds_many(:eventtrackers, EventTrackers)
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
      :bseat,
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
