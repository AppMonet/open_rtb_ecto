alias OpenRtbEcto.V2.{BidRequest, BidResponse, Native}

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
    Native.Request,
    Native.Request.Asset,
    Native.Request.Data,
    Native.Request.EventTracker,
    Native.Request.Img,
    Native.Request.Title,
    Native.Request.Video,
    Native.Response,
    Native.Response.Asset,
    Native.Response.Data,
    Native.Response.EventTracker,
    Native.Response.Img,
    Native.Response.Title,
    Native.Response.Video,
    Native.Response.Link
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
