
EFGMITEMS = {}

// So far, [equipType]:
-- 1 is for weapons
-- 2 is for gear like rigs or backpacks
-- 3 is for unequippable shit like barter items
-- 4 could be for stuff that spawns into the world, idk tho imagine you start shooting a cheater and a HL2 jeep appears and he starts driving away

function EFGMITEMS:__index( var )

	return var or {
        ["displayName"] = "MISSING_ITEM",
        ["displayType"] = "???",
        ["weight"] = 0.1,
        ["value"] = 1,
        ["equipType"] = 4,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
    
        ["sizeX"] = 1,
        ["sizeY"] = 1
    }

end

// WEAPONS

    EFGMITEMS["arc9_eft_akm"] = {

        ["displayName"] = "AKM",
        ["displayType"] = "Assault Rifle",
        ["weight"] = 2.5,
        ["value"] = 12000,
        ["equipType"] = 1,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = "idk",

        ["sizeX"] = 5,
        ["sizeY"] = 2
    }

// GEAR (Rigs, Backpacks)

    EFGMITEMS["efgm_umka"] = {

        ["displayName"] = "Umka M33-SET1",
        ["displayType"] = "Chest Rig",
        ["weight"] = 1.2,
        ["value"] = 12000,
        ["equipType"] = 2,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = "idk",

        ["sizeX"] = 3,
        ["sizeY"] = 4,

        ["containerLayoutSizeX"] = 4, // for the positioning of the child slots, penial you can thank me later
        ["containerLayoutSizeY"] = 4, // also look in the reference folder to see what I'm getting at better
        
        ["childContainers"] = {

            { ["posX"] = 1, ["posY"] = 1, ["sizeX"] = 1, ["sizeY"] = 2 } // Top 4 1x2's
            { ["posX"] = 2, ["posY"] = 1, ["sizeX"] = 1, ["sizeY"] = 2 }
            { ["posX"] = 3, ["posY"] = 1, ["sizeX"] = 1, ["sizeY"] = 2 }
            { ["posX"] = 4, ["posY"] = 1, ["sizeX"] = 1, ["sizeY"] = 2 }

            { ["posX"] = 1, ["posY"] = 3, ["sizeX"] = 1, ["sizeY"] = 1 } // Bottom left 4 1x1's
            { ["posX"] = 2, ["posY"] = 3, ["sizeX"] = 1, ["sizeY"] = 1 }
            { ["posX"] = 1, ["posY"] = 4, ["sizeX"] = 1, ["sizeY"] = 1 }
            { ["posX"] = 2, ["posY"] = 4, ["sizeX"] = 1, ["sizeY"] = 1 }

            { ["posX"] = 3, ["posY"] = 3, ["sizeX"] = 2, ["sizeY"] = 2 } // Bottom right 2x2

        }
    }

// BARTER ITEMS / VALUABLES

    EFGMITEMS["efgm_roler"] = {

        ["displayName"] = "Roler Submariner",
        ["displayType"] = "Barter Item",
        ["weight"] = 0.18,
        ["value"] = 25000,
        ["equipType"] = 3,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = "idk",

        ["sizeX"] = 1,
        ["sizeY"] = 1
    }

// HL2 JEEP

    EFGMITEMS["hl2_jeep"] = {

        ["displayName"] = "The Jeep from Half Life 2",
        ["displayType"] = "Vehicle",
        ["weight"] = 1800,
        ["value"] = 69,
        ["equipType"] = 4,
        ["spawnOnEquip"] = "Jeep",
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = "idk",

        ["sizeX"] = 12,
        ["sizeY"] = 10

    }