defmodule OpenRtbEcto.V2.BidRequest.Network do
  @moduledoc """
  This object describes the network an ad will be displayed on. A Network is defined as the parent entity of
  the Channel object’s entity for the purposes of organizing Channels. Examples are companies that own
  and/or license a collection of content channels (Viacom, Discovery, CBS, WarnerMedia, Turner and others),
  or studio that creates such content and self-distributes content. Name is a human-readable field while
  domain and id can be used for reporting and targeting purposes. See 7.6 for further examples.
  """
  use Ecto.Schema
  import Ecto.Changeset

  @type t :: %__MODULE__{}

  @primary_key false
  embedded_schema do
    field(:id)
    field(:name)
    field(:domain)
    field(:ext, :map, default: %{})
  end

  def changeset(network, attrs) when is_map(attrs) do
    network
    |> cast(attrs, [
      :id,
      :name,
      :domain
    ])
    |> OpenRtbEcto.safe_cast_ext(attrs)
  end

  def changeset(network, _), do: change(network)
end
