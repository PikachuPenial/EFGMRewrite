function GM:Initialize()

    sql.Query( "CREATE TABLE IF NOT EXISTS PlayerData64 ( SteamID INTEGER, Key TEXT, Value TEXT);" )

    sql.LastError()

end

-- Important functions

function SetPlayerData(steamID64, key, value)

    local query = sql.Query( "SELECT Value FROM PlayerData64 WHERE SteamID = " .. steamID64 .. " AND Key = " .. SQLStr( key ) .. ";" )

    sql.LastError()

    if query == nil then

        -- If we need to make a new PData entry

        sql.Query( "INSERT INTO PlayerData64 ( SteamID, Key, Value ) VALUES( " .. steamID64 .. ", " .. SQLStr( key ) .. ", " .. SQLStr( value ) .. ");" )

    end

    if query != nil then

        -- If we need to update an existing entry

        sql.Query( "UPDATE PlayerData64 SET Value = " .. SQLStr( value ) .. " WHERE SteamID = " .. steamID64 .. " AND Key = " .. SQLStr( key ) .. ";" )

    end

    sql.LastError()

end

function GetPlayerData(steamID64, key)

    local query = sql.QueryValue( "SELECT Value FROM PlayerData64 WHERE SteamID = " .. steamID64 .. " AND Key = " .. SQLStr( key ) .. ";" )

    sql.LastError()

    return query

end

-- Network stuff

-- shortening of whatever the fuck happened in the init.lua file of the og efgm, that shit did NOT need to be 919 lines ong
function InitializeNetworkBool(ply, key, value)
    local v = tobool(value)
    local pdata = tobool(ply:GetPData(key))
    if pdata == nil then
		ply:SetNWBool(key, v)
	else
		ply:SetNWBool(key, pdata)
	end
end

function InitializeNetworkInt(ply, key, value)
    local v = tonumber(value)
    local pdata = tonumber(ply:GetPData(key))
    if pdata == nil then
		ply:SetNWInt(key, v)
	else
		ply:SetNWInt(key, pdata)
	end
end

function InitializeNetworkFloat(ply, key, value)
    local v = tonumber(value)
    local pdata = tonumber(ply:GetPData(key))
    if pdata == nil then
		ply:SetNWFloat(key, v)
	else
		ply:SetNWFloat(key, pdata)
	end
end

function InitializeNetworkString(ply, key, value)
    local pdata = ply:GetPData(key)
    if pdata == nil then
		ply:SetNWString(key, value)
	else
		ply:SetNWString(key, pdata)
	end
end

-- basically the same thing but with leaving

function UninitializeNetworkBool(ply, key)
    ply:SetPData(key, ply:GetNWBool(key))
end

function UninitializeNetworkInt(ply, key)
    ply:SetPData(key, ply:GetNWInt(key))
end

function UninitializeNetworkFloat(ply, key)
    ply:SetPData(key, ply:GetNWFloat(key))
end

function UninitializeNetworkString(ply, key)
    ply:SetPData(key, ply:GetNWString(key))
end

-- Temporary debug shit

function DumpTable(tableName)

    local query = sql.Query( "SELECT * FROM " .. SQLStr( tableName ) .. ";" )

    sql.LastError()

    return query
end
concommand.Add("efgm_debug_dumpraidtable", DumpTable)

function DropTable()

    sql.Query( "DROP TABLE PlayerData64;" )

    sql.Query( "CREATE TABLE IF NOT EXISTS PlayerData64 ( SteamID INTEGER, Key TEXT, Value TEXT);" )

end
concommand.Add("efgm_debug_deleteraidtable", DropTable)
