
-- manages the players' inventories, ensures "Enjoy no weapons n____r :D" bullshit doesnt happen again
util.AddNetworkString( "UpdatePlayerInventory" )
util.AddNetworkString( "RequestPlayerInventory" )

util.AddNetworkString( "MovePlayerInventory" )
util.AddNetworkString( "DropPlayerInventory" )

local backpacks = {}

local function SendPlayerInventory(ply, steamID)

    steamID = steamID or ply:SteamID64()

    net.Start( "UpdatePlayerInventory" )
        net.WriteTable( inventoryTable[ steamID ].contents )
    net.Send(ply)

end

hook.Add("PlayerSpawn", "GiveInventory", function(ply)

    local steamID =  ply:SteamID64()
    backpacks[ steamID ] = backpacks[ steamID ] or {}

    local inventory = {}
    local randAtts = table.Copy(ARC9.Attachments_Index) -- FUCK YOU FUCK YOU FUCK YOU FUCK YOU FUCK YOU FUCK YOU FUCK YOU FUCK YOU

    if !isArena then return end

    timer.Simple(0, function()

        -- all this shit is wip sorry penal

        -- a random primary, secondary, grenade, and melee weapon
        --ply:Give(debugPrimWep[math.random(#debugPrimWep)])
        ply:Give(debugShitSecWep[math.random(#debugShitSecWep)]) -- nerfing the nakeds
        ply:Give(debugNadeWep[math.random(#debugNadeWep)])
        ply:Give(debugMeleeWep[math.random(#debugMeleeWep)])

        -- ammo for weapons
        ply:SetAmmo(3000, 1) -- ar2
        ply:SetAmmo(3000, 3) -- pistol
        ply:SetAmmo(3000, 4) -- smg1
        ply:SetAmmo(3000, 5) -- 357
        ply:SetAmmo(3000, 7) -- buckshot
        ply:SetAmmo(3000, 9) -- smg grenade

        -- attachments
        timer.Simple(1, function()
            table.Shuffle(randAtts)
            for k, v in pairs(randAtts) do
                if k > 250 then return end -- only give player 250 diff unique attachments
                ARC9:PlayerGiveAtt(ply, v, math.random(1, 2))
            end

            ARC9:PlayerSendAttInv(ply)
        end)

        -- inventory = LOADOUT.GetArenaInventory(6, 6)

        -- LOADOUT.Equip( ply, inventory.contents )

    end)

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