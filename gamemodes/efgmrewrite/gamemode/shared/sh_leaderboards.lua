LEADERBOARDS = {
    ["Level"] = "Level",
    ["Money Earned"] = "MoneyEarned",
    ["Money Spent"] = "MoneySpent",
    ["Time Played"] = "Time",
    ["Stash Value"] = "StashValue",
    ["Kills"] = "Kills",
    ["Deaths"] = "Deaths",
    ["Suicides"] = "Suicides",
    ["Damage Dealt"] = "DamageDealt",
    ["Damage Recieved"] = "DamageRecieved",
    ["Health Healed"] = "HealthHealed",
    ["Shots Fired"] = "ShotsFired",
    ["Shots Hit"] = "ShotsHit",
    ["Headshots"] = "Headshots",
    ["Farthest Kill"] = "FarthestKill",
    ["Raids Played"] = "RaidsPlayed",
    ["Extractions"] = "Extractions",
    ["Quits"] = "Quits",
    ["Duels Played"] = "DuelsPlayed",
    ["Duels Won"] = "DuelsWon",
    ["Best Extraction Streak"] = "BestExtractionStreak",
    ["Best Kill Streak"] = "BestKillStreak",
    ["Items Looted"] = "ItemsLooted",
    ["Containers Opened"] = "ContainersLooted"
}

if SERVER then

    util.AddNetworkString("GrabLeaderboardData")
    util.AddNetworkString("SendLeaderboardData")

    local LEADERBOARDSTRINGS = {}

    hook.Add("InitPostEntity", "LeaderboardInit", function()

        for text, board in pairs(LEADERBOARDS) do

            local str = util.TableToJSON(sql.Query("SELECT SteamID, SteamName, Value FROM EFGMPlayerData64 WHERE Key = " .. SQLStr(board) .. " ORDER BY Value + 0 DESC LIMIT 100;"))

            str = util.Compress(str)
            str = util.Base64Encode(str, true)

            LEADERBOARDSTRINGS[board] = str

        end

    end)

    net.Receive("GrabLeaderboardData", function(len, ply)

        local key = net.ReadString()

        local str = LEADERBOARDSTRINGS[key] or ""

        net.Start("SendLeaderboardData", true)
        net.WriteString(str)
        net.Send(ply)

    end )

end