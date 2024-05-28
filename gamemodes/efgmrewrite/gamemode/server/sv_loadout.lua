
-- when a player disconnects or server shuts down, save player's weapon, ammo, health, and other state, and give it back when they join back

LOADOUT = {} -- okay this is actually convenient

function LOADOUT.Equip( ply, contents )

    -- Temporary
    for k, v in pairs(contents) do
        
        GiveItem[v.type](ply, v.name, v.count, false)

    end

end

-- function LOADOUT.GetArenaInventory( width, height )

--     local inventory = INVG.New(width or 6, height or 6)
    
--     local primaryWeapon = debugPrimWep[ math.random( #debugPrimWep ) ]
--     local secondaryWeapon = debugSecWep[ math.random( #debugSecWep) ]
--     local grenade = debugNadeWep[ math.random( #debugNadeWep) ]
--     local melee = debugMeleeWep[ math.random( #debugMeleeWep) ]

--     inventory:Add("s_prim1", primaryWep, 1, 1)
--     inventory:Add("s_sec", secondaryWeapon, 1, 1)
--     inventory:Add("s_nade", grenade, 1, 1)
--     inventory:Add("s_kn", melee, 1, 1)

--     inventory:Add("s_ammo1", weapons.Get( primaryWeapon ):GetPrimaryAmmoType(), 2, 1984) -- its just like george orwell's book
--     inventory:Add("s_ammo2", weapons.Get( secondaryWeapon ):GetPrimaryAmmoType(), 2, 1984)

--     return inventory
    
-- end