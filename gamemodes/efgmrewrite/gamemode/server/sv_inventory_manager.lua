
util.AddNetworkString("PlayerReinstantiateInventory")
util.AddNetworkString("PlayerInventoryAddItem")
util.AddNetworkString("PlayerInventoryUpdateItem")
util.AddNetworkString("PlayerInventoryDeleteItem")
util.AddNetworkString("PlayerInventoryDropItem")
util.AddNetworkString("PlayerInventoryEquipItem")
util.AddNetworkString("PlayerInventoryUnEquipItem")
util.AddNetworkString("PlayerInventoryUnEquipAll")
util.AddNetworkString("PlayerInventoryUpdateEquipped")
util.AddNetworkString("PlayerInventoryDropEquippedItem")
util.AddNetworkString("PlayerInventoryDeleteEquippedItem")
util.AddNetworkString("PlayerInventoryConsumeItem")
util.AddNetworkString("PlayerInventoryLootItemFromContainer")
util.AddNetworkString("PlayerInventorySplit")
util.AddNetworkString("PlayerInventoryDelete")
util.AddNetworkString("PlayerInventoryTag")
util.AddNetworkString("PlayerInventoryConsumeGrenade")
util.AddNetworkString("efgm_sendpreset")

function ReinstantiateInventory(ply)

    ply.inventory = {}
    ply.invStr = ""

    local equMelee = table.Copy(ply.weaponSlots[WEAPONSLOTS.MELEE.ID])

    ply.weaponSlots = {}
    ply.equStr = ""
    for k, v in pairs(WEAPONSLOTS) do

        ply.weaponSlots[v.ID] = {}
        for i = 1, v.COUNT, 1 do ply.weaponSlots[v.ID][i] = {} end

    end

    if equMelee != nil then ply.weaponSlots[WEAPONSLOTS.MELEE.ID] = equMelee end

    CalculateInventoryWeight(ply)

end

function AddItemToInventory(ply, name, type, data)

    local def = EFGMITEMS[name]

    if data.count == 0 then return end -- dont add an item that doesnt exist lol!
    data.count = math.Clamp(tonumber(data.count) or 1, 1, def.stackSize)

    if def.equipType == EQUIPTYPE.Weapon then

        data.owner = ply:GetName()

    end

    local item = ITEM.Instantiate(name, type, data)
    local index = table.insert(ply.inventory, item)

    net.Start("PlayerInventoryAddItem", false)
    net.WriteString(name)
    net.WriteUInt(type, 4)
    net.WriteTable(data) -- writing a table isn't great but we ball for now
    net.WriteUInt(index, 16)
    net.Send(ply)

    AddWeightToPlayer(ply, name, data.count)
    UpdateInventoryString(ply)

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

    UpdateInventoryString(ply)

    return item

end

function DeleteItemFromInventory(ply, index, isEquipped)

    local item = ply.inventory[index]

    if !isEquipped then RemoveWeightFromPlayer(ply, item.name, item.data.count) end

    table.remove(ply.inventory, index)

    net.Start("PlayerInventoryDeleteItem", false)
    net.WriteUInt(index, 16)
    net.Send(ply)

    UpdateInventoryString(ply)

    return item

end

function FlowItemToInventory(ply, name, type, data)

    local def = EFGMITEMS[name]
    local stackSize = def.stackSize

    if data.count == 0 then return end -- dont add an item that doesnt exist lol!

    if stackSize == 1 then -- items that can't stack do not need to flow

        AddItemToInventory(ply, name, type, data)
        return

    end

    local amount = tonumber(data.count)
    local inv = table.Copy(ply.inventory)

    for k, v in ipairs(inv) do inv[k].id = k end

    table.sort(inv, function(a, b) return a.data.count > b.data.count end)

    for k, v in ipairs(inv) do

        if v.name == name and v.data.count != def.stackSize and amount > 0 then

            local countToMax = stackSize - v.data.count

            if amount >= countToMax then

                local newData = {}
                newData.count = stackSize
                UpdateItemFromInventory(ply, v.id, newData)
                amount = amount - countToMax

            elseif amount < countToMax then

                local newData = {}
                newData.count = ply.inventory[v.id].data.count + amount
                UpdateItemFromInventory(ply, v.id, newData)
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

