EQUIPTYPE = {}
EQUIPTYPE.Weapon = 1
EQUIPTYPE.Gear = 2
EQUIPTYPE.None = 3
EQUIPTYPE.Spawn = 4 -- for shit that spawns into the world on equip

EFGMITEMS = {}

function EFGMITEMS:__index(var)
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

-- WEAPONS
    -- assault carbines
    EFGMITEMS["arc9_eft_adar15"] = {
        ["fullName"] = "ADAR 2-15 5.56x45 carbine",
        ["displayName"] = "ADAR 2-15",
        ["displayType"] = "Assault Carbine",
        ["weight"] = 2.9,
        ["value"] = 41000,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["wepSlot"] = "Primary",
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = "items/weapons/adar15.png",

        ["sizeX"] = 5,
        ["sizeY"] = 2
    }

    EFGMITEMS["arc9_eft_vsk94"] = {
        ["fullName"] = "KBP VSK-94 9x39 rifle",
        ["displayName"] = "VSK-94",
        ["displayType"] = "Assault Carbine",
        ["weight"] = 2.9,
        ["value"] = 65000,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["wepSlot"] = "Primary",
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = "items/weapons/vsk94.png",

        ["sizeX"] = 5,
        ["sizeY"] = 2
    }

    EFGMITEMS["arc9_eft_rfb"] = {
        ["fullName"] = "Kel-Tec RFB 7.62x51 rifle",
        ["displayName"] = "Kal-Tec RFB",
        ["displayType"] = "Assault Carbine",
        ["weight"] = 3.6,
        ["value"] = 54000,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["wepSlot"] = "Primary",
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = "items/weapons/rfb.png",

        ["sizeX"] = 4,
        ["sizeY"] = 2
    }

    EFGMITEMS["arc9_eft_tx15"] = {
        ["fullName"] = "Lone Star TX-15 DML 5.56x45 carbine",
        ["displayName"] = "TX-15 DML",
        ["displayType"] = "Assault Carbine",
        ["weight"] = 3.3,
        ["value"] = 95000,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["wepSlot"] = "Primary",
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = "items/weapons/tx15.png",

        ["sizeX"] = 6,
        ["sizeY"] = 2
    }

    EFGMITEMS["arc9_eft_sag_ak545"] = {
        ["fullName"] = "SAG AK-545 5.45x39 carbine",
        ["displayName"] = "AK-545",
        ["displayType"] = "Assault Carbine",
        ["weight"] = 4.4,
        ["value"] = 54000,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["wepSlot"] = "Primary",
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = "items/weapons/sag_ak545.png",

        ["sizeX"] = 5,
        ["sizeY"] = 2
    }

    EFGMITEMS["arc9_eft_sag_ak545short"] = {
        ["fullName"] = "SAG AK-545 Short 5.45x39 carbine",
        ["displayName"] = "AK-545 Short",
        ["displayType"] = "Assault Carbine",
        ["weight"] = 4.3,
        ["value"] = 63000,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["wepSlot"] = "Primary",
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = "items/weapons/sag_ak545_short.png",

        ["sizeX"] = 4,
        ["sizeY"] = 2
    }

    EFGMITEMS["arc9_eft_sr3"] = {
        ["fullName"] = "SR-3M 9x39 compact assault rifle",
        ["displayName"] = "SR-3M",
        ["displayType"] = "Assault Carbine",
        ["weight"] = 2.5,
        ["value"] = 147000,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["wepSlot"] = "Primary",
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = "items/weapons/sr3m.png",

        ["sizeX"] = 3,
        ["sizeY"] = 2
    }

    EFGMITEMS["arc9_eft_svt"] = {
        ["fullName"] = "Tokarev SVT-40 7.62x54R rifle",
        ["displayName"] = "SVT-40",
        ["displayType"] = "Assault Carbine",
        ["weight"] = 4.1,
        ["value"] = 64000,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["wepSlot"] = "Primary",
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = "items/weapons/svt.png",

        ["sizeX"] = 6,
        ["sizeY"] = 1
    }

    EFGMITEMS["arc9_eft_sks"] = {
        ["fullName"] = "TOZ Simonov SKS 7.62x39 carbine",
        ["displayName"] = "SKS",
        ["displayType"] = "Assault Carbine",
        ["weight"] = 3.7,
        ["value"] = 29000,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["wepSlot"] = "Primary",
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = "items/weapons/sks.png",

        ["sizeX"] = 5,
        ["sizeY"] = 1
    }

    EFGMITEMS["arc9_eft_vpo101"] = {
        ["fullName"] = "Molot Arms VPO-101 Vepr-Hunter 7.62x51 carbine",
        ["displayName"] = "VPO-101 Vepr-Hunter",
        ["displayType"] = "Assault Carbine",
        ["weight"] = 3.8,
        ["value"] = 44000,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["wepSlot"] = "Primary",
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = "items/weapons/vpo101.png",

        ["sizeX"] = 5,
        ["sizeY"] = 2
    }

    EFGMITEMS["arc9_eft_vpo136"] = {
        ["fullName"] = "Molot Arms VPO-136 Vepr-KM 7.62x39 carbine",
        ["displayName"] = "VPO-136 Vepr-KM",
        ["displayType"] = "Assault Carbine",
        ["weight"] = 3.2,
        ["value"] = 33000,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["wepSlot"] = "Primary",
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = "items/weapons/vpo136.png",

        ["sizeX"] = 5,
        ["sizeY"] = 2
    }

    EFGMITEMS["arc9_eft_vpo209"] = {
        ["fullName"] = "Molot Arms VPO-209 .366 TKM carbine",
        ["displayName"] = "VPO-209",
        ["displayType"] = "Assault Carbine",
        ["weight"] = 3.2,
        ["value"] = 35000,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["wepSlot"] = "Primary",
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = "items/weapons/vpo209.png",

        ["sizeX"] = 5,
        ["sizeY"] = 2
    }

    -- assault rifles
    EFGMITEMS["arc9_eft_velociraptor"] = {
        ["fullName"] = "Aklys Defense Velociraptor .300 Blackout assault rifle",
        ["displayName"] = "Velociraptor .300 BLK",
        ["displayType"] = "Assault Rifle",
        ["weight"] = 3.5,
        ["value"] = 90000,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["wepSlot"] = "Primary",
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = "items/weapons/velociraptor.png",

        ["sizeX"] = 4,
        ["sizeY"] = 2
    }

    EFGMITEMS["arc9_eft_ak101"] = {
        ["fullName"] = "Kalashnikov AK-101 5.56x45 assault rifle",
        ["displayName"] = "AK-101",
        ["displayType"] = "Assault Rifle",
        ["weight"] = 3.6,
        ["value"] = 39000,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["wepSlot"] = "Primary",
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = "items/weapons/ak101.png",

        ["sizeX"] = 5,
        ["sizeY"] = 2
    }

    EFGMITEMS["arc9_eft_ak102"] = {
        ["fullName"] = "Kalashnikov AK-102 5.56x45 assault rifle",
        ["displayName"] = "AK-102",
        ["displayType"] = "Assault Rifle",
        ["weight"] = 3.2,
        ["value"] = 45000,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["wepSlot"] = "Primary",
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = "items/weapons/ak102.png",

        ["sizeX"] = 4,
        ["sizeY"] = 2
    }

    EFGMITEMS["arc9_eft_ak103"] = {
        ["fullName"] = "Kalashnikov AK-103 7.62x39 assault rifle",
        ["displayName"] = "AK-103",
        ["displayType"] = "Assault Rifle",
        ["weight"] = 3.6,
        ["value"] = 48000,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["wepSlot"] = "Primary",
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = "items/weapons/ak103.png",

        ["sizeX"] = 5,
        ["sizeY"] = 2
    }

    EFGMITEMS["arc9_eft_ak104"] = {
        ["fullName"] = "Kalashnikov AK-104 7.62x39 assault rifle",
        ["displayName"] = "AK-104",
        ["displayType"] = "Assault Rifle",
        ["weight"] = 3.2,
        ["value"] = 41000,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["wepSlot"] = "Primary",
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = "items/weapons/ak104.png",

        ["sizeX"] = 4,
        ["sizeY"] = 2
    }

    EFGMITEMS["arc9_eft_ak105"] = {
        ["fullName"] = "Kalashnikov AK-105 5.45x39 assault rifle",
        ["displayName"] = "AK-105",
        ["displayType"] = "Assault Rifle",
        ["weight"] = 3.2,
        ["value"] = 46000,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["wepSlot"] = "Primary",
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = "items/weapons/ak105.png",

        ["sizeX"] = 4,
        ["sizeY"] = 2
    }

    EFGMITEMS["arc9_eft_ak12"] = {
        ["fullName"] = "Kalashnikov AK-12 5.45x39 assault rifle",
        ["displayName"] = "AK-12",
        ["displayType"] = "Assault Rifle",
        ["weight"] = 3.6,
        ["value"] = 88000,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["wepSlot"] = "Primary",
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = "items/weapons/ak12.png",

        ["sizeX"] = 5,
        ["sizeY"] = 2
    }

    EFGMITEMS["arc9_eft_ak74"] = {
        ["fullName"] = "Kalashnikov AK-74 5.45x39 assault rifle",
        ["displayName"] = "AK-74",
        ["displayType"] = "Assault Rifle",
        ["weight"] = 3.3,
        ["value"] = 38000,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["wepSlot"] = "Primary",
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = "items/weapons/ak74.png",

        ["sizeX"] = 5,
        ["sizeY"] = 2
    }

    EFGMITEMS["arc9_eft_ak74m"] = {
        ["fullName"] = "Kalashnikov AK-74M 5.45x39 assault rifle",
        ["displayName"] = "AK-74M",
        ["displayType"] = "Assault Rifle",
        ["weight"] = 3.6,
        ["value"] = 40000,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["wepSlot"] = "Primary",
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = "items/weapons/ak74m.png",

        ["sizeX"] = 5,
        ["sizeY"] = 2
    }

    EFGMITEMS["arc9_eft_akm"] = {
        ["fullName"] = "Kalashnikov AKM 7.62x39 assault rifle",
        ["displayName"] = "AKM",
        ["displayType"] = "Assault Rifle",
        ["weight"] = 3.5,
        ["value"] = 46000,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["wepSlot"] = "Primary",
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = "items/weapons/akm.png",

        ["sizeX"] = 5,
        ["sizeY"] = 2
    }

    EFGMITEMS["arc9_eft_akms"] = {
        ["fullName"] = "Kalashnikov AKMS 7.62x39 assault rifle",
        ["displayName"] = "AKMS",
        ["displayType"] = "Assault Rifle",
        ["weight"] = 3.4,
        ["value"] = 44000,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["wepSlot"] = "Primary",
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = "items/weapons/akms.png",

        ["sizeX"] = 5,
        ["sizeY"] = 2
    }

    EFGMITEMS["arc9_eft_aks74"] = {
        ["fullName"] = "Kalashnikov AKS-74 5.45x39 assault rifle",
        ["displayName"] = "AKS-74",
        ["displayType"] = "Assault Rifle",
        ["weight"] = 3.1,
        ["value"] = 35000,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["wepSlot"] = "Primary",
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = "items/weapons/aks74.png",

        ["sizeX"] = 5,
        ["sizeY"] = 2
    }

    EFGMITEMS["arc9_eft_aks74u"] = {
        ["fullName"] = "Kalashnikov AKS-74U 5.45x39 assault rifle",
        ["displayName"] = "AKS-74U",
        ["displayType"] = "Assault Rifle",
        ["weight"] = 2.6,
        ["value"] = 29000,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["wepSlot"] = "Primary",
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = "items/weapons/aks74u.png",

        ["sizeX"] = 4,
        ["sizeY"] = 2
    }

    EFGMITEMS["arc9_eft_asval"] = {
        ["fullName"] = "AS VAL 9x39 special assault rifle",
        ["displayName"] = "AS VAL",
        ["displayType"] = "Assault Rifle",
        ["weight"] = 2.5,
        ["value"] = 145000,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["wepSlot"] = "Primary",
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = "items/weapons/asval.png",

        ["sizeX"] = 5,
        ["sizeY"] = 2
    }

    EFGMITEMS["arc9_eft_ash12"] = {
        ["fullName"] = "ASh-12 12.7x55 assault rifle",
        ["displayName"] = "ASh-12",
        ["displayType"] = "Assault Rifle",
        ["weight"] = 6.1,
        ["value"] = 90000,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["wepSlot"] = "Primary",
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = "items/weapons/ash12.png",

        ["sizeX"] = 4,
        ["sizeY"] = 2
    }

    EFGMITEMS["arc9_eft_m4a1"] = {
        ["fullName"] = "Colt M4A1 5.56x45 assault rifle",
        ["displayName"] = "M4A1",
        ["displayType"] = "Assault Rifle",
        ["weight"] = 2.9,
        ["value"] = 97000,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["wepSlot"] = "Primary",
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = "items/weapons/m4a1.png",

        ["sizeX"] = 5,
        ["sizeY"] = 2
    }

    EFGMITEMS["arc9_eft_sa58"] = {
        ["fullName"] = "DS Arms SA58 7.62x51 assault rifle",
        ["displayName"] = "DSA SA58",
        ["displayType"] = "Assault Rifle",
        ["weight"] = 3.9,
        ["value"] = 108000,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["wepSlot"] = "Primary",
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = "items/weapons/sa58.png",

        ["sizeX"] = 5,
        ["sizeY"] = 2
    }

    EFGMITEMS["arc9_eft_mdr"] = {
        ["fullName"] = "Desert Tech MDR 7.62x51 assault rifle",
        ["displayName"] = "DT MDR .308",
        ["displayType"] = "Assault Rifle",
        ["weight"] = 4.4,
        ["value"] = 189000,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["wepSlot"] = "Primary",
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = "items/weapons/mdr.png",

        ["sizeX"] = 4,
        ["sizeY"] = 2
    }

    EFGMITEMS["arc9_eft_mdr556"] = {
        ["fullName"] = "Desert Tech MDR 5.56x45 assault rifle",
        ["displayName"] = "DT MDR 5.56",
        ["displayType"] = "Assault Rifle",
        ["weight"] = 3.9,
        ["value"] = 83000,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["wepSlot"] = "Primary",
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = "items/weapons/mdr556.png",

        ["sizeX"] = 4,
        ["sizeY"] = 2
    }

    EFGMITEMS["arc9_eft_scarh"] = {
        ["fullName"] = "FN SCAR-H 7.62x51 assault rifle",
        ["displayName"] = "SCAR-H",
        ["displayType"] = "Assault Rifle",
        ["weight"] = 3.8,
        ["value"] = 149000,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["wepSlot"] = "Primary",
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = "items/weapons/scarh.png",

        ["sizeX"] = 5,
        ["sizeY"] = 2
    }

    EFGMITEMS["arc9_eft_scarl"] = {
        ["fullName"] = "FN SCAR-L 5.56x45 assault rifle",
        ["displayName"] = "SCAR-L",
        ["displayType"] = "Assault Rifle",
        ["weight"] = 3.2,
        ["value"] = 64000,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["wepSlot"] = "Primary",
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = "items/weapons/scarl.png",

        ["sizeX"] = 5,
        ["sizeY"] = 2
    }

    EFGMITEMS["arc9_eft_hk416"] = {
        ["fullName"] = "HK 416A5 5.56x45 assault rifle",
        ["displayName"] = "HK 416A5",
        ["displayType"] = "Assault Rifle",
        ["weight"] = 3.8,
        ["value"] = 99000,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["wepSlot"] = "Primary",
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = "items/weapons/hk416.png",

        ["sizeX"] = 5,
        ["sizeY"] = 2
    }

    EFGMITEMS["arc9_eft_g36"] = {
        ["fullName"] = "HK G36 5.56x45 assault rifle",
        ["displayName"] = "G36",
        ["displayType"] = "Assault Rifle",
        ["weight"] = 3,
        ["value"] = 47000,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["wepSlot"] = "Primary",
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = "items/weapons/g36.png",

        ["sizeX"] = 6,
        ["sizeY"] = 2
    }

    EFGMITEMS["arc9_eft_9a91"] = {
        ["fullName"] = "KBP 9A-91 9x39 compact assault rifle",
        ["displayName"] = "9A-91",
        ["displayType"] = "Assault Rifle",
        ["weight"] = 2.4,
        ["value"] = 36000,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["wepSlot"] = "Primary",
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = "items/weapons/9a91.png",

        ["sizeX"] = 4,
        ["sizeY"] = 2
    }

    EFGMITEMS["arc9_eft_mk47_mutant"] = {
        ["fullName"] = "CMMG Mk47 Mutant 7.62x39 assault rifle",
        ["displayName"] = "Mk47",
        ["displayType"] = "Assault Rifle",
        ["weight"] = 2.3,
        ["value"] = 110000,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["wepSlot"] = "Primary",
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = "items/weapons/mk47_mutant.png",

        ["sizeX"] = 4,
        ["sizeY"] = 2
    }

    EFGMITEMS["arc9_eft_rd704"] = {
        ["fullName"] = "Rifle Dynamics RD-704 7.62x39 assault rifle",
        ["displayName"] = "RD-704",
        ["displayType"] = "Assault Rifle",
        ["weight"] = 3.8,
        ["value"] = 88000,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["wepSlot"] = "Primary",
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = "items/weapons/rd704.png",

        ["sizeX"] = 4,
        ["sizeY"] = 2
    }

    EFGMITEMS["arc9_eft_scarx17"] = {
        ["fullName"] = "FN SCAR-H X-17 7.62x51 assault rifle",
        ["displayName"] = "SCAR-H X-17",
        ["displayType"] = "Assault Rifle",
        ["weight"] = 3.8,
        ["value"] = 169000,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["wepSlot"] = "Primary",
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = "items/weapons/scarh.png",

        ["sizeX"] = 5,
        ["sizeY"] = 2
    }

    EFGMITEMS["arc9_eft_mcx"] = {
        ["fullName"] = "SIG MCX .300 Blackout assault rifle",
        ["displayName"] = "MCX .300 BLK",
        ["displayType"] = "Assault Rifle",
        ["weight"] = 2.7,
        ["value"] = 97000,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["wepSlot"] = "Primary",
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = "items/weapons/mcx.png",

        ["sizeX"] = 4,
        ["sizeY"] = 2
    }

    EFGMITEMS["arc9_eft_spear"] = {
        ["fullName"] = "SIG MCX-SPEAR 6.8x51 assault rifle",
        ["displayName"] = "MCX-SPEAR 6.8",
        ["displayType"] = "Assault Rifle",
        ["weight"] = 4.2,
        ["value"] = 249000,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["wepSlot"] = "Primary",
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = "items/weapons/spear.png",

        ["sizeX"] = 6,
        ["sizeY"] = 2
    }

    EFGMITEMS["arc9_eft_auga1"] = {
        ["fullName"] = "Steyr AUG A1 5.56x45 assault rifle",
        ["displayName"] = "AUG A1",
        ["displayType"] = "Assault Rifle",
        ["weight"] = 3.8,
        ["value"] = 43000,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["wepSlot"] = "Primary",
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = "items/weapons/auga1.png",

        ["sizeX"] = 5,
        ["sizeY"] = 2
    }

    EFGMITEMS["arc9_eft_aug"] = {
        ["fullName"] = "Steyr AUG A3 5.56x45 assault rifle",
        ["displayName"] = "AUG A3",
        ["displayType"] = "Assault Rifle",
        ["weight"] = 4,
        ["value"] = 56000,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["wepSlot"] = "Primary",
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = "items/weapons/aug.png",

        ["sizeX"] = 5,
        ["sizeY"] = 2
    }

    EFGMITEMS["arc9_eft_avt"] = {
        ["fullName"] = "Tokarev AVT-40 7.62x54R automatic rifle",
        ["displayName"] = "AVT-40",
        ["displayType"] = "Assault Rifle",
        ["weight"] = 4.2,
        ["value"] = 61000,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["wepSlot"] = "Primary",
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = "items/weapons/avt.png",

        ["sizeX"] = 6,
        ["sizeY"] = 2
    }

    -- light machine guns
    EFGMITEMS["arc9_eft_m60e4"] = {
        ["fullName"] = "U.S. Ordnance M60E4 7.62x51 light machine gun",
        ["displayName"] = "M60E4",
        ["displayType"] = "Light Machine Gun",
        ["weight"] = 10,
        ["value"] = 100000,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["wepSlot"] = "Primary",
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = "items/weapons/m60e4.png",

        ["sizeX"] = 5,
        ["sizeY"] = 2
    }

    EFGMITEMS["arc9_eft_m60e6"] = {
        ["fullName"] = "U.S. Ordnance M60E6 7.62x51 light machine gun",
        ["displayName"] = "M60E6",
        ["displayType"] = "Light Machine Gun",
        ["weight"] = 9.4,
        ["value"] = 110000,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["wepSlot"] = "Primary",
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = "items/weapons/m60e6.png",

        ["sizeX"] = 5,
        ["sizeY"] = 2
    }

    EFGMITEMS["arc9_eft_pkm"] = {
        ["fullName"] = "Kalashnikov PKM 7.62x54R machine gun",
        ["displayName"] = "PKM",
        ["displayType"] = "Light Machine Gun",
        ["weight"] = 8.9,
        ["value"] = 205000,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["wepSlot"] = "Primary",
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = "items/weapons/pkm.png",

        ["sizeX"] = 6,
        ["sizeY"] = 3
    }

    EFGMITEMS["arc9_eft_pkp"] = {
        ["fullName"] = "Kalashnikov PKP 7.62x54R infantry machine gun",
        ["displayName"] = 'PKP "Pecheneg"',
        ["displayType"] = "Light Machine Gun",
        ["weight"] = 9.6,
        ["value"] = 230100,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["wepSlot"] = "Primary",
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = "items/weapons/pkp.png",

        ["sizeX"] = 6,
        ["sizeY"] = 3
    }

    EFGMITEMS["arc9_eft_rpd"] = {
        ["fullName"] = "Degtyarev RPD 7.62x39 machine gun",
        ["displayName"] = "RPD",
        ["displayType"] = "Light Machine Gun",
        ["weight"] = 7.4,
        ["value"] = 99000,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["wepSlot"] = "Primary",
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = "items/weapons/rpd.png",

        ["sizeX"] = 6,
        ["sizeY"] = 3
    }

    EFGMITEMS["arc9_eft_rpk16"] = {
        ["fullName"] = "RPK-16 5.45x39 light machine gun",
        ["displayName"] = "RPK-16",
        ["displayType"] = "Light Machine Gun",
        ["weight"] = 3.6,
        ["value"] = 68000,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["wepSlot"] = "Primary",
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = "items/weapons/rpk16.png",

        ["sizeX"] = 5,
        ["sizeY"] = 2
    }

    -- pistols
    EFGMITEMS["arc9_eft_m9a3"] = {
        ["fullName"] = "Beretta M9A3 9x19 pistol",
        ["displayName"] = "M9A3",
        ["displayType"] = "Pistol",
        ["weight"] = 0.8,
        ["value"] = 23000,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["wepSlot"] = "Secondary",
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = "items/weapons/m9a3.png",

        ["sizeX"] = 2,
        ["sizeY"] = 1
    }

    EFGMITEMS["arc9_eft_pd20"] = {
        ["fullName"] = "20x1mm toy gun",
        ["displayName"] = "Blicky",
        ["displayType"] = "Pistol",
        ["weight"] = 0.1,
        ["value"] = 10000,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["wepSlot"] = "Secondary",
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = "items/weapons/blicky.png",

        ["sizeX"] = 2,
        ["sizeY"] = 1
    }

    EFGMITEMS["arc9_eft_m1911"] = {
        ["fullName"] = "Colt M1911A1 .45 ACP pistol",
        ["displayName"] = "M1911A1",
        ["displayType"] = "Pistol",
        ["weight"] = 1.2,
        ["value"] = 19000,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["wepSlot"] = "Secondary",
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = "items/weapons/m1911.png",

        ["sizeX"] = 2,
        ["sizeY"] = 1
    }

    EFGMITEMS["arc9_eft_m45"] = {
        ["fullName"] = "Colt M45A1 .45 ACP pistol",
        ["displayName"] = "M45A1",
        ["displayType"] = "Pistol",
        ["weight"] = 1.1,
        ["value"] = 22000,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["wepSlot"] = "Secondary",
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = "items/weapons/m45.png",

        ["sizeX"] = 2,
        ["sizeY"] = 1
    }

    EFGMITEMS["arc9_eft_deagle_l5"] = {
        ["fullName"] = "Magnum Research Desert Eagle L5 .357 pistol",
        ["displayName"] = "Desert Eagle L5",
        ["displayType"] = "Pistol",
        ["weight"] = 1.5,
        ["value"] = 32000,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["wepSlot"] = "Secondary",
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = "items/weapons/deagle_l5.png",

        ["sizeX"] = 2,
        ["sizeY"] = 1
    }

    EFGMITEMS["arc9_eft_deagle_l5"] = {
        ["fullName"] = "Magnum Research Desert Eagle L5 .357 pistol",
        ["displayName"] = "Desert Eagle L5",
        ["displayType"] = "Pistol",
        ["weight"] = 1.5,
        ["value"] = 32000,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["wepSlot"] = "Secondary",
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = "items/weapons/deagle_l5.png",

        ["sizeX"] = 2,
        ["sizeY"] = 1
    }

    EFGMITEMS["arc9_eft_deagle_l6"] = {
        ["fullName"] = "Magnum Research Desert Eagle L6 .50 AE pistol",
        ["displayName"] = "Desert Eagle L6",
        ["displayType"] = "Pistol",
        ["weight"] = 1.7,
        ["value"] = 38000,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["wepSlot"] = "Secondary",
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = "items/weapons/deagle_l6.png",

        ["sizeX"] = 2,
        ["sizeY"] = 1
    }

    EFGMITEMS["arc9_eft_deagle_xix"] = {
        ["fullName"] = "Magnum Research Desert Eagle Mk XIX .50 AE pistol",
        ["displayName"] = "Desert Eagle Mk XIX",
        ["displayType"] = "Pistol",
        ["weight"] = 1.9,
        ["value"] = 43000,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["wepSlot"] = "Secondary",
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = "items/weapons/deagle_xix.png",

        ["sizeX"] = 2,
        ["sizeY"] = 1
    }

    EFGMITEMS["arc9_eft_fn57"] = {
        ["fullName"] = "FN Five-seveN MK2 5.7x28 pistol",
        ["displayName"] = "FN 5-7",
        ["displayType"] = "Pistol",
        ["weight"] = 0.6,
        ["value"] = 44000,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["wepSlot"] = "Secondary",
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = "items/weapons/fn57.png",

        ["sizeX"] = 2,
        ["sizeY"] = 1
    }

    EFGMITEMS["arc9_eft_glock17"] = {
        ["fullName"] = "Glock 17 9x19 pistol",
        ["displayName"] = "Glock 17",
        ["displayType"] = "Pistol",
        ["weight"] = 0.8,
        ["value"] = 19000,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["wepSlot"] = "Secondary",
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = "items/weapons/glock17.png",

        ["sizeX"] = 2,
        ["sizeY"] = 1
    }

    EFGMITEMS["arc9_eft_glock18c"] = {
        ["fullName"] = "Glock 18C 9x19 machine pistol",
        ["displayName"] = "Glock 18C",
        ["displayType"] = "Pistol",
        ["weight"] = 0.8,
        ["value"] = 37000,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["wepSlot"] = "Secondary",
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = "items/weapons/glock18c.png",

        ["sizeX"] = 2,
        ["sizeY"] = 1
    }

    EFGMITEMS["arc9_eft_glock19x"] = {
        ["fullName"] = "Glock 19X 9x19 pistol",
        ["displayName"] = "Glock 19X",
        ["displayType"] = "Pistol",
        ["weight"] = 0.6,
        ["value"] = 20000,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["wepSlot"] = "Secondary",
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = "items/weapons/glock19x.png",

        ["sizeX"] = 2,
        ["sizeY"] = 1
    }

    EFGMITEMS["arc9_eft_usp"] = {
        ["fullName"] = "HK USP .45 ACP pistol",
        ["displayName"] = "USP .45",
        ["displayType"] = "Pistol",
        ["weight"] = 0.8,
        ["value"] = 26000,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["wepSlot"] = "Secondary",
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = "items/weapons/usp.png",

        ["sizeX"] = 2,
        ["sizeY"] = 1
    }

    EFGMITEMS["arc9_eft_pl15"] = {
        ["fullName"] = "Lebedev PL-15 9x19 pistol",
        ["displayName"] = "PL-15",
        ["displayType"] = "Pistol",
        ["weight"] = 0.9,
        ["value"] = 24000,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["wepSlot"] = "Secondary",
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = "items/weapons/pl15.png",

        ["sizeX"] = 2,
        ["sizeY"] = 1
    }

    EFGMITEMS["arc9_eft_pm"] = {
        ["fullName"] = "Makarov PM 9x18PM pistol",
        ["displayName"] = "PM",
        ["displayType"] = "Pistol",
        ["weight"] = 0.7,
        ["value"] = 15000,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["wepSlot"] = "Secondary",
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = "items/weapons/pm.png",

        ["sizeX"] = 2,
        ["sizeY"] = 1
    }

    EFGMITEMS["arc9_eft_mp443"] = {
        ["fullName"] = "Yarygin MP-443 Grach 9x19 pistol",
        ["displayName"] = "MP-443 Grach",
        ["displayType"] = "Pistol",
        ["weight"] = 0.9,
        ["value"] = 18000,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["wepSlot"] = "Secondary",
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = "items/weapons/mp443.png",

        ["sizeX"] = 2,
        ["sizeY"] = 1
    }

    EFGMITEMS["arc9_eft_pb"] = {
        ["fullName"] = "PB 9x18PM silenced pistol",
        ["displayName"] = "PB",
        ["displayType"] = "Pistol",
        ["weight"] = 0.9,
        ["value"] = 17000,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["wepSlot"] = "Secondary",
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = "items/weapons/pb.png",

        ["sizeX"] = 3,
        ["sizeY"] = 1
    }

    EFGMITEMS["arc9_eft_rsh12"] = {
        ["fullName"] = "RSh-12 12.7x55 revolver",
        ["displayName"] = "RSh-12",
        ["displayType"] = "Pistol",
        ["weight"] = 2.2,
        ["value"] = 78000,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["wepSlot"] = "Secondary",
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = "items/weapons/rsh12.png",

        ["sizeX"] = 2,
        ["sizeY"] = 1
    }

    EFGMITEMS["arc9_eft_p226r"] = {
        ["fullName"] = "SIG P226R 9x19 pistol",
        ["displayName"] = "P226R",
        ["displayType"] = "Pistol",
        ["weight"] = 0.8,
        ["value"] = 41000,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["wepSlot"] = "Secondary",
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = "items/weapons/p226r.png",

        ["sizeX"] = 2,
        ["sizeY"] = 1
    }

    EFGMITEMS["arc9_eft_sr1mp"] = {
        ["fullName"] = "Serdyukov SR-1MP Gyurza 9x21 pistol",
        ["displayName"] = "SR-1MP",
        ["displayType"] = "Pistol",
        ["weight"] = 0.8,
        ["value"] = 32000,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["wepSlot"] = "Secondary",
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = "items/weapons/sr1mp.png",

        ["sizeX"] = 2,
        ["sizeY"] = 1
    }

    EFGMITEMS["arc9_eft_apb"] = {
        ["fullName"] = "Stechkin APB 9x18PM silenced machine pistol",
        ["displayName"] = "APB",
        ["displayType"] = "Pistol",
        ["weight"] = 1.6,
        ["value"] = 34000,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["wepSlot"] = "Secondary",
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = "items/weapons/apb.png",

        ["sizeX"] = 4,
        ["sizeY"] = 1
    }

    EFGMITEMS["arc9_eft_aps"] = {
        ["fullName"] = "Stechkin APS 9x18PM machine pistol",
        ["displayName"] = "APS",
        ["displayType"] = "Pistol",
        ["weight"] = 1.0,
        ["value"] = 28000,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["wepSlot"] = "Secondary",
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = "items/weapons/aps.png",

        ["sizeX"] = 2,
        ["sizeY"] = 1
    }

    EFGMITEMS["arc9_eft_tt33"] = {
        ["fullName"] = "TT-33 7.62x25 TT pistol",
        ["displayName"] = "TT",
        ["displayType"] = "Pistol",
        ["weight"] = 0.8,
        ["value"] = 9000,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["wepSlot"] = "Secondary",
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = "items/weapons/tt33.png",

        ["sizeX"] = 2,
        ["sizeY"] = 1
    }

    EFGMITEMS["arc9_eft_cr200ds"] = {
        ["fullName"] = "Chiappa Rhino 200DS 9x19 revolver",
        ["displayName"] = "CR 200DS",
        ["displayType"] = "Pistol",
        ["weight"] = 0.7,
        ["value"] = 21000,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["wepSlot"] = "Secondary",
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = "items/weapons/cr200ds.png",

        ["sizeX"] = 1,
        ["sizeY"] = 1
    }

    EFGMITEMS["arc9_eft_cr50ds"] = {
        ["fullName"] = "Chiappa Rhino 50DS .357 revolver",
        ["displayName"] = "CR 50DS",
        ["displayType"] = "Pistol",
        ["weight"] = 0.9,
        ["value"] = 27000,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["wepSlot"] = "Secondary",
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = "items/weapons/cr50ds.png",

        ["sizeX"] = 2,
        ["sizeY"] = 1
    }

    -- shotguns
    EFGMITEMS["arc9_eft_m3super90"] = {
        ["fullName"] = "Benelli M3 Super 90 12ga dual-mode shotgun",
        ["displayName"] = "M3 Super 90",
        ["displayType"] = "Shotgun",
        ["weight"] = 3.3,
        ["value"] = 39000,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["wepSlot"] = "Primary",
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = "items/weapons/m3super90.png",

        ["sizeX"] = 5,
        ["sizeY"] = 2
    }

    EFGMITEMS["arc9_eft_m590"] = {
        ["fullName"] = "Mossberg 590A1 12ga pump-action shotgun",
        ["displayName"] = "590A1",
        ["displayType"] = "Shotgun",
        ["weight"] = 3.4,
        ["value"] = 30000,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["wepSlot"] = "Primary",
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = "items/weapons/m590.png",

        ["sizeX"] = 5,
        ["sizeY"] = 1
    }

    EFGMITEMS["arc9_eft_mr133"] = {
        ["fullName"] = "MP-133 12ga pump-action shotgun",
        ["displayName"] = "MP-133",
        ["displayType"] = "Shotgun",
        ["weight"] = 3.5,
        ["value"] = 25000,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["wepSlot"] = "Primary",
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = "items/weapons/mr133.png",

        ["sizeX"] = 5,
        ["sizeY"] = 1
    }

    EFGMITEMS["arc9_eft_mr153"] = {
        ["fullName"] = "MP-153 12ga semi-automatic shotgun",
        ["displayName"] = "MP-153",
        ["displayType"] = "Shotgun",
        ["weight"] = 3.6,
        ["value"] = 40000,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["wepSlot"] = "Primary",
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = "items/weapons/mr153.png",

        ["sizeX"] = 7,
        ["sizeY"] = 1
    }

    EFGMITEMS["arc9_eft_mr155"] = {
        ["fullName"] = "MP-155 12ga semi-automatic shotgun",
        ["displayName"] = "MP-155",
        ["displayType"] = "Shotgun",
        ["weight"] = 3.4,
        ["value"] = 45000,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["wepSlot"] = "Primary",
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = "items/weapons/mr155.png",

        ["sizeX"] = 5,
        ["sizeY"] = 1
    }

    EFGMITEMS["arc9_eft_mr43_sawedoff"] = {
        ["fullName"] = "MP-43 12ga sawed-off double-barrel shotgun",
        ["displayName"] = "MP-43 Sawed-off",
        ["displayType"] = "Shotgun",
        ["weight"] = 2.1,
        ["value"] = 19000,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["wepSlot"] = "Secondary",
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = "items/weapons/mr43_sawedoff.png",

        ["sizeX"] = 3,
        ["sizeY"] = 1
    }

    EFGMITEMS["arc9_eft_mr43"] = {
        ["fullName"] = "MP-43-1C 12ga double-barrel shotgun",
        ["displayName"] = "MP-43-1C",
        ["displayType"] = "Shotgun",
        ["weight"] = 3.6,
        ["value"] = 20000,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["wepSlot"] = "Primary",
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = "items/weapons/mr43.png",

        ["sizeX"] = 6,
        ["sizeY"] = 1
    }

    EFGMITEMS["arc9_eft_aa12"] = {
        ["fullName"] = "MPS Auto Assault-12 Gen 1 12ga automatic shotgun",
        ["displayName"] = "AA-12",
        ["displayType"] = "Shotgun",
        ["weight"] = 5.0,
        ["value"] = 120000,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["wepSlot"] = "Primary",
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = "items/weapons/aa12.png",

        ["sizeX"] = 5,
        ["sizeY"] = 2
    }

    EFGMITEMS["arc9_eft_mts255"] = {
        ["fullName"] = "MTs-255-12 12ga shotgun",
        ["displayName"] = "MTs-255-12",
        ["displayType"] = "Shotgun",
        ["weight"] = 4.2,
        ["value"] = 24000,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["wepSlot"] = "Primary",
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = "items/weapons/mts255.png",

        ["sizeX"] = 6,
        ["sizeY"] = 1
    }

    EFGMITEMS["arc9_eft_m870"] = {
        ["fullName"] = "Remington Model 870 12ga pump-action shotgun",
        ["displayName"] = "M870",
        ["displayType"] = "Shotgun",
        ["weight"] = 3.1,
        ["value"] = 35000,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["wepSlot"] = "Primary",
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = "items/weapons/m870.png",

        ["sizeX"] = 5,
        ["sizeY"] = 1
    }

    EFGMITEMS["arc9_eft_saiga12fa"] = {
        ["fullName"] = "Saiga-12K 12ga automatic shotgun",
        ["displayName"] = "Saiga-12K FA",
        ["displayType"] = "Shotgun",
        ["weight"] = 5.6,
        ["value"] = 140000,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["wepSlot"] = "Primary",
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = "items/weapons/saiga12fa.png",

        ["sizeX"] = 6,
        ["sizeY"] = 2
    }

    EFGMITEMS["arc9_eft_saiga12k"] = {
        ["fullName"] = "Saiga-12K ver.10 12ga semi-automatic shotgun",
        ["displayName"] = "Saiga-12K",
        ["displayType"] = "Shotgun",
        ["weight"] = 3.6,
        ["value"] = 40000,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["wepSlot"] = "Primary",
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = "items/weapons/saiga12k.png",

        ["sizeX"] = 5,
        ["sizeY"] = 2
    }

    EFGMITEMS["arc9_eft_ks23"] = {
        ["fullName"] = "TOZ KS-23M 23x75mm pump-action shotgun",
        ["displayName"] = "KS-23M",
        ["displayType"] = "Shotgun",
        ["weight"] = 3.8,
        ["value"] = 75000,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["wepSlot"] = "Primary",
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = "items/weapons/ks23.png",

        ["sizeX"] = 6,
        ["sizeY"] = 1
    }

    EFGMITEMS["arc9_eft_toz106"] = {
        ["fullName"] = "TOZ-106 20ga bolt-action shotgun",
        ["displayName"] = "TOZ-106",
        ["displayType"] = "Shotgun",
        ["weight"] = 2.7,
        ["value"] = 17000,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["wepSlot"] = "Primary",
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = "items/weapons/toz106.png",

        ["sizeX"] = 4,
        ["sizeY"] = 1
    }

    -- sniper rifles/marksman rifles
    EFGMITEMS["arc9_eft_ai_axmc"] = {
        ["fullName"] = "Accuracy International AXMC .338 LM bolt-action sniper rifle",
        ["displayName"] = "AI AXMC",
        ["displayType"] = "Sniper Rifle",
        ["weight"] = 5.7,
        ["value"] = 270000,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["wepSlot"] = "Primary",
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = "items/weapons/axmc.png",

        ["sizeX"] = 5,
        ["sizeY"] = 2
    }

        EFGMITEMS["arc9_eft_ak50"] = {
        ["fullName"] = "AK-50 .50 BMG sniper rifle",
        ["displayName"] = "AK-50",
        ["displayType"] = "Sniper Rifle",
        ["weight"] = 12.8,
        ["value"] = 400000,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["wepSlot"] = "Primary",
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = "items/weapons/ak50.png",

        ["sizeX"] = 7,
        ["sizeY"] = 2
    }

    EFGMITEMS["arc9_eft_g28"] = {
        ["fullName"] = "HK G28 7.62x51 marksman rifle",
        ["displayName"] = "G28",
        ["displayType"] = "Marksman Rifle",
        ["weight"] = 5.4,
        ["value"] = 210000,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["wepSlot"] = "Primary",
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = "items/weapons/g28.png",

        ["sizeX"] = 6,
        ["sizeY"] = 3
    }

    EFGMITEMS["arc9_eft_sr25"] = {
        ["fullName"] = "Knight's Armament Company SR-25 7.62x51 marksman rifle",
        ["displayName"] = "SR-25",
        ["displayType"] = "Marksman Rifle",
        ["weight"] = 3.8,
        ["value"] = 120000,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["wepSlot"] = "Primary",
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = "items/weapons/sr25.png",

        ["sizeX"] = 5,
        ["sizeY"] = 2
    }

    EFGMITEMS["arc9_eft_dvl10"] = {
        ["fullName"] = "Lobaev Arms DVL-10 7.62x51 bolt-action sniper rifle",
        ["displayName"] = "DVL-10",
        ["displayType"] = "Sniper Rifle",
        ["weight"] = 5.0,
        ["value"] = 150000,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["wepSlot"] = "Primary",
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = "items/weapons/dvl.png",

        ["sizeX"] = 5,
        ["sizeY"] = 2
    }

    EFGMITEMS["arc9_eft_mk18_mjolnir"] = {
        ["fullName"] = "SWORD International Mk-18 .338 LM marksman rifle",
        ["displayName"] = "Mk-18 Mjölnir",
        ["displayType"] = "Marksman Rifle",
        ["weight"] = 6.5,
        ["value"] = 330000,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["wepSlot"] = "Primary",
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = "items/weapons/mk18_mjolnir.png",

        ["sizeX"] = 6,
        ["sizeY"] = 2
    }

    EFGMITEMS["arc9_eft_mosin_infantry"] = {
        ["fullName"] = "Mosin 7.62x54R bolt-action rifle (Infantry)",
        ["displayName"] = "Mosin Infantry",
        ["displayType"] = "Sniper Rifle",
        ["weight"] = 4.8,
        ["value"] = 38000,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["wepSlot"] = "Primary",
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = "items/weapons/mosin_infantry.png",

        ["sizeX"] = 6,
        ["sizeY"] = 1
    }

    EFGMITEMS["arc9_eft_mosin_sniper"] = {
        ["fullName"] = "Mosin 7.62x54R bolt-action rifle (Sniper)",
        ["displayName"] = "Mosin Sniper",
        ["displayType"] = "Sniper Rifle",
        ["weight"] = 4.8,
        ["value"] = 44000,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["wepSlot"] = "Primary",
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = "items/weapons/mosin_sniper.png",

        ["sizeX"] = 6,
        ["sizeY"] = 1
    }

    EFGMITEMS["arc9_eft_mp18"] = {
        ["fullName"] = "MP-18 7.62x54R single-shot rifle",
        ["displayName"] = "MP-18",
        ["displayType"] = "Sniper Rifle",
        ["weight"] = 2.8,
        ["value"] = 17000,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["wepSlot"] = "Primary",
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = "items/weapons/mp18.png",

        ["sizeX"] = 5,
        ["sizeY"] = 1
    }

    EFGMITEMS["arc9_eft_t5000"] = {
        ["fullName"] = "ORSIS T-5000M 7.62x51 bolt-action sniper rifle",
        ["displayName"] = "T-5000M",
        ["displayType"] = "Sniper Rifle",
        ["weight"] = 5.9,
        ["value"] = 88000,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["wepSlot"] = "Primary",
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = "items/weapons/t5000.png",

        ["sizeX"] = 5,
        ["sizeY"] = 2
    }

    EFGMITEMS["arc9_eft_m700"] = {
        ["fullName"] = "Remington Model 700 7.62x51 bolt-action sniper rifle",
        ["displayName"] = "M700",
        ["displayType"] = "Sniper Rifle",
        ["weight"] = 4.0,
        ["value"] = 63000,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["wepSlot"] = "Primary",
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = "items/weapons/m700.png",

        ["sizeX"] = 5,
        ["sizeY"] = 1
    }

    EFGMITEMS["arc9_eft_rsass"] = {
        ["fullName"] = "Remington R11 RSASS 7.62x51 marksman rifle",
        ["displayName"] = "RSASS",
        ["displayType"] = "Marksman Rifle",
        ["weight"] = 4.9,
        ["value"] = 130000,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["wepSlot"] = "Primary",
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = "items/weapons/rsass.png",

        ["sizeX"] = 5,
        ["sizeY"] = 2
    }

    EFGMITEMS["arc9_eft_m1a"] = {
        ["fullName"] = "Springfield Armory M1A 7.62x51 rifle",
        ["displayName"] = "M1A",
        ["displayType"] = "Marksman Rifle",
        ["weight"] = 3.9,
        ["value"] = 105000,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["wepSlot"] = "Primary",
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = "items/weapons/m1a.png",

        ["sizeX"] = 4,
        ["sizeY"] = 2
    }

    EFGMITEMS["arc9_eft_sv98"] = {
        ["fullName"] = "SV-98 7.62x54R bolt-action sniper rifle",
        ["displayName"] = "SV-98",
        ["displayType"] = "Sniper Rifle",
        ["weight"] = 5.1,
        ["value"] = 74000,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["wepSlot"] = "Primary",
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = "items/weapons/sv98.png",

        ["sizeX"] = 6,
        ["sizeY"] = 2
    }

    EFGMITEMS["arc9_eft_svds"] = {
        ["fullName"] = "SVDS 7.62x54R sniper rifle",
        ["displayName"] = "SVDS",
        ["displayType"] = "Marksman Rifle",
        ["weight"] = 4.3,
        ["value"] = 85000,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["wepSlot"] = "Primary",
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = "items/weapons/svds.png",

        ["sizeX"] = 6,
        ["sizeY"] = 2
    }

    EFGMITEMS["arc9_eft_vpo215"] = {
        ["fullName"] = "Molot Arms VPO-215 Gornostay .366 TKM bolt-action rifle",
        ["displayName"] = "VPO-215 Gornostay",
        ["displayType"] = "Sniper Rifle",
        ["weight"] = 3.3,
        ["value"] = 27000,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["wepSlot"] = "Primary",
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = "items/weapons/vpo215.png",

        ["sizeX"] = 5,
        ["sizeY"] = 1
    }

    EFGMITEMS["arc9_eft_vss"] = {
        ["fullName"] = "VSS Vintorez 9x39 special sniper rifle",
        ["displayName"] = "VSS Vintorez",
        ["displayType"] = "Marksman Rifle",
        ["weight"] = 2.6,
        ["value"] = 143000,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["wepSlot"] = "Primary",
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = "items/weapons/vss.png",

        ["sizeX"] = 5,
        ["sizeY"] = 2
    }

    EFGMITEMS["arc9_eft_sako_trg"] = {
        ["fullName"] = "Sako TRG M10 .338 LM bolt-action sniper rifle",
        ["displayName"] = "Sako TRG M10",
        ["displayType"] = "Sniper Rifle",
        ["weight"] = 6.7,
        ["value"] = 249500,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["wepSlot"] = "Primary",
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = "items/weapons/sako.png",

        ["sizeX"] = 6,
        ["sizeY"] = 2
    }

    -- submachine guns
    EFGMITEMS["arc9_eft_mp9"] = {
        ["fullName"] = "B&T MP9 9x19 submachine gun",
        ["displayName"] = "MP9",
        ["displayType"] = "Submachine Gun",
        ["weight"] = 1.3,
        ["value"] = 43000,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["wepSlot"] = "Primary",
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = "items/weapons/mp9.png",

        ["sizeX"] = 3,
        ["sizeY"] = 2
    }

    EFGMITEMS["arc9_eft_mp9n"] = {
        ["fullName"] = "B&T MP9-N 9x19 submachine gun",
        ["displayName"] = "MP9-N",
        ["displayType"] = "Submachine Gun",
        ["weight"] = 1.4,
        ["value"] = 50000,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["wepSlot"] = "Primary",
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = "items/weapons/mp9n.png",

        ["sizeX"] = 3,
        ["sizeY"] = 2
    }

    EFGMITEMS["arc9_eft_fn_p90"] = {
        ["fullName"] = "FN P90 5.7x28 submachine gun",
        ["displayName"] = "P90",
        ["displayType"] = "Submachine Gun",
        ["weight"] = 2.9,
        ["value"] = 72000,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["wepSlot"] = "Primary",
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = "items/weapons/p90.png",

        ["sizeX"] = 3,
        ["sizeY"] = 2
    }

    EFGMITEMS["arc9_eft_mp5"] = {
        ["fullName"] = "HK MP5 9x19 submachine gun",
        ["displayName"] = "MP5",
        ["displayType"] = "Submachine Gun",
        ["weight"] = 2.4,
        ["value"] = 41000,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["wepSlot"] = "Primary",
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = "items/weapons/mp5.png",

        ["sizeX"] = 4,
        ["sizeY"] = 2
    }

    EFGMITEMS["arc9_eft_mp5k"] = {
        ["fullName"] = "HK MP5K 9x19 submachine gun",
        ["displayName"] = "MP5K-N",
        ["displayType"] = "Submachine Gun",
        ["weight"] = 1.8,
        ["value"] = 32000,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["wepSlot"] = "Primary",
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = "items/weapons/mp5k.png",

        ["sizeX"] = 2,
        ["sizeY"] = 1
    }

    EFGMITEMS["arc9_eft_mp7a1"] = {
        ["fullName"] = "HK MP7A1 4.6x30 submachine gun",
        ["displayName"] = "MP7A1",
        ["displayType"] = "Submachine Gun",
        ["weight"] = 2.2,
        ["value"] = 73000,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["wepSlot"] = "Primary",
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = "items/weapons/mp7a1.png",

        ["sizeX"] = 3,
        ["sizeY"] = 1
    }

    EFGMITEMS["arc9_eft_mp7a2"] = {
        ["fullName"] = "HK MP7A2 4.6x30 submachine gun",
        ["displayName"] = "MP7A2",
        ["displayType"] = "Submachine Gun",
        ["weight"] = 2.2,
        ["value"] = 81000,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["wepSlot"] = "Primary",
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = "items/weapons/mp7a2.png",

        ["sizeX"] = 3,
        ["sizeY"] = 1
    }

    EFGMITEMS["arc9_eft_ump"] = {
        ["fullName"] = "HK UMP .45 ACP submachine gun",
        ["displayName"] = "UMP .45",
        ["displayType"] = "Submachine Gun",
        ["weight"] = 2.2,
        ["value"] = 35000,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["wepSlot"] = "Primary",
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = "items/weapons/ump.png",

        ["sizeX"] = 3,
        ["sizeY"] = 2
    }

    EFGMITEMS["arc9_eft_uzi"] = {
        ["fullName"] = "IWI UZI 9x19 submachine gun",
        ["displayName"] = "UZI",
        ["displayType"] = "Submachine Gun",
        ["weight"] = 3.7,
        ["value"] = 29000,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["wepSlot"] = "Primary",
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = "items/weapons/uzi.png",

        ["sizeX"] = 3,
        ["sizeY"] = 2
    }

    EFGMITEMS["arc9_eft_uzi_pro"] = {
        ["fullName"] = "IWI UZI PRO Pistol 9x19 submachine gun",
        ["displayName"] = "UZI PRO Pistol",
        ["displayType"] = "Submachine Gun",
        ["weight"] = 1.6,
        ["value"] = 48000,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["wepSlot"] = "Primary",
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = "items/weapons/uzi_pro.png",

        ["sizeX"] = 2,
        ["sizeY"] = 1
    }

    EFGMITEMS["arc9_eft_vector45"] = {
        ["fullName"] = "TDI KRISS Vector Gen.2 .45 ACP submachine gun",
        ["displayName"] = "Vector .45",
        ["displayType"] = "Submachine Gun",
        ["weight"] = 2.6,
        ["value"] = 78000,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["wepSlot"] = "Primary",
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = "items/weapons/vector45.png",

        ["sizeX"] = 3,
        ["sizeY"] = 2
    }

    EFGMITEMS["arc9_eft_vector9"] = {
        ["fullName"] = "TDI KRISS Vector Gen.2 9x19 submachine gun",
        ["displayName"] = "Vector 9x19",
        ["displayType"] = "Submachine Gun",
        ["weight"] = 2.5,
        ["value"] = 72000,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["wepSlot"] = "Primary",
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = "items/weapons/vector9.png",

        ["sizeX"] = 3,
        ["sizeY"] = 2
    }

    EFGMITEMS["arc9_eft_pp1901"] = {
        ["fullName"] = "PP-19-01 Vityaz 9x19 submachine gun",
        ["displayName"] = "PP-19-01",
        ["displayType"] = "Submachine Gun",
        ["weight"] = 2.8,
        ["value"] = 22000,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["wepSlot"] = "Primary",
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = "items/weapons/pp1901.png",

        ["sizeX"] = 3,
        ["sizeY"] = 2
    }

    EFGMITEMS["arc9_eft_kedr"] = {
        ["fullName"] = "PP-91 Kedr 9x18PM submachine gun",
        ["displayName"] = "PP-91 Kedr",
        ["displayType"] = "Submachine Gun",
        ["weight"] = 1.5,
        ["value"] = 18000,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["wepSlot"] = "Primary",
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = "items/weapons/kedr.png",

        ["sizeX"] = 3,
        ["sizeY"] = 2
    }

    EFGMITEMS["arc9_eft_ppsh41"] = {
        ["fullName"] = "PPSh-41 7.62x25 submachine gun",
        ["displayName"] = "PPSh-41",
        ["displayType"] = "Submachine Gun",
        ["weight"] = 4.0,
        ["value"] = 26000,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["wepSlot"] = "Primary",
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = "items/weapons/ppsh.png",

        ["sizeX"] = 4,
        ["sizeY"] = 2
    }

    EFGMITEMS["arc9_eft_saiga9"] = {
        ["fullName"] = "Saiga-9 9x19 carbine",
        ["displayName"] = "Saiga-9",
        ["displayType"] = "Submachine Gun",
        ["weight"] = 3.0,
        ["value"] = 17000,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["wepSlot"] = "Primary",
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = "items/weapons/saiga9.png",

        ["sizeX"] = 4,
        ["sizeY"] = 2
    }

    EFGMITEMS["arc9_eft_mpx"] = {
        ["fullName"] = "SIG MPX 9x19 submachine gun",
        ["displayName"] = "MPX",
        ["displayType"] = "Submachine Gun",
        ["weight"] = 2.8,
        ["value"] = 54000,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["wepSlot"] = "Primary",
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = "items/weapons/mpx.png",

        ["sizeX"] = 4,
        ["sizeY"] = 2
    }

    EFGMITEMS["arc9_eft_stm9"] = {
        ["fullName"] = "Soyuz-TM STM-9 Gen.2 9x19 carbine",
        ["displayName"] = "STM-9",
        ["displayType"] = "Submachine Gun",
        ["weight"] = 2.0,
        ["value"] = 43000,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["wepSlot"] = "Primary",
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = "items/weapons/stm9.png",

        ["sizeX"] = 4,
        ["sizeY"] = 2
    }

    EFGMITEMS["arc9_eft_sr2m"] = {
        ["fullName"] = "SR-2M Veresk 9x21 submachine gun",
        ["displayName"] = "SR-2M",
        ["displayType"] = "Submachine Gun",
        ["weight"] = 1.7,
        ["value"] = 53000,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["wepSlot"] = "Primary",
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = "items/weapons/sr2m.png",

        ["sizeX"] = 3,
        ["sizeY"] = 2
    }

    -- launchers
    EFGMITEMS["arc9_eft_fn40gl"] = {
        ["fullName"] = "FN40GL Mk2 40mm grenade launcher",
        ["displayName"] = "FN40GL",
        ["displayType"] = "Launcher",
        ["weight"] = 3.0,
        ["value"] = 160000,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["wepSlot"] = "Primary",
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = "items/weapons/fn40gl.png",

        ["sizeX"] = 3,
        ["sizeY"] = 2
    }

    EFGMITEMS["arc9_eft_m32a1"] = {
        ["fullName"] = "Milkor M32A1 MSGL 40mm grenade launcher",
        ["displayName"] = "Milkor M32A1",
        ["displayType"] = "Launcher",
        ["weight"] = 5.4,
        ["value"] = 400000,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["wepSlot"] = "Primary",
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = "items/weapons/m32a1.png",

        ["sizeX"] = 4,
        ["sizeY"] = 2
    }

        EFGMITEMS["arc9_eft_rshg2"] = {
        ["fullName"] = "RShG-2 72.5mm rocket launcher",
        ["displayName"] = "RShG-2",
        ["displayType"] = "Launcher",
        ["weight"] = 4.0,
        ["value"] = 200000,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["wepSlot"] = "Primary",
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = "items/weapons/rshg2.png",

        ["sizeX"] = 4,
        ["sizeY"] = 1
    }

    -- melee
    EFGMITEMS["arc9_eft_melee_taran"] = {
        ["fullName"] = "PR-Taran Police Baton",
        ["displayName"] = "PR-Taran",
        ["displayType"] = "Melee",
        ["weight"] = 0.7,
        ["value"] = 25000,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["wepSlot"] = "Melee",
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = "items/melee/taran.png",

        ["sizeX"] = 1,
        ["sizeY"] = 2
    }

    EFGMITEMS["arc9_eft_melee_6x5"] = {
        ["fullName"] = "6Kh5 Bayonet",
        ["displayName"] = "6Kh5",
        ["displayType"] = "Melee",
        ["weight"] = 0.2,
        ["value"] = 15000,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["wepSlot"] = "Melee",
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = "items/melee/6x5.png",

        ["sizeX"] = 2,
        ["sizeY"] = 1
    }

    EFGMITEMS["arc9_eft_melee_akula"] = {
        ["fullName"] = "Akula Push Dagger",
        ["displayName"] = "Akula",
        ["displayType"] = "Melee",
        ["weight"] = 0.1,
        ["value"] = 600000,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["wepSlot"] = "Melee",
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = "items/melee/akula.png",

        ["sizeX"] = 1,
        ["sizeY"] = 1
    }

    EFGMITEMS["arc9_eft_melee_wycc"] = {
        ["fullName"] = "Antique Axe",
        ["displayName"] = "Axe",
        ["displayType"] = "Melee",
        ["weight"] = 1.1,
        ["value"] = 70000,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["wepSlot"] = "Melee",
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = "items/melee/axe.png",

        ["sizeX"] = 1,
        ["sizeY"] = 2
    }

    EFGMITEMS["arc9_eft_melee_gladius"] = {
        ["fullName"] = "APOK Tactical Wasteland Gladius",
        ["displayName"] = "TWG",
        ["displayType"] = "Melee",
        ["weight"] = 1.2,
        ["value"] = 1000000,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["wepSlot"] = "Melee",
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = "items/melee/gladius.png",

        ["sizeX"] = 1,
        ["sizeY"] = 4
    }

    EFGMITEMS["arc9_eft_melee_a2607"] = {
        ["fullName"] = "Bars A-2607 95Kh18 knife",
        ["displayName"] = "A-2607",
        ["displayType"] = "Melee",
        ["weight"] = 0.2,
        ["value"] = 9000,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["wepSlot"] = "Melee",
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = "items/melee/a2607.png",

        ["sizeX"] = 2,
        ["sizeY"] = 1
    }

    EFGMITEMS["arc9_eft_melee_a2607d"] = {
        ["fullName"] = "Bars A-2607 Damascus knife",
        ["displayName"] = "A-2607",
        ["displayType"] = "Melee",
        ["weight"] = 0.2,
        ["value"] = 9000,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["wepSlot"] = "Melee",
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = "items/melee/a2607d.png",

        ["sizeX"] = 2,
        ["sizeY"] = 1
    }

    EFGMITEMS["arc9_eft_melee_camper"] = {
        ["fullName"] = "Camper Axe",
        ["displayName"] = "Camper",
        ["displayType"] = "Melee",
        ["weight"] = 0.6,
        ["value"] = 30000,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["wepSlot"] = "Melee",
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = "items/melee/camper.png",

        ["sizeX"] = 1,
        ["sizeY"] = 3
    }

    EFGMITEMS["arc9_eft_melee_labris"] = {
        ["fullName"] = "Chained Labrys",
        ["displayName"] = "Chained Labrys",
        ["displayType"] = "Melee",
        ["weight"] = 19.0,
        ["value"] = 4000000,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["wepSlot"] = "Melee",
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = "items/melee/labris.png",

        ["sizeX"] = 5,
        ["sizeY"] = 5
    }

    EFGMITEMS["arc9_eft_melee_crash"] = {
        ["fullName"] = "Crash Axe",
        ["displayName"] = "SCA",
        ["displayType"] = "Melee",
        ["weight"] = 1.4,
        ["value"] = 2000000,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["wepSlot"] = "Melee",
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = "items/melee/crash.png",

        ["sizeX"] = 1,
        ["sizeY"] = 3
    }

    EFGMITEMS["arc9_eft_melee_cultist"] = {
        ["fullName"] = "Cultist Knife",
        ["displayName"] = "Knife",
        ["displayType"] = "Melee",
        ["weight"] = 0.2,
        ["value"] = 75000,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["wepSlot"] = "Melee",
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = "items/melee/cultist.png",

        ["sizeX"] = 2,
        ["sizeY"] = 1
    }

    EFGMITEMS["arc9_eft_melee_fulcrum"] = {
        ["fullName"] = "ER FULCRUM BAYONET",
        ["displayName"] = "ER BAYONET",
        ["displayType"] = "Melee",
        ["weight"] = 0.4,
        ["value"] = 16000,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["wepSlot"] = "Melee",
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = "items/melee/fulcrum.png",

        ["sizeX"] = 2,
        ["sizeY"] = 1
    }

    EFGMITEMS["arc9_eft_melee_crowbar"] = {
        ["fullName"] = "Freeman Crowbar",
        ["displayName"] = "Crowbar",
        ["displayType"] = "Melee",
        ["weight"] = 1.9,
        ["value"] = 15000,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["wepSlot"] = "Melee",
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = "items/melee/crowbar.png",

        ["sizeX"] = 1,
        ["sizeY"] = 3
    }

    EFGMITEMS["arc9_eft_melee_kiba"] = {
        ["fullName"] = "Kiba Arms Tactical Tomahawk",
        ["displayName"] = "KATT",
        ["displayType"] = "Melee",
        ["weight"] = 1.8,
        ["value"] = 80000,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["wepSlot"] = "Melee",
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = "items/melee/katt.png",

        ["sizeX"] = 1,
        ["sizeY"] = 3
    }

    EFGMITEMS["arc9_eft_melee_kukri"] = {
        ["fullName"] = "United Cutlery M48 Tactical Kukri",
        ["displayName"] = "M48 Kukri",
        ["displayType"] = "Melee",
        ["weight"] = 0.4,
        ["value"] = 200000,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["wepSlot"] = "Melee",
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = "items/melee/kukri.png",

        ["sizeX"] = 2,
        ["sizeY"] = 1
    }

    EFGMITEMS["arc9_eft_melee_m2"] = {
        ["fullName"] = "Miller Bros. Blades M-2 Tactical Sword",
        ["displayName"] = "M-2",
        ["displayType"] = "Melee",
        ["weight"] = 1.3,
        ["value"] = 1000000,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["wepSlot"] = "Melee",
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = "items/melee/m2.png",

        ["sizeX"] = 1,
        ["sizeY"] = 3
    }

    EFGMITEMS["arc9_eft_melee_mpl50"] = {
        ["fullName"] = "MPL-50 entrenching tool",
        ["displayName"] = "MPL-50",
        ["displayType"] = "Melee",
        ["weight"] = 0.8,
        ["value"] = 10000,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["wepSlot"] = "Melee",
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = "items/melee/mpl50.png",

        ["sizeX"] = 1,
        ["sizeY"] = 3
    }

    EFGMITEMS["arc9_eft_melee_rebel"] = {
        ["fullName"] = "Red Rebel Ice Pick",
        ["displayName"] = "RedRebel",
        ["displayType"] = "Melee",
        ["weight"] = 0.6,
        ["value"] = 2500000,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["wepSlot"] = "Melee",
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = "items/melee/rebel.png",

        ["sizeX"] = 1,
        ["sizeY"] = 3
    }

    EFGMITEMS["arc9_eft_melee_voodoo"] = {
        ["fullName"] = "SOG Voodoo Hawk Tactical Tomahawk",
        ["displayName"] = "Hawk",
        ["displayType"] = "Melee",
        ["weight"] = 0.8,
        ["value"] = 3600000,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["wepSlot"] = "Melee",
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = "items/melee/voodoo.png",

        ["sizeX"] = 1,
        ["sizeY"] = 2
    }

    EFGMITEMS["arc9_eft_melee_sp8"] = {
        ["fullName"] = "SP-8 Survival Machete",
        ["displayName"] = "SP-8",
        ["displayType"] = "Melee",
        ["weight"] = 0.6,
        ["value"] = 64000,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["wepSlot"] = "Melee",
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = "items/melee/sp8.png",

        ["sizeX"] = 1,
        ["sizeY"] = 3
    }

    EFGMITEMS["arc9_eft_melee_taiga"] = {
        ["fullName"] = "UVSR Taiga-1 Survival Machete",
        ["displayName"] = "Taiga-1",
        ["displayType"] = "Melee",
        ["weight"] = 0.6,
        ["value"] = 500000,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["wepSlot"] = "Melee",
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = "items/melee/taiga.png",

        ["sizeX"] = 1,
        ["sizeY"] = 3
    }

    -- grenades
    EFGMITEMS["arc9_eft_melee_taiga"] = {
        ["fullName"] = "UVSR Taiga-1 Survival Machete",
        ["displayName"] = "Taiga-1",
        ["displayType"] = "Melee",
        ["weight"] = 0.6,
        ["value"] = 500000,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["wepSlot"] = "Melee",
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = "items/melee/taiga.png",

        ["sizeX"] = 1,
        ["sizeY"] = 3
    }

    -- grenades
    EFGMITEMS["arc9_eft_f1"] = {
        ["fullName"] = "F-1 hand grenade",
        ["displayName"] = "F-1",
        ["displayType"] = "Grenade",
        ["weight"] = 0.6,
        ["value"] = 15000,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["wepSlot"] = "Grenade",
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = "items/grenades/f1.png",

        ["sizeX"] = 1,
        ["sizeY"] = 1
    }

    EFGMITEMS["arc9_eft_m18"] = {
        ["fullName"] = "M18 smoke grenade (Green)",
        ["displayName"] = "M18 (g)",
        ["displayType"] = "Grenade",
        ["weight"] = 0.5,
        ["value"] = 4000,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["wepSlot"] = "Grenade",
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = "items/grenades/m18.png",

        ["sizeX"] = 1,
        ["sizeY"] = 1
    }

    EFGMITEMS["arc9_eft_m18y"] = {
        ["fullName"] = "M18 smoke grenade (Yellow)",
        ["displayName"] = "M18 (y)",
        ["displayType"] = "Grenade",
        ["weight"] = 0.5,
        ["value"] = 4000,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["wepSlot"] = "Grenade",
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = "items/grenades/m18y.png",

        ["sizeX"] = 1,
        ["sizeY"] = 1
    }

    EFGMITEMS["arc9_eft_m67"] = {
        ["fullName"] = "M67 hand grenade",
        ["displayName"] = "M67",
        ["displayType"] = "Grenade",
        ["weight"] = 0.4,
        ["value"] = 20000,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["wepSlot"] = "Grenade",
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = "items/grenades/m67.png",

        ["sizeX"] = 1,
        ["sizeY"] = 1
    }

    EFGMITEMS["arc9_eft_m7290"] = {
        ["fullName"] = "Model 7290 Flash Bang grenade",
        ["displayName"] = "M7290",
        ["displayType"] = "Grenade",
        ["weight"] = 0.4,
        ["value"] = 18000,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["wepSlot"] = "Grenade",
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = "items/grenades/m7290.png",

        ["sizeX"] = 1,
        ["sizeY"] = 1
    }

    EFGMITEMS["arc9_eft_rdg2b"] = {
        ["fullName"] = "RDG-2B smoke grenade",
        ["displayName"] = "RDG-2B",
        ["displayType"] = "Grenade",
        ["weight"] = 0.6,
        ["value"] = 3000,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["wepSlot"] = "Grenade",
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = "items/grenades/rdg2b.png",

        ["sizeX"] = 1,
        ["sizeY"] = 2
    }

    EFGMITEMS["arc9_eft_rgd5"] = {
        ["fullName"] = "RGD-5 hand grenade",
        ["displayName"] = "RGD-5",
        ["displayType"] = "Grenade",
        ["weight"] = 0.3,
        ["value"] = 18000,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["wepSlot"] = "Grenade",
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = "items/grenades/rgd5.png",

        ["sizeX"] = 1,
        ["sizeY"] = 1
    }

    EFGMITEMS["arc9_eft_rgn"] = {
        ["fullName"] = "RGN hand grenade",
        ["displayName"] = "RGN",
        ["displayType"] = "Grenade",
        ["weight"] = 0.3,
        ["value"] = 38000,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["wepSlot"] = "Grenade",
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = "items/grenades/rgn.png",

        ["sizeX"] = 1,
        ["sizeY"] = 1
    }

    EFGMITEMS["arc9_eft_rgo"] = {
        ["fullName"] = "RGO hand grenade",
        ["displayName"] = "RGO",
        ["displayType"] = "Grenade",
        ["weight"] = 0.5,
        ["value"] = 33000,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["wepSlot"] = "Grenade",
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = "items/grenades/rgo.png",

        ["sizeX"] = 1,
        ["sizeY"] = 1
    }

    EFGMITEMS["arc9_eft_v40"] = {
        ["fullName"] = "V40 Mini-Grenade",
        ["displayName"] = "V40",
        ["displayType"] = "Grenade",
        ["weight"] = 0.1,
        ["value"] = 25000,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["wepSlot"] = "Grenade",
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = "items/grenades/v40.png",

        ["sizeX"] = 1,
        ["sizeY"] = 1
    }

    EFGMITEMS["arc9_eft_vog17"] = {
        ["fullName"] = "VOG-17 Khattabka improvised hand grenade",
        ["displayName"] = "VOG-17",
        ["displayType"] = "Grenade",
        ["weight"] = 0.2,
        ["value"] = 30000,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["wepSlot"] = "Grenade",
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = "items/grenades/vog17.png",

        ["sizeX"] = 1,
        ["sizeY"] = 1
    }

    EFGMITEMS["arc9_eft_vog25"] = {
        ["fullName"] = "VOG-25 Khattabka improvised hand grenade",
        ["displayName"] = "VOG-25",
        ["displayType"] = "Grenade",
        ["weight"] = 0.2,
        ["value"] = 40000,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["wepSlot"] = "Grenade",
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = "items/grenades/vog25.png",

        ["sizeX"] = 1,
        ["sizeY"] = 1
    }

    EFGMITEMS["arc9_eft_zarya"] = {
        ["fullName"] = "Zarya stun grenade",
        ["displayName"] = "Zarya",
        ["displayType"] = "Grenade",
        ["weight"] = 0.1,
        ["value"] = 12000,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["wepSlot"] = "Grenade",
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = "items/grenades/zarya.png",

        ["sizeX"] = 1,
        ["sizeY"] = 1
    }

    -- specials
    EFGMITEMS["arc9_eft_sp81"] = {
        ["fullName"] = "ZiD SP-81 26x75 signal pistol",
        ["displayName"] = "SP-81",
        ["displayType"] = "Special",
        ["weight"] = 0.6,
        ["value"] = 25000,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["wepSlot"] = "Utility",
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = "items/special/sp81.png",

        ["sizeX"] = 1,
        ["sizeY"] = 1
    }

    EFGMITEMS["arc9_eft_rangefinder"] = {
        ["fullName"] = "Vortex Ranger 1500 rangefinder",
        ["displayName"] = "R1500",
        ["displayType"] = "Special",
        ["weight"] = 0.2,
        ["value"] = 20000,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["wepSlot"] = "Secondary",
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = "items/special/r1500.png",

        ["sizeX"] = 1,
        ["sizeY"] = 1
    }

