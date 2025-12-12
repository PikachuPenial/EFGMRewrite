
local chunkedInv = {}
local chunkedEqu = {}

hook.Add("OnInventoryChunked", "NetworkInventory", function(str, uID)

    local inventoryStr = str
    inventoryStr = util.Base64Decode(inventoryStr)
    inventoryStr = util.Decompress(inventoryStr)

    if !inventoryStr then return end

    local inventoryTbl = util.JSONToTable(inventoryStr)

    playerInventory = inventoryTbl
    if playerInventory == nil then playerInventory = {} end

end)

hook.Add("OnEquippedChunked", "NetworkEquipped", function(str, uID)

    local equippedStr = str

    equippedStr = util.Base64Decode(equippedStr)
    equippedStr = util.Decompress(equippedStr)

    if !equippedStr then return end

    local equippedTbl = util.JSONToTable(equippedStr)

    playerWeaponSlots = equippedTbl
    if playerWeaponSlots == nil then

        playerWeaponSlots = {}
        for k, v in pairs(WEAPONSLOTS) do

            playerWeaponSlots[v.ID] = {}

            for i = 1, v.COUNT, 1 do

                playerWeaponSlots[v.ID][i] = {}

            end

        end

    end

    playerEquippedSlot = 0
    playerEquippedSubSlot = 0

end)

net.Receive("PlayerNetworkInventory", function(len, ply)

    local uID = net.ReadFloat()
    local index = net.ReadUInt(16)
    local chunkCount = net.ReadUInt(16)
    local chunk = net.ReadString()

    if !chunkedInv[uID] then

        chunkedInv[uID] = {

            Chunks = {},
            ReceivedCount = 0,
            TotalCount = chunkCount

        }

    end

    chunkedInv[uID].Chunks[index] = chunk
    chunkedInv[uID].ReceivedCount = chunkedInv[uID].ReceivedCount + 1

    if chunkedInv[uID].ReceivedCount == chunkedInv[uID].TotalCount then

        local str = ""

        for i = 1, chunkCount do

            str = str .. chunkedInv[uID].Chunks[i]

        end

        hook.Run("OnInventoryChunked", str, uID)
        chunkedInv[uID] = nil

    end

end )

net.Receive("PlayerNetworkEquipped", function(len, ply)

    local uID = net.ReadFloat()
    local index = net.ReadUInt(16)
    local chunkCount = net.ReadUInt(16)
    local chunk = net.ReadString()

    if !chunkedEqu[uID] then

        chunkedEqu[uID] = {

            Chunks = {},
            ReceivedCount = 0,
            TotalCount = chunkCount

        }

    end

    chunkedEqu[uID].Chunks[index] = chunk
    chunkedEqu[uID].ReceivedCount = chunkedEqu[uID].ReceivedCount + 1

    if chunkedEqu[uID].ReceivedCount == chunkedEqu[uID].TotalCount then

        local str = ""

        for i = 1, chunkCount do

            str = str .. chunkedEqu[uID].Chunks[i]

        end

        hook.Run("OnEquippedChunked", str, uID)
        chunkedEqu[uID] = nil

    end

end )

function ReinstantiateInventory()

    playerInventory = {}

    local equMelee = table.Copy(playerWeaponSlots[WEAPONSLOTS.MELEE.ID])

    playerWeaponSlots = {}
    for k, v in pairs(WEAPONSLOTS) do

        playerWeaponSlots[v.ID] = {}

        for i = 1, v.COUNT, 1 do

            playerWeaponSlots[v.ID][i] = {}

        end

    end

    if equMelee != nil then playerWeaponSlots[WEAPONSLOTS.MELEE.ID] = equMelee end

    playerEquippedSlot = 0
    playerEquippedSubSlot = 0

end

function ReinstantiateInventoryAfterDuel()

    local equMelee = table.Copy(playerWeaponSlots[WEAPONSLOTS.MELEE.ID])

    playerWeaponSlots = {}
    for k, v in pairs(WEAPONSLOTS) do

        playerWeaponSlots[v.ID] = {}

        for i = 1, v.COUNT, 1 do

            playerWeaponSlots[v.ID][i] = {}

        end

    end

    if equMelee != nil then playerWeaponSlots[WEAPONSLOTS.MELEE.ID] = equMelee end

    playerEquippedSlot = 0
    playerEquippedSubSlot = 0

end

net.Receive("PlayerReinstantiateInventory", function(len, ply) ReinstantiateInventory() end)
net.Receive("PlayerReinstantiateInventoryAfterDuel", function(len, ply) ReinstantiateInventoryAfterDuel() end)

net.Receive("PlayerInventoryReload", function(len, ply)

    Menu.ReloadInventory()

end )

net.Receive("PlayerSlotsReload", function(len, ply)

    Menu.ReloadSlots()

end )

net.Receive("PlayerInventoryAddItem", function(len, ply)

    local name, type, data, index

    name = net.ReadString()
    type = net.ReadUInt(4)
    data = net.ReadTable()
    index = net.ReadUInt(16)

    table.insert(playerInventory, index, ITEM.Instantiate(name, type, data))

end )

