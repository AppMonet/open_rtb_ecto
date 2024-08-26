defmodule OpenRtbEcto.V2.BidRequestTest do
  use ExUnit.Case, async: true

  alias OpenRtbEcto.Support.TestHelper
  alias OpenRtbEcto.V2.BidRequest

  alias OpenRtbEcto.V2.BidRequest.{
    App,
    Imp,
    Device,
    User,
    Pmp,
    Video,
    UserAgent
  }

  # all of the fields that are required anywhere
  @globally_required_defaults %{
    imp: [%{id: "1", banner: %{w: 300, h: 250}}],
    request: "{}",
    mimes: ["video/mp4"],
    ver: "1.0",
    complete: 1,
    id: "1234",
    sid: "one",
    asi: "one",
    nodes: [%{hp: 1, asi: "example", sid: "one"}],
    brand: "MyGreatBrand"
  }

  describe "changeset setup" do
    test "changeset will cast all fields" do
      global_required_defaults_set = MapSet.new(Map.keys(@globally_required_defaults))

      all_structs =
        :application.get_key(:open_rtb_ecto, :modules)
        |> elem(1)
        |> Enum.filter(&(&1 |> Module.split() |> Enum.take(3) == ~w|OpenRtbEcto V2 BidRequest|))

      structs = Enum.map(all_structs, &struct/1)
      structs = Enum.map(structs, fn s -> {s, Map.keys(s)} end)

      # assert that if we applied a change containing this key,
      # it would be reflected in the struct
      for {struct_name, fields} <- structs, k <- fields, k != :__struct__ do
        struct_tag = Map.get(struct_name, :__struct__)

        new_value =
          case struct_tag.__schema__(:type, k) do
            :string ->
              "example"

            :integer ->
              1

            :float ->
              1.1

            :map ->
              %{test: %{value: 1}}

            OpenRtbEcto.Types.TinyInt ->
              0

            {:array, :string} ->
              ["test"]

            {:array, :integer} ->
              [1]

            {:parameterized, _, _} ->
              :skip

            _other ->
              :skip
          end

        if new_value != :skip do
          input = %{k => new_value}
          required = MapSet.intersection(MapSet.new(fields), global_required_defaults_set)

          input =
            Enum.reduce(required, input, fn
              ^k, input ->
                input

              rf, input ->
                Map.put(
                  input,
                  rf,
                  Map.get(@globally_required_defaults, rf)
                )
            end)
            |> Map.delete(:__struct__)

          assert {:ok, %{:__struct__ => ^struct_tag, ^k => ^new_value}} =
                   OpenRtbEcto.cast(struct_tag, input)
        end
      end
    end
  end

  describe "valid data" do
    test "android requests" do
      data = TestHelper.test_data("v2/request", "example-request-app-android-1.json")
      assert {:ok, %BidRequest{} = req} = OpenRtbEcto.cast(BidRequest, data)
      assert req.id == "7979d0c78074638bbdf739ffdf285c7e1c74a691"
      assert [%Imp{}] = req.imp
      assert %App{id: "20625"} = req.app
      assert %Device{make: "Samsung"} = req.device
      assert %User{id: "bd5adc55dcbab4bf090604df4f543d90b09f0c88"} = req.user

      data = TestHelper.test_data("v2/request", "example-request-app-android-2.json")
      assert {:ok, %BidRequest{}} = OpenRtbEcto.cast(BidRequest, data)
    end

    test "iphone request" do
      data = TestHelper.test_data("v2/request", "iphone.json")
      assert {:ok, %BidRequest{}} = OpenRtbEcto.cast(BidRequest, data)
    end

    test "structured user-agent" do
      data = TestHelper.test_data("v2/request", "structured-ua.json")

      assert {:ok,
              %BidRequest{
                device: %Device{
                  sua: %UserAgent{
                    browsers: [%{brand: "Chrome", version: ["1.2"]}],
                    architecture: "aarch64",
                    platform: %{brand: "iOS", version: ["15.0"]}
                  }
                }
              }} = OpenRtbEcto.cast(BidRequest, data)
    end

    test "multiple imps" do
      data = TestHelper.test_data("v2/request", "multi-imp.json")
      assert {:ok, %BidRequest{} = req} = OpenRtbEcto.cast(BidRequest, data)
      assert [%Imp{}, %Imp{}, %Imp{}] = req.imp
    end

    test "with pmp" do
      data = TestHelper.test_data("v2/request", "pmp.json")
      assert {:ok, %BidRequest{} = req} = OpenRtbEcto.cast(BidRequest, data)
      assert [%Imp{pmp: %Pmp{}, video: %Video{boxingallowed: 1}}] = req.imp
    end
  end

  describe "invalid data" do
    test "returns error tuple with friendly error map" do
      data = TestHelper.test_data("v2/request", "example-request-app-android-1.json")

      invalid =
        data
        |> Map.put("allimps", 1_000)
        |> Map.delete("id")

      assert {:error, reasons} = OpenRtbEcto.cast(BidRequest, invalid)
      assert %{allimps: ["is invalid, got 0"], id: ["can't be blank, got nil"]} = reasons
    end
  end

  describe "json encoding" do
    test "fields with nil values are omitted" do
      str = Poison.encode!(%BidRequest{})
      map = Poison.decode!(str)

      assert 3 == map_size(map)
      assert ["allimps", "at", "test"] = Enum.sort(Map.keys(map))
    end
  end
end
