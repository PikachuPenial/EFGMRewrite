
-- basically just debug shit, having a file for general console commands was not a great idea

local function ChangeStatus(ply, cmd, args)

    if args[1] == nil then return end

    local status = tonumber( args[1] )

    ply:SetRaidStatus(status)

end
concommand.Add("efgm_debug_changeraidstatus", ChangeStatus)

local function GetStatus(ply, cmd, args)

    print( ply:GetRaidStatus() )

end
concommand.Add("efgm_debug_getraidstatus", GetStatus)

local function GetRaidInfo(ply, cmd, args)

    print(GetGlobalInt("RaidStatus") .. " " .. GetGlobalInt("RaidTimeLeft"))

end
concommand.Add("efgm_debug_getraidinfo", GetRaidInfo)

local function DebugStartRaid(ply, cmd, args)

    RAID:StartRaid()

    GetRaidInfo()

end
concommand.Add("efgm_debug_startraid", DebugStartRaid)

local function DebugEndRaid(ply, cmd, args)

    -- what i said on GEFRST 999x

    RAID:EndRaid()

    GetRaidInfo()

end
concommand.Add("efgm_debug_endraid", DebugEndRaid)

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