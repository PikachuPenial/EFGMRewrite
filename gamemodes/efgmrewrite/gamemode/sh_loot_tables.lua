
sellMultiplier = 1 -- placeholder basically

LOOT = {}

-- currently half life 2 because no weapons yet

-- types:
-- 1 == weapon
-- 2 == ammo
-- 3 == utility
-- 4 == special (for cluster strikes, airdrops, idk ill get creative)

-- format: array[type][weapon] = {tier(1 to 3), cost, buyLevel}

-- WEAPONS
LOOT[1] = {}
LOOT[1]["weapon_crowbar"]       = {1, 50,  0}
LOOT[1]["weapon_pistol"]        = {1, 100, 0}
LOOT[1]["weapon_357"]           = {2, 200, 3}
LOOT[1]["weapon_shotgun"]       = {2, 200, 2}
LOOT[1]["weapon_smg1"]          = {2, 300, 4}
LOOT[1]["weapon_ar2"]           = {3, 500, 5}
LOOT[1]["weapon_rpg"]           = {3, 650, 5}
LOOT[1]["weapon_crossbow"]      = {3, 350, 4}

-- format: array[type][ammo] = {tier, cost, buyCount}
-- buycount is how many ammo for the cost, so like a cost of 100 for a buycount of 20 means each round will cost 5 money
-- idk how selling is gonna work but probably not incremental

-- AMMUNITION

LOOT[2] = {}
LOOT[2]["Pistol"]               = {1, 40, 18}
LOOT[2]["357"]                  = {2, 75, 6}
LOOT[2]["Buckshot"]             = {2, 80, 6}
LOOT[2]["SMG1"]                 = {2, 90, 45}
LOOT[2]["AR2"]                  = {3, 200, 30}
LOOT[2]["RPG_Round"]            = {3, 400, 1}
LOOT[2]["XBowBolt"]             = {3, 90, 1}

LOOT[2]["SMG1_Grenade"]         = {3, 550, 1}
LOOT[2]["AR2AltFire"]           = {3, 400, 1}

-- this is gonna get refactored so many fucking times i can gurantee it

LOOT.FUNCTIONS = {}

LOOT.FUNCTIONS.CheckExists = {} -- idk why i thought this was needed (and it doesnt even fucking work)

LOOT.FUNCTIONS.CheckExists[1] = function(item)-- weapons
    return weapons.Get( item ) != nil -- if it equals nil then the weapon aint a weapon
end

LOOT.FUNCTIONS.CheckExists[2] = function(item) -- ammo
    return game.GetAmmoID( item ) != -1 -- if it equals -1 then the ammo just does not exist
end

LOOT.FUNCTIONS.PlayerHasItem = {}

LOOT.FUNCTIONS.PlayerHasItem[1] = function(ply, item, count) -- weapons
    return ply:HasWeapon( item )
end


LOOT.FUNCTIONS.PlayerHasItem[2] = function(ply, item, count) -- ammo
    if count == nil then count = 1 end
    return ply:GetAmmoCount(item) >= count
end

LOOT.FUNCTIONS.TakeItem = {}

LOOT.FUNCTIONS.TakeItem[1] = function(ply, item, count) -- weapons
    ply:StripWeapon(item)
end


LOOT.FUNCTIONS.TakeItem[2] = function(ply, item, count) -- ammo
    if count == nil then count = 1 end
    ply:RemoveAmmo(count, item)
end

LOOT.FUNCTIONS.GiveItem = {}

LOOT.FUNCTIONS.GiveItem[1] = function(ply, item, count) -- weapons
    ply:Give(item, true)
end


LOOT.FUNCTIONS.GiveItem[2] = function(ply, item, count) -- ammo
    if count == nil then count = 1 end
    ply:GiveAmmo(count, item, false)
end

LOOT.FUNCTIONS.GetCost = {}

LOOT.FUNCTIONS.GetCost[1] = function(item, count) -- weapons
    return LOOT[1][item][2] -- LOOT.Weapons.WeaponName.Cost (count dont matter)
end


LOOT.FUNCTIONS.GetCost[2] = function(item, count) -- ammo
    if count == nil then count = 1 end
    return (LOOT[2][item][2] / LOOT[2][item][3]) * count -- gets cost per bullet multiplied by the amount of bullets your rat ass wants
end