defmodule OpenRtbEcto.V2.Native.Response.EventTracker do
  @moduledoc """
  The event trackers response is an array of objects and specifies the types of events the bidder
  wishes to track and the URLs/information to track them. Bidder must only respond with methods
  indicated as available in the request. Note that most javascript trackers expect to be loaded at
  impression time, so it’s not generally recommended for the buyer to respond with javascript trackers on
  other events, but the appropriateness of this is up to each buyer.
  """

  use Ecto.Schema
  import Ecto.Changeset

  @type t :: %__MODULE__{}

  embedded_schema do
    field(:event, :integer)
    field(:method, :integer)
    field(:url, :string)
    field(:customdata, :map, default: %{})
    field(:ext, :map, default: %{})
  end

  def changeset(event_tracker, attrs \\ %{}) do
    event_tracker
    |> cast(attrs, [
      :event,
      :method,
      :url,
      :customdata,
      :ext
    ])
    |> validate_required([:event, :method])
  end
end
