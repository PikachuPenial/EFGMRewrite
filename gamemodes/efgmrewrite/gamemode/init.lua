
isArena = GetConVar("efgm_arenamode"):GetInt() == 1 or false

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

local function GetArenaLoadout(ply)

	ply:Give(debugPrimWep[math.random(#debugPrimWep)])
	ply:Give(debugSecWep[math.random(#debugSecWep)])
	ply:Give(debugNadeWep[math.random(#debugNadeWep)])

end

function GM:PlayerSpawn(ply)

	ply:SetGravity(.72)
	ply:SetMaxHealth(100)
	ply:SetRunSpeed(230)
	ply:SetWalkSpeed(140)
	ply:SetJumpPower(140)

	ply:SetLadderClimbSpeed(120)
	ply:SetSlowWalkSpeed(78)

	ply:SetCrouchedWalkSpeed(0.45)
	ply:SetDuckSpeed(0.53)
	ply:SetUnDuckSpeed(0.53)

	ply:SetModel("models/player/Group01/male_07.mdl")
	ply:SetupHands()
	ply:AddEFlags(EFL_NO_DAMAGE_FORCES) -- disables knockback being applied when damage is taken

	LOADOUT.Equip(ply)
	if isArena then GetArenaLoadout(ply) end

	ply:SetRaidStatus(0, "")

end

hook.Add("PlayerInitialSpawn", "InitFirstSpawn", function(ply)

    if !ply:IsListenServerHost() then return end
        
    HostID = tonumber( ply:SteamID64() )

end)

function GM:PlayerDeath(victim, inflictor, attacker)

	RAID:RemovePlayer(victim)

	-- do nwints and shit for kd and idfk ill find it out when the actual im(port)ant shit is done haha port i said port he said it guys
    -- i did the important shit in sv_stats.lua guys guys i said port again i fucking did it

    -- local backpack = ents.Create("efgm_backpack")
    -- backpack:SetPos(victim:GetPos())
    -- backpack:Spawn()
    -- backpack:Activate()
    -- backpack:SetContents( victim:GetInventory( blacklist ), victim )

	-- death sound
	victim:EmitSound(Sound("deathsounds/" .. math.random(1, 116) .. ".wav"), 80)

	-- respawn timer
	timer.Create(victim:SteamID() .. "respawnTime", 10, 1, function() victim:Spawn() end)

end

hook.Add("PlayerDeathSound", "RemoveDefaultDeathSound", function() return true end)

function GM:ScalePlayerDamage(target, hitgroup, dmginfo)
	dmginfo:ScaleDamage(1)
end

hook.Add( "PlayerShouldTakeDamage", "AntiLobbyKill", function(victim, attacker) 
	
	return !victim:CompareStatus(0)

end )

hook.Add( "OnPlayerHitGround", "VelocityLimiter", function( ply, inWater, onFloater, speed) 

	local vel = ply:GetVelocity()
	ply:SetVelocity(Vector(-vel.x / 2, -vel.y / 2, 0))

end )

-- prevent respawning if under a respawn timer
hook.Add( "PlayerDeathThink", "SpawnLock", function(ply) 
	
	if timer.Exists(ply:SteamID() .. "respawnTime") then
		return false
	end

end )

-- modifies voice chat to be proximity based
hook.Add( "PlayerCanHearPlayersVoice", "ProxVOIP", function(listener,talker)

	if (tonumber(listener:GetPos():Distance(talker:GetPos())) > 1050) then -- 20~ meter voice distance
		return false, false
	else
		return true, true
	end

end )