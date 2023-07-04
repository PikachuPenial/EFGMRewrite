
-- TODO ASAP: SEPARATE LOOT FOR SPAWNING AND LOOT FOR PURCHASE

sellMultiplier = 1 -- placeholder basically

LOOT = {}

-- types:
-- 1 == weapon
-- 2 == ammo
-- 3 == entities

-- format: array[type][weapon] = {tier(1 to 3), cost, buyLevel}

-- WEAPONS
LOOT[1] = {}
LOOT[1]["arc9_eft_glock19x"]        = {1, 100, 0, 8}
LOOT[1]["arc9_eft_fn57"]            = {1, 150, 0, 8}
LOOT[1]["arc9_eft_glock17"]         = {1, 100, 0, 8}
LOOT[1]["arc9_eft_toz106"]          = {1, 150, 0, 5}
LOOT[1]["arc9_eft_mp18"]            = {1, 200, 0, 5}
LOOT[1]["arc9_eft_saiga9"]          = {1, 150, 0, 6}
LOOT[1]["arc9_eft_glock18c"]        = {2, 250, 0, 8}
LOOT[1]["arc9_eft_sag_ak545"]       = {2, 300, 2, 4}
LOOT[1]["arc9_eft_sag_ak545short"]  = {2, 300, 2, 4}
LOOT[1]["arc9_eft_vpo136"]          = {2, 350, 2, 4}
LOOT[1]["arc9_eft_vpo209"]          = {2, 250, 2, 4}
LOOT[1]["arc9_eft_rsh12"]           = {2, 250, 0, 8}
LOOT[1]["arc9_eft_ai_axmc"]         = {2, 450, 2, 7}
LOOT[1]["arc9_eft_saiga12k"]        = {2, 400, 2, 5}
LOOT[1]["arc9_eft_fn_p90"]          = {2, 350, 2, 6}
LOOT[1]["arc9_eft_pp1901"]          = {2, 300, 2, 6}
LOOT[1]["arc9_eft_akm"]             = {3, 450, 5, 2}
LOOT[1]["arc9_eft_ak74m"]           = {3, 500, 5, 2}
LOOT[1]["arc9_eft_ak74"]            = {3, 500, 5, 2}
LOOT[1]["arc9_eft_rpk16"]           = {3, 500, 5, 3}
LOOT[1]["arc9_eft_rd704"]           = {3, 500, 5, 2}
LOOT[1]["arc9_eft_ak105"]           = {3, 500, 5, 2}
LOOT[1]["arc9_eft_ak104"]           = {3, 500, 5, 2}
LOOT[1]["arc9_eft_ash12"]           = {3, 650, 5, 2}
LOOT[1]["arc9_eft_aks74u"]          = {3, 400, 5, 6}
LOOT[1]["arc9_eft_ak103"]           = {3, 500, 5, 2}
LOOT[1]["arc9_eft_ak102"]           = {3, 500, 5, 2}
LOOT[1]["arc9_eft_aks74"]           = {3, 400, 5, 2}
LOOT[1]["arc9_eft_akms"]            = {3, 450, 5, 2}
LOOT[1]["arc9_eft_ak101"]           = {3, 500, 5, 2}

-- format: array[type][ammo] = {tier, cost, buyCount}
-- buycount is how many ammo for the cost, so like a cost of 100 for a buycount of 20 means each round will cost 5 money
-- idk how selling is gonna work but probably not incremental

-- AMMUNITION

LOOT[2] = {}
LOOT[2]["Pistol"]                   = {1, 40, 18, 2}
LOOT[2]["357"]                      = {2, 75, 6, 2}
LOOT[2]["Buckshot"]                 = {2, 80, 6, 2}
LOOT[2]["SMG1"]                     = {2, 90, 45, 2}
LOOT[2]["AR2"]                      = {3, 200, 30, 2}
LOOT[2]["RPG_Round"]                = {3, 400, 1, 2}
LOOT[2]["XBowBolt"]                 = {3, 90, 1, 2}

LOOT[2]["SMG1_Grenade"]             = {3, 550, 1, 3}
LOOT[2]["AR2AltFire"]               = {3, 400, 1, 3}

concommand.Add("efgm_debug_shoplist", function(ply, cmd, args)

    print("[1] is the tier, [2] is the cost, [3] is the level needed to buy!")
    PrintTable(LOOT[1])
    print("[1] is the tier, [2] is the cost, [3] is the amount of bullets per paying the cost!")
    PrintTable(LOOT[2])

end)

LOOT.CATEGORIES = {}

LOOT.CATEGORIES[1] = {}
LOOT.CATEGORIES[1][1] = "Unknown"
LOOT.CATEGORIES[1][2] = "Assault Rifle"
LOOT.CATEGORIES[1][3] = "Light Machine Gun"
LOOT.CATEGORIES[1][4] = "Marksman Rifle"
LOOT.CATEGORIES[1][5] = "Shotgun"
LOOT.CATEGORIES[1][6] = "Submachine Gun"
LOOT.CATEGORIES[1][7] = "Sniper Rifle"
LOOT.CATEGORIES[1][8] = "Pistol"
LOOT.CATEGORIES[1][9] = "Knife"

