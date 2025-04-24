-- Eat shit penial i stole your titanmod code save manager code
hook.Add("Initialize", "PDataInitialize", function()
    sql.Query( "CREATE TABLE IF NOT EXISTS EFGMPlayerData64 ( SteamID INTEGER, Key TEXT, Value TEXT);" )
end)

-- Important shit (I renamed playerdata64 so it can't conflict with titanmod)
function SetPlayerData(steamID64, key, value)

    local query = sql.Query("SELECT Value FROM EFGMPlayerData64 WHERE SteamID = " .. steamID64 .. " AND Key = " .. SQLStr( key ) .. ";")

    --If we need to make a new PData entry.
    if query == nil then sql.Query("INSERT INTO EFGMPlayerData64 ( SteamID, Key, Value ) VALUES( " .. steamID64 .. ", " .. SQLStr( key ) .. ", " .. SQLStr( value ) .. ");")

    --If we need to update an existing entry.
    else sql.Query("UPDATE EFGMPlayerData64 SET Value = " .. SQLStr( value ) .. " WHERE SteamID = " .. steamID64 .. " AND Key = " .. SQLStr( key ) .. ";") end

end

function GetPlayerData(steamID64, key)

    local query = sql.QueryValue("SELECT Value FROM EFGMPlayerData64 WHERE SteamID = " .. steamID64 .. " AND Key = " .. SQLStr( key ) .. ";")

    return query

end

-- Network shit
function InitializeNetworkBool(ply, key, value)

    local pdata = GetPlayerData(ply:SteamID64(), key)

    ply:SetNWBool(key, tobool( pdata or value or false ))

end

function InitializeNetworkInt(ply, key, value)

    local pdata = GetPlayerData(ply:SteamID64(), key)

    ply:SetNWInt(key, tonumber( pdata or value or 1 ))

end

function InitializeNetworkFloat(ply, key, value)

    local pdata = GetPlayerData(ply:SteamID64(), key)

    ply:SetNWFloat(key, tonumber( pdata or value or 1 ))

end

function InitializeNetworkString(ply, key, value)

    local pdata = GetPlayerData(ply:SteamID64(), key)

    ply:SetNWString(key, pdata or value or "")

end

-- HostID is defined in the init as the listen host's id to free up network variable space
function UninitializeNetworkBool(ply, key)

    SetPlayerData(ply:SteamID64() or HostID, key, ply:GetNWBool(key))

end

function UninitializeNetworkInt(ply, key)

    SetPlayerData(ply:SteamID64() or HostID, key, ply:GetNWInt(key))

end

function UninitializeNetworkFloat(ply, key)

    SetPlayerData(ply:SteamID64() or HostID, key, ply:GetNWFloat(key))

end

function UninitializeNetworkString(ply, key)

    SetPlayerData(ply:SteamID64() or HostID, key, ply:GetNWString(key))

end