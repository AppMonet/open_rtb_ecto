defmodule EncoderTest do
  use ExUnit.Case, async: true

  describe "encode\1" do
    test "encoding a struct with empty fields should drop them" do
      eids = %OpenRtbEcto.V2.BidRequest.Eids{}
      assert "{}" == Jsonrs.encode!(eids)
    end
  end
end
