
-- when a player disconnects or server shuts down, save player's weapon, ammo, health, and other state, and give it back when they join back

SAVE = {} -- i fucking love encapsulation of state

hook.Add("Initialize", "SaveInitialize", function()

    sql.Query( "CREATE TABLE IF NOT EXISTS EFGMSaveData ( ItemName TEXT, ItemCount INTEGER, ItemType INTEGER, ItemOwner INTEGER );" ) -- basically stash but yk savedata

end)

hook.Add("PlayerDisconnected", "SaveDisconnect", function(ply)

    if !ply:CompareStatus(0) then return end

    SAVE.StoreData(ply)

end)

hook.Add("ShutDown", "SaveShutdown", function()

    for k, ply in pairs(player.GetHumans()) do
        
        if !ply:CompareStatus(0) then return end

        SAVE.StoreData(ply)

    end

end)

function SAVE.StoreData(ply)

    local steamID = ply:SteamID64() or HostID

    local saveData = {}

    for k, v in pairs(ply:GetWeapons()) do
        
        local wep = v:GetClass()

        local tbl = {}

        tbl.ItemName = wep
        tbl.ItemCount = 1
        tbl.ItemType = 1

        table.insert(saveData, tbl)

    end

    for k, v in pairs(ply:GetAmmo()) do

        local tbl = {}
        
        tbl.ItemName = game.GetAmmoName(k)
        tbl.ItemCount = v
        tbl.ItemType = 2

        table.insert(saveData, tbl)

    end

    for k, v in pairs(saveData) do
        
        -- i escaped the item name because idk i feel like the chances of somebody somehow doing an sql injection with an item are low but not zero
        sql.Query( "INSERT INTO EFGMSaveData (ItemName, ItemCount, ItemType, ItemOwner) VALUES (".. SQLStr(v.ItemName) ..", ".. v.ItemCount ..", ".. v.ItemType ..", ".. steamID ..");" )

    end

    PrintTable(saveData)

end

function SAVE.RetrieveData(ply)

    local steamID = ply:SteamID64() or HostID

    local saveData = sql.Query( "SELECT ItemName, ItemCount, ItemType FROM EFGMSaveData WHERE ItemOwner = ".. steamID ..";" )

    if saveData == "NULL" then print("ok what the fuck") return nil end

    return saveData -- returns nil if query got nothing

end

function SAVE.EquipPlayer(ply, data)

    for k, v in ipairs(data) do

        PrintTable(v)
        
        if tonumber( v.ItemType ) == 1 then

            ply:Give(v.ItemName, true)
        
        elseif tonumber( v.ItemType ) == 2 then

            ply:GiveAmmo(v.ItemCount, v.ItemName, true)
            
        end

    end

end

function SAVE.WipePlayerData(ply)

    local steamID = ply:SteamID64() or HostID

    sql.Query( "DELETE FROM EFGMSaveData WHERE ItemOwner = ".. steamID ..";" )

end

function SAVE.WipeData()

    sql.Query( "DELETE FROM EFGMSaveData;" )

end