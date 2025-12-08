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
    tbl["HealthHealed"] = ply:GetNWInt("HealthHealed")
    tbl["ShotsFired"] = ply:GetNWInt("ShotsFired")
    tbl["ShotsHit"] = ply:GetNWInt("ShotsHit")
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

function ResetRaidStats(ply)

    ply:SetNWInt("RaidDamageDealt", 0)
    ply:SetNWInt("RaidDamageRecievedPlayers", 0)
    ply:SetNWInt("RaidDamageRecievedFalling", 0)
    ply:SetNWInt("RaidHealthHealed", 0)
    ply:SetNWInt("RaidItemsLooted", 0)
    ply:SetNWInt("RaidContainersLooted", 0)
    ply:SetNWInt("RaidKills", 0)
    ply:SetNWInt("RaidShotsFired", 0)
    ply:SetNWInt("RaidShotsHit", 0)

end

hook.Add("PlayerDeath", "DeathUpdateStats", function(victim, weapon, attacker)

    -- update victim's stats (cringe lootcel)
    victim:SetNWInt("Deaths", victim:GetNWInt("Deaths") + 1)

    -- update attacker stats (based and alivepilled)
    if attacker == victim then return end

    attacker:SetNWInt("Kills", attacker:GetNWInt("Kills") + 1)

end)

hook.Add("EntityTakeDamage", "DamageUpdateStats", function(ply, damageInfo)

    if !ply:IsPlayer() then return end

    local attacker = damageInfo:GetAttacker()

    if !attacker:IsPlayer() then return end
    if attacker == ply then return end

    local damageAmount = math.Round(damageInfo:GetDamage())

    if damageAmount > 0 then

        ply:SetNWInt("DamageRecieved", ply:GetNWInt("DamageRecieved") + math.min(damageAmount, 100))
        ply:SetNWInt("RaidDamageRecievedPlayers", ply:GetNWInt("RaidDamageRecievedPlayers") + math.min(damageAmount, 100))

    end

    if damageAmount > 0 then

        attacker:SetNWInt("DamageDealt", attacker:GetNWInt("DamageDealt") + math.min(damageAmount, 100))
        attacker:SetNWInt("RaidDamageDealt", attacker:GetNWInt("RaidDamageDealt") + math.min(damageAmount, 100))

    end

end)

hook.Add("PlayerExtraction", "ExtractUpdateStats", function(ply, time, isGuranteed)

    ply:SetNWInt("Extractions", ply:GetNWInt("Extractions") + 1)

end)