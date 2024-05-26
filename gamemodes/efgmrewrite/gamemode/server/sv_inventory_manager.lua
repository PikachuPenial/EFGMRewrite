
-- manages the players' inventories, ensures "Enjoy no weapons n____r :D" bullshit doesnt happen again

util.AddNetworkString( "UpdatePlayerInventory" )
util.AddNetworkString( "RequestPlayerInventory" )

util.AddNetworkString( "MovePlayerInventory" )
util.AddNetworkString( "DropPlayerInventory" )

local inventoryTable = {}
local ammoTable = {}

local function SendPlayerInventory(ply, steamID)

    steamID = steamID or ply:SteamID64()

    net.Start( "UpdatePlayerInventory" )
        net.WriteTable( inventoryTable[ steamID ].contents )
    net.Send(ply)

end

local function TakeAmmoFromInventory( ply, ammoName, ammoCount )

    ply:PrintMessage(HUD_PRINTCENTER, "Took "..tostring(ammoCount).." bullets from your inventory lol." )

end

hook.Add("PlayerSpawn", "GiveInventory", function(ply)

    -- References the loadout system eventually, rn just for testing

    local steamID =  ply:SteamID64()

    inventoryTable[ steamID ] = INVG.New(6, 6, 0)

    -- for testing purposes

    inventoryTable[ steamID ]:Add("s_prim1", "arc9_eft_aks74u", 1, 1)
    inventoryTable[ steamID ]:Add("s_sec", "arc9_eft_tt33", 1, 1)

    inventoryTable[ steamID ]:Add("g_1_1", "SMG1", 2, 90)
    inventoryTable[ steamID ]:Add("g_2_1", "Pistol", 2, 30)

    SendPlayerInventory(ply, steamID)

    timer.Simple(0, function() -- if you think this is unnecessary, try removing it

        LOADOUT.Equip( ply, inventoryTable[ steamID ].contents )

    end)

end)

-- yes this is, in fact, the only way to do this. this somehow doesnt impact performance, even well past 1000 iterations per second
hook.Add("Tick", "CheckReload", function()

    for k, ply in ipairs(player.GetHumans()) do

        local wep = ply:GetActiveWeapon()

        if IsValid( wep ) then

            local steamID = ply:SteamID64()

            ammoTable[steamID] = ammoTable[steamID] or {}
            ammoTable[steamID].count1 = ammoTable[steamID].count1 or 0
            ammoTable[steamID].count2 = ammoTable[steamID].count2 or 0

            local ammotype1 = wep:GetPrimaryAmmoType()
            local ammotype2 = wep:GetSecondaryAmmoType()

            local count1 = ply:GetAmmoCount( ammotype1 )
            local count2 = ply:GetAmmoCount( ammotype2 )

            if count1 != ammoTable[steamID].count1 then

                TakeAmmoFromInventory( ply, ammotype1, ammoTable[steamID].count1 - count1 )

            end

            if count2 != ammoTable[steamID].count2 then

                TakeAmmoFromInventory( ply, ammotype2, ammoTable[steamID].count2 - count2 )
                
            end

            ammoTable[steamID].count1 = count1
            ammoTable[steamID].count2 = count2
        
        end
        
    end

end)

net.Receive("RequestPlayerInventory", function(len, ply)

    SendPlayerInventory(ply, ply:SteamID64())

end)

net.Receive("MovePlayerInventory", function(len, ply)

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

net.Receive("DropPlayerInventory", function(len, ply)

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