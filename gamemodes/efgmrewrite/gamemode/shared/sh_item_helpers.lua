

-- TODO: Add a more complex item behavior system than types

CheckExists = {} -- ok its needed now

CheckExists[1] = function(item)-- weapons
    return ITEMS[item] != nil
end

CheckExists[2] = function(item) -- ammo
    return ITEMS[item] != nil
end

CheckExists[3] = function(item) -- attatchment
    return ITEMS[item] != nil
end

PlayerHasItem = {}

PlayerHasItem[1] = function(ply, item, count) -- weapons
    return ply:HasWeapon( item )
end

PlayerHasItem[2] = function(ply, item, count) -- ammo
    return ply:GetAmmoCount(item) >= (count or 1)
end

PlayerHasItem[3] = function(ply, item, count) -- attatchment
    return false -- idk how to do that
end

TakeItem = {}

TakeItem[1] = function(ply, item, count) -- weapons
    ply:StripWeapon(item)
end

TakeItem[2] = function(ply, item, count) -- ammo
    ply:RemoveAmmo(count or 1, item)
end

GiveItem = {}

GiveItem[1] = function(ply, item, count, noReserveAmmo) -- weapons
    ply:Give(item, noReserveAmmo or true)
end

GiveItem[2] = function(ply, item, count, noReserveAmmo) -- ammo
    ply:GiveAmmo(count or 1, item, true)
end

GiveItem[3] = function(ply, item, count, noReserveAmmo) -- attatchment
    ARC9:PlayerGiveAtt(ply, item, count or 1)
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
    return (count1 or 1) + (count2 or 1)
end

AddItems[3] = function(count1, count2) -- attatchments
    return (count1 or 1) + (count2 or 1)
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