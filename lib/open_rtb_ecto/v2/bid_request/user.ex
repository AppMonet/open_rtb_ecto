defmodule OpenRtbEcto.V2.BidRequest.User do
  @moduledoc """
  This object contains information known or derived about the human user of the device (i.e., the
  audience for advertising). The user id is an exchange artifact and may be subject to rotation or
  other privacy policies. However, this user ID must be stable long enough to serve reasonably as
  the basis for frequency capping and retargeting.
  """

  use Ecto.Schema
  import Ecto.Changeset

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
    field(:consent)
    embeds_one(:geo, Geo)
    embeds_many(:data, Data)
    embeds_many(:eids, Eids)
    field(:ext, :map, default: %{})
  end

  def changeset(user, attrs) when is_map(user) do
    user
    |> cast(attrs, [:id, :buyeruid, :yob, :gender, :keywords, :customdata, :consent])
    |> OpenRtbEcto.safe_cast_ext(attrs)
    |> OpenRtbEcto.safe_cast_embeds_many(:eids, attrs)
    |> cast_embed(:geo)
    |> cast_embed(:data)
  end

  def changeset(user, _), do: change(user)
end
