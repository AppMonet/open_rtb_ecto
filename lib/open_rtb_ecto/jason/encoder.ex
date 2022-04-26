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
    UserAgent
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
