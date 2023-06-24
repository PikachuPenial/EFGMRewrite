
-- used exclusively for testing dumbass things for penal dont ask

concommand.Add("tm_doshat", function(ply, cmd, args)
    print( sql.Query("SELECT sum1 - sum2 FROM (SELECT Value as sum1 FROM PlayerData64 WHERE Key = 'playerKills') INNER JOIN (SELECT Value as sum2 FROM PlayerData64 WHERE Key = 'playerDeaths');") )
end)

local function GetPlayerKDTable()
    -- Query to fetch the necessary data and calculate KD ratio
    local query = "SELECT P.SteamID AS steamid, (SELECT Value FROM PlayerData64 WHERE steamid = P.SteamID AND Key = 'playerKills') AS Kills, (SELECT Value FROM PlayerData64 WHERE steamid = P.SteamID AND Key = 'playerDeaths') AS Deaths FROM PlayerData64 P LIMIT 50;"
  
    -- Execute the query and retrieve the results
    local result = sql.Query(query)
  
    -- Check if the query was successful and return the result
    if result then
        return result
    else
        -- Handle the error if the query fails
        print("Error executing SQL query: " .. sql.LastError())
        return {}
    end
end

[[
    SELECT P.steamid AS steamid, p.steamname
    AS steamname,
    CAST((SELECT value FROM PlayerData64 WHERE steamid = P.steamid AND key = 'playerKills') as float) /
    (SELECT value FROM PlayerData64 WHERE steamid = P.steamid AND key = 'playerDeaths')
    AS [KD Ratio]
    FROM PlayerData64 P
    GROUP BY [KD Ratio];
]]