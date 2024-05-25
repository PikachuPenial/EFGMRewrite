-- shit here

local inventory = INVG.New(6, 6, 0)

-- for testing purposes

inventory:Add("s_prim1", "arc9_eft_auga1", 1, 1)
inventory:Add("s_sec", "arc9_eft_tt33", 1, 1)

inventory:Add("g_1_1", "SMG1", 2, 90)
inventory:Add("g_2_1", "Pistol", 2, 20)

concommand.Add("efgm_update_inventory", function(ply, cmd, args)

    net.Start("RequestPlayerInventory")
    net.SendToServer()

end)

net.Receive("UpdatePlayerInventory", function(len, ply)

    

end)