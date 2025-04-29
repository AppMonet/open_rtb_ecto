defmodule OpenRtbEcto.DiscardInvalidTest do
  use ExUnit.Case

  alias OpenRtbEcto.V2.BidRequest
  alias OpenRtbEcto.V2.BidRequest.Device

  test "top-level optional fields with invalid values are discarded" do
    # Create a BidRequest with an invalid at value
    request_data = %{
      id: "test-id-123",
      imp: [%{id: "imp-1"}],
      # :at should be 1, 2 or > 500; 3 is invalid
      at: 3
    }

    {:ok, result} = OpenRtbEcto.cast(BidRequest, request_data)

    # The invalid at value should be discarded, falling back to the default
    assert result.at == 2
  end

  test "nested object with invalid fields can still be parsed" do
    # Create a BidRequest with a device that has invalid devicetype
    request_data = %{
      id: "test-id-123",
      imp: [%{id: "imp-1"}],
      device: %{
        ua: "Mozilla/5.0",
        # devicetype should be 1-7; 99 is invalid
        devicetype: 99
      }
    }

    {:ok, result} = OpenRtbEcto.cast(BidRequest, request_data)

    # The device should still be included, but the invalid devicetype should be discarded
    assert result.device != nil
    assert result.device.ua == "Mozilla/5.0"
    assert result.device.devicetype == nil
  end

  test "tiny_int fields with invalid values are discarded" do
    # Create a Device with an invalid TinyInt value
    device_data = %{
      ua: "Mozilla/5.0",
      # Should be 0, 1, true, or false
      dnt: "invalid"
    }

    # Direct use of the Device changeset
    changeset = Device.changeset(%Device{}, device_data)
    result = Ecto.Changeset.apply_changes(changeset)

    # The dnt field should be nil since the invalid value was discarded
    assert result.dnt == nil
    # But other fields should be present
    assert result.ua == "Mozilla/5.0"
  end
end
