
-- https://www.youtube.com/watch?v=Iv3F5ARdu58

ITEM = {}

function ITEM.Instantiate(name, type, data)

    local item = {}

    item.name = name or "ERROR"
    item.type = type or -1
    item.data = data or {} -- instance data like count, attachments, durability, whatever the fuck

    return item

end

function AmountInInventory(inventory, itemName)

    local count = 0

    for k, v in ipairs(inventory) do

        if !table.IsEmpty(v) then
            if v.name == itemName then
                count = count + (math.max(v.data.count, 1) or 1)
            end
        end

    end

    return count

end

if GetConVar("efgm_derivesbox"):GetInt() == 1 then

    concommand.Add("efgm_debug_getinventory", function(ply, cmd, args)

        PrintTable(ply.inventory)

    end)

end