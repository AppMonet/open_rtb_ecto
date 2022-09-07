alias OpenRtbEcto.V2.{BidRequest, BidResponse}

alias OpenRtbEcto.V2.BidRequest.{
  App,
  Audio,
  Banner,
  Content,
  Data,
  Deal,
  Device,
  Format,
  Geo,
  Imp,
  Metric,
  Native,
  Pmp,
  Producer,
  Publisher,
  Regs,
  Segment,
  Site,
  Source,
  User,
  Video,
  BrandVersion,
  Channel,
  Network,
  SupplyChain,
  SupplyChainNode,
  Uid,
  Eids,
  UserAgent
}

alias OpenRtbEcto.V2.BidResponse.{Bid, SeatBid}

# TODO: programmatically find all modules rather than manually adding them here
defimpl Jason.Encoder,
  for: [
    BidRequest,
    BidResponse,
    App,
    Audio,
    Banner,
    Content,
    Data,
    Deal,
    Device,
    Format,
    Geo,
    Imp,
    Metric,
    Native,
    Pmp,
    Producer,
    Publisher,
    Regs,
    Segment,
    Site,
    Source,
    User,
    Video,
    Bid,
    SeatBid,
    BrandVersion,
    Channel,
    Network,
    SupplyChain,
    SupplyChainNode,
    Uid,
    Eids,
    UserAgent,
    OpenRtbEcto.V2.Native.Request,
    OpenRtbEcto.V2.Native.Request.Asset,
    OpenRtbEcto.V2.Native.Request.Data,
    OpenRtbEcto.V2.Native.Request.EventTracker,
    OpenRtbEcto.V2.Native.Request.Img,
    OpenRtbEcto.V2.Native.Request.Title,
    OpenRtbEcto.V2.Native.Request.Video,
    OpenRtbEcto.V2.Native.Response,
    OpenRtbEcto.V2.Native.Response.Asset,
    OpenRtbEcto.V2.Native.Response.Data,
    OpenRtbEcto.V2.Native.Response.EventTracker,
    OpenRtbEcto.V2.Native.Response.Img,
    OpenRtbEcto.V2.Native.Response.Title,
    OpenRtbEcto.V2.Native.Response.Video,
    OpenRtbEcto.V2.Native.Response.Link
  ] do
  def encode(struct, opts) do
    struct
    |> Map.from_struct()
    |> Enum.reduce(%{}, fn {k, v}, acc ->
      case v do
        nil -> acc
        [] -> acc
        %{} = map when map_size(map) == 0 -> acc
        _ -> Map.put(acc, k, v)
      end
    end)
    |> Jason.Encode.map(opts)
  end
end
