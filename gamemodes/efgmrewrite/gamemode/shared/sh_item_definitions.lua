EQUIPTYPE = {}
EQUIPTYPE.Weapon = 1
EQUIPTYPE.Ammunition = 2
EQUIPTYPE.Gear = 3
EQUIPTYPE.Spawn = 4 -- for shit that spawns into the world on equip
EQUIPTYPE.Consumable = 5
EQUIPTYPE.Attachment = 6
EQUIPTYPE.None = 7

EFGMITEMS = {}

-- WEAPONS
    -- assault carbines
    EFGMITEMS["arc9_eft_adar15"] = {
        ["fullName"] = "ADAR 2-15 5.56x45 carbine",
        ["displayName"] = "ADAR 2-15",
        ["displayType"] = "Assault Carbine",
        ["weight"] = 2.9,
        ["value"] = 41000,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["equipSlot"] = WEAPONSLOTS.PRIMARY.ID,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/weapons/adar15.png", "smooth"),

        ["sizeX"] = 5,
        ["sizeY"] = 2,

        ["defAtts"] = "XQAAAQCYAgAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8ONwzg/TnvSfVBqeGuIaSSp0lbXXmmwiKc+3qpTFQPm/3TEpRkNkliqewzXeK6KEow99gDpNekcBZLljEK1yteXPgcDvoY1gzY43rtGqP1p7jD5gej6NEa+QNcT8BXtXPmN5o2OkWkgurm/9AXyGT4En6CkA7mCMaVO2Yf9O7uShDeIXUNI/H0SBmpgNixBxQz+E/POyeEsbq2xrf7Aprms9YvCG5XWqysS0SdlwFcjFBYuYDbgf2u7nIW7LR3gi3thoSNvXHYQR/r2U6AF5oA"
    }

    EFGMITEMS["arc9_eft_vsk94"] = {
        ["fullName"] = "KBP VSK-94 9x39 rifle",
        ["displayName"] = "VSK-94",
        ["displayType"] = "Assault Carbine",
        ["weight"] = 2.9,
        ["value"] = 65000,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["equipSlot"] = WEAPONSLOTS.PRIMARY.ID,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/weapons/vsk94.png", "smooth"),

        ["sizeX"] = 5,
        ["sizeY"] = 2,

        ["defAtts"] = "XQAAAQA/AQAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8OxEj3M6NEz3RX71XCYfOHncMteTkzK1bNnD0ch1JesVcWATp5G09k+0YVg1cAGkdsOIfs+Qsr2LRnuer24UJlIh2n7Lb+WaPCEhTW7X4aZOJQnELQOIJoBY9Wi+SDFpx1kjJ6Uad1mbVmwii/9f4XHyIA"
    }

    EFGMITEMS["arc9_eft_rfb"] = {
        ["fullName"] = "Kel-Tec RFB 7.62x51 rifle",
        ["displayName"] = "Kal-Tec RFB",
        ["displayType"] = "Assault Carbine",
        ["weight"] = 3.6,
        ["value"] = 54000,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["equipSlot"] = WEAPONSLOTS.PRIMARY.ID,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/weapons/rfb.png", "smooth"),

        ["sizeX"] = 4,
        ["sizeY"] = 2,

        ["defAtts"] = "XQAAAQDDAQAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8OIQMOqZA7fASOsjTnTK+5tyMtCf5S3eX59xP8WN23ZyQ+TvTCJsvjaq82IMiiV5QK4szoA/bMyTYpFaTqx2PI3pyhTcPsdIapPnru67+fzz/K1Z98VMZLR5TH+9vSJvHtElLmmrpKaxP05iuKyCE3B82cC/39buGs4Xs3pwLSUfyGDxFBNOLpzIT/3ATm4tb2tvIjp5o="
    }

    EFGMITEMS["arc9_eft_tx15"] = {
        ["fullName"] = "Lone Star TX-15 DML 5.56x45 carbine",
        ["displayName"] = "TX-15 DML",
        ["displayType"] = "Assault Carbine",
        ["weight"] = 3.3,
        ["value"] = 95000,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["equipSlot"] = WEAPONSLOTS.PRIMARY.ID,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/weapons/tx15.png", "smooth"),

        ["sizeX"] = 6,
        ["sizeY"] = 2,

        ["defAtts"] = "XQAAAQDhAwAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8ONwzg/TnvSdRKMPYpDULfQayPik8I0xIa1V4p75pAWrkNCWfG14EWqVFlNWIJHALRyRr6Wv5/v88HRQXfKH/4ARquI8d3vb21586V6xlvlXftbXMlZYGgYlff+EJZnB1UiyxOnx/3jU7Ptkma716R1vGAVnyoL6zWNKQVW3ykXCqG9Vci+jdv8bDPtb14XTLUpe7VZVmZ/J26lO0tkYcSzZlpBfLbVCjPGyE+VaLvR1GS1Ih9dntYX89MPPENC7ODH7u3kReM4aW+/vZ+ejx0d3fWB8mVTZG4vVZoZte34hySnGfmqNySAy/FjsDEXN/IOry6GQnfMss6pigejnyJ0LzjZogmlS1CE0vQF/ekE4ebAA=="
    }

    EFGMITEMS["arc9_eft_sag_ak545"] = {
        ["fullName"] = "SAG AK-545 5.45x39 carbine",
        ["displayName"] = "AK-545",
        ["displayType"] = "Assault Carbine",
        ["weight"] = 4.4,
        ["value"] = 54000,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["equipSlot"] = WEAPONSLOTS.PRIMARY.ID,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/weapons/sag_ak545.png", "smooth"),

        ["sizeX"] = 5,
        ["sizeY"] = 2,

        ["defAtts"] = "XQAAAQB+AgAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8NWDT+kEGPPnFlfSScSybP+C3Y0ij7z9iVh7t2mLczDAV3rxV/Tab/+5LCblM65d7iYCxVFrOjRr/G08xhEUw/hd4M+7+9I6N15rAON7hFd9OZPaqOS5X/KJSf+lo+SNzvIgxOHwtgKVmQx95wSO5F2wsaRQWeYn2YiczkbY14ycHPheO6MymGa2y/n1p0vmkOg2rFcvh5GvzRFnN5i6ITBbwdnh2rosValGwtTY4j2ZR596OTW/6hX2n+7VZe"
    }

    EFGMITEMS["arc9_eft_sag_ak545short"] = {
        ["fullName"] = "SAG AK-545 Short 5.45x39 carbine",
        ["displayName"] = "AK-545 Short",
        ["displayType"] = "Assault Carbine",
        ["weight"] = 4.3,
        ["value"] = 63000,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["equipSlot"] = WEAPONSLOTS.PRIMARY.ID,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/weapons/sag_ak545_short.png", "smooth"),

        ["sizeX"] = 4,
        ["sizeY"] = 2,

        ["defAtts"] = "XQAAAQCBAgAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8NWDT+kEGPPnFlfSScSitKC3h96j2MfwFs9lVZzbkxhsM84Ocm2m12AHZKDY7Lm7vCn2PU4az/K5SN/zP226NxzPE72JF0Onfk/TfCglJZOlG9nCAUuCFMsCbSO0Hxvy1RspZ8Qcxzr+bPsEBDSbRHkcnyzUDGfF42qKWcPVorGQQYc0bYElrOn3dBvQkNntCZQHNaU+iHlRyEfzmqTUGeT9L+SATgPl/aF+zDDk9nX8D7NUMubW0ZG9XcN07sW0Y="
    }

    EFGMITEMS["arc9_eft_sr3"] = {
        ["fullName"] = "SR-3M 9x39 compact assault rifle",
        ["displayName"] = "SR-3M",
        ["displayType"] = "Assault Carbine",
        ["weight"] = 2.5,
        ["value"] = 147000,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["equipSlot"] = WEAPONSLOTS.PRIMARY.ID,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/weapons/sr3m.png", "smooth"),

        ["sizeX"] = 3,
        ["sizeY"] = 2,

        ["defAtts"] = "XQAAAQBoAQAAAAAAAAA9iIIiM7hMNz0dhIkbkvLjTdSR5gRNNIHH3iMy0YgfJ5Lm1K8QmyKhGRtnNHx3kcm9IN0ZKMDsA9aRJyB2BQGcJAY6GYLfG2kqLcGFAtoF5Av9QyRQsV9TgKhSRE1hFodzywbKc8ROcdk0pygDZULgrqj6VRj6SNnhCb8KZolQ+paSigJbPyIM3gC8zmp8dRzZeAA="
    }

    EFGMITEMS["arc9_eft_svt"] = {
        ["fullName"] = "Tokarev SVT-40 7.62x54R rifle",
        ["displayName"] = "SVT-40",
        ["displayType"] = "Assault Carbine",
        ["weight"] = 4.1,
        ["value"] = 64000,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["equipSlot"] = WEAPONSLOTS.PRIMARY.ID,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/weapons/svt.png", "smooth"),

        ["sizeX"] = 6,
        ["sizeY"] = 1,

        ["defAtts"] = "XQAAAQB6AQAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8OSzbA7bh+n22rgF3eZfKtFbSq5Sv+U+sy+44faPgqnhcKVRO4XjwHGPSoIh7Eyzb+O4+J8wGaj+XHNqll6K87d1ISHf4dqwegtt2oyHmnvVS5LvAV7DerEoOhNerbQm4BKVKDKlTI3EcZpjGzrUpmsVbObipc2xgipczd6X/2KSKZ5rf9HQ=="
    }

    EFGMITEMS["arc9_eft_sks"] = {
        ["fullName"] = "TOZ Simonov SKS 7.62x39 carbine",
        ["displayName"] = "SKS",
        ["displayType"] = "Assault Carbine",
        ["weight"] = 3.7,
        ["value"] = 29000,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["equipSlot"] = WEAPONSLOTS.PRIMARY.ID,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/weapons/sks.png", "smooth"),

        ["sizeX"] = 5,
        ["sizeY"] = 1,

        ["defAtts"] = "XQAAAQDeAQAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8OSgZMg8rR1f1NriFw604PtByzx3OWWZtOO4j0PQ2t5a1OGJX8eUlI9fNvLL68bctwYP8ZatKY+oTkz82RpebfT+LImbnfnVcexmiiZa0A5CUTPYWS9RAQTvDWST4QO/CBTeDXHHhB4cJK3NtOwRWC61qABII+gzX5mv+54qT8t54sGw6aF78vepy4igYkAA=="
    }

    EFGMITEMS["arc9_eft_vpo101"] = {
        ["fullName"] = "Molot Arms VPO-101 Vepr-Hunter 7.62x51 carbine",
        ["displayName"] = "VPO-101 Vepr-Hunter",
        ["displayType"] = "Assault Carbine",
        ["weight"] = 3.8,
        ["value"] = 44000,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["equipSlot"] = WEAPONSLOTS.PRIMARY.ID,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/weapons/vpo101.png", "smooth"),

        ["sizeX"] = 5,
        ["sizeY"] = 2,

        ["defAtts"] = "XQAAAQApAQAAAAAAAAA9iIIiM7hMNz0dhIkbkvLjTdSR5gRNNIHH3iM11FXbdH8EhvqeVEf4e8s8pqSUeHr5dxjuk5VJ16uZIcKjKrixVz39yI+NMVUz4BMktvpaajFsUrpQQ991pxbvCO8lQKmywBJ6rWU6guUPzN0KWgGObGzJIr8A"
    }

    EFGMITEMS["arc9_eft_vpo136"] = {
        ["fullName"] = "Molot Arms VPO-136 Vepr-KM 7.62x39 carbine",
        ["displayName"] = "VPO-136 Vepr-KM",
        ["displayType"] = "Assault Carbine",
        ["weight"] = 3.2,
        ["value"] = 33000,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["equipSlot"] = WEAPONSLOTS.PRIMARY.ID,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/weapons/vpo136.png", "smooth"),

        ["sizeX"] = 5,
        ["sizeY"] = 2,

        ["defAtts"] = "XQAAAQAuAgAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8NWDT+kEGPPnFjslbt4xbIPd/q60hodE43tM1ytr7bEv2N6nxkaKveBZRkZUauda0ZYGJLOlmOSCuDhTa3lybTfDnW8PlYla1TjpOTM44622G+Fu1yLJZEUlu+WYLoqDgn5Q0qpQ5cQaGBRB7jVRUzOaos2wCkolw/ZW8XD00nBhh9rMhXARH3RO+9AXj5TL2Rm7HKQ5xAKwa1pbLwXHZoAl1AXeu8rNavxEdKZFPuTuU/6E2nG30KkPKaH7c="
    }

    EFGMITEMS["arc9_eft_vpo209"] = {
        ["fullName"] = "Molot Arms VPO-209 .366 TKM carbine",
        ["displayName"] = "VPO-209",
        ["displayType"] = "Assault Carbine",
        ["weight"] = 3.2,
        ["value"] = 35000,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["equipSlot"] = WEAPONSLOTS.PRIMARY.ID,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/weapons/vpo209.png", "smooth"),

        ["sizeX"] = 5,
        ["sizeY"] = 2,

        ["defAtts"] = "XQAAAQAtAgAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8NWDT+kEGPPnFjslbt4xjmVkJBjle8bjtok2Ua8haAP+W7CrzgCP8lRbkXtTOXSnQ59p7RSkhFnm7rDKP3TZqZ2FvTqbFAqb4BJ0neIez5VROHBPR8YPzC9OI3tAC8HhYOuXh2hTUT7GEgp9Ck5ja5eJnuDC3WfWIJ1hLNqg9NXvkjaA3c4rI1W6U5FbjPnAOxjJ52vrb4dfq6Jeacsvi79ZUINJmjTy8v7Ze9ohVBEwURQyE+Jw=="
    }

    -- assault rifles
    EFGMITEMS["arc9_eft_velociraptor"] = {
        ["fullName"] = "Aklys Defense Velociraptor .300 Blackout assault rifle",
        ["displayName"] = "Velociraptor .300 BLK",
        ["displayType"] = "Assault Rifle",
        ["weight"] = 3.5,
        ["value"] = 90000,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["equipSlot"] = WEAPONSLOTS.PRIMARY.ID,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/weapons/velociraptor.png", "smooth"),

        ["sizeX"] = 4,
        ["sizeY"] = 2,

        ["defAtts"] = "XQAAAQCQAQAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8ONwzg/QXs7OyJFuxzQi6LzMsFSvNU1yACpZwRaPs5EodvVwyjcJT3XwS6d+9+4ug91/qR+ermrEClJty912QBtqdui+PMzm1CjpMD8XFPO1LEU1e/FMACiOW77NtOuUxG6WPaO5xD1SVFY7X6TTXF+F+vOmlZGLw+ctKeMR7iEGa1XR3kWcFnWoV0jvNOMOE3RclEYd+ufnPfFELtEqyWGZbV3InaGrO/j5uE"
    }

    EFGMITEMS["arc9_eft_ak101"] = {
        ["fullName"] = "Kalashnikov AK-101 5.56x45 assault rifle",
        ["displayName"] = "AK-101",
        ["displayType"] = "Assault Rifle",
        ["weight"] = 3.6,
        ["value"] = 39000,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["equipSlot"] = WEAPONSLOTS.PRIMARY.ID,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/weapons/ak101.png", "smooth"),

        ["sizeX"] = 5,
        ["sizeY"] = 2,

        ["defAtts"] = "XQAAAQA5AgAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8NWDT+kEGPPnFlfSO8Nqi4JBHKWbddf3eB9qikwLxMV8hvMeGwx/baMSBnueQ4qeTkj3h91Z8A8ihT5YfyyjjGfPN3J+M718JTJlY6OHojxYLS7+y5YfitgfXUB+eNLJVOEjKXP9KSWXtC/iUJuY5IalPQDwJEjXIUAXD22lFHReNyn3a0SZFFWAQamU4zGnGnfDVHqZfvfYoLh5wPwfohhlrAfYdncvutPBetQEVgqI556p/fOgo="
    }

    EFGMITEMS["arc9_eft_ak102"] = {
        ["fullName"] = "Kalashnikov AK-102 5.56x45 assault rifle",
        ["displayName"] = "AK-102",
        ["displayType"] = "Assault Rifle",
        ["weight"] = 3.2,
        ["value"] = 45000,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["equipSlot"] = WEAPONSLOTS.PRIMARY.ID,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/weapons/ak102.png", "smooth"),

        ["sizeX"] = 4,
        ["sizeY"] = 2,

        ["defAtts"] = "XQAAAQA5AgAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8NWDT+kEGPPnFlfSO8Ns6AZxWP3PlA/84ffW/F1EvjIsK44URuKcDSa+VS+CwgoqFlAy5J222cRX/Vjj6JS7X3TfsYbz/5rO2KJigMDwoHVnv+N2vPihkaSuPQk0Z62mkPUC8GednFAlj8OUUkQX6MyQgVivpPVy5wfoYu+PH1sInwaIWaMR5cUiu32Yj9F1z3uDdQmK0ocSXuZncKe2mBgoHcmd1ip1PvgElDwXick18vDi3Zgrk="
    }

    EFGMITEMS["arc9_eft_ak103"] = {
        ["fullName"] = "Kalashnikov AK-103 7.62x39 assault rifle",
        ["displayName"] = "AK-103",
        ["displayType"] = "Assault Rifle",
        ["weight"] = 3.6,
        ["value"] = 48000,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["equipSlot"] = WEAPONSLOTS.PRIMARY.ID,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/weapons/ak103.png", "smooth"),

        ["sizeX"] = 5,
        ["sizeY"] = 2,

        ["defAtts"] = "XQAAAQBiAgAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8NWDT+kEGPPnFlfSO8Nu7maxWP3PlA/84ffW/F1EvjIsK44URskLjrU3INVpOUUpW/T+X8KaCPCqXRuwyOfDk8iB1lfs9JmT/oZc7o/a/qSaZj07jExj7OfYd4nzvmulpMNSijwj9hDtpYct603tBDjIZi7SaBw6gexLd0U23pTrs72UmoWXtD9KNq76NfTbqPRmcA6SbLoawCvse/HTjDsawwnZc3+puJ0RALoMUE+0iRJciXJ32NzgsC"
    }

    EFGMITEMS["arc9_eft_ak104"] = {
        ["fullName"] = "Kalashnikov AK-104 7.62x39 assault rifle",
        ["displayName"] = "AK-104",
        ["displayType"] = "Assault Rifle",
        ["weight"] = 3.2,
        ["value"] = 41000,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["equipSlot"] = WEAPONSLOTS.PRIMARY.ID,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/weapons/ak104.png", "smooth"),

        ["sizeX"] = 4,
        ["sizeY"] = 2,

        ["defAtts"] = "XQAAAQBiAgAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8NWDT+kEGPPnFlfSO8Nw6CxwPL9zZwK6qbhs1exY95EYTr5o7kpJWXwunlf6BMvZGfefnONSZi5v+97rVtOxLFfbUJVXA96l7paialxEHSYoJucJO7oOgSQfVpJj7noQo+36s5FPycPcRRCx0JeW7AajTDITbJcnocmhd5rdrmuWkgCDJouk0rREZLqkokYmKBNbKZ48dpjGJ9ou7ViUnTYn0U6OI/QlJj1jLvg0ZB00GRX0lrMd2NzjkmsAA="
    }

    EFGMITEMS["arc9_eft_ak105"] = {
        ["fullName"] = "Kalashnikov AK-105 5.45x39 assault rifle",
        ["displayName"] = "AK-105",
        ["displayType"] = "Assault Rifle",
        ["weight"] = 3.2,
        ["value"] = 46000,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["equipSlot"] = WEAPONSLOTS.PRIMARY.ID,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/weapons/ak105.png", "smooth"),

        ["sizeX"] = 4,
        ["sizeY"] = 2,

        ["defAtts"] = "XQAAAQBRAgAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8NWDT+kEGPPnFlfSO8Nyw3wwPL9zZwK6qbhs1exY95EYTr5o7kpJWXwunlf6BMuwy+UTZW8lwoXi0o0oO6mTyzbfX13P1TDZ7nepb7LCA4HwekfWeQK6Dkwc3KyunQhPThpMpchMGWDfSdnbdjN7B5UZ2uZml3p39bjYBSd+m2s5aFRZSF8fWDdN8Vp3JhfkG6pHRzWNGKpLrPTYY7i9blTSAEH+c9CaWU2QEV9jk8X+mhyPba5pvfkyFz7gA="
    }

    EFGMITEMS["arc9_eft_ak12"] = {
        ["fullName"] = "Kalashnikov AK-12 5.45x39 assault rifle",
        ["displayName"] = "AK-12",
        ["displayType"] = "Assault Rifle",
        ["weight"] = 3.6,
        ["value"] = 88000,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["equipSlot"] = WEAPONSLOTS.PRIMARY.ID,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/weapons/ak12.png", "smooth"),

        ["sizeX"] = 5,
        ["sizeY"] = 2,

        ["defAtts"] = "XQAAAQCtAgAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8LcWHiLIpod33BsI9oXI+YvXrczo24nxbYfjlSRF1YF3Vl54iDtNZH7jPs3xx40T4Kf1X+gWLUW1ViEr6HSJEUxNUaGjKIZQEfKhkrbyH/BxRRT2U425yK0NIO+vkp8ofbDCsow17cBYwfGphoc+1XymTdWUoNudQ27NQtatOGQTSWorZrL3Ox8EIW5nf7n0aB0UGwNFtN1EdHwBcAlpNU9e3Yqbjd1D6ZEkOtrgtib5yZcisBhERmD/xfMAA="
    }

    EFGMITEMS["arc9_eft_ak74"] = {
        ["fullName"] = "Kalashnikov AK-74 5.45x39 assault rifle",
        ["displayName"] = "AK-74",
        ["displayType"] = "Assault Rifle",
        ["weight"] = 3.3,
        ["value"] = 38000,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["equipSlot"] = WEAPONSLOTS.PRIMARY.ID,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/weapons/ak74.png", "smooth"),

        ["sizeX"] = 5,
        ["sizeY"] = 2,

        ["defAtts"] = "XQAAAQAmAgAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8NWDT+kEGPPnFlfSScSitmwGLrqnyyN98JIPzpwPIX/9KgyF1GotiIuhFjeTGCSDJNctN6I8y9DxmfRJ9NhrlCsOICkjgfTK9wJs93JWXc1UzZNryCAvuBo3eDytRNqk+TwEb/gwgAC2ek6u/pQcEgS2dVrjwE/5HWSVXhnkcDGxhxRyEKxDtNtlbIClhiAfkiz039xdTxVd9/+XPgmKlytFqJbRMYh5Kcqylt0m80RZe10reQMgA="
    }

    EFGMITEMS["arc9_eft_ak74m"] = {
        ["fullName"] = "Kalashnikov AK-74M 5.45x39 assault rifle",
        ["displayName"] = "AK-74M",
        ["displayType"] = "Assault Rifle",
        ["weight"] = 3.6,
        ["value"] = 40000,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["equipSlot"] = WEAPONSLOTS.PRIMARY.ID,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/weapons/ak74m.png", "smooth"),

        ["sizeX"] = 5,
        ["sizeY"] = 2,

        ["defAtts"] = "XQAAAQAhAgAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8NWDT+kEGPPnFlfSScSybP+C3Y0ij7z9iVh7t2mLczDAV3rxV/Tab/iWNW9/ErKFP8/+D+Vim0am/Po/HkaFLcHxy1NAWYDWhE5TToWI9DcWlSySfGeqJ5X0F+A9G4JpJ5+ITrwjilXBDXYGI7RsX2jg4Rm3sgACPoO8EI1B12xnH0ZXUUO/fkPxxhECig2eKQajc16XJKoEAjfqQweUxCYKPm8wUCuyU4BhqH1tEJhgoO5wA="
    }

    EFGMITEMS["arc9_eft_akm"] = {
        ["fullName"] = "Kalashnikov AKM 7.62x39 assault rifle",
        ["displayName"] = "AKM",
        ["displayType"] = "Assault Rifle",
        ["weight"] = 3.5,
        ["value"] = 46000,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["equipSlot"] = WEAPONSLOTS.PRIMARY.ID,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/weapons/akm.png", "smooth"),

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
        ["equipSlot"] = WEAPONSLOTS.PRIMARY.ID,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/weapons/akms.png", "smooth"),

        ["sizeX"] = 5,
        ["sizeY"] = 2,

        ["defAtts"] = "XQAAAQACAgAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8NWDT+kEGPPnFlfSyGhIy8o/wiKvL93nxHBIW4c+xoXNI8ovSyL1sZpt99SrYfcdc39Atnyt4+MSL8FR1c8qG5KgOkAQW8ZPFremApexmyQYv+4oOojOjTOMITQoGMyenBqlKsSfxVnv4k3Pyjih2HqDeiTqKxVs0o+3377oApURVXEe0UWRmtoafw+i8ugX4Bzrizxw9vUXgTSfbMOozCJXgorGkJtLkavNlq"
    }

    EFGMITEMS["arc9_eft_aks74"] = {
        ["fullName"] = "Kalashnikov AKS-74 5.45x39 assault rifle",
        ["displayName"] = "AKS-74",
        ["displayType"] = "Assault Rifle",
        ["weight"] = 3.1,
        ["value"] = 35000,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["equipSlot"] = WEAPONSLOTS.PRIMARY.ID,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/weapons/aks74.png", "smooth"),

        ["sizeX"] = 5,
        ["sizeY"] = 2,

        ["defAtts"] = "XQAAAQAnAgAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8NWDT+kEGPPnFlfSScSitmwGLrqnyyN98JIPzpwPIX/9KgyF1GotiIuhFjeTGCSDJNctN6BTySRMfHDIfbSAKxpBDZq+GKhGskyxMt2ZsyF/cYJ8evGfBHLi4OO71kf2GvuG67phqgfQ8b0EKImJwbf+GbLs762Ta7vR9BfkOjN1W9KxUFehje0Yzi5g+ZMTYcoRJ/VJHlSb0RcpYdWZSy4f0non5h+n81LAxQqZRULDI/VbcaxiDj"
    }

    EFGMITEMS["arc9_eft_aks74u"] = {
        ["fullName"] = "Kalashnikov AKS-74U 5.45x39 assault rifle",
        ["displayName"] = "AKS-74U",
        ["displayType"] = "Assault Rifle",
        ["weight"] = 2.6,
        ["value"] = 29000,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["equipSlot"] = WEAPONSLOTS.PRIMARY.ID,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/weapons/aks74u.png", "smooth"),

        ["sizeX"] = 4,
        ["sizeY"] = 2,

        ["defAtts"] = "XQAAAQDaAQAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8LcWZNz742AnWnBW5VFLsMbYkg5JCtgcCZFQzZvKB7kdZlb7hYagJ7xTPFZ2McEz65077s8B+FWvzBE8FH3UO1VnwHvhCXw7ua73XK/ipwVxqxGmfGuH6rK0r8VL632B6ztnI8PKNABt3A2EItiEhsYVqkVySGPj2sdgNrDFN6ojMeJ2C0knLtyPiBB1fHZ0rAgFPuOvPzMd1jAA=="
    }

    EFGMITEMS["arc9_eft_asval"] = {
        ["fullName"] = "AS VAL 9x39 special assault rifle",
        ["displayName"] = "AS VAL",
        ["displayType"] = "Assault Rifle",
        ["weight"] = 2.5,
        ["value"] = 145000,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["equipSlot"] = WEAPONSLOTS.PRIMARY.ID,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/weapons/asval.png", "smooth"),

        ["sizeX"] = 5,
        ["sizeY"] = 2,

        ["defAtts"] = "XQAAAQCSAQAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8OwmVfT2hq/H64qBlSsLc/OGn6XwHM3Rbx0N1ed9Tqdupk/nUylj0UY2YpYpkPX3jeqgqAnCrVaPLvk0QTUg3LiNYYr49MDIapMWEO2/dbjsxcacl4KCmDehoHgxY0hbp4PPja3elSuaXxpvgvSz44rShom0jdSFYl4PdazbHs57zFavwA"
    }

    EFGMITEMS["arc9_eft_ash12"] = {
        ["fullName"] = "ASh-12 12.7x55 assault rifle",
        ["displayName"] = "ASh-12",
        ["displayType"] = "Assault Rifle",
        ["weight"] = 6.1,
        ["value"] = 90000,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["equipSlot"] = WEAPONSLOTS.PRIMARY.ID,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/weapons/ash12.png", "smooth"),

        ["sizeX"] = 4,
        ["sizeY"] = 2,

        ["defAtts"] = "XQAAAQCeAQAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8Lcjh5PiK/llZGDr7oa+u0gaZ5EJru7gxOqJdvNbXpy5tlUiCzfDxOhcoz5+HaAwLcuGJng8zD00WC4H58kQa5GFmHMGDajP9AjQuzCyaf/ErixY5umfnP41eoXt+tOg6oIuPRiquOyhx7c78EIYCpis14lvAw28laBPvvJoVLaNT9SgA="
    }

    EFGMITEMS["arc9_eft_m4a1"] = {
        ["fullName"] = "Colt M4A1 5.56x45 assault rifle",
        ["displayName"] = "M4A1",
        ["displayType"] = "Assault Rifle",
        ["weight"] = 2.9,
        ["value"] = 97000,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["equipSlot"] = WEAPONSLOTS.PRIMARY.ID,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/weapons/m4a1.png", "smooth"),

        ["sizeX"] = 5,
        ["sizeY"] = 2,

        ["defAtts"] = "XQAAAQABAwAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8ONwzg/TnvSdOuj9Kx9YEwhGAFo9OdI268mAArnELh5agZrRYl48tzyKSHZRxI8QcbeeBN+HCcijbalGB5/5S4ud0YP8XQL0kyyAzg4dZq5v9C9Wgv/bLG0NZqUJAylj3Idh4haZYZGesG1yvvOsxry08LzOH4dRl5daY6BYz/Rk2MD1eDXcxDTMFpeaRixzbF65RRu/z9uAt+9nPYoM8toJT12NTIjQiOl5z5wO+nUYwRfdvjMzBr05lk5qree48Vrp2T/7brPVo+4MqBalIlt3aJqtzo2oRIcI0V04b9ZtZQkcbp7ZcrFOHoirKYvsiogOt3JSpRHQ=="
    }

    EFGMITEMS["arc9_eft_sa58"] = {
        ["fullName"] = "DS Arms SA58 7.62x51 assault rifle",
        ["displayName"] = "DSA SA58",
        ["displayType"] = "Assault Rifle",
        ["weight"] = 3.9,
        ["value"] = 108000,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["equipSlot"] = WEAPONSLOTS.PRIMARY.ID,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/weapons/sa58.png", "smooth"),

        ["sizeX"] = 5,
        ["sizeY"] = 2,

        ["defAtts"] = "XQAAAQDSAgAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8OSPFaQ+Z9j7jFV/QkWSo8LF+HuEPkjjdPYu1ECAHLWrbSjF+V6XRHGwHs6qPztm+72vAncD3zcqemaa+4eLgG/GWVH8hbIr/NcIAL5P/2ZsKX/iK62hXF9TSM56Qai5nL/b/efkp81vIa+kT9BDbplJP1czlCfdAYwjpwNkO4CcFjKPplwQXe8dZC1JZaBVaovscQbjBs0RaRXH5XsdxvPdvXMmC0/kZOWYmkBQrD/mKs2yk2NJhqIBTv/xM/FCQRSQKG"
    }

    EFGMITEMS["arc9_eft_mdr"] = {
        ["fullName"] = "Desert Tech MDR 7.62x51 assault rifle",
        ["displayName"] = "DT MDR .308",
        ["displayType"] = "Assault Rifle",
        ["weight"] = 4.4,
        ["value"] = 189000,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["equipSlot"] = WEAPONSLOTS.PRIMARY.ID,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/weapons/mdr.png", "smooth"),

        ["sizeX"] = 4,
        ["sizeY"] = 2,

        ["defAtts"] = "XQAAAQD4AQAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8ONwqzmFISRLjG/VemL4oZlhMCtKZULDcmVXRhJNGlioWR8BkkaIttiYQupxDEIfTeGA7uawLFRKY/x3l2r8NjPnsTTYc9PxAfJBRmw2WAq1b6oq07A3t91rQ7nIyj6v6oXuhN8gDnoTHGCV5Zge4enwyPxKYAZMp1HayVY03PYyXPtDVuvI4fwAW/Halwd8LLzMvSwRSGdbwqDx8FrbBw"
    }

    EFGMITEMS["arc9_eft_mdr556"] = {
        ["fullName"] = "Desert Tech MDR 5.56x45 assault rifle",
        ["displayName"] = "DT MDR 5.56",
        ["displayType"] = "Assault Rifle",
        ["weight"] = 3.9,
        ["value"] = 83000,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["equipSlot"] = WEAPONSLOTS.PRIMARY.ID,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/weapons/mdr556.png", "smooth"),

        ["sizeX"] = 4,
        ["sizeY"] = 2,

        ["defAtts"] = "XQAAAQA8AgAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8ONwqzmFISRLjG/VemL4oZlhMCtKZULDcmVXRhJNGlioWR8BkkaIttiYQupxDEIfTeGA7szStyP1abuabMk2pZ1RHFmvPXZDFNsQxVOHYjjaBTVtxztjaHlzfTLymJyZSQaz0G7CgE/zPv3fYK39RivcrJynHmCMoSNpyd3t3NENOpOI3iU2XeqyhNRRhNh4NV3vI7Ahtq+P6NLCklaW+PoVAYZQ2yeE7A"
    }

    EFGMITEMS["arc9_eft_scarh"] = {
        ["fullName"] = "FN SCAR-H 7.62x51 assault rifle",
        ["displayName"] = "SCAR-H",
        ["displayType"] = "Assault Rifle",
        ["weight"] = 3.8,
        ["value"] = 149000,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["equipSlot"] = WEAPONSLOTS.PRIMARY.ID,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/weapons/scarh.png", "smooth"),

        ["sizeX"] = 5,
        ["sizeY"] = 2,

        ["defAtts"] = "XQAAAQCvAwAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8Lchzpvw0LefC8cKmSsx2FONi6w2fdtBqbRE9Vb00gVDvijCNLXoLoPgvffNK3Ts0h+hlNZzplarnB0yQ1tBql+DJXHQE5KjnHwrHTsv99djgpg623p2x8ZIXRr9Hj0bkJ+fo0BE0Ktx1Np1bwp1Ih15WjqZW6ODVgWg+t0eBEfZ6G2XhERPOLgRUqR4lA41QPVpN5CBrvXz8vYqez4KtrMRYyxW6kL38KYR9g8LWYhZYV2qKDoUAnUqh7aBSE70USzJjb0yj8li0BI8sZifzAZKv+NVhSR9gHgwvSdmScKTpK"
    }

    EFGMITEMS["arc9_eft_scarl"] = {
        ["fullName"] = "FN SCAR-L 5.56x45 assault rifle",
        ["displayName"] = "SCAR-L",
        ["displayType"] = "Assault Rifle",
        ["weight"] = 3.2,
        ["value"] = 64000,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["equipSlot"] = WEAPONSLOTS.PRIMARY.ID,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/weapons/scarl.png", "smooth"),

        ["sizeX"] = 5,
        ["sizeY"] = 2,

        ["defAtts"] = "XQAAAQCTAwAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8Lchzpvw0LefC8cKmSsx2FONi6w2fdtBqbRE9Vb00gVDvijCNLXoLoPgvffNK3Ts0h+hlNZzplarnB0yQ1tBql+DJXHQE5KjnHwrHTsv99djgpg623p2x8ZIXRr9Hj0bkJ+fpSP5oQl1gUd/uBzgHZXPqYDia3zGatZntVOmvdLNRO6b62mBLy/jeajU1y4EMLAz2jReJ3sKDWbGuBmk3qznnO0wjcIWxrS5ijwqLbZ4qrwsohYL1bynfst1WEfzM57lgSYhmRNvLgzdoGMHRlj69by0vLYwo5wfaPy5sLVqYFK+DYAA=="
    }

    EFGMITEMS["arc9_eft_hk416"] = {
        ["fullName"] = "HK 416A5 5.56x45 assault rifle",
        ["displayName"] = "HK 416A5",
        ["displayType"] = "Assault Rifle",
        ["weight"] = 3.8,
        ["value"] = 99000,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["equipSlot"] = WEAPONSLOTS.PRIMARY.ID,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/weapons/hk416.png", "smooth"),

        ["sizeX"] = 5,
        ["sizeY"] = 2,

        ["defAtts"] = "XQAAAQBUAwAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8ONwzg/8xPddUIcJzvtQD1KU7srpRLtA975iQzkGu1iCVddOzJGUaKhmxG58LYnmpfteaZRuBnLbRn2c1sWgRVNteDRAcEffZDHLJVMHsOZkim5FCv+yaXcGRadq388nbXl0llD5GKT6H/wYm+qA35tCsllQ5kmlxetwyXQQqaa4prMpNNYqm6ijjPUV3ZdPq4xbXusdXvJZzMag96690TVOOWkpnrzeGGygm0BbEXtEYz/i6b+lq1sfZPz5zG8RLsGMjL7G3dodBsvpBuvPTnfVO8F+R+HQaW/eyp53aYniBY3FSLPL1JVTYjv0UlJ/8RlLi+NJpvYA=="
    }

    EFGMITEMS["arc9_eft_g36"] = {
        ["fullName"] = "HK G36 5.56x45 assault rifle",
        ["displayName"] = "G36",
        ["displayType"] = "Assault Rifle",
        ["weight"] = 3,
        ["value"] = 47000,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["equipSlot"] = WEAPONSLOTS.PRIMARY.ID,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/weapons/g36.png", "smooth"),

        ["sizeX"] = 6,
        ["sizeY"] = 2,

        ["defAtts"] = "XQAAAQD9AQAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8MXq1bvq6bgjOSIGCJgLqbsTlF0WfwVNrBtJxovR3TGwJB9vxZpkenqFGqgI+S6lhrRXjW8nAjeuQIEojfe/G/0tPbd0TbBOrG30rYlqGhwt7UwkcVdCWnvOCVUbB6GOvcvzXsHiv05wkgRSPi786QKDPyYPjUWTPog9WH7UQPlgwlHkO8pYGOvi487KHq7ejUGOhU5JjdQUHgpB/vwl9moduMKFWr/Q5VPIgA"
    }

    EFGMITEMS["arc9_eft_9a91"] = {
        ["fullName"] = "KBP 9A-91 9x39 compact assault rifle",
        ["displayName"] = "9A-91",
        ["displayType"] = "Assault Rifle",
        ["weight"] = 2.4,
        ["value"] = 36000,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["equipSlot"] = WEAPONSLOTS.PRIMARY.ID,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/weapons/9a91.png", "smooth"),

        ["sizeX"] = 4,
        ["sizeY"] = 2,

        ["defAtts"] = "XQAAAQBBAQAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8OxEj3M6NEz8aDJRJgCO71iBAJt5wSUKAbDrCLqIIbEgbmW76rULjIaHb3prbj4/85H8qolydNzsXrEQsuea+jWEhoj8hAkeQGbBFmj8RHquOzwBBXq9IHdbh2lXhcIYIffJOIsG6syZVOB7HcxYSfXeR7LYv+KHF0l4YROQA="
    }

    EFGMITEMS["arc9_eft_mk47_mutant"] = {
        ["fullName"] = "CMMG Mk47 Mutant 7.62x39 assault rifle",
        ["displayName"] = "Mk47",
        ["displayType"] = "Assault Rifle",
        ["weight"] = 2.3,
        ["value"] = 110000,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["equipSlot"] = WEAPONSLOTS.PRIMARY.ID,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/weapons/mk47_mutant.png", "smooth"),

        ["sizeX"] = 4,
        ["sizeY"] = 2,

        ["defAtts"] = "XQAAAQAkAwAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8Lchzpvw0LefC8nJifjVbTknHCQBjxUoQrnXPJE9wVW1sa2b3/dGIriqHhC9sLIkt8/JzzkdUEJ5nYk8T3lqyL22ZE1nvjUItPtSzo866Tp0eCSJaACFrWrJ8YcYaYztbxHFp6JS7x5FMSjLlzJNh2WYabJqumoLED74PSOkpXUHoChT5JEVUPXArnvXUUmh/B0SxRZsXUShWtLcYL7xA8185qm6V4YJrRvQZqI6+h/yqwsrgCkidnvmmksQjWyFV0KoH/5QKKkltDU66v3OzX6zZi7O8g1LJUnxM1COq0qyngret0kIyDwtmewwOxuVfQ"
    }

    EFGMITEMS["arc9_eft_rd704"] = {
        ["fullName"] = "Rifle Dynamics RD-704 7.62x39 assault rifle",
        ["displayName"] = "RD-704",
        ["displayType"] = "Assault Rifle",
        ["weight"] = 3.8,
        ["value"] = 88000,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["equipSlot"] = WEAPONSLOTS.PRIMARY.ID,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/weapons/rd704.png", "smooth"),

        ["sizeX"] = 4,
        ["sizeY"] = 2,

        ["defAtts"] = "XQAAAQBtAgAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8NWDT+kEGPPnGI9Ho0W6AoGsTnmW59C2oiRFRBLwgoxe4xV0WX6qxNx8dyJP/FQw1B3pV0KKOxnfGbRot9mzre6sDSWfks4hMl1SaxfynBKxJqOIslgwM5T8W8PwovOlUaB/xS7JArBkKF0e7Qnj+tsBEsHJNM36FMgi3SNVvtbWFhloUvN6wUNCbT4u3uCH/owxYXyZfzMwwZHkXfyowvkaATWQWjbNJv8IcEJVUkYj5zgJdDMiFvsIk0TuXbSt/PMLL+sTx7kuKhwzk6SWAO138NTu2BE0EaSlj8AUUA"
    }

    EFGMITEMS["arc9_eft_scarx17"] = {
        ["fullName"] = "FN SCAR-H X-17 7.62x51 assault rifle",
        ["displayName"] = "SCAR-H X-17",
        ["displayType"] = "Assault Rifle",
        ["weight"] = 3.8,
        ["value"] = 169000,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["equipSlot"] = WEAPONSLOTS.PRIMARY.ID,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/weapons/scarh.png", "smooth"),

        ["sizeX"] = 5,
        ["sizeY"] = 2,

        ["defAtts"] = "XQAAAQBqAwAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8Lchzpvw0LefC8cKmSsx2FONi6w2fdtBqbRE9Vb00gVDvijCNLXoLoPgvffNK3Ts0huoSj2t/J0Qabzrcgv9pIaOT9CCdac3Y+YiE7NjVh97i2MicncONHdm6NmZli1bQsBg+UTHTU98QHIxHQLweawMprPi2gNBjCbnVttJXN95pQwlC0EmP5DBXXneqo6nXKML8S5RR1fGFOKRvar9owEqwt4A1DEstTSYzieAWWa+SXpmEeUk1ILuF0+09C2JkHAU7J9gP7ARmjV8LngiaZT1VbsnJvpbHAiNAFCd/mMbzcEazLVyfG"
    }

    EFGMITEMS["arc9_eft_mcx"] = {
        ["fullName"] = "SIG MCX .300 Blackout assault rifle",
        ["displayName"] = "MCX .300 BLK",
        ["displayType"] = "Assault Rifle",
        ["weight"] = 2.7,
        ["value"] = 97000,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["equipSlot"] = WEAPONSLOTS.PRIMARY.ID,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/weapons/mcx.png", "smooth"),

        ["sizeX"] = 4,
        ["sizeY"] = 2,

        ["defAtts"] = "XQAAAQAdAwAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8NVkzy8EViB521uhMOB77JnlX7Rf/HlUVbSUxcN9VszlqQdLv7dF0JZ1wMfEP6+N2HYFKR9bEG2TOe6lmbipfzzu7o5Ky8Exbt4OpGoxP/uHNS2BLN/DPj5OCXszFeLpZ5lRsbTRyOuG/LN/wIJIco9iS8BsAfDdjO7tQtFFh3cyiqoicfwUfGNCc34/UyRckGL6bBjmN7zY6yErBPr9CujPk5uoquMJ4O2GyXTciXj8TNXAmGq/4zJdn9FUoBfXaegO2lqB38h/qDpv96EWdziuNphNAZxi9st5R69SQZOmY="
    }

    EFGMITEMS["arc9_eft_spear"] = {
        ["fullName"] = "SIG MCX-SPEAR 6.8x51 assault rifle",
        ["displayName"] = "MCX-SPEAR 6.8",
        ["displayType"] = "Assault Rifle",
        ["weight"] = 4.2,
        ["value"] = 249000,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["equipSlot"] = WEAPONSLOTS.PRIMARY.ID,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/weapons/spear.png", "smooth"),

        ["sizeX"] = 6,
        ["sizeY"] = 2,

        ["defAtts"] = "XQAAAQCcAwAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8OSoeUBP1Ca6xQ9hHtW/bYXYqRd2dsqgaXb7nIqkg11g1cQNMakbKvTttl2nuw1Xh7+2zy8kXwuBVXVfb0oZ0sQU720KkI7u9mCZUx6Oc6P6gMSwyGv5ZqluSU2GU400dWqr++epGrAhypcxQFxyCdtCigys0IadzVVrPxLGVNgrC3f0fyEqPuk/knkBpwSDppmDIJLVx4EwHtR4dEKjRbVFJueC/JOub/ZCz9phkncUk6Co8MTDvAi8yUM6QNxr6Q8GTVhg5rj6o2AJDHmHU8ISvN5NqYmNVjDuf3O8VwFip467e5yQNsV2PaCo4xEVxotgO9GDmvE/POgqBOhHw/XQZWjUSYcr4="
    }

    EFGMITEMS["arc9_eft_auga1"] = {
        ["fullName"] = "Steyr AUG A1 5.56x45 assault rifle",
        ["displayName"] = "AUG A1",
        ["displayType"] = "Assault Rifle",
        ["weight"] = 3.8,
        ["value"] = 43000,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["equipSlot"] = WEAPONSLOTS.PRIMARY.ID,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/weapons/auga1.png", "smooth"),

        ["sizeX"] = 5,
        ["sizeY"] = 2,

        ["defAtts"] = "XQAAAQBBAQAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8LcnIp+MP5IAjMvmwgz+41xGNe7eZvA/1nI9Cc3a4tADEWgmIIhGF5MEPPSKpKJWeT1US7B+nAYrV/yEFLebEoK48CLni5W3/utnI27rSaRShCcF3Hte0TQh+sAISDqtmxsDQVioObg8U4lpY3LX/tA3qAUgIVmZTbg41LAA=="
    }

    EFGMITEMS["arc9_eft_aug"] = {
        ["fullName"] = "Steyr AUG A3 5.56x45 assault rifle",
        ["displayName"] = "AUG A3",
        ["displayType"] = "Assault Rifle",
        ["weight"] = 4,
        ["value"] = 56000,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["equipSlot"] = WEAPONSLOTS.PRIMARY.ID,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/weapons/aug.png", "smooth"),

        ["sizeX"] = 5,
        ["sizeY"] = 2,

        ["defAtts"] = "XQAAAQCyAQAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8LcnIp+MP5IAjLeVHoKL40hfYxDKj7oLj4ZNU256mz11eCzL7NBE0YCNJ4X4Zy+lv/FTEoou8qGqAYsurmuNrNiiMpqqkHCQ9drsIXXRRAAnzmy81uZfG5KASdPAOoFE7ujOpke/rjelaKNyB6TTsE5W0MW77oakZuqPt2JWdj0Hy+lpseDAvazaw="
    }

    EFGMITEMS["arc9_eft_avt"] = {
        ["fullName"] = "Tokarev AVT-40 7.62x54R automatic rifle",
        ["displayName"] = "AVT-40",
        ["displayType"] = "Assault Rifle",
        ["weight"] = 4.2,
        ["value"] = 61000,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["equipSlot"] = WEAPONSLOTS.PRIMARY.ID,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/weapons/avt.png", "smooth"),

        ["sizeX"] = 6,
        ["sizeY"] = 2,

        ["defAtts"] = "XQAAAQB6AQAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8OSzbA7bh+n22rgF3eZfKtFbSq5Sv+U+sy+44faPgqnhcKVRO4XjwHGPSoIh7Eyzb+O4+J8wGaj+XHNqll6K87d1ISHf4dqwegtt2oyHmnvVS5LvAV7DerEoOhNerbQm4BKVKDKlTI3EcZpy/eUCv548mEYlvgQBoJnVPfzwwniUzv7Y5AuQ=="
    }

    -- light machine guns
    EFGMITEMS["arc9_eft_m60e4"] = {
        ["fullName"] = "U.S. Ordnance M60E4 7.62x51 light machine gun",
        ["displayName"] = "M60E4",
        ["displayType"] = "Light Machine Gun",
        ["weight"] = 10,
        ["value"] = 100000,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["equipSlot"] = WEAPONSLOTS.PRIMARY.ID,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/weapons/m60e4.png", "smooth"),

        ["sizeX"] = 5,
        ["sizeY"] = 2,

        ["defAtts"] = "XQAAAQBUAgAAAAAAAAA9iIIiM7hMNz0dhIkbkvLjTdSR5gRNNIHH3iMso2fmTz8F3jy5pVr3uGXDL8fbOjv/zKw7ozNLG1nGdWzDvHAdCwDTMX9X/3j/xK3T+dxjdbxHrI7i1GBfkAxdqaA9Zd0SaHMWQquI5eJnyFO2VS61xiJY+jhXgz6DR5o+mvju9nG1wnFbkH8yrSDOyq5tjKTAFu68riDxMtL9lkaeDSxoXFnDEow5fM0GFiKB5MNNFKSUWHyZLnKNo42BxU4B5P4Sn2hL1Ya+IA=="
    }

    EFGMITEMS["arc9_eft_m60e6"] = {
        ["fullName"] = "U.S. Ordnance M60E6 7.62x51 light machine gun",
        ["displayName"] = "M60E6",
        ["displayType"] = "Light Machine Gun",
        ["weight"] = 9.4,
        ["value"] = 110000,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["equipSlot"] = WEAPONSLOTS.PRIMARY.ID,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/weapons/m60e6.png", "smooth"),

        ["sizeX"] = 5,
        ["sizeY"] = 2,

        ["defAtts"] = "XQAAAQCpAgAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8OSSsLLcJyAHCCocixFdnSv7HKuyXN99OF0r8E7y72hI9xM4LhZpazFPnoHK2XoCtAqnqs4JGM0rw+mGc6h3DXdBmlNItS6v+yeYD6W3SxhPJ4sDDaQfNGtQ2nRsCXnF8WyPAWAXHcPoSl5uPWm3mVw5CBlrC1Ba9TO3tsNFe5I5AQWUphNDBYBOdTtXYHRk666tjWYWY6S1byamgiDKCwwprLOuLajl+uAB1pdLrTKoYCCag9B8ZIXGmoVJY+9VCN+TQ7oQ=="
    }

    EFGMITEMS["arc9_eft_pkm"] = {
        ["fullName"] = "Kalashnikov PKM 7.62x54R machine gun",
        ["displayName"] = "PKM",
        ["displayType"] = "Light Machine Gun",
        ["weight"] = 8.9,
        ["value"] = 205000,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["equipSlot"] = WEAPONSLOTS.PRIMARY.ID,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/weapons/pkm.png", "smooth"),

        ["sizeX"] = 6,
        ["sizeY"] = 3,

        ["defAtts"] = "XQAAAQB1AQAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8LmM+VxqdivxON2A4c/UqwSJhqDo+4MgoaYe3T9Uq9jxbrXbeouPZLy1sIP/T9DyOZBwzjl8btLjhrC3FgFrmdqNCYWkz30yzsETGz/5o6wAs0ZzQw8mceqa3lJoSXZGbka9NLvH0SOwaeLSmbAtj5lQrj3w6en7CSh2yTolf1HY02GOWY"
    }

    EFGMITEMS["arc9_eft_pkp"] = {
        ["fullName"] = "Kalashnikov PKP 7.62x54R infantry machine gun",
        ["displayName"] = 'PKP "Pecheneg"',
        ["displayType"] = "Light Machine Gun",
        ["weight"] = 9.6,
        ["value"] = 230100,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["equipSlot"] = WEAPONSLOTS.PRIMARY.ID,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/weapons/pkp.png", "smooth"),

        ["sizeX"] = 6,
        ["sizeY"] = 3,

        ["defAtts"] = "XQAAAQBAAQAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8LmM+VxqdivxON6Som3vL2ybUBNPLkDFs7ArpEbRhf//vDzHLbNjwl/yi0+ghuUFk0qpomQmY51j7k5NmwRm4tC6nxVy7gbHQo7OSzUJB2xaJHe+Xp4GXZ/5OAUrxrBimVt5hyP/sKIQjw7g8P+evKxFjVgPcA"
    }

    EFGMITEMS["arc9_eft_rpd"] = {
        ["fullName"] = "Degtyarev RPD 7.62x39 machine gun",
        ["displayName"] = "RPD",
        ["displayType"] = "Light Machine Gun",
        ["weight"] = 7.4,
        ["value"] = 99000,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["equipSlot"] = WEAPONSLOTS.PRIMARY.ID,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/weapons/rpd.png", "smooth"),

        ["sizeX"] = 6,
        ["sizeY"] = 3,

        ["defAtts"] = "XQAAAQCiAQAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8OIg2Alsq6N5HJfzqGetoWgtBPuIFPieR7POjErtXp2hCvFJRW9NnJMkzk6x1OSJgTacqq2lLYClfHwBgbnP83d0UWq0A99jh/OIqT0b5jejBLSseE7AwTBYDbNdIr7/tWgsUDbjHMrFthXNQo+SDQl70q0QOkxRbNeUWcXrMiC8JogPK3ONwvewZBJL+tH5Y="
    }

    EFGMITEMS["arc9_eft_rpk16"] = {
        ["fullName"] = "RPK-16 5.45x39 light machine gun",
        ["displayName"] = "RPK-16",
        ["displayType"] = "Light Machine Gun",
        ["weight"] = 3.6,
        ["value"] = 68000,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["equipSlot"] = WEAPONSLOTS.PRIMARY.ID,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/weapons/rpk16.png", "smooth"),

        ["sizeX"] = 5,
        ["sizeY"] = 2,

        ["defAtts"] = "XQAAAQAkAwAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8OIg4EaB9tZlmxUqnNjWMtFUXsgURvra4DARqTRAAJ1RKCUZtu9ifdkwwgWqxrTiSkIN3cRyq1JU2zssDBPUgNM9gWFKMq3C5EZmUZjMNKqDyYhvdAEOAmXPBRkJNvoLbqNcdgeXAss6ysNQczRunkqp/viMiUYfhEyl0PGwrQHoJJwGi8gR7dtgM5nmcARnITnfgcNZjG1lESXIsA+hpMDBBnh3dOtiNGTNv98XUJ+RNmOr0g9JWKmxylNF5ZWJi7cuBE02UofijActj7CMzBFK7/rw=="
    }

    -- pistols
    EFGMITEMS["arc9_eft_m9a3"] = {
        ["fullName"] = "Beretta M9A3 9x19 pistol",
        ["displayName"] = "M9A3",
        ["displayType"] = "Pistol",
        ["weight"] = 0.8,
        ["value"] = 23000,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["equipSlot"] = WEAPONSLOTS.HOLSTER.ID,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/weapons/m9a3.png", "smooth"),

        ["sizeX"] = 2,
        ["sizeY"] = 1,

        ["defAtts"] = "XQAAAQCDAQAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8LmM+VxqdivwEJTPh3E+VFN6tQFSEw8nl+xsNZHkUqRC+DuxEPE4Hmq2ZF39I5/fW7oBi14Z7pNIIvvvTcmGH8EPSRl1Mgu31LkWQpOtv6A9h6lrhDeArrse4Q9wLpJvvlZzE2wk3jB1y52JTzihtkZKJlfFjhCjnhAA=="
    }

    EFGMITEMS["arc9_eft_pd20"] = {
        ["fullName"] = "20x1mm toy gun",
        ["displayName"] = "Blicky",
        ["displayType"] = "Pistol",
        ["weight"] = 0.1,
        ["value"] = 10000,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["equipSlot"] = WEAPONSLOTS.HOLSTER.ID,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/weapons/blicky.png", "smooth"),

        ["sizeX"] = 2,
        ["sizeY"] = 1,

        ["defAtts"] = "XQAAAQAXAAAAAAAAAAA9iIIiM7hMNz0dkAd2RJ793J7f29M/CuuhAA=="
    }

    EFGMITEMS["arc9_eft_m1911"] = {
        ["fullName"] = "Colt M1911A1 .45 ACP pistol",
        ["displayName"] = "M1911A1",
        ["displayType"] = "Pistol",
        ["weight"] = 1.2,
        ["value"] = 19000,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["equipSlot"] = WEAPONSLOTS.HOLSTER.ID,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/weapons/m1911.png", "smooth"),

        ["sizeX"] = 2,
        ["sizeY"] = 1,

        ["defAtts"] = "XQAAAQAJAgAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8LmM+Vxqdiva/+T8TWXFyZ6L+YGhlUEFGCfP6ZxRzhhtO4thQe+Y8iks9vtbjX/1mlPDmp6O4OLhhuzMvFkTlrQfPfK3ivuCRfw5mF2t9J9NMfTJXBYIwDkT8TIZrYGTDnj2E5r2njE2qO1+VknMQZ+JwujYf7xqN5yt85euuFXh09YHiN3D6NJTg6xDdwtlRy"
    }

    EFGMITEMS["arc9_eft_m45"] = {
        ["fullName"] = "Colt M45A1 .45 ACP pistol",
        ["displayName"] = "M45A1",
        ["displayType"] = "Pistol",
        ["weight"] = 1.1,
        ["value"] = 22000,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["equipSlot"] = WEAPONSLOTS.HOLSTER.ID,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/weapons/m45.png", "smooth"),

        ["sizeX"] = 2,
        ["sizeY"] = 1,

        ["defAtts"] = "XQAAAQAJAgAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8LmM+Vxqdiva/+T8TVGz12MZlTBvfFuwVHr2M0vIvxQabJdixi//02kBQvQE1BNSe+/x4UWJGqsdu0r0fjAJV8uPf4/9yf+Oa6i2nzhe+E/pAfpR4BznYJwkvGIHjKA6KtHKxQIslWZOjXQ7OqGi4qZT5NtitnZJtizjAPZf/nSJs9PdJfcS2+CyOZXDohKl62quGEQuCnXlubjg=="
    }

    EFGMITEMS["arc9_eft_deagle_l5"] = {
        ["fullName"] = "Magnum Research Desert Eagle L5 .357 pistol",
        ["displayName"] = "Desert Eagle L5",
        ["displayType"] = "Pistol",
        ["weight"] = 1.5,
        ["value"] = 32000,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["equipSlot"] = WEAPONSLOTS.HOLSTER.ID,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/weapons/deagle_l5.png", "smooth"),

        ["sizeX"] = 2,
        ["sizeY"] = 1,

        ["defAtts"] = "XQAAAQCOAQAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8LmM+Vxqdivswh+weqM2t5ghOvIx8KkqejxKzgldfViMxjx46Znco6smBqgrvGL0O8YJT4T7wgJccpjUYf5269cqJMCf+ilpumoHK8Ntg1+FepHm5oovFm5h8yqEygpQHVjnZ4Nrbct08Y75391QU/Vr6NU6avpWOzXnBRQcQDAA=="
    }

    EFGMITEMS["arc9_eft_deagle_l6"] = {
        ["fullName"] = "Magnum Research Desert Eagle L6 .50 AE pistol",
        ["displayName"] = "Desert Eagle L6",
        ["displayType"] = "Pistol",
        ["weight"] = 1.7,
        ["value"] = 38000,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["equipSlot"] = WEAPONSLOTS.HOLSTER.ID,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/weapons/deagle_l6.png", "smooth"),

        ["sizeX"] = 2,
        ["sizeY"] = 1,

        ["defAtts"] = "XQAAAQB1AQAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8LmM+Vxqdivswh+weqM2t5jQa6lgmam1bVV9wqHc/InvQl2sKu4I6dhqSCkrPRwoNttNR6fAeglycM1HiUxpoKzGlKvMjh+VEul0WOs3iIX3F3hb8XZ41U/VsWr8dMwwBnCgT27aU36knR7GmGNHv/+DtzE7QVQtyLiTVcbSs2OW3jLLzqAA=="
    }

    EFGMITEMS["arc9_eft_deagle_xix"] = {
        ["fullName"] = "Magnum Research Desert Eagle Mk XIX .50 AE pistol",
        ["displayName"] = "Desert Eagle Mk XIX",
        ["displayType"] = "Pistol",
        ["weight"] = 1.9,
        ["value"] = 43000,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["equipSlot"] = WEAPONSLOTS.HOLSTER.ID,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/weapons/deagle_xix.png", "smooth"),

        ["sizeX"] = 2,
        ["sizeY"] = 1,

        ["defAtts"] = "XQAAAQBxAQAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8LmM+Vxqdivswh+weqM2xeCHfXrhUWtKNsXbe+5XDYmGj0t/koPy+Xq92uCt+K1b4FZ8g/hvjMTFuFnPQCMzIfl7bnx9LzZYJwze3ZyIDflOo/FE/iHGwU1UnEQfokAnehpB6GaY7U+lNnUOmYxuPR8miv/wQgfxpcx+Y="
    }

    EFGMITEMS["arc9_eft_fn57"] = {
        ["fullName"] = "FN Five-seveN MK2 5.7x28 pistol",
        ["displayName"] = "FN 5-7",
        ["displayType"] = "Pistol",
        ["weight"] = 0.6,
        ["value"] = 44000,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["equipSlot"] = WEAPONSLOTS.HOLSTER.ID,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/weapons/fn57.png", "smooth"),

        ["sizeX"] = 2,
        ["sizeY"] = 1,

        ["defAtts"] = "XQAAAQAMAQAAAAAAAAA9iIIiM7hMNz0dhIkbkvLjTdSR5gRNNIHH3iLx7t5wr3FFXY/9RrihzPm/gZGThPmW/5f0k3e4vh0z8FkTFaDqOgHBWJGFX3r6Fdlg/2RrXUciz4JBF5REP4W2XIDOp389OhAQn3eo0puY/4A="
    }

    EFGMITEMS["arc9_eft_glock17"] = {
        ["fullName"] = "Glock 17 9x19 pistol",
        ["displayName"] = "Glock 17",
        ["displayType"] = "Pistol",
        ["weight"] = 0.8,
        ["value"] = 19000,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["equipSlot"] = WEAPONSLOTS.HOLSTER.ID,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/weapons/glock17.png", "smooth"),

        ["sizeX"] = 2,
        ["sizeY"] = 1,

        ["defAtts"] = "XQAAAQBCAQAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8LmM+Vxqdivt1xkDF9J/BRcigS9VhIYXZ5jzcY0QKC4UDg7zw2J4NcnLrn7qGmfbrcIn3ZOxTbRObyQ+TN50SFIJhk4W7/rr4DmKjva9hcJV4mRdtdDl5y7njjTqZ9/obcJWyBUMOHjtHNwFf6XAzu"
    }

    EFGMITEMS["arc9_eft_glock18c"] = {
        ["fullName"] = "Glock 18C 9x19 machine pistol",
        ["displayName"] = "Glock 18C",
        ["displayType"] = "Pistol",
        ["weight"] = 0.8,
        ["value"] = 37000,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["equipSlot"] = WEAPONSLOTS.HOLSTER.ID,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/weapons/glock18c.png", "smooth"),

        ["sizeX"] = 2,
        ["sizeY"] = 1,

        ["defAtts"] = "XQAAAQAuAQAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8LmM+Vxqdivt1xk4SiRjwdbJ+RltR5p3e6xTPK4jcJw9qY6Bkjo4aprpMte/wKgyPzNA+TIK46D/sfb/qyPHGYEpI7eWlZZskfihX3L1xEWEH0uQhZ1CnIYjmkotENPSDug5CKHs0Ulr3f4g3lcmT07gA="
    }

    EFGMITEMS["arc9_eft_glock19x"] = {
        ["fullName"] = "Glock 19X 9x19 pistol",
        ["displayName"] = "Glock 19X",
        ["displayType"] = "Pistol",
        ["weight"] = 0.6,
        ["value"] = 20000,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["equipSlot"] = WEAPONSLOTS.HOLSTER.ID,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/weapons/glock19x.png", "smooth"),

        ["sizeX"] = 2,
        ["sizeY"] = 1,

        ["defAtts"] = "XQAAAQAqAQAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8LmM+Vxqdivt1xlyTi2kEhSDJ0/hjFF+ZhmDnWCz/XusxgpHtc5BJM3wDICpGycXMrvH9E1L9NKRh70J5M7syVS/SO+SoYGiVU1WhrrhKYepHGjrFocqvFzPAhbv6IyvMcLkdzussozVm0VRU="
    }

    EFGMITEMS["arc9_eft_usp"] = {
        ["fullName"] = "HK USP .45 ACP pistol",
        ["displayName"] = "USP .45",
        ["displayType"] = "Pistol",
        ["weight"] = 0.8,
        ["value"] = 26000,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["equipSlot"] = WEAPONSLOTS.HOLSTER.ID,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/weapons/usp.png", "smooth"),

        ["sizeX"] = 2,
        ["sizeY"] = 1,

        ["defAtts"] = "XQAAAQCvAQAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8LmM+VxqdivzBHMTRxglFdvimLKcy1jyOrRsYPl3qRiyX4XvjyVJvyHklho+t8gVZExOXjbfMkt+e9MdetDvqhYhw4iEVFfHmEe4ABTlm9B4kQRHkUBMLkfXdinWNgD3hmkMtGlR4KynTRLT3yBnmgN2LpPMtWEaBY52V7UG6lgA=="
    }

    EFGMITEMS["arc9_eft_pl15"] = {
        ["fullName"] = "Lebedev PL-15 9x19 pistol",
        ["displayName"] = "PL-15",
        ["displayType"] = "Pistol",
        ["weight"] = 0.9,
        ["value"] = 24000,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["equipSlot"] = WEAPONSLOTS.HOLSTER.ID,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/weapons/pl15.png", "smooth"),

        ["sizeX"] = 2,
        ["sizeY"] = 1,

        ["defAtts"] = "XQAAAQAbAQAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8LmM+VxqdivxOSNEdVv0L37daJtxpkfSMuD7nd72zoac4KV1tNG0hnWlS9vugxfb2i5nikGPX/x7fgjwzzvtOLnl9U+WgreiAiqVOJ9kq/5obz9InMIAXOjbfPysfPs4rMWPK8DUOL"
    }

    EFGMITEMS["arc9_eft_pm"] = {
        ["fullName"] = "Makarov PM 9x18PM pistol",
        ["displayName"] = "PM",
        ["displayType"] = "Pistol",
        ["weight"] = 0.7,
        ["value"] = 15000,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["equipSlot"] = WEAPONSLOTS.HOLSTER.ID,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/weapons/pm.png", "smooth"),

        ["sizeX"] = 2,
        ["sizeY"] = 1,

        ["defAtts"] = "XQAAAQDfAAAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8N0MrcAX4ZC/nXwXwJMUX9VzIJ9eJoIzCxxdGJugl7TlFzel6UwwEdsDy/8G80rRx4/ISGjd3kGS6R64Nw6B+419FI8Iuegof64zUxQc/BQvc+KZA="
    }

    EFGMITEMS["arc9_eft_mp443"] = {
        ["fullName"] = "Yarygin MP-443 Grach 9x19 pistol",
        ["displayName"] = "MP-443 Grach",
        ["displayType"] = "Pistol",
        ["weight"] = 0.9,
        ["value"] = 18000,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["equipSlot"] = WEAPONSLOTS.HOLSTER.ID,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/weapons/mp443.png", "smooth"),

        ["sizeX"] = 2,
        ["sizeY"] = 1,

        ["defAtts"] = "XQAAAQCKAAAAAAAAAAA9iIIiM7hMNz0dhIkbkvLjTdSR5gRNNIHH3iMsviapv77xMa1x/jpy6bAjUW6sPbpwOYKac6uJtf5N1dKAFULp44UjPYFMBCK134yz1vswcmhn56o/AA=="
    }

    EFGMITEMS["arc9_eft_pb"] = {
        ["fullName"] = "PB 9x18PM silenced pistol",
        ["displayName"] = "PB",
        ["displayType"] = "Pistol",
        ["weight"] = 0.9,
        ["value"] = 17000,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["equipSlot"] = WEAPONSLOTS.HOLSTER.ID,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/weapons/pb.png", "smooth"),

        ["sizeX"] = 3,
        ["sizeY"] = 1,

        ["defAtts"] = "XQAAAQCwAAAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8Nz6D0gX5ySkZNvQ9kVxN2oB2e+x5mololx5+0qIIQff+f9wIHQK6as1lei0/0i8/97/7VIpwTc/v8m0jOypdFCAMSb8RdVo4qB+kRFA=="
    }

    EFGMITEMS["arc9_eft_rsh12"] = {
        ["fullName"] = "RSh-12 12.7x55 revolver",
        ["displayName"] = "RSh-12",
        ["displayType"] = "Pistol",
        ["weight"] = 2.2,
        ["value"] = 78000,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["equipSlot"] = WEAPONSLOTS.HOLSTER.ID,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/weapons/rsh12.png", "smooth"),

        ["sizeX"] = 2,
        ["sizeY"] = 1,

        ["defAtts"] = "XQAAAQCSAAAAAAAAAAA9iIIiM7hMNz0dhJSTKmZ7v+v6J9rfJDxrK5jGCg9Ongj2ouH9rTzyEctbtT8fV//t2AQ2AZxawi8qmKMSgUzbkr8ItspwpeCSHI3kSOweFs81HRO3DZClNaakAA=="
    }

    EFGMITEMS["arc9_eft_p226r"] = {
        ["fullName"] = "SIG P226R 9x19 pistol",
        ["displayName"] = "P226R",
        ["displayType"] = "Pistol",
        ["weight"] = 0.8,
        ["value"] = 41000,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["equipSlot"] = WEAPONSLOTS.HOLSTER.ID,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/weapons/p226r.png", "smooth"),

        ["sizeX"] = 2,
        ["sizeY"] = 1,

        ["defAtts"] = "XQAAAQBMAQAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8LmM+VxqdivxKVF5T+C7zd3vec1rvrAoEdFGwNxOIARyiqMLUYwCcRpAng5F3a8P++FMOSod0D0BXl1e77r2cWTrbxmXSuPJVJXprMK9aBhNpA5UGQXVURYk9qsVNl6LiGhdn8PS8HDLdoOpE1cAfNLxO8yZs="
    }

    EFGMITEMS["arc9_eft_sr1mp"] = {
        ["fullName"] = "Serdyukov SR-1MP Gyurza 9x21 pistol",
        ["displayName"] = "SR-1MP",
        ["displayType"] = "Pistol",
        ["weight"] = 0.8,
        ["value"] = 32000,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["equipSlot"] = WEAPONSLOTS.HOLSTER.ID,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/weapons/sr1mp.png", "smooth"),

        ["sizeX"] = 2,
        ["sizeY"] = 1,

        ["defAtts"] = "XQAAAQBXAAAAAAAAAAA9iIIiM7hMNz0dhIkbkvLjTdSR5gRNNIHH3iMsviZ+8MTSN7UCyyRm0aGA+jNdSGXjQWiRJbBIjQEMikyPT7J/h14DxwI6DqLvMGhtAA=="
    }

    EFGMITEMS["arc9_eft_apb"] = {
        ["fullName"] = "Stechkin APB 9x18PM silenced machine pistol",
        ["displayName"] = "APB",
        ["displayType"] = "Pistol",
        ["weight"] = 1.6,
        ["value"] = 34000,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["equipSlot"] = WEAPONSLOTS.HOLSTER.ID,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/weapons/apb.png", "smooth"),

        ["sizeX"] = 4,
        ["sizeY"] = 1,

        ["defAtts"] = "XQAAAQBBAQAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8LceiiH+OYU8CKsAUrAdr/tENAyThefN6cDVAvNEE2F5mDkS3Rk1uREfnqeAx7q76URnhkxW9ezdHaZGJlkZD9FmCgkjjCQDJ1B0mOn3eT4vC72j3iq1TLR4PqnlLWvjo9JegVAA=="
    }

    EFGMITEMS["arc9_eft_aps"] = {
        ["fullName"] = "Stechkin APS 9x18PM machine pistol",
        ["displayName"] = "APS",
        ["displayType"] = "Pistol",
        ["weight"] = 1.0,
        ["value"] = 28000,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["equipSlot"] = WEAPONSLOTS.HOLSTER.ID,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/weapons/aps.png", "smooth"),

        ["sizeX"] = 2,
        ["sizeY"] = 1,

        ["defAtts"] = "XQAAAQDoAAAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8LceiiH+X7VuJllh2JgrygyhJzeJeRAUMgmKPwWdZCzRqYZexKUns3rzBSsK2Hj+avMZYkJ4b9wJXw3J+GnkWctfYm9Dgy6D19uNPzAA=="
    }

    EFGMITEMS["arc9_eft_tt33"] = {
        ["fullName"] = "TT-33 7.62x25 TT pistol",
        ["displayName"] = "TT",
        ["displayType"] = "Pistol",
        ["weight"] = 0.8,
        ["value"] = 9000,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["equipSlot"] = WEAPONSLOTS.HOLSTER.ID,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/weapons/tt33.png", "smooth"),

        ["sizeX"] = 2,
        ["sizeY"] = 1,

        ["defAtts"] = "XQAAAQC/AAAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8Oc2p/mgB/xAKAv4zbPEDsMJKGrN0dVZcBOr2DjQYRbMT4MiiumWQx+UK95/Nvc39bwvVU1RkDteZAwlo0mn6ASN/g31UowrgJXSPvZCEto68A"
    }

    EFGMITEMS["arc9_eft_cr200ds"] = {
        ["fullName"] = "Chiappa Rhino 200DS 9x19 revolver",
        ["displayName"] = "CR 200DS",
        ["displayType"] = "Pistol",
        ["weight"] = 0.7,
        ["value"] = 21000,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["equipSlot"] = WEAPONSLOTS.HOLSTER.ID,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/weapons/cr200ds.png", "smooth"),

        ["sizeX"] = 1,
        ["sizeY"] = 1,

        ["defAtts"] = "XQAAAQC1AAAAAAAAAAA9iIIiM7hMNz0dhIkbkvLjTdSR5gRNNIHH3iMxyb1USyArYDmk731f5dmwXd1V2F4KB2PoMgWnJCTwClBVT2CAhNumNQnOhBgvFvtbRGRj8/vmD9myG6J5DmZhnZIA"
    }

    EFGMITEMS["arc9_eft_cr50ds"] = {
        ["fullName"] = "Chiappa Rhino 50DS .357 revolver",
        ["displayName"] = "CR 50DS",
        ["displayType"] = "Pistol",
        ["weight"] = 0.9,
        ["value"] = 27000,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["equipSlot"] = WEAPONSLOTS.HOLSTER.ID,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/weapons/cr50ds.png", "smooth"),

        ["sizeX"] = 2,
        ["sizeY"] = 1,

        ["defAtts"] = "XQAAAQD0AAAAAAAAAAA9iIIiM7hMNz0dhIkbkvLjTdSR5gRNNIHH3iMxyb1USyArYDmk731f5dmwXd1V2F4KB2PoMgWnJCTwClBVT2CAhNumNQnOhBgvFvtbRSBdDSX/JEhDflFLZp4RsgU48ZBAfbFtCxzD2A=="
    }

    -- shotguns
    EFGMITEMS["arc9_eft_m3super90"] = {
        ["fullName"] = "Benelli M3 Super 90 12ga dual-mode shotgun",
        ["displayName"] = "M3 Super 90",
        ["displayType"] = "Shotgun",
        ["weight"] = 3.3,
        ["value"] = 39000,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["equipSlot"] = WEAPONSLOTS.PRIMARY.ID,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/weapons/m3super90.png", "smooth"),

        ["sizeX"] = 5,
        ["sizeY"] = 2,

        ["defAtts"] = "XQAAAQAZAgAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8NUZMP40QWndnxL8Md9bjhwTqWECpCpnCIWQQlz5538GEncsfHe2QOxB/tCr1SkG+XMF4y+5EAaoyzoUra4P37r8hyWHh6bC7xUkNi72e+GWwopRDL0QZ42TJtYRBkpsBU4yOy8RxOlDlywYEDFP6hJGYa2VLwydXNBZVA4jAvAZLlYZmzj8eW8lyPx1b0JJ2Bo5ng"
    }

    EFGMITEMS["arc9_eft_m590"] = {
        ["fullName"] = "Mossberg 590A1 12ga pump-action shotgun",
        ["displayName"] = "590A1",
        ["displayType"] = "Shotgun",
        ["weight"] = 3.4,
        ["value"] = 30000,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["equipSlot"] = WEAPONSLOTS.PRIMARY.ID,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/weapons/m590.png", "smooth"),

        ["sizeX"] = 5,
        ["sizeY"] = 1,

        ["defAtts"] = "XQAAAQB4AQAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8NUcBpvXLm8lkMPKMXHqRiLKF55cbAc904tXTkm4W3W0yA1OsnrOfILaJM92KjwQxOWOEiHWrxIttmXwMpPhLwJGHdLcEZKnM+sQhY0Mxo+PT7UJUE9juj8OJF2CtNTm65I3LJwsJBQF1xBJE5AzpLmZ4iFuIWF0O3IHceGU631S47JYA="
    }

    EFGMITEMS["arc9_eft_mr133"] = {
        ["fullName"] = "MP-133 12ga pump-action shotgun",
        ["displayName"] = "MP-133",
        ["displayType"] = "Shotgun",
        ["weight"] = 3.5,
        ["value"] = 25000,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["equipSlot"] = WEAPONSLOTS.PRIMARY.ID,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/weapons/mr133.png", "smooth"),

        ["sizeX"] = 5,
        ["sizeY"] = 1,

        ["defAtts"] = "XQAAAQBAAQAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8NV9soqBkgp9xKO7Kzg2dCl/HKiW+fRuX8JPD3U0v7srDXOXCUG85bOAsJeBrjxnVOSUD/930s/nAksh6vnoQpbsS0eP+sfldKbHkVMdUcGb6Nfj7B0HxCOF5gUFyhFKPHIfPbFq5vPHcilqPQc7XZZFGVyzeCGxLw0qn8gA=="
    }

    EFGMITEMS["arc9_eft_mr153"] = {
        ["fullName"] = "MP-153 12ga semi-automatic shotgun",
        ["displayName"] = "MP-153",
        ["displayType"] = "Shotgun",
        ["weight"] = 3.6,
        ["value"] = 40000,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["equipSlot"] = WEAPONSLOTS.PRIMARY.ID,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/weapons/mr153.png", "smooth"),

        ["sizeX"] = 7,
        ["sizeY"] = 1,

        ["defAtts"] = "XQAAAQBYAQAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8NV9soxclwG/vLo5K6RnuIXLbaswlwWOWqkxbEnzZoRppkn//6LvHIYf42vOIuzYGB92XfwC1K+Hvk9FW8Y5JGcvka/pJrFbQms3J70HDEavIcmrYNDwhwLsp2NTO2jx+D03bcbwKpjNWdfaiVxe+cls+Arwjr4KBGTSZU/bs05Hzt8Aql6ec="
    }

    EFGMITEMS["arc9_eft_mr155"] = {
        ["fullName"] = "MP-155 12ga semi-automatic shotgun",
        ["displayName"] = "MP-155",
        ["displayType"] = "Shotgun",
        ["weight"] = 3.4,
        ["value"] = 45000,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["equipSlot"] = WEAPONSLOTS.PRIMARY.ID,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/weapons/mr155.png", "smooth"),

        ["sizeX"] = 5,
        ["sizeY"] = 1,

        ["defAtts"] = "XQAAAQA+AQAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8NV9soxedGhWiR+Gfozfg60lFT777G0lvDHIXNd3q17CVbvQWfGkpYPyx7Q/ct964SG8bX1rGdig/ZJ/qAPGOBdvRCTIiOqlvQYFfoo555XMkHwZl1LjDxvh2iPxa38AAH41J0vXZifhs5l4Vdbnnc+E79nnVfQC+/Tca2"
    }

    EFGMITEMS["arc9_eft_mr43_sawedoff"] = {
        ["fullName"] = "MP-43 12ga sawed-off double-barrel shotgun",
        ["displayName"] = "MP-43 Sawed-off",
        ["displayType"] = "Shotgun",
        ["weight"] = 2.1,
        ["value"] = 19000,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["equipSlot"] = WEAPONSLOTS.HOLSTER.ID,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/weapons/mr43_sawedoff.png", "smooth"),

        ["sizeX"] = 3,
        ["sizeY"] = 1,

        ["defAtts"] = "XQAAAQCiAAAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8NV9tY8mxdjo2DonfYbDKLCbCIbLM3cKUS2n/zqm05+D37Ngjxrrie0dZPauCRtFna98ClssC3lfqP05ddYiEK1HzEQOs1ep5BPFYtNON8YV4="
    }

    EFGMITEMS["arc9_eft_mr43"] = {
        ["fullName"] = "MP-43-1C 12ga double-barrel shotgun",
        ["displayName"] = "MP-43-1C",
        ["displayType"] = "Shotgun",
        ["weight"] = 3.6,
        ["value"] = 20000,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["equipSlot"] = WEAPONSLOTS.PRIMARY.ID,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/weapons/mr43.png", "smooth"),

        ["sizeX"] = 6,
        ["sizeY"] = 1,

        ["defAtts"] = "XQAAAQCsAAAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8NV9tY8mxdjo2DonfYuRH8meGEWV+yPXPsnXJtugMF/FY1SGQeBs3hw/sKrnsf0G5RjtwcTZ3klbiZR7YMsrSArUhco3zw5apV7ppTVolQCAA="
    }

    EFGMITEMS["arc9_eft_aa12"] = {
        ["fullName"] = "MPS Auto Assault-12 Gen 1 12ga automatic shotgun",
        ["displayName"] = "AA-12",
        ["displayType"] = "Shotgun",
        ["weight"] = 5.0,
        ["value"] = 120000,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["equipSlot"] = WEAPONSLOTS.PRIMARY.ID,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/weapons/aa12.png", "smooth"),

        ["sizeX"] = 5,
        ["sizeY"] = 2,

        ["defAtts"] = "XQAAAQDuAAAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8LcFEZt27uts1h9rv7GPLtHmlYv2Jo2nuh7ASujjecKKRJrBb423B5Rb+LCwMHmYzVDazfSYQvIVkx69fGD/hkToa/2CzZ878TuqbaYhkFofeMRzEdbKzxIHhUKn0rrlE3QNfG/wA="
    }

    EFGMITEMS["arc9_eft_mts255"] = {
        ["fullName"] = "MTs-255-12 12ga shotgun",
        ["displayName"] = "MTs-255-12",
        ["displayType"] = "Shotgun",
        ["weight"] = 4.2,
        ["value"] = 24000,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["equipSlot"] = WEAPONSLOTS.PRIMARY.ID,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/weapons/mts255.png", "smooth"),

        ["sizeX"] = 6,
        ["sizeY"] = 1,

        ["defAtts"] = "XQAAAQBoAQAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8NWBZxcXd4lgpEYOABEMGVgtCK/aSLEaxnwae0hch5Ptd1XInQcH+dbu9HJcNSDVgmdJVbNux7pih1EapIy244Q6vvsSvlwxOScXyS4yBYAD8Dee7noa5Q817A6O0TvIJgIUDC6yM2EQceVON8lWXSCFefVJB/ktJsloM="
    }

    EFGMITEMS["arc9_eft_m870"] = {
        ["fullName"] = "Remington Model 870 12ga pump-action shotgun",
        ["displayName"] = "M870",
        ["displayType"] = "Shotgun",
        ["weight"] = 3.1,
        ["value"] = 35000,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["equipSlot"] = WEAPONSLOTS.PRIMARY.ID,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/weapons/m870.png", "smooth"),

        ["sizeX"] = 5,
        ["sizeY"] = 1,

        ["defAtts"] = "XQAAAQBLAQAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8NUglz4qzXk+esKjOEbvYtjoW6dJrfCWOEsB7khQXO/X8w2x8X/CWqjxaOmmEQ56IXjItMHtn3T1YVFg4KDwe51dsSHW0bru0MlZLg/GlxF/Zvj07/T5iWe8gnctmBB24xvg4QQHazoufFdYXFyHnwx9QiFww3G+znn5a9N44="
    }

    EFGMITEMS["arc9_eft_saiga12fa"] = {
        ["fullName"] = "Saiga-12K 12ga automatic shotgun",
        ["displayName"] = "Saiga-12K FA",
        ["displayType"] = "Shotgun",
        ["weight"] = 5.6,
        ["value"] = 140000,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["equipSlot"] = WEAPONSLOTS.PRIMARY.ID,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/weapons/saiga12fa.png", "smooth"),

        ["sizeX"] = 6,
        ["sizeY"] = 2,

        ["defAtts"] = "XQAAAQB4AwAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8NWDT+kEGPPXAnnu00OGUPFCojWFr8rsYIfBsTYl9178LFdS6tG1B2ZxwsgSbecQ/C3Meb3KSmwYqU2FIwUpWXOQ6H1K9jhG5VvQICUy6gbyLNJmr/IFwdX4ih0KRHToRvciL8+cMf+QnkIRcL7vxWrn7v7J9J2trJsMMUaUVqK1FxLSPMIoUKXdM1C6XlAM5BcgTs+8lOEc1SKDfArWDoNdia/mMoBNcruWFT1M13A87NU+/i1ihxE6rYH8qHJdWjvI5c0oWXqt9ncbNG+Au3mZCwxjDHdwbowTJPajaQS5rfgm5pQv4yE1VGUhiX8h05NWQJTFwlOxGHyc6OPxss+ipQzJMKOrpKt9bylJcCw27lvTslJxs56eYovlCXmJlhMzDnPaSArmoA"
    }

    EFGMITEMS["arc9_eft_saiga12k"] = {
        ["fullName"] = "Saiga-12K ver.10 12ga semi-automatic shotgun",
        ["displayName"] = "Saiga-12K",
        ["displayType"] = "Shotgun",
        ["weight"] = 3.6,
        ["value"] = 40000,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["equipSlot"] = WEAPONSLOTS.PRIMARY.ID,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/weapons/saiga12k.png", "smooth"),

        ["sizeX"] = 5,
        ["sizeY"] = 2,

        ["defAtts"] = "XQAAAQD2AQAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8OSPTtC5Psez9ZTnS8YLQTM2ltmsJ2NHtb8I4jTTgElGJX1jRCeY3UByXmTpt6X9CGQvKIFNVGbhmZnMvU5UDKxjByS8kDpBAffIAeSK8fVDHWQSh9hChsuIyWKHpPytQJmI84QcinH/JolfNyzbUk19Xe1t6KYvWVoGRbyhy1tGTFGz/1BH8vIIhUosjdyhQiuNyKXiR7/xTwaS3PTkg6ogeUry0oTpcA"
    }

    EFGMITEMS["arc9_eft_ks23"] = {
        ["fullName"] = "TOZ KS-23M 23x75mm pump-action shotgun",
        ["displayName"] = "KS-23M",
        ["displayType"] = "Shotgun",
        ["weight"] = 3.8,
        ["value"] = 75000,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["equipSlot"] = WEAPONSLOTS.PRIMARY.ID,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/weapons/ks23.png", "smooth"),

        ["sizeX"] = 6,
        ["sizeY"] = 1,

        ["defAtts"] = "XQAAAQAYAQAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8NBwAdi2xdjoyRPEwHyL9ndUw3Qf4JJVzUDILPXYi0ZSvk6zeiSBatUDV6mIl5YsUsk5YzqiQoidcyuB0VRdj0VBjkk9xiNowuHAQHOew9TZrAo77PynKhjolR0ippc3hLpRsDgfcJ0YoHXNA="
    }

    EFGMITEMS["arc9_eft_toz106"] = {
        ["fullName"] = "TOZ-106 20ga bolt-action shotgun",
        ["displayName"] = "TOZ-106",
        ["displayType"] = "Shotgun",
        ["weight"] = 2.7,
        ["value"] = 17000,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["equipSlot"] = WEAPONSLOTS.PRIMARY.ID,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/weapons/toz106.png", "smooth"),

        ["sizeX"] = 4,
        ["sizeY"] = 1,

        ["defAtts"] = "XQAAAQD+AAAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8NVhYAGVeSOkq5ioj8jMxwGGwTsYJMDWKx/nbgAnY9n5tQLn+yaXuDFCl3lEI+VyTEauuBOLYO4n+5q0sQC4B4Sjo09VUcbtNDl5o5r11sKBBTpJ3ITsV0vDiebHG+CokOLec/1PxJDlymrw=="
    }

    -- sniper rifles/marksman rifles
    EFGMITEMS["arc9_eft_ai_axmc"] = {
        ["fullName"] = "Accuracy International AXMC .338 LM bolt-action sniper rifle",
        ["displayName"] = "AI AXMC",
        ["displayType"] = "Sniper Rifle",
        ["weight"] = 5.7,
        ["value"] = 270000,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["equipSlot"] = WEAPONSLOTS.PRIMARY.ID,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/weapons/axmc.png", "smooth"),

        ["sizeX"] = 5,
        ["sizeY"] = 2,

        ["defAtts"] = "XQAAAQDhAwAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8LcsYCbthEf9oFSoSxAkrJ5MHEtbkpwPQvQB1xFtCyk1QLE+imKyPumFPHpcXKuIe+j4b3sDvYqfe7IxMhskP2yHt/GS6VwCdLv1JnbWDvOkzqVT0vfDRHIIBDfbBCeWE8UAItC5RpezcbUMzJe3DEJiZN6RO2H0yuwdj5fc6uqC17vEP2AFNDhK/TKz9ahfIuuo8wZ77EN1GK2LnmvIDyXyP4GEUWCnMW227BnoYs50TuigRg/r1bitCvXeRVhepEt2M/Wg=="
    }

        EFGMITEMS["arc9_eft_ak50"] = {
        ["fullName"] = "AK-50 .50 BMG sniper rifle",
        ["displayName"] = "AK-50",
        ["displayType"] = "Sniper Rifle",
        ["weight"] = 12.8,
        ["value"] = 400000,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["equipSlot"] = WEAPONSLOTS.PRIMARY.ID,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/weapons/ak50.png", "smooth"),

        ["sizeX"] = 7,
        ["sizeY"] = 2,

        ["defAtts"] = "XQAAAQAJAgAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8MZPzvHDqVW9Zr+l1XqbTku0XrI40dVyapGHi+sNSHLbu8NvEE+5m/7y1Uc3pCqoaAsC9b1LCp3S5vzlKWdbSHnSMBTjM4TqruOeDpGWYwCaEEuqRZtK1OS0OmXLEYJEDTDufsiz9zMrLV4gApem0FhjHku3hIRvpAKQj03bppFtFbgk+LHUc9gyCB"
    }

    EFGMITEMS["arc9_eft_g28"] = {
        ["fullName"] = "HK G28 7.62x51 marksman rifle",
        ["displayName"] = "G28",
        ["displayType"] = "Marksman Rifle",
        ["weight"] = 5.4,
        ["value"] = 210000,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["equipSlot"] = WEAPONSLOTS.PRIMARY.ID,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/weapons/g28.png", "smooth"),

        ["sizeX"] = 6,
        ["sizeY"] = 3,

        ["defAtts"] = "XQAAAQAsBAAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8Lchzpvw0LefC8hu4+7dXYbNKzz014YolWmVqMYRuK5YCam2fgKlEcPvm+rzjsun8OdBpgt/uNSe/ayL7WJrLzw6FF1DHgRU/lqG3hEf61nWTu+CPJYddv3r4ez8tOMz+eOV8+mkLKbetrK2wKBNbLmPmSyVdJEyIH9VwuPJNniIkCb8dFC43uVgLlR6InZkEkfTCj1y2lg2ed0HeuCRQGVwiDp8GKbjgBp0Xd7vFbiW1eSlLF9oUcCdJWeDBTZ51Iiwu/AT9Bm2VOLM89IekkmaqlaLsx6VnaSyM1tAXeP+1R4HH1VlZu7N1MvD8m7XcnMuR4kyRw7CouhSNNSjZMvLWI1QP2JMaWgziL8H1MxqJv"
    }

    EFGMITEMS["arc9_eft_sr25"] = {
        ["fullName"] = "Knight's Armament Company SR-25 7.62x51 marksman rifle",
        ["displayName"] = "SR-25",
        ["displayType"] = "Marksman Rifle",
        ["weight"] = 3.8,
        ["value"] = 120000,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["equipSlot"] = WEAPONSLOTS.PRIMARY.ID,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/weapons/sr25.png", "smooth"),

        ["sizeX"] = 5,
        ["sizeY"] = 2,

        ["defAtts"] = "XQAAAQBaAwAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8Lchzpvw0LefC8cKmSsx2FONi6w2fdtBqbRE9Vb00gVDviwUYh2V4s4R3AT9EDGmFdHaCJ9XkU0X5rNKcaJfu+dFjahOnSsKR+r1GtBTDV9nhVaB6IZCnaPlFxePEyr7gw2YsmwtbO1jtTOy3Izs1eW6OnFHWEi1Gx4NL0RV/JYLC6/12Om2Pxsy2sEcHlJeHOH6SIu7l82AwRplvdv5FHtu5OTZec8R/DU65bOZk+53V2JpJF1VYxq8NwaI5LOx70PMrXS5yu8JgKsBwt63I6Vx4fMb30obWeBJzYHXtmXRMuiU/10IpWY+vnH1xIpAVOb5TA"
    }

    EFGMITEMS["arc9_eft_dvl10"] = {
        ["fullName"] = "Lobaev Arms DVL-10 7.62x51 bolt-action sniper rifle",
        ["displayName"] = "DVL-10",
        ["displayType"] = "Sniper Rifle",
        ["weight"] = 5.0,
        ["value"] = 150000,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["equipSlot"] = WEAPONSLOTS.PRIMARY.ID,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/weapons/dvl.png", "smooth"),

        ["sizeX"] = 5,
        ["sizeY"] = 2,

        ["defAtts"] = "XQAAAQCKAQAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8L6/0wnr/Jsa1p1kHyfvXikOJS7PNC7qaXt4+w3qSztc3+cFQrBWa+C57ISiJHQGQP8/jtqaT4Ps7YabTcGDFQZbKeE7+q+jP4p/y+1HWCJQ1+yUopZIsi7MgifhFwXRiugBfSx/+G1bRwBjHcYWTFVatptm2ErIrcX1G4pKoVaJpkjG4B///SSYIsBbVA"
    }

    EFGMITEMS["arc9_eft_mk18_mjolnir"] = {
        ["fullName"] = "SWORD International Mk-18 .338 LM marksman rifle",
        ["displayName"] = "Mk-18 Mjölnir",
        ["displayType"] = "Marksman Rifle",
        ["weight"] = 6.5,
        ["value"] = 330000,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["equipSlot"] = WEAPONSLOTS.PRIMARY.ID,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/weapons/mk18_mjolnir.png", "smooth"),

        ["sizeX"] = 6,
        ["sizeY"] = 2,

        ["defAtts"] = "XQAAAQCsAgAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8Lchzpvw0LefC8hv59A4CQeaGlaPJjqs5VnIN0AFBsBso51IxEtxO+V9oImpdKBMLjMp8B1B8RQhyHZ0PAZ8l5m1PkQ4B4+g8NbgGo+77Q7nIEw5n8PxyZk2bq8VQZFHgqL83a3jATxjootibVO+Co4a5GqaCilhv8mnFlKlMU+FCT/yClCvHu+/ewsG0r7FcNExntkZXr6hfanCTwIRjD+EFEwMh0XXdqLeea0UY1l7wwrTswFUz+"
    }

    EFGMITEMS["arc9_eft_mosin_infantry"] = {
        ["fullName"] = "Mosin 7.62x54R bolt-action rifle (Infantry)",
        ["displayName"] = "Mosin Infantry",
        ["displayType"] = "Sniper Rifle",
        ["weight"] = 4.8,
        ["value"] = 38000,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["equipSlot"] = WEAPONSLOTS.PRIMARY.ID,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/weapons/mosin_infantry.png", "smooth"),

        ["sizeX"] = 6,
        ["sizeY"] = 1,

        ["defAtts"] = "XQAAAQBmAQAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8NV4+pY+0XkZKHWxkZKCKF0+Ob5fNs3s5OFKWT+HASlx6CN4+PJGFPkL3i5sLLz+TOvImFE2UK7JKi1QOyK1JJP3tN/dQxofSuCMLUjYAvvlOko63tO1HwDkD4IoUYtSvcGXUy5gvrkEDaCMnpVA=="
    }

    EFGMITEMS["arc9_eft_mosin_sniper"] = {
        ["fullName"] = "Mosin 7.62x54R bolt-action rifle (Sniper)",
        ["displayName"] = "Mosin Sniper",
        ["displayType"] = "Sniper Rifle",
        ["weight"] = 4.8,
        ["value"] = 44000,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["equipSlot"] = WEAPONSLOTS.PRIMARY.ID,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/weapons/mosin_sniper.png", "smooth"),

        ["sizeX"] = 6,
        ["sizeY"] = 1,

        ["defAtts"] = "XQAAAQBmAQAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8NV4+pY+0XkZKHWxkZKCKF0+Ob5fNs3s5OFKWT+HASlx6CN4+PJGFPkL3i5sLLz+TOvImFE2UK7JKi1QOyK1JJP3vegGGaON+2VPul/8++WqyUZNeaa6DChd06BdK8dCBUUYi/z5yiDWpIYeeA"
    }

    EFGMITEMS["arc9_eft_mp18"] = {
        ["fullName"] = "MP-18 7.62x54R single-shot rifle",
        ["displayName"] = "MP-18",
        ["displayType"] = "Sniper Rifle",
        ["weight"] = 2.8,
        ["value"] = 17000,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["equipSlot"] = WEAPONSLOTS.PRIMARY.ID,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/weapons/mp18.png", "smooth"),

        ["sizeX"] = 5,
        ["sizeY"] = 1,

        ["defAtts"] = "XQAAAQDiAAAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8NV6VfczERS4GZYjxV/r216Up0BZRyLU8Dd5/9fAAPNftYJczs1AaTA/zqPr5a6PhnJBEbni2Tbknz12sfUGtXzyYmLojKU77pXszKSY9zLBhn2yCAJujtDC+tQwW5S24WoA=="
    }

    EFGMITEMS["arc9_eft_t5000"] = {
        ["fullName"] = "ORSIS T-5000M 7.62x51 bolt-action sniper rifle",
        ["displayName"] = "T-5000M",
        ["displayType"] = "Sniper Rifle",
        ["weight"] = 5.9,
        ["value"] = 88000,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["equipSlot"] = WEAPONSLOTS.PRIMARY.ID,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/weapons/t5000.png", "smooth"),

        ["sizeX"] = 5,
        ["sizeY"] = 2,

        ["defAtts"] = "XQAAAQBTAwAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8ObRiu3tibt3IP5oBbAn23oHzYA8d1/1rQ/6F6KFMvcaM/pLh9ayXkhgZ14kGEirPqWpP/6dxSMYHyxausiP7ggK1p8DCF9BmSb4P3uaSQI9UKX1Tr7qt2eR2Yx9fs4nwR58vTFh2I8lu11HcNFQaAswMKFbD2SaXMhqfJwu83TYJB1+grgXPZyR68JdCcWX6U5YtKl8drOluEj1jijLNSQfwc9v06T2Nqcukz6M37sCCB3fHwFA=="
    }

    EFGMITEMS["arc9_eft_m700"] = {
        ["fullName"] = "Remington Model 700 7.62x51 bolt-action sniper rifle",
        ["displayName"] = "M700",
        ["displayType"] = "Sniper Rifle",
        ["weight"] = 4.0,
        ["value"] = 63000,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["equipSlot"] = WEAPONSLOTS.PRIMARY.ID,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/weapons/m700.png", "smooth"),

        ["sizeX"] = 5,
        ["sizeY"] = 1,

        ["defAtts"] = "XQAAAQAPAQAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8NUfBrxG5/o6wCZICOBvnuThI2G4SXoY5YVE6djRZzT+hLefB8oK6y+WP73ZLPfot111L1Z8yv/Klzy9wOI8rA2th1khRAIQn3Zxm2dJNQkqO2nZexAlJLFGg30dKLB+fUGNNJBuFy1WcFa6ehPHnKQA=="
    }

    EFGMITEMS["arc9_eft_rsass"] = {
        ["fullName"] = "Remington R11 RSASS 7.62x51 marksman rifle",
        ["displayName"] = "RSASS",
        ["displayType"] = "Marksman Rifle",
        ["weight"] = 4.9,
        ["value"] = 130000,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["equipSlot"] = WEAPONSLOTS.PRIMARY.ID,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/weapons/rsass.png", "smooth"),

        ["sizeX"] = 5,
        ["sizeY"] = 2,

        ["defAtts"] = "XQAAAQC5AgAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8Lchzpvw0LefC8nH/Q5D/5WQm8ZkY/7e2UXLJ+U/sr/LGlYPiAkUENKsUNQ0OZJKV4xujGrotTXTK8lWcV3TAANhKb/Y1Xlt99olDTPMak9UrUGXYynFY3+5gltTTTt/P/SxEFydUMCy2KHtPyB8Ob/wjkKc34cULXS3sZffRqyqs+BoiZk95dUmpFTX4ngnqMF4+KpxEyzSjMxMIUumYijLMTfQNL60+WWkBdmCA8JlHVj/2AgnNI42dWJ+MGwrAtAA=="
    }

    EFGMITEMS["arc9_eft_m1a"] = {
        ["fullName"] = "Springfield Armory M1A 7.62x51 rifle",
        ["displayName"] = "M1A",
        ["displayType"] = "Marksman Rifle",
        ["weight"] = 3.9,
        ["value"] = 105000,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["equipSlot"] = WEAPONSLOTS.PRIMARY.ID,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/weapons/m1a.png", "smooth"),

        ["sizeX"] = 5,
        ["sizeY"] = 2,

        ["defAtts"] = "XQAAAQClAQAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8NUWEgbTj3U/7wMBbhp+3V3U++qZq9cNzZu4MkjHnVzmx7ZyhChGagN5roUUg3zO9DT+aeuSPLUn12Kh/p8oGsNBFu58FtMzE1JVRLfl5pJm0u8S5o6rcHPrHykKvygcv6uhT74SK9HVjdHSbSHdbiNAx5VlMQYjxfmlYPLrcVZEWydTtL8z4Pqjx8zG4ViA=="
    }

    EFGMITEMS["arc9_eft_sv98"] = {
        ["fullName"] = "SV-98 7.62x54R bolt-action sniper rifle",
        ["displayName"] = "SV-98",
        ["displayType"] = "Sniper Rifle",
        ["weight"] = 5.1,
        ["value"] = 74000,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["equipSlot"] = WEAPONSLOTS.PRIMARY.ID,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/weapons/sv98.png", "smooth"),

        ["sizeX"] = 6,
        ["sizeY"] = 2,

        ["defAtts"] = "XQAAAQBLAQAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8OSytTkJgaUnpNNGc+Gl6jVHV/uSNDf/kO4OHmIYepg0elfMCMxvyZU1WTuQFb/dnwV8M4PC6lSZdZMuezE7eF3HWlgqW7PFipSfyrVe9jbv03iHjENH3dhywatmAwUqycXPSurpMpqxJ3HYd+hhPLgZfgpR0jPJd5szGtky82jQ=="
    }

    EFGMITEMS["arc9_eft_svds"] = {
        ["fullName"] = "SVDS 7.62x54R sniper rifle",
        ["displayName"] = "SVDS",
        ["displayType"] = "Marksman Rifle",
        ["weight"] = 4.3,
        ["value"] = 85000,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["equipSlot"] = WEAPONSLOTS.PRIMARY.ID,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/weapons/svds.png", "smooth"),

        ["sizeX"] = 6,
        ["sizeY"] = 2,

        ["defAtts"] = "XQAAAQBvAgAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8OSy5Op2fcAEZMuyaASWAz0/M7SqAjtmacTwu80ueelzptgu4g0+pF5hx9p4QDd/RDvkDYZMtgN7RlbE+FpjS0JnhcRJMOxD3V35XFgdgYu+X2w5Hln8J+LmSldVJMIdldC3dAacAYun6GPlg2I8iu4Lq+Hc0FUBQPTcLfF22MgWS/8nNfFHQBZ/5v83vKP+3/LRV/0wYSyc8fCy+Jk2NStIYUKrI="
    }

    EFGMITEMS["arc9_eft_vpo215"] = {
        ["fullName"] = "Molot Arms VPO-215 Gornostay .366 TKM bolt-action rifle",
        ["displayName"] = "VPO-215 Gornostay",
        ["displayType"] = "Sniper Rifle",
        ["weight"] = 3.3,
        ["value"] = 27000,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["equipSlot"] = WEAPONSLOTS.PRIMARY.ID,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/weapons/vpo215.png", "smooth"),

        ["sizeX"] = 5,
        ["sizeY"] = 1,

        ["defAtts"] = "XQAAAQBiAQAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8Ow/iPem4evSEh1ZVBQmKe6TaWo6POdajS5pypMmDY20hbHcZSWr7CxGfmXs85U87DKMtHcVIC0q5r3emPMZeQY6fJyMV2DpZXb0TEMuHcUwO1tU5prVUPsBo7HimY3Il6WrUtItPKOdFNc21rxdVWIB54CVOib0iEWQ=="
    }

    EFGMITEMS["arc9_eft_vss"] = {
        ["fullName"] = "VSS Vintorez 9x39 special sniper rifle",
        ["displayName"] = "VSS Vintorez",
        ["displayType"] = "Marksman Rifle",
        ["weight"] = 2.6,
        ["value"] = 143000,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["equipSlot"] = WEAPONSLOTS.PRIMARY.ID,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/weapons/vss.png", "smooth"),

        ["sizeX"] = 5,
        ["sizeY"] = 2,

        ["defAtts"] = "XQAAAQBtAQAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8OwmVfT2hq/H64qBlSsLc/OGn6XwHM3Rbx0N1ed9Tqdupk/nUylj0UY2YpYpkPX3jeqgqAnCrVaNv1fySJhu99NEpabNPsEGTjXDLy7jmO+jBxswQ7Nq0MpQq9SWRznk2rHKBFdXEEuWDGJSVnjp0XHF7iu5IsLOUKVfodqQ1AEA=="
    }

    EFGMITEMS["arc9_eft_sako_trg"] = {
        ["fullName"] = "Sako TRG M10 .338 LM bolt-action sniper rifle",
        ["displayName"] = "Sako TRG M10",
        ["displayType"] = "Sniper Rifle",
        ["weight"] = 6.7,
        ["value"] = 249500,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["equipSlot"] = WEAPONSLOTS.PRIMARY.ID,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/weapons/sako.png", "smooth"),

        ["sizeX"] = 6,
        ["sizeY"] = 2,

        ["defAtts"] = "XQAAAQD4AgAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8OSPUS50ueaV1GG+rPRo5+8m2Sm656FXjCbKUY7J6DBmUnL9FXWbbSS2BVCo31BNK4Bvrc6zYshs41G/Zc61xYlL+L4GI5NKRlP/Aa75K43e/UAnao6/4jXc0TuG5WT/TP851aNFst+XIAdAV99s+P2SyECbvjN8tB0TUBR9QTBY5YjsR11tMSKoEpUaLETGViO0j1zwi7Z4wTQqZYwgHBEj+eecA8ksrgWYkTCjvBcf1xAA=="
    }

    -- submachine guns
    EFGMITEMS["arc9_eft_mp9"] = {
        ["fullName"] = "B&T MP9 9x19 submachine gun",
        ["displayName"] = "MP9",
        ["displayType"] = "Submachine Gun",
        ["weight"] = 1.3,
        ["value"] = 43000,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["equipSlot"] = WEAPONSLOTS.PRIMARY.ID,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/weapons/mp9.png", "smooth"),

        ["sizeX"] = 3,
        ["sizeY"] = 2,

        ["defAtts"] = "XQAAAQCKAQAAAAAAAAA9iIIiM7hMNz0dhIkbkvLjTdSR5gRNNIHH3iMsyB8XQoVZc5MYQexI1ffzpCrvKqfdB+rsPaHaT2Blw9LmEBuv1mA/ZRmzKcRiqXPL89IDAsS6U+YMW22DXenZavSF1ISlOL7FxvzWoLrgHpOOSm5JzIoRwanakCwORxSktHUHCH/ES6bJl4MUG9iYDnuo6Q=="
    }

    EFGMITEMS["arc9_eft_mp9n"] = {
        ["fullName"] = "B&T MP9-N 9x19 submachine gun",
        ["displayName"] = "MP9-N",
        ["displayType"] = "Submachine Gun",
        ["weight"] = 1.4,
        ["value"] = 50000,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["equipSlot"] = WEAPONSLOTS.PRIMARY.ID,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/weapons/mp9n.png", "smooth"),

        ["sizeX"] = 3,
        ["sizeY"] = 2,

        ["defAtts"] = "XQAAAQBkAQAAAAAAAAA9iIIiM7hMNz0dhIkbkvLjTdSR5gRNNIHH3iMsyB8XQoVZc5LZUctUjjB8hqkZn7PgjNJBHUDMSCfKQdTCQa/QYOQH7cDRfRaTVJ767wECL5eTBfe6RNmzmxLzZn9tAPPZgf41fsi324dNSCCqQJvh0p3Sb3lrktclA2Vw2NHxERhLYg8r"
    }

    EFGMITEMS["arc9_eft_fn_p90"] = {
        ["fullName"] = "FN P90 5.7x28 submachine gun",
        ["displayName"] = "P90",
        ["displayType"] = "Submachine Gun",
        ["weight"] = 2.9,
        ["value"] = 72000,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["equipSlot"] = WEAPONSLOTS.PRIMARY.ID,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/weapons/p90.png", "smooth"),

        ["sizeX"] = 3,
        ["sizeY"] = 2,

        ["defAtts"] = "XQAAAQBMAgAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8Ny5IZ7Zcx4cUYhoInAEZ+nl9GVj4rv1KsgZ4x2lhRagjdJTg3JU/kscQERrXasfT6UaKVuZt2bsQiG2/t/UNQA4RMAWLsptpRXm6CBu4uWV5sUH8F4Mm5qQlRjtsaS+Epco+oyrNDfMEv0/EQOU8gwsN890XzZHleJwcAoTA6xDmd3TkYNJmem/wVs/lccsmtTDhbR2Mn6YVhBos="
    }

    EFGMITEMS["arc9_eft_mp5"] = {
        ["fullName"] = "HK MP5 9x19 submachine gun",
        ["displayName"] = "MP5",
        ["displayType"] = "Submachine Gun",
        ["weight"] = 2.4,
        ["value"] = 41000,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["equipSlot"] = WEAPONSLOTS.PRIMARY.ID,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/weapons/mp5.png", "smooth"),

        ["sizeX"] = 3,
        ["sizeY"] = 2,

        ["defAtts"] = "XQAAAQCbAQAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8NV6WhTi7Ui/5BdiqeDJy8MVUdk9skb/TP9x4IQXLk+dJw1ASm2Bc56n23sNdESJMDpvQGDRKmlwcv2uQem6GgQKNCB/Yrfsu0zjVfJf9BWLnxdPIcWYoQ0efbGWHjXAIDv2JSFSOWXOu8kXdQ/60VM9uUucTdVaS4I39SYw=="
    }

    EFGMITEMS["arc9_eft_mp5k"] = {
        ["fullName"] = "HK MP5K 9x19 submachine gun",
        ["displayName"] = "MP5K-N",
        ["displayType"] = "Submachine Gun",
        ["weight"] = 1.8,
        ["value"] = 32000,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["equipSlot"] = WEAPONSLOTS.PRIMARY.ID,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/weapons/mp5k.png", "smooth"),

        ["sizeX"] = 2,
        ["sizeY"] = 1,

        ["defAtts"] = "XQAAAQBLAQAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8NV6WhTi7Ui/4zrwVOyrfUx7fgXQ8ALMhtStnN/OQ+C36mWZp8UwJ5uH0SWZv3pKOwPGG/asqqBXKosYoeIhiF5PLQkB4gd2YGJDJHYaI+6lCLhpsO8Vk3EFMbHjO34SpSfB/6qMDHEJthcKju1G/19g=="
    }

    EFGMITEMS["arc9_eft_mp7a1"] = {
        ["fullName"] = "HK MP7A1 4.6x30 submachine gun",
        ["displayName"] = "MP7A1",
        ["displayType"] = "Submachine Gun",
        ["weight"] = 2.2,
        ["value"] = 73000,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["equipSlot"] = WEAPONSLOTS.PRIMARY.ID,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/weapons/mp7a1.png", "smooth"),

        ["sizeX"] = 3,
        ["sizeY"] = 1,

        ["defAtts"] = "XQAAAQBoAQAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8NV6XBeOzbVc3/+oJVTjqv2y1/N6rCbsp5PT5ky5xEMVwRLNgW0fN8cTRAuAizUrBVXXF/YybHeXMOq38nmuYZjE8rO8MdHthSgqamIKXz4/vfLxrEx5t5AeABJfq8yRXBa5WJ7l0Q9DHa5FunPA8b8LPQdhozbE/jMgtnf9G3"
    }

    EFGMITEMS["arc9_eft_mp7a2"] = {
        ["fullName"] = "HK MP7A2 4.6x30 submachine gun",
        ["displayName"] = "MP7A2",
        ["displayType"] = "Submachine Gun",
        ["weight"] = 2.2,
        ["value"] = 81000,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["equipSlot"] = WEAPONSLOTS.PRIMARY.ID,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/weapons/mp7a2.png", "smooth"),

        ["sizeX"] = 3,
        ["sizeY"] = 1,

        ["defAtts"] = "XQAAAQBoAQAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8NV6XBeOzbVc3/+oJVTjqv2y1/N6rCbsp5PT5ky5xEMVwRLNgW0fN8cTRAuAizUrBVXXF/YybHeXMOq38nmuYZjE8rO8MdHthSgqamIKXz4/vfLxrEx5t5AeABLGPYyRXBa5WJ7l0Q9DHa5FunPA8b8LPQdhozbE/jMgtnf9G3"
    }

    EFGMITEMS["arc9_eft_ump"] = {
        ["fullName"] = "HK UMP .45 ACP submachine gun",
        ["displayName"] = "UMP .45",
        ["displayType"] = "Submachine Gun",
        ["weight"] = 2.2,
        ["value"] = 35000,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["equipSlot"] = WEAPONSLOTS.PRIMARY.ID,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/weapons/ump.png", "smooth"),

        ["sizeX"] = 3,
        ["sizeY"] = 2,

        ["defAtts"] = "XQAAAQDEAQAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8LmM+VxqdivzAkNlrd254f2zsoAbSMkGc7K6jqT3wmPoeiLRGobkYLeRB+RlYSNPlrjogENZ5LAajivJRLfrO+7bb9wBK9R2qy+ZF9p6RJySe79wzSD62bV4CmCHDKZ54raGVc8AzqsobkJW01xMjAkg/ILIRZwXI1TAI="
    }

    EFGMITEMS["arc9_eft_uzi"] = {
        ["fullName"] = "IWI UZI 9x19 submachine gun",
        ["displayName"] = "UZI",
        ["displayType"] = "Submachine Gun",
        ["weight"] = 3.7,
        ["value"] = 29000,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["equipSlot"] = WEAPONSLOTS.PRIMARY.ID,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/weapons/uzi.png", "smooth"),

        ["sizeX"] = 3,
        ["sizeY"] = 2,

        ["defAtts"] = "XQAAAQBUAQAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8OnI8vYf1rCestvC7ZomSDqkEaST9pI/tJWGuLhGPu7F3/hH5jrMd8VPdZo9VfZwp5bXMJsXWD218BSfizcep/epC73lPWFlJdkXkIgRjbmaVBXd3Uky4/py6cCyEUADpEnhlTeCsizpJ6fVOAg8u2peV75Uu5OUoZt5OLno6yow=="
    }

    EFGMITEMS["arc9_eft_uzi_pro"] = {
        ["fullName"] = "IWI UZI PRO Pistol 9x19 submachine gun",
        ["displayName"] = "UZI PRO Pistol",
        ["displayType"] = "Submachine Gun",
        ["weight"] = 1.6,
        ["value"] = 48000,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["equipSlot"] = WEAPONSLOTS.PRIMARY.ID,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/weapons/uzi_pro.png", "smooth"),

        ["sizeX"] = 2,
        ["sizeY"] = 1,

        ["defAtts"] = "XQAAAQBMAQAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8OnI8wUUtnKFsnDqksjQsUIr0a9ug53GItJaWG9dXHQsj4p7qnyx5LvF9XSMnbk5vTEPLZSjCOUQ31HUnwDqaOaQcMT2gbJSIRizo0Vpog5GN0YnpbZPPoCVxLg/vc+E3PpGfwFQBBzz3begaoPEp/UI6adqSCDkVxb9nEGOIO/XExtA=="
    }

    EFGMITEMS["arc9_eft_vector45"] = {
        ["fullName"] = "TDI KRISS Vector Gen.2 .45 ACP submachine gun",
        ["displayName"] = "Vector .45",
        ["displayType"] = "Submachine Gun",
        ["weight"] = 2.6,
        ["value"] = 78000,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["equipSlot"] = WEAPONSLOTS.PRIMARY.ID,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/weapons/vector45.png", "smooth"),

        ["sizeX"] = 3,
        ["sizeY"] = 2,

        ["defAtts"] = "XQAAAQCPAgAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8LmM+VxqdivzWrVHCKHCrwkDoGD2H5i0vKMWG4xOnDh+DnfHsrok0+NhhHIvfShgaTM2uRxIz3c3fP25b6aNk1Wo6VIkLhe9IkMCHmUnCfE8JliQPXa2S/ax3xxIMjWVO9wrzDLpOhmUr8U1AnpPf9dvXBkMyoLK8u9w67ZGCc6zu4uJ2lpglAxXXqzQuEGTe03GznPKFlHtCHG8XTEWs7aDtjnLTW7BpFikGo5ieGcVbVL/6DI7laqmKH"
    }

    EFGMITEMS["arc9_eft_vector9"] = {
        ["fullName"] = "TDI KRISS Vector Gen.2 9x19 submachine gun",
        ["displayName"] = "Vector 9x19",
        ["displayType"] = "Submachine Gun",
        ["weight"] = 2.5,
        ["value"] = 72000,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["equipSlot"] = WEAPONSLOTS.PRIMARY.ID,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/weapons/vector9.png", "smooth"),

        ["sizeX"] = 3,
        ["sizeY"] = 2,

        ["defAtts"] = "XQAAAQCQAgAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8LmM+VxqdivzWrVHCKHFK/OKg6tQGfMxTw2sSYzH8DA+yRkukxMuVtnHLd5D+00z1/CuRNFHTCnwPKHYIf7LKMkE93bGmGNu+Y8Gq5MnyO+/Yfii5VZM1JsV31Gp+3yhsu1i7dJ5HK1wd58KR23artZsA/xG0D1QanKxMttmuNLMCEg/QdoFLkrCmcmrwFHrVSXCmZmDOFUTvZpz0KoOIqvseLpVg1/pFx56Kcr1vy1bQmerxUWRbd5ds9zBE6AA=="
    }

    EFGMITEMS["arc9_eft_pp1901"] = {
        ["fullName"] = "PP-19-01 Vityaz 9x19 submachine gun",
        ["displayName"] = "PP-19-01",
        ["displayType"] = "Submachine Gun",
        ["weight"] = 2.8,
        ["value"] = 22000,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["equipSlot"] = WEAPONSLOTS.PRIMARY.ID,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/weapons/pp1901.png", "smooth"),

        ["sizeX"] = 3,
        ["sizeY"] = 2,

        ["defAtts"] = "XQAAAQDlAQAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8Ow0KSg3T7B5vIp3sexto8fQ4pxZDgD8ITlaBezlHariBt2nNgnR5HpjwrHzxjhb/9/KF6dD+MIHNTFA9Kaq3AwXyYvEabaCVx3g+ZYil6ymdOPUBQvS1UrOFsD2D8gDH2tRIcdU/Y4+2Ovh1ui0SKDd+eymaTj8Dwe8TxTXg7gl8WIkGtMU/bmc2opM5I1nzyKCAyGctDw44y"
    }

    EFGMITEMS["arc9_eft_kedr"] = {
        ["fullName"] = "PP-91 Kedr 9x18PM submachine gun",
        ["displayName"] = "PP-91 Kedr",
        ["displayType"] = "Submachine Gun",
        ["weight"] = 1.5,
        ["value"] = 18000,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["equipSlot"] = WEAPONSLOTS.PRIMARY.ID,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/weapons/kedr.png", "smooth"),

        ["sizeX"] = 3,
        ["sizeY"] = 2,

        ["defAtts"] = "XQAAAQCWAAAAAAAAAAA9iIIiM7hMNz0dhJSTKmZ7v+v6J9rfJDxrK5jGCg3BYDHYlRHvfWew2oXx4dsswxofgrYNO0HRMoNogTCUTYwLyG00L3Nll37QQlzZazSRsWCwnl8/RdAzcQ=="
    }

    EFGMITEMS["arc9_eft_ppsh41"] = {
        ["fullName"] = "PPSh-41 7.62x25 submachine gun",
        ["displayName"] = "PPSh-41",
        ["displayType"] = "Submachine Gun",
        ["weight"] = 4.0,
        ["value"] = 26000,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["equipSlot"] = WEAPONSLOTS.PRIMARY.ID,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/weapons/ppsh.png", "smooth"),

        ["sizeX"] = 4,
        ["sizeY"] = 2,

        ["defAtts"] = "XQAAAQDnAAAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8N0RqirEVRWccrEPmZQy2AqJNRYYwzkZDcKZUlCD0pHntf2w3T13Rz/KFkXhFoHFcbVhF5Tm2+6qGo2yB8pxLI6BVj+ShG5w3yBPFISM1P9c92waE6nUkVmwA="
    }

    EFGMITEMS["arc9_eft_saiga9"] = {
        ["fullName"] = "Saiga-9 9x19 carbine",
        ["displayName"] = "Saiga-9",
        ["displayType"] = "Submachine Gun",
        ["weight"] = 3.0,
        ["value"] = 17000,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["equipSlot"] = WEAPONSLOTS.PRIMARY.ID,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/weapons/saiga9.png", "smooth"),

        ["sizeX"] = 4,
        ["sizeY"] = 2,

        ["defAtts"] = "XQAAAQDoAQAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8Ow0KSg3T7B5vIp3sexto6q0AlysynnEO7AtzYfdOUlVrvx/JoE923Gtn7IextB9sgNGPSe4VIllyjo36FhU/nFYdGyq3CmZqWXXd8kRbdFQ7nRL1Seo1iKx5h577Wfn4q5AY0ZjOMxO/l6+gimmN05PXaFNxchJr3hJXXDy4rW+8NPxNv6MDm6kgs6Ap55yydmmB8CfyhOeFNb5dAKwA="
    }

    EFGMITEMS["arc9_eft_mpx"] = {
        ["fullName"] = "SIG MPX 9x19 submachine gun",
        ["displayName"] = "MPX",
        ["displayType"] = "Submachine Gun",
        ["weight"] = 2.8,
        ["value"] = 54000,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["equipSlot"] = WEAPONSLOTS.PRIMARY.ID,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/weapons/mpx.png", "smooth"),

        ["sizeX"] = 4,
        ["sizeY"] = 2,

        ["defAtts"] = "XQAAAQAIAwAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8NV6pNTTPdW6lkrMILLX5Qrf3AjqprlCB+rMOMGzMDhpdxdn1+CTPrYuA8snl2O9gXUVRDBdq0xz4bmZRB1stPHoZFDIOB45A7TWOd3QR+6B11V++6ld/lqUAdsWUC2CWS25KDzyeTZ3LR0hwYWLCXGd/ugZ8DEEB2IwolVBtVRzETc0j5uo56eyEiuilaGz9XB/cLtBN017OouTyw7lazpNIvBLjlSPZbP+bRG2ajC8u6P3GptnJA6FMPlM/BQObqLaZ4wFjAZUNMAAA="
    }

    EFGMITEMS["arc9_eft_stm9"] = {
        ["fullName"] = "Soyuz-TM STM-9 Gen.2 9x19 carbine",
        ["displayName"] = "STM-9",
        ["displayType"] = "Submachine Gun",
        ["weight"] = 2.0,
        ["value"] = 43000,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["equipSlot"] = WEAPONSLOTS.PRIMARY.ID,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/weapons/stm9.png", "smooth"),

        ["sizeX"] = 4,
        ["sizeY"] = 2,

        ["defAtts"] = "XQAAAQCzAgAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8ONwzg/TnvSdQ0A0yA5XazCbEH/vLw/nHkJ2XqRzfgqw5kSXxscJbZh4RNNwBeDAq3M0aMSoXkMANJpjU51sUzgNodJ4PPq0fK7Y+xa0tOjgmyE9wQpN2AbJlfR2U8LlPKf7ds4bdso0BXQ4Zy5JwA9aaD3KVbcL/4+UH2hqktQ1SLcr8FohdwocdF6EVjGIEn0vyzQNcdeh+o8I1vKa2vzB4WQTDeIeoEZ+FX5BWtzMWI0vYPqvEG9Pu0tZ/w6f7xdb53rUrkNXTEdIFnqbrmQ0Ey2A=="
    }

    EFGMITEMS["arc9_eft_sr2m"] = {
        ["fullName"] = "SR-2M Veresk 9x21 submachine gun",
        ["displayName"] = "SR-2M",
        ["displayType"] = "Submachine Gun",
        ["weight"] = 1.7,
        ["value"] = 53000,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["equipSlot"] = WEAPONSLOTS.PRIMARY.ID,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/weapons/sr2m.png", "smooth"),

        ["sizeX"] = 3,
        ["sizeY"] = 2,

        ["defAtts"] = "XQAAAQCSAQAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8OSrn2+R+UR2za4bcZe+/IwUlX0PcpLfPOK5eFMdlDveryivexZNi6fe+Y+ROyxqyj4Dv1Z9BlA2CEZjv7lZ1y1QgkdifYos3wNSlZWqfZQ5+VC+aMRnTvI4iuSZAjthOUSJlcjcAOmLrkR027m8H2Q2st5fIA"
    }

    -- launchers
    EFGMITEMS["arc9_eft_fn40gl"] = {
        ["fullName"] = "FN40GL Mk2 40mm grenade launcher",
        ["displayName"] = "FN40GL",
        ["displayType"] = "Launcher",
        ["weight"] = 3.0,
        ["value"] = 160000,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["equipSlot"] = WEAPONSLOTS.PRIMARY.ID,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/weapons/fn40gl.png", "smooth"),

        ["sizeX"] = 3,
        ["sizeY"] = 2,

        ["defAtts"] = "XQAAAQCrAAAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8LcZnpdAq+1HxvVFYM8yMuG3QVvnwhP32P3T9+b6yx6EtZbue8c+rXbC1/wisVwiACA9z7RE6ODiOAXKohmGfZ731lBAX2dwTm+1X5GW6w0B97mkHiGQA="
    }

    EFGMITEMS["arc9_eft_m32a1"] = {
        ["fullName"] = "Milkor M32A1 MSGL 40mm grenade launcher",
        ["displayName"] = "Milkor M32A1",
        ["displayType"] = "Launcher",
        ["weight"] = 5.4,
        ["value"] = 400000,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["equipSlot"] = WEAPONSLOTS.PRIMARY.ID,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/weapons/m32a1.png", "smooth"),

        ["sizeX"] = 4,
        ["sizeY"] = 2,

        ["defAtts"] = "XQAAAQAJAQAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8LcZnpdAq+1HxvVFYM8yMuG3QVvnwhP32P3T9+b6yx6EtZbue8dF7Fsj37UUn+7mk9v/HrNRAFGg6nQkIwWTKSU5Ht4euLD+2nV9cVQ5QTQEhTXHfBai51DvzIw0ZoLBPUIiwYXsBVck0Y40MSrORhD3wFxwGQfgA="
    }

        EFGMITEMS["arc9_eft_rshg2"] = {
        ["fullName"] = "RShG-2 72.5mm rocket launcher",
        ["displayName"] = "RShG-2",
        ["displayType"] = "Launcher",
        ["weight"] = 4.0,
        ["value"] = 200000,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["equipSlot"] = WEAPONSLOTS.PRIMARY.ID,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/weapons/rshg2.png", "smooth"),

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
        ["equipSlot"] = WEAPONSLOTS.MELEE.ID,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/melee/taran.png", "smooth"),

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
        ["equipSlot"] = WEAPONSLOTS.MELEE.ID,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/melee/6x5.png", "smooth"),

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
        ["equipSlot"] = WEAPONSLOTS.MELEE.ID,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/melee/akula.png", "smooth"),

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
        ["equipSlot"] = WEAPONSLOTS.MELEE.ID,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/melee/axe.png", "smooth"),

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
        ["equipSlot"] = WEAPONSLOTS.MELEE.ID,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/melee/gladius.png", "smooth"),

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
        ["equipSlot"] = WEAPONSLOTS.MELEE.ID,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/melee/a2607.png", "smooth"),

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
        ["equipSlot"] = WEAPONSLOTS.MELEE.ID,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/melee/a2607d.png", "smooth"),

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
        ["equipSlot"] = WEAPONSLOTS.MELEE.ID,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/melee/camper.png", "smooth"),

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
        ["equipSlot"] = WEAPONSLOTS.MELEE.ID,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/melee/labris.png", "smooth"),

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
        ["equipSlot"] = WEAPONSLOTS.MELEE.ID,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/melee/crash.png", "smooth"),

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
        ["equipSlot"] = WEAPONSLOTS.MELEE.ID,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/melee/cultist.png", "smooth"),

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
        ["equipSlot"] = WEAPONSLOTS.MELEE.ID,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/melee/fulcrum.png", "smooth"),

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
        ["equipSlot"] = WEAPONSLOTS.MELEE.ID,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/melee/crowbar.png", "smooth"),

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
        ["equipSlot"] = WEAPONSLOTS.MELEE.ID,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/melee/katt.png", "smooth"),

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
        ["equipSlot"] = WEAPONSLOTS.MELEE.ID,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/melee/kukri.png", "smooth"),

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
        ["equipSlot"] = WEAPONSLOTS.MELEE.ID,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/melee/m2.png", "smooth"),

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
        ["equipSlot"] = WEAPONSLOTS.MELEE.ID,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/melee/mpl50.png", "smooth"),

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
        ["equipSlot"] = WEAPONSLOTS.MELEE.ID,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/melee/rebel.png", "smooth"),

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
        ["equipSlot"] = WEAPONSLOTS.MELEE.ID,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/melee/voodoo.png", "smooth"),

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
        ["equipSlot"] = WEAPONSLOTS.MELEE.ID,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/melee/sp8.png", "smooth"),

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
        ["equipSlot"] = WEAPONSLOTS.MELEE.ID,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/melee/taiga.png", "smooth"),

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
        ["equipSlot"] = WEAPONSLOTS.MELEE.ID,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/melee/taiga.png", "smooth"),

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
        ["equipSlot"] = WEAPONSLOTS.GRENADE.ID,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/grenades/f1.png", "smooth"),

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
        ["equipSlot"] = WEAPONSLOTS.GRENADE.ID,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/grenades/m18.png", "smooth"),

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
        ["equipSlot"] = WEAPONSLOTS.GRENADE.ID,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/grenades/m18y.png", "smooth"),

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
        ["equipSlot"] = WEAPONSLOTS.GRENADE.ID,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/grenades/m67.png", "smooth"),

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
        ["equipSlot"] = WEAPONSLOTS.GRENADE.ID,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/grenades/m7290.png", "smooth"),

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
        ["equipSlot"] = WEAPONSLOTS.GRENADE.ID,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/grenades/rdg2b.png", "smooth"),

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
        ["equipSlot"] = WEAPONSLOTS.GRENADE.ID,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/grenades/rgd5.png", "smooth"),

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
        ["equipSlot"] = WEAPONSLOTS.GRENADE.ID,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/grenades/rgn.png", "smooth"),

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
        ["equipSlot"] = WEAPONSLOTS.GRENADE.ID,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/grenades/rgo.png", "smooth"),

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
        ["equipSlot"] = WEAPONSLOTS.GRENADE.ID,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/grenades/v40.png", "smooth"),

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
        ["equipSlot"] = WEAPONSLOTS.GRENADE.ID,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/grenades/vog17.png", "smooth"),

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
        ["equipSlot"] = WEAPONSLOTS.GRENADE.ID,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/grenades/vog25.png", "smooth"),

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
        ["equipSlot"] = WEAPONSLOTS.GRENADE.ID,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/grenades/zarya.png", "smooth"),

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
        ["equipSlot"] = WEAPONSLOTS.UTILITY.ID,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/special/sp81.png", "smooth"),

        ["sizeX"] = 2,
        ["sizeY"] = 1,

        ["defAtts"] = "XQAAAQBMAAAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8LcZnpdAm+MHx7QSWYVQ05R018qLGy4Ql10Wh0xRhQUdUgz8wGuxkTc1+wcUVnUX80pBNBJA=="
    }

    EFGMITEMS["arc9_eft_rangefinder"] = {
        ["fullName"] = "Vortex Ranger 1500 rangefinder",
        ["displayName"] = "R1500",
        ["displayType"] = "Special",
        ["weight"] = 0.2,
        ["value"] = 20000,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["equipSlot"] = WEAPONSLOTS.HOLSTER.ID,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/special/r1500.png", "smooth"),

        ["sizeX"] = 1,
        ["sizeY"] = 1
    }

