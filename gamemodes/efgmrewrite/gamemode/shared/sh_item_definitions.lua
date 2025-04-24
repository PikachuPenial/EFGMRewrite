EQUIPTYPE = {}
EQUIPTYPE.Weapon = 1
EQUIPTYPE.Gear = 2
EQUIPTYPE.None = 3
EQUIPTYPE.Spawn = 4 // For shit that spawns into the world on equip

EFGMITEMS = {}

function EFGMITEMS:__index( var )
	return {
        ["fullName"] = "MISSING_ITEM",
        ["displayName"] = "MISSING",
        ["displayType"] = "???",
        ["weight"] = 0.1,
        ["value"] = 0,
        ["equipType"] = EQUIPTYPE.None,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = "missing",

        ["sizeX"] = 1,
        ["sizeY"] = 1
    }
end

// WEAPONS
    EFGMITEMS["arc9_eft_akm"] = {

        ["fullName"] = "AKM",
        ["displayName"] = "AKM",
        ["displayType"] = "Assault Rifle",
        ["weight"] = 2.5,
        ["value"] = 12000,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = "idk",

        ["sizeX"] = 5,
        ["sizeY"] = 2
    }

// RIGS
    EFGMITEMS["efgm_umka"] = {

        ["fullName"] = "Umka M33-SET1",
        ["displayName"] = "Umka",
        ["displayType"] = "Chest Rig",
        ["weight"] = 1.2,
        ["value"] = 12000,
        ["equipType"] = EQUIPTYPE.Gear,
        ["equipmentType"] = "rig",
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = "idk",

        ["sizeX"] = 3,
        ["sizeY"] = 4,

        ["containerLayoutSizeX"] = 4, // for the positioning of the child slots, penial you can thank me later
        ["containerLayoutSizeY"] = 4, // also look in the reference folder to see what I'm getting at better

        ["childContainers"] = {
            { ["posX"] = 1, ["posY"] = 1, ["sizeX"] = 1, ["sizeY"] = 2 }, // Top 4 1x2's
            { ["posX"] = 2, ["posY"] = 1, ["sizeX"] = 1, ["sizeY"] = 2 },
            { ["posX"] = 3, ["posY"] = 1, ["sizeX"] = 1, ["sizeY"] = 2 },
            { ["posX"] = 4, ["posY"] = 1, ["sizeX"] = 1, ["sizeY"] = 2 },

            { ["posX"] = 1, ["posY"] = 3, ["sizeX"] = 1, ["sizeY"] = 1 }, // Bottom left 4 1x1's
            { ["posX"] = 2, ["posY"] = 3, ["sizeX"] = 1, ["sizeY"] = 1 },
            { ["posX"] = 1, ["posY"] = 4, ["sizeX"] = 1, ["sizeY"] = 1 },
            { ["posX"] = 2, ["posY"] = 4, ["sizeX"] = 1, ["sizeY"] = 1 },

            { ["posX"] = 3, ["posY"] = 3, ["sizeX"] = 2, ["sizeY"] = 2 } // Bottom right 2x2
        }
    }

// POCKETS
    EFGMITEMS["efgm_default_pockets"] = {

        ["fullName"] = "",
        ["displayName"] = "",
        ["displayType"] = "",
        ["weight"] = 0,
        ["value"] = 0,
        ["equipType"] = EQUIPTYPE.Gear,
        ["equipmentType"] = "pockets",
        ["appearInInventory"] = false,
        ["stackSize"] = 1,
        ["icon"] = "",

        ["sizeX"] = 1,
        ["sizeY"] = 1,

        ["containerLayoutSizeX"] = 4,
        ["containerLayoutSizeY"] = 1,

        ["childContainers"] = {
            { ["posX"] = 1, ["posY"] = 1, ["sizeX"] = 1, ["sizeY"] = 1 },
            { ["posX"] = 2, ["posY"] = 1, ["sizeX"] = 1, ["sizeY"] = 1 },
            { ["posX"] = 3, ["posY"] = 1, ["sizeX"] = 1, ["sizeY"] = 1 },
            { ["posX"] = 4, ["posY"] = 1, ["sizeX"] = 1, ["sizeY"] = 1 }
        }
    }

    EFGMITEMS["efgm_alt_pockets"] = {

        ["fullName"] = "",
        ["displayName"] = "",
        ["displayType"] = "",
        ["weight"] = 0,
        ["value"] = 0,
        ["equipType"] = EQUIPTYPE.Gear,
        ["equipmentType"] = "pockets",
        ["appearInInventory"] = false,
        ["stackSize"] = 1,
        ["icon"] = "",

        ["sizeX"] = 1,
        ["sizeY"] = 1,

        ["containerLayoutSizeX"] = 1,
        ["containerLayoutSizeY"] = 2,

        ["childContainers"] = {
            { ["posX"] = 1, ["posY"] = 1, ["sizeX"] = 1, ["sizeY"] = 2 }
        }
    }

    EFGMITEMS["efgm_eod_pockets"] = {

        ["fullName"] = "",
        ["displayName"] = "",
        ["displayType"] = "",
        ["weight"] = 0,
        ["value"] = 0,
        ["equipType"] = EQUIPTYPE.Gear,
        ["equipmentType"] = "pockets",
        ["appearInInventory"] = false,
        ["stackSize"] = 1,
        ["icon"] = "",

        ["sizeX"] = 1,
        ["sizeY"] = 1,

        ["containerLayoutSizeX"] = 4,
        ["containerLayoutSizeY"] = 2,

        ["childContainers"] = {
            { ["posX"] = 1, ["posY"] = 1, ["sizeX"] = 1, ["sizeY"] = 1 },
            { ["posX"] = 2, ["posY"] = 1, ["sizeX"] = 1, ["sizeY"] = 2 },
            { ["posX"] = 3, ["posY"] = 1, ["sizeX"] = 1, ["sizeY"] = 2 },
            { ["posX"] = 4, ["posY"] = 1, ["sizeX"] = 1, ["sizeY"] = 1 }
        }
    }

