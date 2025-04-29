defmodule OpenRtbEcto.V2.Native.Request.AssetTest do
  use ExUnit.Case, async: true

  alias OpenRtbEcto.V2.Native.Request.Asset
  alias OpenRtbEcto.Support.TestHelper

  describe "invalid data (now discarded)" do
    test "cast with invalid data that contains title and video discards the invalid media" do
      data = TestHelper.test_data("v2/request", "incorrect-assets-data-title-video.json")
      # With our new behavior, this should succeed but discard invalid media
      assert {:ok, asset} = OpenRtbEcto.cast(Asset, data)

      # Make sure the id was properly parsed
      assert asset.id == 1
    end

    test "cast with all media types discards the invalid media" do
      data = TestHelper.test_data("v2/request", "incorrect-assets-data-all-media.json")
      # With our new behavior, this should succeed but discard invalid media
      assert {:ok, asset} = OpenRtbEcto.cast(Asset, data)

      # Make sure the id was properly parsed
      assert asset.id == 1
    end
  end

  describe "valid data" do
    test "valid asset data" do
      data = TestHelper.test_data("v2/request", "correct-assets.json")
      assert {:ok, %Asset{}} = OpenRtbEcto.cast(Asset, data)
    end
  end
end