-- RIGS
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

        ["containerLayoutSizeX"] = 4, -- for the positioning of the child slots, penial you can thank me later
        ["containerLayoutSizeY"] = 4, -- also look in the reference folder to see what I'm getting at better

        ["childContainers"] = {
            { ["posX"] = 1, ["posY"] = 1, ["sizeX"] = 1, ["sizeY"] = 2 }, -- Top 4 1x2's
            { ["posX"] = 2, ["posY"] = 1, ["sizeX"] = 1, ["sizeY"] = 2 },
            { ["posX"] = 3, ["posY"] = 1, ["sizeX"] = 1, ["sizeY"] = 2 },
            { ["posX"] = 4, ["posY"] = 1, ["sizeX"] = 1, ["sizeY"] = 2 },

            { ["posX"] = 1, ["posY"] = 3, ["sizeX"] = 1, ["sizeY"] = 1 }, -- Bottom left 4 1x1's
            { ["posX"] = 2, ["posY"] = 3, ["sizeX"] = 1, ["sizeY"] = 1 },
            { ["posX"] = 1, ["posY"] = 4, ["sizeX"] = 1, ["sizeY"] = 1 },
            { ["posX"] = 2, ["posY"] = 4, ["sizeX"] = 1, ["sizeY"] = 1 },

            { ["posX"] = 3, ["posY"] = 3, ["sizeX"] = 2, ["sizeY"] = 2 } -- Bottom right 2x2
        }
    }

-- POCKETS
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

-- BACKPACKS
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

-- SECURE CONTAINERS
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

-- BARTER ITEMS / VALUABLES
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

-- HL2 JEEP
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