defmodule OpenRtbEcto.V2.BidRequest.Site do
  @moduledoc """
  This object should be included if the ad supported content is a website as opposed to a
  non-browser application. A bid request must not contain both a Site and an App object. At a
  minimum, it is useful to provide a site ID or page URL, but this is not strictly required.
  """

  use Ecto.Schema
  import Ecto.Changeset

  alias OpenRtbEcto.Types.TinyInt
  alias OpenRtbEcto.V2.BidRequest.{Publisher, Content}

  @type t :: %__MODULE__{}

  @primary_key false
  embedded_schema do
    field(:id)
    field(:name)
    field(:domain)
    field(:cattax, :integer)
    field(:cat, {:array, :string})
    field(:sectioncat, {:array, :string})
    field(:pagecat, {:array, :string})
    field(:page)
    field(:ref)
    field(:search)
    field(:mobile, TinyInt)
    field(:privacypolicy, TinyInt)
    embeds_one(:publisher, Publisher)
    embeds_one(:content, Content)
    field(:keywords)
    # Magnite XAPI extension:
    # An array of string identifiers denoting the advertiser blocklist
    # relevant for this impression.
    field(:blocklists, {:array, :string})
    field(:ext, :map, default: %{})
  end

  def changeset(site, attrs) when is_map(attrs) do
    site
    |> cast(attrs, [
      :id,
      :name,
      :domain,
      :cattax,
      :cat,
      :sectioncat,
      :pagecat,
      :page,
      :ref,
      :search,
      :mobile,
      :privacypolicy,
      :keywords,
      :blocklists
    ])
    |> OpenRtbEcto.safe_cast_ext(attrs)
    |> cast_embed(:publisher)
    |> cast_embed(:content)
  end

  def changeset(site, _), do: change(site)
end
