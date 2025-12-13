
util.AddNetworkString("PlayerStashReload")
util.AddNetworkString("PlayerStashAddItem")
util.AddNetworkString("PlayerStashUpdateItem")
util.AddNetworkString("PlayerStashDeleteItem")
util.AddNetworkString("PlayerStashAddItemFromInventory")
util.AddNetworkString("PlayerStashAddItemFromEquipped")
util.AddNetworkString("PlayerStashAddAllFromInventory")
util.AddNetworkString("PlayerStashTakeItemToInventory")
util.AddNetworkString("PlayerStashEquipItem")
util.AddNetworkString("PlayerStashConsumeItem")
util.AddNetworkString("PlayerStashPinItem")

function ReloadStash(ply)

    net.Start("PlayerStashReload", false)
    net.Send(ply)

end

function AddItemToStash(ply, name, type, data)

    local def = EFGMITEMS[name]

    data.count = math.Clamp(tonumber(data.count) or 1, 1, def.stackSize)

    if def.equipType == EQUIPTYPE.Weapon and (!data.owner or !data.timestamp) then

        data.owner = ply:SteamID64()
        data.timestamp = os.time()

    end

    local item = ITEM.Instantiate(name, type, data)
    local index = table.insert(ply.stash, item)

    net.Start("PlayerStashAddItem", false)
    net.WriteString(name)
    net.WriteUInt(type, 4)
    net.WriteTable(data) -- writing a table isn't great but we ball for now
    net.WriteUInt(index, 16)
    net.Send(ply)

    ply:SetNWInt("StashCount", #ply.stash)

end

function UpdateItemFromStash(ply, index, data)

    local item = ply.stash[index]

    ply.stash[index].data = data

    net.Start("PlayerStashUpdateItem", false)
    net.WriteTable(ply.stash[index].data)
    net.WriteUInt(index, 16)
    net.Send(ply)

    ply:SetNWInt("StashCount", #ply.stash)

    return item

end

function DeleteItemFromStash(ply, index)

    local item = ply.stash[index]

    table.remove(ply.stash, index)

    net.Start("PlayerStashDeleteItem", false)
    net.WriteUInt(index, 16)
    net.Send(ply)

    ply:SetNWInt("StashCount", #ply.stash)

    return item

end

function FlowItemToStash(ply, name, type, data)

    local def = EFGMITEMS[name]
    local stackSize = def.stackSize

    if stackSize == 1 then -- items that can't stack do not need to flow

        for i = 1, data.count do

            AddItemToStash(ply, name, type, data)

        end

        return

    end

    local amount = tonumber(data.count)
    local inv = {}

    for k, v in ipairs(ply.stash) do

        inv[k] = {}
        inv[k].name = v.name
        inv[k].data = v.data
        inv[k].id = k

    end

    table.sort(inv, function(a, b) return a.data.count > b.data.count end)

    for k, v in ipairs(inv) do

        if v.name == name and v.data.count != def.stackSize and amount > 0 then

            local countToMax = stackSize - v.data.count

            if amount >= countToMax then

                local newData = {}
                newData.count = stackSize
                UpdateItemFromStash(ply, v.id, newData)
                amount = amount - countToMax

            elseif amount < countToMax then

                local newData = {}
                newData.count = ply.stash[v.id].data.count + amount
                UpdateItemFromStash(ply, v.id, newData)
                amount = 0
                break

            end

        end

    end

    -- if leftover after checking every similar item type
    while amount > 0 do

        if amount >= stackSize then

            local newData = {}
            newData.count = stackSize
            AddItemToStash(ply, name, type, newData)
            amount = amount - stackSize

        else

            local newData = {}
            newData.count = amount
            AddItemToStash(ply, name, type, newData)
            break

        end

    end

end

function DeflowItemsFromStash(ply, name, count)

    local amount = count
    local inv = {}

    for k, v in ipairs(ply.stash) do

        inv[k] = {}
        inv[k].name = v.name
        inv[k].data = v.data
        inv[k].id = k

    end

    table.sort(inv, function(a, b) return a.data.count < b.data.count end)

    for k, v in ipairs(inv) do

        if v.name == name and v.data.count > 0 and amount > 0 then

            if amount >= v.data.count then

                amount = amount - v.data.count
                DeleteItemFromStash(ply, v.id)
                DeflowItemsFromStash(ply, name, amount)
                return

            else

                local newData = {}
                newData.count = ply.stash[v.id].data.count - amount
                UpdateItemFromStash(ply, v.id, newData)
                break

            end

        end

    end

    return amount

end

net.Receive("PlayerStashAddItemFromInventory", function(len, ply)

    if !ply:CompareStatus(0) then return end
    if ply:GetNWInt("StashCount", 0) >= ply:GetNWInt("StashMax", 150) then return end

    local itemIndex = net.ReadUInt(16)
    local item = DeleteItemFromInventory(ply, itemIndex, false)

    if item == nil then return end

    FlowItemToStash(ply, item.name, item.type, item.data)

    ReloadInventory(ply)
    ReloadStash(ply)

    ply:SetNWInt("StashCount", #ply.stash)

end)

net.Receive("PlayerStashAddItemFromEquipped", function(len, ply)

    if !ply:CompareStatus(0) then return end
    if ply:GetNWInt("StashCount", 0) >= ply:GetNWInt("StashMax", 150) then return end

    local equipID = net.ReadUInt(4)
    local equipSlot = net.ReadUInt(4)

    local item = table.Copy(ply.weaponSlots[equipID][equipSlot])

    if table.IsEmpty(item) then return end

    table.Empty(ply.weaponSlots[equipID][equipSlot])

    local wep = ply:GetWeapon(item.name)

    if wep != NULL and item.data.att then

        local atts = table.Copy(wep.Attachments)
        local str = GenerateAttachString(atts)
        item.data.att = str

    end

    local def = EFGMITEMS[item.name]
    if wep != NULL and def.displayType != "Grenade" then

        local clip1 = wep:Clip1()
        local ammoDef = EFGMITEMS[wep.Ammo]
        if clip1 > 0 and ply:GetNWBool("InRange", false) == false and ammoDef then

            local data = {}
            data.count = math.Clamp(wep:Clip1(), 1, ammoDef.stackSize)
            FlowItemToInventory(ply, wep.Ammo, EQUIPTYPE.Ammunition, data)

        end

        local clip2 = wep:Clip2()
        local ammoDef2 = EFGMITEMS[wep.UBGLAmmo]
        if clip2 > 0 and ply:GetNWBool("InRange", false) == false and ammoDef2 then

            local data = {}
            data.count = math.Clamp(wep:Clip2(), 1, ammoDef2.stackSize)
            FlowItemToInventory(ply, wep.UBGLAmmo, EQUIPTYPE.Ammunition, data)

        end

        ReloadInventory(ply)

    end

    ReloadSlots(ply)

    ply:StripWeapon(item.name)

    RemoveWeightFromPlayer(ply, item.name, item.data.count)

    if item.data.att then

        local atts = GetPrefixedAttachmentListFromCode(item.data.att)
        if !atts then return end

        for _, a in ipairs(atts) do

            local att = EFGMITEMS[a]
            if att == nil then continue end

            RemoveWeightFromPlayer(ply, a, 1)

        end

    end

    AddItemToStash(ply, item.name, item.type, item.data)

    ReloadStash(ply)

end)

net.Receive("PlayerStashAddAllFromInventory", function(len, ply)

    if !ply:CompareStatus(0) then return end

    local indexes = #ply.inventory
    local indexesNuked = 0

    for i = 1, indexes do

        if ply:GetNWInt("StashCount", 0) >= ply:GetNWInt("StashMax", 150) then return end

        local itemIndex = i - indexesNuked
        local item = DeleteItemFromInventory(ply, itemIndex, false)
        indexesNuked = indexesNuked + 1

        if item == nil then return end

        FlowItemToStash(ply, item.name, item.type, item.data)

        ply:SetNWInt("StashCount", #ply.stash)

    end

    ReloadInventory(ply)
    ReloadStash(ply)

end)

net.Receive("PlayerStashTakeItemToInventory", function(len, ply)

    if !ply:CompareStatus(0) then return end

    local itemIndex = net.ReadUInt(16)
    local item = DeleteItemFromStash(ply, itemIndex)

    if item == nil then return end
    item.data.pin = nil

    FlowItemToInventory(ply, item.name, item.type, item.data)

    ReloadStash(ply)
    ReloadInventory(ply)

    ply:SetNWInt("StashCount", #ply.stash)

end)

net.Receive("PlayerStashEquipItem", function(len, ply)

    if !ply:CompareStatus(0) then return end

    local itemIndex, equipSlot, equipSubSlot

    itemIndex = net.ReadUInt(16)
    equipSlot = net.ReadUInt(4)
    equipSubSlot = net.ReadUInt(16)

    local item = ply.stash[itemIndex]
    if item == nil then return end

    item.data.pin = nil

    if AmountInInventory(ply.weaponSlots[equipSlot], item.name) > 0 then return end

    if table.IsEmpty(ply.weaponSlots[equipSlot][equipSubSlot]) then

        DeleteItemFromStash(ply, itemIndex)
        ply.weaponSlots[equipSlot][equipSubSlot] = item
        AddWeightToPlayer(ply, item.name, item.data.count)

        if item.data.att then

            local atts = GetPrefixedAttachmentListFromCode(item.data.att)
            if !atts then return end

            for _, a in ipairs(atts) do

                local att = EFGMITEMS[a]
                if att == nil then continue end

                AddWeightToPlayer(ply, a, 1)

            end

        end

        equipWeaponName = item.name
        GiveWepWithPresetFromCode(ply, item.name, item.data.att)

        ReloadStash(ply)
        ReloadSlots(ply)

    end

end)

net.Receive("PlayerStashConsumeItem", function(len, ply)

    if !ply:CompareStatus(0) then return end

    local itemIndex = net.ReadUInt(16)
    local item = ply.stash[itemIndex]
    local durability = item.data.durability

    local i = EFGMITEMS[item.name]

    -- heal
    if i.consumableType == "heal" then

        local healAmount = ply:GetMaxHealth() - ply:Health()

        if durability < healAmount then healAmount = durability end

        ply:SetHealth(math.min(ply:Health() + healAmount, 100))
        ply.stash[itemIndex].data.durability = durability - healAmount

        if ply.stash[itemIndex].data.durability > 0 then

            net.Start("PlayerStashUpdateItem", false)
            net.WriteTable(item.data)
            net.WriteUInt(itemIndex, 16)
            net.Send(ply)

        else

            net.Start("PlayerStashDeleteItem", false)
            net.WriteUInt(itemIndex, 16)
            net.Send(ply)

            table.remove(ply.stash, itemIndex)

            RemoveWeightFromPlayer(ply, item.name, item.data.count)

        end

    end

    ReloadStash(ply)
    ply:SetNWInt("StashCount", #ply.stash)

end)

net.Receive("PlayerStashPinItem", function(len, ply)

    if !ply:CompareStatus(0) then return end

    local itemIndex = net.ReadUInt(16)

    if ply.stash[itemIndex].data.pin != 1 then

        ply.stash[itemIndex].data.pin = 1

    else

        ply.stash[itemIndex].data.pin = nil

    end

    net.Start("PlayerStashUpdateItem", false)
    net.WriteTable(ply.stash[itemIndex].data)
    net.WriteUInt(itemIndex, 16)
    net.Send(ply)

    ReloadStash(ply)

end)

function CalculateStashValue(ply)

    local value = 0

    for k, v in ipairs(ply.stash) do

        local def = EFGMITEMS[v.name]
        local count = math.Clamp(v.data.count, 1, def.stackSize) or 1

        if def.consumableType != "heal" and def.consumableType != "key" then

            value = value + (def.value * count)

        else

            value = value + math.floor(def.value * (v.data.durability / def.consumableValue))

        end

        if def.equipType == EQUIPTYPE.Weapon and v.data.att then

            local atts = GetPrefixedAttachmentListFromCode(v.data.att)
            if !atts then return end

            for _, a in ipairs(atts) do

                local att = EFGMITEMS[a]
                if att == nil then continue end

                value = value + att.value

            end

        end

    end

    ply:SetNWInt("StashValue", value)
    return value

end

function UpdateStashString(ply)

    local stashStr = util.TableToJSON(ply.stash)
    stashStr = util.Compress(stashStr)
    stashStr = util.Base64Encode(stashStr, true)
    ply.stashStr = stashStr

end

function DecodeStash(ply, str)

    if !str then return end
    str = util.Base64Decode(str)
    str = util.Decompress(str)
    if !str then return end

    local tbl = util.JSONToTable(str)

    return tbl

end

function WipeStash(ply)

    ply.stashStr = ""
	ply.stash = {}

    SendChunkedNet(ply, ply.stashStr, "PlayerNetworkStash")

end

if GetConVar("efgm_derivesbox"):GetInt() == 1 then

    concommand.Add("efgm_debug_wipestash", function(ply, cmd, args) WipeStash(ply) end)

    function PrintStashString(ply)

        UpdateStashString(ply)
        print(ply.stashStr)

    end
    concommand.Add("efgm_debug_printstashstring", function(ply, cmd, args) PrintStashString(ply) end)

end