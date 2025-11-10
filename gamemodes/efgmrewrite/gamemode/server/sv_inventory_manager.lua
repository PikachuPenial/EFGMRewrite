
util.AddNetworkString("PlayerReinstantiateInventory")
util.AddNetworkString("PlayerInventoryAddItem")
util.AddNetworkString("PlayerInventoryUpdateItem")
util.AddNetworkString("PlayerInventoryDeleteItem")
util.AddNetworkString("PlayerInventoryDropItem")
util.AddNetworkString("PlayerInventoryEquipItem")
util.AddNetworkString("PlayerInventoryUnEquipItem")
util.AddNetworkString("PlayerInventoryUnEquipAll")
util.AddNetworkString("PlayerInventoryDropEquippedItem")
util.AddNetworkString("PlayerInventoryConsumeItem")
util.AddNetworkString("PlayerInventoryLootItemFromContainer")

hook.Add("PlayerSpawn", "InventorySetup", function(ply)

	ply.inventory = {}

    ply.weaponSlots = {}
    for k, v in pairs(WEAPONSLOTS) do

        ply.weaponSlots[v.ID] = {}
        for i = 1, v.COUNT, 1 do ply.weaponSlots[v.ID][i] = {} end

    end

    ply:SetNWFloat("InventoryWeight", 0.00)

end)

function ReinstantiateInventory(ply)

    ply.inventory = {}

    ply.weaponSlots = {}
    for k, v in pairs(WEAPONSLOTS) do

        ply.weaponSlots[v.ID] = {}
        for i = 1, v.COUNT, 1 do ply.weaponSlots[v.ID][i] = {} end

    end

    ply:SetNWFloat("InventoryWeight", 0.00)

end
concommand.Add("efgm_flush_inventory", function(ply, cmd, args) ReinstantiateInventory(ply) net.Start("PlayerReinstantiateInventory", false) net.Send(ply) end)

hook.Add("OnReloaded", "InventoryReload", function()

    for k, ply in pairs(player.GetAll()) do

        ReinstantiateInventory(ply)

    end

    net.Start("PlayerReinstantiateInventory", false)
    net.Broadcast()

end)

function AddItemToInventory(ply, name, type, data)

    print("I DO NOT UNDERSTAND")

    local def = EFGMITEMS[name]

    if data.count == 0 then return end -- dont add an item that doesnt exist lol!
    data.count = math.Clamp(tonumber(data.count) or 1, 1, def.stackSize)

    local item = ITEM.Instantiate(name, type, data)
    local index = table.insert(ply.inventory, item)

    net.Start("PlayerInventoryAddItem", false)
    net.WriteString(name)
    net.WriteUInt(type, 4)
    net.WriteTable(data) -- writing a table isn't great but we ball for now
    net.WriteUInt(index, 16)
    net.Send(ply)

    AddWeightToPlayer(ply, name, data.count)

end

function UpdateItemFromInventory(ply, index, data)

    local item = ply.inventory[index]
    local oldData = ply.inventory[index].data

    if oldData.count < data.count then

        AddWeightToPlayer(ply, item.name, data.count - oldData.count)

    elseif oldData.count > data.count then

        RemoveWeightFromPlayer(ply, item.name, oldData.count - data.count)

    end

    ply.inventory[index].data = data

    net.Start("PlayerInventoryUpdateItem", false)
    net.WriteTable(ply.inventory[index].data)
    net.WriteUInt(index, 16)
    net.Send(ply)

    return item

end

function DeleteItemFromInventory(ply, index, isEquipped)

    local item = ply.inventory[index]

    if !isEquipped then RemoveWeightFromPlayer(ply, item.name, item.data.count) end

    table.remove(ply.inventory, index)

    net.Start("PlayerInventoryDeleteItem", false)
    net.WriteUInt(index, 16)
    net.Send(ply)

    return item

end

