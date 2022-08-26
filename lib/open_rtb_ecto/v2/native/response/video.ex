defmodule OpenRtbEcto.V2.Native.Response.Video do
  @moduledoc """
  Corresponds to the Video Object in the request, yet containing a value of a conforming VAST tag as a value.
  """

  use Ecto.Schema
  import Ecto.Changeset

  @type t :: %__MODULE__{}

  embedded_schema do
    field(:vasttag, :string)
  end

  def changeset(video, attrs \\ %{}) do
    video
    |> cast(attrs, :vasttag)
    |> validate_required(:vasttag)
  end
end
