
ITEM = {}

function ITEM.CreateItem( identifier, data, md )

    local info = ReadJSON( identifier ) or ReadJSON( "missing_item" )

    local item = {}
    item.identifier = identifier
    item.data = data or {}
    item.md = md or {}

    return item

end