function FlowItemToInventory(ply, name, type, data)

    local def = EFGMITEMS[name]
    local stackSize = def.stackSize

    if data.count == 0 then return end -- dont add an item that doesnt exist lol!

    local amount = tonumber(data.count)

    for k, v in ipairs(ply.inventory) do

        if v.name == name and v.data.count != def.stackSize and amount > 0 then

            local countToMax = stackSize - v.data.count

            if amount >= countToMax then

                local newData = {}
                newData.count = stackSize
                UpdateItemFromInventory(ply, k, newData)
                amount = amount - countToMax

            elseif amount < countToMax then

                local newData = {}
                newData.count = ply.inventory[k].data.count + amount
                UpdateItemFromInventory(ply, k, newData)
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
            AddItemToInventory(ply, name, type, newData)
            amount = amount - stackSize

        else

            local newData = {}
            newData.count = amount
            AddItemToInventory(ply, name, type, newData)
            break

        end

    end

end

-- TODO!!! SORT BY ITEMS WITH THE LEAST AMOUNT IN THEIR DATA COUNT!!! itll be nicer to take from the lower stacks than to take 2 bullets from your perfect 60 stacks of ammo
-- for some reason this is also not working properly with stacks but i cant be bothered rn
function DeflowItemsFromInventory(ply, name, count)

    local amount = count

    for k, v in ipairs(ply.inventory) do

        if v.name == name and v.data.count > 0 and amount > 0 then

            if amount >= v.data.count then

                amount = amount - v.data.count
                DeleteItemFromInventory(ply, k, false)

            else

                local newData = {}
                newData.count = ply.inventory[k].data.count - amount
                UpdateItemFromInventory(ply, k, newData)
                break

            end

        end

    end

    return amount

end

net.Receive("PlayerInventoryDropItem", function(len, ply)

    local itemIndex = net.ReadUInt(16)
    local data = net.ReadTable()
    local item = ply.inventory[itemIndex]

    if table.IsEmpty(item) then return end

    local wep = ents.Create(item.name)

    if wep == NULL then table.remove(ply.inventory, itemIndex) RemoveWeightFromPlayer(ply, item.name, item.data.count) return end

    if data.att then

        LoadPresetFromCode(wep, data.att)

    end

    wep:SetPos(ply:GetShootPos() + ply:GetForward() * 128)
    wep:Spawn()
    wep:PhysWake()

    if type(wep.GetData) == "function" then wep:GetData(data) end

    table.remove(ply.inventory, itemIndex)
    RemoveWeightFromPlayer(ply, item.name, item.data.count)

end)

net.Receive("PlayerInventoryEquipItem", function(len, ply)

    local itemIndex, equipSlot, equipSubSlot

    itemIndex = net.ReadUInt(16)
    equipSlot = net.ReadUInt(4)
    equipSubSlot = net.ReadUInt(16)

    local item = ply.inventory[itemIndex]
    if item == nil then return end

    if AmountInInventory(ply.weaponSlots[equipSlot], item.name) > 0 then return end -- can't have multiple of the same item

    if table.IsEmpty(ply.weaponSlots[equipSlot][equipSubSlot]) then

        DeleteItemFromInventory(ply, itemIndex, true)
        ply.weaponSlots[equipSlot][equipSubSlot] = item

        equipWeaponName = item.name
        local wpn = ply:Give(item.name)
        LoadPresetFromCode(wpn, item.data.att)

    end

end)

net.Receive("PlayerInventoryUnEquipItem", function(len, ply)

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
        FlowItemToInventory(ply, wep.Ammo, EQUIPTYPE.Ammunition, data)

    end

    ply:StripWeapon(item.name)

    local newItem = ITEM.Instantiate(item.name, item.type, item.data)
    local index = table.insert(ply.inventory, newItem)

    net.Start("PlayerInventoryAddItem", false)
    net.WriteString(item.name)
    net.WriteUInt(item.type, 4)
    net.WriteTable(item.data)
    net.WriteUInt(index, 16)
    net.Send(ply)

end)

function UnequipAll(ply)

    for i = 1, 5 do

        for k, v in pairs(ply.weaponSlots[i]) do

            if !table.IsEmpty(v) then

                local item = table.Copy(v)

                if item == nil then return end

                table.Empty(ply.weaponSlots[i][k])

                local wep = ply:GetWeapon(item.name)

                if wep != NULL and item.data.att then

                    local atts = table.Copy(wep.Attachments)
                    local str = GenerateAttachString(atts)
                    item.data.att = str

                end

                local clip1 = wep:Clip1()
                if clip1 != -1 then

                    local data = {}
                    data.count = wep:Clip1()
                    FlowItemToInventory(ply, wep.Ammo, EQUIPTYPE.Ammunition, data)

                end

                local newItem = ITEM.Instantiate(item.name, item.type, item.data)
                local index = table.insert(ply.inventory, newItem)

                net.Start("PlayerInventoryAddItem", false)
                net.WriteString(item.name)
                net.WriteUInt(item.type, 4)
                net.WriteTable(item.data)
                net.WriteUInt(index, 16)
                net.Send(ply)

                net.Start("PlayerInventoryUnEquipAll")
                net.Send(ply)

            end

        end

    end

