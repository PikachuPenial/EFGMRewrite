
-- manages the players' inventories, ensures "Enjoy no weapons n____r :D" bullshit doesnt happen again

util.AddNetworkString( "UpdateBackpack" )
util.AddNetworkString( "RequestBackpack" )

util.AddNetworkString( "MoveBackpackItem" )
util.AddNetworkString( "DropBackpackItem" )

local backpacks = {}

local activeSlots = {}

local function SendPlayerInventory(ply, steamID)

    steamID = steamID or ply:SteamID64()

    net.Start( "UpdateBackpack" )
        net.WriteTable( inventoryTable[ steamID ].contents )
    net.Send(ply)

end

hook.Add("PlayerSpawn", "GiveBackpack", function(ply)

    local steamID =  ply:SteamID64()
    backpacks[ steamID ] = backpacks[ steamID ] or {}
    activeSlots[ steamID ] = activeSlots[ steamID ] or {}

    if !isArena then return end

    timer.Simple(0, function()

        local inventory = LOADOUT.GetArenaInventory(6, 6, 200)

        LOADOUT.Equip( ply, inventory )

    end)

end)

hook.Add("PlayerDeath", "RevokeShitOnDeath", function(ply)

    local steamID =  ply:SteamID64()
    backpacks[ steamID ] = {}
    activeSlots[ steamID ] = {}

end)

hook.Add("PlayerDisconnected", "RevokeShitOnDisconnect", function(ply)

    local steamID =  ply:SteamID64()
    backpacks[ steamID ] = {}
    activeSlots[ steamID ] = {}

end)

hook.Add( "AllowPlayerPickup", "AllowWeaponPickup", function( ply, ent )

    -- todo: support ammo and attatchments(?)

end )

net.Receive("RequestBackpack", function(len, ply)

    SendPlayerInventory(ply, ply:SteamID64())

end)

net.Receive("MoveBackpackItem", function(len, ply)

    local oldPos = net.ReadString()
    local newPos = net.ReadString()
    local count = net.ReadUInt(32)

    local steamID = ply:SteamID64()

    inventoryTable[ steamID ] = inventoryTable[ steamID ] or INVG.New(6, 6, 0)

    count = math.Clamp( count, 1, inventoryTable[ steamID ].contents[ oldPos ].count )

    -- makes sure some bs isnt happening
    if inventoryTable[ steamID ].contents[ oldPos ] == nil then print( "old position doesnt exist" ) PrintTable( inventoryTable[ steamID ].contents ) return end
    if inventoryTable[ steamID ].contents[ newPos ] != nil then print( "new position is occupied" ) PrintTable( inventoryTable[ steamID ].contents ) return end

    -- eventually add check if new position exceeds boundaries but idgaf rn

    inventoryTable[ steamID ]:Move( oldPos, newPos, count )

    print( "Moved item successfully" )

end)

net.Receive("DropBackpackItem", function(len, ply)

    local pos = net.ReadString()
    local count = net.ReadUInt(32)

    local steamID = ply:SteamID64()

    inventoryTable[ steamID ] = inventoryTable[ steamID ] or INVG.New(6, 6, 0)

    -- makes sure some bs isnt happening
    if inventoryTable[ steamID ].contents[ pos ] == nil then print( "position doesnt exist" ) PrintTable( inventoryTable[ steamID ].contents ) return end

    inventoryTable[ steamID ]:Remove( pos, math.Clamp( count, 1, inventoryTable[ steamID ].contents[ pos ].count ) )

    -- drop logic eventually

    print( "Dropped item successfully" )

end)

hook.Add("PlayerCanPickupWeapon", "WeaponPickup", function(ply, weapon)

    if !isInventoryTesting then return true end

    local name = weapon:GetClass()
    local steamID = ply:SteamID64()

    -- assign active slots if possible (also I forgot how half of this shit works)
    -- *should* return true if the weapon can be assigned to a slot, and false if the slot is filled
    -- also which primary slot it goes to server-side is arbitrary, it only matters for binds client-side

    if flippedDebugPrimWep[name] != nil then

        if activeSlots[steamID][KEY_1] == nil then activeSlots[steamID][KEY_1] = name ply:PrintMessage(HUD_PRINTTALK, "Picked up "..name.."!") return true
        elseif activeSlots[steamID][KEY_2] == nil then activeSlots[steamID][KEY_2] = name ply:PrintMessage(HUD_PRINTTALK, "Picked up "..name.."!") return true
        else return false end

    end

    if flippedDebugSecWep[name] != nil then

        if activeSlots[steamID][KEY_3] == nil then activeSlots[steamID][KEY_3] = name ply:PrintMessage(HUD_PRINTTALK, "Picked up "..name.."!") return true
        else return false end

    end

    if flippedDebugNadeWep[name] != nil then

        if activeSlots[steamID][KEY_G] == nil then activeSlots[steamID][KEY_G] = name ply:PrintMessage(HUD_PRINTTALK, "Picked up "..name.."!") return true
        else return false end

    end

    if flippedDebugMeleeWep[name] != nil then

        if activeSlots[steamID][KEY_V] == nil then activeSlots[steamID][KEY_V] = name ply:PrintMessage(HUD_PRINTTALK, "Picked up "..name.."!") return true
        else return false end

    end

    return false

end)

hook.Add("PlayerDroppedWeapon", "WeaponDrop", function(ply, weapon)

    if !isInventoryTesting then return end

    local name = weapon:GetClass()
    local steamID = ply:SteamID64()

    if activeSlots[steamID][KEY_1] == name then activeSlots[steamID][KEY_1] = nil ply:PrintMessage(HUD_PRINTTALK, "Dropped "..name.."!") return end
    if activeSlots[steamID][KEY_2] == name then activeSlots[steamID][KEY_2] = nil ply:PrintMessage(HUD_PRINTTALK, "Dropped "..name.."!") return end
    if activeSlots[steamID][KEY_3] == name then activeSlots[steamID][KEY_3] = nil ply:PrintMessage(HUD_PRINTTALK, "Dropped "..name.."!") return end
    if activeSlots[steamID][KEY_G] == name then activeSlots[steamID][KEY_G] = nil ply:PrintMessage(HUD_PRINTTALK, "Dropped "..name.."!") return end
    if activeSlots[steamID][KEY_V] == name then activeSlots[steamID][KEY_V] = nil ply:PrintMessage(HUD_PRINTTALK, "Dropped "..name.."!") return end

end)

-- will do later for ammos and such perhaps
hook.Add("PlayerCanPickupItem", "ItemPickupTest", function(ply, item)

    -- local steamID = ply:SteamID64()
    -- activeSlots[steamID] = activeSlots[steamID] or {}

    return true

end)