defmodule OpenRtbEcto.V2.Native.ResponseTest do
  use ExUnit.Case

  alias OpenRtbEcto.V2.Native.Response
  alias OpenRtbEcto.Support.TestHelper

  describe "valid data" do
    test "valid native response data" do
      data = TestHelper.test_data("v2/response", "native-bid-response.json")
      assert {:ok, %Response{}} = OpenRtbEcto.cast(Response, data)
    end
  end

  describe "Poison Encoder protocol is implemented" do
    assert Poison.encode!(%Response{})
  end
end
