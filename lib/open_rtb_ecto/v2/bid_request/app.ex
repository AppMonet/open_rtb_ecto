defmodule OpenRtbEcto.V2.BidRequest.App do
  @moduledoc """
  An “app” object should be included if the ad supported content is part of a mobile application
  (as opposed to a mobile website). A bid request must not contain both an “app” object and a
  “site” object.
  The app object itself and all of its parameters are optional, so default values are not provided. If
  an optional parameter is not specified, it should be considered unknown. . At a minimum, it’s
  useful to provide an App ID or bundle, but this is not strictly required.
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
    field(:ver)
    field(:bundle)
    field(:privacypolicy, :integer)
    field(:paid)
    embeds_one(:publisher, Publisher)
    embeds_one(:content, Content)
    field(:keywords)
  end

  def changeset(app, attrs \\ %{}) do
    app
    |> cast(attrs, [
      :id,
      :name,
      :domain,
      :cat,
      :sectioncat,
      :pagecat,
      :ver,
      :bundle,
      :privacypolicy,
      :paid,
      :keywords
    ])
    |> cast_embed(:publisher)
    |> cast_embed(:content)
    |> validate_number(:privacypolicy, greater_than_or_equal_to: 0, less_than_or_equal_to: 1)
  end
end
