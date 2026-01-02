-- lua enum approx because fuck me and fuck you (and fuck ttt because thats how im learning metatables, please refer to words 5 through 9)

-- player status
-- the DUEL enum here is just not fucking working, i can print it here and it shows, i can print it anywhere else and its fucking nil, its 6am, i dont want to find out why, fuck my retarded Garry's Mod life - penial
playerStatus = {
    LOBBY = 0,
    PMC = 1,
    SCAV = 2,
    DUEL = 3,
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

-- tried to make shit adjustable, that way you could say fuck it and let everyone carry 100 grenades or knives or both or neither and it'd let them
-- that could even be added with like convars and shit
-- max of 4 bits yada yada yada you surely get it by now
WEAPONSLOTS = {
    PRIMARY =       {ID = 1, COUNT = 2},
    HOLSTER =       {ID = 2, COUNT = 1},
    MELEE =         {ID = 3, COUNT = 1},
    GRENADE =       {ID = 4, COUNT = 1},
    CONSUMABLE =    {ID = 5, COUNT = 1}
}

CONSUMABLETYPES = {
    MEDKIT = 0,
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

QUOTES = {
    "nobody is sending any quotes so have this one! -penial",
}