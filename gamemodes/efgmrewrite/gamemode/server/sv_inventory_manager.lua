
-- manages the players' inventories, ensures "Enjoy no weapons n____r :D" bullshit doesnt happen again

local plyMeta = FindMetaTable( "Player" )
if not plyMeta then Error("Could not find player table") return end

util.AddNetworkString( "UpdateBackpack" )
util.AddNetworkString( "RequestBackpack" )

util.AddNetworkString( "MoveBackpackItem" )
util.AddNetworkString( "DropBackpackItem" )

plyMeta.Backpack = {}
plyMeta.ActiveSlots = {}

local function SendPlayerInventory(ply)

    net.Start( "UpdateBackpack" )
        net.WriteTable( ply.Backpack.contents )
    net.Send(ply)

end

hook.Add("PlayerSpawn", "GiveBackpack", function(ply)

    timer.Simple(0, function()

        ply.Backpack = INV.New()
        table.Empty( ply.ActiveSlots )

        local inventory

        if isArena then

            print("arena mode is on")
            inventory = LOADOUT.GetArenaInventory( 200 )

        else

            print("arena mode is off")
            inventory = LOADOUT.GetInventory( 200 )

        end

        print("Printing inventory from hook PlayerSpawn in sv_inventory_manager.lua:")
        PrintTable(inventory)
        LOADOUT.Equip( ply, inventory )

    end)

end)

hook.Add("PlayerDeath", "RevokeShitOnDeath", function(ply)

    -- ima just keep this here

end)

hook.Add("PlayerDisconnected", "RevokeShitOnDisconnect", function(ply)

    ply.Backpack.contents = {}
    ply.ActiveSlots = {}

end)

hook.Add( "AllowPlayerPickup", "AllowWeaponPickup", function( ply, ent )

    -- todo: support ammo and attatchments(?)

end )

net.Receive("RequestBackpack", function(len, ply)

    SendPlayerInventory(ply, ply:SteamID64())

end)

net.Receive("DropBackpackItem", function(len, ply)

    local item = net.ReadString()
    local count = net.ReadUInt(32)

    local didRemove = ply.Backpack:Remove( item, count )

    if !didRemove then return end
        
    -- drop the weapon

end)

hook.Add("PlayerCanPickupWeapon", "WeaponPickup", function(ply, weapon)

    if !isInventoryTesting then return true end

    local name = weapon:GetClass()

    -- assign active slots if possible (also I forgot how half of this shit works)
    -- *should* return true if the weapon can be assigned to a slot, and false if the slot is filled
    -- also which primary slot it goes to server-side is arbitrary, it only matters for binds client-side

    if flippedDebugPrimWep[name] != nil then

        if ply.ActiveSlots[KEY_1] == nil then ply.ActiveSlots[KEY_1] = name return true
        elseif ply.ActiveSlots[KEY_2] == nil then ply.ActiveSlots[KEY_2] = name return true
        else return false end

    end

    if flippedDebugSecWep[name] != nil then

        if ply.ActiveSlots[KEY_3] == nil then ply.ActiveSlots[KEY_3] = name return true
        else return false end

    end

    if flippedDebugNadeWep[name] != nil then

        if ply.ActiveSlots[KEY_G] == nil then ply.ActiveSlots[KEY_G] = name return true
        else return false end

    end

    if flippedDebugMeleeWep[name] != nil then

        if ply.ActiveSlots[KEY_4] == nil then ply.ActiveSlots[KEY_4] = name return true
        else return false end

    end

    return false

end)

hook.Add("PlayerDroppedWeapon", "WeaponDrop", function(ply, weapon)

    if !isInventoryTesting then return end

    local name = weapon:GetClass()

    if ply.ActiveSlots[KEY_1] == name then ply.ActiveSlots[KEY_1] = nil ply:PrintMessage(HUD_PRINTTALK, "Dropped "..name.."!") return end
    if ply.ActiveSlots[KEY_2] == name then ply.ActiveSlots[KEY_2] = nil ply:PrintMessage(HUD_PRINTTALK, "Dropped "..name.."!") return end
    if ply.ActiveSlots[KEY_3] == name then ply.ActiveSlots[KEY_3] = nil ply:PrintMessage(HUD_PRINTTALK, "Dropped "..name.."!") return end
    if ply.ActiveSlots[KEY_G] == name then ply.ActiveSlots[KEY_G] = nil ply:PrintMessage(HUD_PRINTTALK, "Dropped "..name.."!") return end
    if ply.ActiveSlots[KEY_4] == name then ply.ActiveSlots[KEY_4] = nil ply:PrintMessage(HUD_PRINTTALK, "Dropped "..name.."!") return end

end)

-- will do later for ammos and such perhaps
hook.Add("PlayerCanPickupItem", "ItemPickupTest", function(ply, item)

    return true

end)

-- i hate the active slot system so much
hook.Add("Think", "CheckButtonPresses", function()

    if !isInventoryTesting then return end

    for k, ply in ipairs( player.GetHumans() ) do
        
        if table.IsEmpty( ply.ActiveSlots ) then return end

        for keyPressed, weaponName in pairs( ply.ActiveSlots ) do
            
            if !ply:HasWeapon( tostring( weaponName ) ) then

                ply.ActiveSlots[ keyPressed ] = nil

            end
        end

    end


end)