// BACKPACKS
    EFGMITEMS["efgm_daypack"] = {

        ["fullName"] = "LBT-8005A Day Pack",
        ["displayName"] = "Daypack",
        ["displayType"] = "Backpack",
        ["weight"] = 0.57,
        ["value"] = 22000,
        ["equipType"] = EQUIPTYPE.Gear,
        ["equipmentType"] = "backpack",
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = "idk",

        ["sizeX"] = 4,
        ["sizeY"] = 5,

        ["containerLayoutSizeX"] = 4,
        ["containerLayoutSizeY"] = 5,

        ["childContainers"] = {
            { ["posX"] = 1, ["posY"] = 1, ["sizeX"] = 4, ["sizeY"] = 5 }
        }
    }

// SECURE CONTAINERS
    EFGMITEMS["efgm_sc_alpha"] = {

        ["fullName"] = "Secure Container Alpha",
        ["displayName"] = "Alpha",
        ["displayType"] = "Secure Container",
        ["weight"] = 0.6,
        ["value"] = 0,
        ["equipType"] = EQUIPTYPE.Gear,
        ["equipmentType"] = "sc",
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = "idk",

        ["sizeX"] = 2,
        ["sizeY"] = 2,

        ["containerLayoutSizeX"] = 2,
        ["containerLayoutSizeY"] = 2,

        ["childContainers"] = {
            { ["posX"] = 1, ["posY"] = 1, ["sizeX"] = 2, ["sizeY"] = 2 }
        }
    }

    EFGMITEMS["efgm_sc_beta"] = {

        ["fullName"] = "Secure Container Beta",
        ["displayName"] = "Beta",
        ["displayType"] = "Secure Container",
        ["weight"] = 0.8,
        ["value"] = 0,
        ["equipType"] = EQUIPTYPE.Gear,
        ["equipmentType"] = "sc",
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = "idk",

        ["sizeX"] = 3,
        ["sizeY"] = 2,

        ["containerLayoutSizeX"] = 3,
        ["containerLayoutSizeY"] = 2,

        ["childContainers"] = {
            { ["posX"] = 1, ["posY"] = 1, ["sizeX"] = 3, ["sizeY"] = 2 }
        }
    }

    EFGMITEMS["efgm_sc_epsilon"] = {

        ["fullName"] = "Secure Container Epsilon",
        ["displayName"] = "Epsilon",
        ["displayType"] = "Secure Container",
        ["weight"] = 1.1,
        ["value"] = 0,
        ["equipType"] = EQUIPTYPE.Gear,
        ["equipmentType"] = "sc",
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = "idk",

        ["sizeX"] = 4,
        ["sizeY"] = 2,

        ["containerLayoutSizeX"] = 4,
        ["containerLayoutSizeY"] = 2,

        ["childContainers"] = {
            { ["posX"] = 1, ["posY"] = 1, ["sizeX"] = 4, ["sizeY"] = 2 }
        }
    }

    EFGMITEMS["efgm_sc_gamma"] = {

        ["fullName"] = "Secure Container Gamma",
        ["displayName"] = "Gamma",
        ["displayType"] = "Secure Container",
        ["weight"] = 1.2,
        ["value"] = 0,
        ["equipType"] = EQUIPTYPE.Gear,
        ["equipmentType"] = "sc",
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = "idk",

        ["sizeX"] = 3,
        ["sizeY"] = 3,

        ["containerLayoutSizeX"] = 3,
        ["containerLayoutSizeY"] = 3,

        ["childContainers"] = {
            { ["posX"] = 1, ["posY"] = 1, ["sizeX"] = 3, ["sizeY"] = 3 }
        }
    }

    EFGMITEMS["efgm_sc_kappa"] = {

        ["fullName"] = "Secure Container Kappa",
        ["displayName"] = "Kappa",
        ["displayType"] = "Secure Container",
        ["weight"] = 2,
        ["value"] = 0,
        ["equipType"] = EQUIPTYPE.Gear,
        ["equipmentType"] = "sc",
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = "idk",

        ["sizeX"] = 3,
        ["sizeY"] = 3,

        ["containerLayoutSizeX"] = 3,
        ["containerLayoutSizeY"] = 4,

        ["childContainers"] = {
            { ["posX"] = 1, ["posY"] = 1, ["sizeX"] = 3, ["sizeY"] = 4 }
        }
    }

// BARTER ITEMS / VALUABLES
    EFGMITEMS["efgm_roler"] = {

        ["fullName"] = "Roler Submariner",
        ["displayType"] = "Barter Item",
        ["weight"] = 0.18,
        ["value"] = 25000,
        ["equipType"] = EQUIPTYPE.None,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = "idk",

        ["sizeX"] = 1,
        ["sizeY"] = 1
    }

// HL2 JEEP
    EFGMITEMS["hl2_jeep"] = {

        ["fullName"] = "The Jeep from Half Life 2",
        ["displayType"] = "Vehicle",
        ["weight"] = 1800,
        ["value"] = 69,
        ["equipType"] = EQUIPTYPE.Spawn,
        ["spawnOnEquip"] = "Jeep",
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = "idk",

        ["sizeX"] = 12,
        ["sizeY"] = 10

    }