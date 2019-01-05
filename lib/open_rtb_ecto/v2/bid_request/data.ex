defmodule OpenRtbEcto.V2.BidRequest.Data do
  @moduledoc """
  The data and segment objects together allow data about the user to be passed to bidders in the
  bid request. This data may be from multiple sources (e.g., the exchange itself, third party
  providers) as specified by the data object ID field. A bid request can mix data objects from
  multiple providers.
  The data object itself and all of its parameters are optional, so default values are not provided.
  If an optional parameter is not specified, it should be considered unknown.
  """

  use Ecto.Schema
  import Ecto.Changeset

  alias OpenRtbEcto.V2.BidRequest.Segment

  @primary_key false
  embedded_schema do
    field(:id)
    field(:name)
    embeds_many(:segment, Segment)
  end

  def changeset(data, attrs \\ %{}) do
    data
    |> cast(attrs, [:id, :name])
    |> cast_embed(:segment)
  end
end
