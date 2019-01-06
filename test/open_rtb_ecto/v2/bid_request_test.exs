defmodule OpenRtbEcto.V2.BidRequestTest do
  use OpenRtbEcto.OpenRtbCase, async: true

  alias OpenRtbEcto.V2.BidRequest

  describe "valid data" do
    test "cast from map" do
      data_1 = test_data("request", "example-request-app-android-1.json")
      data_2 = test_data("request", "example-request-app-android-2.json")
      assert {:ok, casted_1} = OpenRtbEcto.cast(BidRequest, data_1)
      assert {:ok, casted_2} = OpenRtbEcto.cast(BidRequest, data_2)
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
