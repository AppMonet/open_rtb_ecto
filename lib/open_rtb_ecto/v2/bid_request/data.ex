defmodule OpenRtbEcto.V2.BidRequest.Data do
  @moduledoc """
  The data and segment objects together allow additional data about the related object (e.g., user,
  content) to be specified. This data may be from multiple sources whether from the exchange itself
  or third parties as specified by the id field. A bid request can mix data objects from multiple
  providers. The specific data providers in use should be published by the exchange a priori to its
  bidders.
  """

  use Ecto.Schema
  import Ecto.Changeset

  alias OpenRtbEcto.V2.BidRequest.Segment

  @type t :: %__MODULE__{}

  @primary_key false
  embedded_schema do
    field(:id)
    field(:name)
    embeds_many(:segment, Segment)
    field(:ext, :map, default: %{})
  end

  def changeset(data, attrs \\ %{}) do
    data
    |> cast(attrs, [:id, :name, :ext])
    |> cast_embed(:segment)
  end
end