-- AMMUNITION
    -- pistol cartirdges
    EFGMITEMS["efgm_ammo_762x25"] = {
        ["fullName"] = "7.62x25mm Tokarev",
        ["displayName"] = "7.62x25",
        ["displayType"] = "Ammunition",
        ["weight"] = 0.01,
        ["value"] = 80,
        ["equipType"] = EQUIPTYPE.Ammunition,
        ["appearInInventory"] = true,
        ["stackSize"] = 60,
        ["icon"] = Material("items/ammo/762x25.png", "smooth"),
        ["iconColor"] = Color(52, 53, 36, 155),

        ["sizeX"] = 1,
        ["sizeY"] = 1
    }

    EFGMITEMS["efgm_ammo_9x18"] = {
        ["fullName"] = "9x18mm Makarov",
        ["displayName"] = "9x18",
        ["displayType"] = "Ammunition",
        ["weight"] = 0.012,
        ["value"] = 90,
        ["equipType"] = EQUIPTYPE.Ammunition,
        ["appearInInventory"] = true,
        ["stackSize"] = 60,
        ["icon"] = Material("items/ammo/9x18.png", "smooth"),
        ["iconColor"] = Color(52, 53, 36, 155),

        ["sizeX"] = 1,
        ["sizeY"] = 1
    }

    EFGMITEMS["efgm_ammo_9x19"] = {
        ["fullName"] = "9x19mm Parabellum",
        ["displayName"] = "9x19",
        ["displayType"] = "Ammunition",
        ["weight"] = 0.005,
        ["value"] = 100,
        ["equipType"] = EQUIPTYPE.Ammunition,
        ["appearInInventory"] = true,
        ["stackSize"] = 60,
        ["icon"] = Material("items/ammo/9x19.png", "smooth"),
        ["iconColor"] = Color(52, 53, 36, 155),

        ["sizeX"] = 1,
        ["sizeY"] = 1
    }

    EFGMITEMS["efgm_ammo_9x21"] = {
        ["fullName"] = "9x21mm Gyurza",
        ["displayName"] = "9x21",
        ["displayType"] = "Ammunition",
        ["weight"] = 0.011,
        ["value"] = 190,
        ["equipType"] = EQUIPTYPE.Ammunition,
        ["appearInInventory"] = true,
        ["stackSize"] = 60,
        ["icon"] = Material("items/ammo/9x21.png", "smooth"),
        ["iconColor"] = Color(52, 53, 36, 155),

        ["sizeX"] = 1,
        ["sizeY"] = 1
    }

    EFGMITEMS["efgm_ammo_357"] = {
        ["fullName"] = ".357 Magnum",
        ["displayName"] = ".357",
        ["displayType"] = "Ammunition",
        ["weight"] = 0.016,
        ["value"] = 100,
        ["equipType"] = EQUIPTYPE.Ammunition,
        ["appearInInventory"] = true,
        ["stackSize"] = 60,
        ["icon"] = Material("items/ammo/357.png", "smooth"),
        ["iconColor"] = Color(52, 53, 36, 155),

        ["sizeX"] = 1,
        ["sizeY"] = 1
    }

    EFGMITEMS["efgm_ammo_45"] = {
        ["fullName"] = ".45 ACP",
        ["displayName"] = ".45",
        ["displayType"] = "Ammunition",
        ["weight"] = 0.016,
        ["value"] = 210,
        ["equipType"] = EQUIPTYPE.Ammunition,
        ["appearInInventory"] = true,
        ["stackSize"] = 60,
        ["icon"] = Material("items/ammo/45.png", "smooth"),
        ["iconColor"] = Color(52, 53, 36, 155),

        ["sizeX"] = 1,
        ["sizeY"] = 1
    }

    EFGMITEMS["efgm_ammo_50ae"] = {
        ["fullName"] = ".50 Action Express",
        ["displayName"] = ".50 AE",
        ["displayType"] = "Ammunition",
        ["weight"] = 0.029,
        ["value"] = 420,
        ["equipType"] = EQUIPTYPE.Ammunition,
        ["appearInInventory"] = true,
        ["stackSize"] = 60,
        ["icon"] = Material("items/ammo/50ae.png", "smooth"),
        ["iconColor"] = Color(52, 53, 36, 155),

        ["sizeX"] = 1,
        ["sizeY"] = 1
    }

    EFGMITEMS["efgm_ammo_20x1"] = {
        ["fullName"] = "20x1mm",
        ["displayName"] = "Disk",
        ["displayType"] = "Ammunition",
        ["weight"] = 0.001,
        ["value"] = 10,
        ["equipType"] = EQUIPTYPE.Ammunition,
        ["appearInInventory"] = true,
        ["stackSize"] = 20,
        ["icon"] = Material("items/ammo/20x1.png", "smooth"),
        ["iconColor"] = Color(52, 53, 36, 155),

        ["sizeX"] = 1,
        ["sizeY"] = 1
    }

    -- pdw cartirdges
    EFGMITEMS["efgm_ammo_46x30"] = {
        ["fullName"] = "4.6x30mm HK",
        ["displayName"] = "4.6x30",
        ["displayType"] = "Ammunition",
        ["weight"] = 0.007,
        ["value"] = 380,
        ["equipType"] = EQUIPTYPE.Ammunition,
        ["appearInInventory"] = true,
        ["stackSize"] = 60,
        ["icon"] = Material("items/ammo/46x30.png", "smooth"),
        ["iconColor"] = Color(52, 53, 36, 155),

        ["sizeX"] = 1,
        ["sizeY"] = 1
    }

    EFGMITEMS["efgm_ammo_57x28"] = {
        ["fullName"] = "5.7x28mm FN",
        ["displayName"] = "5.7x28",
        ["displayType"] = "Ammunition",
        ["weight"] = 0.006,
        ["value"] = 310,
        ["equipType"] = EQUIPTYPE.Ammunition,
        ["appearInInventory"] = true,
        ["stackSize"] = 60,
        ["icon"] = Material("items/ammo/57x28.png", "smooth"),
        ["iconColor"] = Color(52, 53, 36, 155),

        ["sizeX"] = 1,
        ["sizeY"] = 1
    }

    -- rifle cartirdges
    EFGMITEMS["efgm_ammo_545x39"] = {
        ["fullName"] = "5.45x39mm",
        ["displayName"] = "5.45x39",
        ["displayType"] = "Ammunition",
        ["weight"] = 0.01,
        ["value"] = 220,
        ["equipType"] = EQUIPTYPE.Ammunition,
        ["appearInInventory"] = true,
        ["stackSize"] = 60,
        ["icon"] = Material("items/ammo/545x39.png", "smooth"),
        ["iconColor"] = Color(52, 53, 36, 155),

        ["sizeX"] = 1,
        ["sizeY"] = 1
    }

    EFGMITEMS["efgm_ammo_556x45"] = {
        ["fullName"] = "5.56x45mm NATO",
        ["displayName"] = "5.56x45",
        ["displayType"] = "Ammunition",
        ["weight"] = 0.012,
        ["value"] = 270,
        ["equipType"] = EQUIPTYPE.Ammunition,
        ["appearInInventory"] = true,
        ["stackSize"] = 60,
        ["icon"] = Material("items/ammo/556x45.png", "smooth"),
        ["iconColor"] = Color(52, 53, 36, 155),

        ["sizeX"] = 1,
        ["sizeY"] = 1
    }

    EFGMITEMS["efgm_ammo_68x51"] = {
        ["fullName"] = "6.8x51mm",
        ["displayName"] = "6.8x51",
        ["displayType"] = "Ammunition",
        ["weight"] = 0.024,
        ["value"] = 680,
        ["equipType"] = EQUIPTYPE.Ammunition,
        ["appearInInventory"] = true,
        ["stackSize"] = 40,
        ["icon"] = Material("items/ammo/68x51.png", "smooth"),
        ["iconColor"] = Color(52, 53, 36, 155),

        ["sizeX"] = 1,
        ["sizeY"] = 1
    }

    EFGMITEMS["efgm_ammo_300"] = {
        ["fullName"] = ".300 Blackout",
        ["displayName"] = ".300",
        ["displayType"] = "Ammunition",
        ["weight"] = 0.014,
        ["value"] = 330,
        ["equipType"] = EQUIPTYPE.Ammunition,
        ["appearInInventory"] = true,
        ["stackSize"] = 60,
        ["icon"] = Material("items/ammo/300.png", "smooth"),
        ["iconColor"] = Color(52, 53, 36, 155),

        ["sizeX"] = 1,
        ["sizeY"] = 1
    }

    EFGMITEMS["efgm_ammo_762x39"] = {
        ["fullName"] = "7.62x39mm",
        ["displayName"] = "7.62x39",
        ["displayType"] = "Ammunition",
        ["weight"] = 0.016,
        ["value"] = 290,
        ["equipType"] = EQUIPTYPE.Ammunition,
        ["appearInInventory"] = true,
        ["stackSize"] = 60,
        ["icon"] = Material("items/ammo/762x39.png", "smooth"),
        ["iconColor"] = Color(52, 53, 36, 155),

        ["sizeX"] = 1,
        ["sizeY"] = 1
    }

    EFGMITEMS["efgm_ammo_762x51"] = {
        ["fullName"] = "7.62x51mm NATO",
        ["displayName"] = "7.62x51",
        ["displayType"] = "Ammunition",
        ["weight"] = 0.022,
        ["value"] = 360,
        ["equipType"] = EQUIPTYPE.Ammunition,
        ["appearInInventory"] = true,
        ["stackSize"] = 40,
        ["icon"] = Material("items/ammo/762x51.png", "smooth"),
        ["iconColor"] = Color(52, 53, 36, 155),

        ["sizeX"] = 1,
        ["sizeY"] = 1
    }

    EFGMITEMS["efgm_ammo_762x54"] = {
        ["fullName"] = "7.62x54mmR",
        ["displayName"] = "7.62x54",
        ["displayType"] = "Ammunition",
        ["weight"] = 0.024,
        ["value"] = 350,
        ["equipType"] = EQUIPTYPE.Ammunition,
        ["appearInInventory"] = true,
        ["stackSize"] = 40,
        ["icon"] = Material("items/ammo/762x54.png", "smooth"),
        ["iconColor"] = Color(52, 53, 36, 155),

        ["sizeX"] = 1,
        ["sizeY"] = 1
    }

    EFGMITEMS["efgm_ammo_338"] = {
        ["fullName"] = ".338 Lapua Magnum",
        ["displayName"] = ".338",
        ["displayType"] = "Ammunition",
        ["weight"] = 0.049,
        ["value"] = 880,
        ["equipType"] = EQUIPTYPE.Ammunition,
        ["appearInInventory"] = true,
        ["stackSize"] = 40,
        ["icon"] = Material("items/ammo/338.png", "smooth"),
        ["iconColor"] = Color(52, 53, 36, 155),

        ["sizeX"] = 1,
        ["sizeY"] = 1
    }

    EFGMITEMS["efgm_ammo_9x39"] = {
        ["fullName"] = "9x39mm",
        ["displayName"] = "9x39",
        ["displayType"] = "Ammunition",
        ["weight"] = 0.023,
        ["value"] = 400,
        ["equipType"] = EQUIPTYPE.Ammunition,
        ["appearInInventory"] = true,
        ["stackSize"] = 60,
        ["icon"] = Material("items/ammo/9x39.png", "smooth"),
        ["iconColor"] = Color(52, 53, 36, 155),

        ["sizeX"] = 1,
        ["sizeY"] = 1
    }

    EFGMITEMS["efgm_ammo_366"] = {
        ["fullName"] = ".366 TKM",
        ["displayName"] = ".366",
        ["displayType"] = "Ammunition",
        ["weight"] = 0.019,
        ["value"] = 320,
        ["equipType"] = EQUIPTYPE.Ammunition,
        ["appearInInventory"] = true,
        ["stackSize"] = 60,
        ["icon"] = Material("items/ammo/366.png", "smooth"),
        ["iconColor"] = Color(52, 53, 36, 155),

        ["sizeX"] = 1,
        ["sizeY"] = 1
    }

    EFGMITEMS["efgm_ammo_127x55"] = {
        ["fullName"] = "12.7x55mm",
        ["displayName"] = "12.7x55",
        ["displayType"] = "Ammunition",
        ["weight"] = 0.055,
        ["value"] = 700,
        ["equipType"] = EQUIPTYPE.Ammunition,
        ["appearInInventory"] = true,
        ["stackSize"] = 40,
        ["icon"] = Material("items/ammo/127x55.png", "smooth"),
        ["iconColor"] = Color(52, 53, 36, 155),

        ["sizeX"] = 1,
        ["sizeY"] = 1
    }

    EFGMITEMS["efgm_ammo_50bmg"] = {
        ["fullName"] = ".50 BMG",
        ["displayName"] = ".50",
        ["displayType"] = "Ammunition",
        ["weight"] = 0.1,
        ["value"] = 1300,
        ["equipType"] = EQUIPTYPE.Ammunition,
        ["appearInInventory"] = true,
        ["stackSize"] = 20,
        ["icon"] = Material("items/ammo/50bmg.png", "smooth"),
        ["iconColor"] = Color(52, 53, 36, 155),

        ["sizeX"] = 1,
        ["sizeY"] = 1
    }

    -- shotgun cartirdges
    EFGMITEMS["efgm_ammo_12gauge"] = {
        ["fullName"] = "12 gauge",
        ["displayName"] = "12/70",
        ["displayType"] = "Ammunition",
        ["weight"] = 0.05,
        ["value"] = 220,
        ["equipType"] = EQUIPTYPE.Ammunition,
        ["appearInInventory"] = true,
        ["stackSize"] = 20,
        ["icon"] = Material("items/ammo/12gauge.png", "smooth"),
        ["iconColor"] = Color(52, 53, 36, 155),

        ["sizeX"] = 1,
        ["sizeY"] = 1
    }

    EFGMITEMS["efgm_ammo_20gauge"] = {
        ["fullName"] = "20 gauge",
        ["displayName"] = "20/70",
        ["displayType"] = "Ammunition",
        ["weight"] = 0.04,
        ["value"] = 200,
        ["equipType"] = EQUIPTYPE.Ammunition,
        ["appearInInventory"] = true,
        ["stackSize"] = 20,
        ["icon"] = Material("items/ammo/20gauge.png", "smooth"),
        ["iconColor"] = Color(52, 53, 36, 155),

        ["sizeX"] = 1,
        ["sizeY"] = 1
    }

    EFGMITEMS["efgm_ammo_4gauge"] = {
        ["fullName"] = "23x75mmR",
        ["displayName"] = "23x75",
        ["displayType"] = "Ammunition",
        ["weight"] = 0.08,
        ["value"] = 420,
        ["equipType"] = EQUIPTYPE.Ammunition,
        ["appearInInventory"] = true,
        ["stackSize"] = 20,
        ["icon"] = Material("items/ammo/4gauge.png", "smooth"),
        ["iconColor"] = Color(52, 53, 36, 155),

        ["sizeX"] = 1,
        ["sizeY"] = 1
    }

    -- launcher cartirdges
    EFGMITEMS["efgm_ammo_40x46"] = {
        ["fullName"] = "40x46mm",
        ["displayName"] = "40x46",
        ["displayType"] = "Ammunition",
        ["weight"] = 0.23,
        ["value"] = 7000,
        ["equipType"] = EQUIPTYPE.Ammunition,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/ammo/40x46.png", "smooth"),
        ["iconColor"] = Color(52, 53, 36, 155),

        ["sizeX"] = 1,
        ["sizeY"] = 1
    }

    EFGMITEMS["efgm_ammo_40x53"] = {
        ["fullName"] = "40x53mm",
        ["displayName"] = "40x53",
        ["displayType"] = "Ammunition",
        ["weight"] = 0.25,
        ["value"] = 8000,
        ["equipType"] = EQUIPTYPE.Ammunition,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/ammo/40x53.png", "smooth"),
        ["iconColor"] = Color(52, 53, 36, 155),

        ["sizeX"] = 1,
        ["sizeY"] = 1
    }

    -- flare cartirdges
    EFGMITEMS["efgm_ammo_26x75"] = {
        ["fullName"] = "26x75mm",
        ["displayName"] = "26x75",
        ["displayType"] = "Ammunition",
        ["weight"] = 0.04,
        ["value"] = 5000,
        ["equipType"] = EQUIPTYPE.Ammunition,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/ammo/26x75.png", "smooth"),
        ["iconColor"] = Color(52, 53, 36, 155),

        ["sizeX"] = 1,
        ["sizeY"] = 1
    }

