defmodule OpenRtbEcto.V2.Native.Request.EventTracker do
  @moduledoc """
  The event trackers object specifies the types of events the bidder can request to be tracked in the bid response,
  and which types of tracking are available for each event type, and is included as an array in the request.
  """

  use OpenRtbEcto.SafeSchema

  @type t :: %__MODULE__{}

  embedded_schema do
    field(:event, :integer)
    field(:methods, {:array, :integer})
    field(:ext, :map, default: %{})
  end

  def changeset(event_tracker, attrs \\ %{}) do
    event_tracker
    |> safe_cast(attrs, [
      :event,
      :methods,
      :ext
    ])
    |> validate_required([:event, :methods])
  end
end