net.Receive("PlayerInventoryUpdateItem", function(len, ply)

    local newData, index

    newData = net.ReadTable()
    index = net.ReadUInt(16)

    playerInventory[index].data = newData

end )

net.Receive("PlayerInventoryDeleteItem", function(len, ply)

    local index

    index = net.ReadUInt(16)

    table.remove(playerInventory, index)

end )

net.Receive("PlayerInventoryUnEquipAll", function(len, ply)

    local equMelee = table.Copy(playerWeaponSlots[WEAPONSLOTS.MELEE.ID])

    playerWeaponSlots = {}
    for k, v in pairs(WEAPONSLOTS) do

        if v.ID == WEAPONSLOTS.MELEE.ID then continue end

        playerWeaponSlots[v.ID] = {}

        for i = 1, v.COUNT, 1 do

            playerWeaponSlots[v.ID][i] = {}

        end

    end

    if equMelee != nil then playerWeaponSlots[WEAPONSLOTS.MELEE.ID] = equMelee end

    Menu.ReloadSlots()

end )

function UnequipAll()

    net.Start("PlayerInventoryUnEquipAllCL", false)
    net.SendToServer()

end

net.Receive("PlayerInventoryUpdateEquipped", function(len, ply)

    local newData, index, key

    newData = net.ReadTable()
    index = net.ReadUInt(16)
    key = net.ReadUInt(16)

    playerWeaponSlots[index][key].data = newData
    Menu.ReloadSlots()

end )

net.Receive("PlayerInventoryDeleteEquippedItem", function(len, ply)

    local equipID, equipSlot

    equipID = net.ReadUInt(4)
    equipSlot = net.ReadUInt(4)

    table.Empty(playerWeaponSlots[equipID][equipSlot])

    Menu.ReloadSlots()

end )

function DropItemFromInventory(itemIndex)

    if LocalPlayer():CompareStatus(3) then return end

    net.Start("PlayerInventoryDropItem", false)
    net.WriteUInt(itemIndex, 16)
    net.SendToServer()

    table.remove(playerInventory, itemIndex)
    Menu.ReloadInventory()

end

-- returns bool whether or not it could equip an item clientside (desync may be an issue since server could disagree and neither side would know)
function EquipItemFromInventory(itemIndex, equipSlot, primaryPref)

    if LocalPlayer():CompareStatus(3) then return end

    local item = playerInventory[itemIndex]
    if item == nil then return end

    if AmountInInventory(playerWeaponSlots[equipSlot], item.name) != 0 then return end -- can't have multiple of the same item

    -- checking item equip slots
    if equipSlot == 1 and primaryPref != nil then

        if primaryPref == 1 then

            playerWeaponSlots[equipSlot][1] = item

            net.Start("PlayerInventoryEquipItem", false)
                net.WriteUInt(itemIndex, 16)
                net.WriteUInt(equipSlot, 4)
                net.WriteUInt(1, 16)
            net.SendToServer()

            return true

        else

            playerWeaponSlots[equipSlot][2] = item

            net.Start("PlayerInventoryEquipItem", false)
                net.WriteUInt(itemIndex, 16)
                net.WriteUInt(equipSlot, 4)
                net.WriteUInt(2, 16)
            net.SendToServer()

            return true

        end

    else

        for k, v in ipairs(playerWeaponSlots[equipSlot]) do

            if table.IsEmpty(v) then

                playerWeaponSlots[equipSlot][k] = item

                net.Start("PlayerInventoryEquipItem", false)
                    net.WriteUInt(itemIndex, 16)
                    net.WriteUInt(equipSlot, 4)
                    net.WriteUInt(k, 16)
                net.SendToServer()

                return true

            end

        end

    end

    return false

end

function UnEquipItemFromInventory(equipID, equipSlot)

    if LocalPlayer():CompareStatus(3) then return end

    local item = playerWeaponSlots[equipID][equipSlot]

    if table.IsEmpty(item) then return end

    table.Empty(playerWeaponSlots[equipID][equipSlot])

    net.Start("PlayerInventoryUnEquipItem", false)
        net.WriteUInt(equipID, 4)
        net.WriteUInt(equipSlot, 4)
    net.SendToServer()

end

function DropEquippedItem(equipID, equipSlot)

    if LocalPlayer():CompareStatus(3) then return end

    local item = playerWeaponSlots[equipID][equipSlot]

    if table.IsEmpty(item) then return end

    table.Empty(playerWeaponSlots[equipID][equipSlot])

    net.Start("PlayerInventoryDropEquippedItem", false)
        net.WriteUInt(equipID, 4)
        net.WriteUInt(equipSlot, 4)
    net.SendToServer()

    Menu.ReloadSlots()

end

function ConsumeItemFromInventory(itemIndex)

    net.Start("PlayerInventoryConsumeItem", false)
    net.WriteUInt(itemIndex, 16)
    net.SendToServer()

end

net.Receive("PlayerInventoryConsumeGrenade", function(len, ply)

    table.Empty(playerWeaponSlots[4][1])
    Menu.ReloadSlots()

end )