-- MEDICAL

    EFGMITEMS["efgm_meds_ai2"] = {
        ["fullName"] = "AI-2 medkit",
        ["displayName"] = "AI-2",
        ["displayType"] = "Medical",
        ["weight"] = 0.5,
        ["value"] = 5000,
        ["equipType"] = EQUIPTYPE.Consumable,
        ["consumableType"] = "heal",
        ["consumableValue"] = 20,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/meds/ai2.png", "smooth"),
        ["iconColor"] = Color(41, 33, 26, 155),

        ["sizeX"] = 1,
        ["sizeY"] = 1
    }

    EFGMITEMS["efgm_meds_ifak"] = {
        ["fullName"] = "IFAK individual first aid kit",
        ["displayName"] = "IFAK",
        ["displayType"] = "Medical",
        ["weight"] = 1,
        ["value"] = 12000,
        ["equipType"] = EQUIPTYPE.Consumable,
        ["consumableType"] = "heal",
        ["consumableValue"] = 60,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/meds/ifak.png", "smooth"),
        ["iconColor"] = Color(41, 33, 26, 155),

        ["sizeX"] = 1,
        ["sizeY"] = 1
    }

    EFGMITEMS["efgm_meds_salewa"] = {
        ["fullName"] = "Salewa first aid kit",
        ["displayName"] = "Salewa",
        ["displayType"] = "Medical",
        ["weight"] = 0.8,
        ["value"] = 20000,
        ["equipType"] = EQUIPTYPE.Consumable,
        ["consumableType"] = "heal",
        ["consumableValue"] = 100,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/meds/salewa.png", "smooth"),
        ["iconColor"] = Color(41, 33, 26, 155),

        ["sizeX"] = 1,
        ["sizeY"] = 2
    }

    EFGMITEMS["efgm_meds_grizzly"] = {
        ["fullName"] = "Grizzly medical kit",
        ["displayName"] = "Grizzly",
        ["displayType"] = "Medical",
        ["weight"] = 1.6,
        ["value"] = 35000,
        ["equipType"] = EQUIPTYPE.Consumable,
        ["consumableType"] = "heal",
        ["consumableValue"] = 200,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/meds/grizzly.png", "smooth"),
        ["iconColor"] = Color(41, 33, 26, 155),

        ["sizeX"] = 2,
        ["sizeY"] = 2
    }

