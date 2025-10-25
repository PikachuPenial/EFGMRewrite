
util.AddNetworkString("PlayerReinstantiateInventory")
util.AddNetworkString("PlayerInventoryAddItem")
util.AddNetworkString("PlayerInventoryUpdateItem")
util.AddNetworkString("PlayerInventoryDeleteItem")
util.AddNetworkString("PlayerInventoryDropItem")
util.AddNetworkString("PlayerInventoryEquipItem")
util.AddNetworkString("PlayerInventoryConsumeItem")

hook.Add("PlayerSpawn", "InventorySetup", function(ply)

	ply.inventory = {}

    ply.weaponSlots = {}
    for k, v in pairs( WEAPONSLOTS ) do

        ply.weaponSlots[v.ID] = {}

        for i = 1, v.COUNT, 1 do
            ply.weaponSlots[v.ID][i] = {}
        end

    end

end)

function ReinstantiateInventory(ply)

    ply.inventory = {}

    ply.weaponSlots = {}
    for k, v in pairs( WEAPONSLOTS ) do

        ply.weaponSlots[v.ID] = {}

        for i = 1, v.COUNT, 1 do
            ply.weaponSlots[v.ID][i] = {}
        end

    end

    print("server inventory flushed")

end
concommand.Add("efgm_flush_inventory", function(ply, cmd, args) ReinstantiateInventory(ply) end)

hook.Add("OnReloaded", "InventoryReload", function()

    for k, ply in pairs(player.GetAll()) do
        ReinstantiateInventory(ply)
    end

    net.Start("PlayerReinstantiateInventory", false)
    net.Broadcast()

end)

function AddItemToInventory(ply, name, type, data)

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

end

function UpdateItemFromInventory(ply, index, data)

    ply.inventory[index].data = data

    net.Start("PlayerInventoryUpdateItem", false)
    net.WriteTable(ply.inventory[index].data)
    net.WriteUInt(index, 16)
    net.Send(ply)

end

function DeleteItemFromInventory(ply, index)

    print("Deleting " .. ply.inventory[index].name .. " at index " .. index)
    table.remove(ply.inventory, index)

    net.Start("PlayerInventoryDeleteItem", false)
    net.WriteUInt(index, 16)
    net.Send(ply)

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
                DeleteItemFromInventory(ply, k)

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

    local wep = ents.Create(item.name)

    if data.att then

        local attachments = util.JSONToTable(data.att)

        for k, v in pairs(attachments) do DecompressTableRecursive(v) end

        wep.Attachments = table.Copy(attachments)

    end

    wep:SetPos(ply:GetShootPos() + ply:GetForward() * 128)
    wep:Spawn()
    wep:PhysWake()

    if type(wep.GetData) == "function" then wep:GetData(data) end

    table.remove(ply.inventory, itemIndex)

end)

net.Receive("PlayerInventoryEquipItem", function(len, ply)

    local itemIndex, equipSlot, equipSubSlot

    itemIndex = net.ReadUInt(16)
    equipSlot = net.ReadUInt(4)
    equipSubSlot = net.ReadUInt(16)

    print(itemIndex)
    print(equipSlot)
    print(equipSubSlot)

    local item = ply.inventory[itemIndex]
    if item == nil then return end

    print("got past item nil check")

    print(AmountInInventory( ply.weaponSlots[ equipSlot ], item.name ) .. " of " .. item.name .. " in inventory")
    if AmountInInventory( ply.weaponSlots[ equipSlot ], item.name ) > 0 then return end -- can't have multiple of the same item

    print("got past amountininventory check")

    if table.IsEmpty( ply.weaponSlots[equipSlot][equipSubSlot] ) then

    print("got past amountininventory check")

        DeleteItemFromInventory(ply, itemIndex)
        ply.weaponSlots[equipSlot][equipSubSlot] = item

        print("Success! Equipping " .. item.name)

        equipWeaponName = item.name
        ply:Give(item.name, true)
        -- go crazy with attachments here penal

    end

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

        end

    end

end)

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

