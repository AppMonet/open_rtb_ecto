defmodule OpenRtbEcto.V2.BidRequest.Metric do
  @moduledoc """
  This object is associated with an impression as an array of metrics. These metrics can offer
  insight into the impression to assist with decisioning such as average recent viewability,
  click-through rate, etc. Each metric is identified by its type, reports the value of the metric,
  and optionally identifies the source or vendor measuring the value.
  """
  use Ecto.Schema
  import Ecto.Changeset

  @type t :: %__MODULE__{}

  @primary_key false
  embedded_schema do
    field(:type)
    field(:value, :float)
    field(:vendor)
    field(:ext, :map)
  end

  def changeset(metric, attrs \\ %{}) do
    metric
    |> cast(attrs, [:type, :value, :vendor, :ext])
    |> validate_number(:value, greater_than_or_equal_to: 0.0, less_than_or_equal_to: 1.0)
  end
end
