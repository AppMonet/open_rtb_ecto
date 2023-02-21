defmodule OpenRtbEcto.V2.BidRequestTest do
  use ExUnit.Case, async: true

  alias OpenRtbEcto.Support.TestHelper
  alias OpenRtbEcto.V2.BidRequest
  alias OpenRtbEcto.V2.BidRequest.{App, Imp, Device, User, Pmp, Video, UserAgent}

  describe "valid data" do
    test "android requests" do
      data = TestHelper.test_data("v2/request", "example-request-app-android-1.json")
      assert {:ok, %BidRequest{} = req} = OpenRtbEcto.cast(BidRequest, data)
      assert req.id == "7979d0c78074638bbdf739ffdf285c7e1c74a691"
      assert [%Imp{}] = req.imp
      assert %App{id: "20625"} = req.app
      assert %Device{make: "Samsung"} = req.device
      assert %User{id: "bd5adc55dcbab4bf090604df4f543d90b09f0c88"} = req.user

      data = TestHelper.test_data("v2/request", "example-request-app-android-2.json")
      assert {:ok, %BidRequest{}} = OpenRtbEcto.cast(BidRequest, data)
    end

    test "iphone request" do
      data = TestHelper.test_data("v2/request", "iphone.json")
      assert {:ok, %BidRequest{}} = OpenRtbEcto.cast(BidRequest, data)
    end

    test "structured user-agent" do
      data = TestHelper.test_data("v2/request", "structured-ua.json")

      assert {:ok,
              %BidRequest{
                device: %Device{
                  sua: %UserAgent{
                    browsers: [%{brand: "Chrome", version: ["1.2"]}],
                    architecture: "aarch64",
                    platform: %{brand: "iOS", version: ["15.0"]}
                  }
                }
              }} = OpenRtbEcto.cast(BidRequest, data)
    end

    test "multiple imps" do
      data = TestHelper.test_data("v2/request", "multi-imp.json")
      assert {:ok, %BidRequest{} = req} = OpenRtbEcto.cast(BidRequest, data)
      assert [%Imp{}, %Imp{}, %Imp{}] = req.imp
    end

    test "with pmp" do
      data = TestHelper.test_data("v2/request", "pmp.json")
      assert {:ok, %BidRequest{} = req} = OpenRtbEcto.cast(BidRequest, data)
      assert [%Imp{pmp: %Pmp{}, video: %Video{boxingallowed: 1}}] = req.imp
    end
  end

  describe "invalid data" do
    test "returns error tuple with friendly error map" do
      data = TestHelper.test_data("v2/request", "example-request-app-android-1.json")

      invalid =
        data
        |> Map.put("allimps", 1_000)
        |> Map.delete("id")

      assert {:error, reasons} = OpenRtbEcto.cast(BidRequest, invalid)
      assert %{allimps: ["is invalid, got 0"], id: ["can't be blank, got nil"]} = reasons
    end
  end

  describe "json encoding" do
    test "fields with nil values are omitted" do
      assert "{\"allimps\":0,\"at\":2,\"test\":0}" == Jason.encode!(%BidRequest{})
    end
  end
end
