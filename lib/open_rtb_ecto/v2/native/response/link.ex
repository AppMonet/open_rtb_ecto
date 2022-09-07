defmodule OpenRtbEcto.V2.Native.Response.Link do
  @moduledoc """
  Used for ‘call to action’ assets, or other links from the Native ad.
  This Object should be associated to its peer object in the parent Asset Object or as
  the master link in the top level Native Ad response object. When that peer object is
  activated (clicked) the action should take the user to the location of the link.
  """

  use Ecto.Schema
  import Ecto.Changeset

  @type t :: %__MODULE__{}

  embedded_schema do
    field(:url, :string)
    field(:clicktrackers, {:array, :string})
    field(:fallback, :string)
    field(:ext, :map, default: %{})
  end

  def changeset(link, attrs \\ %{}) do
    link
    |> cast(attrs, [
      :url,
      :clicktrackers,
      :fallback,
      :ext
    ])
    |> validate_required(:url)
  end
end
