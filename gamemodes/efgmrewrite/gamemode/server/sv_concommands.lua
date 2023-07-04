
-- basically just debug shit, having a file for general console commands was not a great idea


local function GetNetworkInt(ply, cmd, args)

    ply:PrintMessage(HUD_PRINTCENTER, ply:GetNWInt(args[1]))

end
concommand.Add("efgm_debug_getint", GetNetworkInt)

concommand.Add("efgm_debug_getinventory", function(ply, cmd, args)

    local weps = ply:GetWeapons()
    local ammo = {}
    local tbl = ply:GetAmmo()

    for k, v in pairs(tbl) do
        
        ammo[game.GetAmmoName(k)] = v

    end

    print("Weapons:")
    PrintTable(weps)
    print("Ammo:")
    PrintTable(ammo)

end)