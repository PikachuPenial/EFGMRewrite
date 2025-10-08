
playerInventory = {}

-- for dev. purposes, dont need to start new map to give yourself items after a reload
function ReinstantiateInventory()

    print("client inventory flushed")
    playerInventory = {}

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

function DropItemFromInventory(itemIndex, data)

    net.Start("PlayerInventoryDropItem", false)
    net.WriteUInt(itemIndex, 16)
    net.WriteTable(data)
    net.SendToServer()

    table.remove(playerInventory, itemIndex)
    ReloadInventory()

end

function EquipItemFromInventory(itemIndex)

    -- can receive "Primary", "Holster", "Melee" and "Grenade"
    -- if it receives a primary weapon, check if the primary weapon slot is used. If it isn't, put it there, if it is, put it in the secondary weapon slot instead
    ReloadInventory()

end

function ConsumeItemFromInventory(itemIndex)

    net.Start("PlayerInventoryConsumeItem", false)
    net.WriteUInt(itemIndex, 16)
    net.SendToServer()
    ReloadInventory()

end