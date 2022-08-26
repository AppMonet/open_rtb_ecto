defmodule OpenRtbEcto.V2.Native.Request.Img do
  @moduledoc """
  The Image object to be used for all image elements of the Native ad such as Icons, Main Image, etc.
  """

  use Ecto.Schema
  import Ecto.Changeset

  @type t :: %__MODULE__{}

  embedded_schema do
    field(:type, :integer)
    field(:w, :integer)
    field(:wmin, :integer)
    field(:h, :integer)
    field(:hmin, :integer)
    field(:mimes, {:array, :string})
    field(:ext, :map, default: %{})
  end

  def changeset(img, attrs \\ %{}) do
    img
    |> cast(attrs, [
      :type,
      :w,
      :wmin,
      :h,
      :hmin,
      :mimes,
      :ext
    ])
  end
end
