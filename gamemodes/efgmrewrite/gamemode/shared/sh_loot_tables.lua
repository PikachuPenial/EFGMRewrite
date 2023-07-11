
-- TODO ASAP: SEPARATE LOOT FOR SPAWNING AND LOOT FOR PURCHASE

sellMultiplier = 1 -- placeholder basically

LOOT = {}

-- types:
-- 1 == weapon
-- 2 == ammo
-- 3 == entities

-- format: array[type][weapon] = {tier(1 to 3)}

-- WEAPONS
LOOT[1] = {}
LOOT[1]["arc9_eft_glock19x"]        = {1}
LOOT[1]["arc9_eft_fn57"]            = {1}
LOOT[1]["arc9_eft_glock17"]         = {1}
LOOT[1]["arc9_eft_toz106"]          = {1}
LOOT[1]["arc9_eft_mp18"]            = {1}
LOOT[1]["arc9_eft_saiga9"]          = {1}
LOOT[1]["arc9_eft_glock18c"]        = {2}
LOOT[1]["arc9_eft_sag_ak545"]       = {2}
LOOT[1]["arc9_eft_sag_ak545short"]  = {2}
LOOT[1]["arc9_eft_vpo136"]          = {2}
LOOT[1]["arc9_eft_vpo209"]          = {2}
LOOT[1]["arc9_eft_rsh12"]           = {2}
LOOT[1]["arc9_eft_saiga12k"]        = {2}
LOOT[1]["arc9_eft_fn_p90"]          = {2}
LOOT[1]["arc9_eft_pp1901"]          = {2}
LOOT[1]["arc9_eft_akm"]             = {3}
LOOT[1]["arc9_eft_ak74m"]           = {3}
LOOT[1]["arc9_eft_ak74"]            = {3}
LOOT[1]["arc9_eft_rpk16"]           = {3}
LOOT[1]["arc9_eft_rd704"]           = {3}
LOOT[1]["arc9_eft_ak105"]           = {3}
LOOT[1]["arc9_eft_ak104"]           = {3}
LOOT[1]["arc9_eft_ash12"]           = {3}
LOOT[1]["arc9_eft_aks74u"]          = {3}
LOOT[1]["arc9_eft_ak103"]           = {3}
LOOT[1]["arc9_eft_ak102"]           = {3}
LOOT[1]["arc9_eft_aks74"]           = {3}
LOOT[1]["arc9_eft_akms"]            = {3}
LOOT[1]["arc9_eft_ak101"]           = {3}
LOOT[1]["arc9_eft_ai_axmc"]         = {3}