defmodule OpenRtbEcto.V2.BidRequest.Eids do
  @moduledoc """
  Extended identifiers support in the OpenRTB specification allows buyers to use audience data in real-time
  bidding. This object can contain one or more UIDs from a single source or a technology provider. The
  exchange should ensure that business agreements allow for the sending of this data. 
  """
  alias OpenRtbEcto.V2.BidRequest.Uid

  use Ecto.Schema
  import Ecto.Changeset

  @type t :: %__MODULE__{}

  @primary_key false
  embedded_schema do
    field(:source)
    embeds_many(:uids, Uid)
    field(:ext, :map, default: %{})
  end

  def changeset(eids, attrs) when is_map(attrs) do
    eids
    |> cast(attrs, [:source])
    |> OpenRtbEcto.safe_cast_ext(attrs)
    |> OpenRtbEcto.safe_cast_embeds_many(:uids, attrs)
  end

  def changeset(eids, _), do: change(eids)
end
