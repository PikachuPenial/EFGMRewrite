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
    Knife = 9,
    Grenade = 10,
    RPG = 11,

    Main = 17,
    Alt = 18
}

revCat = {}

for k, v in pairs(cat) do
    revCat[v] = k
end