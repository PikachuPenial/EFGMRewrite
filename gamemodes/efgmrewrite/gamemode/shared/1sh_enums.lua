-- lua enum approx because fuck me and fuck you (and fuck ttt because thats how im learning metatables, please refer to words 5 through 9)

-- player status
playerStatus = {
    LOBBY = 0,
    PMC = 1,
    SCAV = 2,
    DUEL = 3 -- i do not like putting this here one bit
}

-- raid status
raidStatus = {
    PENDING = 0,
    ACTIVE = 1,
    ENDED = 2
}

-- duel status
duelStatus = {
    PENDING = 0,
    ACTIVE = 1
}

-- Tried to make shit adjustable, that way you could say fuck it and let everyone carry 100 grenades or knives or both or neither and it'd let them
-- That could even be added with like convars and shit
WEAPONSLOTS = {
    PRIMARY = { ID = 1, COUNT = 2},
    HOLSTER = { ID = 2, COUNT = 1},
    MELEE = { ID = 3, COUNT = 1},
    GRENADE = { ID = 4, COUNT = 1},
    UTILITY = { ID = 5, COUNT = 3}
}

HITGROUPS = {
    [1] = "HEAD, EYES",
    [2] = "CHEST",
    [3] = "STOMACH",
    [4] = "LEFT ARM",
    [5] = "RIGHT ARM",
    [6] = "LEFT LEG",
    [7] = "RIGHT LEG"
}

models = {
    -- k == itemname, v == modelpath

    ["Pistol"] = "models/Items/BoxSRounds.mdl",
    ["357"] = "models/Items/357ammo.mdl",
    ["Buckshot"] = "models/Items/BoxBuckshot.mdl",
    ["SMG1"] = "models/Items/BoxMRounds.mdl",
    ["AR2"] = "models/Items/combine_rifle_cartridge01.mdl",
    ["RPG_Round"] = "models/items/ammocrate_rockets.mdl",
    ["XBowBolt"] = "models/Items/CrossbowRounds.mdl",
    ["SMG1_Grenade"] = "models/Items/AR2_Grenade.mdl",
    ["AR2AltFire"] = "models/Items/combine_rifle_ammo01.mdl"
}