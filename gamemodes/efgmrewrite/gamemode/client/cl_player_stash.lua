
net.Receive("PlayerNetworkStash", function(len, ply)

    local stashStr = net.ReadString()

    stashStr = util.Base64Decode(stashStr)
    stashStr = util.Decompress(stashStr)

    if !stashStr then return end

    local stashTbl = util.JSONToTable(stashStr)

    playerStash = stashTbl
    if playerStash == nil then playerStash = {} end

end )

net.Receive("PlayerStashReload", function(len, ply)

    Menu.ReloadStash()

end )

net.Receive("PlayerStashAddItem", function(len, ply)

    local name, type, data, index

    name = net.ReadString()
    type = net.ReadUInt(4)
    data = net.ReadTable()
    index = net.ReadUInt(16)

    table.insert(playerStash, index, ITEM.Instantiate(name, type, data))
    Menu.ReloadStash()

end )

net.Receive("PlayerStashUpdateItem", function(len, ply)

    local newData, index

    newData = net.ReadTable()
    index = net.ReadUInt(16)

    playerStash[index].data = newData
    Menu.ReloadStash()

end )

net.Receive("PlayerStashDeleteItem", function(len, ply)

    local index

    index = net.ReadUInt(16)

    table.remove(playerStash, index)

    Menu.ReloadStash()

end )

function StashItemFromInventory(itemIndex)

    if !ply:CompareStatus(0) then return end

    local item = playerInventory[itemIndex]
    if item == nil then return end

    net.Start("PlayerStashAddItemFromInventory", false)
        net.WriteUInt(itemIndex, 16)
    net.SendToServer()

    Menu.ReloadInventory()
    Menu.ReloadStash()

end

function StashItemFromEquipped(equipID, equipSlot)

    if !ply:CompareStatus(0) then return end

    local item = playerWeaponSlots[equipID][equipSlot]

    if table.IsEmpty(item) then return end

    table.Empty(playerWeaponSlots[equipID][equipSlot])

    net.Start("PlayerStashAddItemFromEquipped", false)
        net.WriteUInt(equipID, 4)
        net.WriteUInt(equipSlot, 4)
    net.SendToServer()

    Menu.ReloadSlots()
    Menu.ReloadStash()

end

function TakeFromStashToInventory(itemIndex)

    if !ply:CompareStatus(0) then return end

    local item = playerStash[itemIndex]
    if item == nil then return end

    net.Start("PlayerStashTakeItemToInventory", false)
        net.WriteUInt(itemIndex, 16)
    net.SendToServer()

    Menu.ReloadInventory()
    Menu.ReloadStash()

end

function EquipItemFromStash(itemIndex, equipSlot, primaryPref)

    if !ply:CompareStatus(0) then return end

    local item = playerStash[itemIndex]
    if item == nil then return end

    if AmountInInventory(playerWeaponSlots[equipSlot], item.name) != 0 then return end

    -- checking item equip slots
    if equipSlot == 1 and primaryPref != nil then

        if primaryPref == 1 then

            playerWeaponSlots[equipSlot][1] = item

            net.Start("PlayerStashEquipItem", false)
                net.WriteUInt(itemIndex, 16)
                net.WriteUInt(equipSlot, 4)
                net.WriteUInt(1, 16)
            net.SendToServer()

            Menu.ReloadSlots()

            return true

        else

            playerWeaponSlots[equipSlot][2] = item

            net.Start("PlayerStashEquipItem", false)
                net.WriteUInt(itemIndex, 16)
                net.WriteUInt(equipSlot, 4)
                net.WriteUInt(2, 16)
            net.SendToServer()

            Menu.ReloadSlots()

            return true

        end

    else

        for k, v in ipairs(playerWeaponSlots[equipSlot]) do

            if table.IsEmpty(v) then

                playerWeaponSlots[equipSlot][k] = item

                net.Start("PlayerStashEquipItem", false)
                    net.WriteUInt(itemIndex, 16)
                    net.WriteUInt(equipSlot, 4)
                    net.WriteUInt(k, 16)
                net.SendToServer()

                Menu.ReloadSlots()

                return true

            end

        end

    end

    return false

end

function ConsumeItemFromStash(itemIndex)

    if !ply:CompareStatus(0) then return end

    net.Start("PlayerStashConsumeItem", false)
    net.WriteUInt(itemIndex, 16)
    net.SendToServer()
    Menu.ReloadStash()

end

function PinItemFromStash(itemIndex)

    if !ply:CompareStatus(0) then return end

    local item = playerStash[itemIndex]
    if item == nil then return end

    net.Start("PlayerStashPinItem", false)
        net.WriteUInt(itemIndex, 16)
    net.SendToServer()

    Menu.ReloadStash()

end