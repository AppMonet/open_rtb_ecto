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

    test "required field errors are still reported" do
      assert {:error, reason} = OpenRtbEcto.cast(Video, "{}")
      assert %{mimes: ["can't be blank, got nil"]} = reason
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
      assert %{} == uid.ext
    end

    test "schain without nodes casts safely" do
      schain = %{
        ver: "1.2",
        complete: 1,
        nodes: nil
      }

      assert {:ok, result} = OpenRtbEcto.cast(OpenRtbEcto.V2.BidRequest.SupplyChain, schain)
      assert result.ver == "1.2"
      assert result.complete == 1
      assert result.nodes == []

      bid_request =
        TestHelper.test_data("v2/request", "example-request-app-android-1.json", :map)
        |> put_in(["source"], %{"schain" => schain})

      assert {:ok, casted} = OpenRtbEcto.cast(OpenRtbEcto.V2.BidRequest, bid_request)
      assert casted.source.schain.ver == "1.2"
      assert casted.source.schain.complete == 1
      assert casted.source.schain.nodes == []
    end

    test "real example with empty arrays in eids list" do
      bid_request =
        TestHelper.test_data("v2/request", "invalid-eids.json", :map)

      assert {:ok, casted} = OpenRtbEcto.cast(OpenRtbEcto.V2.BidRequest, bid_request)

      # Ensure that the empty arrays in eids are handled gracefully
      # (they are converted to empty eids objects with default values)
      assert casted.user.eids != nil
      dbg(casted.user.eids)
      assert is_list(casted.user.eids)

      # Check if there are any eids entries that came from empty arrays
      empty_eids =
        Enum.filter(casted.user.eids, fn eid ->
          eid.source == nil && eid.uids == [] && eid.ext == %{}
        end)

      # We should have at least one entry that came from an empty array
      assert length(empty_eids) > 0
    end
  end
end
