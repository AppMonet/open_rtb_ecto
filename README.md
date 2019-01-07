# OpenRtbEcto

[OpenRTB 2.0 Spec](https://www.iab.com/wp-content/uploads/2015/06/OpenRTB_API_Specification_Version2_0_FINAL.pdf)

[OpenRTB 3.0 Spec](https://github.com/InteractiveAdvertisingBureau/openrtb/blob/master/OpenRTB%20v3.0%20FINAL.md)

**TODO: Add description**

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

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at [https://hexdocs.pm/open_rtb_ecto](https://hexdocs.pm/open_rtb_ecto).

### OpenRTB Example Payloads
https://wiki.smaato.com/pages/viewpage.action?pageId=1770079


### Details
1. We do NOT attempt to validate ISO-4217 currency codes in `cur` fields
