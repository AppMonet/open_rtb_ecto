defmodule OpenRtbEcto.V2.BidRequest.Producer do
  @moduledoc """
  The producer is useful when content where the ad is shown is syndicated, and may appear on a
  completely different publisher. The producer object itself and all of its parameters are optional,
  so default values are not provided. If an optional parameter is not specified, it should be
  considered unknown. This object is optional, but useful if the content producer is different
  from the site publisher.
  """

  use Ecto.Schema
  import Ecto.Changeset

  @primary_key false
  embedded_schema do
    field(:id)
    field(:name)
    field(:cat, {:array, :string})
    field(:domain)
  end

  # TODO validate categories?
  def changeset(producer, attrs \\ %{}) do
    producer
    |> cast(attrs, [:id, :name, :cat, :domain])
  end
end
