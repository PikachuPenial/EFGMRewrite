
-- when a player disconnects or server shuts down, save player's weapon, ammo, health, and other state, and give it back when they join back

LOADOUT = {} -- okay this is actually convenient

function LOADOUT.Equip( ply, inventory )

    -- Temporary
    for k, v in pairs( inventory.contents ) do

        GiveItem[v.type](ply, v.name, v.count)

    end

    -- ARC9:PlayerSendAttInv(ply)

end

function LOADOUT.GetArenaInventory( width, height, attatchmentCount )

    local inventory = INVG.New(width, height)

    local secondary = debugShitSecWep[ math.random( #debugShitSecWep ) ] -- nerfing the nekeds
    local grenade = debugNadeWep[ math.random( #debugNadeWep) ]
    local melee = debugMeleeWep[ math.random( #debugMeleeWep) ]

    inventory:Add( secondary, 1, 1 ) -- should be inventory.contents[1] and so on
    inventory:Add( grenade, 1, 1 )
    inventory:Add( melee, 1, 1 )

    inventory:Add(1, 2, 3000) -- ar2
    inventory:Add(3, 2, 3000) -- pistol
    inventory:Add(4, 2, 3000) -- smg1
    inventory:Add(5, 2, 3000) -- 357
    inventory:Add(6, 2, 3000) -- buckshot
    inventory:Add(7, 2, 3000) -- smg grenade

    -- inventory:Add( game.GetAmmoID( weapons.Get( secondary ).Ammo ), 2, 1984 ) -- its just like george orwell's book (yes porty this is a good thing but people cant shoot the guns they find for now lmao)

    table.Shuffle(debugRandAtts)

    for k, v in ipairs(debugRandAtts) do

        inventory:Add( v, 3, math.random(1, 2) )

        if k > attatchmentCount then return inventory end

    end

    return inventory

end