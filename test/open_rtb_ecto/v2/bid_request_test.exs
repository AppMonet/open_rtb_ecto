defmodule OpenRtbEcto.V2.BidRequestTest do
  use OpenRtbEcto.OpenRtbCase, async: true

  alias OpenRtbEcto.V2.BidRequest
  alias OpenRtbEcto.V2.BidRequest.{App, Impression, Device, User}

  describe "valid data" do
    test "cast from map" do
      data = test_data("request", "example-request-app-android-1.json", :map)
      assert {:ok, %BidRequest{} = req} = OpenRtbEcto.cast(BidRequest, data)
      assert req.id == "7979d0c78074638bbdf739ffdf285c7e1c74a691"
      assert [%Impression{}] = req.imp
      assert %App{id: "20625"} = req.app
      assert %Device{make: "Samsung"} = req.device
      assert %User{id: "bd5adc55dcbab4bf090604df4f543d90b09f0c88"} = req.user

      data = test_data("request", "example-request-app-android-2.json", :map)
      assert {:ok, %BidRequest{}} = OpenRtbEcto.cast(BidRequest, data)
    end
  end

  describe "invalid data" do
    test "returns error tuple with friendly error map" do
      data = test_data("request", "example-request-app-android-1.json")

      invalid =
        data
        |> Map.put("allimps", 1_000)
        |> Map.delete("id")

      assert {:error, reasons} = OpenRtbEcto.cast(BidRequest, invalid)
      assert %{allimps: ["is invalid"], id: ["can't be blank"]} = reasons
    end
  end
end
