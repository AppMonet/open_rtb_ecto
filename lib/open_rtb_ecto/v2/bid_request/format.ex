defmodule OpenRtbEcto.V2.BidRequest.Format do
  @moduledoc """
  This object represents an allowed size (i.e., height and width combination) or Flex Ad parameters
  for a banner impression. These are typically used in an array where multiple sizes are permitted.
  It is recommended that either the w/h pair or the wratio/hratio/wmin set (i.e., for Flex Ads) be
  specified.
  """

  use Ecto.Schema
  import Ecto.Changeset

  @type t :: %__MODULE__{}

  @primary_key false
  embedded_schema do
    field(:w, :integer)
    field(:h, :integer)
    field(:wratio, :integer)
    field(:hratio, :integer)
    field(:wmin, :integer)
    field(:ext, :map, default: %{})
  end

  def changeset(format, attrs \\ %{}) do
    format
    |> cast(attrs, [:w, :h, :wratio, :hratio, :wmin, :ext])
  end
end
