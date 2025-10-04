
-- https://www.youtube.com/watch?v=Iv3F5ARdu58

-- for dev. purposes, dont need to start new map to give yourself items after a reload
hook.Add("OnReloaded", "InventoryReload", function()

    for k, ply in pairs(player.GetAll()) do
        ReinstantiateInventory(ply)
    end

end)

ITEM = {}

function ITEM.Instantiate(name, type, data)
    local item = {}

    item.name = name or "ERROR"
    item.type = type or -1
    item.data = data or {} -- instance data like count, attachments, durability, whatever the fuck

    return item
end