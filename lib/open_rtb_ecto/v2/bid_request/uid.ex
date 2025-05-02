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

  @doc """
  In the wild, there invalid EID UIDs are very common so this changeset is very lenient
  and discards invalid data rather than considering the changeset invalid.
  """
  def changeset(uid, attrs) when is_map(attrs) do
    uid
    |> cast(attrs, [:id, :atype])
    |> OpenRtbEcto.safe_cast_ext(attrs)
  end

  def changeset(uid, _), do: change(uid)
end
