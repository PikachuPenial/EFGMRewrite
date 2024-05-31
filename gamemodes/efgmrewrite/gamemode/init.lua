
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

local playerModels = {"models/eft/pmcs/usec_extended_pm.mdl", "models/eft/pmcs/bear_extended_pm.mdl"}

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

	ply:SetModel(playerModels[math.random(#playerModels)])

	ply:SetBodygroup(0, math.random(0, 4)) -- head
	ply:SetBodygroup(1, math.random(0, 18)) -- body
	ply:SetBodygroup(2, math.random(0, 15)) -- legs
	ply:SetBodygroup(3, math.random(0, 14)) -- face

	ply:SetupHands()
	ply:AddEFlags(EFL_NO_DAMAGE_FORCES) -- disables knockback being applied when damage is taken
end

hook.Add("PlayerInitialSpawn", "InitFirstSpawn", function(ply)

	if !ply:IsListenServerHost() then return end
	HostID = tonumber( ply:SteamID64() )

end)

function GM:PlayerDeath(victim, inflictor, attacker)

	local blacklist = {"arc9_eft_melee_taran", "arc9_eft_melee_6x5", "arc9_eft_melee_wycc", "arc9_eft_melee_a2607", "arc9_eft_melee_a2607d", "arc9_eft_melee_camper", "arc9_eft_melee_crash", "arc9_eft_melee_cultist", "arc9_eft_melee_fulcrum", "arc9_eft_melee_crowbar", "arc9_eft_melee_kiba", "arc9_eft_melee_kukri", "arc9_eft_melee_m2", "arc9_eft_melee_mpl50", "arc9_eft_melee_rebel", "arc9_eft_melee_voodoo", "arc9_eft_melee_sp8", "arc9_eft_melee_hultafors", "arc9_eft_melee_taiga"}
	local inventory = victim:GetWeapons()
	local inventoryClean = {}

	for k, v in ipairs(inventory) do -- i tried for an entire hour to do this within the entity itself, but alas, it didn't fucking work, i genuinely don't even know anymore

		local item = v:GetClass()
		if !table.HasValue(blacklist, item) then

			table.insert(inventoryClean, item)

		end

	end

	local backpack = ents.Create("efgm_backpack_temp")
	backpack:SetPos(victim:GetPos() + Vector(0, 0, 64))
	backpack:Spawn()
	backpack:Activate()
	backpack:SetBagContents(inventoryClean)
	backpack:SetBagAttachments(victim.ARC9_AttInv)
	backpack:SetVictimName(victim:GetName())

	-- death sound
	victim:EmitSound(Sound("deathsounds/death" .. math.random(1, 116) .. ".wav"), 80)

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
	if attacker != victim then

		victim:PrintMessage(HUD_PRINTCENTER, attacker:GetName() .. " killed you with a " .. weaponName .. " from " .. distance .. "m away")

	else

		victim:PrintMessage(HUD_PRINTCENTER, "You commited suicide")

	end

end

hook.Add("PostPlayerDeath", "PlayerRemoveRaid", function(ply)

	RAID:RemovePlayer(ply)

	-- respawn timer
	timer.Create(ply:SteamID() .. "respawnTime", 10, 1, function() ply:Spawn() end)

end)

-- reduce velocity upon landing to prevent bunny hopping
hook.Add( "OnPlayerHitGround", "VelocityLimiter", function( ply, inWater, onFloater, speed) 

	local vel = ply:GetVelocity()
	ply:SetVelocity(Vector(-vel.x / 2, -vel.y / 2, 0))

end )

-- disable crouch jumping because of animation abuse + dynamic crouch toggling
hook.Add("StartCommand", "DisableCrouchCommand", function(ply, cmd)
	if !ply:IsOnGround() and !ply:Crouching() then
		cmd:RemoveKey(IN_DUCK)
	end

	if ply:Crouching() or cmd:KeyDown(IN_DUCK) then
		cmd:RemoveKey(IN_JUMP)
	end

	if cmd:KeyDown(IN_BACK) or (cmd:KeyDown(IN_MOVELEFT) or cmd:KeyDown(IN_MOVERIGHT)) and !cmd:KeyDown(IN_FORWARD) then
		cmd:RemoveKey(IN_SPEED)
	end

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

	if (tonumber(listener:GetPos():Distance(talker:GetPos())) > 1575 ) or !talker:Alive() then -- 30~ meter voice distance, not able to talk while dead but can still hear others
		return false, false
	else
		return true, true
	end

end )