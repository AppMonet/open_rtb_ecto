defmodule OpenRtbEcto.V2.BidRequest do
  @moduledoc """
  The top-level bid request object contains a globally unique bid request or auction ID. This id attribute is
  required as is at least one impression object (Section 3.2.4). Other attributes in this top-level object
  establish rules and restrictions that apply to all impressions being offered.

  There are also several subordinate objects that provide detailed data to potential buyers. Among these
  are the Site and App objects, which describe the type of published media in which the impression(s)
  appear. These objects are highly recommended, but only one applies to a given bid request depending
  on whether the media is browser-based web content or a non-browser application, respectively.
  """

  use OpenRtbEcto.SafeSchema

  alias OpenRtbEcto.Types.TinyInt
  alias OpenRtbEcto.V2.BidRequest.{Imp, Site, App, Device, User, Source, Regs}

  @type t :: %__MODULE__{}

  @primary_key false
  embedded_schema do
    field(:id)
    embeds_many(:imp, Imp)
    embeds_one(:site, Site)
    embeds_one(:app, App)
    embeds_one(:device, Device)
    embeds_one(:user, User)
    field(:test, :integer, default: 0)
    field(:at, :integer, default: 2)
    field(:tmax, :integer)
    field(:wseat, {:array, :string})
    field(:bseat, {:array, :string})
    field(:allimps, TinyInt, default: 0)
    field(:cur, {:array, :string})
    field(:wlang, {:array, :string})
    field(:wlangb, {:array, :string})
    field(:cattax, :integer)
    field(:bcat, {:array, :string})
    field(:badv, {:array, :string})
    field(:bapp, {:array, :string})
    embeds_one(:source, Source)
    embeds_one(:regs, Regs)
    field(:ext, :map, default: %{})
  end

  def changeset(request, attrs \\ %{}) do
    request
    |> safe_cast(
      attrs,
      [
        :id,
        :test,
        :at,
        :tmax,
        :wseat,
        :bseat,
        :allimps,
        :cur,
        :wlang,
        :wlangb,
        :bcat,
        :badv,
        :bapp,
        :ext,
        :cattax
      ]
    )
    |> cast_embed(:imp, required: true)
    |> safe_cast_embed(:site)
    |> safe_cast_embed(:app)
    |> safe_cast_embed(:device)
    |> safe_cast_embed(:user)
    |> safe_cast_embed(:source)
    |> safe_cast_embed(:regs)
    |> validate_required(:id)
    |> validate_auction_type()
  end

  defp validate_auction_type(changeset) do
    case get_change(changeset, :at) do
      nil ->
        changeset

      val when val in 1..2 or val > 500 ->
        changeset

      _ ->
        # Invalid auction type is an optional field, so discard instead of error
        delete_change(changeset, :at)
    end
  end
end
