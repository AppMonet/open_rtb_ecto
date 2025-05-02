defmodule OpenRtbEctoTest do
  use ExUnit.Case, async: true
  doctest OpenRtbEcto

  alias OpenRtbEcto.Support.TestHelper
  alias OpenRtbEcto.V2.BidRequest
  alias OpenRtbEcto.V2.BidRequest.Video

  describe "cast/2" do
    test "valid map" do
      data = TestHelper.test_data("v2/request", "example-request-app-android-1.json", :map)
      assert {:ok, %BidRequest{}} = OpenRtbEcto.cast(BidRequest, data)
    end

    test "valid json" do
      data = TestHelper.test_data("v2/request", "example-request-app-android-1.json", :json)
      assert {:ok, %BidRequest{}} = OpenRtbEcto.cast(BidRequest, data)
    end

    test "invalid json" do
      assert {:error, {:invalid_byte, _, _}} = OpenRtbEcto.cast(BidRequest, "blarg{")
    end

    test "charlists in errors are displayed as lists" do
      assert {:error, reason} = OpenRtbEcto.cast(Video, "{\"companiontype\":[4]}")
      assert %{companiontype: ["has an invalid entry, got [4]"]} = reason
    end
  end

  describe "json encoding" do
    test "all structs have JSON.Encoder implementations" do
      {:ok, all} = :application.get_key(:open_rtb_ecto, :modules)
      mods = for mod <- all, String.starts_with?(to_string(mod), "Elixir.OpenRtbEcto.V"), do: mod
      assert length(mods) > 1
      assert Enum.all?(mods, &JSON.encode!/1)
    end
  end

  describe "special cases" do
    test "invalid eid.uids are treated as empty values" do
      # This is quite a common occurance and it is undesirabled to consider the entire BidRequest invalid in this case.
      data = TestHelper.test_data("v2/request", "example-request-app-android-1.json", :map)

      eids = [
        %{
          "source" => "id5-sync.com",
          "uids" => [
            %{
              "id" =>
                "ID5*Ytuo5-HqJf5K7SPxHrzMjy_kToWAuuydYKFMDIzkBUjycgd-afG5Ln__Hf4afTRP8LTPtMmeNK25-SYPvlE9T_C6Hu3n5WO7eiH-lclH-5zw3vtFm7EYLKNPp-UJhYUr8N-OzM7p8yRtLYfTeE-GdfDr8URlJa3NSh4qI99sbXbw9x9bmwaZAuoe0PZg-4fr",
              "atype" => 1,
              "ext" => %{"linkType" => 2, "pba" => "fXPUj6QUvbNGkLLpoWmisG2jmkEw9hlrmAjktZt2es8="}
            }
          ]
        },
        %{
          "source" => "audigent.com",
          "uids" => [
            %{
              "id" => "060ixe9jsgld56gh7dcg6ha9jlj6h687gfcuom6weq0ky0qs2kiq0se6w0w0s042q",
              "atype" => 1
            }
          ]
        },
        %{
          "source" => "sourcewithinvaliduids.com",
          "uids" => [[]]
        },
        %{
          "source" => "sourcewithinvalidext.com",
          "uids" => [
            %{
              "id" => "32b89953-0f9a-4fb3-981a-2ad9041ff027",
              "atype" => 1,
              "ext" => "string_instead_of_map"
            }
          ]
        },
        %{
          "source" => "pubcid.org",
          "uids" => [%{"id" => "32b89953-0f9a-4fb3-981a-2ad9041ff027", "atype" => 1}]
        }
      ]

      data = put_in(data, ["user", "eids"], eids)
      assert {:ok, %BidRequest{user: %{eids: eids}}} = OpenRtbEcto.cast(BidRequest, data)

      assert 5 == Enum.count(eids)
      invalid_entry = Enum.find(eids, &(&1.source == "sourcewithinvaliduids.com"))
      assert [%BidRequest.Uid{}] == invalid_entry.uids

      invalid_ext = Enum.find(eids, &(&1.source == "sourcewithinvalidext.com"))
      uid = hd(invalid_ext.uids)
      assert "32b89953-0f9a-4fb3-981a-2ad9041ff027" == uid.id
      assert %{} == uid.ext
    end

    test "schain with no nodes" do
      schain = %{schain: %{complete: 1, nodes: nil, ver: "1.0"}}

      data =
        TestHelper.test_data("v2/request", "example-request-app-android-1.json", :map)
        |> put_in(["source"], schain)

      assert {:ok, %BidRequest{}} = OpenRtbEcto.cast(BidRequest, data)
    end
  end
end
