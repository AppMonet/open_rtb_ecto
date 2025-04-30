defmodule OpenRtbEcto.V2.Native.Response.Img do
  @moduledoc """
  Corresponds to the Image Object in the request. The Image object to be used for all
  image elements of the Native ad such as Icons, Main Image, etc.
  """

  use OpenRtbEcto.SafeSchema

  @type t :: %__MODULE__{}

  embedded_schema do
    field(:type, :integer)
    field(:url, :string)
    field(:w, :integer)
    field(:h, :integer)
    field(:ext, :map, default: %{})
  end

  def changeset(img, attrs \\ %{}) do
    img
    |> safe_cast(attrs, [
      :type,
      :url,
      :w,
      :h,
      :ext
    ])
    |> validate_required(:url)
  end
end
