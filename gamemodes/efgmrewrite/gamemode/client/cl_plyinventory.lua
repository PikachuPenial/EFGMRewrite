-- shit here


concommand.Add("efgm_update_inventory", function(ply, cmd, args)

    net.Start("RequestPlayerInventory")
    net.SendToServer()

end)

net.Receive("UpdatePlayerInventory", function(len, ply)

    PrintTable( net.ReadTable() )

end)