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
    field(:ext, :map)
  end

  def changeset(uid, attrs \\ %{}) do
    uid
    |> cast(attrs, [:id, :atype, :ext])
  end
end
