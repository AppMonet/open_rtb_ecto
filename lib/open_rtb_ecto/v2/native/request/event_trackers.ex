defmodule OpenRtbEcto.V2.Native.Request.EventTrackers do
  @moduledoc """
  The event trackers object specifies the types of events the bidder can request to be tracked in the bid response, and which types of tracking are available for each event type, and is included as an array in the request.
  """

  use Ecto.Schema
  import Ecto.Changeset

  embedded_schema do
    field(:event, :integer)
    field(:methods, {:array, :integer})
    field(:ext, :map, default: %{})
  end

  def changeset(request, attrs \\ %{}) do
    request
    |> cast(attrs, [
      :event,
      :methods,
      :ext
    ])
    |> validate_required([:event, :methods])
  end
end
