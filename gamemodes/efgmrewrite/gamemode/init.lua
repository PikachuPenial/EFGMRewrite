
isArena = (GetConVar("efgm_arenamode"):GetInt() == 1) or false -- fixed it :D

AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

for _, v in ipairs(file.Find("gamemodes/efgmrewrite/gamemode/shared/*.lua", "GAME", "nameasc")) do
	print("shared/" .. v)
	AddCSLuaFile("shared/" .. v)
	include("shared/" .. v)
end

for _, v in ipairs(file.Find("gamemodes/efgmrewrite/gamemode/client/*.lua", "GAME", "nameasc")) do
	print("client/" .. v)
	AddCSLuaFile("client/" .. v)
end

for _, v in ipairs(file.Find("gamemodes/efgmrewrite/gamemode/server/*.lua", "GAME", "nameasc")) do
	print("server/" .. v)
	include("server/" .. v)
end

-- intel shit

for _, v in ipairs(file.Find("gamemodes/efgmrewrite/gamemode/intel/*.lua", "GAME", "nameasc")) do
	print("intel/" .. v)
	AddCSLuaFile("intel/" .. v)
end

HostID = nil -- will be set if it's a p2p server (holy fucking shit i really didnt set it to nil)

function GM:Initialize()

	print("Escape From Garry's Mod Rewrite has been initialized on " .. game.GetMap())

	RunConsoleCommand("sv_airaccelerate", "2") 		-- what is a titanmod?
	RunConsoleCommand("mp_falldamage", "1") 		-- what is a titanmod? part two, electric boogaloo
	RunConsoleCommand("mp_show_voice_icons", "0") 	-- disable vc icons over heads
	RunConsoleCommand("mp_friendlyfire", "1") 		-- take a wild guess

end

-- player models
local usecPMs = {"models/eft/pmcs/usec_extended_pm.mdl"}
local bearPMs = {"models/eft/pmcs/bear_extended_pm.mdl"}
local allPMs = {"models/eft/pmcs/usec_extended_pm.mdl", "models/eft/pmcs/bear_extended_pm.mdl"}

