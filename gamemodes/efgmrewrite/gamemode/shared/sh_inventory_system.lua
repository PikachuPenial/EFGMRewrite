-- https://www.youtube.com/watch?v=Iv3F5ARdu58

ITEM = {}

function ITEM.Instantiate(name, type, data)
    local item = {}

    item.name = name or "ERROR"
    item.type = type or -1
    item.data = data or {} -- instance data like count, attachments, durability, whatever the fuck

    return item
end
