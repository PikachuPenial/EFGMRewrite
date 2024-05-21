
-- when a player disconnects or server shuts down, save player's weapon, ammo, health, and other state, and give it back when they join back

LOADOUT = {} -- i fucking love encapsulation of state

hook.Add("Initialize", "SaveInitialize", function()

    -- Max integer size is 8 bytes (8 chunks of 8 bits)
    -- The first two bytes could be used to store the x and y value,
    -- with one of the bits in them used to designate whether or not the item is in a backpack or active slot

    -- For example:

    -- 00000100 (first byte, 0-255, designates an item on a 5 x value)
    -- 00000000 (second byte, 256-65535 designates an item on a 1 x value)

    -- or maybe

    -- 10000001 (first byte, the first one designates the item is in an active slot, and the rest signifies which slot the item will be in, maybe the second primary slot)
    -- 00000000 (second byte, has no information bc there arent gonna be 32768 slots)

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

function LOADOUT.LocationInformationTOPos( locationInformation )

    -- handles overflows
    if locationInformation > 4294967295 then return nil end

    -- yeah this fuckery actually works im suprised too
    local pos = {}

    pos.y = bit.rshift( bit.band( locationInformation, 4294901760 ), 16 ) + 1
    pos.x = bit.band( locationInformation, 65535 ) + 1

    return pos

end
concommand.Add("efgm_debug_loctopos", function(ply, cmd, args)

    local loadoutInformation = tonumber( args[1] )

    print("Input:")
    print( loadoutInformation )
    print("Output")
    PrintTable( LOADOUT.LocationInformationTOPos( loadoutInformation ) )

end)

function LOADOUT.PosTOLocationInformation( pos, isActiveSlot )

    -- these handle overflows
    if pos.x > 32767 then return nil end
    if pos.y > 65535 then return nil end

    local locationInformation = (pos.x - 1) + (pos.y - 1) * 65536
    if isActiveSlot or false then locationInformation = locationInformation + 32768 end

    return locationInformation

end
concommand.Add("efgm_debug_postoloc", function(ply, cmd, args)

    local pos = {}
    pos.x = tonumber( args[1] )
    pos.y = tonumber( args[2] )

    print("Input:")
    PrintTable( pos )
    print("Output")
    print( LOADOUT.PosTOLocationInformation( pos ) or -1 )

end)