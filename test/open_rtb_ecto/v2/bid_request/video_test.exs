defmodule OpenRtbEcto.V2.BidRequest.VideoTest do
  use ExUnit.Case, async: true
  alias OpenRtbEcto.V2.BidRequest.Video

  test "video.api field must contain only positive integers" do
    assert {:ok, _} = OpenRtbEcto.cast(Video, "{\"api\":[7],\"mimes\":[\"video/mp4\"]}")
    assert {:error, %{api: errors}} = OpenRtbEcto.cast(Video, "{\"api\":[-7]}")
    assert ["has an invalid entry, got [-7]"] = errors
  end

  test "video.protocols can be up to 16" do
    assert {:ok, _} = OpenRtbEcto.cast(Video, "{\"protocols\":[16], \"mimes\":[\"video/mp4\"]}")
    assert {:error, %{protocols: [_]}} = OpenRtbEcto.cast(Video, "{\"protocols\":[\"a\"], \"mimes\":[\"video/mp4\"]}")
  end

  test "video.playbackmethod can be up to 7" do
    assert {:ok, _} = OpenRtbEcto.cast(Video, "{\"playbackmethod\":[7], \"mimes\":[\"video/mp4\"]}")
    assert {:error, %{playbackmethod: [_]}} = OpenRtbEcto.cast(Video, "{\"playbackmethod\":[8], \"mimes\":[\"video/mp4\"]}")
  end

  test "video.plcmt must be 1..4" do
    assert {:ok, _} = OpenRtbEcto.cast(Video, "{\"plcmt\":3,\"mimes\":[\"video/mp4\"]}")
    assert {:error, %{plcmt: [_]}} = OpenRtbEcto.cast(Video, "{\"plcmt\":-1}")
  end
end
