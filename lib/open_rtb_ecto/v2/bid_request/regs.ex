defmodule OpenRtbEcto.V2.BidRequest.Regs do
  @moduledoc """
  This object contains any legal, governmental, or industry regulations that apply to the request. The coppa flag signals whether or not the request falls under the United States Federal Trade Commission’s regulations for the United States Children’s Online Privacy Protection Act (“COPPA”).
  """
  use Ecto.Schema
  import Ecto.Changeset

  alias OpenRtbEcto.Types.TinyInt

  @primary_key false
  embedded_schema do
    field(:coppa, TinyInt)
    field(:ext, :map)
  end

  def changeset(regs, attrs \\ %{}) do
    regs
    |> cast(attrs, [:coppa, :ext])
  end
end
