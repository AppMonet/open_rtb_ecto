defmodule OpenRtbEcto.V2.BidRequest.Content do
  @moduledoc """
  The content object itself and all of its parameters are optional, so default values are not
  provided. If an optional parameter is not specified, it should be considered unknown. This
  object describes the content in which the impression will appear (may be syndicated or nonsyndicated
  content).
  This object may be useful in the situation where syndicated content contains impressions and
  does not necessarily match the publisher’s general content. The exchange might or might not
  have knowledge of the page where the content is running, as a result of the syndication
  method. (For example, video impressions embedded in an iframe on an unknown web property
  or device.)
  """

  use Ecto.Schema
  import Ecto.Changeset

  alias OpenRtbEcto.V2.BidRequest.Producer

  @valid_contexts MapSet.new(["1", "2", "3", "4", "5", "6", "7"])

  @primary_key false
  embedded_schema do
    field(:id)
    field(:episode, :integer)
    field(:title)
    field(:series)
    field(:season)
    field(:url)
    field(:cat, {:array, :string})
    field(:videoquality, :integer)
    field(:keywords)
    field(:contentrating)
    field(:userrating)
    field(:context)
    field(:livestream, :integer)
    field(:sourcerelationship, :integer)
    embeds_one(:producer, Producer)
    field(:len, :integer)
  end

  # TODO
  # do we want/need to validate cat values are valid IAB categories?
  def changeset(content, attrs \\ %{}) do
    content
    |> cast(attrs, [
      :id,
      :episode,
      :title,
      :series,
      :season,
      :url,
      :cat,
      :videoquality,
      :keywords,
      :contentrating,
      :userrating,
      :context,
      :livestream,
      :sourcerelationship,
      :len
    ])
    |> cast_embed(:producer)
    |> validate_number(:videoquality, greater_than_or_equal_to: 0, less_than_or_equal_to: 3)
    |> validate_number(:livestream, greater_than_or_equal_to: 0, less_than_or_equal_to: 1)
    |> validate_number(:sourcerelationship, greater_than_or_equal_to: 0, less_than_or_equal_to: 1)
    |> validate_inclusion(:context, @valid_contexts)
  end
end
