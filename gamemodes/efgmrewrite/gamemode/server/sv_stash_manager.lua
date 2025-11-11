
util.AddNetworkString("PlayerStashAddItem")
util.AddNetworkString("PlayerStashUpdateItem")
util.AddNetworkString("PlayerStashDeleteItem")
util.AddNetworkString("PlayerStashAddItemFromInventory")
util.AddNetworkString("PlayerStashAddItemFromEquipped")
util.AddNetworkString("PlayerStashConsumeItem")
util.AddNetworkString("PlayerInventoryDeleteItem")

function AddItemToStash(ply, name, type, data)

    local def = EFGMITEMS[name]

    if data.count == 0 then return end -- dont add an item that doesnt exist lol!
    data.count = math.Clamp(tonumber(data.count) or 1, 1, def.stackSize)

    local item = ITEM.Instantiate(name, type, data)
    local index = table.insert(ply.stash, item)

    net.Start("PlayerStashAddItem", false)
    net.WriteString(name)
    net.WriteUInt(type, 4)
    net.WriteTable(data) -- writing a table isn't great but we ball for now
    net.WriteUInt(index, 16)
    net.Send(ply)

    UpdateStashString(ply)

end

function UpdateItemFromStash(ply, index, data)

    local item = ply.stash[index]

    ply.stash[index].data = data

    net.Start("PlayerStashUpdateItem", false)
    net.WriteTable(ply.stash[index].data)
    net.WriteUInt(index, 16)
    net.Send(ply)

    UpdateStashString(ply)

    return item

end

function DeleteItemFromStash(ply, index)

    local item = ply.stash[index]

    table.remove(ply.stash, index)

    net.Start("PlayerStashDeleteItem", false)
    net.WriteUInt(index, 16)
    net.Send(ply)

    UpdateStashString(ply)

    return item

end

function FlowItemToStash(ply, name, type, data)

    local def = EFGMITEMS[name]
    local stackSize = def.stackSize

    if data.count == 0 then return end -- dont add an item that doesnt exist lol!

    local amount = tonumber(data.count)

    for k, v in ipairs(ply.stash) do

        if v.name == name and v.data.count != def.stackSize and amount > 0 then

            local countToMax = stackSize - v.data.count

            if amount >= countToMax then

                local newData = {}
                newData.count = stackSize
                UpdateItemFromStash(ply, k, newData)
                amount = amount - countToMax

            elseif amount < countToMax then

                local newData = {}
                newData.count = ply.stash[k].data.count + amount
                UpdateItemFromStash(ply, k, newData)
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

    for k, v in ipairs(ply.stash) do

        if v.name == name and v.data.count > 0 and amount > 0 then

            if amount >= v.data.count then

                amount = amount - v.data.count
                DeleteItemFromStash(ply, k)

            else

                local newData = {}
                newData.count = ply.stash[k].data.count - amount
                UpdateItemFromStash(ply, k, newData)
                break

            end

        end

    end

    return amount

end

net.Receive("PlayerStashAddItemFromInventory", function(len, ply)

    if !ply:CompareStatus(0) then return end

    local itemIndex = net.ReadUInt(16)
    local item = DeleteItemFromInventory(ply, itemIndex, false)

    if item == nil then return end

    FlowItemToStash(ply, item.name, item.type, item.data)

    UpdateStashString(ply)

end)

net.Receive("PlayerStashAddItemFromEquipped", function(len, ply)

    if !ply:CompareStatus(0) then return end

    equipID = net.ReadUInt(4)
    equipSlot = net.ReadUInt(4)

    local item = table.Copy(ply.weaponSlots[equipID][equipSlot])

    if table.IsEmpty(item) then return end

    table.Empty(ply.weaponSlots[equipID][equipSlot])

    local wep = ply:GetWeapon(item.name)

    if wep != NULL and item.data.att then

        local atts = table.Copy(wep.Attachments)
        local str = GenerateAttachString(atts)
        item.data.att = str

    end

    local clip1 = wep:Clip1()
    if clip1 != -1 and clip1 != 0 then

        local data = {}
        data.count = wep:Clip1()
        FlowItemToStash(ply, wep.Ammo, EQUIPTYPE.Ammunition, data)

    end

    ply:StripWeapon(item.name)

    AddItemToStash(ply, item.name, item.type, item.data)

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

    UpdateStashString(ply)

end)

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

    net.Start("PlayerNetworkStash", false)
    net.WriteString("")
    net.Send(ply)

end
concommand.Add("efgm_debug_wipestash", function(ply, cmd, args) WipeStash(ply) end)