-- KEYS

    EFGMITEMS["efgm_key_workshop_office"] = {
        ["fullName"] = "Workshop Office Key",
        ["displayName"] = "W. Office",
        ["displayType"] = "Key",
        ["weight"] = 0.2,
        ["value"] = 29000,
        ["equipType"] = EQUIPTYPE.None,
        ["consumableType"] = "key",
        ["consumableValue"] = 5,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/keys/civil.png", "smooth"),
        ["iconColor"] = Color(31, 38, 26, 155),

        ["sizeX"] = 1,
        ["sizeY"] = 1
    }

    EFGMITEMS["efgm_key_workshop_armory"] = {
        ["fullName"] = "Workshop Armory Key",
        ["displayName"] = "W. Armory",
        ["displayType"] = "Key",
        ["weight"] = 0.2,
        ["value"] = 42000,
        ["equipType"] = EQUIPTYPE.None,
        ["consumableType"] = "key",
        ["consumableValue"] = 5,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/keys/industrial.png", "smooth"),
        ["iconColor"] = Color(31, 38, 26, 155),

        ["sizeX"] = 1,
        ["sizeY"] = 1
    }

    EFGMITEMS["efgm_key_hotel_marked"] = {
        ["fullName"] = "Hotel Marked Room Key",
        ["displayName"] = "Hotel mrk.",
        ["displayType"] = "Key",
        ["weight"] = 0.2,
        ["value"] = 676767,
        ["equipType"] = EQUIPTYPE.None,
        ["consumableType"] = "key",
        ["consumableValue"] = 5,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/keys/industrial_marked.png", "smooth"),
        ["iconColor"] = Color(31, 38, 26, 155),

        ["sizeX"] = 1,
        ["sizeY"] = 1
    }

    EFGMITEMS["efgm_key_bigred_meeting"] = {
        ["fullName"] = "Big Red Meeting Room Key",
        ["displayName"] = "Br. Meeting",
        ["displayType"] = "Key",
        ["weight"] = 0.2,
        ["value"] = 42000,
        ["equipType"] = EQUIPTYPE.None,
        ["consumableType"] = "key",
        ["consumableValue"] = 5,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/keys/dorm.png", "smooth"),
        ["iconColor"] = Color(31, 38, 26, 155),

        ["sizeX"] = 1,
        ["sizeY"] = 1
    }

    EFGMITEMS["efgm_keycard_bunker_entrance"] = {
        ["fullName"] = "Bunker Entrance Keycard",
        ["displayName"] = "B. Door",
        ["displayType"] = "Key",
        ["weight"] = 0.2,
        ["value"] = 420690,
        ["equipType"] = EQUIPTYPE.None,
        ["consumableType"] = "key",
        ["consumableValue"] = 5,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/keys/keycard_green.png", "smooth"),
        ["iconColor"] = Color(31, 38, 26, 155),

        ["sizeX"] = 1,
        ["sizeY"] = 1
    }

    EFGMITEMS["efgm_keycard_bunker_armory"] = {
        ["fullName"] = "Bunker Armory Access Keycard",
        ["displayName"] = "B. Armory",
        ["displayType"] = "Key",
        ["weight"] = 0.2,
        ["value"] = 420690,
        ["equipType"] = EQUIPTYPE.None,
        ["consumableType"] = "key",
        ["consumableValue"] = 5,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/keys/keycard_dark_red.png", "smooth"),
        ["iconColor"] = Color(31, 38, 26, 155),

        ["sizeX"] = 1,
        ["sizeY"] = 1
    }

