
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

end

local defaultLoadout = INV()
defaultLoadout:AddItem("arc9_eft_m9a3", 1, 1)
defaultLoadout:AddItem("weapon_crowbar", 1, 1)
-- no ammo bc dupe lmao

local blacklist = {}
blacklist["arc9_eft_m9a3"] = true
blacklist["weapon_crowbar"] = true

local function GetArenaLoadout()

    local loadout = INV()

    -- infinite ammo btw
    loadout:AddItem(debugPrimWep[math.random(#debugPrimWep)], 1, 1)
    loadout:AddItem(debugSecWep[math.random(#debugSecWep)], 1, 1)
    loadout:AddItem("weapon_crowbar", 1, 1)

    return loadout

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
	ply:SetDuckSpeed(0.48)
	ply:SetUnDuckSpeed(0.48)

	ply:SetModel("models/player/Group01/male_07.mdl")
	ply:SetupHands()
	ply:AddEFlags(EFL_NO_DAMAGE_FORCES) -- disables knockback being applied when damage is taken

    LOADOUT.EquipLoadout(ply)

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

    local backpack = ents.Create("efgm_backpack")
    backpack:SetPos(victim:GetPos())
    backpack:Spawn()
    backpack:Activate()
    backpack:SetContents( victim:GetInventory( blacklist ), victim )

end

function GM:ScalePlayerDamage(target, hitgroup, dmginfo)
	dmginfo:ScaleDamage(1)
end

hook.Add( "PlayerShouldTakeDamage", "AntiLobbyKill", function(victim, attacker) 
	
	return !victim:CompareStatus(0)

end )