defmodule OpenRtbEcto.V2.BidRequest.VideoTest do
  use ExUnit.Case, async: true
  alias OpenRtbEcto.V2.BidRequest.Video

  test "video.api field must contain only positive integers" do
    assert {:ok, _} = OpenRtbEcto.cast(Video, "{\"api\":[7],\"mimes\":[\"video/mp4\"]}")
    assert {:error, %{api: errors}} = OpenRtbEcto.cast(Video, "{\"api\":[-7]}")
    assert ["has an invalid entry, got [-7]"] = errors
  end

  test "video.plcmt must be 1..4" do
    assert {:ok, _} = OpenRtbEcto.cast(Video, "{\"plcmt\":3,\"mimes\":[\"video/mp4\"]}")
    assert {:error, %{plcmt: [_]}} = OpenRtbEcto.cast(Video, "{\"plcmt\":-1}")
  end
end
