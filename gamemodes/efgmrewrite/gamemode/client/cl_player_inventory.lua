
playerInventory = {}

playerWeaponSlots = {}
for k, v in pairs(WEAPONSLOTS) do

    playerWeaponSlots[v.ID] = {}

    for i = 1, v.COUNT, 1 do
        playerWeaponSlots[v.ID][i] = {}
    end

end

playerEquippedSlot = 0
playerEquippedSubSlot = 0

-- for dev. purposes, dont need to start new map to give yourself items after a reload
function ReinstantiateInventory()

    playerInventory = {}

    playerWeaponSlots = {}
    for k, v in pairs(WEAPONSLOTS) do

    playerWeaponSlots[v.ID] = {}

    for i = 1, v.COUNT, 1 do
        playerWeaponSlots[v.ID][i] = {}
    end

    print("client inventory flushed")

end

playerEquippedSlot = 0
playerEquippedSubSlot = 0

end

hook.Add("OnReloaded", "InventoryReload", function() ReinstantiateInventory() RunConsoleCommand("efgm_flush_inventory") end)
net.Receive("PlayerReinstantiateInventory", function(len, ply) ReinstantiateInventory() end)

net.Receive("PlayerInventoryReload", function(len, ply)

    ReloadInventory()

end )

net.Receive("PlayerInventoryAddItem", function(len, ply)

    local name, type, data, index

    name = net.ReadString()
    type = net.ReadUInt(4)
    data = net.ReadTable()
    index = net.ReadUInt(16)

    table.insert(playerInventory, index, ITEM.Instantiate(name, type, data))
    ReloadInventory()

end )

net.Receive("PlayerInventoryUpdateItem", function(len, ply)

    local newData, index

    newData = net.ReadTable()
    index = net.ReadUInt(16)

    playerInventory[index].data = newData
    ReloadInventory()

end )

net.Receive("PlayerInventoryDeleteItem", function(len, ply)

    local index

    index = net.ReadUInt(16)

    table.remove(playerInventory, index)

    ReloadInventory()

end )

net.Receive("PlayerInventoryUnEquipAll", function(len, ply)

    playerWeaponSlots = {}
    for k, v in pairs(WEAPONSLOTS) do

        playerWeaponSlots[v.ID] = {}

        for i = 1, v.COUNT, 1 do
            playerWeaponSlots[v.ID][i] = {}
        end

    end

end )

function DropItemFromInventory(itemIndex, data)

    net.Start("PlayerInventoryDropItem", false)
    net.WriteUInt(itemIndex, 16)
    net.WriteTable(data)
    net.SendToServer()

    table.remove(playerInventory, itemIndex)
    ReloadInventory()

end

-- returns bool whether or not it could equip an item clientside (desync may be an issue since server could disagree and neither side would know)
function EquipItemFromInventory(itemIndex, equipSlot, primaryPref)

    local item = playerInventory[itemIndex]
    if item == nil then return end

    print("SLOT IS " .. equipSlot)

    if AmountInInventory(playerWeaponSlots[equipSlot], item.name ) != 0 then return end -- can't have multiple of the same item

    -- checking item equip slots
    if equipSlot == 1 and primaryPref != nil then

        if primaryPref == 1 then

            playerWeaponSlots[equipSlot][1] = item

            ReloadInventory()

            net.Start("PlayerInventoryEquipItem", false )
                net.WriteUInt(itemIndex, 16)
                net.WriteUInt(equipSlot, 4)
                net.WriteUInt(1, 16)
            net.SendToServer()

            ReloadInventory()

            return true

        else

            playerWeaponSlots[equipSlot][2] = item

            ReloadInventory()

            net.Start("PlayerInventoryEquipItem", false )
                net.WriteUInt(itemIndex, 16)
                net.WriteUInt(equipSlot, 4)
                net.WriteUInt(2, 16)
            net.SendToServer()

            ReloadInventory()

            return true

        end

    else

        for k, v in ipairs(playerWeaponSlots[equipSlot]) do

            if table.IsEmpty(v) then

                playerWeaponSlots[equipSlot][k] = item

                ReloadInventory()

                net.Start("PlayerInventoryEquipItem", false )
                    net.WriteUInt(itemIndex, 16)
                    net.WriteUInt(equipSlot, 4)
                    net.WriteUInt(k, 16)
                net.SendToServer()

                ReloadInventory()

                return true

            end

        end

    end

    return false

end

function UnEquipItemFromInventory(equipID, equipSlot)

    local item = playerWeaponSlots[equipID][equipSlot]

    if table.IsEmpty(item) then return end

    table.Empty(playerWeaponSlots[equipID][equipSlot])

    ReloadSlots()

    net.Start("PlayerInventoryUnEquipItem", false)
        net.WriteUInt(equipID, 4)
        net.WriteUInt(equipSlot, 4)
    net.SendToServer()

    ReloadSlots()

end

function DropEquippedItem(equipID, equipSlot)

    local item = playerWeaponSlots[equipID][equipSlot]

    if table.IsEmpty(item) then return end

    table.Empty(playerWeaponSlots[equipID][equipSlot])

    ReloadSlots()

    net.Start("PlayerInventoryDropEquippedItem", false)
        net.WriteUInt(equipID, 4)
        net.WriteUInt(equipSlot, 4)
    net.SendToServer()

    ReloadSlots()

end

function ConsumeItemFromInventory(itemIndex)

    net.Start("PlayerInventoryConsumeItem", false)
    net.WriteUInt(itemIndex, 16)
    net.SendToServer()
    ReloadInventory()

end

concommand.Add("efgm_inventory_equip", function(ply, cmd, args)

    -- if subslot is specified it tries to equip that specific slot, and if not it cycles through all subslots for that slot type (eg, for grenades or utility)
    local equipSlot = tonumber(args[1])
    if equipSlot == nil then return end
    local equipSubSlot = tonumber(args[2])

    if equipSubSlot == nil then

        if playerEquippedSlot == equipSlot then

            local subSlotCount = #playerWeaponSlots[equipSlot]

            if subSlotCount == 1 or playerEquippedSubSlot == subSlotCount then -- selecting first subslot

                local item = playerWeaponSlots[equipSlot][1]
                if !istable(item) then return end
                if table.IsEmpty(item) then return end

                weapon = LocalPlayer():GetWeapon(item.name)
                input.SelectWeapon(weapon)

                playerEquippedSlot = equipSlot
                playerEquippedSubSlot = 1

            else -- cycling to next subslot

                local item = playerWeaponSlots[equipSlot][playerEquippedSubSlot + 1]
                if !istable(item) then return end
                if table.IsEmpty(item) then return end

                weapon = LocalPlayer():GetWeapon(item.name)
                input.SelectWeapon(weapon)

                playerEquippedSlot = equipSlot
                playerEquippedSubSlot = playerEquippedSubSlot + 1

            end

        else -- selecting first subslot

            local item = playerWeaponSlots[equipSlot][1]
            if !istable(item) then return end
            if table.IsEmpty(item) then return end

            weapon = LocalPlayer():GetWeapon(item.name)
            input.SelectWeapon(weapon)

            playerEquippedSlot = equipSlot
            playerEquippedSubSlot = 1

        end

    else -- selecting from subslot

        local item = playerWeaponSlots[equipSlot][equipSubSlot]
        if !istable(item) then return end
        if table.IsEmpty(item) then return end

        weapon = LocalPlayer():GetWeapon(item.name)
        -- print("item.name = " .. item.name)
        input.SelectWeapon(weapon)

        playerEquippedSlot = equipSlot
        playerEquippedSubSlot = equipSubSlot

    end

end)