-- BARTER
    EFGMITEMS["efgm_barter_fireklean"] = {
        ["fullName"] = "#FireKlean gun lube",
        ["displayName"] = "#FireKlean",
        ["displayType"] = "Flammable",
        ["weight"] = 0.2,
        ["value"] = 22000,
        ["equipType"] = EQUIPTYPE.None,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/barter/fireklean.png", "smooth"),
        ["iconColor"] = Color(45, 37, 48, 155),

        ["sizeX"] = 1,
        ["sizeY"] = 1,

        ["canPurchase"] = false
    }

    EFGMITEMS["efgm_barter_aabattery"] = {
        ["fullName"] = "AA Battery",
        ["displayName"] = "AA batt.",
        ["displayType"] = "Energy",
        ["weight"] = 0.05,
        ["value"] = 1900,
        ["equipType"] = EQUIPTYPE.None,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/barter/aabattery.png", "smooth"),
        ["iconColor"] = Color(33, 43, 48, 155),

        ["sizeX"] = 1,
        ["sizeY"] = 1,

        ["canPurchase"] = false
    }

    EFGMITEMS["efgm_barter_mcc"] = {
        ["fullName"] = "Advanced Current Converter",
        ["displayName"] = "MCC",
        ["displayType"] = "Electronic",
        ["weight"] = 5,
        ["value"] = 189000,
        ["equipType"] = EQUIPTYPE.None,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/barter/mcc.png", "smooth"),
        ["iconColor"] = Color(45, 37, 48, 155),

        ["sizeX"] = 2,
        ["sizeY"] = 2,

        ["canPurchase"] = false
    }

    EFGMITEMS["efgm_barter_alkaline"] = {
        ["fullName"] = "Alkaline Cleaner",
        ["displayName"] = "Alkali",
        ["displayType"] = "Household",
        ["weight"] = 1,
        ["value"] = 5100,
        ["equipType"] = EQUIPTYPE.None,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/barter/alkali.png", "smooth"),

        ["sizeX"] = 1,
        ["sizeY"] = 2,

        ["canPurchase"] = false
    }

    EFGMITEMS["efgm_barter_thermometer"] = {
        ["fullName"] = "Analog Thermometer",
        ["displayName"] = "Therm.",
        ["displayType"] = "Building",
        ["weight"] = 0.3,
        ["value"] = 28500,
        ["equipType"] = EQUIPTYPE.None,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/barter/thermometer.png", "smooth"),
        ["iconColor"] = Color(45, 37, 48, 155),

        ["sizeX"] = 1,
        ["sizeY"] = 2,

        ["canPurchase"] = false
    }

    EFGMITEMS["efgm_barter_teapot"] = {
        ["fullName"] = "Antique Teapot",
        ["displayName"] = "Teapot",
        ["displayType"] = "Valuable",
        ["weight"] = 1.1,
        ["value"] = 29200,
        ["equipType"] = EQUIPTYPE.None,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/barter/teapot.png", "smooth"),
        ["iconColor"] = Color(45, 37, 48, 155),

        ["sizeX"] = 1,
        ["sizeY"] = 2,

        ["canPurchase"] = false
    }

    EFGMITEMS["efgm_barter_vase"] = {
        ["fullName"] = "Antique Vase",
        ["displayName"] = "Vase",
        ["displayType"] = "Valuable",
        ["weight"] = 2,
        ["value"] = 40000,
        ["equipType"] = EQUIPTYPE.None,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/barter/vase.png", "smooth"),
        ["iconColor"] = Color(45, 37, 48, 155),

        ["sizeX"] = 2,
        ["sizeY"] = 2,

        ["canPurchase"] = false
    }

    EFGMITEMS["efgm_barter_apollo"] = {
        ["fullName"] = "Apollo Soyuz Cigarettes",
        ["displayName"] = "Apollo",
        ["displayType"] = "Other",
        ["weight"] = 0.05,
        ["value"] = 1575,
        ["equipType"] = EQUIPTYPE.None,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/barter/apollo.png", "smooth"),
        ["iconColor"] = Color(33, 43, 48, 155),

        ["sizeX"] = 1,
        ["sizeY"] = 1,

        ["canPurchase"] = false
    }

    EFGMITEMS["efgm_barter_aquapeps"] = {
        ["fullName"] = "Aquapeps Water Purification Tablets",
        ["displayName"] = "Aquapeps",
        ["displayType"] = "Medicine",
        ["weight"] = 1.1,
        ["value"] = 14050,
        ["equipType"] = EQUIPTYPE.None,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/barter/aquapeps.png", "smooth"),
        ["iconColor"] = Color(33, 43, 48, 155),

        ["sizeX"] = 1,
        ["sizeY"] = 1,

        ["canPurchase"] = false
    }

    EFGMITEMS["efgm_barter_aramid"] = {
        ["fullName"] = "Aramid Fiber Fabric",
        ["displayName"] = "Aramid",
        ["displayType"] = "Other",
        ["weight"] = 0.15,
        ["value"] = 5600,
        ["equipType"] = EQUIPTYPE.None,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/barter/aramid.png", "smooth"),
        ["iconColor"] = Color(33, 43, 48, 155),

        ["sizeX"] = 2,
        ["sizeY"] = 1,

        ["canPurchase"] = false
    }

    EFGMITEMS["efgm_barter_awl"] = {
        ["fullName"] = "Awl",
        ["displayName"] = "Awl",
        ["displayType"] = "Tool",
        ["weight"] = 0.1,
        ["value"] = 9400,
        ["equipType"] = EQUIPTYPE.None,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/barter/awl.png", "smooth"),
        ["iconColor"] = Color(33, 43, 48, 155),

        ["sizeX"] = 1,
        ["sizeY"] = 1,

        ["canPurchase"] = false
    }

    EFGMITEMS["efgm_barter_axel"] = {
        ["fullName"] = "Axel Parrot Figurine",
        ["displayName"] = "Axel",
        ["displayType"] = "Valuable",
        ["weight"] = 0.35,
        ["value"] = 26500,
        ["equipType"] = EQUIPTYPE.None,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/barter/axel.png", "smooth"),
        ["iconColor"] = Color(45, 37, 48, 155),

        ["sizeX"] = 1,
        ["sizeY"] = 2,

        ["canPurchase"] = false
    }

    EFGMITEMS["efgm_barter_bearbuddy"] = {
        ["fullName"] = "BEAR Buddy Plush Toy",
        ["displayName"] = "BEAR Buddy",
        ["displayType"] = "Other",
        ["weight"] = 0.35,
        ["value"] = 52050,
        ["equipType"] = EQUIPTYPE.None,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/barter/bearbuddy.png", "smooth"),
        ["iconColor"] = Color(45, 37, 48, 155),

        ["sizeX"] = 2,
        ["sizeY"] = 2,

        ["canPurchase"] = false
    }

    EFGMITEMS["efgm_barter_bearfigurine"] = {
        ["fullName"] = "BEAR Operative Figurine",
        ["displayName"] = "BEAR",
        ["displayType"] = "Valuable",
        ["weight"] = 0.2,
        ["value"] = 38900,
        ["equipType"] = EQUIPTYPE.None,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/barter/bearfigurine.png", "smooth"),
        ["iconColor"] = Color(45, 37, 48, 155),

        ["sizeX"] = 1,
        ["sizeY"] = 2,

        ["canPurchase"] = false
    }

    EFGMITEMS["efgm_barter_bakeezy"] = {
        ["fullName"] = "BakeEzy Cook Book",
        ["displayName"] = "BakeEzy",
        ["displayType"] = "Information",
        ["weight"] = 0.25,
        ["value"] = 17400,
        ["equipType"] = EQUIPTYPE.None,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/barter/bakeezy.png", "smooth"),
        ["iconColor"] = Color(45, 37, 48, 155),

        ["sizeX"] = 1,
        ["sizeY"] = 2,

        ["canPurchase"] = false
    }

    EFGMITEMS["efgm_barter_book"] = {
        ["fullName"] = "Battered Antique Book",
        ["displayName"] = "Book",
        ["displayType"] = "Valuable",
        ["weight"] = 0.4,
        ["value"] = 30885,
        ["equipType"] = EQUIPTYPE.None,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/barter/book.png", "smooth"),
        ["iconColor"] = Color(45, 37, 48, 155),

        ["sizeX"] = 1,
        ["sizeY"] = 2,

        ["canPurchase"] = false
    }

    EFGMITEMS["efgm_barter_bolts"] = {
        ["fullName"] = "Bolts",
        ["displayName"] = "Bolts",
        ["displayType"] = "Building",
        ["weight"] = 0.4,
        ["value"] = 6950,
        ["equipType"] = EQUIPTYPE.None,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/barter/bolts.png", "smooth"),
        ["iconColor"] = Color(33, 43, 48, 155),

        ["sizeX"] = 1,
        ["sizeY"] = 1,

        ["canPurchase"] = false
    }

    EFGMITEMS["efgm_barter_vitamins"] = {
        ["fullName"] = "Bottle Of OLOLO Multivitamins",
        ["displayName"] = "Vitamins",
        ["displayType"] = "Medicine",
        ["weight"] = 0.2,
        ["value"] = 8500,
        ["equipType"] = EQUIPTYPE.None,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/barter/vitamins.png", "smooth"),
        ["iconColor"] = Color(33, 43, 48, 155),

        ["sizeX"] = 1,
        ["sizeY"] = 1,

        ["canPurchase"] = false
    }

    EFGMITEMS["efgm_barter_h2o2"] = {
        ["fullName"] = "Bottle Of Hydrogen Peroxide",
        ["displayName"] = "H2O2",
        ["displayType"] = "Medicine",
        ["weight"] = 0.1,
        ["value"] = 5995,
        ["equipType"] = EQUIPTYPE.None,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/barter/h2o2.png", "smooth"),
        ["iconColor"] = Color(33, 43, 48, 155),

        ["sizeX"] = 1,
        ["sizeY"] = 1,

        ["canPurchase"] = false
    }

    EFGMITEMS["efgm_barter_nacl"] = {
        ["fullName"] = "Bottle Of Saline Solution",
        ["displayName"] = "NaCl",
        ["displayType"] = "Medicine",
        ["weight"] = 0.3,
        ["value"] = 5360,
        ["equipType"] = EQUIPTYPE.None,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/barter/nacl.png", "smooth"),
        ["iconColor"] = Color(33, 43, 48, 155),

        ["sizeX"] = 1,
        ["sizeY"] = 1,

        ["canPurchase"] = false
    }

    EFGMITEMS["efgm_barter_brokengpx"] = {
        ["fullName"] = "Broken GPhone X Smartphone",
        ["displayName"] = "GPX",
        ["displayType"] = "Electronic",
        ["weight"] = 0.3,
        ["value"] = 14600,
        ["equipType"] = EQUIPTYPE.None,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/barter/brokengpx.png", "smooth"),
        ["iconColor"] = Color(33, 43, 48, 155),

        ["sizeX"] = 1,
        ["sizeY"] = 1,

        ["canPurchase"] = false
    }

    EFGMITEMS["efgm_barter_brokengphone"] = {
        ["fullName"] = "Broken GPhone Smartphone",
        ["displayName"] = "GPhone",
        ["displayType"] = "Electronic",
        ["weight"] = 0.3,
        ["value"] = 10040,
        ["equipType"] = EQUIPTYPE.None,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/barter/brokengphone.png", "smooth"),
        ["iconColor"] = Color(33, 43, 48, 155),

        ["sizeX"] = 1,
        ["sizeY"] = 1,

        ["canPurchase"] = false
    }

    EFGMITEMS["efgm_barter_brokenlcd"] = {
        ["fullName"] = "Broken LCD",
        ["displayName"] = "BrokenLCD",
        ["displayType"] = "Electronic",
        ["weight"] = 0.05,
        ["value"] = 7000,
        ["equipType"] = EQUIPTYPE.None,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/barter/brokenlcd.png", "smooth"),
        ["iconColor"] = Color(33, 43, 48, 155),

        ["sizeX"] = 1,
        ["sizeY"] = 2,

        ["canPurchase"] = false
    }

    EFGMITEMS["efgm_barter_lion"] = {
        ["fullName"] = "Bronze Lion Figurine",
        ["displayName"] = "Lion",
        ["displayType"] = "Valuable",
        ["weight"] = 7.2,
        ["value"] = 142010,
        ["equipType"] = EQUIPTYPE.None,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/barter/lion.png", "smooth"),
        ["iconColor"] = Color(33, 43, 48, 155),

        ["sizeX"] = 3,
        ["sizeY"] = 2,

        ["canPurchase"] = false
    }

    EFGMITEMS["efgm_barter_bulbex"] = {
        ["fullName"] = "Bulbex Cable Cutter",
        ["displayName"] = "Bulbex",
        ["displayType"] = "Tool",
        ["weight"] = 0.55,
        ["value"] = 52500,
        ["equipType"] = EQUIPTYPE.None,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/barter/bulbex.png", "smooth"),
        ["iconColor"] = Color(45, 37, 48, 155),

        ["sizeX"] = 1,
        ["sizeY"] = 2,

        ["canPurchase"] = false
    }

    EFGMITEMS["efgm_barter_wires"] = {
        ["fullName"] = "Bundle Of Wires",
        ["displayName"] = "Wires",
        ["displayType"] = "Electronic",
        ["weight"] = 0.25,
        ["value"] = 4995,
        ["equipType"] = EQUIPTYPE.None,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/barter/wires.png", "smooth"),
        ["iconColor"] = Color(33, 43, 48, 155),

        ["sizeX"] = 1,
        ["sizeY"] = 1,

        ["canPurchase"] = false
    }

    EFGMITEMS["efgm_barter_cpufan"] = {
        ["fullName"] = "CPU Fan",
        ["displayName"] = "CPU Fan",
        ["displayType"] = "Electronic",
        ["weight"] = 0.1,
        ["value"] = 3100,
        ["equipType"] = EQUIPTYPE.None,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/barter/cpufan.png", "smooth"),
        ["iconColor"] = Color(33, 43, 48, 155),

        ["sizeX"] = 1,
        ["sizeY"] = 1,

        ["canPurchase"] = false
    }

    EFGMITEMS["efgm_barter_drlupos"] = {
        ["fullName"] = "Can Of Dr. Lupo's Coffee Beans",
        ["displayName"] = "DrLupo's",
        ["displayType"] = "Other",
        ["weight"] = 0.5,
        ["value"] = 16600,
        ["equipType"] = EQUIPTYPE.None,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/barter/drlupos.png", "smooth"),
        ["iconColor"] = Color(45, 37, 48, 155),

        ["sizeX"] = 1,
        ["sizeY"] = 1,

        ["canPurchase"] = false
    }

    EFGMITEMS["efgm_barter_majaica"] = {
        ["fullName"] = "Can Of Majaica Coffee Beans",
        ["displayName"] = "Majaica",
        ["displayType"] = "Other",
        ["weight"] = 0.35,
        ["value"] = 9435,
        ["equipType"] = EQUIPTYPE.None,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/barter/majaica.png", "smooth"),
        ["iconColor"] = Color(33, 43, 48, 155),

        ["sizeX"] = 1,
        ["sizeY"] = 1,

        ["canPurchase"] = false
    }

    EFGMITEMS["efgm_barter_ratcola"] = {
        ["fullName"] = "Can Of RatCola Soda",
        ["displayName"] = "RatCola",
        ["displayType"] = "Medicine",
        ["weight"] = 0.35,
        ["value"] = 16000,
        ["equipType"] = EQUIPTYPE.None,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/barter/ratcola.png", "smooth"),
        ["iconColor"] = Color(45, 37, 48, 155),

        ["sizeX"] = 1,
        ["sizeY"] = 1,

        ["canPurchase"] = false
    }

    EFGMITEMS["efgm_barter_thermite"] = {
        ["fullName"] = "Can Of Thermite",
        ["displayName"] = "Thermite",
        ["displayType"] = "Flammable",
        ["weight"] = 0.65,
        ["value"] = 19900,
        ["equipType"] = EQUIPTYPE.None,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/barter/thermite.png", "smooth"),
        ["iconColor"] = Color(33, 43, 48, 155),

        ["sizeX"] = 1,
        ["sizeY"] = 1,

        ["canPurchase"] = false
    }

    EFGMITEMS["efgm_barter_salt"] = {
        ["fullName"] = "Can Of White Salt",
        ["displayName"] = "Salt",
        ["displayType"] = "Household",
        ["weight"] = 0.25,
        ["value"] = 5040,
        ["equipType"] = EQUIPTYPE.None,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/barter/salt.png", "smooth"),

        ["sizeX"] = 1,
        ["sizeY"] = 1,

        ["canPurchase"] = false
    }

    EFGMITEMS["efgm_barter_superwater"] = {
        ["fullName"] = "Canister With Purified Water",
        ["displayName"] = "Superwater",
        ["displayType"] = "Medicine",
        ["weight"] = 3.3,
        ["value"] = 40000,
        ["equipType"] = EQUIPTYPE.None,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/barter/superwater.png", "smooth"),
        ["iconColor"] = Color(45, 37, 48, 155),

        ["sizeX"] = 2,
        ["sizeY"] = 2,

        ["canPurchase"] = false
    }

    EFGMITEMS["efgm_barter_caps"] = {
        ["fullName"] = "Capacitors",
        ["displayName"] = "Caps",
        ["displayType"] = "Electronic",
        ["weight"] = 0.1,
        ["value"] = 2450,
        ["equipType"] = EQUIPTYPE.None,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/barter/caps.png", "smooth"),
        ["iconColor"] = Color(33, 43, 48, 155),

        ["sizeX"] = 1,
        ["sizeY"] = 1,

        ["canPurchase"] = false
    }

    EFGMITEMS["efgm_barter_carbattery"] = {
        ["fullName"] = "Car Battery",
        ["displayName"] = "Car Battery",
        ["displayType"] = "Energy",
        ["weight"] = 12,
        ["value"] = 98000,
        ["equipType"] = EQUIPTYPE.None,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/barter/carbattery.png", "smooth"),
        ["iconColor"] = Color(33, 43, 48, 155),

        ["sizeX"] = 3,
        ["sizeY"] = 2,

        ["canPurchase"] = false
    }

    EFGMITEMS["efgm_barter_cat"] = {
        ["fullName"] = "Cat Figurine",
        ["displayName"] = "Cat",
        ["displayType"] = "Valuable",
        ["weight"] = 3.1,
        ["value"] = 39200,
        ["equipType"] = EQUIPTYPE.None,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/barter/cat.png", "smooth"),
        ["iconColor"] = Color(33, 43, 48, 155),

        ["sizeX"] = 1,
        ["sizeY"] = 3,

        ["canPurchase"] = false
    }

    EFGMITEMS["efgm_barter_prokill"] = {
        ["fullName"] = "Chain With Prokill Medallion",
        ["displayName"] = "Prokill",
        ["displayType"] = "Valuable",
        ["weight"] = 0.1,
        ["value"] = 53550,
        ["equipType"] = EQUIPTYPE.None,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/barter/prokill.png", "smooth"),
        ["iconColor"] = Color(45, 37, 48, 155),

        ["sizeX"] = 1,
        ["sizeY"] = 1,

        ["canPurchase"] = false
    }

    EFGMITEMS["efgm_barter_chainlet"] = {
        ["fullName"] = "Chainlet",
        ["displayName"] = "Chainlet",
        ["displayType"] = "Valuable",
        ["weight"] = 0.1,
        ["value"] = 5000,
        ["equipType"] = EQUIPTYPE.None,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/barter/chainlet.png", "smooth"),
        ["iconColor"] = Color(33, 43, 48, 155),

        ["sizeX"] = 1,
        ["sizeY"] = 1,

        ["canPurchase"] = false
    }

    EFGMITEMS["efgm_barter_ornament"] = {
        ["fullName"] = "Christmas Tree Ornament",
        ["displayName"] = "Ornament",
        ["displayType"] = "Valuable",
        ["weight"] = 0.05,
        ["value"] = 9450,
        ["equipType"] = EQUIPTYPE.None,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/barter/ornament.png", "smooth"),
        ["iconColor"] = Color(33, 43, 48, 155),

        ["sizeX"] = 1,
        ["sizeY"] = 1,

        ["canPurchase"] = false
    }

    EFGMITEMS["efgm_barter_matches"] = {
        ["fullName"] = "Classic Matches",
        ["displayName"] = "Matches",
        ["displayType"] = "Flammable",
        ["weight"] = 0.05,
        ["value"] = 1370,
        ["equipType"] = EQUIPTYPE.None,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/barter/matches.png", "smooth"),
        ["iconColor"] = Color(33, 43, 48, 155),

        ["sizeX"] = 1,
        ["sizeY"] = 1,

        ["canPurchase"] = false
    }

    EFGMITEMS["efgm_barter_clin"] = {
        ["fullName"] = "Clin Window Cleaner",
        ["displayName"] = "Clin",
        ["displayType"] = "Household",
        ["weight"] = 0.5,
        ["value"] = 4480,
        ["equipType"] = EQUIPTYPE.None,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/barter/clin.png", "smooth"),

        ["sizeX"] = 1,
        ["sizeY"] = 2,

        ["canPurchase"] = false
    }

    EFGMITEMS["efgm_barter_mtape"] = {
        ["fullName"] = "Construction Measuring Tape",
        ["displayName"] = "MTape",
        ["displayType"] = "Tool",
        ["weight"] = 0.15,
        ["value"] = 2320,
        ["equipType"] = EQUIPTYPE.None,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/barter/mtape.png", "smooth"),
        ["iconColor"] = Color(33, 43, 48, 155),

        ["sizeX"] = 1,
        ["sizeY"] = 1,

        ["canPurchase"] = false
    }

    EFGMITEMS["efgm_barter_cordura"] = {
        ["fullName"] = "Cordura Polyamide Fabric",
        ["displayName"] = "Cordura",
        ["displayType"] = "Other",
        ["weight"] = 0.1,
        ["value"] = 8330,
        ["equipType"] = EQUIPTYPE.None,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/barter/cordura.png", "smooth"),
        ["iconColor"] = Color(33, 43, 48, 155),

        ["sizeX"] = 2,
        ["sizeY"] = 1,

        ["canPurchase"] = false
    }

    EFGMITEMS["efgm_barter_hose"] = {
        ["fullName"] = "Corrugated Hose",
        ["displayName"] = "Hose",
        ["displayType"] = "Building",
        ["weight"] = 0.6,
        ["value"] = 70000,
        ["equipType"] = EQUIPTYPE.None,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/barter/hose.png", "smooth"),
        ["iconColor"] = Color(33, 43, 48, 155),

        ["sizeX"] = 2,
        ["sizeY"] = 1,

        ["canPurchase"] = false
    }

    EFGMITEMS["efgm_barter_crickent"] = {
        ["fullName"] = "Crickent Lighter",
        ["displayName"] = "Crickent",
        ["displayType"] = "Flammable",
        ["weight"] = 0.05,
        ["value"] = 800,
        ["equipType"] = EQUIPTYPE.None,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/barter/crickent.png", "smooth"),
        ["iconColor"] = Color(33, 43, 48, 155),

        ["sizeX"] = 1,
        ["sizeY"] = 1,

        ["canPurchase"] = false
    }

    EFGMITEMS["efgm_barter_cultistfigurine"] = {
        ["fullName"] = "Cultist Figurine",
        ["displayName"] = "Cultist",
        ["displayType"] = "Valuable",
        ["weight"] = 0.2,
        ["value"] = 63000,
        ["equipType"] = EQUIPTYPE.None,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/barter/cultistfigurine.png", "smooth"),
        ["iconColor"] = Color(45, 37, 48, 155),

        ["sizeX"] = 1,
        ["sizeY"] = 2,

        ["canPurchase"] = false
    }

    EFGMITEMS["efgm_barter_cyclon"] = {
        ["fullName"] = "Cyclon Rechargeable Battery",
        ["displayName"] = "Cyclon",
        ["displayType"] = "Energy",
        ["weight"] = 1.7,
        ["value"] = 53500,
        ["equipType"] = EQUIPTYPE.None,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/barter/cyclon.png", "smooth"),
        ["iconColor"] = Color(45, 37, 48, 155),

        ["sizeX"] = 2,
        ["sizeY"] = 1,

        ["canPurchase"] = false
    }

    EFGMITEMS["efgm_barter_dbattery"] = {
        ["fullName"] = "D Size Battery",
        ["displayName"] = "D batt.",
        ["displayType"] = "Energy",
        ["weight"] = 0.05,
        ["value"] = 1390,
        ["equipType"] = EQUIPTYPE.None,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/barter/dbattery.png", "smooth"),
        ["iconColor"] = Color(33, 43, 48, 155),

        ["sizeX"] = 1,
        ["sizeY"] = 1,

        ["canPurchase"] = false
    }

    EFGMITEMS["efgm_barter_dvd"] = {
        ["fullName"] = "DVD Drive",
        ["displayName"] = "DVD",
        ["displayType"] = "Electronic",
        ["weight"] = 0.6,
        ["value"] = 5225,
        ["equipType"] = EQUIPTYPE.None,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/barter/dvd.png", "smooth"),
        ["iconColor"] = Color(33, 43, 48, 155),

        ["sizeX"] = 2,
        ["sizeY"] = 1,

        ["canPurchase"] = false
    }

    EFGMITEMS["efgm_barter_hdd"] = {
        ["fullName"] = "Damaged Hard Drive",
        ["displayName"] = "HDD",
        ["displayType"] = "Electronic",
        ["weight"] = 0.25,
        ["value"] = 4710,
        ["equipType"] = EQUIPTYPE.None,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/barter/hdd.png", "smooth"),
        ["iconColor"] = Color(33, 43, 48, 155),

        ["sizeX"] = 2,
        ["sizeY"] = 1,

        ["canPurchase"] = false
    }

    EFGMITEMS["efgm_barter_beardoil"] = {
        ["fullName"] = "Deadlyslob's Beard Oil",
        ["displayName"] = "BeardOil",
        ["displayType"] = "Household",
        ["weight"] = 0.05,
        ["value"] = 33000,
        ["equipType"] = EQUIPTYPE.None,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/barter/beardoil.png", "smooth"),
        ["iconColor"] = Color(45, 37, 48, 155),

        ["sizeX"] = 1,
        ["sizeY"] = 1,

        ["canPurchase"] = false
    }

    EFGMITEMS["efgm_barter_dedmorozfigurine"] = {
        ["fullName"] = "Ded Moroz Figurine",
        ["displayName"] = "Ded Moroz",
        ["displayType"] = "Valuable",
        ["weight"] = 0.2,
        ["value"] = 49000,
        ["equipType"] = EQUIPTYPE.None,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/barter/dedmorozfigurine.png", "smooth"),
        ["iconColor"] = Color(45, 37, 48, 155),

        ["sizeX"] = 1,
        ["sizeY"] = 2,

        ["canPurchase"] = false
    }

    EFGMITEMS["efgm_barter_diary"] = {
        ["fullName"] = "Diary",
        ["displayName"] = "Diary",
        ["displayType"] = "Information",
        ["weight"] = 0.2,
        ["value"] = 38000,
        ["equipType"] = EQUIPTYPE.None,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/barter/diary.png", "smooth"),
        ["iconColor"] = Color(33, 43, 48, 155),

        ["sizeX"] = 1,
        ["sizeY"] = 2,

        ["canPurchase"] = false
    }

    EFGMITEMS["efgm_barter_syringe"] = {
        ["fullName"] = "Disposable Syringe",
        ["displayName"] = "Syringe",
        ["displayType"] = "Medicine",
        ["weight"] = 0.05,
        ["value"] = 5125,
        ["equipType"] = EQUIPTYPE.None,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/barter/syringe.png", "smooth"),
        ["iconColor"] = Color(33, 43, 48, 155),

        ["sizeX"] = 1,
        ["sizeY"] = 1,

        ["canPurchase"] = false
    }

    EFGMITEMS["efgm_barter_dfuel"] = {
        ["fullName"] = "Dry Fuel",
        ["displayName"] = "DFuel",
        ["displayType"] = "Flammable",
        ["weight"] = 0.1,
        ["value"] = 12650,
        ["equipType"] = EQUIPTYPE.None,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/barter/dfuel.png", "smooth"),
        ["iconColor"] = Color(33, 43, 48, 155),

        ["sizeX"] = 1,
        ["sizeY"] = 1,

        ["canPurchase"] = false
    }

    EFGMITEMS["efgm_barter_ducttape"] = {
        ["fullName"] = "Duct Tape",
        ["displayName"] = "Duct Tape",
        ["displayType"] = "Building",
        ["weight"] = 0.1,
        ["value"] = 1495,
        ["equipType"] = EQUIPTYPE.None,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/barter/ducttape.png", "smooth"),
        ["iconColor"] = Color(33, 43, 48, 155),

        ["sizeX"] = 1,
        ["sizeY"] = 1,

        ["canPurchase"] = false
    }

    EFGMITEMS["efgm_barter_drill"] = {
        ["fullName"] = "Electric Drill",
        ["displayName"] = "Drill",
        ["displayType"] = "Electronic",
        ["weight"] = 1.2,
        ["value"] = 18480,
        ["equipType"] = EQUIPTYPE.None,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/barter/drill.png", "smooth"),
        ["iconColor"] = Color(33, 43, 48, 155),

        ["sizeX"] = 2,
        ["sizeY"] = 2,

        ["canPurchase"] = false
    }

    EFGMITEMS["efgm_barter_motor"] = {
        ["fullName"] = "Electric Motor",
        ["displayName"] = "Motor",
        ["displayType"] = "Electronic",
        ["weight"] = 1.4,
        ["value"] = 24070,
        ["equipType"] = EQUIPTYPE.None,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/barter/motor.png", "smooth"),
        ["iconColor"] = Color(33, 43, 48, 155),

        ["sizeX"] = 2,
        ["sizeY"] = 2,

        ["canPurchase"] = false
    }

    EFGMITEMS["efgm_barter_ec"] = {
        ["fullName"] = "Electronic Components",
        ["displayName"] = "EC",
        ["displayType"] = "Electronic",
        ["weight"] = 0.1,
        ["value"] = 11300,
        ["equipType"] = EQUIPTYPE.None,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/barter/ec.png", "smooth"),
        ["iconColor"] = Color(33, 43, 48, 155),

        ["sizeX"] = 1,
        ["sizeY"] = 1,

        ["canPurchase"] = false
    }

    EFGMITEMS["efgm_barter_eslamp"] = {
        ["fullName"] = "Energy-saving Lamp",
        ["displayName"] = "ES Lamp",
        ["displayType"] = "Electronic",
        ["weight"] = 0.2,
        ["value"] = 6800,
        ["equipType"] = EQUIPTYPE.None,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/barter/eslamp.png", "smooth"),
        ["iconColor"] = Color(33, 43, 48, 155),

        ["sizeX"] = 1,
        ["sizeY"] = 1,

        ["canPurchase"] = false
    }

    EFGMITEMS["efgm_barter_fuel"] = {
        ["fullName"] = "Expeditionary Fuel Tank",
        ["displayName"] = "Fuel",
        ["displayType"] = "Flammable",
        ["weight"] = 5.6,
        ["value"] = 31500,
        ["equipType"] = EQUIPTYPE.None,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/barter/fuel.png", "smooth"),
        ["iconColor"] = Color(33, 43, 48, 155),

        ["sizeX"] = 2,
        ["sizeY"] = 2,

        ["canPurchase"] = false
    }

    EFGMITEMS["efgm_barter_fp100"] = {
        ["fullName"] = "FP-100 Filter Absorber",
        ["displayName"] = "FP-100",
        ["displayType"] = "Other",
        ["weight"] = 13,
        ["value"] = 88000,
        ["equipType"] = EQUIPTYPE.None,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/barter/fp100.png", "smooth"),
        ["iconColor"] = Color(33, 43, 48, 155),

        ["sizeX"] = 3,
        ["sizeY"] = 3,

        ["canPurchase"] = false
    }

    EFGMITEMS["efgm_barter_gpsa"] = {
        ["fullName"] = "Far-forward GPS Signal Amplifier Unit",
        ["displayName"] = "GPSA",
        ["displayType"] = "Electronic",
        ["weight"] = 0.4,
        ["value"] = 210900,
        ["equipType"] = EQUIPTYPE.None,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/barter/gpsa.png", "smooth"),
        ["iconColor"] = Color(45, 37, 48, 155),

        ["sizeX"] = 1,
        ["sizeY"] = 1,

        ["canPurchase"] = false
    }

    EFGMITEMS["efgm_barter_fscdr"] = {
        ["fullName"] = "Flat Screwdriver",
        ["displayName"] = "F scdr.",
        ["displayType"] = "Tool",
        ["weight"] = 0.3,
        ["value"] = 7840,
        ["equipType"] = EQUIPTYPE.None,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/barter/fscdr.png", "smooth"),
        ["iconColor"] = Color(33, 43, 48, 155),

        ["sizeX"] = 1,
        ["sizeY"] = 1,

        ["canPurchase"] = false
    }

    EFGMITEMS["efgm_barter_landfscdr"] = {
        ["fullName"] = "Flat Screwdriver (Long)",
        ["displayName"] = "L&F scdr.",
        ["displayType"] = "Tool",
        ["weight"] = 0.35,
        ["value"] = 9900,
        ["equipType"] = EQUIPTYPE.None,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/barter/landfscdr.png", "smooth"),
        ["iconColor"] = Color(33, 43, 48, 155),

        ["sizeX"] = 1,
        ["sizeY"] = 2,

        ["canPurchase"] = false
    }

    EFGMITEMS["efgm_barter_fleece"] = {
        ["fullName"] = "Fleece Fabric",
        ["displayName"] = "Fleece",
        ["displayType"] = "Other",
        ["weight"] = 0.05,
        ["value"] = 2520,
        ["equipType"] = EQUIPTYPE.None,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/barter/fleece.png", "smooth"),
        ["iconColor"] = Color(33, 43, 48, 155),

        ["sizeX"] = 2,
        ["sizeY"] = 1,

        ["canPurchase"] = false
    }

    EFGMITEMS["efgm_barter_fcond"] = {
        ["fullName"] = "Fuel Conditioner",
        ["displayName"] = "FCond",
        ["displayType"] = "Flammable",
        ["weight"] = 1.4,
        ["value"] = 36325,
        ["equipType"] = EQUIPTYPE.None,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/barter/fcond.png", "smooth"),
        ["iconColor"] = Color(33, 43, 48, 155),

        ["sizeX"] = 1,
        ["sizeY"] = 2,

        ["canPurchase"] = false
    }

    EFGMITEMS["efgm_barter_ewunit"] = {
        ["fullName"] = "GARY ZONT Portable Electronic Warfare Device",
        ["displayName"] = "EW Unit",
        ["displayType"] = "Electronic",
        ["weight"] = 0.8,
        ["value"] = 84000,
        ["equipType"] = EQUIPTYPE.None,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/barter/ewunit.png", "smooth"),
        ["iconColor"] = Color(45, 37, 48, 155),

        ["sizeX"] = 1,
        ["sizeY"] = 2,

        ["canPurchase"] = false
    }

    EFGMITEMS["efgm_barter_gasan"] = {
        ["fullName"] = "Gas Analyzer",
        ["displayName"] = "GasAn",
        ["displayType"] = "Electronic",
        ["weight"] = 0.4,
        ["value"] = 13660,
        ["equipType"] = EQUIPTYPE.None,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/barter/gasan.png", "smooth"),
        ["iconColor"] = Color(33, 43, 48, 155),

        ["sizeX"] = 1,
        ["sizeY"] = 2,

        ["canPurchase"] = false
    }

    EFGMITEMS["efgm_barter_filter"] = {
        ["fullName"] = "Gas Mask Air Filter",
        ["displayName"] = "Filter",
        ["displayType"] = "Other",
        ["weight"] = 0.5,
        ["value"] = 6320,
        ["equipType"] = EQUIPTYPE.None,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/barter/filter.png", "smooth"),
        ["iconColor"] = Color(33, 43, 48, 155),

        ["sizeX"] = 2,
        ["sizeY"] = 1,

        ["canPurchase"] = false
    }

    EFGMITEMS["efgm_barter_gmcount"] = {
        ["fullName"] = "Geiger-Muller Counter",
        ["displayName"] = "GMcount",
        ["displayType"] = "Electronic",
        ["weight"] = 0.4,
        ["value"] = 10530,
        ["equipType"] = EQUIPTYPE.None,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/barter/gmcount.png", "smooth"),
        ["iconColor"] = Color(33, 43, 48, 155),

        ["sizeX"] = 1,
        ["sizeY"] = 2,

        ["canPurchase"] = false
    }

    EFGMITEMS["efgm_barter_skull"] = {
        ["fullName"] = "Gold Skull Ring",
        ["displayName"] = "Skull",
        ["displayType"] = "Valuable",
        ["weight"] = 0.05,
        ["value"] = 41000,
        ["equipType"] = EQUIPTYPE.None,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/barter/skull.png", "smooth"),
        ["iconColor"] = Color(45, 37, 48, 155),

        ["sizeX"] = 1,
        ["sizeY"] = 1,

        ["canPurchase"] = false
    }

    EFGMITEMS["efgm_barter_1gphone"] = {
        ["fullName"] = "Golden 1GPhone Smartphone",
        ["displayName"] = "1GPhone",
        ["displayType"] = "Electronic",
        ["weight"] = 0.3,
        ["value"] = 28105,
        ["equipType"] = EQUIPTYPE.None,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/barter/1gphone.png", "smooth"),
        ["iconColor"] = Color(45, 37, 48, 155),

        ["sizeX"] = 1,
        ["sizeY"] = 1,

        ["canPurchase"] = false
    }

    EFGMITEMS["efgm_barter_egg"] = {
        ["fullName"] = "Golden Egg",
        ["displayName"] = "Egg",
        ["displayType"] = "Valuable",
        ["weight"] = 0.2,
        ["value"] = 42840,
        ["equipType"] = EQUIPTYPE.None,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/barter/egg.png", "smooth"),
        ["iconColor"] = Color(45, 37, 48, 155),

        ["sizeX"] = 1,
        ["sizeY"] = 1,

        ["canPurchase"] = false
    }

    EFGMITEMS["efgm_barter_goldchain"] = {
        ["fullName"] = "Golden Neck Chain",
        ["displayName"] = "GoldChain",
        ["displayType"] = "Valuable",
        ["weight"] = 0.1,
        ["value"] = 24000,
        ["equipType"] = EQUIPTYPE.None,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/barter/goldchain.png", "smooth"),
        ["iconColor"] = Color(33, 43, 48, 155),

        ["sizeX"] = 1,
        ["sizeY"] = 1,

        ["canPurchase"] = false
    }

    EFGMITEMS["efgm_barter_rooster"] = {
        ["fullName"] = "Golden Rooster Figurine",
        ["displayName"] = "Rooster",
        ["displayType"] = "Valuable",
        ["weight"] = 3.8,
        ["value"] = 57000,
        ["equipType"] = EQUIPTYPE.None,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/barter/rooster.png", "smooth"),
        ["iconColor"] = Color(45, 37, 48, 155),

        ["sizeX"] = 2,
        ["sizeY"] = 2,

        ["canPurchase"] = false
    }

    EFGMITEMS["efgm_barter_gpu"] = {
        ["fullName"] = "Graphics Card",
        ["displayName"] = "GPU",
        ["displayType"] = "Electronic",
        ["weight"] = 0.6,
        ["value"] = 672220,
        ["equipType"] = EQUIPTYPE.None,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/barter/gpu.png", "smooth"),
        ["iconColor"] = Color(33, 43, 48, 155),

        ["sizeX"] = 2,
        ["sizeY"] = 1,

        ["canPurchase"] = false
    }

    EFGMITEMS["efgm_barter_greenbat"] = {
        ["fullName"] = "GreenBat Lithium Battery",
        ["displayName"] = "GreenBat",
        ["displayType"] = "Energy",
        ["weight"] = 0.05,
        ["value"] = 210900,
        ["equipType"] = EQUIPTYPE.None,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/barter/greenbat.png", "smooth"),
        ["iconColor"] = Color(45, 37, 48, 155),

        ["sizeX"] = 1,
        ["sizeY"] = 1,

        ["canPurchase"] = false
    }

    EFGMITEMS["efgm_barter_eagle"] = {
        ["fullName"] = 'Gunpowder "Eagle"',
        ["displayName"] = "Eagle",
        ["displayType"] = "Flammable",
        ["weight"] = 0.6,
        ["value"] = 20160,
        ["equipType"] = EQUIPTYPE.None,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/barter/eagle.png", "smooth"),
        ["iconColor"] = Color(31, 38, 26, 155),

        ["sizeX"] = 1,
        ["sizeY"] = 2,

        ["canPurchase"] = false
    }

    EFGMITEMS["efgm_barter_hawk"] = {
        ["fullName"] = 'Gunpowder "Hawk"',
        ["displayName"] = "Hawk",
        ["displayType"] = "Flammable",
        ["weight"] = 0.6,
        ["value"] = 22090,
        ["equipType"] = EQUIPTYPE.None,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/barter/hawk.png", "smooth"),
        ["iconColor"] = Color(54, 35, 32, 155),

        ["sizeX"] = 1,
        ["sizeY"] = 2,

        ["canPurchase"] = false
    }

    EFGMITEMS["efgm_barter_kite"] = {
        ["fullName"] = 'Gunpowder "Kite"',
        ["displayName"] = "Kite",
        ["displayType"] = "Flammable",
        ["weight"] = 0.6,
        ["value"] = 8820,
        ["equipType"] = EQUIPTYPE.None,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/barter/kite.png", "smooth"),
        ["iconColor"] = Color(33, 43, 48, 155),

        ["sizeX"] = 1,
        ["sizeY"] = 2,

        ["canPurchase"] = false
    }

    EFGMITEMS["efgm_barter_handdrill"] = {
        ["fullName"] = "Hand Drill",
        ["displayName"] = "Hand Drill",
        ["displayType"] = "Tool",
        ["weight"] = 2.3,
        ["value"] = 37800,
        ["equipType"] = EQUIPTYPE.None,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/barter/handdrill.png", "smooth"),
        ["iconColor"] = Color(45, 37, 48, 155),

        ["sizeX"] = 3,
        ["sizeY"] = 2,

        ["canPurchase"] = false
    }

    EFGMITEMS["efgm_barter_horse"] = {
        ["fullName"] = "Horse Figurine",
        ["displayName"] = "Horse",
        ["displayType"] = "Valuable",
        ["weight"] = 0.5,
        ["value"] = 7200,
        ["equipType"] = EQUIPTYPE.None,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/barter/horse.png", "smooth"),
        ["iconColor"] = Color(33, 43, 48, 155),

        ["sizeX"] = 1,
        ["sizeY"] = 2,

        ["canPurchase"] = false
    }

    EFGMITEMS["efgm_barter_hmatches"] = {
        ["fullName"] = "Hunting Matches",
        ["displayName"] = "HMatches",
        ["displayType"] = "Flammable",
        ["weight"] = 0.5,
        ["value"] = 2395,
        ["equipType"] = EQUIPTYPE.None,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/barter/hmatches.png", "smooth"),
        ["iconColor"] = Color(33, 43, 48, 155),

        ["sizeX"] = 1,
        ["sizeY"] = 1,

        ["canPurchase"] = false
    }

    EFGMITEMS["efgm_barter_inseq"] = {
        ["fullName"] = "Inseq Gas Pipe Wrench",
        ["displayName"] = "Inseq",
        ["displayType"] = "Tool",
        ["weight"] = 0.5,
        ["value"] = 28500,
        ["equipType"] = EQUIPTYPE.None,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/barter/inseq.png", "smooth"),
        ["iconColor"] = Color(45, 37, 48, 155),

        ["sizeX"] = 1,
        ["sizeY"] = 2,

        ["canPurchase"] = false
    }

    EFGMITEMS["efgm_barter_tape"] = {
        ["fullName"] = "Insulating Tape",
        ["displayName"] = "Tape",
        ["displayType"] = "Building",
        ["weight"] = 0.05,
        ["value"] = 1200,
        ["equipType"] = EQUIPTYPE.None,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/barter/tape.png", "smooth"),
        ["iconColor"] = Color(33, 43, 48, 155),

        ["sizeX"] = 1,
        ["sizeY"] = 1,

        ["canPurchase"] = false
    }

    EFGMITEMS["efgm_barter_intelligence"] = {
        ["fullName"] = "Intelligence Folder",
        ["displayName"] = "Intelligence",
        ["displayType"] = "Information",
        ["weight"] = 0.2,
        ["value"] = 159995,
        ["equipType"] = EQUIPTYPE.None,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/barter/intelligence.png", "smooth"),
        ["iconColor"] = Color(33, 43, 48, 155),

        ["sizeX"] = 2,
        ["sizeY"] = 1,

        ["canPurchase"] = false
    }

    EFGMITEMS["efgm_barter_iridium"] = {
        ["fullName"] = "Iridium Military Thermal Vision Module",
        ["displayName"] = "Iridium",
        ["displayType"] = "Electronic",
        ["weight"] = 0.2,
        ["value"] = 90280,
        ["equipType"] = EQUIPTYPE.None,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/barter/iridium.png", "smooth"),
        ["iconColor"] = Color(45, 37, 48, 155),

        ["sizeX"] = 1,
        ["sizeY"] = 1,

        ["canPurchase"] = false
    }

    EFGMITEMS["efgm_barter_pickles"] = {
        ["fullName"] = "Jar Of Pickles",
        ["displayName"] = "Pickles",
        ["displayType"] = "Other",
        ["weight"] = 2,
        ["value"] = 45900,
        ["equipType"] = EQUIPTYPE.None,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/barter/pickles.png", "smooth"),
        ["iconColor"] = Color(45, 37, 48, 155),

        ["sizeX"] = 1,
        ["sizeY"] = 2,

        ["canPurchase"] = false
    }

    EFGMITEMS["efgm_barter_kek"] = {
        ["fullName"] = "KEKTAPE Duct Tape",
        ["displayName"] = "KEK",
        ["displayType"] = "Building",
        ["weight"] = 0.15,
        ["value"] = 15120,
        ["equipType"] = EQUIPTYPE.None,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/barter/kek.png", "smooth"),
        ["iconColor"] = Color(45, 37, 48, 155),

        ["sizeX"] = 1,
        ["sizeY"] = 1,

        ["canPurchase"] = false
    }

    EFGMITEMS["efgm_barter_kosa"] = {
        ["fullName"] = "KOSA UAV Electronic Jamming Device",
        ["displayName"] = "KOSA",
        ["displayType"] = "Electronic",
        ["weight"] = 3,
        ["value"] = 61500,
        ["equipType"] = EQUIPTYPE.None,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/barter/kosa.png", "smooth"),
        ["iconColor"] = Color(45, 37, 48, 155),

        ["sizeX"] = 3,
        ["sizeY"] = 2,

        ["canPurchase"] = false
    }

    EFGMITEMS["efgm_barter_ledx"] = {
        ["fullName"] = "LEDX Skin Transilluminator",
        ["displayName"] = "LEDX",
        ["displayType"] = "Medicine",
        ["weight"] = 0.05,
        ["value"] = 1433220,
        ["equipType"] = EQUIPTYPE.None,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/barter/ledx.png", "smooth"),
        ["iconColor"] = Color(33, 43, 48, 155),

        ["sizeX"] = 1,
        ["sizeY"] = 1,

        ["canPurchase"] = false
    }

    EFGMITEMS["efgm_barter_multitool"] = {
        ["fullName"] = "Leatherman Multitool",
        ["displayName"] = "MultiTool",
        ["displayType"] = "Tool",
        ["weight"] = 0.15,
        ["value"] = 8605,
        ["equipType"] = EQUIPTYPE.None,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/barter/multitool.png", "smooth"),
        ["iconColor"] = Color(54, 35, 32, 155),

        ["sizeX"] = 1,
        ["sizeY"] = 1,

        ["canPurchase"] = false
    }

    EFGMITEMS["efgm_barter_bulb"] = {
        ["fullName"] = "Light Bulb",
        ["displayName"] = "Bulb",
        ["displayType"] = "Electronic",
        ["weight"] = 0.1,
        ["value"] = 5985,
        ["equipType"] = EQUIPTYPE.None,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/barter/bulb.png", "smooth"),
        ["iconColor"] = Color(33, 43, 48, 155),

        ["sizeX"] = 1,
        ["sizeY"] = 1,

        ["canPurchase"] = false
    }

    EFGMITEMS["efgm_barter_bulb"] = {
        ["fullName"] = "Light Bulb",
        ["displayName"] = "Bulb",
        ["displayType"] = "Electronic",
        ["weight"] = 0.1,
        ["value"] = 5985,
        ["equipType"] = EQUIPTYPE.None,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/barter/bulb.png", "smooth"),
        ["iconColor"] = Color(33, 43, 48, 155),

        ["sizeX"] = 1,
        ["sizeY"] = 1,

        ["canPurchase"] = false
    }

    EFGMITEMS["efgm_barter_lootlord"] = {
        ["fullName"] = "Loot Lord Plushie",
        ["displayName"] = "Loot Lord",
        ["displayType"] = "Valuable",
        ["weight"] = 0.3,
        ["value"] = 50000,
        ["equipType"] = EQUIPTYPE.None,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/barter/lootlord.png", "smooth"),
        ["iconColor"] = Color(45, 37, 48, 155),

        ["sizeX"] = 2,
        ["sizeY"] = 2,

        ["canPurchase"] = false
    }

    EFGMITEMS["efgm_barter_magnet"] = {
        ["fullName"] = "Magnet",
        ["displayName"] = "Magnet",
        ["displayType"] = "Electronic",
        ["weight"] = 0.4,
        ["value"] = 8000,
        ["equipType"] = EQUIPTYPE.None,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/barter/magnet.png", "smooth"),
        ["iconColor"] = Color(33, 43, 48, 155),

        ["sizeX"] = 1,
        ["sizeY"] = 1,

        ["canPurchase"] = false
    }

    EFGMITEMS["efgm_barter_malboro"] = {
        ["fullName"] = "Malboro Cigarettes",
        ["displayName"] = "Malboro",
        ["displayType"] = "Other",
        ["weight"] = 0.05,
        ["value"] = 1400,
        ["equipType"] = EQUIPTYPE.None,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/barter/malboro.png", "smooth"),
        ["iconColor"] = Color(33, 43, 48, 155),

        ["sizeX"] = 1,
        ["sizeY"] = 1,

        ["canPurchase"] = false
    }

    EFGMITEMS["efgm_barter_bloodset"] = {
        ["fullName"] = "Medical Bloodset",
        ["displayName"] = "Bloodset",
        ["displayType"] = "Medicine",
        ["weight"] = 0.2,
        ["value"] = 6150,
        ["equipType"] = EQUIPTYPE.None,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/barter/bloodset.png", "smooth"),
        ["iconColor"] = Color(33, 43, 48, 155),

        ["sizeX"] = 1,
        ["sizeY"] = 1,

        ["canPurchase"] = false
    }

    EFGMITEMS["efgm_barter_medtools"] = {
        ["fullName"] = "Medical Tools",
        ["displayName"] = "MedTools",
        ["displayType"] = "Medicine",
        ["weight"] = 0.25,
        ["value"] = 4500,
        ["equipType"] = EQUIPTYPE.None,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/barter/medtools.png", "smooth"),
        ["iconColor"] = Color(33, 43, 48, 155),

        ["sizeX"] = 1,
        ["sizeY"] = 1,

        ["canPurchase"] = false
    }

    EFGMITEMS["efgm_barter_mscissors"] = {
        ["fullName"] = "Metal Cutting Scissors",
        ["displayName"] = "MScissors",
        ["displayType"] = "Tool",
        ["weight"] = 0.6,
        ["value"] = 12485,
        ["equipType"] = EQUIPTYPE.None,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/barter/mscissors.png", "smooth"),
        ["iconColor"] = Color(33, 43, 48, 155),

        ["sizeX"] = 1,
        ["sizeY"] = 2,

        ["canPurchase"] = false
    }

    EFGMITEMS["efgm_barter_metalfuel"] = {
        ["fullName"] = "Metal Fuel Tank",
        ["displayName"] = "Fuel",
        ["displayType"] = "Flammable",
        ["weight"] = 9,
        ["value"] = 28800,
        ["equipType"] = EQUIPTYPE.None,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/barter/metalfuel.png", "smooth"),
        ["iconColor"] = Color(33, 43, 48, 155),

        ["sizeX"] = 2,
        ["sizeY"] = 3,

        ["canPurchase"] = false
    }

    EFGMITEMS["efgm_barter_mparts"] = {
        ["fullName"] = "Metal Spare Parts",
        ["displayName"] = "M.parts",
        ["displayType"] = "Building",
        ["weight"] = 0.45,
        ["value"] = 3150,
        ["equipType"] = EQUIPTYPE.None,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/barter/mparts.png", "smooth"),
        ["iconColor"] = Color(33, 43, 48, 155),

        ["sizeX"] = 1,
        ["sizeY"] = 1,

        ["canPurchase"] = false
    }

    EFGMITEMS["efgm_barter_mb"] = {
        ["fullName"] = "Microcontroller Board",
        ["displayName"] = "MB",
        ["displayType"] = "Electronic",
        ["weight"] = 0.05,
        ["value"] = 167700,
        ["equipType"] = EQUIPTYPE.None,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/barter/mb.png", "smooth"),
        ["iconColor"] = Color(45, 37, 48, 155),

        ["sizeX"] = 1,
        ["sizeY"] = 1,

        ["canPurchase"] = false
    }

    EFGMITEMS["efgm_barter_sgc10"] = {
        ["fullName"] = "Military COFDM Wireless Signal Transmitter",
        ["displayName"] = "SG-C10",
        ["displayType"] = "Electronic",
        ["weight"] = 2,
        ["value"] = 124555,
        ["equipType"] = EQUIPTYPE.None,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/barter/sgc10.png", "smooth"),
        ["iconColor"] = Color(33, 43, 48, 155),

        ["sizeX"] = 2,
        ["sizeY"] = 1,

        ["canPurchase"] = false
    }

    EFGMITEMS["efgm_barter_mcable"] = {
        ["fullName"] = "Military Cable",
        ["displayName"] = "MCable",
        ["displayType"] = "Electronic",
        ["weight"] = 0.6,
        ["value"] = 39470,
        ["equipType"] = EQUIPTYPE.None,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/barter/mcable.png", "smooth"),
        ["iconColor"] = Color(45, 37, 48, 155),

        ["sizeX"] = 2,
        ["sizeY"] = 1,

        ["canPurchase"] = false
    }

    EFGMITEMS["efgm_barter_mcb"] = {
        ["fullName"] = "Military Circuit Board",
        ["displayName"] = "MCB",
        ["displayType"] = "Electronic",
        ["weight"] = 0.4,
        ["value"] = 97700,
        ["equipType"] = EQUIPTYPE.None,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/barter/mcb.png", "smooth"),
        ["iconColor"] = Color(45, 37, 48, 155),

        ["sizeX"] = 1,
        ["sizeY"] = 1,

        ["canPurchase"] = false
    }

    EFGMITEMS["efgm_barter_mtube"] = {
        ["fullName"] = "Military Corrugated Tube",
        ["displayName"] = "MTube",
        ["displayType"] = "Building",
        ["weight"] = 0.4,
        ["value"] = 24990,
        ["equipType"] = EQUIPTYPE.None,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/barter/mtube.png", "smooth"),
        ["iconColor"] = Color(45, 37, 48, 155),

        ["sizeX"] = 1,
        ["sizeY"] = 1,

        ["canPurchase"] = false
    }

    EFGMITEMS["efgm_barter_mfd"] = {
        ["fullName"] = "Military Flash Drive",
        ["displayName"] = "MFD",
        ["displayType"] = "Information",
        ["weight"] = 0.1,
        ["value"] = 155000,
        ["equipType"] = EQUIPTYPE.None,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/barter/mfd.png", "smooth"),
        ["iconColor"] = Color(33, 43, 48, 155),

        ["sizeX"] = 1,
        ["sizeY"] = 1,

        ["canPurchase"] = false
    }

    EFGMITEMS["efgm_barter_mgt"] = {
        ["fullName"] = "Military Gyrotachometer",
        ["displayName"] = "MGT",
        ["displayType"] = "Electronic",
        ["weight"] = 0.9,
        ["value"] = 34320,
        ["equipType"] = EQUIPTYPE.None,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/barter/mgt.png", "smooth"),
        ["iconColor"] = Color(45, 37, 48, 155),

        ["sizeX"] = 1,
        ["sizeY"] = 2,

        ["canPurchase"] = false
    }

    EFGMITEMS["efgm_barter_pfilter"] = {
        ["fullName"] = "Military Power Filter",
        ["displayName"] = "PFilter",
        ["displayType"] = "Electronic",
        ["weight"] = 0.2,
        ["value"] = 44650,
        ["equipType"] = EQUIPTYPE.None,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/barter/pfilter.png", "smooth"),
        ["iconColor"] = Color(45, 37, 48, 155),

        ["sizeX"] = 1,
        ["sizeY"] = 1,

        ["canPurchase"] = false
    }

    EFGMITEMS["efgm_barter_nixxor"] = {
        ["fullName"] = "NIXXOR Lens",
        ["displayName"] = "NIXXOR",
        ["displayType"] = "Electronic",
        ["weight"] = 0.15,
        ["value"] = 14160,
        ["equipType"] = EQUIPTYPE.None,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/barter/nixxor.png", "smooth"),
        ["iconColor"] = Color(33, 43, 48, 155),

        ["sizeX"] = 1,
        ["sizeY"] = 1,

        ["canPurchase"] = false
    }

    EFGMITEMS["efgm_barter_nippers"] = {
        ["fullName"] = "Nippers",
        ["displayName"] = "Nippers",
        ["displayType"] = "Tool",
        ["weight"] = 0.3,
        ["value"] = 8500,
        ["equipType"] = EQUIPTYPE.None,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/barter/nippers.png", "smooth"),
        ["iconColor"] = Color(33, 43, 48, 155),

        ["sizeX"] = 1,
        ["sizeY"] = 1,

        ["canPurchase"] = false
    }

    EFGMITEMS["efgm_barter_ofz"] = {
        ["fullName"] = "OFZ 30x165mm shell",
        ["displayName"] = "OFZ",
        ["displayType"] = "Other",
        ["weight"] = 0.8,
        ["value"] = 35280,
        ["equipType"] = EQUIPTYPE.None,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/barter/ofz.png", "smooth"),
        ["iconColor"] = Color(33, 43, 48, 155),

        ["sizeX"] = 1,
        ["sizeY"] = 2,

        ["canPurchase"] = false
    }

    EFGMITEMS["efgm_barter_firesteel"] = {
        ["fullName"] = "Old Firesteel",
        ["displayName"] = "Firesteel",
        ["displayType"] = "Valuable",
        ["weight"] = 0.5,
        ["value"] = 39930,
        ["equipType"] = EQUIPTYPE.None,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/barter/firesteel.png", "smooth"),
        ["iconColor"] = Color(45, 37, 48, 155),

        ["sizeX"] = 1,
        ["sizeY"] = 1,

        ["canPurchase"] = false
    }

    EFGMITEMS["efgm_barter_oscope"] = {
        ["fullName"] = "Ophthalmoscope",
        ["displayName"] = "OScope",
        ["displayType"] = "Medicine",
        ["weight"] = 0.05,
        ["value"] = 121000,
        ["equipType"] = EQUIPTYPE.None,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/barter/oscope.png", "smooth"),
        ["iconColor"] = Color(33, 43, 48, 155),

        ["sizeX"] = 1,
        ["sizeY"] = 1,

        ["canPurchase"] = false
    }

    EFGMITEMS["efgm_barter_toothpaste"] = {
        ["fullName"] = "Ortodontox Toothpaste",
        ["displayName"] = "Ortodontox",
        ["displayType"] = "Household",
        ["weight"] = 0.2,
        ["value"] = 3400,
        ["equipType"] = EQUIPTYPE.None,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/barter/toothpaste.png", "smooth"),

        ["sizeX"] = 1,
        ["sizeY"] = 1,

        ["canPurchase"] = false
    }

    EFGMITEMS["efgm_barter_bleach"] = {
        ["fullName"] = "Ox Bleach",
        ["displayName"] = "Bleach",
        ["displayType"] = "Household",
        ["weight"] = 1,
        ["value"] = 3700,
        ["equipType"] = EQUIPTYPE.None,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/barter/bleach.png", "smooth"),

        ["sizeX"] = 1,
        ["sizeY"] = 2,

        ["canPurchase"] = false
    }

    EFGMITEMS["efgm_barter_paid"] = {
        ["fullName"] = "PAID AntiRoach Spray",
        ["displayName"] = "PAID",
        ["displayType"] = "Household",
        ["weight"] = 0.5,
        ["value"] = 3700,
        ["equipType"] = EQUIPTYPE.None,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/barter/paid.png", "smooth"),

        ["sizeX"] = 1,
        ["sizeY"] = 2,

        ["canPurchase"] = false
    }

    EFGMITEMS["efgm_barter_cpu"] = {
        ["fullName"] = "PC CPU",
        ["displayName"] = "CPU",
        ["displayType"] = "Electronic",
        ["weight"] = 0.1,
        ["value"] = 8700,
        ["equipType"] = EQUIPTYPE.None,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/barter/cpu.png", "smooth"),
        ["iconColor"] = Color(33, 43, 48, 155),

        ["sizeX"] = 1,
        ["sizeY"] = 1,

        ["canPurchase"] = false
    }

    EFGMITEMS["efgm_barter_buckwheat"] = {
        ["fullName"] = "Pack Of Arseniy Buckwheat",
        ["displayName"] = "Buckwheat",
        ["displayType"] = "Other",
        ["weight"] = 0.8,
        ["value"] = 14000,
        ["equipType"] = EQUIPTYPE.None,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/barter/buckwheat.png", "smooth"),

        ["sizeX"] = 1,
        ["sizeY"] = 2,

        ["canPurchase"] = false
    }

    EFGMITEMS["efgm_barter_chlorine"] = {
        ["fullName"] = "Pack Of Chlorine",
        ["displayName"] = "Chlorine",
        ["displayType"] = "Household",
        ["weight"] = 0.35,
        ["value"] = 21050,
        ["equipType"] = EQUIPTYPE.None,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/barter/chlorine.png", "smooth"),

        ["sizeX"] = 2,
        ["sizeY"] = 1,

        ["canPurchase"] = false
    }

    EFGMITEMS["efgm_barter_nails"] = {
        ["fullName"] = "Pack Of Nails",
        ["displayName"] = "Nails",
        ["displayType"] = "Building",
        ["weight"] = 0.4,
        ["value"] = 2580,
        ["equipType"] = EQUIPTYPE.None,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/barter/nails.png", "smooth"),
        ["iconColor"] = Color(33, 43, 48, 155),

        ["sizeX"] = 1,
        ["sizeY"] = 1,

        ["canPurchase"] = false
    }

    EFGMITEMS["efgm_barter_screws"] = {
        ["fullName"] = "Pack Of Screws",
        ["displayName"] = "Nails",
        ["displayType"] = "Building",
        ["weight"] = 0.3,
        ["value"] = 1990,
        ["equipType"] = EQUIPTYPE.None,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/barter/screws.png", "smooth"),
        ["iconColor"] = Color(33, 43, 48, 155),

        ["sizeX"] = 1,
        ["sizeY"] = 1,

        ["canPurchase"] = false
    }

    EFGMITEMS["efgm_barter_sodium"] = {
        ["fullName"] = "Pack Of Sodium Bicarbonate",
        ["displayName"] = "Sodium",
        ["displayType"] = "Household",
        ["weight"] = 0.5,
        ["value"] = 4000,
        ["equipType"] = EQUIPTYPE.None,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/barter/sodium.png", "smooth"),
        ["iconColor"] = Color(33, 43, 48, 155),

        ["sizeX"] = 1,
        ["sizeY"] = 1,

        ["canPurchase"] = false
    }

    EFGMITEMS["efgm_barter_paracord"] = {
        ["fullName"] = "Paracord",
        ["displayName"] = "Paracord",
        ["displayType"] = "Tool",
        ["weight"] = 0.35,
        ["value"] = 15000,
        ["equipType"] = EQUIPTYPE.None,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/barter/paracord.png", "smooth"),
        ["iconColor"] = Color(33, 43, 48, 155),

        ["sizeX"] = 2,
        ["sizeY"] = 1,

        ["canPurchase"] = false
    }

    EFGMITEMS["efgm_barter_relay"] = {
        ["fullName"] = "Phase Control Relay",
        ["displayName"] = "Relay",
        ["displayType"] = "Electronic",
        ["weight"] = 0.05,
        ["value"] = 4050,
        ["equipType"] = EQUIPTYPE.None,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/barter/relay.png", "smooth"),
        ["iconColor"] = Color(33, 43, 48, 155),

        ["sizeX"] = 1,
        ["sizeY"] = 1,

        ["canPurchase"] = false
    }

    EFGMITEMS["efgm_barter_aesa"] = {
        ["fullName"] = "Phased Array Element",
        ["displayName"] = "AESA",
        ["displayType"] = "Electronic",
        ["weight"] = 1.7,
        ["value"] = 480990,
        ["equipType"] = EQUIPTYPE.None,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/barter/aesa.png", "smooth"),
        ["iconColor"] = Color(45, 37, 48, 155),

        ["sizeX"] = 2,
        ["sizeY"] = 2,

        ["canPurchase"] = false
    }

    EFGMITEMS["efgm_barter_btc"] = {
        ["fullName"] = "Physical Bitcoin",
        ["displayName"] = "0.2BTC",
        ["displayType"] = "Valuable",
        ["weight"] = 0.05,
        ["value"] = 888888,
        ["equipType"] = EQUIPTYPE.None,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/barter/btc.png", "smooth"),
        ["iconColor"] = Color(45, 37, 48, 155),

        ["sizeX"] = 1,
        ["sizeY"] = 1,

        ["canPurchase"] = false
    }

    EFGMITEMS["efgm_barter_plexiglass"] = {
        ["fullName"] = "Piece Of Plexiglass",
        ["displayName"] = "Plexiglass",
        ["displayType"] = "Building",
        ["weight"] = 0.5,
        ["value"] = 5400,
        ["equipType"] = EQUIPTYPE.None,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/barter/plexiglass.png", "smooth"),
        ["iconColor"] = Color(33, 43, 48, 155),

        ["sizeX"] = 1,
        ["sizeY"] = 1,

        ["canPurchase"] = false
    }

    EFGMITEMS["efgm_barter_meds"] = {
        ["fullName"] = "Pile Of Meds",
        ["displayName"] = "Meds",
        ["displayType"] = "Medicine",
        ["weight"] = 0.2,
        ["value"] = 4020,
        ["equipType"] = EQUIPTYPE.None,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/barter/meds.png", "smooth"),
        ["iconColor"] = Color(33, 43, 48, 155),

        ["sizeX"] = 1,
        ["sizeY"] = 1,

        ["canPurchase"] = false
    }

    EFGMITEMS["efgm_barter_pgw"] = {
        ["fullName"] = "Pipe Grip Wrench",
        ["displayName"] = "PGW",
        ["displayType"] = "Tool",
        ["weight"] = 1.2,
        ["value"] = 83160,
        ["equipType"] = EQUIPTYPE.None,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/barter/pgw.png", "smooth"),
        ["iconColor"] = Color(45, 37, 48, 155),

        ["sizeX"] = 1,
        ["sizeY"] = 2,

        ["canPurchase"] = false
    }

    EFGMITEMS["efgm_barter_pliers"] = {
        ["fullName"] = "Pliers",
        ["displayName"] = "Pliers",
        ["displayType"] = "Tool",
        ["weight"] = 0.4,
        ["value"] = 4900,
        ["equipType"] = EQUIPTYPE.None,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/barter/pliers.png", "smooth"),
        ["iconColor"] = Color(33, 43, 48, 155),

        ["sizeX"] = 1,
        ["sizeY"] = 1,

        ["canPurchase"] = false
    }

    EFGMITEMS["efgm_barter_elite"] = {
        ["fullName"] = "Pliers Elite",
        ["displayName"] = "Elite",
        ["displayType"] = "Tool",
        ["weight"] = 0.25,
        ["value"] = 18200,
        ["equipType"] = EQUIPTYPE.None,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/barter/elite.png", "smooth"),
        ["iconColor"] = Color(33, 43, 48, 155),

        ["sizeX"] = 1,
        ["sizeY"] = 1,

        ["canPurchase"] = false
    }

    EFGMITEMS["efgm_barter_powerbank"] = {
        ["fullName"] = "Portable Powerbank",
        ["displayName"] = "Powerbank",
        ["displayType"] = "Energy",
        ["weight"] = 0.3,
        ["value"] = 12200,
        ["equipType"] = EQUIPTYPE.None,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/barter/powerbank.png", "smooth"),
        ["iconColor"] = Color(33, 43, 48, 155),

        ["sizeX"] = 1,
        ["sizeY"] = 1,

        ["canPurchase"] = false
    }

    EFGMITEMS["efgm_barter_defib"] = {
        ["fullName"] = "Portable Defibrillator",
        ["displayName"] = "Defib",
        ["displayType"] = "Medicine",
        ["weight"] = 1.5,
        ["value"] = 141400,
        ["equipType"] = EQUIPTYPE.None,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/barter/defib.png", "smooth"),
        ["iconColor"] = Color(33, 43, 48, 155),

        ["sizeX"] = 1,
        ["sizeY"] = 1,

        ["canPurchase"] = false
    }

    EFGMITEMS["efgm_barter_cord"] = {
        ["fullName"] = "Power Cord",
        ["displayName"] = "Cord",
        ["displayType"] = "Electronic",
        ["weight"] = 0.6,
        ["value"] = 7900,
        ["equipType"] = EQUIPTYPE.None,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/barter/cord.png", "smooth"),
        ["iconColor"] = Color(33, 43, 48, 155),

        ["sizeX"] = 2,
        ["sizeY"] = 1,

        ["canPurchase"] = false
    }

    EFGMITEMS["efgm_barter_psu"] = {
        ["fullName"] = "Power Supply Unit",
        ["displayName"] = "PSU",
        ["displayType"] = "Electronic",
        ["weight"] = 1.5,
        ["value"] = 8000,
        ["equipType"] = EQUIPTYPE.None,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/barter/psu.png", "smooth"),
        ["iconColor"] = Color(33, 43, 48, 155),

        ["sizeX"] = 2,
        ["sizeY"] = 2,

        ["canPurchase"] = false
    }

    EFGMITEMS["efgm_barter_pass"] = {
        ["fullName"] = "Press Pass",
        ["displayName"] = "Pass",
        ["displayType"] = "Other",
        ["weight"] = 0.1,
        ["value"] = 31500,
        ["equipType"] = EQUIPTYPE.None,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/barter/pass.png", "smooth"),
        ["iconColor"] = Color(45, 37, 48, 155),

        ["sizeX"] = 1,
        ["sizeY"] = 2,

        ["canPurchase"] = false
    }

    EFGMITEMS["efgm_barter_pgauge"] = {
        ["fullName"] = "Pressure Gauge",
        ["displayName"] = "PGauge",
        ["displayType"] = "Building",
        ["weight"] = 0.8,
        ["value"] = 38600,
        ["equipType"] = EQUIPTYPE.None,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/barter/pgauge.png", "smooth"),
        ["iconColor"] = Color(45, 37, 48, 155),

        ["sizeX"] = 2,
        ["sizeY"] = 1,

        ["canPurchase"] = false
    }

    EFGMITEMS["efgm_barter_pcb"] = {
        ["fullName"] = "Printed Circuit Board",
        ["displayName"] = "PCB",
        ["displayType"] = "Electronic",
        ["weight"] = 0.3,
        ["value"] = 8050,
        ["equipType"] = EQUIPTYPE.None,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/barter/pcb.png", "smooth"),
        ["iconColor"] = Color(33, 43, 48, 155),

        ["sizeX"] = 1,
        ["sizeY"] = 1,

        ["canPurchase"] = false
    }

    EFGMITEMS["efgm_barter_paper"] = {
        ["fullName"] = "Printer Paper",
        ["displayName"] = "Paper",
        ["displayType"] = "Household",
        ["weight"] = 0.5,
        ["value"] = 1500,
        ["equipType"] = EQUIPTYPE.None,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/barter/paper.png", "smooth"),

        ["sizeX"] = 2,
        ["sizeY"] = 1,

        ["canPurchase"] = false
    }

    EFGMITEMS["efgm_barter_propane"] = {
        ["fullName"] = "Propane Tank (5L)",
        ["displayName"] = "Propane",
        ["displayType"] = "Flammable",
        ["weight"] = 5,
        ["value"] = 41000,
        ["equipType"] = EQUIPTYPE.None,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/barter/propane.png", "smooth"),
        ["iconColor"] = Color(33, 43, 48, 155),

        ["sizeX"] = 2,
        ["sizeY"] = 2,

        ["canPurchase"] = false
    }

    EFGMITEMS["efgm_barter_ram"] = {
        ["fullName"] = "RAM Stick",
        ["displayName"] = "RAM",
        ["displayType"] = "Electronic",
        ["weight"] = 0.05,
        ["value"] = 7000,
        ["equipType"] = EQUIPTYPE.None,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/barter/ram.png", "smooth"),
        ["iconColor"] = Color(33, 43, 48, 155),

        ["sizeX"] = 1,
        ["sizeY"] = 1,

        ["canPurchase"] = false
    }

    EFGMITEMS["efgm_barter_helix"] = {
        ["fullName"] = "Radiator Helix",
        ["displayName"] = "Helix",
        ["displayType"] = "Electronic",
        ["weight"] = 0.3,
        ["value"] = 9135,
        ["equipType"] = EQUIPTYPE.None,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/barter/helix.png", "smooth"),
        ["iconColor"] = Color(33, 43, 48, 155),

        ["sizeX"] = 1,
        ["sizeY"] = 1,

        ["canPurchase"] = false
    }

    EFGMITEMS["efgm_barter_ratchet"] = {
        ["fullName"] = "Ratchet Wrench",
        ["displayName"] = "Ratchet",
        ["displayType"] = "Tool",
        ["weight"] = 1,
        ["value"] = 68120,
        ["equipType"] = EQUIPTYPE.None,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/barter/ratchet.png", "smooth"),
        ["iconColor"] = Color(33, 43, 48, 155),

        ["sizeX"] = 1,
        ["sizeY"] = 2,

        ["canPurchase"] = false
    }

    EFGMITEMS["efgm_barter_raven"] = {
        ["fullName"] = "Raven Figurine",
        ["displayName"] = "Raven",
        ["displayType"] = "Valuable",
        ["weight"] = 0.4,
        ["value"] = 34000,
        ["equipType"] = EQUIPTYPE.None,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/barter/raven.png", "smooth"),
        ["iconColor"] = Color(45, 37, 48, 155),

        ["sizeX"] = 1,
        ["sizeY"] = 2,

        ["canPurchase"] = false
    }

    EFGMITEMS["efgm_barter_rbatt"] = {
        ["fullName"] = "Rechargeable Battery",
        ["displayName"] = "RBattery",
        ["displayType"] = "Energy",
        ["weight"] = 0.1,
        ["value"] = 10400,
        ["equipType"] = EQUIPTYPE.None,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/barter/rbatt.png", "smooth"),
        ["iconColor"] = Color(33, 43, 48, 155),

        ["sizeX"] = 1,
        ["sizeY"] = 1,

        ["canPurchase"] = false
    }

    EFGMITEMS["efgm_barter_repellent"] = {
        ["fullName"] = "Repellent",
        ["displayName"] = "Repellent",
        ["displayType"] = "Household",
        ["weight"] = 0.15,
        ["value"] = 5350,
        ["equipType"] = EQUIPTYPE.None,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/barter/repellent.png", "smooth"),

        ["sizeX"] = 1,
        ["sizeY"] = 2,

        ["canPurchase"] = false
    }

    EFGMITEMS["efgm_barter_ripstop"] = {
        ["fullName"] = "Ripstop Fabric",
        ["displayName"] = "Ripstop",
        ["displayType"] = "Other",
        ["weight"] = 0.1,
        ["value"] = 3600,
        ["equipType"] = EQUIPTYPE.None,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/barter/ripstop.png", "smooth"),
        ["iconColor"] = Color(33, 43, 48, 155),

        ["sizeX"] = 2,
        ["sizeY"] = 1,

        ["canPurchase"] = false
    }

    EFGMITEMS["efgm_barter_roler"] = {
        ["fullName"] = "Roler Submariner Gold Wrist Watch",
        ["displayName"] = "Roler",
        ["displayType"] = "Valuable",
        ["weight"] = 0.1,
        ["value"] = 56600,
        ["equipType"] = EQUIPTYPE.None,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/barter/roler.png", "smooth"),
        ["iconColor"] = Color(45, 37, 48, 155),

        ["sizeX"] = 1,
        ["sizeY"] = 1,

        ["canPurchase"] = false
    }

    EFGMITEMS["efgm_barter_rpliers"] = {
        ["fullName"] = "Round Pliers",
        ["displayName"] = "RPliers",
        ["displayType"] = "Tool",
        ["weight"] = 0.25,
        ["value"] = 17000,
        ["equipType"] = EQUIPTYPE.None,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/barter/rpliers.png", "smooth"),
        ["iconColor"] = Color(33, 43, 48, 155),

        ["sizeX"] = 1,
        ["sizeY"] = 1,

        ["canPurchase"] = false
    }

    EFGMITEMS["efgm_barter_sas"] = {
        ["fullName"] = "SAS Drive",
        ["displayName"] = "SAS",
        ["displayType"] = "Information",
        ["weight"] = 0.2,
        ["value"] = 119000,
        ["equipType"] = EQUIPTYPE.None,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/barter/sas.png", "smooth"),
        ["iconColor"] = Color(33, 43, 48, 155),

        ["sizeX"] = 1,
        ["sizeY"] = 1,

        ["canPurchase"] = false
    }

    EFGMITEMS["efgm_barter_ssd"] = {
        ["fullName"] = "SSD Drive",
        ["displayName"] = "SSD",
        ["displayType"] = "Information",
        ["weight"] = 0.05,
        ["value"] = 87100,
        ["equipType"] = EQUIPTYPE.None,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/barter/ssd.png", "smooth"),
        ["iconColor"] = Color(33, 43, 48, 155),

        ["sizeX"] = 1,
        ["sizeY"] = 1,

        ["canPurchase"] = false
    }

    EFGMITEMS["efgm_barter_shampoo"] = {
        ["fullName"] = "Schaman Shampoo",
        ["displayName"] = "Shampoo",
        ["displayType"] = "Household",
        ["weight"] = 0.3,
        ["value"] = 4400,
        ["equipType"] = EQUIPTYPE.None,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/barter/shampoo.png", "smooth"),

        ["sizeX"] = 1,
        ["sizeY"] = 2,

        ["canPurchase"] = false
    }

    EFGMITEMS["efgm_barter_nuts"] = {
        ["fullName"] = "Screw Nuts",
        ["displayName"] = "Nuts",
        ["displayType"] = "Building",
        ["weight"] = 0.3,
        ["value"] = 5480,
        ["equipType"] = EQUIPTYPE.None,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/barter/nuts.png", "smooth"),
        ["iconColor"] = Color(33, 43, 48, 155),

        ["sizeX"] = 1,
        ["sizeY"] = 1,

        ["canPurchase"] = false
    }

    EFGMITEMS["efgm_barter_screwdriver"] = {
        ["fullName"] = "Screwdriver",
        ["displayName"] = "Scdr.",
        ["displayType"] = "Tool",
        ["weight"] = 0.15,
        ["value"] = 2200,
        ["equipType"] = EQUIPTYPE.None,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/barter/screwdriver.png", "smooth"),
        ["iconColor"] = Color(33, 43, 48, 155),

        ["sizeX"] = 1,
        ["sizeY"] = 1,

        ["canPurchase"] = false
    }

    EFGMITEMS["efgm_barter_flashdrive"] = {
        ["fullName"] = "Secure Flash Drive",
        ["displayName"] = "Flash",
        ["displayType"] = "Information",
        ["weight"] = 0.1,
        ["value"] = 99999,
        ["equipType"] = EQUIPTYPE.None,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/barter/flashdrive.png", "smooth"),
        ["iconColor"] = Color(33, 43, 48, 155),

        ["sizeX"] = 1,
        ["sizeY"] = 1,

        ["canPurchase"] = false
    }

    EFGMITEMS["efgm_barter_smt"] = {
        ["fullName"] = "Secure Magnetic Tape Cassettee",
        ["displayName"] = "SMT",
        ["displayType"] = "Information",
        ["weight"] = 0.25,
        ["value"] = 150000,
        ["equipType"] = EQUIPTYPE.None,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/barter/smt.png", "smooth"),
        ["iconColor"] = Color(33, 43, 48, 155),

        ["sizeX"] = 1,
        ["sizeY"] = 1,

        ["canPurchase"] = false
    }

    EFGMITEMS["efgm_barter_master"] = {
        ["fullName"] = 'Set Of Files "Master"',
        ["displayName"] = "Master",
        ["displayType"] = "Tool",
        ["weight"] = 0.45,
        ["value"] = 59900,
        ["equipType"] = EQUIPTYPE.None,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/barter/master.png", "smooth"),
        ["iconColor"] = Color(33, 43, 48, 155),

        ["sizeX"] = 2,
        ["sizeY"] = 2,

        ["canPurchase"] = false
    }

    EFGMITEMS["efgm_barter_sewingkit"] = {
        ["fullName"] = "Sewing Kit",
        ["displayName"] = "Sewing",
        ["displayType"] = "Tool",
        ["weight"] = 0.2,
        ["value"] = 23940,
        ["equipType"] = EQUIPTYPE.None,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/barter/sewingkit.png", "smooth"),
        ["iconColor"] = Color(33, 43, 48, 155),

        ["sizeX"] = 1,
        ["sizeY"] = 1,

        ["canPurchase"] = false
    }

    EFGMITEMS["efgm_barter_shus"] = {
        ["fullName"] = "Shustrilo Sealing Foam",
        ["displayName"] = "Shus",
        ["displayType"] = "Building",
        ["weight"] = 1,
        ["value"] = 22000,
        ["equipType"] = EQUIPTYPE.None,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/barter/shus.png", "smooth"),
        ["iconColor"] = Color(33, 43, 48, 155),

        ["sizeX"] = 1,
        ["sizeY"] = 3,

        ["canPurchase"] = false
    }

    EFGMITEMS["efgm_barter_tube"] = {
        ["fullName"] = "Silicone Tube",
        ["displayName"] = "Tube",
        ["displayType"] = "Building",
        ["weight"] = 0.15,
        ["value"] = 11900,
        ["equipType"] = EQUIPTYPE.None,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/barter/tube.png", "smooth"),
        ["iconColor"] = Color(33, 43, 48, 155),

        ["sizeX"] = 1,
        ["sizeY"] = 1,

        ["canPurchase"] = false
    }

    EFGMITEMS["efgm_barter_badge"] = {
        ["fullName"] = "Silver Badge",
        ["displayName"] = "Badge",
        ["displayType"] = "Valuable",
        ["weight"] = 0.05,
        ["value"] = 40000,
        ["equipType"] = EQUIPTYPE.None,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/barter/badge.png", "smooth"),
        ["iconColor"] = Color(45, 37, 48, 155),

        ["sizeX"] = 1,
        ["sizeY"] = 1,

        ["canPurchase"] = false
    }

    EFGMITEMS["efgm_barter_slimdiary"] = {
        ["fullName"] = "Slim Diary",
        ["displayName"] = "SDiary",
        ["displayType"] = "Information",
        ["weight"] = 0.1,
        ["value"] = 57400,
        ["equipType"] = EQUIPTYPE.None,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/barter/slimdiary.png", "smooth"),
        ["iconColor"] = Color(33, 43, 48, 155),

        ["sizeX"] = 1,
        ["sizeY"] = 1,

        ["canPurchase"] = false
    }

    EFGMITEMS["efgm_barter_dcleaner"] = {
        ["fullName"] = "Smoked Chimney Drain Cleaner",
        ["displayName"] = "DCleaner",
        ["displayType"] = "Household",
        ["weight"] = 0.5,
        ["value"] = 6000,
        ["equipType"] = EQUIPTYPE.None,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/barter/dcleaner.png", "smooth"),

        ["sizeX"] = 1,
        ["sizeY"] = 2,

        ["canPurchase"] = false
    }

    EFGMITEMS["efgm_barter_soap"] = {
        ["fullName"] = "Soap",
        ["displayName"] = "Soap",
        ["displayType"] = "Household",
        ["weight"] = 0.05,
        ["value"] = 2400,
        ["equipType"] = EQUIPTYPE.None,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/barter/soap.png", "smooth"),

        ["sizeX"] = 1,
        ["sizeY"] = 1,

        ["canPurchase"] = false
    }

    EFGMITEMS["efgm_barter_splug"] = {
        ["fullName"] = "Spark Plug",
        ["displayName"] = "SPlug",
        ["displayType"] = "Electronic",
        ["weight"] = 0.05,
        ["value"] = 11000,
        ["equipType"] = EQUIPTYPE.None,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/barter/splug.png", "smooth"),
        ["iconColor"] = Color(33, 43, 48, 155),

        ["sizeX"] = 1,
        ["sizeY"] = 1,

        ["canPurchase"] = false
    }

    EFGMITEMS["efgm_barter_strike"] = {
        ["fullName"] = "Strike Cigarettes",
        ["displayName"] = "Strike",
        ["displayType"] = "Other",
        ["weight"] = 0.05,
        ["value"] = 1990,
        ["equipType"] = EQUIPTYPE.None,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/barter/strike.png", "smooth"),
        ["iconColor"] = Color(33, 43, 48, 155),

        ["sizeX"] = 1,
        ["sizeY"] = 1,

        ["canPurchase"] = false
    }

    EFGMITEMS["efgm_barter_survl"] = {
        ["fullName"] = "SurvL Survivor Lighter",
        ["displayName"] = "SurvL",
        ["displayType"] = "Flammable",
        ["weight"] = 0.05,
        ["value"] = 20000,
        ["equipType"] = EQUIPTYPE.None,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/barter/survl.png", "smooth"),
        ["iconColor"] = Color(45, 37, 48, 155),

        ["sizeX"] = 1,
        ["sizeY"] = 1,

        ["canPurchase"] = false
    }

    EFGMITEMS["efgm_barter_tplug"] = {
        ["fullName"] = "T-Shaped Plug",
        ["displayName"] = "T-Plug",
        ["displayType"] = "Electronic",
        ["weight"] = 0.05,
        ["value"] = 7700,
        ["equipType"] = EQUIPTYPE.None,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/barter/tplug.png", "smooth"),
        ["iconColor"] = Color(33, 43, 48, 155),

        ["sizeX"] = 1,
        ["sizeY"] = 1,

        ["canPurchase"] = false
    }

    EFGMITEMS["efgm_barter_tp200"] = {
        ["fullName"] = "TP-200 TNT Brick",
        ["displayName"] = "TP-200",
        ["displayType"] = "Flammable",
        ["weight"] = 0.2,
        ["value"] = 30000,
        ["equipType"] = EQUIPTYPE.None,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/barter/tp200.png", "smooth"),
        ["iconColor"] = Color(33, 43, 48, 155),

        ["sizeX"] = 1,
        ["sizeY"] = 1,

        ["canPurchase"] = false
    }

    EFGMITEMS["efgm_barter_tp200"] = {
        ["fullName"] = "TP-200 TNT Brick",
        ["displayName"] = "TP-200",
        ["displayType"] = "Flammable",
        ["weight"] = 0.2,
        ["value"] = 30000,
        ["equipType"] = EQUIPTYPE.None,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/barter/tp200.png", "smooth"),
        ["iconColor"] = Color(33, 43, 48, 155),

        ["sizeX"] = 1,
        ["sizeY"] = 1,

        ["canPurchase"] = false
    }

    EFGMITEMS["efgm_barter_tamatthi"] = {
        ["fullName"] = "Tamatthi Kunai Knife Replica",
        ["displayName"] = "Tamatthi",
        ["displayType"] = "Valuable",
        ["weight"] = 0.4,
        ["value"] = 98000,
        ["equipType"] = EQUIPTYPE.None,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/barter/tamatthi.png", "smooth"),
        ["iconColor"] = Color(45, 37, 48, 155),

        ["sizeX"] = 1,
        ["sizeY"] = 2,

        ["canPurchase"] = false
    }

    EFGMITEMS["efgm_barter_manual"] = {
        ["fullName"] = "Tech Manual",
        ["displayName"] = "Manual",
        ["displayType"] = "Information",
        ["weight"] = 0.2,
        ["value"] = 87900,
        ["equipType"] = EQUIPTYPE.None,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/barter/manual.png", "smooth"),
        ["iconColor"] = Color(33, 43, 48, 155),

        ["sizeX"] = 1,
        ["sizeY"] = 2,

        ["canPurchase"] = false
    }

    EFGMITEMS["efgm_barter_folders"] = {
        ["fullName"] = 'TerraGroup "Blue Folders" Materials',
        ["displayName"] = "Folders",
        ["displayType"] = "Information",
        ["weight"] = 0.3,
        ["value"] = 485555,
        ["equipType"] = EQUIPTYPE.None,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/barter/folders.png", "smooth"),
        ["iconColor"] = Color(33, 43, 48, 155),

        ["sizeX"] = 1,
        ["sizeY"] = 2,

        ["canPurchase"] = false
    }

    EFGMITEMS["efgm_barter_tetriz"] = {
        ["fullName"] = "Tetriz Portable Game Console",
        ["displayName"] = "Tetriz",
        ["displayType"] = "Electronic",
        ["weight"] = 0.1,
        ["value"] = 171000,
        ["equipType"] = EQUIPTYPE.None,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/barter/tetriz.png", "smooth"),
        ["iconColor"] = Color(33, 43, 48, 155),

        ["sizeX"] = 1,
        ["sizeY"] = 2,

        ["canPurchase"] = false
    }

    EFGMITEMS["efgm_barter_tp"] = {
        ["fullName"] = "Toilet Paper",
        ["displayName"] = "TP",
        ["displayType"] = "Household",
        ["weight"] = 0.05,
        ["value"] = 5500,
        ["equipType"] = EQUIPTYPE.None,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/barter/tp.png", "smooth"),

        ["sizeX"] = 1,
        ["sizeY"] = 1,

        ["canPurchase"] = false
    }

    EFGMITEMS["efgm_barter_toolset"] = {
        ["fullName"] = "Toolset",
        ["displayName"] = "Toolset",
        ["displayType"] = "Tool",
        ["weight"] = 0.6,
        ["value"] = 20000,
        ["equipType"] = EQUIPTYPE.None,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/barter/toolset.png", "smooth"),
        ["iconColor"] = Color(33, 43, 48, 155),

        ["sizeX"] = 2,
        ["sizeY"] = 2,

        ["canPurchase"] = false
    }

    EFGMITEMS["efgm_barter_maps"] = {
        ["fullName"] = "Topographic Survey Maps",
        ["displayName"] = "Maps",
        ["displayType"] = "Information",
        ["weight"] = 0.2,
        ["value"] = 162200,
        ["equipType"] = EQUIPTYPE.None,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/barter/maps.png", "smooth"),
        ["iconColor"] = Color(33, 43, 48, 155),

        ["sizeX"] = 2,
        ["sizeY"] = 1,

        ["canPurchase"] = false
    }

    EFGMITEMS["efgm_barter_poxeram"] = {
        ["fullName"] = "Tube Of Poxeram Cold Welding",
        ["displayName"] = "Poxeram",
        ["displayType"] = "Building",
        ["weight"] = 0.05,
        ["value"] = 11600,
        ["equipType"] = EQUIPTYPE.None,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/barter/poxeram.png", "smooth"),
        ["iconColor"] = Color(33, 43, 48, 155),

        ["sizeX"] = 1,
        ["sizeY"] = 1,

        ["canPurchase"] = false
    }

    EFGMITEMS["efgm_barter_rfidr"] = {
        ["fullName"] = "UHF RFID Reader",
        ["displayName"] = "RFIDR",
        ["displayType"] = "Electronic",
        ["weight"] = 0.5,
        ["value"] = 105115,
        ["equipType"] = EQUIPTYPE.None,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/barter/rfidr.png", "smooth"),
        ["iconColor"] = Color(33, 43, 48, 155),

        ["sizeX"] = 1,
        ["sizeY"] = 1,

        ["canPurchase"] = false
    }

    EFGMITEMS["efgm_barter_usb"] = {
        ["fullName"] = "USB Adapter",
        ["displayName"] = "USB-A",
        ["displayType"] = "Electronic",
        ["weight"] = 0.1,
        ["value"] = 1000,
        ["equipType"] = EQUIPTYPE.None,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/barter/usb.png", "smooth"),
        ["iconColor"] = Color(33, 43, 48, 155),

        ["sizeX"] = 1,
        ["sizeY"] = 1,

        ["canPurchase"] = false
    }

    EFGMITEMS["efgm_barter_usb"] = {
        ["fullName"] = "USB Adapter",
        ["displayName"] = "USB-A",
        ["displayType"] = "Electronic",
        ["weight"] = 0.1,
        ["value"] = 1000,
        ["equipType"] = EQUIPTYPE.None,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/barter/usb.png", "smooth"),
        ["iconColor"] = Color(33, 43, 48, 155),

        ["sizeX"] = 1,
        ["sizeY"] = 1,

        ["canPurchase"] = false
    }

    EFGMITEMS["efgm_barter_usecfigurine"] = {
        ["fullName"] = "USEC Operative Figurine",
        ["displayName"] = "USEC",
        ["displayType"] = "Valuable",
        ["weight"] = 0.2,
        ["value"] = 38900,
        ["equipType"] = EQUIPTYPE.None,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/barter/usecfigurine.png", "smooth"),
        ["iconColor"] = Color(45, 37, 48, 155),

        ["sizeX"] = 1,
        ["sizeY"] = 2,

        ["canPurchase"] = false
    }

    EFGMITEMS["efgm_barter_fuze"] = {
        ["fullName"] = "UZRGM Grenade Fuze",
        ["displayName"] = "Fuze",
        ["displayType"] = "Other",
        ["weight"] = 0.05,
        ["value"] = 5130,
        ["equipType"] = EQUIPTYPE.None,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/barter/fuze.png", "smooth"),
        ["iconColor"] = Color(33, 43, 48, 155),

        ["sizeX"] = 1,
        ["sizeY"] = 1,

        ["canPurchase"] = false
    }

    EFGMITEMS["efgm_barter_uvlamp"] = {
        ["fullName"] = "Ultraviolet Lamp",
        ["displayName"] = "UV",
        ["displayType"] = "Electronic",
        ["weight"] = 0.2,
        ["value"] = 9995,
        ["equipType"] = EQUIPTYPE.None,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/barter/uvlamp.png", "smooth"),
        ["iconColor"] = Color(33, 43, 48, 155),

        ["sizeX"] = 1,
        ["sizeY"] = 1,

        ["canPurchase"] = false
    }

    EFGMITEMS["efgm_barter_vpx"] = {
        ["fullName"] = "VPX Flash Storage Module",
        ["displayName"] = "VPX",
        ["displayType"] = "Information",
        ["weight"] = 0.5,
        ["value"] = 123600,
        ["equipType"] = EQUIPTYPE.None,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/barter/vpx.png", "smooth"),
        ["iconColor"] = Color(33, 43, 48, 155),

        ["sizeX"] = 1,
        ["sizeY"] = 1,

        ["canPurchase"] = false
    }

    EFGMITEMS["efgm_barter_veritas"] = {
        ["fullName"] = "Veritas Guitar Pick",
        ["displayName"] = "Veritas",
        ["displayType"] = "Valuable",
        ["weight"] = 0.05,
        ["value"] = 34600,
        ["equipType"] = EQUIPTYPE.None,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/barter/veritas.png", "smooth"),
        ["iconColor"] = Color(45, 37, 48, 155),

        ["sizeX"] = 1,
        ["sizeY"] = 1,

        ["canPurchase"] = false
    }

    EFGMITEMS["efgm_barter_viibiin"] = {
        ["fullName"] = "Viibiin Sneaker",
        ["displayName"] = "Viibiin",
        ["displayType"] = "Valuable",
        ["weight"] = 0.4,
        ["value"] = 35740,
        ["equipType"] = EQUIPTYPE.None,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/barter/viibiin.png", "smooth"),
        ["iconColor"] = Color(45, 37, 48, 155),

        ["sizeX"] = 2,
        ["sizeY"] = 1,

        ["canPurchase"] = false
    }

    EFGMITEMS["efgm_barter_virtex"] = {
        ["fullName"] = "Virtex Programmable Processor",
        ["displayName"] = "Virtex",
        ["displayType"] = "Electronic",
        ["weight"] = 0.3,
        ["value"] = 289980,
        ["equipType"] = EQUIPTYPE.None,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/barter/virtex.png", "smooth"),
        ["iconColor"] = Color(33, 43, 48, 155),

        ["sizeX"] = 1,
        ["sizeY"] = 1,

        ["canPurchase"] = false
    }

    EFGMITEMS["efgm_barter_wd40100"] = {
        ["fullName"] = "WD-40 (100ml)",
        ["displayName"] = "WD-40",
        ["displayType"] = "Flammable",
        ["weight"] = 0.2,
        ["value"] = 4385,
        ["equipType"] = EQUIPTYPE.None,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/barter/wd40100.png", "smooth"),
        ["iconColor"] = Color(33, 43, 48, 155),

        ["sizeX"] = 1,
        ["sizeY"] = 1,

        ["canPurchase"] = false
    }

    EFGMITEMS["efgm_barter_wd40400"] = {
        ["fullName"] = "WD-40 (400ml)",
        ["displayName"] = "WD-40",
        ["displayType"] = "Flammable",
        ["weight"] = 0.6,
        ["value"] = 13020,
        ["equipType"] = EQUIPTYPE.None,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/barter/wd40400.png", "smooth"),
        ["iconColor"] = Color(33, 43, 48, 155),

        ["sizeX"] = 1,
        ["sizeY"] = 2,

        ["canPurchase"] = false
    }

    EFGMITEMS["efgm_barter_waterfilter"] = {
        ["fullName"] = "Water Filter",
        ["displayName"] = "WFilter",
        ["displayType"] = "Other",
        ["weight"] = 0.4,
        ["value"] = 29790,
        ["equipType"] = EQUIPTYPE.None,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/barter/waterfilter.png", "smooth"),
        ["iconColor"] = Color(33, 43, 48, 155),

        ["sizeX"] = 1,
        ["sizeY"] = 2,

        ["canPurchase"] = false
    }

    EFGMITEMS["efgm_barter_weaponparts"] = {
        ["fullName"] = "Weapon Parts",
        ["displayName"] = "WParts",
        ["displayType"] = "Other",
        ["weight"] = 0.4,
        ["value"] = 8970,
        ["equipType"] = EQUIPTYPE.None,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/barter/weaponparts.png", "smooth"),
        ["iconColor"] = Color(33, 43, 48, 155),

        ["sizeX"] = 2,
        ["sizeY"] = 1,

        ["canPurchase"] = false
    }

    EFGMITEMS["efgm_barter_wilston"] = {
        ["fullName"] = "Wilston Cigarettes",
        ["displayName"] = "Wilston",
        ["displayType"] = "Other",
        ["weight"] = 0.05,
        ["value"] = 5025,
        ["equipType"] = EQUIPTYPE.None,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/barter/wilston.png", "smooth"),
        ["iconColor"] = Color(33, 43, 48, 155),

        ["sizeX"] = 1,
        ["sizeY"] = 1,

        ["canPurchase"] = false
    }

    EFGMITEMS["efgm_barter_clock"] = {
        ["fullName"] = "Wooden Clock",
        ["displayName"] = "Clock",
        ["displayType"] = "Valuable",
        ["weight"] = 0.05,
        ["value"] = 52480,
        ["equipType"] = EQUIPTYPE.None,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/barter/clock.png", "smooth"),
        ["iconColor"] = Color(33, 43, 48, 155),

        ["sizeX"] = 2,
        ["sizeY"] = 2,

        ["canPurchase"] = false
    }

    EFGMITEMS["efgm_barter_lcd"] = {
        ["fullName"] = "Working LCD",
        ["displayName"] = "LCD",
        ["displayType"] = "Electronic",
        ["weight"] = 0.05,
        ["value"] = 23980,
        ["equipType"] = EQUIPTYPE.None,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/barter/lcd.png", "smooth"),
        ["iconColor"] = Color(33, 43, 48, 155),

        ["sizeX"] = 1,
        ["sizeY"] = 2,

        ["canPurchase"] = false
    }

    EFGMITEMS["efgm_barter_wrench"] = {
        ["fullName"] = "Wrench",
        ["displayName"] = "Wrench",
        ["displayType"] = "Tool",
        ["weight"] = 0.3,
        ["value"] = 2230,
        ["equipType"] = EQUIPTYPE.None,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/barter/wrench.png", "smooth"),
        ["iconColor"] = Color(33, 43, 48, 155),

        ["sizeX"] = 1,
        ["sizeY"] = 1,

        ["canPurchase"] = false
    }

    EFGMITEMS["efgm_barter_xeno"] = {
        ["fullName"] = "Xenomorph Sealing Foam",
        ["displayName"] = "Xeno",
        ["displayType"] = "Building",
        ["weight"] = 0.7,
        ["value"] = 21280,
        ["equipType"] = EQUIPTYPE.None,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/barter/xeno.png", "smooth"),
        ["iconColor"] = Color(33, 43, 48, 155),

        ["sizeX"] = 1,
        ["sizeY"] = 3,

        ["canPurchase"] = false
    }

    EFGMITEMS["efgm_barter_zibbo"] = {
        ["fullName"] = "Zibbo Lighter",
        ["displayName"] = "Zibbo",
        ["displayType"] = "Flammable",
        ["weight"] = 0.1,
        ["value"] = 6055,
        ["equipType"] = EQUIPTYPE.None,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/barter/zibbo.png", "smooth"),
        ["iconColor"] = Color(33, 43, 48, 155),

        ["sizeX"] = 1,
        ["sizeY"] = 1,

        ["canPurchase"] = false
    }

    EFGMITEMS["efgm_barter_tankbattery"] = {
        ["fullName"] = "6-STEN-140-M Military Battery",
        ["displayName"] = "Tank Battery",
        ["displayType"] = "Energy",
        ["weight"] = 30,
        ["value"] = 555105,
        ["equipType"] = EQUIPTYPE.None,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/barter/tankbattery.png", "smooth"),
        ["iconColor"] = Color(45, 37, 48, 155),

        ["sizeX"] = 4,
        ["sizeY"] = 2,

        ["canPurchase"] = false
    }

    EFGMITEMS["efgm_barter_tea"] = {
        ["fullName"] = "42 Signature Blend English Tea",
        ["displayName"] = "42",
        ["displayType"] = "Other",
        ["weight"] = 0.2,
        ["value"] = 17485,
        ["equipType"] = EQUIPTYPE.None,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/barter/tea.png", "smooth"),
        ["iconColor"] = Color(45, 37, 48, 155),

        ["sizeX"] = 1,
        ["sizeY"] = 1,

        ["canPurchase"] = false
    }

