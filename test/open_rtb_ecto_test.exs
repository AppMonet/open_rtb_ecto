defmodule OpenRtbEctoTest do
  use OpenRtbEcto.OpenRtbCase, async: true
  doctest OpenRtbEcto

  alias OpenRtbEcto.V2.BidRequest

  describe "cast/2" do
    test "valid map" do
      data = test_data("request", "example-request-app-android-1.json", :map)
      assert {:ok, %BidRequest{}} = OpenRtbEcto.cast(BidRequest, data)
    end

    test "valid json" do
      data = test_data("request", "example-request-app-android-1.json", :json)
      assert {:ok, %BidRequest{}} = OpenRtbEcto.cast(BidRequest, data)
    end

    test "invalid json" do
      assert {:error, %Jason.DecodeError{}} = OpenRtbEcto.cast(BidRequest, "blarg{")
    end
  end
end
