# OpenRtbEcto
Ecto schemas for [OpenRTB](https://www.iab.com/guidelines/real-time-bidding-rtb-project/).

2.5 is complete, but 3.0 is in progress...

[OpenRTB 2.5 Spec](https://www.iab.com/wp-content/uploads/2016/03/OpenRTB-API-Specification-Version-2-5-FINAL.pdf)

[OpenRTB 3.0 Spec](https://github.com/InteractiveAdvertisingBureau/openrtb/blob/master/OpenRTB%20v3.0%20FINAL.md)

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `open_rtb_ecto` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:open_rtb_ecto, "~> 0.1.0"}
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
