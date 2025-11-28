isArena = (GetConVar("efgm_arenamode"):GetInt() == 1) or false -- fixed it :D

AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")
AddCSLuaFile("!config.lua")
include("!config.lua")

for _, v in ipairs(file.Find("gamemodes/efgmrewrite/gamemode/shared/*.lua", "GAME", "nameasc")) do

	AddCSLuaFile("shared/" .. v)
	include("shared/" .. v)

end

for _, v in ipairs(file.Find("gamemodes/efgmrewrite/gamemode/client/*.lua", "GAME", "nameasc")) do

	AddCSLuaFile("client/" .. v)

end

for _, v in ipairs(file.Find("gamemodes/efgmrewrite/gamemode/server/*.lua", "GAME", "nameasc")) do

	include("server/" .. v)

end

for _, v in ipairs(file.Find("gamemodes/efgmrewrite/gamemode/intel/*.lua", "GAME", "nameasc")) do

	AddCSLuaFile("intel/" .. v)

end

util.AddNetworkString("PlayerReinstantiateInventory")

HostID = nil -- will be set if it's a p2p server (holy fucking shit i really didnt set it to nil)

function GM:Initialize()

	print("Escape From Garry's Mod Rewrite has been initialized on " .. game.GetMap())

	RunConsoleCommand("sv_airaccelerate", "1") 		-- what is a titanmod?
	RunConsoleCommand("mp_falldamage", "1") 		-- what is a titanmod? part two, electric boogaloo
	RunConsoleCommand("mp_show_voice_icons", "0") 	-- disable vc icons over heads

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

	ply:SetCrouchedWalkSpeed(0.46)
	ply:SetDuckSpeed(0.4)
	ply:SetUnDuckSpeed(0.4)

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
	ply:SetCrouched(false)
	ply:SetEnteringCrouch(false)
	ply:SetExitingCrouch(false)
	ply:SetNW2Bool("DoStep", false)

end

hook.Add("PlayerInitialSpawn", "InitFirstSpawn", function(ply)

	if !ply:IsListenServerHost() then return end
	HostID = tonumber(ply:SteamID64())

end)

util.AddNetworkString("CreateDeathInformation")
function GM:PlayerDeath(victim, inflictor, attacker)

	if !victim:CompareStatus(0) then

		UnequipAll(victim) -- unload all equipped items into inventory, helps clean this all up

		if !table.IsEmpty(victim.inventory) then

			local backpack = ents.Create("efgm_backpack")
			backpack:SetPos(victim:GetPos() + Vector(0, 0, 64))
			backpack:Spawn()
			backpack:Activate()
			backpack:SetBagData(victim.inventory, victim:GetName() .. "'S CORPSE")

		end

		ReinstantiateInventory(victim)
		net.Start("PlayerReinstantiateInventory", false)
		net.Send(victim)

	end

	-- death sound
	victim:EmitSound(Sound("deathsounds/death" .. math.random(1, 116) .. ".wav"), math.random(65, 80)) -- holy shit thats a few
	victim:SetNWInt("RaidTime", 0)

	-- when a player suicides
	if !IsValid(attacker) or victim == attacker or !attacker:IsPlayer() then

		local xpMult = 0.5

		net.Start("CreateDeathInformation")
		net.WriteFloat(xpMult)
		net.WriteInt(victim:GetNWInt("RaidTime", 0), 16)
		net.WriteInt(math.Round(victim:GetNWFloat("ExperienceTime", 0)), 16)
		net.WriteInt(victim:GetNWInt("ExperienceCombat", 0), 16)
		net.WriteInt(victim:GetNWInt("ExperienceExploration", 0), 16)
		net.WriteInt(victim:GetNWInt("ExperienceLooting", 0), 16)
		net.WriteInt(victim:GetNWInt("ExperienceBonus", 0), 16)
		net.WriteEntity(victim)
		net.WriteString("")
		net.WriteInt(0, 16)
		net.Send(victim)

		ApplyPlayerExperience(victim, 0.5)
		return

	end

	local rawDistance = victim:GetPos():Distance(attacker:GetPos())
	local distance = math.Round(rawDistance * 0.01905) -- convert hammer units to meters

	local xpMult = 0.5

	net.Start("CreateDeathInformation")
	net.WriteFloat(xpMult)
	net.WriteInt(victim:GetNWInt("RaidTime", 0), 16)
	net.WriteInt(math.Round(victim:GetNWFloat("ExperienceTime", 0)), 16)
	net.WriteInt(victim:GetNWInt("ExperienceCombat", 0), 16)
	net.WriteInt(victim:GetNWInt("ExperienceExploration", 0), 16)
	net.WriteInt(victim:GetNWInt("ExperienceLooting", 0), 16)
	net.WriteInt(victim:GetNWInt("ExperienceBonus", 0), 16)
	net.WriteEntity(attacker)
	net.WriteString(attacker:GetActiveWeapon():GetClass())
	net.WriteInt(distance, 16)
	net.Send(victim)

	attacker:SetNWInt("ExperienceCombat", attacket:GetNWInt("ExperienceCombat") + 300)

	ApplyPlayerExperience(victim, 0.5)

