
-- manages the players' inventories, ensures "Enjoy no weapons n____r :D" bullshit doesnt happen again

util.AddNetworkString( "UpdatePlayerInventory" )
util.AddNetworkString( "RequestPlayerInventory" )

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
    inventoryTable[ steamID ]:Add("g_2_1", "Pistol", 2, 20)

    PrintTable(inventoryTable[ steamID ].contents)
    

    SendPlayerInventory(ply, steamID)

    timer.Simple(0, function() -- if you think this is unnecessary, try removing it

        LOADOUT.Equip( ply, inventoryTable[ steamID ].contents )
        
    end)

end)