AddCSLuaFile("cl_init.lua")
AddCSLuaFile("cl_menu_manager.lua")

AddCSLuaFile("shared.lua")

include("shared.lua")

include("sv_concommands.lua")
include("sv_network_manager.lua")
include("sv_player_spawner.lua")
include("sv_playermeta.lua")
include("sv_raid_manager.lua")

function GM:PlayerInitialSpawn(ply)

    -- setup nwints and custom pdatas

end