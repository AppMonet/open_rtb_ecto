defmodule OpenRtbEcto.V2.BidRequest.Site do
  @moduledoc """
  A site object should be included if the ad supported content is part of a website (as opposed to
  an application). A bid request must not contain both a site object and an app object.
  The site object itself and all of its parameters are optional, so default values are not provided. If
  an optional parameter is not specified, it should be considered unknown. At a minimum, it’s
  useful to provide a page URL or a site ID, but this is not strictly required.
  """

  use Ecto.Schema
  import Ecto.Changeset

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
    field(:privacypolicy, :integer)
    field(:ref)
    field(:search)
    embeds_one(:publisher, Publisher)
    embeds_one(:content, Content)
    field(:keywords)
  end

  # TODO validate categories?
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
      :privacypolicy,
      :ref,
      :search,
      :keywords
    ])
    |> cast_embed(:publisher)
    |> cast_embed(:content)
    |> validate_inclusion(:privacypolicy, 0..1)
  end
end
