defmodule OpenRtbEcto.V2.BidRequest.Producer do
  @moduledoc """
  This object defines the producer of the content in which the ad will be shown. This is
  particularly useful when the content is syndicated and may be distributed through different publishers
  and thus when the producer and publisher are not necessarily the same entity.
  """

  use OpenRtbEcto.SafeSchema

  @type t :: %__MODULE__{}

  @primary_key false
  embedded_schema do
    field(:id)
    field(:name)
    field(:cattax, :integer)
    field(:cat, {:array, :string})
    field(:domain)
    field(:ext, :map, default: %{})
  end

  def changeset(producer, attrs \\ %{}) do
    producer
    |> safe_cast(attrs, [:id, :name, :cattax, :cat, :domain, :ext])
  end
end
