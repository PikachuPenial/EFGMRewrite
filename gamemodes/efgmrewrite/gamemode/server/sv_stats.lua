-- skill systems go here
Stats = {}

function Stats.GetAll(ply)
    local tbl = {}

    -- stats
    tbl["FreshWipe"] = ply:GetNWBool("FreshWipe")
    tbl["Level"] = ply:GetNWInt("Level")
    tbl["Experience"] = ply:GetNWInt("Experience")
    tbl["MoneyEarned"] = ply:GetNWInt("MoneyEarned")
    tbl["MoneySpent"] = ply:GetNWInt("MoneySpent")
    tbl["Time"] = ply:GetNWInt("Time")
    tbl["StashValue"] = ply:GetNWInt("StashValue")

    -- combat
    tbl["Kills"] = ply:GetNWInt("Kills")
    tbl["Deaths"] = ply:GetNWInt("Deaths")
    tbl["Suicides"] = ply:GetNWInt("Suicides")
    tbl["DamageDealt"] = ply:GetNWInt("DamageDealt")
    tbl["DamageRecieved"] = ply:GetNWInt("DamageRecieved")
    tbl["DamageHealed"] = ply:GetNWInt("DamageHealed")
    tbl["Headshots"] = ply:GetNWInt("Headshots")
    tbl["FarthestKill"] = ply:GetNWInt("FarthestKill")

    -- raids
    tbl["Extractions"] = ply:GetNWInt("Extractions")
    tbl["Quits"] = ply:GetNWInt("Quits")
    tbl["RaidsPlayed"] = ply:GetNWInt("RaidsPlayed")

    -- streaks
    tbl["CurrentKillStreak"] = ply:GetNWInt("CurrentKillStreak")
    tbl["BestKillStreak"] = ply:GetNWInt("BestKillStreak")
    tbl["CurrentExtractionStreak"] = ply:GetNWInt("CurrentExtractionStreak")
    tbl["BestExtractionStreak"] = ply:GetNWInt("BestExtractionStreak")

    return tbl
end
concommand.Add("efgm_get_stats", function(ply, cmd, args)
    PrintTable(Stats.GetAll(ply))
end)

-- hooks yippee
hook.Add("PlayerInitialSpawn", "PlayerInitializeStats", function(ply)
    SetupPlayerData(ply)
end)

hook.Add("PlayerDisconnected", "PlayerUninitializeStats", function(ply)
    ply:SetNWBool("FreshWipe", false)

    if !ply:CompareStatus(0) then
        ply:SetNWInt("Quits", ply:GetNWInt("Quits", 0) + 1)
    end

	SavePlayerData(ply)
end)

hook.Add("ShutDown", "ServerUninitializeStats", function(ply)
	for k, v in pairs(player.GetHumans()) do
		SavePlayerData(v)
	end
end)

hook.Add("PlayerDeath", "DeathUpdateStats", function(victim, weapon, attacker)
    -- update victim's stats (cringe lootcel)
    victim:SetNWInt("Deaths", victim:GetNWInt("Deaths") + 1)

    -- update attacker stats (based and alivepilled)
    if attacker == victim then return end

    attacker:SetNWInt("Kills", attacker:GetNWInt("Kills") + 1)
end)

hook.Add("EntityTakeDamage", "DamageUpdateStats", function(ply, damageInfo)
    if !ply:IsPlayer() then return end

    local damageAmount = damageInfo:GetDamage()

    if damageAmount < 0 then -- if the player healed (this probably aint even gonna work)
        ply:SetNWInt("DamageHealed", ply:GetNWInt("DamageHealed") - damageAmount)
    elseif damageAmount > 0 then
        ply:SetNWInt("DamageRecieved", ply:GetNWInt("DamageRecieved") + damageAmount)
    end

    local attacker = damageInfo:GetAttacker()

    if !attacker:IsPlayer() then return end
    if attacker == ply then return end

    if damageAmount < 0 then -- if the attacker healed another player somehow
        attacker:SetNWInt("DamageHealed", attacker:GetNWInt("DamageHealed") - damageAmount)
    elseif damageAmount > 0 then
        attacker:SetNWInt("DamageDealt", attacker:GetNWInt("DamageDealt") + damageAmount)
    end
end)

hook.Add("PlayerExtraction", "ExtractUpdateStats", function(ply, time, isGuranteed)
    ply:SetNWInt("Extractions", ply:GetNWInt("Extractions") + 1)
end)