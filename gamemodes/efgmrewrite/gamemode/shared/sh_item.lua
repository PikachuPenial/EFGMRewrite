
ITEM = {}

function ITEM.CreateItem( identifier, data, md )

    local item = {}
    item.identifier = identifier
    item.data = data or {}
    item.md = md or {}

    local info = EFGMITEMS[ id ]

    if info.equipType == EQUIPTYPE.Gear then
        
        for k, v in ipairs( info.childContainers ) do

            item.data[k] = {}
            item.md[k] = {}

        end

    end

    return item

end

function ITEM.AddItem( container, childContainerID, item, posX, posY, isRotated )

    // should probably be checks here for whether the item can fit or not

    local index = table.insert( container.data[childContainerID], item )
    container.md[childContainerID][index] = {
        ["x"] = posX,
        ["y"] = posY,
        ["r"] = isRotated
    }

end

function ITEM.RemoveItemAtIndex( container, childContainerID, index )

    table.remove( container.data[childContainerID], index)
    table.remove( container.md[childContainerID], index)

end