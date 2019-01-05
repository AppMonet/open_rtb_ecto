defmodule OpenRtbEcto.V2.BidRequest do
  @moduledoc """
  The top-level bid request object contains a globally unique bid request or auction ID. This “id”
  attribute is required as is at least one “imp” (i.e., impression) object. Other attributes are
  optional since an exchange may establish default values.
  """

  use Ecto.Schema
  import Ecto.Changeset

  alias OpenRtbEcto.V2.BidRequest.{Impression, Site, App, Device, User}

  @primary_key false
  embedded_schema do
    field(:id)
    embeds_many(:imp, Impression)
    embeds_one(:site, Site)
    embeds_one(:app, App)
    embeds_one(:device, Device)
    embeds_one(:user, User)
    field(:at, :integer, default: 2)
    field(:tmax, :integer)
    field(:wseat, {:array, :string})
    field(:allimps, :integer, default: 0)
    field(:cur, {:array, :string})
    field(:bcat, {:array, :string})
    field(:badav, {:array, :string})
    field(:ext, :map)
  end

  def changeset(request, attrs \\ %{}) do
    request
    |> cast(attrs, [:id, :at, :tmax, :wseat, :allimps, :cur, :bcat, :badav, :ext])
    |> cast_embed(:imp)
    |> cast_embed(:site)
    |> cast_embed(:app)
    |> cast_embed(:device)
    |> cast_embed(:user)
    |> validate_required([:id, :imp])
    |> validate_auction_type()
    |> validate_inclusion(:allimps, 0..1)
  end

  # TODO put this somewhere common as it is used in v2 & v3
  defp validate_auction_type(changeset) do
    case get_change(changeset, :at) do
      nil -> changeset
      val when val in 0..1 or val > 500 -> changeset
      _ -> add_error(changeset, :at, "must equal 0, 1 or be greater than 500")
    end
  end
end
