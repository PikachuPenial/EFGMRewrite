
local plyMeta = FindMetaTable( "Player" )
if not plyMeta then Error("Could not find player table") return end

if SERVER then
    
    -- local playerInventories = {}

    -- hook.Add( "PlayerSpawn", "PlayerInventoryInitialize", function(ply)
    
    --     local id64 = ply:SteamID64()

    --     playerInventories[id64] = SetupPlayerInventory(ply)

    -- end)

    -- function SetupPlayerInventory(ply)

    --     local inventory = {}

    --     inventory.rig = {}
    --     inventory.backpack = {}
    --     inventory.pockets = {}
    --     inventory.sc = {}

    -- end

end