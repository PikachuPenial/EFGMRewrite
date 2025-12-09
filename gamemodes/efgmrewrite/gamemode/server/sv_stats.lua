-- skill systems go here
Stats = {}

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
    victim:SetNWInt("CurrentKillStreak", 0)
    victim:SetNWInt("CurrentExtractionStreak", 0)

    -- update attacker stats (based and alivepilled)
    if attacker == victim then victim:SetNWInt("Suicides", victim:GetNWInt("Suicides") + 1) return end

    attacker:SetNWInt("Kills", attacker:GetNWInt("Kills") + 1)
    attacker:SetNWInt("CurrentKillStreak", attacker:GetNWInt("CurrentKillStreak") + 1)
    if attacker:GetNWInt("CurrentKillStreak") >= attacker:GetNWInt("BestKillStreak") then attacker:SetNWInt("BestKillStreak", attacker:GetNWInt("CurrentKillStreak")) end

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
    ply:SetNWInt("CurrentExtractionStreak", ply:GetNWInt("CurrentExtractionStreak") + 1)
    if ply:GetNWInt("CurrentExtractionStreak") >= ply:GetNWInt("BestExtractionStreak") then ply:SetNWInt("BestExtractionStreak", ply:GetNWInt("CurrentExtractionStreak")) end

end)