defmodule OpenRtbEcto.V2.BidRequest.App do
  @moduledoc """
  This object should be included if the ad supported content is a non-browser application (typically in
  mobile) as opposed to a website. A bid request must not contain both an App and a Site object. At a
  minimum, it is useful to provide an App ID or bundle, but this is not strictly required.
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
    field(:bundle)
    field(:domain)
    field(:storeurl)
    field(:cattax, :integer)
    field(:cat, {:array, :string})
    field(:sectioncat, {:array, :string})
    field(:pagecat, {:array, :string})
    field(:ver)
    field(:privacypolicy, TinyInt)
    field(:paid, TinyInt)
    embeds_one(:publisher, Publisher)
    embeds_one(:content, Content)
    field(:keywords)
    # Magnite XAPI extension:
    # An array of string identifiers denoting the advertiser blocklist
    # relevant for this impression.
    field(:blocklists, {:array, :string})
    field(:ext, :map, default: %{})
  end

  def changeset(app, attrs \\ %{}) do
    app
    |> cast(attrs, [
      :id,
      :name,
      :bundle,
      :domain,
      :storeurl,
      :cattax,
      :cat,
      :sectioncat,
      :pagecat,
      :ver,
      :privacypolicy,
      :paid,
      :keywords,
      :blocklists,
      :ext
    ])
    |> cast_embed(:publisher)
    |> cast_embed(:content)
  end
end
