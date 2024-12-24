
ITEM = {}

function ITEM.CreateItem( identifier, count, metadata )

    local info = ReadJSON( identifier ) or ReadJSON( "missing_item" )

    local item = {}
    item.identifier = identifier
    item.count = count or 1
    item.metadata = metadata or {}

    return item

end