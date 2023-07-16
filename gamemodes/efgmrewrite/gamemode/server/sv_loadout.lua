
-- when a player disconnects or server shuts down, save player's weapon, ammo, health, and other state, and give it back when they join back

LOADOUT = {} -- i fucking love encapsulation of state

hook.Add("Initialize", "SaveInitialize", function()

    sql.Query( "CREATE TABLE IF NOT EXISTS EFGMSaveData ( ItemName TEXT, ItemCount INTEGER, ItemType INTEGER, ItemOwner INTEGER );" ) -- basically stash but yk savedata

end)

hook.Add("PlayerDisconnected", "SaveDisconnect", function(ply)

    if !ply:CompareStatus(0) then return end

    LOADOUT.StoreData(ply)

end)

hook.Add("ShutDown", "SaveShutdown", function()

    for k, ply in pairs(player.GetHumans()) do
        
        if !ply:CompareStatus(0) then return end

        LOADOUT.StoreData(ply)

    end

end)

function LOADOUT.StoreData(ply)

    local steamID = ply:SteamID64() or HostID

    local saveInventory = ply:GetInventory()

    if saveInventory == nil then return end

    for k, v in pairs(saveInventory.contents) do
        
        -- i escaped the item name because idk i feel like the chances of somebody somehow doing an sql injection with an item are low but not zero
        sql.Query( "INSERT INTO EFGMSaveData (ItemName, ItemCount, ItemType, ItemOwner) VALUES (".. SQLStr(k) ..", ".. v.count ..", ".. v.type ..", ".. steamID ..");" )

    end
    
end

function LOADOUT.RetrieveData(ply)

    local steamID = ply:SteamID64() or HostID

    local query = sql.Query( "SELECT ItemName, ItemCount, ItemType FROM EFGMSaveData WHERE ItemOwner = ".. steamID ..";" )

    if query == "NULL" or query == nil then return nil end -- if query is empty returns nil

    local saveData = INV.SQLToInventory(query) 

    return saveData

end

function LOADOUT.WipePlayerData(ply)

    local steamID = ply:SteamID64() or HostID

    sql.Query( "DELETE FROM EFGMSaveData WHERE ItemOwner = ".. steamID ..";" )

end

function LOADOUT.WipeData()

    sql.Query( "DELETE FROM EFGMSaveData;" )

end