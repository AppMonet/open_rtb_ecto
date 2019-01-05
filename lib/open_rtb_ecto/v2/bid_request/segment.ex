defmodule OpenRtbEcto.V2.BidRequest.Segment do
  @moduledoc """
  The data and segment objects together allow data about the user to be passed to bidders in the
  bid request. Segment objects convey specific units of information from the provider identified
  in the parent data object.
  The segment object itself and all of its parameters are optional, so default values are not
  provided; if an optional parameter is not specified, it should be considered unknown.
  """

  use Ecto.Schema
  import Ecto.Changeset

  @primary_key false
  embedded_schema do
    field(:id)
    field(:name)
    field(:value)
  end

  #
  def changeset(producer, attrs \\ %{}) do
    producer
    |> cast(attrs, [:id, :name, :value])
  end
end
