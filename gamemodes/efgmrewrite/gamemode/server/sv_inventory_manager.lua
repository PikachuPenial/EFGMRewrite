
-- manages the players' inventories, ensures "Enjoy no weapons n____r :D" bullshit doesnt happen again

util.AddNetworkString( "UpdatePlayerInventory" )
util.AddNetworkString( "RequestPlayerInventory" )

util.AddNetworkString( "MovePlayerInventory" )
util.AddNetworkString( "DropPlayerInventory" )

local inventoryTable = {}

local function SendPlayerInventory(ply, steamID)

    steamID = steamID or ply:SteamID64()

    net.Start( "UpdatePlayerInventory" )
        net.WriteTable( inventoryTable[ steamID ].contents )
    net.Send(ply)

end

hook.Add("PlayerSpawn", "GiveInventory", function(ply)

    -- References the loadout system eventually, rn just for testing

    local steamID =  ply:SteamID64()

    inventoryTable[ steamID ] = INVG.New(6, 6, 0)

    -- for testing purposes

    inventoryTable[ steamID ]:Add("s_prim1", "arc9_eft_aks74u", 1, 1)
    inventoryTable[ steamID ]:Add("s_sec", "arc9_eft_tt33", 1, 1)

    inventoryTable[ steamID ]:Add("g_1_1", "SMG1", 2, 90)
    inventoryTable[ steamID ]:Add("g_2_1", "Pistol", 2, 30)

    SendPlayerInventory(ply, steamID)

    timer.Simple(0, function() -- if you think this is unnecessary, try removing it

        LOADOUT.Equip( ply, inventoryTable[ steamID ].contents )

    end)

end)

net.Receive("RequestPlayerInventory", function(len, ply)

    SendPlayerInventory(ply, ply:SteamID64())

end)

net.Receive("MovePlayerInventory", function(len, ply)

    local oldPos = net.ReadString()
    local newPos = net.ReadString()
    local count = net.ReadUInt(32)

    local steamID = ply:SteamID64()

    inventoryTable[ steamID ] = inventoryTable[ steamID ] or INVG.New(6, 6, 0)

    count = math.Clamp( count, 1, inventoryTable[ steamID ].contents[ oldPos ].count )

    -- makes sure some bs isnt happening
    if inventoryTable[ steamID ].contents[ oldPos ] == nil then print( "old position doesnt exist" ) PrintTable( inventoryTable[ steamID ].contents ) return end
    if inventoryTable[ steamID ].contents[ newPos ] != nil then print( "new position is occupied" ) PrintTable( inventoryTable[ steamID ].contents ) return end

    -- eventually add check if new position exceeds boundaries but idgaf rn

    inventoryTable[ steamID ]:Move( oldPos, newPos, count )

    print( "Moved item successfully" )

end)

net.Receive("DropPlayerInventory", function(len, ply)

    local pos = net.ReadString()
    local count = net.ReadUInt(32)

    local steamID = ply:SteamID64()

    inventoryTable[ steamID ] = inventoryTable[ steamID ] or INVG.New(6, 6, 0)

    -- makes sure some bs isnt happening
    if inventoryTable[ steamID ].contents[ pos ] == nil then print( "position doesnt exist" ) PrintTable( inventoryTable[ steamID ].contents ) return end

    inventoryTable[ steamID ]:Remove( pos, math.Clamp( count, 1, inventoryTable[ steamID ].contents[ pos ].count ) )

    -- drop logic eventually

    print( "Dropped item successfully" )

end)