defmodule OpenRtbEctoTest do
  use OpenRtbEcto.OpenRtbCase, async: true
  doctest OpenRtbEcto

  alias OpenRtbEcto.V2.BidRequest
  alias OpenRtbEcto.V2.BidRequest.Video

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

    test "charlists in errors are displayed as lists" do
      assert {:error, reason} = OpenRtbEcto.cast(Video, "{\"companiontype\":[4]}")
      assert %{companiontype: ["has an invalid entry, got [4]"]} = reason
    end
  end

  describe "json encoding" do
    test "all structs have Jason.Encoder implementations" do
      {:ok, all} = :application.get_key(:open_rtb_ecto, :modules)
      mods = for mod <- all, String.starts_with?(to_string(mod), "Elixir.OpenRtbEcto.V"), do: mod
      assert length(mods) > 1
      assert Enum.all?(mods, &Jason.encode!/1)
    end
  end
end
