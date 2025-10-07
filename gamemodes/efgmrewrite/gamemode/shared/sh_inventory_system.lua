
-- https://www.youtube.com/watch?v=Iv3F5ARdu58

ITEM = {}

function ITEM.Instantiate(name, type, data)

    local item = {}

    item.name = name or "ERROR"
    item.type = type or -1
    item.data = data or {} -- instance data like count, attachments, durability, whatever the fuck

    return item

end

function AmountInInventory( ply, itemName )

    local inventory = {}
    if SERVER then inventory = ply.inventory end
    if CLIENT then inventory = playerInventory end

    local count = 0

    for k, v in ipairs(inventory) do
        
        if v.name == itemName then count = count + v.data.count or 1 end

    end

    return count

end
concommand.Add("efgm_debug_getinvamount", function(ply, cmd, args)

    print( AmountInInventory( ply, args[1] ).." amount of "..args[1].." found!" )

end)

concommand.Add("efgm_debug_getinventory", function(ply, cmd, args)

    PrintTable(ply.inventory)

end)