-- lua enum approx because fuck me and fuck you (and fuck ttt because thats how im learning metatables, please refer to words 5 through 9)

-- player status
playerStatus = {
    LOBBY = 0,
    PMC = 1,
    SCAV = 2
}

-- raid status
raidStatus = {
    PENDING = 0,
    ACTIVE = 1,
    ENDED = 2
}

cat = { -- theres a limit on 16 each but idc
    Unknown = 1,
    AR = 2,
    LMG = 3,
    DMR = 4,
    Shotgun = 5,
    SMG = 6,
    Sniper = 7,
    Pistol = 8,
    Melee = 9,
    Grenade = 10,
    RPG = 11,

    Main = 17,
    Alt = 18
}

-- Tried to make shit adjustable, that way you could say fuck it and let everyone carry 100 grenades or knives or both or neither and it'd let them
-- That could even be added with like convars and shit

WEAPONSLOTS = {
    PRIMARY = { ID = 1, COUNT = 2},
    HOLSTER = { ID = 2, COUNT = 1},
    MELEE = { ID = 3, COUNT = 1},
    GRENADE = { ID = 4, COUNT = 2},
    UTILITY = { ID = 5, COUNT = 3}
}

revCat = {}

for k, v in pairs(cat) do
    revCat[v] = k
end

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
    ["AR2AltFire"] = "models/Items/combine_rifle_ammo01.mdl",
}