
sellMultiplier = 1 -- placeholder basically

ITEMS = {}

-- types:
-- 1 == weapon
-- 2 == ammo
-- 3 == entities

-- format: array[weapon] = {type, category, cost, buyLevel, buyCount}

-- WEAPONS
ITEMS = {}
ITEMS["arc9_eft_glock19x"]          = {1, cat.Pistol    , 100, 1, 1}
ITEMS["arc9_eft_fn57"]              = {1, cat.Pistol    , 150, 1, 1}
ITEMS["arc9_eft_glock17"]           = {1, cat.Pistol    , 100, 1, 1}
ITEMS["arc9_eft_toz106"]            = {1, cat.Shotgun   , 150, 1, 1}
ITEMS["arc9_eft_mp18"]              = {1, cat.Sniper    , 200, 1, 1}
ITEMS["arc9_eft_saiga9"]            = {1, cat.SMG       , 150, 1, 1}
ITEMS["arc9_eft_glock18c"]          = {1, cat.Pistol    , 250, 1, 1}
ITEMS["arc9_eft_sag_ak545"]         = {1, cat.AR        , 300, 1, 1}
ITEMS["arc9_eft_sag_ak545short"]    = {1, cat.AR        , 300, 1, 1}
ITEMS["arc9_eft_vpo136"]            = {1, cat.DMR       , 350, 1, 1}
ITEMS["arc9_eft_vpo209"]            = {1, cat.DMR       , 250, 1, 1}
ITEMS["arc9_eft_rsh12"]             = {1, cat.Pistol    , 250, 1, 1}
ITEMS["arc9_eft_ai_axmc"]           = {1, cat.Sniper    , 450, 1, 1}
ITEMS["arc9_eft_saiga12k"]          = {1, cat.Shotgun   , 400, 1, 1}
ITEMS["arc9_eft_fn_p90"]            = {1, cat.SMG       , 350, 1, 1}
ITEMS["arc9_eft_pp1901"]            = {1, cat.SMG       , 300, 1, 1}
ITEMS["arc9_eft_akm"]               = {1, cat.AR        , 450, 1, 1}
ITEMS["arc9_eft_ak74m"]             = {1, cat.AR        , 500, 1, 1}
ITEMS["arc9_eft_ak74"]              = {1, cat.AR        , 500, 1, 1}
ITEMS["arc9_eft_rpk16"]             = {1, cat.LMG       , 500, 1, 1}
ITEMS["arc9_eft_rd704"]             = {1, cat.AR        , 500, 1, 1}
ITEMS["arc9_eft_ak105"]             = {1, cat.AR        , 500, 1, 1}
ITEMS["arc9_eft_ak104"]             = {1, cat.AR        , 500, 1, 1}
ITEMS["arc9_eft_ash12"]             = {1, cat.AR        , 650, 1, 1}
ITEMS["arc9_eft_aks74u"]            = {1, cat.SMG       , 400, 1, 1}
ITEMS["arc9_eft_ak103"]             = {1, cat.AR        , 500, 1, 1}
ITEMS["arc9_eft_ak102"]             = {1, cat.AR        , 500, 1, 1}
ITEMS["arc9_eft_aks74"]             = {1, cat.AR        , 400, 1, 1}
ITEMS["arc9_eft_akms"]              = {1, cat.AR        , 450, 1, 1}
ITEMS["arc9_eft_ak101"]             = {1, cat.AR        , 500, 1, 1}

ITEMS["Pistol"]                     = {2, cat.Main      , 40, 1, 18}
ITEMS["357"]                        = {2, cat.Main      , 75, 1, 6}
ITEMS["Buckshot"]                   = {2, cat.Main      , 80, 1, 6}
ITEMS["SMG1"]                       = {2, cat.Main      , 90, 1, 45}
ITEMS["AR2"]                        = {2, cat.Main      , 200, 1, 30}
ITEMS["RPG_Round"]                  = {2, cat.Main      , 400, 1, 1}
ITEMS["XBowBolt"]                   = {2, cat.Main      , 90, 1, 1}
ITEMS["SMG1_Grenade"]               = {2, cat.Alt       , 550, 1, 1}
ITEMS["AR2AltFire"]                 = {2, cat.Alt       , 400, 1, 1}

concommand.Add("efgm_debug_shoplist", function(ply, cmd, args)

    local itemString = "ITEM (Type, Category, Cost per Item, Required Level)\n\n"

    -- for readability
    local int = 0

    local tbl = {} tbl[1] = "Weapon" tbl[2] = "Ammo"

    for k, v in pairs(ITEMS) do -- k is "itemname", v is {1, 2, 3, 4, 5}

        int = int + 1

        itemString = itemString .. k .. " ("..tbl[v[1]]..", "..revCat[v[2]]..", $".. math.Round( v[3]/v[5], 2 )..", "..v[4]..")\n"

        if int == 4 then
            
            int = 0

            itemString = itemString .. "\n"

        end

    end

    print(itemString)

end)

CheckExists = {} -- ok its needed now

CheckExists[1] = function(item)-- weapons
    return ITEMS[item] != nil -- if it equals nil then the weapon aint a weapon
end

CheckExists[2] = function(item) -- ammo
    return ITEMS[item] != nil -- if it equals nil then the ammo just does not exist
end

PlayerHasItem = {}

PlayerHasItem[1] = function(ply, item, count) -- weapons
    return ply:HasWeapon( item )
end


PlayerHasItem[2] = function(ply, item, count) -- ammo
    return ply:GetAmmoCount(item) >= (count or 1)
end

TakeItem = {}

TakeItem[1] = function(ply, item, count) -- weapons
    ply:StripWeapon(item)
end


TakeItem[2] = function(ply, item, count) -- ammo
    ply:RemoveAmmo(count or 1, item)
end


GiveItem = {}

GiveItem[1] = function(ply, item, count, hidePopup) -- weapons
    ply:Give(item, true)
end

GiveItem[2] = function(ply, item, count, hidePopup) -- ammo
    ply:GiveAmmo(count or 1, item, hidePopup or true)
end


GetCost = {}

GetCost[1] = function(item, count) -- weapons
    return ITEMS[item][3] -- ITEMS.Weapons.WeaponName.Cost (count dont matter)
end

GetCost[2] = function(item, count) -- ammo
    local costPerBullet = ITEMS[item][3] / ITEMS[item][5]
    return math.ceil(costPerBullet * (count or 1)) -- gets cost per bullet multiplied by the amount of bullets your rat ass wants
end


AddItems = {} -- returns count

AddItems[1] = function(count1, count2) -- weapons
    return 1
end

AddItems[2] = function(count1, count2) -- ammo
    return count1 or 1 + count2 or 1 -- gets cost per bullet multiplied by the amount of bullets your rat ass wants
end


GetShopIconInfo = {}

GetShopIconInfo[1] = function(item)

    local displayName, model, category, price

    local weaponInfo = weapons.Get( item ) or {}

    displayName = weaponInfo["PrintName"] or weaponInfo["TrueName"] or item

    model = weaponInfo["WorldModel"] or "errorlmao"

    local lootInfo = ITEMS[item] or {}

    category = lootInfo[2] or 1

    price = lootInfo[3]

    return displayName, model, category, price

end

GetShopIconInfo[2] = function(item)

    local displayName, category, price

    local lootInfo = ITEMS[item] or {}

    category = lootInfo[2] or 1

    price = GetCost[2](item, 1)

    return displayName or item, models[item] or "errorlol", category, price

end