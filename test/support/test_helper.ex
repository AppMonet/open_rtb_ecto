defmodule OpenRtbEcto.Support.TestHelper do
  def test_data(type, filename, format \\ :map)

  def test_data(type, filename, :json) do
    Path.join([File.cwd!(), "test", "data", type, filename])
    |> File.read!()
  end

  def test_data(type, filename, :map) do
    test_data(type, filename, :json)
    |> Jsonrs.decode!()
  end
end
