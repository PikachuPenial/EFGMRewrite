
playerInventory = {}

net.Receive( "ModifyPlayerInventory", function( len, ply )

    local name, type, data, arg

    name = net.ReadString()
    type = net.ReadUInt( 4 )
    data = net.ReadTable()
    arg = net.ReadUInt(4)

    if arg == 0 then

        table.insert( playerInventory, ITEM.Instantiate(name, type, data) )

    end
    
    if arg == 1 then

        -- TODO: Remove specified item

    end

    PrintTable(playerInventory)


end )