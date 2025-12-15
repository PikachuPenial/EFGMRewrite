local chunkedMarket = {}

hook.Add("OnMarketChunked", "NetworkMarket", function(str, uID)

    local marketStr = str
    marketStr = util.Base64Decode(marketStr)
    marketStr = util.Decompress(marketStr)

    if !marketStr then return end

    local marketTbl = util.JSONToTable(marketStr)

    marketLimits = marketTbl

end)

net.Receive("PlayerNetworkMarket", function(len, ply)

    local uID = net.ReadFloat()
    local index = net.ReadUInt(16)
    local chunkCount = net.ReadUInt(16)
    local chunk = net.ReadString()

    if !chunkedMarket[uID] then

        chunkedMarket[uID] = {

            Chunks = {},
            ReceivedCount = 0,
            TotalCount = chunkCount

        }

    end

    chunkedMarket[uID].Chunks[index] = chunk
    chunkedMarket[uID].ReceivedCount = chunkedMarket[uID].ReceivedCount + 1

    if chunkedMarket[uID].ReceivedCount == chunkedMarket[uID].TotalCount then

        local str = ""

        for i = 1, chunkCount do

            str = str .. chunkedMarket[uID].Chunks[i]

        end

        hook.Run("OnMarketChunked", str, uID)
        chunkedMarket[uID] = nil

    end

end )