LOOT.CATEGORIES[2] = {}
LOOT.CATEGORIES[2][1] = "Unknown"
LOOT.CATEGORIES[2][2] = "Primary"
LOOT.CATEGORIES[2][3] = "Alternate Fire"

-- this is gonna get refactored so many fucking times i can gurantee it

LOOT.FUNCTIONS = {}

LOOT.FUNCTIONS.CheckExists = {} -- ok its needed now

LOOT.FUNCTIONS.CheckExists[1] = function(item)-- weapons
    return LOOT[1][item] != nil -- if it equals nil then the weapon aint a weapon
end

LOOT.FUNCTIONS.CheckExists[2] = function(item) -- ammo
    return LOOT[2][item] != nil -- if it equals nil then the ammo just does not exist
end

LOOT.FUNCTIONS.PlayerHasItem = {}

LOOT.FUNCTIONS.PlayerHasItem[1] = function(ply, item, count) -- weapons
    return ply:HasWeapon( item )
end


LOOT.FUNCTIONS.PlayerHasItem[2] = function(ply, item, count) -- ammo
    return ply:GetAmmoCount(item) >= (count or 1)
end

LOOT.FUNCTIONS.TakeItem = {}

LOOT.FUNCTIONS.TakeItem[1] = function(ply, item, count) -- weapons
    ply:StripWeapon(item)
end


LOOT.FUNCTIONS.TakeItem[2] = function(ply, item, count) -- ammo
    ply:RemoveAmmo(count or 1, item)
end


LOOT.FUNCTIONS.GiveItem = {}

LOOT.FUNCTIONS.GiveItem[1] = function(ply, item, count) -- weapons
    ply:Give(item, true)
end


LOOT.FUNCTIONS.GiveItem[2] = function(ply, item, count) -- ammo
    ply:GiveAmmo(count or 1, item, false)
end


LOOT.FUNCTIONS.GetCost = {}

LOOT.FUNCTIONS.GetCost[1] = function(item, count) -- weapons
    return LOOT[1][item][2] -- LOOT.Weapons.WeaponName.Cost (count dont matter)
end


LOOT.FUNCTIONS.GetCost[2] = function(item, count) -- ammo
    local costPerBullet = LOOT[2][item][2] / LOOT[2][item][3]
    return costPerBullet * (count or 1) -- gets cost per bullet multiplied by the amount of bullets your rat ass wants
end


LOOT.FUNCTIONS.AddItems = {} -- returns count

LOOT.FUNCTIONS.AddItems[1] = function(count1, count2) -- weapons
    return 1
end

LOOT.FUNCTIONS.AddItems[2] = function(count1, count2) -- ammo
    return count1 or 1 + count2 or 1 -- gets cost per bullet multiplied by the amount of bullets your rat ass wants
end


LOOT.FUNCTIONS.GetStashIconInfo = {}

LOOT.FUNCTIONS.GetStashIconInfo[1] = function(item)

    local displayName, model, tier, category

    local weaponInfo = weapons.Get( item ) or {}

    displayName = weaponInfo["PrintName"] or weaponInfo["TrueName"] or item

    model = weaponInfo["WorldModel"] or "errorlmao"

    local lootInfo = LOOT[1][item] or {}

    tier = lootInfo[1] or 1

    category = LOOT.CATEGORIES[1][lootInfo[4]] or 1

    return displayName, model, tier, category

end

LOOT.FUNCTIONS.GetStashIconInfo[2] = function(item)

    print(item)

    local displayName, model, tier, category

    local lootInfo = LOOT[2][item] or {}

    tier = lootInfo[1] or 1

    category = LOOT.CATEGORIES[2][lootInfo[4]] or 1

    return displayName or item, model or "errorlol", tier, category

end


LOOT.FUNCTIONS.GetShopIconInfo = {}

LOOT.FUNCTIONS.GetShopIconInfo[1] = function(item)

    local displayName, model, tier, category, price

    local weaponInfo = weapons.Get( item ) or {}

    displayName = weaponInfo["PrintName"] or weaponInfo["TrueName"] or item

    model = weaponInfo["WorldModel"] or "errorlmao"

    local lootInfo = LOOT[1][item] or {}

    tier = lootInfo[1] or 1

    category = LOOT.CATEGORIES[1][lootInfo[4]] or 1

    price = lootInfo[2]

    return displayName, model, tier, category, price

end

LOOT.FUNCTIONS.GetShopIconInfo[2] = function(item)

    print(item)

    local displayName, model, tier, category, price

    local lootInfo = LOOT[2][item] or {}

    tier = lootInfo[1] or 1

    category = LOOT.CATEGORIES[2][lootInfo[4]] or 1

    price = lootInfo[2] or 0

    return displayName or item, model or "errorlol", tier, category, price

end