function DeflowItemsFromInventory(ply, name, count)

    local amount = count
    local inv = table.Copy(ply.inventory)

    for k, v in ipairs(inv) do inv[k].id = k end

    table.sort(inv, function(a, b) return a.data.count < b.data.count end)

    for k, v in ipairs(inv) do

        if v.name == name and v.data.count > 0 and amount > 0 then

            if amount >= v.data.count then

                amount = amount - v.data.count
                DeleteItemFromInventory(ply, v.id, false)
                DeflowItemsFromInventory(ply, name, amount)
                return

            else

                local newData = {}
                newData.count = ply.inventory[v.id].data.count - amount
                UpdateItemFromInventory(ply, v.id, newData)
                break

            end

        end

    end

    return amount

end

net.Receive("PlayerInventoryDropItem", function(len, ply)

    local itemIndex = net.ReadUInt(16)
    local item = ply.inventory[itemIndex]

    if table.IsEmpty(item) then return false end

    entity = ents.Create("efgm_dropped_item")
    entity:SetItem(item.name, item.type, item.data)

    local pos, ang = ply:GetShootPos(), ply:EyeAngles()
    local dir = (ang:Forward() * 32) + (ang:Right() * 6) + (ang:Up() * -5)

    entity:SetPos(pos + dir)
    entity:Spawn()
    entity:SetOwner(ply)
    entity:PhysWake()

    local phys = entity:GetPhysicsObject()
    if IsValid(phys) then
        phys:ApplyForceCenter(ang:Forward() * 10)
        phys:ApplyForceOffset(VectorRand(), vector_origin)
    end

    table.remove(ply.inventory, itemIndex)
    RemoveWeightFromPlayer(ply, item.name, item.data.count)
    UpdateInventoryString(ply)

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

        if !item.data.owner then item.data.owner = ply:GetName() end

        DeleteItemFromInventory(ply, itemIndex, true)
        ply.weaponSlots[equipSlot][equipSubSlot] = item

        equipWeaponName = item.name
        GiveWepWithPresetFromCode(ply, item.name, item.data.att)

    end

    UpdateEquippedString(ply)

end)

net.Receive("PlayerInventoryUnEquipItem", function(len, ply)

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
    if def.displayType != "Grenade" then

        local clip1 = wep:Clip1()
        if clip1 != -1 and clip1 != 0 and ply:GetNWBool("InRange", false) == false then

            local data = {}
            data.count = wep:Clip1()
            FlowItemToInventory(ply, wep.Ammo, EQUIPTYPE.Ammunition, data)

        end

        local clip2 = wep:Clip2()
        if clip2 != -1 and clip2 != 0 and ply:GetNWBool("InRange", false) == false then

            local data = {}
            data.count = wep:Clip2()
            FlowItemToInventory(ply, wep.UBGLAmmo, EQUIPTYPE.Ammunition, data)

        end

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

    UpdateInventoryString(ply)
    UpdateEquippedString(ply)

end)

function UnequipAll(ply)

    for i = 1, 5 do

        if i == WEAPONSLOTS.MELEE.ID then continue end

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

                local def = EFGMITEMS[item.name]
                if def.displayType != "Grenade" then

                    local clip1 = wep:Clip1()
                    if clip1 != -1 and clip1 != 0 and ply:GetNWBool("InRange", false) == false then

                        local data = {}
                        data.count = wep:Clip1()
                        FlowItemToInventory(ply, wep.Ammo, EQUIPTYPE.Ammunition, data)

                    end

                    local clip2 = wep:Clip2()
                    if clip2 != -1 and clip2 != 0 and ply:GetNWBool("InRange", false) == false then

                        local data = {}
                        data.count = wep:Clip2()
                        FlowItemToInventory(ply, wep.UBGLAmmo, EQUIPTYPE.Ammunition, data)

                    end

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

    UpdateInventoryString(ply)
    UpdateEquippedString(ply)

end

