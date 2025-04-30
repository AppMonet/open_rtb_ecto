defmodule OpenRtbEcto.V2.BidRequest.User do
  @moduledoc """
  This object contains information known or derived about the human user of the device (i.e., the
  audience for advertising). The user id is an exchange artifact and may be subject to rotation or
  other privacy policies. However, this user ID must be stable long enough to serve reasonably as
  the basis for frequency capping and retargeting.
  """

  use OpenRtbEcto.SafeSchema

  alias OpenRtbEcto.V2.BidRequest.{Geo, Data, Eids}

  @type t :: %__MODULE__{}

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
    embeds_many(:eids, Eids)
    field(:ext, :map, default: %{})
  end

  def changeset(user, attrs \\ %{}) do
    user
    |> safe_cast(attrs, [:id, :buyeruid, :yob, :gender, :keywords, :customdata, :ext])
    |> safe_cast_embed(:geo)
    |> safe_cast_embed(:data)
    |> safe_cast_embed(:eids)
  end
end
