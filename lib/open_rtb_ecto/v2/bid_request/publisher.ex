defmodule OpenRtbEcto.V2.BidRequest.Publisher do
  @moduledoc """
  The publisher object itself and all of its parameters are optional, so default values are not
  provided. If an optional parameter is not specified, it should be considered unknown.
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

  #
  # TODO validate categories?
  def changeset(producer, attrs \\ %{}) do
    producer
    |> cast(attrs, [:id, :name, :cat, :domain])
  end
end
