defmodule OpenRtbEcto.V2.BidRequest.Publisher do
  @moduledoc """
  This object describes the publisher of the media in which the ad will be displayed. The publisher
  is typically the seller in an OpenRTB transaction.
  """

  use Ecto.Schema
  import Ecto.Changeset

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

  def changeset(publisher, attrs) when is_map(attrs) do
    publisher
    |> cast(attrs, [:id, :name, :cattax, :cat, :domain, :ext])
  end

  def changeset(publisher, _), do: change(publisher)
end
