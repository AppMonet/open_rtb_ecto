defmodule OpenRtbEctoTest do
  use OpenRtbEcto.OpenRtbCase, async: true
  doctest OpenRtbEcto

  alias OpenRtbEcto.V2.BidRequest
  alias OpenRtbEcto.V2.BidResponse.Bid

  describe "cast/2" do
    test "valid map" do
      data = test_data("v2/request", "example-request-app-android-1.json", :map)
      assert {:ok, %BidRequest{}} = OpenRtbEcto.cast(BidRequest, data)
    end

    test "valid json" do
      data = test_data("v2/request", "example-request-app-android-1.json", :json)
      assert {:ok, %BidRequest{}} = OpenRtbEcto.cast(BidRequest, data)
    end

    test "invalid json" do
      assert {:error, %Jason.DecodeError{}} = OpenRtbEcto.cast(BidRequest, "blarg{")
    end
  end

  describe "format_invalid_changeset/1" do
    test "properly formats invalid validate_inclusion" do
      assert {:error, error} = OpenRtbEcto.cast(Bid, %{api: 18})

      assert %{
               api: ["is invalid, got 18"]
             } = error
    end
  end
end
