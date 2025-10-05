
playerInventory = {}

-- for dev. purposes, dont need to start new map to give yourself items after a reload
function ReinstantiateInventory()

    print("client inventory flushed")
    playerInventory = {}

end

hook.Add("OnReloaded", "InventoryReload", function() ReinstantiateInventory() RunConsoleCommand("efgm_flush_inventory") end)
net.Receive("PlayerReinstantiateInventory", function(len, ply) ReinstantiateInventory() end)

net.Receive("PlayerInventoryAddItem", function(len, ply)

    local name, type, data, index

    name = net.ReadString()
    type = net.ReadUInt(4)
    data = net.ReadTable()
    index = net.ReadUInt(16)

    table.insert(playerInventory, index, ITEM.Instantiate(name, type, data))

end )

function DropItemFromInventory(itemIndex)

    net.Start("PlayerInventoryDropItem", false)
    net.WriteUInt(itemIndex, 16)
    net.SendToServer()

    table.remove(playerInventory, itemIndex)

end

function EquipItemFromInventory(itemIndex)

    -- can receive "Primary", "Holster", "Melee" and "Grenade"
    -- if it receives a primary weapon, check if the primary weapon slot is used. If it isn't, put it there, if it is, put it in the secondary weapon slot instead

end