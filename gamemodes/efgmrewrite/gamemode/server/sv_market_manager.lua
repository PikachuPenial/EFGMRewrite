util.AddNetworkString("PlayerMarketPurchaseItem")

net.Receive("PlayerMarketPurchaseItem", function(len, ply)

    local item = net.ReadString()
    local count = net.ReadUInt(8)

    local def = EFGMITEMS[item]

    local plyMoney = ply:GetNWInt("Money", 0)
    local cost = def.value * count

    if plyMoney < cost then return false end

    local data = {}
    data.count = count

    if def.equipType == EQUIPTYPE.Weapon and def.defAtts then

        data.att = def.defAtts

    end

    FlowItemToStash(ply, item, def.equipType, data)
    UpdateStashString(ply)

    ply:SetNWInt("Money", plyMoney - cost)

end)

concommand.Add("efgm_debug_setmoney", function(ply, cmd, args) ply:SetNWInt("Money", tonumber(args[1]) or 0) end)