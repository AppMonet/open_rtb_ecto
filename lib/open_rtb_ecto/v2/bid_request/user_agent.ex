defmodule OpenRtbEcto.V2.BidRequest.UserAgent do
  @moduledoc """
  Structured user agent information, which can be used when a client supports User-Agent Client Hints. If
  both device.ua and device.sua are present in the bid request, device.sua should be considered the more
  accurate representation of the device attributes. This is because the device.ua may contain a frozen or
  reduced user agent string due to deprecation of user agent strings by browsers.
  """
  alias OpenRtbEcto.Types.TinyInt
  alias OpenRtbEcto.V2.BidRequest.BrandVersion

  use Ecto.Schema
  import Ecto.Changeset

  @type t :: %__MODULE__{}

  @primary_key false
  embedded_schema do
    embeds_many(:browsers, BrandVersion)
    embeds_one(:platform, BrandVersion)
    field(:mobile, TinyInt)
    field(:architecture)
    field(:bitness)
    field(:model)
    field(:source, :integer)
    field(:ext, :map, default: %{})
  end

  def changeset(user_agent, attrs) when is_map(attrs) do
    user_agent
    |> cast(attrs, [:mobile, :architecture, :bitness, :model, :source])
    |> OpenRtbEcto.safe_cast_ext(attrs)
    |> safe_cast_browsers(attrs)
    |> cast_embed(:platform)
  end

  def changeset(user_agent, _), do: change(user_agent)

  defp safe_cast_browsers(changeset, %{"browsers" => browsers}) when is_list(browsers),
    do: cast_embed(changeset, :browsers)

  defp safe_cast_browsers(changeset, %{browsers: browsers}) when is_list(browsers),
    do: cast_embed(changeset, :browsers)

  defp safe_cast_browsers(changeset, _attrs), do: changeset
end
