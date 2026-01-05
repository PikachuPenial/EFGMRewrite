-- skill systems go here
Stats = {}

function ResetRaidStats(ply)

    ply:SetNWInt("RaidDamageDealt", 0)
    ply:SetNWInt("RaidDamageRecievedPlayers", 0)
    ply:SetNWInt("RaidDamageRecievedFalling", 0)
    ply:SetNWInt("RaidDamageRecievedSelf", 0)
    ply:SetNWInt("RaidHealthHealed", 0)
    ply:SetNWInt("RaidItemsLooted", 0)
    ply:SetNWInt("RaidContainersLooted", 0)
    ply:SetNWInt("RaidKeysUsed", 0)
    ply:SetNWInt("RaidKills", 0)
    ply:SetNWInt("RaidFarthestKill", 0)
    ply:SetNWInt("RaidShotsFired", 0)
    ply:SetNWInt("RaidShotsHit", 0)
    ply:SetNWInt("RaidGrenadesThrown", 0)

end

hook.Add("PlayerDeath", "DeathUpdateStats", function(victim, weapon, attacker)

    if victim:CompareStatus(0) or victim:CompareStatus(3) then return end -- this was counting suicides in the hideout for the longest time oh my god

    -- update victim's stats (cringe lootcel)
    victim:SetNWInt("Deaths", victim:GetNWInt("Deaths", 0) + 1)
    victim:SetNWInt("CurrentKillStreak", 0)
    victim:SetNWInt("CurrentExtractionStreak", 0)

    -- update attacker stats (based and alivepilled)
    if !IsValid(attacker) or victim == attacker or !attacker:IsPlayer() then victim:SetNWInt("Suicides", victim:GetNWInt("Suicides", 0) + 1) return end

    attacker:SetNWInt("Kills", attacker:GetNWInt("Kills", 0) + 1)
    attacker:SetNWInt("CurrentKillStreak", attacker:GetNWInt("CurrentKillStreak", 0) + 1)
    if attacker:GetNWInt("CurrentKillStreak", 0) >= attacker:GetNWInt("BestKillStreak", 0) then attacker:SetNWInt("BestKillStreak", attacker:GetNWInt("CurrentKillStreak", 0)) end

    if victim:LastHitGroup() == HITGROUP_HEAD then attacker:SetNWInt("Headshots", attacker:GetNWInt("Headshots", 0) + 1) end

    local rawDistance = victim:GetPos():Distance(attacker:GetPos())
    local distance = units_to_meters(rawDistance)
    if distance >= attacker:GetNWInt("FarthestKill", 0) then attacker:SetNWInt("FarthestKill", distance) end
    if distance >= attacker:GetNWInt("RaidFarthestKill", 0) then attacker:SetNWInt("RaidFarthestKill", distance) end

end)

hook.Add("EntityTakeDamage", "DamageUpdateStats", function(ply, damageInfo)

    if !ply:IsPlayer() then return end
    if ply:CompareStatus(0) or ply:CompareStatus(3) then return end

    local attacker = damageInfo:GetAttacker()

    if !attacker:IsPlayer() then return end

    local selfDamage = false
    if attacker == ply then selfDamage = true end

    local health = ply:Health() or 100
    local damageAmount = math.min(math.Round(damageInfo:GetDamage()), health)

    if damageAmount > 0 then

        ply:SetNWInt("DamageRecieved", ply:GetNWInt("DamageRecieved") + damageAmount)
        if !selfDamage then ply:SetNWInt("RaidDamageRecievedPlayers", ply:GetNWInt("RaidDamageRecievedPlayers") + damageAmount)
        else ply:SetNWInt("RaidDamageRecievedSelf", ply:GetNWInt("RaidDamageRecievedSelf") + damageAmount) end

    end

    if damageAmount > 0 and !selfDamage then

        attacker:SetNWInt("DamageDealt", attacker:GetNWInt("DamageDealt") + damageAmount)
        attacker:SetNWInt("RaidDamageDealt", attacker:GetNWInt("RaidDamageDealt") + damageAmount)

    end

end)

hook.Add("PlayerExtraction", "ExtractUpdateStats", function(ply, time, isGuranteed)

    ply:SetNWInt("Extractions", ply:GetNWInt("Extractions") + 1)
    ply:SetNWInt("CurrentExtractionStreak", ply:GetNWInt("CurrentExtractionStreak") + 1)
    if ply:GetNWInt("CurrentExtractionStreak") >= ply:GetNWInt("BestExtractionStreak") then ply:SetNWInt("BestExtractionStreak", ply:GetNWInt("CurrentExtractionStreak")) end

end)