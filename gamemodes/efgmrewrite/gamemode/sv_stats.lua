-- skill systems go here

Stats = {}

-- stat convenience functions

function Stats.InitializeAll(ply)

    -- stats
    InitializeNetworkBool(ply, "FreshWipe", true) -- false if player has logged on once this wipe
    InitializeNetworkInt(ply, "Level", 0)
    InitializeNetworkInt(ply, "Experience", 0)
	InitializeNetworkInt(ply, "MoneyEarned", 0) -- all money earned
	InitializeNetworkInt(ply, "MoneySpent", 0) -- all money spent (money would just be MoneyEarned - MoneySpent)
	InitializeNetworkInt(ply, "Time", 0) -- playtime in minutes

    -- combat
	InitializeNetworkInt(ply, "Kills", 0)
	InitializeNetworkInt(ply, "Deaths", 0)
	InitializeNetworkInt(ply, "DamageGiven", 0)
	InitializeNetworkInt(ply, "DamageRecieved", 0)
	InitializeNetworkInt(ply, "DamageHealed", 0)

    -- raids
	InitializeNetworkInt(ply, "Extractions", 0)
	InitializeNetworkInt(ply, "Quits", 0)
	InitializeNetworkInt(ply, "FullRaids", 0) -- the amount of full raids played, counted if you join before the first minute and stay until the raid ends

end

function Stats.UninitializeAll(ply)

    -- stats
    UninitializeNetworkBool(ply, "FreshWipe")
    UninitializeNetworkInt(ply, "Level")
    UninitializeNetworkInt(ply, "Experience")
	UninitializeNetworkInt(ply, "MoneyEarned")
	UninitializeNetworkInt(ply, "MoneySpent")
	UninitializeNetworkInt(ply, "Time")

    -- combat
	UninitializeNetworkInt(ply, "Kills")
	UninitializeNetworkInt(ply, "Deaths")
	UninitializeNetworkInt(ply, "DamageGiven")
	UninitializeNetworkInt(ply, "DamageRecieved")
	UninitializeNetworkInt(ply, "DamageHealed")

    -- raids
	UninitializeNetworkInt(ply, "Extractions")
	UninitializeNetworkInt(ply, "Quits")
	UninitializeNetworkInt(ply, "FullRaids")

end

function Stats.GetAll(ply)

    local tbl = {}

    -- stats
    tbl["FreshWipe"] = ply:GetNWBool("FreshWipe")
    tbl["Level"] = ply:GetNWInt("Level")
    tbl["Experience"] = ply:GetNWInt("Experience")
    tbl["MoneyEarned"] = ply:GetNWInt("MoneyEarned")
    tbl["MoneySpent"] = ply:GetNWInt("MoneySpent")
    tbl["Time"] = ply:GetNWInt("Time")

    -- combat
    tbl["Kills"] = ply:GetNWInt("Kills")
    tbl["Deaths"] = ply:GetNWInt("Deaths")
    tbl["DamageGiven"] = ply:GetNWInt("DamageGiven")
    tbl["DamageRecieved"] = ply:GetNWInt("DamageRecieved")
    tbl["DamageHealed"] = ply:GetNWInt("DamageHealed")

    -- raids
    tbl["Extractions"] = ply:GetNWInt("Extractions")
    tbl["Quits"] = ply:GetNWInt("Quits")
    tbl["FullRaids"] = ply:GetNWInt("FullRaids")

    return tbl

end
concommand.Add("efgm_get_stats", function(ply, cmd, args)

    PrintTable(Stats.GetAll(ply))

end)

-- hooks yippee

hook.Add("PlayerInitialSpawn", "PlayerInitializeStats", function(ply)

	-- setup nwints and custom pdatas (these only use regular pdata for now)

    Stats.InitializeAll(ply)

end)

hook.Add("PlayerDisconnected", "PlayerUninitializeStats", function(ply)

	Stats.UninitializeAll(ply)

end)

hook.Add("ShutDown", "ServerUninitializeStats", function(ply)-- the wiki gives a scary warning about steamid64 not working with this hook so if i ever implement better pdata thats gonna be a problem

	for k, v in pairs(player.GetHumans()) do

		Stats.UninitializeAll(v)

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
        attacker:SetNWInt("DamageGiven", attacker:GetNWInt("DamageGiven") + damageAmount)
    end

end)

hook.Add("PlayerExtraction", "ExtractUpdateStats", function(ply, time, isGuranteed)

    ply:SetNWInt("Extractions", ply:GetNWInt("Extractions") + 1)

end)