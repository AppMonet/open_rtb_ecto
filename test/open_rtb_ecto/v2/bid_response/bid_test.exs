defmodule OpenRtbEcto.V2.BidResponse.BidTest do
  use ExUnit.Case, async: true

  alias OpenRtbEcto.V2.BidResponse

  test "crid is never nil" do
    tests = [{nil, "1"}, {"123", "123"}]

    for {input, expected} <- tests do
      data = %{
        "adid" => "52a5516d29e435137c6f6e74",
        "adm" =>
          "<a href=\"http://ads.com/click/112770_1386565997\"><img src=\"http://ads.com/img/112770_1386565997?won=${AUCTION_PRICE}\" width=\"728\" height=\"90\" border=\"0\" alt=\"Advertisement\" /></a>",
        "adomain" => ["ads.com"],
        "attr" => [],
        "cid" => "52a5516d29e435137c6f6e74",
        "crid" => input,
        "id" => "1",
        "impid" => "1",
        "iurl" => "http://ads.com/112770_1386565997.jpeg",
        "nurl" => "http://ads.com/win/112770_1386565997?won=${AUCTION_PRICE}",
        "price" => 0.751371
      }

      {:ok, casted} = OpenRtbEcto.cast(BidResponse.Bid, data)
      assert casted.crid == expected
    end

    {:ok, casted} = OpenRtbEcto.cast(BidResponse.Bid, %{id: "1", impid: "1", price: 1.0})
    assert casted.crid == "1"
  end
end