function UnequipAllFirearms(ply)

    for i = 1, 5 do

        if i == WEAPONSLOTS.MELEE.ID or i == WEAPONSLOTS.UTILITY.ID then continue end

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

                local def = EFGMITEMS[item.name]
                if def.displayType != "Grenade" then

                    local clip1 = wep:Clip1()
                    if clip1 != -1 and clip1 != 0 and ply:GetNWBool("InRange", false) == false then

                        local data = {}
                        data.count = wep:Clip1()
                        FlowItemToInventory(ply, wep.Ammo, EQUIPTYPE.Ammunition, data)

                    end

                    local clip2 = wep:Clip2()
                    if clip2 != -1 and clip2 != 0 and ply:GetNWBool("InRange", false) == false then

                        local data = {}
                        data.count = wep:Clip2()
                        FlowItemToInventory(ply, wep.UBGLAmmo, EQUIPTYPE.Ammunition, data)

                    end

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

    UpdateInventoryString(ply)
    UpdateEquippedString(ply)

end

function MatchWithEquippedAndUpdate(ply, itemName, attsTbl)

    for i = 1, 5 do

        for k, v in pairs(ply.weaponSlots[i]) do

            if !table.IsEmpty(v) then

                if v.name == itemName then

                    local atts = table.Copy(attsTbl)
                    local str = GenerateAttachString(atts)
                    v.data.att = str

                    net.Start("PlayerInventoryUpdateEquipped", false)
                    net.WriteTable(v.data)
                    net.WriteUInt(i, 16)
                    net.WriteUInt(k, 16)
                    net.Send(ply)

                    return

                end

            end

        end

    end

end

net.Receive("PlayerInventoryDropEquippedItem", function(len, ply)

    local equipID = net.ReadUInt(4)
    local equipSlot = net.ReadUInt(4)

    local item = table.Copy(ply.weaponSlots[equipID][equipSlot])

    if table.IsEmpty(item) then return end

    table.Empty(ply.weaponSlots[equipID][equipSlot])

    ply:StripWeapon(item.name)

    entity = ents.Create("efgm_dropped_item")
    entity:SetItem(item.name, item.type, item.data)

    local pos, ang = ply:GetShootPos(), ply:EyeAngles()
    local dir = (ang:Forward() * 32) + (ang:Right() * 6) + (ang:Up() * -5)

    entity:SetPos(pos + dir)
    entity:Spawn()
    entity:SetOwner(ply)
    entity:PhysWake()

    local phys = entity:GetPhysicsObject()
    if IsValid(phys) then
        phys:ApplyForceCenter(ang:Forward() * 10)
        phys:ApplyForceOffset(VectorRand(), vector_origin)
    end

    RemoveWeightFromPlayer(ply, item.name, item.data.count)
    UpdateEquippedString(ply)

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
        ply:SetNWInt("HealthHealed", ply:GetNWInt("HealthHealed") + healAmount)
        ply:SetNWInt("RaidHealthHealed", ply:GetNWInt("RaidHealthHealed") + healAmount)
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

    UpdateInventoryString(ply)

end)

net.Receive("PlayerInventoryLootItemFromContainer", function(len, ply)

    local container = net.ReadEntity()
    local index = net.ReadUInt(16)

    if container == nil then return end

    local newItem = table.Copy(container.Inventory[index])

    local def = EFGMITEMS[newItem.name]

    if def.equipType == EQUIPTYPE.Weapon and !newItem.data.owner then

        newItem.data.owner = ply:GetName()

    end

    FlowItemToInventory(ply, newItem.name, newItem.type, newItem.data)

    if !ply:CompareStatus(0) then

        ply:SetNWInt("RaidItemsLooted", ply:GetNWInt("RaidItemsLooted") + 1)

    end

    table.remove(container.Inventory, index)

    if table.IsEmpty(container.Inventory) then container:Remove() end

end)

net.Receive("PlayerInventorySplit", function(len, ply)

    local invType = net.ReadString()
    local item = net.ReadString()
    local count = net.ReadUInt(8)
    local key = net.ReadUInt(16)

    if !ply:CompareStatus(0) and invType == "stash" then return false end

    local def = EFGMITEMS[item]

    if invType == "inv" then

        local data = ply.inventory[key].data

        if AmountInInventory(ply.inventory, item) < count then return false end

        local newData = table.Copy(data)
        newData.count = data.count - count
        UpdateItemFromInventory(ply, key, newData)

        local newNewData = table.Copy(data) -- fuck
        newNewData.count = count
        AddItemToInventory(ply, item, def.equipType, newNewData)

        UpdateInventoryString(ply)
        return true

    elseif invType == "stash" then

        local data = ply.stash[key].data

        if AmountInInventory(ply.stash, item) < count then return false end

        local newData = table.Copy(data)
        newData.count = data.count - count
        UpdateItemFromStash(ply, key, newData)

        local newNewData = table.Copy(data) -- fuck
        newNewData.count = count
        AddItemToStash(ply, item, def.equipType, newNewData)

        UpdateStashString(ply)
        return true

    end

end)

