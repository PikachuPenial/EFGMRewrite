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

        itemString = itemString .. k .. " (" .. tbl[v[1]] .. ", " .. revCat[v[2]] .. ", $" .. math.Round(v[3]/v[5], 2) .. ", " .. v[4] .. ")\n"

        if int == 4 then
            int = 0
            itemString = itemString .. "\n"
        end
    end

    print(itemString)
end)
