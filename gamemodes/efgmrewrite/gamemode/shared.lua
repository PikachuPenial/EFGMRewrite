GM.Name = "Escape From Garry's Mod 2"
GM.Author = "Porty & maybe penial idk yet"
GM.Email = "piss off"
GM.Website = "piss on"

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

include("sh_playermeta.lua")
