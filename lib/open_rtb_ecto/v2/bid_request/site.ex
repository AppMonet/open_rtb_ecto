defmodule OpenRtbEcto.V2.BidRequest.Site do
  @moduledoc """
  This object should be included if the ad supported content is a website as opposed to a non-browser
  application. A bid request must not contain both a Site and an App object. At a minimum, it is useful
  to provide a site ID or page URL, but this is not strictly required.
  """

  use Ecto.Schema
  import Ecto.Changeset

  alias OpenRtbEcto.Types.TinyInt
  alias OpenRtbEcto.V2.BidRequest.{Publisher, Content}

  @primary_key false
  embedded_schema do
    field(:id)
    field(:name)
    field(:domain)
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
    field(:ext, :map)
  end

  def changeset(site, attrs \\ %{}) do
    site
    |> cast(attrs, [
      :id,
      :name,
      :domain,
      :cat,
      :sectioncat,
      :pagecat,
      :page,
      :ref,
      :search,
      :mobile,
      :privacypolicy,
      :keywords,
      :ext
    ])
    |> cast_embed(:publisher)
    |> cast_embed(:content)
  end
end
