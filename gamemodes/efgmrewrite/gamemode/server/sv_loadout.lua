
-- when a player disconnects or server shuts down, save player's weapon, ammo, health, and other state, and give it back when they join back

LOADOUT = {} -- i fucking love encapsulation of state

hook.Add("Initialize", "SaveInitialize", function()

    -- ok so imagine for the locationinformation, like the first bit could be 1 to designate a weapon slot
    -- (like 5 or 10100000 would be for secondary or something)
    -- and if it was 0 it could just be to store the position of regular backpack slots
    -- (maybe 0yxyxyxy, so 20 or 00101000 would store the coords (3, 0))
    sql.Query( "CREATE TABLE IF NOT EXISTS EFGMSaveData ( LocationInformation INTEGER, Name TEXT, Count INTEGER, Type INTEGER, Owner INTEGER );" ) -- basically stash but yk savedata

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