sellMultiplier = 0.5

-- types:
-- 0 == any item
-- 1 == military box (weapons, attachments, ammunition)
-- 2 == ammunition box (ammunition, grenades)
-- 3 == medical box (medical items)
-- 4 == barter box (assorted barter items & keys)
-- 5 == attachment box (attachments)

-- format: array[type][items]

function GenerateLootTables()

    LOOT = {}
    LOOT[0] = {}
    LOOT[1] = {}
    LOOT[2] = {}
    LOOT[3] = {}
    LOOT[4] = {}
    LOOT[5] = {}

    for k, v in pairs(EFGMITEMS) do

        LOOT[0][k] = v

        if v.displayType == "Assault Carbine" or v.displayType == "Assault Rifle" or v.displayType == "Light Machine Gun" or v.displayType == "Pistol" or v.displayType == "Shotgun" or v.displayType == "Sniper Rifle" or v.displayType == "Marksman Rifle" or v.displayType == "Submachine Gun" or v.displayType == "Launcher" or v.displayType == "Melee" or v.displayType == "Grenade" or v.displayType == "Special" or v.displayType == "Ammunition" or v.displayType == "Accessory" or v.displayType == "Barrel" or v.displayType == "Cover" or v.displayType == "Foregrip" or v.displayType == "Gas Block" or v.displayType == "Handguard" or v.displayType == "Magazine" or v.displayType == "Mount" or v.displayType == "Muzzle" or v.displayType == "Optic" or v.displayType == "Pistol Grip" or v.displayType == "Receiver" or v.displayType == "Sight" or v.displayType == "Stock" or v.displayType == "Tactical" then

            LOOT[1][k] = v

        end

        if v.displayType == "Ammunition" or v.displayType == "Grenade" then

            LOOT[2][k] = v

        end

        if v.displayType == "Medical" then

            LOOT[3][k] = v

        end

        if v.displayType == "Building" or v.displayType == "Electronic" or v.displayType == "Energy" or v.displayType == "Flammable" or v.displayType == "Household" or v.displayType == "Information" or v.displayType == "Medicine" or v.displayType == "Other" or v.displayType == "Tool" or v.displayType == "Valuable" then

            LOOT[4][k] = v

        end

        if v.displayType == "Accessory" or v.displayType == "Barrel" or v.displayType == "Cover" or v.displayType == "Foregrip" or v.displayType == "Gas Block" or v.displayType == "Handguard" or v.displayType == "Magazine" or v.displayType == "Mount" or v.displayType == "Muzzle" or v.displayType == "Optic" or v.displayType == "Pistol Grip" or v.displayType == "Receiver" or v.displayType == "Sight" or v.displayType == "Stock" or v.displayType == "Tactical" then

            LOOT[5][k] = v

        end

    end

