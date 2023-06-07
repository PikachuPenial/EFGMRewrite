AddCSLuaFile("cl_hud.lua")
AddCSLuaFile("cl_init.lua")
-- AddCSLuaFile("cl_keybinds.lua")
AddCSLuaFile("cl_menu_alias.lua")
AddCSLuaFile("cl_menu_manager.lua")
AddCSLuaFile("cl_menu.lua")
AddCSLuaFile("cl_raid_info.lua")
-- AddCSLuaFile("cl_scoreboard.lua")
AddCSLuaFile("cl_shop_manager.lua")
AddCSLuaFile("cl_stash_manager.lua")

AddCSLuaFile("shared.lua")
AddCSLuaFile("config.lua")
AddCSLuaFile("sh_debug_handler.lua")
AddCSLuaFile("sh_enums.lua")
AddCSLuaFile("sh_loot_tables.lua")
AddCSLuaFile("sh_playermeta.lua")

-- Intel shit

AddCSLuaFile("intel/cl_intel.lua")
AddCSLuaFile("intel/info_concrete.lua")
AddCSLuaFile("intel/info_ravine.lua")

include("shared.lua")
include("config.lua")

include("sh_debug_handler.lua")
include("sh_enums.lua")
include("sh_loot_tables.lua")
include("sh_playermeta.lua")

include("sv_concommands.lua")
include("sv_network_manager.lua")
include("sv_player_spawner.lua")
include("sv_playermeta.lua")
include("sv_raid_manager.lua")
include("sv_shop_manager.lua")
include("sv_stash_manager.lua")
include("sv_stats.lua")

function GM:Initialize()

	print("Escape From Garry's Mod Rewrite has been initialized on " .. game.GetMap())

end

function GM:PlayerSpawn(ply)

	ply:SetGravity(.72)
	ply:SetMaxHealth(100)
	ply:SetRunSpeed(230)
	ply:SetWalkSpeed(140)
	ply:SetJumpPower(140)

	ply:SetLadderClimbSpeed(70)
	ply:SetSlowWalkSpeed(78)

	ply:SetCrouchedWalkSpeed(0.45)
	ply:SetDuckSpeed(0.48)
	ply:SetUnDuckSpeed(0.48)

	ply:SetModel("models/player/Group01/male_07.mdl")
	ply:SetupHands()
	ply:AddEFlags(EFL_NO_DAMAGE_FORCES) -- disables knockback being applied when damage is taken

	ply:Give(debugPrimWep[math.random(#debugPrimWep)])
	ply:Give(debugSecWep[math.random(#debugSecWep)])

end

function GM:PlayerDeath(victim, inflictor, attacker)

	RAID:RemovePlayer(victim)

	-- do nwints and shit for kd and idfk ill find it out when the actual im(port)ant shit is done haha port i said port he said it guys

end