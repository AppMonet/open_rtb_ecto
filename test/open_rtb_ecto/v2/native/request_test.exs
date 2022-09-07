defmodule OpenRtbEcto.V2.Native.RequestTest do
  use ExUnit.Case

  alias OpenRtbEcto.V2.Native.Request
  alias OpenRtbEcto.Support.TestHelper

  describe "valid data" do
    test "valid native request data" do
      data = TestHelper.test_data("v2/request", "correct-native-request.json")
      assert {:ok, %Request{}} = OpenRtbEcto.cast(Request, data)
    end
  end

  describe "invalid data" do
    test "valid native request data" do
      data = TestHelper.test_data("v2/request", "incorrect-native-request-without-assets.json")
      assert {:error, _} = OpenRtbEcto.cast(Request, data)
    end
  end
end
