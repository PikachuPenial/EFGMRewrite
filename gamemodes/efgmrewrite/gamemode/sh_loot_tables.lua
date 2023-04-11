
LOOT = {}

-- currently half life 2 because no weapons yet

-- format: array[weaponString] = {tier(1 to 3), cost, buyLevel}

-- tiers:
-- 1 == low
-- 2 == medium
-- 3 == high

-- types:
-- 1 == weapon
-- 2 == utility
-- 3 == armor
-- 4 == special (for cluster strikes, airdrops, idk ill get creative)

LOOT[1] = {}

LOOT[1]["weapon_pistol"]       = {1, 100, 0}
LOOT[1]["weapon_crowbar"]      = {1, 50,  0}
LOOT[1]["weapon_357"]          = {2, 200, 3}
LOOT[1]["weapon_shotgun"]      = {2, 200, 2}
LOOT[1]["weapon_smg1"]         = {2, 300, 4}
LOOT[1]["weapon_ar2"]          = {3, 500, 5}
LOOT[1]["weapon_rpg"]          = {3, 650, 5}
LOOT[1]["weapon_crossbow"]     = {3, 350, 4}