function GM:PlayerSpawn(ply)

	ply:SetRaidStatus(0, "") -- moving this in hopes that i wont 'fucking break the gamemode again goddamn it'

	ply:SetGravity(.72)
	ply:SetMaxHealth(100)
	ply:SetRunSpeed(215)
	ply:SetWalkSpeed(130)
	ply:SetJumpPower(140)

	ply:SetLadderClimbSpeed(120)
	ply:SetSlowWalkSpeed(95)

	ply:SetCrouchedWalkSpeed(0.45)
	ply:SetDuckSpeed(0.43)
	ply:SetUnDuckSpeed(0.43)

	if ply:GetInfoNum("efgm_faction_preference", 0) == 1 then
		-- USEC prefered
		ply:SetModel(usecPMs[math.random(#usecPMs)])
	elseif ply:GetInfoNum("efgm_faction_preference", 0) == 2 then
		-- BEAR prefered
		ply:SetModel(bearPMs[math.random(#bearPMs)])
	else
		-- no preference
		ply:SetModel(allPMs[math.random(#allPMs)])
	end

	ply:SetBodygroup(0, math.random(0, 4)) -- head
	ply:SetBodygroup(1, math.random(0, 18)) -- body
	ply:SetBodygroup(2, math.random(0, 15)) -- legs
	ply:SetBodygroup(3, math.random(0, 14)) -- face

	ply:SetupHands()
	ply:AddEFlags(EFL_NO_DAMAGE_FORCES) -- disables knockback being applied when damage is taken
	ply:SendLua("RunConsoleCommand('r_cleardecals')") -- clear decals for that extra 2 fps
end

hook.Add("PlayerInitialSpawn", "InitFirstSpawn", function(ply)

	if !ply:IsListenServerHost() then return end
	HostID = tonumber( ply:SteamID64() )

end)

local blacklist = table.Flip( {"arc9_eft_melee_taran", "arc9_eft_melee_6x5", "arc9_eft_melee_wycc", "arc9_eft_melee_a2607", "arc9_eft_melee_a2607d", "arc9_eft_melee_camper", "arc9_eft_melee_crash", "arc9_eft_melee_cultist", "arc9_eft_melee_fulcrum", "arc9_eft_melee_crowbar", "arc9_eft_melee_kiba", "arc9_eft_melee_kukri", "arc9_eft_melee_m2", "arc9_eft_melee_mpl50", "arc9_eft_melee_rebel", "arc9_eft_melee_voodoo", "arc9_eft_melee_sp8", "arc9_eft_melee_hultafors", "arc9_eft_melee_taiga"} )

function GM:PlayerDeath(victim, inflictor, attacker)

	local weps = victim:GetWeapons()
	local ammo = victim:GetAmmo()

	local inventory = INVG.New()

	for k, v in ipairs( weps ) do -- i tried for an entire hour to do this within the entity itself, but alas, it didn't fucking work, i genuinely don't even know anymore

		local item = v:GetClass()

		if blacklist[item] == nil then

			inventory:Add( item, 1, 1 )

		end

	end

    for k, v in pairs( ammo ) do inventory:Add(k, 2, v) end

	if !table.IsEmpty(inventory.contents) then

        local backpack = ents.Create("efgm_backpack")
		backpack:SetPos(victim:GetPos() + Vector(0, 0, 64))
		backpack:Spawn()
		backpack:Activate()
        backpack:SetBagData( inventory, victim.ARC9_AttInv, victim:GetName() )

	end

	-- death sound
	victim:EmitSound(Sound("deathsounds/death" .. math.random(1, 116) .. ".wav"), 80)

	-- when a player suicides
	if !IsValid(attacker) or victim == attacker or !attacker:IsPlayer() then
		victim:PrintMessage(HUD_PRINTCENTER, "You commited suicide")
		return
	end

	local weaponInfo
	local weaponName
	local rawDistance = victim:GetPos():Distance(attacker:GetPos())
	local distance = math.Round(rawDistance * 0.01905) -- convert hammer units to meters

	if (attacker:GetActiveWeapon():IsValid()) then
		weaponInfo = weapons.Get(attacker:GetActiveWeapon():GetClass())
		weaponName = weaponInfo["PrintName"]
	else
		weaponName = ""
	end

	-- death information
	victim:PrintMessage(HUD_PRINTCENTER, attacker:GetName() .. " [" .. attacker:Health() .. " HP] killed you with a " .. weaponName .. " from " .. distance .. "m away")

end

hook.Add("PostPlayerDeath", "PlayerRemoveRaid", function(ply)

	-- respawn timer
	timer.Create(ply:SteamID() .. "respawnTime", 10, 1, function() ply:Spawn() end)
    ply:SetNWBool("RaidReady", false)
    ply:SetNWBool("RaidTeam", "")

end)

hook.Add( "PlayerDeathSound", "RemoveDefaultDeathSound", function() return true end)

function GM:ScalePlayerDamage(target, hitgroup, dmginfo)
	dmginfo:ScaleDamage(1)
end

-- players in the lobby cant take damage
hook.Add( "PlayerShouldTakeDamage", "AntiLobbyKill", function(victim, attacker) 

	return !victim:CompareStatus(0)

end )

-- prevent respawning if under a respawn timer
hook.Add( "PlayerDeathThink", "SpawnLock", function(ply) 
	
	if timer.Exists(ply:SteamID() .. "respawnTime") then
		return false
	end

end )

-- modifies voice chat to be proximity based
hook.Add( "PlayerCanHearPlayersVoice", "ProxVOIP", function(listener,talker)

	if (tonumber(listener:GetPos():Distance(talker:GetPos())) > 1048 ) or !talker:Alive() then -- 20~ meter voice distance, not able to talk while dead but can still hear others
		return false, false
	else
		return true, true
	end

end )

-- light on bullet impact
hook.Add("EntityFireBullets", "BulletLight", function(Entity, Other)

	if IsValid(Entity) then
		local Trace = {}
		Trace.start = Other.Src
		Trace.endpos = Other.Src + (Other.Dir * 2147483647)
		Trace.filter = Entity
		local Result = util.TraceLine(Trace)

		if Result.Hit then

			local FireLight = ents.Create("light_dynamic")
			FireLight:SetKeyValue("distance", 75)
			FireLight:SetKeyValue("_light", 255 .. " " .. 200 .. " " .. 150)
			FireLight:SetPos(Result.HitPos)
			FireLight:Spawn()
			FireLight:Fire("Kill", "", 0.1)

		end

	end

end)