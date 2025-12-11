util.AddNetworkString("PlayerMarketPurchaseItem")
util.AddNetworkString("PlayerMarketPurchaseItemToInventory")
util.AddNetworkString("PlayerMarketPurchasePresetToInventory")
util.AddNetworkString("PlayerMarketSellItem")
util.AddNetworkString("PlayerMarketSellBulk")

net.Receive("PlayerMarketPurchaseItem", function(len, ply)

    if !ply:CompareStatus(0) then return false end

    local item = net.ReadString()
    local count = net.ReadUInt(16)

    local def = EFGMITEMS[item]

    if def.canPurchase == false then return end
    if ply:GetNWInt("StashCount", 0) + math.floor(count / def.stackSize) >= ply:GetNWInt("StashMax", 150) then return false end

    local plyMoney = ply:GetNWInt("Money", 0)
    local plyLevel = ply:GetNWInt("Level", 1)
    local cost = def.value * count
    local lvl = (def.levelReq or 1)

    if def.equipType == EQUIPTYPE.Weapon and def.defAtts then

        local atts = GetPrefixedAttachmentListFromCode(def.defAtts)
        if !atts then return end

        for _, a in ipairs(atts) do

            local att = EFGMITEMS[a]
            if att == nil then continue end

            cost = cost + att.value

        end

    end

    if plyMoney < cost then return false end
    if plyLevel < lvl then return false end

    local data = {}
    data.count = count

    if def.equipType == EQUIPTYPE.Weapon and def.defAtts then

        data.att = def.defAtts

    end

    if (def.consumableType == "heal" or def.consumableType == "key") and def.consumableValue then

        data.durability = def.consumableValue

    end

    if def.equipType == EQUIPTYPE.Weapon then

        data.owner = ply:SteamID64()
        data.timestamp = os.time()

    end

    FlowItemToStash(ply, item, def.equipType, data)
    ReloadStash(ply)

    ply:SetNWInt("Money", plyMoney - cost)
    ply:SetNWInt("MoneySpent", ply:GetNWInt("MoneySpent") + cost)

    return true

end)

net.Receive("PlayerMarketPurchaseItemToInventory", function(len, ply)

    if !ply:CompareStatus(0) then return false end

    local item = net.ReadString()
    local count = net.ReadUInt(16)

    local def = EFGMITEMS[item]

    if def.canPurchase == false then return end

    local plyMoney = ply:GetNWInt("Money", 0)
    local plyLevel = ply:GetNWInt("Level", 1)
    local cost = def.value * count
    local lvl = (def.levelReq or 1)

    if def.equipType == EQUIPTYPE.Weapon and def.defAtts then

        local atts = GetPrefixedAttachmentListFromCode(def.defAtts)
        if !atts then return end

        for _, a in ipairs(atts) do

            local att = EFGMITEMS[a]
            if att == nil then continue end

            cost = cost + att.value

        end

    end

    if plyMoney < cost then return false end
    if plyLevel < lvl then return false end

    local data = {}
    data.count = count

    if def.equipType == EQUIPTYPE.Weapon and def.defAtts then

        data.att = def.defAtts

    end

    if (def.consumableType == "heal" or def.consumableType == "key") and def.consumableValue then

        data.durability = def.consumableValue

    end

    if def.equipType == EQUIPTYPE.Weapon then

        data.owner = ply:SteamID64()
        data.timestamp = os.time()

    end

    FlowItemToInventory(ply, item, def.equipType, data)
    ReloadInventory(ply)

    ply:SetNWInt("Money", plyMoney - cost)
    ply:SetNWInt("MoneySpent", ply:GetNWInt("MoneySpent") + cost)

    return true

end)

net.Receive("PlayerMarketPurchasePresetToInventory", function(len, ply)

    if !ply:CompareStatus(0) then return false end

    local presetAtts = net.ReadTable()

    local plyMoney = ply:GetNWInt("Money", 0)
    local plyLevel = ply:GetNWInt("Level", 1)

    local cost = 0
    local highestLvl = 0

    for att, attcount in pairs(presetAtts) do

        local i = EFGMITEMS[att]
        if i == nil then return false end

        cost = cost + (i.value * attcount)
        if (i.levelReq or 1) > highestLvl then highestLvl = (i.levelReq or 1) end
        if !i.canPurchase then return false end

    end

    if plyMoney < cost then return false end
    if plyLevel < highestLvl then return false end

    for att, attcount in pairs(presetAtts) do

        local data = {}
        data.count = attcount
        FlowItemToInventory(ply, att, EQUIPTYPE.Attachment, data)

    end

    ReloadInventory(ply)

    ply:SetNWInt("Money", plyMoney - cost)
    ply:SetNWInt("MoneySpent", ply:GetNWInt("MoneySpent") + cost)

    return true

end)

net.Receive("PlayerMarketSellItem", function(len, ply)

    if !ply:CompareStatus(0) then return false end

    local item = net.ReadString()
    local count = net.ReadUInt(8)
    local key = net.ReadUInt(16)

    if AmountInInventory(ply.stash, item) < count then return false end

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
                if att == nil then continue end

                cost = cost + math.floor(att.value * sellMultiplier)

            end

        end

        DeleteItemFromStash(ply, key)
        ReloadStash(ply)

        ply:SetNWInt("Money", plyMoney + cost)
        ply:SetNWInt("MoneyEarned", ply:GetNWInt("MoneyEarned") + cost)
        return true

    elseif def.consumableType == "heal" or def.consumableType == "key" then

        local data = ply.stash[key].data
        local cost = math.floor((def.value * sellMultiplier) * (data.durability / def.consumableValue))

        DeleteItemFromStash(ply, key)
        ReloadStash(ply)

        ply:SetNWInt("Money", plyMoney + cost)
        return true

    else

        local data = ply.stash[key].data
        local cost = math.floor(def.value * sellMultiplier) * count

        if count == math.max(data.count, 1) then

            DeleteItemFromStash(ply, key)

        else

            local newData = table.Copy(data)
            newData.count = math.max(data.count, 1) - count
            UpdateItemFromStash(ply, key, newData)

        end

        ReloadStash(ply)

        ply:SetNWInt("Money", plyMoney + cost)
        ply:SetNWInt("MoneyEarned", ply:GetNWInt("MoneyEarned") + cost)
        return true

    end

end)

if GetConVar("efgm_derivesbox"):GetInt() == 1 then

    concommand.Add("efgm_debug_setmoney", function(ply, cmd, args) ply:SetNWInt("Money", tonumber(args[1]) or 0) end)

end