end

net.Receive("PlayerInventoryDropEquippedItem", function(len, ply)

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

    ply:StripWeapon(item.name)

    local newWep = ents.Create(item.name)

    if item.data.att then

        LoadPresetFromCode(newWep, item.data.att)

    end

    newWep:SetPos(ply:GetShootPos() + ply:GetForward() * 128)
    newWep:Spawn()
    newWep:PhysWake()

    if type(newWep.GetData) == "function" then newWep:GetData(item.data) end

    RemoveWeightFromPlayer(ply, item.name, item.data.count)

end)

net.Receive("PlayerInventoryConsumeItem", function(len, ply)

    local itemIndex = net.ReadUInt(16)
    local item = ply.inventory[itemIndex]
    local durability = item.data.durability

    local i = EFGMITEMS[item.name]

    -- heal
    if i.consumableType == "heal" then

        local healAmount = ply:GetMaxHealth() - ply:Health()

        if durability < healAmount then healAmount = durability end

        ply:SetHealth(math.min(ply:Health() + healAmount, 100))
        ply.inventory[itemIndex].data.durability = durability - healAmount

        if ply.inventory[itemIndex].data.durability > 0 then

            net.Start("PlayerInventoryUpdateItem", false)
            net.WriteTable(item.data)
            net.WriteUInt(itemIndex, 16)
            net.Send(ply)

        else

            net.Start("PlayerInventoryDeleteItem", false)
            net.WriteUInt(itemIndex, 16)
            net.Send(ply)

            table.remove(ply.inventory, itemIndex)

            RemoveWeightFromPlayer(ply, item.name, item.data.count)

        end

    end

end)

net.Receive("PlayerInventoryLootItemFromContainer", function(len, ply)

    local container = net.ReadEntity()
    local index = net.ReadUInt(16)

    local newItem = table.Copy(container.Inventory[index])
    local newIndex = table.insert(ply.inventory, newItem)

    net.Start("PlayerInventoryAddItem", false)
        net.WriteString(newItem.name)
        net.WriteUInt(newItem.type, 4)
        net.WriteTable(newItem.data)
        net.WriteUInt(newIndex, 16)
    net.Send(ply)

    AddWeightToPlayer(ply, newItem.name, newItem.data.count)

    table.remove(container.Inventory, index)

    if table.IsEmpty(container.Inventory) then container:Remove() end

end)

function AddWeightToPlayer(ply, item, count)

    local def = EFGMITEMS[item]

    if count == 0 then count = 1 end
    if def.weight == nil then return false end

    local curWeight = ply:GetNWFloat("InventoryWeight", 0.00)
    local newWeight = math.Round(curWeight + (def.weight * count), 2)

    ply:SetNWFloat("InventoryWeight", newWeight)
    return newWeight

end

function RemoveWeightFromPlayer(ply, item, count)

    local def = EFGMITEMS[item]

    if count == 0 then count = 1 end
    if def.weight == nil then return false end

    local curWeight = ply:GetNWFloat("InventoryWeight", 0.00)
    local newWeight = math.Round(curWeight - (def.weight * count), 2)

    ply:SetNWFloat("InventoryWeight", math.max(0.00, newWeight))
    return newWeight

end

function GiveAmmo(ply, count)

    local ammo = "efgm_ammo_556x45"
    local data = {}
    data.count = count

    FlowItemToInventory(ply, ammo, EQUIPTYPE.Ammunition, data)

end
concommand.Add("efgm_debug_giveammo", function(ply, cmd, args) GiveAmmo(ply, args[1]) end)

function GiveAttachment(ply)

    local attachment = "arc9_att_eft_optic_boss"
    local data = {}

    AddItemToInventory(ply, attachment, EQUIPTYPE.Attachment, data)

end
concommand.Add("efgm_debug_giveattachment", function(ply, cmd, args) GiveAttachment(ply) end)