defmodule OpenRtbEcto.V2.Native.Request.AssetTest do
  use ExUnit.Case, async: true

  alias OpenRtbEcto.V2.Native.Request.Asset
  alias OpenRtbEcto.Support.TestHelper

  describe "invalid data" do
    test "cast will return error as data contains title and video" do
      data = TestHelper.test_data("v2/request", "incorrect-assets-data-title-video.json")
      assert {:error, %{media: error}} = OpenRtbEcto.cast(Asset, data)

      assert ["changeset object may contain only one of title, img, data or video, got nil"] =
               error
    end

    test "cast will return error as data contains all media" do
      data = TestHelper.test_data("v2/request", "incorrect-assets-data-all-media.json")
      assert {:error, %{media: error}} = OpenRtbEcto.cast(Asset, data)

      assert ["changeset object may contain only one of title, img, data or video, got nil"] =
               error
    end
  end

  describe "valid data" do
    test "valid asset data" do
      data = TestHelper.test_data("v2/request", "correct-assets.json")
      assert {:ok, %Asset{}} = OpenRtbEcto.cast(Asset, data)
    end
  end
end
