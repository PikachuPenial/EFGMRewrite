util.AddNetworkString("PlayerMarketPurchaseItem")
util.AddNetworkString("PlayerMarketSellItem")

net.Receive("PlayerMarketPurchaseItem", function(len, ply)

    if !ply:CompareStatus(0) then return end

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

    if def.equipType == EQUIPTYPE.Consumable and def.consumableValue then

        data.durability = def.consumableValue

    end

    FlowItemToStash(ply, item, def.equipType, data)
    UpdateStashString(ply)

    ply:SetNWInt("Money", plyMoney - cost)

end)

net.Receive("PlayerMarketSellItem", function(len, ply)

    if !ply:CompareStatus(0) then return end

    local item = net.ReadString()
    local count = net.ReadUInt(8)
    local key = net.ReadUInt(16)

    if AmountInInventory(ply.stash, item) < count then return end

    local def = EFGMITEMS[item]

    local plyMoney = ply:GetNWInt("Money", 0)

    if def.equipType == EQUIPTYPE.Weapon then

        local data = ply.stash[key].data
        local cost = math.floor(def.value * sellMultiplier)

        if data.att then

            local atts = GetPrefixedAttachmentListFromCode(data.att)
            if !atts then return end

            for _, a in ipairs(atts) do

                local att = EFGMITEMS[a]
                if att == nil then return end

                cost = cost + math.floor(att.value * sellMultiplier)

            end

        end

        DeleteItemFromStash(ply, key)
        UpdateStashString(ply)

        ply:SetNWInt("Money", plyMoney + cost)

    elseif def.equipType == EQUIPTYPE.Consumable then

        local data = ply.stash[key].data
        local cost = math.floor((def.value * sellMultiplier) * (data.durability / def.consumableValue))

        DeleteItemFromStash(ply, key)
        UpdateStashString(ply)

        ply:SetNWInt("Money", plyMoney + cost)

    else

        local cost = math.floor(def.value * sellMultiplier) * count

        DeflowItemsFromStash(ply, item, count)
        UpdateStashString(ply)

        ply:SetNWInt("Money", plyMoney + cost)

    end

end)

concommand.Add("efgm_debug_setmoney", function(ply, cmd, args) ply:SetNWInt("Money", tonumber(args[1]) or 0) end)