defmodule OpenRtbEcto.V2.BidRequest.Content do
  @moduledoc """
  This object describes the content in which the impression will appear, which may be syndicated or
  nonsyndicated content. This object may be useful when syndicated content contains impressions and
  does not necessarily match the publisher’s general content. The exchange might or might not have
  knowledge of the page where the content is running, as a result of the syndication method. For
  example might be a video impression embedded in an iframe on an unknown web property or device.
  """

  use Ecto.Schema
  import Ecto.Changeset

  alias OpenRtbEcto.Types.TinyInt
  alias OpenRtbEcto.V2.BidRequest.{Producer, Data, Network, Channel}

  @type t :: %__MODULE__{}

  @primary_key false
  embedded_schema do
    field(:id)
    field(:episode, :integer)
    field(:title)
    field(:series)
    field(:season)
    field(:artist)
    field(:genre)
    field(:album)
    field(:isrc)
    embeds_one(:producer, Producer)
    field(:url)
    field(:cattax, :integer)
    field(:cat, {:array, :string})
    field(:prodq, :integer)
    field(:videoquality, :integer)
    field(:context, :integer)
    field(:contentrating)
    field(:userrating)
    field(:qagmediarating, :integer)
    field(:keywords)
    field(:livestream, TinyInt)
    field(:sourcerelationship, TinyInt)
    field(:len, :integer)
    field(:language)
    field(:langb)
    field(:embeddable, TinyInt)
    embeds_many(:data, Data)
    field(:ext, :map, default: %{})
    embeds_one(:network, Network)
    embeds_one(:channel, Channel)
  end

  def changeset(content, attrs) when is_map(content) do
    content
    |> cast(attrs, [
      :id,
      :episode,
      :title,
      :series,
      :season,
      :artist,
      :genre,
      :album,
      :isrc,
      :url,
      :cattax,
      :cat,
      :prodq,
      :videoquality,
      :context,
      :contentrating,
      :userrating,
      :qagmediarating,
      :keywords,
      :livestream,
      :sourcerelationship,
      :len,
      :language,
      :langb,
      :embeddable
    ])
    |> OpenRtbEcto.safe_cast_ext(attrs)
    |> cast_embed(:producer)
    |> cast_embed(:data)
    |> cast_embed(:network)
    |> cast_embed(:channel)
    |> validate_inclusion(:videoquality, 0..3)
    |> validate_inclusion(:prodq, 0..3)
    |> validate_inclusion(:context, 1..7)
    |> validate_inclusion(:qagmediarating, 1..3)
  end

  def changeset(content, _), do: change(content)
end