net.Receive("PlayerInventoryDelete", function(len, ply)

    local invType = net.ReadString()
    local key = net.ReadUInt(16)
    local equipID = net.ReadUInt(4)
    local equipSlot = net.ReadUInt(4)

    if !ply:CompareStatus(0) and invType == "stash" then return false end

    if invType == "inv" then

        local item = ply.inventory[key]

        RemoveWeightFromPlayer(ply, item.name, item.data.count)

        table.remove(ply.inventory, key)

        net.Start("PlayerInventoryDeleteItem", false)
        net.WriteUInt(key, 16)
        net.Send(ply)

        UpdateInventoryString(ply)

        return true

    elseif invType == "stash" then

        table.remove(ply.stash, key)

        net.Start("PlayerStashDeleteItem", false)
        net.WriteUInt(key, 16)
        net.Send(ply)

        UpdateStashString(ply)
        ply:SetNWInt("StashCount", #ply.stash)

        return true

    elseif invType == "equipped" then

        local item = table.Copy(ply.weaponSlots[equipID][equipSlot])

        table.Empty(ply.weaponSlots[equipID][equipSlot])

        ply:StripWeapon(item.name)

        net.Start("PlayerInventoryDeleteEquippedItem", false)
        net.WriteUInt(equipID, 4)
        net.WriteUInt(equipSlot, 4)
        net.Send(ply)

        RemoveWeightFromPlayer(ply, item.name, item.data.count)
        UpdateEquippedString(ply)

        return true

    end

end)

net.Receive("PlayerInventoryTag", function(len, ply)

    local tag = net.ReadString()
    local invType = net.ReadString()
    local key = net.ReadUInt(16)
    local equipID = net.ReadUInt(4)
    local equipSlot = net.ReadUInt(4)

    if !ply:CompareStatus(0) then return false end

    if invType == "inv" then

        if ply.inventory[key].data.tag != nil then return end
        ply.inventory[key].data.tag = tag

        net.Start("PlayerInventoryUpdateItem", false)
        net.WriteTable(ply.inventory[key].data)
        net.WriteUInt(key, 16)
        net.Send(ply)

        UpdateInventoryString(ply)

        return true

    elseif invType == "stash" then

        if ply.stash[key].data.tag != nil then return end
        ply.stash[key].data.tag = tag

        net.Start("PlayerStashUpdateItem", false)
        net.WriteTable(ply.stash[key].data)
        net.WriteUInt(key, 16)
        net.Send(ply)

        UpdateStashString(ply)
        ply:SetNWInt("StashCount", #ply.stash)

        return true

    elseif invType == "equipped" then

        if ply.weaponSlots[equipID][equipSlot].data.tag != nil then return end
        ply.weaponSlots[equipID][equipSlot].data.tag = tag

        net.Start("PlayerInventoryUpdateEquipped", false)
        net.WriteTable(ply.weaponSlots[equipID][equipSlot].data)
        net.WriteUInt(equipID, 16)
        net.WriteUInt(equipSlot, 16)
        net.Send(ply)

        UpdateEquippedString(ply)

        return true

    end

end)

function ConsumeGrenade(ply)

    table.Empty(ply.weaponSlots[4][1])

    net.Start("PlayerInventoryConsumeGrenade", false)
    net.Send(ply)

    UpdateEquippedString(ply)

end

function UpdateInventoryString(ply)

    local inventoryStr = util.TableToJSON(ply.inventory)
    inventoryStr = util.Compress(inventoryStr)
    inventoryStr = util.Base64Encode(inventoryStr, true)
    ply.invStr = inventoryStr

end

function UpdateEquippedString(ply)

    local equippedStr = util.TableToJSON(ply.weaponSlots)
    equippedStr = util.Compress(equippedStr)
    equippedStr = util.Base64Encode(equippedStr, true)
    ply.equStr = equippedStr

end

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

function CalculateInventoryWeight(ply)

    local newWeight = 0

    for k, v in pairs(ply.inventory) do

        local def = EFGMITEMS[v.name]
        local count = v.data.count or 1

        newWeight = math.Round(def.weight * count, 2) + newWeight

    end

    for i = 1, 5 do

        for k, v in pairs(ply.weaponSlots[i]) do

            if !table.IsEmpty(v) then

                local def = EFGMITEMS[v.name]
                local count = v.data.count or 1

                newWeight = math.Round(def.weight * count, 2) + newWeight

            end

        end

    end

    ply:SetNWFloat("InventoryWeight", newWeight)
    return newWeight

end

local function DecompressTableRecursive(tbl)

    local result = {}

    for _, v in ipairs(tbl) do

        if v.i then table.insert(result, v.i) end

        if v.s then

            local meow = DecompressTableRecursive(v.s)

            for _, v in ipairs(meow) do

                table.insert(result, v)

            end

        end

    end

    return result

end

local function GetAttsFromPreset(str)

    if !str then return end
    str = util.Base64Decode(str)
    str = util.Decompress(str)
    if !str then return end
    local tbl = util.JSONToTable(str)
    if !tbl then return end

    return DecompressTableRecursive(tbl)

end

local function GiveAttsFromList(ply, tbl)

    -- local take = false

    for i, k in pairs(tbl) do
        -- ARC9:PlayerGiveAtt(ply, k, 1)
        take = true
    end

    -- if take then ARC9:PlayerSendAttInv(ply) end

end

function GiveWepWithPresetFromCode(ply, classname, preset)

    if !ply:IsPlayer() then return end

	local swep = list.Get("Weapon")[classname]
	if swep == nil then return end

    if !isstring(preset) then

        ply:Give(classname)
        return

    end

    if !GetConVar("arc9_free_atts"):GetBool() then

        local atts = GetAttsFromPreset(preset)

        if !atts then

            ply:Give(classname)
            return

        end

        GiveAttsFromList(ply, atts)

    end

    if ply:HasWeapon(classname) then

        local wpn = ply:GetWeapon(classname)

        if IsValid(wpn) then

            ply.givingPreset = true
            wpn:SetNoPresets(true)

            net.Start("efgm_sendpreset")
            net.WriteEntity(wpn)
            net.WriteString(preset)
            net.Send(ply)

            wpn:PostModify()

        end

    else

        local wpn = ply:Give(classname)

        wpn:SetNoPresets(true)

        timer.Simple(0.1, function()

            if IsValid(wpn) then

                ply.givingPreset = true

                net.Start("efgm_sendpreset")
                net.WriteEntity(wpn)
                net.WriteString(preset)
                net.Send(ply)

            end

        end)

    end

end

hook.Add("PlayerSpawn", "GiveEquippedItemsOnSpawn", function(ply)

    ply.SpawnTimerVManip = CurTime() + 1 -- fuck off

    for i = 1, 5 do

        for k, v in pairs(ply.weaponSlots[i]) do

            if !table.IsEmpty(v) then

                local item = table.Copy(v)
                if item == nil then return end

                equipWeaponName = item.name
                GiveWepWithPresetFromCode(ply, item.name, item.data.att)

            end

        end

    end

end)

if GetConVar("efgm_derivesbox"):GetInt() == 1 then

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

    function GiveItem(ply, name, type, count)

        local data = {}
        data.count = count

        AddItemToInventory(ply, name, type, data)

    end
    concommand.Add("efgm_debug_giveitem", function(ply, cmd, args) GiveItem(ply, args[1], tonumber(args[2]), tonumber(args[3])) end)

    function WipeInventory(ply)

        ply.invStr = ""
        ply.inventory = {}

        net.Start("PlayerNetworkInventory", false)
        net.WriteString("")
        net.Send(ply)

        ply:SetNWFloat("InventoryWeight", 0.00)

    end
    concommand.Add("efgm_debug_wipeinventory", function(ply, cmd, args) WipeInventory(ply) end)

    function PrintInventoryString(ply)

        UpdateInventoryString(ply)
        print(ply.invStr)

    end
    concommand.Add("efgm_debug_printinventorystring", function(ply, cmd, args) PrintInventoryString(ply) end)

    function PrintEquippedString(ply)

        UpdateEquippedString(ply)
        print(ply.equStr)

    end
    concommand.Add("efgm_debug_printequippedstring", function(ply, cmd, args) PrintEquippedString(ply) end)

end