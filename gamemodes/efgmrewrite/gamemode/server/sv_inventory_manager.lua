
-- manages the players' inventories, ensures "Enjoy no weapons n____r :D" bullshit doesnt happen again

util.AddNetworkString( "UpdatePlayerInventory" )
util.AddNetworkString( "RequestPlayerInventory" )

local inventoryTable = {}

hook.Add("PlayerSpawn", "GiveInventory", function(ply)

    -- References the loadout system eventually, rn just for testing

    inventoryTable[ply:SteamID64] = INVG.New(6, 6, 0)

    -- for testing purposes

    inventory:Add("s_prim1", "arc9_eft_auga1", 1, 1)
    inventory:Add("s_sec", "arc9_eft_tt33", 1, 1)

    inventory:Add("g_1_1", "SMG1", 2, 90)
    inventory:Add("g_2_1", "Pistol", 2, 20)

end)