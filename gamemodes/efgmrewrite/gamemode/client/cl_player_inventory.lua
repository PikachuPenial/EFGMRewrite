
playerInventory = {}

-- for dev. purposes, dont need to start new map to give yourself items after a reload
function ReinstantiateInventory(ply)

    print("client inventory cleared")
    table.Empty(playerInventory)
    table.ClearKeys(playerInventory)

end


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