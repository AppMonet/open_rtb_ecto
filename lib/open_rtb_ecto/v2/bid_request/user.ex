defmodule OpenRtbEcto.V2.BidRequest.User do
  @moduledoc """
  The “user” object contains information known or derived about the human user of the device.
  Note that the user ID is an exchange artifact (refer to the “device” object for hardware or
  platform derived IDs) and may be subject to rotation policies. However, this user ID must be
  stable long enough to serve reasonably as the basis for frequency capping.
  The user object itself and all of its parameters are optional, so default values are not provided.
  If an optional parameter is not specified, it should be considered unknown.
  If device ID is used as a proxy for unique user ID, use the device object.
  """

  use Ecto.Schema
  import Ecto.Changeset

  alias OpenRtbEcto.V2.BidRequest.{Geo, Data}

  @primary_key false
  embedded_schema do
    field(:id)
    field(:buyeruid)
    field(:yob, :integer)
    field(:gender)
    field(:keywords)
    field(:customdata)
    embeds_one(:geo, Geo)
    embeds_many(:data, Data)
  end

  def changeset(user, attrs \\ %{}) do
    user
    |> cast(attrs, [:id, :buyeruid, :yob, :gender, :keywords, :customdata])
    |> cast_embed(:geo)
    |> cast_embed(:data)
  end
end
