
-- used exclusively for testing dumbass things for penal dont ask

concommand.Add("tm_doshat", function(ply, cmd, args)
    print( sql.Query("SELECT sum1 - sum2 FROM (SELECT Value as sum1 FROM PlayerData64 WHERE Key = 'playerKills') INNER JOIN (SELECT Value as sum2 FROM PlayerData64 WHERE Key = 'playerDeaths');") )
end)

