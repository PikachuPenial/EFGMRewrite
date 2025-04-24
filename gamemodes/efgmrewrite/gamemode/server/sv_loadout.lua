-- when a player disconnects or server shuts down, save player's weapon, ammo, health, and other state, and give it back when they join back

local plyMeta = FindMetaTable("Player")
if not plyMeta then Error("Could not find player table") return end

LOADOUT = {} -- okay this is actually convenient

function LOADOUT.Equip(ply, inventory)
    -- Temporary
    for k, v in pairs(inventory.contents) do
        GiveItem[v.type](ply, v.name, v.count)
    end

    -- ARC9:PlayerSendAttInv(ply)
end

function LOADOUT.GetInventory(attatchmentCount)
    local inventory = INV.New()

    local secondary = debugShitSecWep[ math.random(#debugShitSecWep)] -- nerfing the nekeds
    local grenade = debugNadeWep[math.random(#debugNadeWep)]
    local melee = debugMeleeWep[math.random(#debugMeleeWep)]

    inventory:Add(secondary, 1, 1) -- should be inventory.contents[1] and so on
    inventory:Add(grenade, 1, 1 )
    inventory:Add(melee, 1, 1)

    inventory:Add(1, 2, 3000) -- ar2
    inventory:Add(3, 2, 3000) -- pistol
    inventory:Add(4, 2, 3000) -- smg1
    inventory:Add(5, 2, 3000) -- 357
    inventory:Add(6, 2, 3000) -- buckshot
    inventory:Add(7, 2, 3000) -- smg grenade

    -- inventory:Add(game.GetAmmoID(weapons.Get(secondary).Ammo), 2, 1984) -- its just like george orwell's book (yes porty this is a good thing but people cant shoot the guns they find for now lmao)

    table.Shuffle(debugRandAtts)

    for k, v in ipairs(debugRandAtts) do
        inventory:Add(v, 3, math.random(1, 2))

        if k > attatchmentCount then return inventory end
    end

    return inventory
end

function LOADOUT.GetArenaInventory( attatchmentCount )
    local inventory = INV.New()

    local secondary = debugShitSecWep[math.random(#debugShitSecWep)]
    local grenade = debugNadeWep[math.random(#debugNadeWep)]
    local melee = debugMeleeWep[math.random(#debugMeleeWep)]

    inventory:Add(secondary, 1, 1) -- should be inventory.contents[1] and so on
    inventory:Add(grenade, 1, 1)
    inventory:Add(melee, 1, 1)

    inventory:Add(1, 2, 3000) -- ar2
    inventory:Add(3, 2, 3000) -- pistol
    inventory:Add(4, 2, 3000) -- smg1
    inventory:Add(5, 2, 3000) -- 357
    inventory:Add(6, 2, 3000) -- buckshot
    inventory:Add(7, 2, 3000) -- smg grenade

    -- inventory:Add(game.GetAmmoID(weapons.Get(secondary).Ammo), 2, 1984)

    table.Shuffle(debugRandAtts)

    for k, v in ipairs(debugRandAtts) do
        inventory:Add(v, 3, math.random(1, 2))

        if k > attatchmentCount then return inventory end
    end

    return inventory
end

plyMeta.Backpack = {}
plyMeta.ActiveSlots = {}

hook.Add("PlayerSpawn", "GiveBackpack", function(ply)
    timer.Simple(0, function()

        ply.Backpack = INV.New()
        table.Empty(ply.ActiveSlots)

        local inventory

        if isArena then
            print("arena mode is on")
            inventory = LOADOUT.GetArenaInventory(200)
        else
            print("arena mode is off")
            inventory = LOADOUT.GetInventory(200)
        end

        print("Printing inventory from hook PlayerSpawn in sv_inventory_manager.lua:")
        -- PrintTable(inventory) wow this flooded the console so bad
        LOADOUT.Equip(ply, inventory)

    end)

end)