net.Receive("PlayerInventoryClearFIR", function(len, ply)

    for k, v in ipairs(playerInventory) do

        v.data.fir = nil

    end

    for i = 1, 5 do

        for k, v in pairs(playerWeaponSlots[i]) do

            if table.IsEmpty(v) then continue end

            v.data.fir = nil

        end

    end

    Menu.ReloadInventory()
    Menu.ReloadSlots()

end )

net.Receive("PlayerInventoryReloadForDuel", function(len, ply)

    local primaryItem, secondaryItem

    primaryItem = net.ReadTable()
    secondaryItem = net.ReadTable()

    local hasPrimary = false
    local hasHolster = false

    if primaryItem != nil and !table.IsEmpty(primaryItem) then hasPrimary = true playerWeaponSlots[1][1] = primaryItem end
    if secondaryItem != nil and !table.IsEmpty(secondaryItem) then hasHolster = true playerWeaponSlots[2][1] = secondaryItem end

    timer.Simple(0.2, function()

        if hasPrimary and hasHolster then LocalPlayer():ConCommand("efgm_inventory_equip " .. WEAPONSLOTS.PRIMARY.ID)
        elseif !hasPrimary and hasHolster then LocalPlayer():ConCommand("efgm_inventory_equip " .. WEAPONSLOTS.HOLSTER.ID)
        end

    end)

    Menu.ReloadInventory()
    Menu.ReloadSlots()

end )

net.Receive("efgm_sendpreset", function(len)

    local wpn = net.ReadEntity()
    local preset = net.ReadString()

    if IsValid(wpn) and wpn.ARC9 then

        wpn:LoadPresetFromTable(wpn:ImportPresetCode(preset))

    end

end)

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
                if weapon != NULL then input.SelectWeapon(weapon) end

                playerEquippedSlot = equipSlot
                playerEquippedSubSlot = 1

            else -- cycling to next subslot

                local item = playerWeaponSlots[equipSlot][playerEquippedSubSlot + 1]
                if !istable(item) then return end
                if table.IsEmpty(item) then return end

                weapon = LocalPlayer():GetWeapon(item.name)
                if weapon != NULL then input.SelectWeapon(weapon) end

                playerEquippedSlot = equipSlot
                playerEquippedSubSlot = playerEquippedSubSlot + 1

            end

        else -- selecting first subslot

            local item = playerWeaponSlots[equipSlot][1]
            if !istable(item) then return end
            if table.IsEmpty(item) then return end

            weapon = LocalPlayer():GetWeapon(item.name)
            if weapon != NULL then input.SelectWeapon(weapon) end

            playerEquippedSlot = equipSlot
            playerEquippedSubSlot = 1

        end

    else -- selecting from subslot

        local item = playerWeaponSlots[equipSlot][equipSubSlot]
        if !istable(item) then return end
        if table.IsEmpty(item) then return end
        if item == NULL then return end

        weapon = LocalPlayer():GetWeapon(item.name)
        if weapon != NULL then input.SelectWeapon(weapon) end

        playerEquippedSlot = equipSlot
        playerEquippedSubSlot = equipSubSlot

    end

end)

function SplitFromInventory(inv, item, count, key)

    net.Start("PlayerInventorySplit", false)
    net.WriteString(inv)
    net.WriteString(item)
    net.WriteUInt(count, 8)
    net.WriteUInt(key, 16)
    net.SendToServer()

end

function DeleteFromInventory(inv, item, key, eID, eSlot)

    net.Start("PlayerInventoryDelete", false)
    net.WriteString(inv)
    net.WriteUInt(key, 16)
    net.WriteUInt(eID, 4)
    net.WriteUInt(eSlot, 4)
    net.SendToServer()

end

function TagFromInventory(tag, inv, item, key, eID, eSlot)

    net.Start("PlayerInventoryTag", false)
    net.WriteString(tag)
    net.WriteString(inv)
    net.WriteUInt(key, 16)
    net.WriteUInt(eID, 4)
    net.WriteUInt(eSlot, 4)
    net.SendToServer()

end


function PurchaseItem(item, count)

    net.Start("PlayerMarketPurchaseItem", false)
    net.WriteString(item)
    net.WriteUInt(count, 16)
    net.SendToServer()

end

function PurchaseItemToInv(item, count)

    net.Start("PlayerMarketPurchaseItemToInventory", false)
    net.WriteString(item)
    net.WriteUInt(count, 16)
    net.SendToServer()

end

function PurchasePresetToInventory(atts)

    net.Start("PlayerMarketPurchasePresetToInventory", false)
    net.WriteTable(atts)
    net.SendToServer()

end

function SellItem(item, count, key)

    net.Start("PlayerMarketSellItem", false)
    net.WriteString(item)
    net.WriteUInt(count, 8)
    net.WriteUInt(key, 16)
    net.SendToServer()

end

function SellBulk(ids)

    net.Start("PlayerMarketSellBulk", false)
    net.WriteTable(ids)
    net.SendToServer()

end