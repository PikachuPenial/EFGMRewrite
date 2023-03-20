
sellArray = {}

local tempWeaponsArray = {}

-- currently half life 2 because no weapons yet

-- format: array[weaponString] = {cost, buyLevel}
-- that way instead of searching the entire table to see if you can sell something,
-- just do "if sellArray.Weapons.weaponName then"
tempWeaponsArray["weapon_ar2"]          = {500, 5}
tempWeaponsArray["weapon_smg1"]         = {300, 4}
tempWeaponsArray["weapon_pistol"]       = {100, 0}
tempWeaponsArray["weapon_357"]          = {200, 3}
tempWeaponsArray["weapon_shotgun"]      = {200, 2}
tempWeaponsArray["weapon_rpg"]          = {650, 5}
tempWeaponsArray["weapon_crossbow"]     = {250, 4}
tempWeaponsArray["weapon_crowbar"]      = {50,  0}

sellArray.Weapons = tempWeaponsArray -- may change this idk