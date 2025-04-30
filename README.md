# OpenRtbEcto

Ecto schemas for [OpenRTB](https://www.iab.com/guidelines/real-time-bidding-rtb-project/).

2.6 is complete, but 3.0 is in progress...

Also supports Bid

[OpenRTB 2.5 Spec](https://www.iab.com/wp-content/uploads/2016/03/OpenRTB-API-Specification-Version-2-5-FINAL.pdf)
[OpenRTB 2.6 Spec](https://iabtechlab.com/wp-content/uploads/2022/04/OpenRTB-2-6_FINAL.pdf)
[OpenRTB 3.0 Spec](https://github.com/InteractiveAdvertisingBureau/openrtb/blob/master/OpenRTB%20v3.0%20FINAL.md)

Starting from version 1.0, this library requires Elixir 1.18.0 and above as it uses the new JSON module.

## Installation

The package can be installed by adding `open_rtb_ecto` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:open_rtb_ecto, "~> 1.0"}
  ]
end
```

Docs can be found at [https://hexdocs.pm/open_rtb_ecto](https://hexdocs.pm/open_rtb_ecto).

### OpenRTB Example Payloads

https://wiki.smaato.com/pages/viewpage.action?pageId=1770079

### Notes

1. We do NOT attempt to validate ISO-4217 currency codes
1. In these [examples](https://github.com/openrtb/examples/tree/master/spotxchange):
   - the deprecated `protocol` field is used, but the data is an int array, like the new `protocols` field...
   - `content.season` is sent as an int instead of a string
1. Invalid data in optional fields is discarded rather than causing the entire changeset to be invalid
   - Required fields are still validated as before
   - For assets, having multiple media types still marks the entire asset as invalid
