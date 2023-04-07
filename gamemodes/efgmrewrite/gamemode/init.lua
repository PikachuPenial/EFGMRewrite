AddCSLuaFile("cl_hud.lua")
AddCSLuaFile("cl_menu.lua")
-- AddCSLuaFile("cl_keybinds.lua")
AddCSLuaFile("cl_menu_manager.lua")
-- AddCSLuaFile("cl_progression_menu.lua")
AddCSLuaFile("cl_raid_info.lua")
-- AddCSLuaFile("cl_scoreboard.lua")
-- AddCSLuaFile("cl_shop_menu.lua")
-- AddCSLuaFile("cl_stash_menu.lua")

AddCSLuaFile("shared.lua")
include("shared.lua")

include("sv_concommands.lua")
include("sv_network_manager.lua")
include("sv_player_spawner.lua")
include("sv_playermeta.lua")
include("sv_raid_manager.lua")
-- include("sv_shop_manager.lua")
-- include("sv_skill_manager.lua")
-- include("sv_stash_managerlua")
-- include("sv_task_manager.lua")

function GM:PlayerInitialSpawn(ply)

    -- setup nwints and custom pdatas
    
    InitializeNetworkInt(ply, "PlayerLevel", 0)

end

function GM:PlayerDisconnected(ply)

end

function GM:PlayerDeath(victim, inflictor, attacker)

    victim:ResetRaidStatus()
    RAID:RemovePlayer(victim)

    -- do nwints and shit for kd and idfk ill find it out when the actual important shit is done haha port i said port he said it guys

end