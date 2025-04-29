defmodule OpenRtbEcto.V2.BidRequest.VideoTest do
  use ExUnit.Case, async: true
  alias OpenRtbEcto.V2.BidRequest.Video

  test "valid api values are accepted" do
    assert {:ok, video} = OpenRtbEcto.cast(Video, "{\"api\":[7],\"mimes\":[\"video/mp4\"]}")
    assert video.api == [7]
  end

  test "negative integers in arrays are now accepted" do
    assert {:ok, video} = OpenRtbEcto.cast(Video, "{\"api\":[-7],\"mimes\":[\"video/mp4\"]}")
    assert video.api == [-7]
  end

  test "video.protocols can be up to 16 (valid values)" do
    assert {:ok, video} =
             OpenRtbEcto.cast(Video, "{\"protocols\":[16], \"mimes\":[\"video/mp4\"]}")

    assert video.protocols == [16]
  end

  test "video.protocols with invalid values are discarded" do
    assert {:ok, video} =
             OpenRtbEcto.cast(Video, "{\"protocols\":[\"a\"], \"mimes\":[\"video/mp4\"]}")

    assert video.protocols == nil
    assert video.mimes == ["video/mp4"]
  end

  test "video.playbackmethod can be up to 7 (valid values)" do
    assert {:ok, video} =
             OpenRtbEcto.cast(Video, "{\"playbackmethod\":[7], \"mimes\":[\"video/mp4\"]}")

    assert video.playbackmethod == [7]
  end

  test "video.playbackmethod with invalid types are discarded" do
    assert {:ok, video} =
             OpenRtbEcto.cast(
               Video,
               "{\"playbackmethod\":\"not-an-array\", \"mimes\":[\"video/mp4\"]}"
             )

    assert is_nil(video.playbackmethod)
    assert video.mimes == ["video/mp4"]
  end

  test "video.plcmt can be 1..4 (valid values)" do
    assert {:ok, video} = OpenRtbEcto.cast(Video, "{\"plcmt\":3,\"mimes\":[\"video/mp4\"]}")
    assert video.plcmt == 3
  end

  test "video.plcmt with invalid types are discarded" do
    assert {:ok, video} =
             OpenRtbEcto.cast(
               Video,
               "{\"plcmt\":\"string-not-integer\",\"mimes\":[\"video/mp4\"]}"
             )

    assert video.plcmt == nil
    assert video.mimes == ["video/mp4"]
  end

  test "integer values outside range are still accepted" do
    assert {:ok, video} = OpenRtbEcto.cast(Video, "{\"plcmt\":-1,\"mimes\":[\"video/mp4\"]}")
    assert video.plcmt == -1
    assert video.mimes == ["video/mp4"]
  end
end