end

hook.Add("RaidTimerTick", "RaidTimeExperience", function(ply)

	for k, v in ipairs(player.GetHumans()) do

		if !v:CompareStatus(0) then

			v:SetNWFloat("ExperienceTime", v:GetNWFloat("ExperienceTime") + 0.5)
			v:SetNWInt("RaidTime", v:GetNWInt("RaidTime", 0) + 1)
			v:SetNWInt("Time", v:GetNWInt("Time") + 1)

		end

	end

end)

hook.Add("PostPlayerDeath", "PlayerRemoveRaid", function(ply)

	-- respawn timer
	timer.Create(ply:SteamID() .. "respawnTime", respawnTime, 1, function() end)
	ply:SetNWBool("RaidReady", false)

end)

util.AddNetworkString("PlayerRequestRespawn")
net.Receive("PlayerRequestRespawn", function(len, ply)

	if !timer.Exists(ply:SteamID() .. "respawnTime") then ply:Spawn() end

end )

hook.Add("PlayerDeathSound", "RemoveDefaultDeathSound", function()

	return true

end)

-- function GM:ScalePlayerDamage(target, hitgroup, dmginfo)

	-- dmginfo:ScaleDamage(1)

-- end

-- more lethal fall damage
hook.Add("GetFallDamage", "FallDmgCalc", function(ply, speed)

	return speed / 6

end)

-- hit flinch
hook.Add("EntityTakeDamage", "HitFlinch", function(target, dmginfo)

	if IsValid(target) and target:IsPlayer() then

		util.ScreenShake(target:GetPos(), 1, 3, 0.1, 500)

	end

end)

-- players in the lobby cant take damage
hook.Add("PlayerShouldTakeDamage", "AntiLobbyKill", function(victim, attacker)

	return !victim:CompareStatus(0)

end )

-- prevent respawning if under a respawn timer
hook.Add("PlayerDeathThink", "SpawnLock", function(ply)

	if timer.Exists(ply:SteamID() .. "respawnTime") then return false end

end )

-- modifies voice chat to be proximity based
hook.Add("PlayerCanHearPlayersVoice", "ProxVOIP", function(listener,talker)

	if (tonumber(listener:GetPos():Distance(talker:GetPos())) > 1048 ) or !talker:Alive() then -- 20~ meter voice distance, not able to talk while dead but can still hear others

		return false, false

	else

		return true, true

	end

end )

