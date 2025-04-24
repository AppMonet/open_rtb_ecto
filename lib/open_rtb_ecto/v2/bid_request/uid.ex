defmodule OpenRtbEcto.V2.BidRequest.Uid do
  @moduledoc """
  This object contains a single user identifier provided as part of extended identifiers. The exchange should
  ensure that business agreements allow for the sending of this data.
  """
  use Ecto.Schema
  import Ecto.Changeset

  @type t :: %__MODULE__{}

  @primary_key false
  embedded_schema do
    field(:id)
    field(:atype, :integer)
    field(:ext, :map, default: %{})
  end

  def changeset(uid, attrs \\ %{})

  def changeset(uid, attrs) when is_map(attrs) do
    uid
    |> cast(attrs, [:id, :atype, :ext])
  end

  def changeset(uid, _), do: cast(uid, %{}, [])
end
