-- basically just debug shit, having a file for general console commands was not a great idea
local function GetNetworkInt(ply, cmd, args)
    ply:PrintMessage(HUD_PRINTCENTER, ply:GetNWInt(args[1]))
end
concommand.Add("efgm_debug_getint", GetNetworkInt)