end

function SpawnAllLoot()

    if SERVER then

        for _, ent in ipairs(ents.FindByName("efgm_loot")) do
            ent:Fire("SpawnLoot", 0, 0)
        end

    end

end

-- add attachment item definitions
hook.Add("InitPostEntity", "AttsItemDef", function()

    local arc9atts = ARC9.Attachments

    for k, v in pairs(arc9atts) do

        EFGMITEMS["arc9_att_" .. v.ShortName] = {

            ["fullName"] = v.PrintName,
            ["displayName"] = v.CompactName or v.PrintName,
            ["displayType"] = v.DisplayType or "Attachment",
            ["weight"] = v.Weight or 1,
            ["value"] = v.Value or 10000,
            ["equipType"] = EQUIPTYPE.Attachment,
            ["appearInInventory"] = true,
            ["stackSize"] = 1,
            ["icon"] = v.EFGMIcon or v.Icon,

            ["sizeX"] = v.SizeX or 1,
            ["sizeY"] = v.SizeY or 1,

            ["levelReq"] = v.EFGMLvl or 1

        }

    end

    GenerateLootTables()
    SpawnAllLoot()

end)

hook.Add("OnReloaded", "AttsItemDefReload", function()

    local arc9atts = ARC9.Attachments

    for k, v in pairs(arc9atts) do

        EFGMITEMS["arc9_att_" .. v.ShortName] = {

            ["fullName"] = v.PrintName,
            ["displayName"] = v.CompactName or v.PrintName,
            ["displayType"] = v.DisplayType or "Attachment",
            ["weight"] = v.Weight or 1,
            ["value"] = v.Value or 10000,
            ["equipType"] = EQUIPTYPE.Attachment,
            ["appearInInventory"] = true,
            ["stackSize"] = 1,
            ["icon"] = v.EFGMIcon or v.Icon,

            ["sizeX"] = v.SizeX or 1,
            ["sizeY"] = v.SizeY or 1,

            ["levelReq"] = v.EFGMLvl or 1

        }

    end

    GenerateLootTables()

end)