-- temp. health regen
local healthRegenSpeed = 1.5
local healthRegenDamageDelay = 20
local function Regeneration()

	for _, ply in pairs(player.GetAll()) do

		if ply:Alive() then

			if (ply:Health() < (ply.LastHealth or 0)) then ply.HealthRegenNext = CurTime() + healthRegenDamageDelay end

			if (CurTime() > (ply.HealthRegenNext or 0)) then

				ply.HealthRegen = (ply.HealthRegen or 0) + FrameTime()
				if (ply.HealthRegen >= healthRegenSpeed) then

					local add = math.floor(ply.HealthRegen / healthRegenSpeed)
					ply.HealthRegen = ply.HealthRegen - (add * healthRegenSpeed)

					if (ply:Health() < 100 or healthRegenSpeed < 0) then

						ply:SetHealth(math.min(ply:Health() + add, 100))

					end

				end

			end

			ply.LastHealth = ply:Health()

		end

	end

end
hook.Add("Think", "HealthRegen", Regeneration)

-- light on bullet impact
-- hook.Add("EntityFireBullets", "BulletLight", function(Entity, Other)
	-- if IsValid(Entity) then
		-- local Trace = {}
		-- Trace.start = Other.Src
		-- Trace.endpos = Other.Src + (Other.Dir * 2147483647)
		-- Trace.filter = Entity
		-- local Result = util.TraceLine(Trace)

		-- if Result.Hit then
			-- local FireLight = ents.Create("light_dynamic")
			-- FireLight:SetKeyValue("distance", 50)
			-- FireLight:SetKeyValue("_light", 255 .. " " .. 200 .. " " .. math.random(120, 180))
			-- FireLight:SetPos(Result.HitPos)
			-- FireLight:Spawn()
			-- FireLight:Fire("Kill", "", 0.075)
		-- end
	-- end
-- end)

function ApplyPlayerExperience(ply, mult)

	local exp = 0

	exp = exp + math.Round(ply:GetNWFloat("ExperienceTime", 0) * mult, 0)
	exp = exp + math.Round(ply:GetNWInt("ExperienceCombat", 0) * mult, 0)
	exp = exp + math.Round(ply:GetNWInt("ExperienceExploration", 0) * mult, 0)
	exp = exp + math.Round(ply:GetNWInt("ExperienceLooting", 0) * mult, 0)
	exp = exp + math.Round(ply:GetNWInt("ExperienceBonus", 0) * mult, 0)

	ply:SetNWInt("Experience", ply:GetNWInt("Experience", 0) + exp)

	local curExp = ply:GetNWInt("Experience")
	local curLvl = ply:GetNWInt("Level")

	while (curExp >= ply:GetNWInt("ExperienceToNextLevel")) do

		curExp = curExp - ply:GetNWInt("ExperienceToNextLevel")
		ply:SetNWInt("Level", curLvl + 1)
		ply:SetNWInt("Experience", curExp)

		for k, v in ipairs(levelArray) do

			if (curLvl + 1) == k then ply:SetNWInt("ExperienceToNextLevel", v) end

		end

	end

	ply:SetNWFloat("ExperienceTime", 0)
	ply:SetNWInt("ExperienceCombat", 0)
	ply:SetNWInt("ExperienceExploration", 0)
	ply:SetNWInt("ExperienceLooting", 0)
	ply:SetNWInt("ExperienceBonus", 0)

end

equipWeaponName = ""

-- put weapons picked up into players inventory
hook.Add("PlayerCanPickupWeapon", "InventoryWeaponPickup", function(ply, wep)

	local wepClass = wep:GetClass()

	local data = {}

	local atts = table.Copy(wep.Attachments)
	local str = GenerateAttachString(atts)
	data.att = str

	data.count = 1

	tempEquipWeaponName = equipWeaponName
	equipWeaponName = ""

	if wepClass != tempEquipWeaponName then

		AddItemToInventory(ply, wepClass, EQUIPTYPE.Weapon, data)

		timer.Simple(0, function()

			if IsValid(wep) then wep:Remove() end

		end)

    end

	return wepClass == tempEquipWeaponName

end)

-- disable prop pickups
hook.Add("AllowPlayerPickup", "DisablePickups", function(ply, ent)

	return false

end )

hook.Add("CanPlayerSuicide", "AllowSuicide", function (ply)

	if GetConVar("efgm_derivesbox"):GetInt() == 1 then return true end
	if !ply:CompareStatus(0) then return true else return false end

end )