ICONCOLORS = {}

ICONCOLORS.Yellow = Color(52, 53, 36, 155)
ICONCOLORS.Red = Color(41, 33, 26, 155)
ICONCOLORS.Green = Color(31, 38, 26, 155)
ICONCOLORS.Blue = Color(33, 43, 48, 155)
ICONCOLORS.Purple = Color(45, 37, 48, 155)
ICONCOLORS.Brown = Color(54, 35, 32, 155)
ICONCOLORS.White = Color(50, 50, 50, 155)

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
        ["levelReq"] = 7,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["equipSlot"] = WEAPONSLOTS.PRIMARY.ID,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/weapons/adar15.png", "smooth"),

        ["sizeX"] = 5,
        ["sizeY"] = 2,

        ["caliber"] = "5.56x45",
        ["ammoID"] = "efgm_ammo_556x45",
        ["defAtts"] = "XQAAAQCOAgAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8ONwzg/TnvSfVBqeGuIaSSp0lbXXmmwiKc+3qpTFQPm/3TEpRkNkliqewzXeK6KEow99gDpNekcBZLljEK1yteXPgcDvoY1gzY43rtGqP1p7jD5gej6NEa+QNcT8BXtXPmN5o2OkWkgurm/9AXyGT4En6CkA7mCMaVO2Yf9O7uShDeIXUNI/H0SBmpgNixBxQz+E/0uWDE5UIaP9BN26bE1xGemXO43rgNPGIOjvq9ftb9M37Yo7ZQ5zoYq34ipfXEhRIpOJESzA==",
        ["duelAtts"] = {
            "XQAAAQCOAgAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8ONwzg/TnvSfVBqeGuIaSSp0lbXXmmwiKc+3qpTFQPm/3TEpRkNkliqewzXeK6KEow99gDpNekcBZLljEK1yteXPgcDvoY1gzY43rtGqP1p7jD5gej6NEa+QNcT8BXtXPmN5o2OkWkgurm/9AXyGT4En6CkA7mCMaVO2Yf9O7uShDeIXUNI/H0SBmpgNixBxQz+E/0uWDE5UIaP9BN26bE1xGemXO43rgNPGIOjvq9ftb9M37Yo7ZQ5zoYq34ipfXEhRIpOJESzA==",
            "XQAAAQA9AwAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8ONwzg/TnvSfVBqeGuIaSSp0lbXXmmwiKc+3qpTCtabMPt239l5e5Envvl0bddKHhpL0T/HlKQHBLYkSzAti2tF4parjEbp41xc169y9pm2bvitymY/ISXr4MZwLzWiPwydWKcHvCvV24NbmTjZv88uIvNRfV86CikssG/G3yHH4oU8BHzScEcJLHQUpuuCoGipN/Y+3+8XZbX8JtM+nvmYPZo3avCKNv7CgBT9t8rHaRWUghsv8NiXTyER4Sk5Mx0IoqIdeGisFr5Hhz5+3SmRoUrKsa+mVZq4dW4OWvbMxpYN/f1Kvx1WjKfmjq/lyKEMH46fEG/zfzgJNTqmrJA",
            "XQAAAQClAwAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8ONwzg/TnvSdRKMPYpDULfQayPik8I0xIa1V4p70qzQz4qKF0PIh4SbuLXb88KqILYpkjT72yPzjIcxWwwUxVU1jbGG27bwwJCYAwMCFTyMja6Vbb91U91856iAxIpY0TFV6tVkgnVWhs9HU5cMGqP0UNlG4ytzJpXCaitRnGRRi3nrIlNPpChs1mc3jixmnsXQl2vEt6j1AxqDSp+u0LKFwFhXHj2zbGDmSZzh9Aqs2qc0sWkiORorGLETPL5VRT4NpRCe8T3fGaR/M2UQvQvMMzTPAM8mP4ZSjLRjYwUfKwicGMPb5FvKQpTyMM3JPEmvRfbZM1bT/QD2f43a0ibZKUzLP7EKadUTvxHgmMoPt+JZ+35fSn7pkkcnCU4EAoPfVGrwbxoxu1EIqxmKMjiDP8ZHderxmjCmwpFwjE="
        }
    }

    EFGMITEMS["arc9_eft_vsk94"] = {
        ["fullName"] = "KBP VSK-94 9x39 rifle",
        ["displayName"] = "VSK-94",
        ["displayType"] = "Assault Carbine",
        ["weight"] = 2.9,
        ["value"] = 65000,
        ["levelReq"] = 5,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["equipSlot"] = WEAPONSLOTS.PRIMARY.ID,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/weapons/vsk94.png", "smooth"),

        ["sizeX"] = 5,
        ["sizeY"] = 2,

        ["caliber"] = "9x39",
        ["ammoID"] = "efgm_ammo_9x39",
        ["defAtts"] = "XQAAAQA/AQAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8OxEj3M6NEz3RX71XCYfOHncMteTkzK1bNnD0ch1JesVcWATp5G09k+0YVg1cAGkdsOIfs+Qsr2LRnuer24UJlIh2n7Lb+WaPCEhTW7X4aZOJQnELQOIJoBY9Wi+SDFpx1kjJ6Uad1mbVmwii/9f4XHyIA",
        ["duelAtts"] = {
            "XQAAAQA/AQAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8OxEj3M6NEz3RX71XCYfOHncMteTkzK1bNnD0ch1JesVcWATp5G09k+0YVg1cAGkdsOIfs+Qsr2LRnuer24UJlIh2n7Lb+WaPCEhTW7X4aZOJQnELQOIJoBY9Wi+SDFpx1kjJ6Uad1mbVmwii/9f4XHyIA",
            "XQAAAQBXAQAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8OxEj3M6NEz3RX71XCYfOHncMteTkzK1bNnD0chwcKKUK5HlSEyBPS4c2TJiGRraBGEbOHAPSDWnEJPKpKFtKcOqJGeulMy9aVelAFt7lqPIr8L3vyrt7E4UXn4902BoBdZeyYlwlADD1YLivKWJMxWHfcdCcKa97aRcNlbBvw2QA=",
            "XQAAAQCMAQAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8OxEj3M6NEz3RX71XCYfOHncMteTkzK1bNnD0ch1JesVcWATp5G09k+0YVg1cAGkdsLo9REvLW3dFgxOH13dQGY0WI7GqSe2ACQpx6TLoIqbiszTsP/6koU9/N2OQ2LLn88lIieI+0UlE8Np8AHs83RIK6TAX+/vTCUOOy2XSHOR/as5urvFb6q1GA"
        }
    }

    EFGMITEMS["arc9_eft_rfb"] = {
        ["fullName"] = "Kel-Tec RFB 7.62x51 rifle",
        ["displayName"] = "Kal-Tec RFB",
        ["displayType"] = "Assault Carbine",
        ["weight"] = 3.6,
        ["value"] = 54000,
        ["levelReq"] = 17,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["equipSlot"] = WEAPONSLOTS.PRIMARY.ID,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/weapons/rfb.png", "smooth"),

        ["sizeX"] = 4,
        ["sizeY"] = 2,

        ["caliber"] = "7.62x51",
        ["ammoID"] = "efgm_ammo_762x51",
        ["defAtts"] = "XQAAAQDDAQAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8OIQMOqZA7fASOsjTnTK+5tyMtCf5S3eX59xP8WN23ZyQ+TvTCJsvjaq82IMiiV5QK4szoA/bMyTYpFaTqx2PI3pyhTcPsdIapPnru67+fzz/K1Z98VMZLR5TH+9vSJvHtElLmmrpKaxP05iuKyCE3B82cC/39buGs4Xs3pwLSUfyGDxFBNOLpzIT/3ATm4tb2tvIjp5o=",
        ["duelAtts"] = {
            "XQAAAQDDAQAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8OIQMOqZA7fASOsjTnTK+5tyMtCf5S3eX59xP8WN23ZyQ+TvTCJsvjaq82IMiiV5QK4szoA/bMyTYpFaTqx2PI3pyhTcPsdIapPnru67+fzz/K1Z98VMZLR5TH+9vSJvHtElLmmrpKaxP05iuKyCE3B82cC/39buGs4Xs3pwLSUfyGDxFBNOLpzIT/3ATm4tb2tvIjp5o=",
            "XQAAAQBmAgAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8OIQMOqZA7fASOsjTnTK+5tyMtCf5S3eX59xP8WN23ZyQ+TvTCJsvjaq82IMiiV5QK4szoA/bMyTYpFaTqzlnq48bL5gC1qev1wA6vI7h989K/yLmVUs6CuMQdJApRB7A26puwyvR40/4BCVzACwEEuN0bJ+x2V53EKj+4O4llvgZzOY0l6PpUwTdtHcQaGaZqFmzbin5f38Y5DDqcqtejHCOu8DuCsj3ffnhGTShFvN38PRM86a2GGTojJcPO0boOAn4g",
            "XQAAAQA4AwAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8OIQMOqZA7fASOsjTnTK+5tyMtCf5S3eX59xP8WN23ZyQ+TvTCJsvjaq82IPwrNzQrMBF8wZDYUs/hEa2GVvStJP1qn3PP+vJ383doyxT2WUvm9TY1coSfXXIaNw/60MDSg12EtHQLcJcI9tSPn3lvRp2xEidlt2eOzaHNZstLCKXQMo44qJQuJl16QOiC6phWsNA9qRLBmxwORadtz0XeYfiGEEa+vaHhK+VNpu59RYQz2J6i08LBaBPJuMPEIijjURVmOBeJiCEW4U4S2qALtjNn7B1KRO1GjxwNfR3GFRU7Gs7a7vcYlb2txICJCDGr30SV+qZ+bsgorzwA"
        }
    }

    EFGMITEMS["arc9_eft_tx15"] = {
        ["fullName"] = "Lone Star TX-15 DML 5.56x45 carbine",
        ["displayName"] = "TX-15 DML",
        ["displayType"] = "Assault Carbine",
        ["weight"] = 3.3,
        ["value"] = 95000,
        ["levelReq"] = 27,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["equipSlot"] = WEAPONSLOTS.PRIMARY.ID,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/weapons/tx15.png", "smooth"),

        ["sizeX"] = 6,
        ["sizeY"] = 2,

        ["caliber"] = "5.56x45",
        ["ammoID"] = "efgm_ammo_556x45",
        ["defAtts"] = "XQAAAQDhAwAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8ONwzg/TnvSdRKMPYpDULfQayPik8I0xIa1V4p75pAWrkNCWfG14EWqVFlNWIJHALRyRr6Wv5/v88HRQXfKH/4ARquI8d3vb21586V6xlvlXftbXMlZYGgYlff+EJZnB1UiyxOnx/3jU7Ptkma716R1vGAVnyoL6zWNKQVW3ykXCqG9Vci+jdv8bDPtb14XTLUpe7VZVmZ/J26lO0tkYcSzZlpBfLbVCjPGyE+VaLvR1GS1Ih9dntYX89MPPENC7ODH7u3kReM4aW+/vZ+ejx0d3fWB8mVTZG4vVZoZte34hySnGfmqNySAy/FjsDEXN/IOry6GQnfMss6pigejnyJ0LzjZogmlS1CE0vQF/ekE4ebAA==",
        ["duelAtts"] = {
            "XQAAAQDhAwAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8ONwzg/TnvSdRKMPYpDULfQayPik8I0xIa1V4p75pAWrkNCWfG14EWqVFlNWIJHALRyRr6Wv5/v88HRQXfKH/4ARquI8d3vb21586V6xlvlXftbXMlZYGgYlff+EJZnB1UiyxOnx/3jU7Ptkma716R1vGAVnyoL6zWNKQVW3ykXCqG9Vci+jdv8bDPtb14XTLUpe7VZVmZ/J26lO0tkYcSzZlpBfLbVCjPGyE+VaLvR1GS1Ih9dntYX89MPPENC7ODH7u3kReM4aW+/vZ+ejx0d3fWB8mVTZG4vVZoZte34hySnGfmqNySAy/FjsDEXN/IOry6GQnfMss6pigejnyJ0LzjZogmlS1CE0vQF/ekE4ebAA==",
            "XQAAAQB0AwAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8ONwzg/TnvSdRKMPYpDULfQayPik8I0xIa1V4p70qzQzxN7LK//g71+T4hWAv2Kam3Yexv28D9fp8PzMUX99Oxjt8vEpVZzZrnUHJO3f4lfezHome2xx8Y9tkH29M8vBFz+x4QnYfYCE2rByufVMOcUNu9AC2YCWe7Zrgxi4zA8WhvyWTfx6n+i5Y42V9As4Zc3qSoDsWJP9HM9t23DvezNE5GFEu217oOczjLZNJxI6e3jpScRUDG1WZ2aKmAUDdcd2f8ZBawVDxWBPpv6kiffzKRgq7zhPeEdBoU8iGH61CmnH2jXvlt+MEb2xUbuRyMxRgve6vB0z6LmmuT1N5M30Qwx774Wpok72S1LqUeFFwguGzRtby6KbFD4D5Yniw=",
            "XQAAAQBfBAAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8ONwzg/TnvSdRKMPYpDULfQayPik8I0xIa1V4p75pAWrkNCWcbTygcbsZCMzG4NlQpDOT+gVxh4DTytNcpqqBnDiY31YFUWHwjKGNmz0+z8rehfb9mHRt78FJMgzFG2OYIHyLKAcApL7dmqm7PmNjU+hPXJz4CyepCFiQWiWwf/TseQ5cGztGmQcQ5H8OkyBfCwySbX5iRT5FbVNOcQ9J2W0UqAFJL3sCT/Xw5DQ3OwgruSzUkaZovbVjkHAcUH5O2O4bvgd7VExgdW/YvXng6IFtAujxQl8DR+BFs90KqyKR11e+5JffyiPYoIsKY6p2OgvDXWf+k8ZLHMWWOFjzowh82TfzcdRnO+qKMNZYwboHj7Don3pRO2gHIA+5sxgPz3ArzJg+2e/v2ORTd9VL6eaVfW4DDY9bBxbo/SrJpwn/iuWSzckGYKqcYHj+GiX0A"
        }
    }

    EFGMITEMS["arc9_eft_sag_ak545"] = {
        ["fullName"] = "SAG AK-545 5.45x39 carbine",
        ["displayName"] = "AK-545",
        ["displayType"] = "Assault Carbine",
        ["weight"] = 4.4,
        ["value"] = 54000,
        ["levelReq"] = 21,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["equipSlot"] = WEAPONSLOTS.PRIMARY.ID,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/weapons/sag_ak545.png", "smooth"),

        ["sizeX"] = 5,
        ["sizeY"] = 2,

        ["caliber"] = "5.45x39",
        ["ammoID"] = "efgm_ammo_545x39",
        ["defAtts"] = "XQAAAQB+AgAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8NWDT+kEGPPnFlfSScSybP+C3Y0ij7z9iVh7t2mLczDAV3rxV/Tab/+5LCblM65d7iYCxVFrOjRr/G08xhEUw/hd4M+7+9I6N15rAON7hFd9OZPaqOS5X/KJSf+lo+SNzvIgxOHwtgKVmQx95wSO5F2wsaRQWeYn2YiczkbY14ycHPheO6MymGa2y/n1p0vmkOg2rFcvh5GvzRFnN5i6ITBbwdnh2rosValGwtTY4j2ZR596OTW/6hX2n+7VZe",
        ["duelAtts"] = {
            "XQAAAQB+AgAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8NWDT+kEGPPnFlfSScSybP+C3Y0ij7z9iVh7t2mLczDAV3rxV/Tab/+5LCblM65d7iYCxVFrOjRr/G08xhEUw/hd4M+7+9I6N15rAON7hFd9OZPaqOS5X/KJSf+lo+SNzvIgxOHwtgKVmQx95wSO5F2wsaRQWeYn2YiczkbY14ycHPheO6MymGa2y/n1p0vmkOg2rFcvh5GvzRFnN5i6ITBbwdnh2rosValGwtTY4j2ZR596OTW/6hX2n+7VZe",
            "XQAAAQDBAgAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8NWDT+kEGPPnFlfSScSybP+C3Y0ij7z9iVh7t2mLczDAV3rxV/Tab/+5LCblM65d7iYCxVFrOjRr/G08xhEUw/hd4M+7+9I6N15rAON7hFd9OZPaqOS5X/KJSf+lo+SNzvIgxOHwtgKVmQx95wSO5F2wsaRQWeYn2YiczkbY14ycHPheO6MymGa2y/n1p0vmkOg2rFc+LlAThMwRUUL3Z2x8FmIuoFBeYcrR/spEtKAUOL04Wh5kL7OSSojPgMEljVVl01LfOA90zGxqoktriT1o9KAA==",
            "XQAAAQDiAgAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8NWDT+kEGPPnFjskkojommSaQCNlMpRvkic1YAIsLcoCrGt5qdQEyzvK29oDxopkFM+OvV//c2uk8qSrL8OaQ9VlRoZG7KNa6RfekoPbR99ysy7ZLO8Uew+qalRqpAF5EDCPhzPNFz9G3hbFZJKqRwQmYkS39Bk9rsO4I5CDnY2+jFQ8nW+Qa1LdQ5aFFDIfOIAKw9iaHooKyjeIh0gH7c2Rp2OVxBLEoLWfZKoaNc/abqBOUAdghRQOyrlHaxPFJ1w28aQcF+R2ZGx6r1MMmlAHeArTWywoDrjROsgt8uAA=="
        }
    }

    EFGMITEMS["arc9_eft_sag_ak545short"] = {
        ["fullName"] = "SAG AK-545 Short 5.45x39 carbine",
        ["displayName"] = "AK-545 Short",
        ["displayType"] = "Assault Carbine",
        ["weight"] = 4.3,
        ["value"] = 63000,
        ["levelReq"] = 20,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["equipSlot"] = WEAPONSLOTS.PRIMARY.ID,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/weapons/sag_ak545_short.png", "smooth"),

        ["sizeX"] = 4,
        ["sizeY"] = 2,

        ["caliber"] = "5.45x39",
        ["ammoID"] = "efgm_ammo_545x39",
        ["defAtts"] = "XQAAAQCBAgAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8NWDT+kEGPPnFlfSScSitKC3h96j2MfwFs9lVZzbkxhsM84Ocm2m12AHZKDY7Lm7vCn2PU4az/K5SN/zP226NxzPE72JF0Onfk/TfCglJZOlG9nCAUuCFMsCbSO0Hxvy1RspZ8Qcxzr+bPsEBDSbRHkcnyzUDGfF42qKWcPVorGQQYc0bYElrOn3dBvQkNntCZQHNaU+iHlRyEfzmqTUGeT9L+SATgPl/aF+zDDk9nX8D7NUMubW0ZG9XcN07sW0Y=",
        ["duelAtts"] = {
            "XQAAAQCBAgAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8NWDT+kEGPPnFlfSScSitKC3h96j2MfwFs9lVZzbkxhsM84Ocm2m12AHZKDY7Lm7vCn2PU4az/K5SN/zP226NxzPE72JF0Onfk/TfCglJZOlG9nCAUuCFMsCbSO0Hxvy1RspZ8Qcxzr+bPsEBDSbRHkcnyzUDGfF42qKWcPVorGQQYc0bYElrOn3dBvQkNntCZQHNaU+iHlRyEfzmqTUGeT9L+SATgPl/aF+zDDk9nX8D7NUMubW0ZG9XcN07sW0Y=",
            "XQAAAQD7AgAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8NWDT+kEGPPnFjskj5PLiCdqpBmPRo+JsqdrBY6r8vJDG3yMAYNBdSUbSg7O75lJe1T2djudPGxCyCygVTaW6SYh4CNjCMhzl6lBBUdca2nQk7s7OJ0fd2EeLWws96FUezwbsPQc1ae76yBFpP9Ffb8Bj3LWC8F8rooObm3v0/JHc3fNwcnpyGWkkynaCXvZOX1pbVSEgseqVPfyVPuENEMkQRN4V0jLkNUHKo6+rRybmHYqf/fdBHXDqRHP9bw5zgSWEZeoFgQXlbrSFOS8Q8nKu9YBZWm5MIHAbD8sUkoA==",
            "XQAAAQB7AwAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8NWDT+kEGPPnFjshAgt7e+ktc496fkxw/gc0qwHzR3PVi76qdo4FR6uMLOVkE37k1CFIoLtfQjFoFWEe7yPv7gEKbDo02MmeUtZsxBc0aWN4xKxCOIKGSizr8MdiFZq8yrWVCJkjG7838LMtLGmu8GpG8Sxdgi5nAiHc1G+JtF+Mz7BhVbV3hI720u125m+n0rRH5oa2phLhypy50pJgHvCjUgEblKeqsDe/B1Kh5irlpPteTa2CCCfb0dNTlC1WfvEjnYajoBm5DXLgjRFbHHN7CVOyHU8deY+9CK6GqCUP1Ws7pWvK5F2HdWRhs9tqcC5OI/1AkpPWY2D8YvG7otG0O/9HatwcS2bw9PrIn0AA=="
        }
    }

    EFGMITEMS["arc9_eft_sr3"] = {
        ["fullName"] = "SR-3M 9x39 compact assault rifle",
        ["displayName"] = "SR-3M",
        ["displayType"] = "Assault Carbine",
        ["weight"] = 2.5,
        ["value"] = 167000,
        ["levelReq"] = 40,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["equipSlot"] = WEAPONSLOTS.PRIMARY.ID,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/weapons/sr3m.png", "smooth"),

        ["sizeX"] = 3,
        ["sizeY"] = 2,

        ["lootWeight"] = 65,

        ["caliber"] = "9x39",
        ["ammoID"] = "efgm_ammo_9x39",
        ["defAtts"] = "XQAAAQBoAQAAAAAAAAA9iIIiM7hMNz0dhIkbkvLjTdSR5gRNNIHH3iMy0YgfJ5Lm1K8QmyKhGRtnNHx3kcm9IN0ZKMDsA9aRJyB2BQGcJAY6GYLfG2kqLcGFAtoF5Av9QyRQsV9TgKhSRE1hFodzywbKc8ROcdk0pygDZULgrqj6VRj6SNnhCb8KZolQ+paSigJbPyIM3gC8zmp8dRzZeAA=",
        ["duelAtts"] = {
            "XQAAAQBoAQAAAAAAAAA9iIIiM7hMNz0dhIkbkvLjTdSR5gRNNIHH3iMy0YgfJ5Lm1K8QmyKhGRtnNHx3kcm9IN0ZKMDsA9aRJyB2BQGcJAY6GYLfG2kqLcGFAtoF5Av9QyRQsV9TgKhSRE1hFodzywbKc8ROcdk0pygDZULgrqj6VRj6SNnhCb8KZolQ+paSigJbPyIM3gC8zmp8dRzZeAA=",
            "XQAAAQC5AQAAAAAAAAA9iIIiM7hMNz0dhIkbkvLjTdSR5gRNNIHH3iMy0YgfJ5Lm1K8QmyKhGRtnNHx3kcm9IN0ZKMFHVpqUFKW9uY/1hKW4iBDtn70vbJBJpc5KS1+PIERCdPtNaJGuoDz9XF/FlTk5K7Rtyo7j8d4wRg8S1/m3jSCkBj2JVv0HGmUsv0msTcv9QNN8T0DTGDwRbbe08Xyi8c+JguOhCvWrdxfgdtUuIhn1MxVT",
            "XQAAAQCFAgAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8OSroLMctq9+4ibHH8vqEnjI4QhyEg7C+gu4ZAkRBN2TZ5SPC0WLO+W2ngZxPFdQAo+HqMl64Jn16bdtukqNqSpgo9N8jIAZ6LsUZ2mV7kfU/qh+RrT68Knc3hm+Ddtp5rLOpbzazSxYHBeEvje8LWKTvNeWdd/srG1Jp+d7SAOWW39PYzFUxvjZQb/dW5L6P6dUEJEg7MgfrO268bga5zSXbGaTK98+pfYybt9tT713Dez96VBC4NpEpEhn/Ja09EA+gO45Wqr+Adyr4A"
        }
    }

    EFGMITEMS["arc9_eft_svt"] = {
        ["fullName"] = "Tokarev SVT-40 7.62x54R rifle",
        ["displayName"] = "SVT-40",
        ["displayType"] = "Assault Carbine",
        ["weight"] = 4.1,
        ["value"] = 64000,
        ["levelReq"] = 11,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["equipSlot"] = WEAPONSLOTS.PRIMARY.ID,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/weapons/svt.png", "smooth"),

        ["sizeX"] = 6,
        ["sizeY"] = 1,

        ["caliber"] = "7.62x54",
        ["ammoID"] = "efgm_ammo_762x54",
        ["defAtts"] = "XQAAAQB6AQAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8OSzbA7bh+n22rgF3eZfKtFbSq5Sv+U+sy+44faPgqnhcKVRO4XjwHGPSoIh7Eyzb+O4+J8wGaj+XHNqll6K87d1ISHf4dqwegtt2oyHmnvVS5LvAV7DerEoOhNerbQm4BKVKDKlTI3EcZpjGzrUpmsVbObipc2xgipczd6X/2KSKZ5rf9HQ==",
        ["duelAtts"] = {
            "XQAAAQB6AQAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8OSzbA7bh+n22rgF3eZfKtFbSq5Sv+U+sy+44faPgqnhcKVRO4XjwHGPSoIh7Eyzb+O4+J8wGaj+XHNqll6K87d1ISHf4dqwegtt2oyHmnvVS5LvAV7DerEoOhNerbQm4BKVKDKlTI3EcZpjGzrUpmsVbObipc2xgipczd6X/2KSKZ5rf9HQ==",
            "XQAAAQDYAQAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8OSzbA7bh+n22rgF3eZfKtFbSq5Sv+U+sy+44faPgqnhcKVRO4XjwHGPSoIh7Eyzb+O4+J8wGaj+XHNqll6K87d1ISHf4dqwegtt2oyHmnvVS5LvAV7DerEoOhNerbQm4BKVKDKlTI3EcZpjGzrUqMMVLw4c4Bxj0Ow6DJbgMOwIU6DDq0AjdnsoNB11FBpT3HB82zDFC7aeBosffinLw="
        }
    }

    EFGMITEMS["arc9_eft_sks"] = {
        ["fullName"] = "TOZ Simonov SKS 7.62x39 carbine",
        ["displayName"] = "SKS",
        ["displayType"] = "Assault Carbine",
        ["weight"] = 3.7,
        ["value"] = 29000,
        ["levelReq"] = 1,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["equipSlot"] = WEAPONSLOTS.PRIMARY.ID,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/weapons/sks.png", "smooth"),

        ["sizeX"] = 5,
        ["sizeY"] = 1,

        ["caliber"] = "7.62x39",
        ["ammoID"] = "efgm_ammo_762x39",
        ["defAtts"] = "XQAAAQDeAQAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8OSgZMg8rR1f1NriFw604PtByzx3OWWZtOO4j0PQ2t5a1OGJX8eUlI9fNvLL68bctwYP8ZatKY+oTkz82RpebfT+LImbnfnVcexmiiZa0A5CUTPYWS9RAQTvDWST4QO/CBTeDXHHhB4cJK3NtOwRWC61qABII+gzX5mv+54qT8t54sGw6aF78vepy4igYkAA==",
        ["duelAtts"] = {
            "XQAAAQDeAQAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8OSgZMg8rR1f1NriFw604PtByzx3OWWZtOO4j0PQ2t5a1OGJX8eUlI9fNvLL68bctwYP8ZatKY+oTkz82RpebfT+LImbnfnVcexmiiZa0A5CUTPYWS9RAQTvDWST4QO/CBTeDXHHhB4cJK3NtOwRWC61qABII+gzX5mv+54qT8t54sGw6aF78vepy4igYkAA==",
            "XQAAAQCOAwAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8OSgZMg8rR1f1NriFw604PtByzx3OWWZtOO4j0PQ2t5MMUo7Fl3NUrzT6qQQamm0Abjb8zXnU5HRdydPxh2VEx9Z4H6O2tN8IGIzjYl3Jf/VMFi7HqpTvYKCeitop6wPu2TC6ASUXz/bUTSpSg95w2XO2BzTkdcSASwmXI8Sq8FrhlYuU0fjUACaVqGEzCtJjfiGz9aNylbOzU9+oRE3K37c74GoT4kXzq/rKziLDzUmz4YiHlYCe/kfVxY4E8WwmRkWWWbe51t17gOG+tPBsyJoA6Xb7ykY/cRiJFTeIaM8RFaYVcdg==",
            "XQAAAQC/AgAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8OSgZMg8rR1f1NriFw607pjYXW+8tML5H2fn/WXWwU6hRMVk9vLFDJpfcjVasFQicwjWMNXTM/yPwRiYPhE1lFAci7NUG5gtAuBWe2Hvbo+4Zbpsr3z+wJ6TExGpMiOX3K4+zOroiOjYhbD9/lMB7WgVskC+V27koHhRnA5u0ARLhjWSkBIjqsDXODHDLLuLZ3q9T0Lkd+3BgzXFg22fTa6dJstE9YB3Y06LeyPlnPZKdlnVSin+zpte5fo33V7ghH5sLjsKA="
        }
    }

    EFGMITEMS["arc9_eft_vpo101"] = {
        ["fullName"] = "Molot Arms VPO-101 Vepr-Hunter 7.62x51 carbine",
        ["displayName"] = "VPO-101 Vepr-Hunter",
        ["displayType"] = "Assault Carbine",
        ["weight"] = 3.8,
        ["value"] = 44000,
        ["levelReq"] = 5,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["equipSlot"] = WEAPONSLOTS.PRIMARY.ID,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/weapons/vpo101.png", "smooth"),

        ["sizeX"] = 5,
        ["sizeY"] = 2,

        ["caliber"] = "7.62x51",
        ["ammoID"] = "efgm_ammo_762x51",
        ["defAtts"] = "XQAAAQApAQAAAAAAAAA9iIIiM7hMNz0dhIkbkvLjTdSR5gRNNIHH3iM11FXbdH8EhvqeVEf4e8s8pqSUeHr5dxjuk5VJ16uZIcKjKrixVz39yI+NMVUz4BMktvpaajFsUrpQQ991pxbvCO8lQKmywBJ6rWU6guUPzN0KWgGObGzJIr8A",
        ["duelAtts"] = {
            "XQAAAQApAQAAAAAAAAA9iIIiM7hMNz0dhIkbkvLjTdSR5gRNNIHH3iM11FXbdH8EhvqeVEf4e8s8pqSUeHr5dxjuk5VJ16uZIcKjKrixVz39yI+NMVUz4BMktvpaajFsUrpQQ991pxbvCO8lQKmywBJ6rWU6guUPzN0KWgGObGzJIr8A",
            "XQAAAQBXAQAAAAAAAAA9iIIiM7hMNz0dhIkbkvLjTdSR5gRNNIHH3iM11FXbdH8EhvqeVEf4e8s8pqSUeHr5dxjuk5VJ16uZIcKjKrixVz39yH3+vajQYWgzuJIXNsKPITD99Ci7VE37tjeDNQIvyGnl+zw/ilSv/lAyYfmIO6H0/tcZ1bizozE84cJisLZ4n/GGsAZeJGwbJnItHkjVHvapxKIUGv+x",
            "XQAAAQDPAQAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8Ow/iPb1tQHdLBKCLRkGlKp35rBQAtzLQKTO2eosOSgxaV+qywjmk8DJIfnuDPnkacmoKU76s6WOgmzlCtJvaLNbDiSb/TCoxn1Q5As5dfGPqok6KL//vhR2hOOYB91vHLGnSprxXvcf1MTT99ukCMtZ0Hjuw9ApsAQnYB5ElfIfY8bQwCaOvSmlVcdDqSzP0q2St1atjlJSA="
        }
    }

    EFGMITEMS["arc9_eft_vpo136"] = {
        ["fullName"] = "Molot Arms VPO-136 Vepr-KM 7.62x39 carbine",
        ["displayName"] = "VPO-136 Vepr-KM",
        ["displayType"] = "Assault Carbine",
        ["weight"] = 3.2,
        ["value"] = 33000,
        ["levelReq"] = 4,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["equipSlot"] = WEAPONSLOTS.PRIMARY.ID,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/weapons/vpo136.png", "smooth"),

        ["sizeX"] = 5,
        ["sizeY"] = 2,

        ["caliber"] = "7.62x39",
        ["ammoID"] = "efgm_ammo_762x39",
        ["defAtts"] = "XQAAAQAuAgAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8NWDT+kEGPPnFjslbt4xbIPd/q60hodE43tM1ytr7bEv2N6nxkaKveBZRkZUauda0ZYGJLOlmOSCuDhTa3lybTfDnW8PlYla1TjpOTM44622G+Fu1yLJZEUlu+WYLoqDgn5Q0qpQ5cQaGBRB7jVRUzOaos2wCkolw/ZW8XD00nBhh9rMhXARH3RO+9AXj5TL2Rm7HKQ5xAKwa1pbLwXHZoAl1AXeu8rNavxEdKZFPuTuU/6E2nG30KkPKaH7c=",
        ["duelAtts"] = {
            "XQAAAQAuAgAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8NWDT+kEGPPnFjslbt4xbIPd/q60hodE43tM1ytr7bEv2N6nxkaKveBZRkZUauda0ZYGJLOlmOSCuDhTa3lybTfDnW8PlYla1TjpOTM44622G+Fu1yLJZEUlu+WYLoqDgn5Q0qpQ5cQaGBRB7jVRUzOaos2wCkolw/ZW8XD00nBhh9rMhXARH3RO+9AXj5TL2Rm7HKQ5xAKwa1pbLwXHZoAl1AXeu8rNavxEdKZFPuTuU/6E2nG30KkPKaH7c=",
            "XQAAAQBUAwAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8NWDT+kEGPPnFjslbt4xbIPd/q60hodE43tM1ytr7bEv2N6nxkaKveBZRkZUauda0ZYGJLOlmOSCuDhTa3lyR1BylVzQ++xfkWZoznMjaz7WxC/UR4DiW+imwcqK/ZxINglrDjYb8EZQTd2+POg6XIVh5ZtlqFLjHxjbwax/wpv6I4TLWwWNIvkpzdkjMZKcy+EiXlXKdw0ciMMjTt4EgpC9RHcyXrgIBPA0L+YlLm7fWVqmWEtsHEJ1Ewx59CIKtTFf+NxFGO7iUi2FN88c/sUMdXkIl3VHks93SOhgfTzu4yOR9dO4Rp2luOuufhpXV6A5eRSwTjFsGDzvrkHhbiQOoxSGO7AA==",
            "XQAAAQCmAwAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8NWDT+kEGPPnFlfSyIS9gl64nnoxnwaqihNUCvDNOglUTHdtHZMpZNjKKRTeHQyxqzCAkmi7jU9EPY/W14wugjKPAnnh8653Q0Cj1Izala5nWcwCNDpzUfMQjiAiPRwp8+q/ignfMEv3qdC7EBgHXLZtx2BSBOiwnd5HNHx3jNlJftAkrEMzB3y+dY+vBI/vzJ6HGv9IUyd9jwtWzT9TTPdSv8boSElsvfHHDCz3WN3tAg4Emow10JuqVKZMMDQYutJ6aygkUAvgRxbA9o/fnxaeSTDjJj1ROs0EYR4hpaUGJa7I/QbLSocT8fY8Lv0NQOrzRsqeNhKbLCL8OYWJi8FyQqfP2Wokm+8oQ="
        }
    }

    EFGMITEMS["arc9_eft_vpo209"] = {
        ["fullName"] = "Molot Arms VPO-209 .366 TKM carbine",
        ["displayName"] = "VPO-209",
        ["displayType"] = "Assault Carbine",
        ["weight"] = 3.2,
        ["value"] = 35000,
        ["levelReq"] = 8,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["equipSlot"] = WEAPONSLOTS.PRIMARY.ID,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/weapons/vpo209.png", "smooth"),

        ["sizeX"] = 5,
        ["sizeY"] = 2,

        ["caliber"] = ".366",
        ["ammoID"] = "efgm_ammo_366",
        ["defAtts"] = "XQAAAQAtAgAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8NWDT+kEGPPnFjslbt4xjmVkJBjle8bjtok2Ua8haAP+W7CrzgCP8lRbkXtTOXSnQ59p7RSkhFnm7rDKP3TZqZ2FvTqbFAqb4BJ0neIez5VROHBPR8YPzC9OI3tAC8HhYOuXh2hTUT7GEgp9Ck5ja5eJnuDC3WfWIJ1hLNqg9NXvkjaA3c4rI1W6U5FbjPnAOxjJ52vrb4dfq6Jeacsvi79ZUINJmjTy8v7Ze9ohVBEwURQyE+Jw==",
        ["duelAtts"] = {
            "XQAAAQAtAgAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8NWDT+kEGPPnFjslbt4xjmVkJBjle8bjtok2Ua8haAP+W7CrzgCP8lRbkXtTOXSnQ59p7RSkhFnm7rDKP3TZqZ2FvTqbFAqb4BJ0neIez5VROHBPR8YPzC9OI3tAC8HhYOuXh2hTUT7GEgp9Ck5ja5eJnuDC3WfWIJ1hLNqg9NXvkjaA3c4rI1W6U5FbjPnAOxjJ52vrb4dfq6Jeacsvi79ZUINJmjTy8v7Ze9ohVBEwURQyE+Jw==",
            "XQAAAQCYAgAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8NWDT+kEGPPnFjshQrWFWnl+7IBc2pvfQjJnp4imzJC1a+eyvpa///QK4nSKZOoyxZd2eU/CkF0c8UxwdlQBiI/DlE4zQXvbULBqjzPandy1c4Tict1jqqzkdPNfBaxdgGAn+ek5X3hEWXQ+5kQgtGXioW74wVXJJxMMp56DV25qq/TgN8LkK7V1TiGxkk+WZqhgp+rHcALeOUSz6YZUEWtbwGxfF6RgHYsEDwXNKHjfIELiI7/8tPY1Nz63Alc5IV2u3iyluXg/zlBmO2RUty1+1ZVaEPpZQXQIxd/tqr9fzc1cFM86L9V8XWe6A=",
            "XQAAAQAdBAAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8NWDT+kEGPPnFjslAXRm2oGP1QxSv8Ej6z2NALe32xGObzHUEI0QLGYs7nEBySqi1U7NzTprEgJfX7Zvfl8YETy33GWIwBC37B7SjyUQ43Vddn5uvtRQgo0v2AKY0Jjs8TDUVI/egQllY7f4mUv0b8B1wsNF88RxldZZcC37njP4WZKJEKk/2UuKvw4qwUuP9JM4Jx3FlSU6/3xHlFGM4EyGubibkXvrkl8Lr1zJ1OIKjgqq1gILi+S0s4Zq7lRCQ+aKx3yu4Oe/gHwT8LEGEjRe96FQ87MPesvZ4enVRt8f0ldfj+4T04CckenEVJN7lWrI7ngm44G+Am+hsBye3y8kcgj+eh/bTREimz12hmUvM46BnglzE4q7mNvf7bdjpiIayp8egIU5XXovdcS793vSC+lntOp6e3ywaUt17jymK7mUXcaIOZAA=="
        }
    }

    -- assault rifles
    EFGMITEMS["arc9_eft_velociraptor"] = {
        ["fullName"] = "Aklys Defense Velociraptor .300 Blackout assault rifle",
        ["displayName"] = "Velociraptor .300 BLK",
        ["displayType"] = "Assault Rifle",
        ["weight"] = 3.5,
        ["value"] = 90000,
        ["levelReq"] = 32,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["equipSlot"] = WEAPONSLOTS.PRIMARY.ID,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/weapons/velociraptor.png", "smooth"),

        ["sizeX"] = 4,
        ["sizeY"] = 2,

        ["caliber"] = ".300",
        ["ammoID"] = "efgm_ammo_300",
        ["defAtts"] = "XQAAAQCQAQAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8ONwzg/QXs7OyJFuxzQi6LzMsFSvNU1yACpZwRaPs5EodvVwyjcJT3XwS6d+9+4ug91/qR+ermrEClJty912QBtqdui+PMzm1CjpMD8XFPO1LEU1e/FMACiOW77NtOuUxG6WPaO5xD1SVFY7X6TTXF+F+vOmlZGLw+ctKeMR7iEGa1XR3kWcFnWoV0jvNOMOE3RclEYd+ufnPfFELtEqyWGZbV3InaGrO/j5uE",
        ["duelAtts"] = {
            "XQAAAQCQAQAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8ONwzg/QXs7OyJFuxzQi6LzMsFSvNU1yACpZwRaPs5EodvVwyjcJT3XwS6d+9+4ug91/qR+ermrEClJty912QBtqdui+PMzm1CjpMD8XFPO1LEU1e/FMACiOW77NtOuUxG6WPaO5xD1SVFY7X6TTXF+F+vOmlZGLw+ctKeMR7iEGa1XR3kWcFnWoV0jvNOMOE3RclEYd+ufnPfFELtEqyWGZbV3InaGrO/j5uE",
            "XQAAAQBPAgAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8ONwzg/QXt0hVaSD4dMfb1xQCQCA92nl1gCqIfPaml7IxT01P4BDSqDVJiU68omPNWzCA4YH0PQJRr/bs/ugR1O10WDKSJOOZdwxy2tQqVjS8KWkfkBoy12Yw0vUVvd6YcJl84Ex4ZSNYfz0T/jKT89dOGZBYsRTl60Xl4lPHeoYpSF7HqGGb3UXxL0Z7LvDQP0okSoCxaJBjSBekwdXSYFPC6L1MTYJy5h6ebPV++IU4+kBbwT8Ogt46bCptxfWjY2TMG2HYtYWfTM3bgHVDcRLMwvYmrlsSiULYcQg==",
            "XQAAAQBWAgAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8ONwzg/QXs7OyJFuxzQi6LzMsFSvNU1yACpZwRaPs5EodvVwyjcJT3XwSkeUmEMRpofhX9lPsN16XmxcrtMpbkZel3qIrHMGJoXKF14e17fzKGAVrtl5fJ6KI8jZX8SqMHzgbhnCT+191rWG0byuLx4iljrVmFFJLrlTD6+SdEzPCLq2P4jGCDNkfGUE4g8DYZojfjh0GO62vvX7OXEEBtAyW3wWbGzq8IUDq0bYClXD93Bv5ATIVslOyCjpqHKPuey7o+zupZ6vnMoU0ooICN4ZycI19JSCgyW1bhmobG"
        }
    }

    EFGMITEMS["arc9_eft_aek971"] = {
        ["fullName"] = "AEK-971 5.45x45 assault rifle",
        ["displayName"] = "AEK-971",
        ["displayType"] = "Assault Rifle",
        ["weight"] = 3.3,
        ["value"] = 151000,
        ["levelReq"] = 35,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["equipSlot"] = WEAPONSLOTS.PRIMARY.ID,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/weapons/aek971.png", "smooth"),

        ["sizeX"] = 5,
        ["sizeY"] = 2,

        ["lootWeight"] = 75,

        ["caliber"] = "5.45x39",
        ["ammoID"] = "efgm_ammo_545x39",
        ["defAtts"] = "XQAAAQCfAQAAAAAAAAA9iIIiM7hMNz0dhIkbkvLjTdSR5gRNNIHH3iMgsLQ2HQpM1u5keOo9nkOEi25RcVCGAHvoza8JVSPxJOoz87ZabXFqV0UoVT3eh5eQVRbP7ahsz3JIHY1pHyv74F5aAF2/ZK7/FplqgBwynL7V+II74WXNSKksipmw+Xwum5Hr4J/AZe5edaeEkUENBibdsuO9eoDCO1FY68scPqqr4lAEMR/sqUSxAA==",
        ["duelAtts"] = {
            "XQAAAQCfAQAAAAAAAAA9iIIiM7hMNz0dhIkbkvLjTdSR5gRNNIHH3iMgsLQ2HQpM1u5keOo9nkOEi25RcVCGAHvoza8JVSPxJOoz87ZabXFqV0UoVT3eh5eQVRbP7ahsz3JIHY1pHyv74F5aAF2/ZK7/FplqgBwynL7V+II74WXNSKksipmw+Xwum5Hr4J/AZe5edaeEkUENBibdsuO9eoDCO1FY68scPqqr4lAEMR/sqUSxAA==",
            "XQAAAQCWAgAAAAAAAAA9iIIiM7hMNz0dhIkbkvLjTdSR5gRNNIHH3iMgsLQ2HQpM1u5kMlL5MempoAzHwAd9pcqP1nPqsA6r1C381ZlqQ0X5ZC0mHTZEusn4U/Lz6rPcFZaGIGDy8lIuGCY5xtlyvGSEG8+wk1ZHRNVay0IMiubDhqa4cUj1KwcDy0nkNvbU9eXeZv2sDwU+AS9xrfP2c5e0Dw1XhQYTrlwZu9+UzfG0aCABnNGUGPYCpDor5U3qDwM3RjmR7g8ClYIbJbZJ3B+95iBVmYwrQ55/UPXHoxGN+PVwdBoRumDojRgAgS2PK9gyXM23mWhJlGojiVMabj9aDhLxyv8=",
            "XQAAAQDgAQAAAAAAAAA9iIIiM7hMNz0dhIkbkvLjTdSR5gRNNIHH3iMgsLQ2HQpM1u5jGYFvLIVgeP/k14X/8MVRjw72+CUXzC3NyaqmiJm+fwyJWMxwjmMJEUjpblwbLMKg+EEvpEF46SzLCOEXh3XAXljOtUIk9iHqmYY2RzE8gE9Svc1MnCUex2Sr2rRSbOwx2oHrC02PnG/TIDLNVebwGmmvVUHrA/NK8MPql09f16kaz21GdEUKVPv5lR6WxKlU5XXh+7PHFW2ggWWrWY5GKx4GIHhykeSLr0LDMvI0fvgA"
        }
    }

    EFGMITEMS["arc9_eft_ak101"] = {
        ["fullName"] = "Kalashnikov AK-101 5.56x45 assault rifle",
        ["displayName"] = "AK-101",
        ["displayType"] = "Assault Rifle",
        ["weight"] = 3.6,
        ["value"] = 39000,
        ["levelReq"] = 7,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["equipSlot"] = WEAPONSLOTS.PRIMARY.ID,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/weapons/ak101.png", "smooth"),

        ["sizeX"] = 5,
        ["sizeY"] = 2,

        ["caliber"] = "5.56x45",
        ["ammoID"] = "efgm_ammo_556x45",
        ["defAtts"] = "XQAAAQA5AgAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8NWDT+kEGPPnFlfSO8Nqi4JBHKWbddf3eB9qikwLxMV8hvMeGwx/baMSBnueQ4qeTkj3h91Z8A8ihT5YfyyjjGfPN3J+M718JTJlY6OHojxYLS7+y5YfitgfXUB+eNLJVOEjKXP9KSWXtC/iUJuY5IalPQDwJEjXIUAXD22lFHReNyn3a0SZFFWAQamU4zGnGnfDVHqZfvfYoLh5wPwfohhlrAfYdncvutPBetQEVgqI556p/fOgo=",
        ["duelAtts"] = {
            "XQAAAQA5AgAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8NWDT+kEGPPnFlfSO8Nqi4JBHKWbddf3eB9qikwLxMV8hvMeGwx/baMSBnueQ4qeTkj3h91Z8A8ihT5YfyyjjGfPN3J+M718JTJlY6OHojxYLS7+y5YfitgfXUB+eNLJVOEjKXP9KSWXtC/iUJuY5IalPQDwJEjXIUAXD22lFHReNyn3a0SZFFWAQamU4zGnGnfDVHqZfvfYoLh5wPwfohhlrAfYdncvutPBetQEVgqI556p/fOgo=",
            "XQAAAQARAwAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8NWDT+kEGPPsp2uAP+aCeGrjF1acxjlfrsMrFTTLPL0u4g9ENQliwdJQp51Xrf9w4bNtOb9l2gAF/PMFY0B3UMJdqAOd5XJAY0OJNKA4db3PYYyco9xjpexUFD8sr7hY0J6YCrzsZ+pw5yyua5Ju1NDKrjdi7rj5p1teHSFxSdXkK7+L7HW80j1rEeUbzubfaGGm9aNr9GbojTxe0FdlKhDsoVexjz0KOSU3f+NVoDLPvV+tdcGPG1kqtqLbX7c0pYEvha6JLsdlDbLZYO/9cctOHIz0cC3rxmiy+MwXy0+EF0BZs1vThvdxeVRiVXo69SYNZ888ARlRy2zCNBYfSaDduqtTrhblL7UE8=",
            "XQAAAQDYAwAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8NWDT+kEGPPnFjshAgt7e+ktc496fkxw/gc0qwHzR3PVi76qdo4FR6uSPHeslQpPCplDU6mOXEzOloH4PbpSJts5DTQncah85YuGME5E4VDecq2dS8foZwKvafSeyg1FJHaj//fmZtnhumESLC2Ydm+wd02+AsHPtbt8mxHpg0hNbeUdDzDGPwXxo5Eu8yQGM9U/mol7a+RC0LZD1Xv0F85LgWBrPBUb0q7ff9HKpDoEbdZMfirHjSjO22Dv1kaDbJDQr+wyQ2Ns+tsTVUDNU86949XWUcIHvLEfEH6GAYHpevAFMeP2cGPX4EqaQyxLa28Bl4EXXDw8DyWWG80x0pv/kv3yKFWLRTOIqKwkbP5QZGuGKZBoDK86TT+2Er1aILyYo+UFjVIro="
        }
    }

    EFGMITEMS["arc9_eft_ak102"] = {
        ["fullName"] = "Kalashnikov AK-102 5.56x45 assault rifle",
        ["displayName"] = "AK-102",
        ["displayType"] = "Assault Rifle",
        ["weight"] = 3.2,
        ["value"] = 45000,
        ["levelReq"] = 8,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["equipSlot"] = WEAPONSLOTS.PRIMARY.ID,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/weapons/ak102.png", "smooth"),

        ["sizeX"] = 4,
        ["sizeY"] = 2,

        ["caliber"] = "5.56x45",
        ["ammoID"] = "efgm_ammo_556x45",
        ["defAtts"] = "XQAAAQA5AgAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8NWDT+kEGPPnFlfSO8Ns6AZxWP3PlA/84ffW/F1EvjIsK44URuKcDSa+VS+CwgoqFlAy5J222cRX/Vjj6JS7X3TfsYbz/5rO2KJigMDwoHVnv+N2vPihkaSuPQk0Z62mkPUC8GednFAlj8OUUkQX6MyQgVivpPVy5wfoYu+PH1sInwaIWaMR5cUiu32Yj9F1z3uDdQmK0ocSXuZncKe2mBgoHcmd1ip1PvgElDwXick18vDi3Zgrk=",
        ["duelAtts"] = {
            "XQAAAQA5AgAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8NWDT+kEGPPnFlfSO8Ns6AZxWP3PlA/84ffW/F1EvjIsK44URuKcDSa+VS+CwgoqFlAy5J222cRX/Vjj6JS7X3TfsYbz/5rO2KJigMDwoHVnv+N2vPihkaSuPQk0Z62mkPUC8GednFAlj8OUUkQX6MyQgVivpPVy5wfoYu+PH1sInwaIWaMR5cUiu32Yj9F1z3uDdQmK0ocSXuZncKe2mBgoHcmd1ip1PvgElDwXick18vDi3Zgrk=",
            "XQAAAQDqAgAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8NWDT+kEGPPnFjskkojommSaQCNlMpRvkic1YAIsLcoCrGt5qdQEyEhyYDUlKvPZm1iabPZT7I6WXI5elZVjkbeb+rXDg3fAG8mkELCwGv5DbS8ROEvZamwn2kQTGwoPLWX4noB+gWgn7rI8U99CVEAALCKMtYShxWLL4vLCnSPmxcw0tU5luK0YItHQqw1xj8I2pSM8kJgUJQKXkA0stEPE3HPG/wim3mvtPYcHqnC88Nb/1pTAuEvIm2Ah8MHUwszGayWh2VoQCoL7s5ljTyx3ECv2XdL2i6Qm29J02FscjU3Dm70DMP/UqoP84fzTszyhDAi1Kbag72sk25W3VA+WfBKGk=",
            "XQAAAQA/AwAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8NWDT+kEGPPoLDgg6ncRjqGGaRX5cIjcexPmndMIe29Em8cAccf1YC63W+4A/6FSwfuIwYcPsvGiFJxemxfIG8Arka/k25hxIkIQD8G8fiGKARbVuFVzujtVnali00P0pJkftl7L+XeMC5vsn8lR27OxTEGkCpIYB8A9WQp1YP7Ot6mPShWAOw4ceDQ2hpHq6IewVQ7riCAXMNvYCMwBD6oH/GiBbakydQQtsGQBk/nZSdLp2wJUfVXt8EYcd44gRJeoLoUiI6uifSBzen4rn+S0LmmdMVjL6tLee0tEEhduy/ksMyhhVHVpCYDp57qHCdoGs1Vxnt+4gpuPzQJuMwKDnDMAA="
        }
    }

    EFGMITEMS["arc9_eft_ak103"] = {
        ["fullName"] = "Kalashnikov AK-103 7.62x39 assault rifle",
        ["displayName"] = "AK-103",
        ["displayType"] = "Assault Rifle",
        ["weight"] = 3.6,
        ["value"] = 48000,
        ["levelReq"] = 9,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["equipSlot"] = WEAPONSLOTS.PRIMARY.ID,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/weapons/ak103.png", "smooth"),

        ["sizeX"] = 5,
        ["sizeY"] = 2,

        ["caliber"] = "7.62x39",
        ["ammoID"] = "efgm_ammo_762x39",
        ["defAtts"] = "XQAAAQBiAgAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8NWDT+kEGPPnFlfSO8Nu7maxWP3PlA/84ffW/F1EvjIsK44URskLjrU3INVpOUUpW/T+X8KaCPCqXRuwyOfDk8iB1lfs9JmT/oZc7o/a/qSaZj07jExj7OfYd4nzvmulpMNSijwj9hDtpYct603tBDjIZi7SaBw6gexLd0U23pTrs72UmoWXtD9KNq76NfTbqPRmcA6SbLoawCvse/HTjDsawwnZc3+puJ0RALoMUE+0iRJciXJ32NzgsC",
        ["duelAtts"] = {
            "XQAAAQBiAgAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8NWDT+kEGPPnFlfSO8Nu7maxWP3PlA/84ffW/F1EvjIsK44URskLjrU3INVpOUUpW/T+X8KaCPCqXRuwyOfDk8iB1lfs9JmT/oZc7o/a/qSaZj07jExj7OfYd4nzvmulpMNSijwj9hDtpYct603tBDjIZi7SaBw6gexLd0U23pTrs72UmoWXtD9KNq76NfTbqPRmcA6SbLoawCvse/HTjDsawwnZc3+puJ0RALoMUE+0iRJciXJ32NzgsC",
            "XQAAAQCPAgAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8NWDT+kEGPPnFjslb0NeIflr3NUamrd2mH+QZppLUYv5sdCJ5KY+gi0XDSNbudu6VHHHlHu2dye7lshNwW7u7fZWr3HZsllxCP1bx29rzbZyfVxpN99nl7/4/AYBNGFYyiPpLWewTingAVqvttRMWIROM3bcrTzpuXE6LPH0qoZhhpOEHQi8KPC4mZ6CWxkdHmXzB9XVLT5K1KORqsUJxxJvgPibtC5d40rSuDQITa9vlnCVBcNbM0HDwhcBeLUcb9rstIQvvqw3p07qktZX3NvtOOAfUYpThhRTnfbXjlRf3vAA==",
            "XQAAAQCCAwAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8OSdG+ffqYKcUXeSURjr1U4BtTFsmZmDQ4UkLGDSWJTONDyi1rusfNo+BORcI9ZT563nLoVclhf74byQFwfPIbFqghGSyKdxtQEJMftzgPuYl45av0LE2d3v6eY6+eZinoqUJzYmWeqngNPrBgTSkRhLggGB9lQ6T4hXfZbMNSpxzn5lGZjgxFjJcYWKCQ97iBUOPBrE1siEKglR+9SeHs2y4tcOYIXoxTCyl4FWPX6ngfVlWhes1rtiF3ylzqH00gwmS37Ds2FrFYhiyKQWYHJBBtuVIn1mUXUom5SYYhqRhdk6hcBJIwcwfzbnTPHlGO2qzucAAZPWhWwEVwGw18tvgyKA02zGrbREQ4Iuc4hjf5P+Wq/+Noajs6/gLMADTyZBhEYVNn2KMA"
        }
    }

    EFGMITEMS["arc9_eft_ak104"] = {
        ["fullName"] = "Kalashnikov AK-104 7.62x39 assault rifle",
        ["displayName"] = "AK-104",
        ["displayType"] = "Assault Rifle",
        ["weight"] = 3.2,
        ["value"] = 41000,
        ["levelReq"] = 8,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["equipSlot"] = WEAPONSLOTS.PRIMARY.ID,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/weapons/ak104.png", "smooth"),

        ["sizeX"] = 4,
        ["sizeY"] = 2,

        ["caliber"] = "7.62x39",
        ["ammoID"] = "efgm_ammo_762x39",
        ["defAtts"] = "XQAAAQBiAgAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8NWDT+kEGPPnFlfSO8Nw6CxwPL9zZwK6qbhs1exY95EYTr5o7kpJWXwunlf6BMvZGfefnONSZi5v+97rVtOxLFfbUJVXA96l7paialxEHSYoJucJO7oOgSQfVpJj7noQo+36s5FPycPcRRCx0JeW7AajTDITbJcnocmhd5rdrmuWkgCDJouk0rREZLqkokYmKBNbKZ48dpjGJ9ou7ViUnTYn0U6OI/QlJj1jLvg0ZB00GRX0lrMd2NzjkmsAA=",
        ["duelAtts"] = {
            "XQAAAQBiAgAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8NWDT+kEGPPnFlfSO8Nw6CxwPL9zZwK6qbhs1exY95EYTr5o7kpJWXwunlf6BMvZGfefnONSZi5v+97rVtOxLFfbUJVXA96l7paialxEHSYoJucJO7oOgSQfVpJj7noQo+36s5FPycPcRRCx0JeW7AajTDITbJcnocmhd5rdrmuWkgCDJouk0rREZLqkokYmKBNbKZ48dpjGJ9ou7ViUnTYn0U6OI/QlJj1jLvg0ZB00GRX0lrMd2NzjkmsAA=",
            "XQAAAQCDAgAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8NWDT+kEGPPnFlfSO8Nw6CxwPL9zZwK6qbhs1exY95EYTr5o7kpJWXwunlf6BMvZGfefnONSZi5v3am9nr4PguSxreVi4wNnuisVOWvZLt97XEljqimFx7XAb2fQwvy9tovhrnLfhagHa7bT/axrHvaUYNKk6vfeUl9z/uAzN1ucWxPxsXTweEkqkpyH1CHJHwDEb/3IDZ8SpDLpOlngLo4LlS7GpO9oPhjC2UVR3nbwR1upg0nzQR40qpPyfDIdtLfK72tBvtM9tyZG/1xbVhmQKIuU3u0nzTjFfEDpk=",
            "XQAAAQA9AwAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8OSdG+ffqYKcUXeSURz877uXgINC8Pc1MbRbihhlAdeKGDHf7D34PPxmZWywL+KSUtYFi8z2DeuvQaNkp8HWs2x6Z2CTDu0nMWiquXZA8O+ycP1H00+bIw0nYF7mwcuodUpnANOqsxrzmHI3xK26ZPV2woZ8QpKlDxTek9ji4KliQc7AzlbQNnzWIMYrnO5WJGQR5g3+VnfWgQ83ja1/K0E3kDhmWupJr1XLKv3JlQ3UVsa5UfmPEirSoqOlbhwzbzKDq5XMYajvVLeXjOre+JuHFGKLpA71HnzMrBzW6mqETg7Bzf2Tn/Zs6fHzMk1+lN3y9zVAUxA7319fVIrCEwU3bOZXQiO8x4YjTtmwA="
        }
    }

    EFGMITEMS["arc9_eft_ak105"] = {
        ["fullName"] = "Kalashnikov AK-105 5.45x39 assault rifle",
        ["displayName"] = "AK-105",
        ["displayType"] = "Assault Rifle",
        ["weight"] = 3.2,
        ["value"] = 46000,
        ["levelReq"] = 8,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["equipSlot"] = WEAPONSLOTS.PRIMARY.ID,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/weapons/ak105.png", "smooth"),

        ["sizeX"] = 4,
        ["sizeY"] = 2,

        ["caliber"] = "5.45x39",
        ["ammoID"] = "efgm_ammo_545x39",
        ["defAtts"] = "XQAAAQBRAgAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8NWDT+kEGPPnFlfSO8Nyw3wwPL9zZwK6qbhs1exY95EYTr5o7kpJWXwunlf6BMuwy+UTZW8lwoXi0o0oO6mTyzbfX13P1TDZ7nepb7LCA4HwekfWeQK6Dkwc3KyunQhPThpMpchMGWDfSdnbdjN7B5UZ2uZml3p39bjYBSd+m2s5aFRZSF8fWDdN8Vp3JhfkG6pHRzWNGKpLrPTYY7i9blTSAEH+c9CaWU2QEV9jk8X+mhyPba5pvfkyFz7gA=",
        ["duelAtts"] = {
            "XQAAAQBRAgAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8NWDT+kEGPPnFlfSO8Nyw3wwPL9zZwK6qbhs1exY95EYTr5o7kpJWXwunlf6BMuwy+UTZW8lwoXi0o0oO6mTyzbfX13P1TDZ7nepb7LCA4HwekfWeQK6Dkwc3KyunQhPThpMpchMGWDfSdnbdjN7B5UZ2uZml3p39bjYBSd+m2s5aFRZSF8fWDdN8Vp3JhfkG6pHRzWNGKpLrPTYY7i9blTSAEH+c9CaWU2QEV9jk8X+mhyPba5pvfkyFz7gA=",
            "XQAAAQD5AgAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8NWDT+kEGPPnFjshAgt7e+ktc496fkxw/gc0qwHzR3PVi76qdo4FR6uSPHeslQpPCplDU6mOXEzOloH4PbpSJts5DTQncah85YuGME5HBizo/Qg5DucnkQ7yDjLxTfzI+CO+NgeIg6plv9yjhC7CCSjMZq1YFV7OrrIBCF1IpM16gssXtOgw3kPztue5Aq2NE3/o5Gg0fDAC2i/fORgxTHuBzs4/lt53B9N9sy32G8B6437aL0BYc+wcsljYbO3CzyzrLFMwz3ET/+qEIKFJBgp0bpxGwnyMmguGVLzaquNLC08/KoKpqVjthMmBsVLtdpiiRkTIK3mjN4Fcbi3T6ekYA=",
            "XQAAAQARAwAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8OSdG+ffqYKcUXeSUR554QHxlfr96DAMQMt3CUqDYYpW6U3mnWnsSncTTGReQZEQe1STlMNYuIPnkfXEpNAs8SEV4fDGsq8+PaknLGS+LUNg6/kZ2FDLe4hu3ZQGIPrHbyq47Y22hQEHcngo9iSX8CqJkJrSNXqcmCgg7JdnXx6tkXh4MHYilraNTz0qdk20ew0QpbvbkBiyuBPaEUO3ae+I/oo8Qe3iuKPc00Ov9ie/2dsTCBn34MW9myrqMUM1GPBVbIhADZYpg1ACpkLIdkQavain/tlPJzk1S5A1cgCnxfuHDkdwwC36wSN+GrdUuwJQRQG3y1TjZo97duG45RQTZWD2Kg"
        }
    }

    EFGMITEMS["arc9_eft_ak12"] = {
        ["fullName"] = "Kalashnikov AK-12 5.45x39 assault rifle",
        ["displayName"] = "AK-12",
        ["displayType"] = "Assault Rifle",
        ["weight"] = 3.6,
        ["value"] = 88000,
        ["levelReq"] = 15,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["equipSlot"] = WEAPONSLOTS.PRIMARY.ID,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/weapons/ak12.png", "smooth"),

        ["sizeX"] = 5,
        ["sizeY"] = 2,

        ["caliber"] = "5.45x39",
        ["ammoID"] = "efgm_ammo_545x39",
        ["defAtts"] = "XQAAAQCtAgAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8LcWHiLIpod33BsI9oXI+YvXrczo24nxbYfjlSRF1YF3Vl54iDtNZH7jPs3xx40T4Kf1X+gWLUW1ViEr6HSJEUxNUaGjKIZQEfKhkrbyH/BxRRT2U425yK0NIO+vkp8ofbDCsow17cBYwfGphoc+1XymTdWUoNudQ27NQtatOGQTSWorZrL3Ox8EIW5nf7n0aB0UGwNFtN1EdHwBcAlpNU9e3Yqbjd1D6ZEkOtrgtib5yZcisBhERmD/xfMAA=",
        ["duelAtts"] = {
            "XQAAAQCtAgAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8LcWHiLIpod33BsI9oXI+YvXrczo24nxbYfjlSRF1YF3Vl54iDtNZH7jPs3xx40T4Kf1X+gWLUW1ViEr6HSJEUxNUaGjKIZQEfKhkrbyH/BxRRT2U425yK0NIO+vkp8ofbDCsow17cBYwfGphoc+1XymTdWUoNudQ27NQtatOGQTSWorZrL3Ox8EIW5nf7n0aB0UGwNFtN1EdHwBcAlpNU9e3Yqbjd1D6ZEkOtrgtib5yZcisBhERmD/xfMAA=",
            "XQAAAQDIAwAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8LcWHiLIzaWYYWkMHhUK1QO6I0tRSVfUY7PKynTD7u582NQUFsQH1QJjiNFkc9xjOFFhNzTiBvTkyPL9bKcog4TncCAHH04HlVAyF78Jo6S9FYahx0YaMqv5DDdKWmGxSiR0VZ7Q05vxi0JH69OUrIxLdVGaPzCMC/KP4rm3CGUresjJPCXgZo8sexN7w1qO2hZs+HTwwWgzOcw+iXOtec1u40Qpr4hsw6pLXZHCwaST3zDvsWK+h34KzF24MmtB/i0oQ24kXMk/iN9IjwSwevobZ8oxwf4Z6xhFQlbASWoLdb9xXCsWF+uXivPwzHayfEDTrbT6PyEQvBzbZwMxsf4dxTkWO7HcrtJlNAZ8IRpMyllT+f+MquCQFNkWihB+euiZGs",
            "XQAAAQDSAgAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8LcWHiLIpod33BsI9oXI+YvXrczo24nxbYfjlSRF1YF3Vl54iDtNZH7jPs3xx40T4Kf1X+gWLUZZvtbqIGL3Kf7yV+OxPfgICWdromM4TflTyaObwEoGx+LbQwKA9SEt5SDnOU4Cu/UiugZ7Go6CdOPNZ4vSq62r7Y2J3y1DhPl+XGikUQ7ZOFG93a6pD1R0YiWBCWTn6wTKDh00Uz5FGLzwH5fdHEDj8YnUolR6n7W0pcWjB4eVkR5dGCoUiNuw0tKfeqfJ2NZlp2KQpEcILyl5vX5C07XY2VdeFT8E6+NijvmnenHQA="
        }
    }

    EFGMITEMS["arc9_eft_ak74"] = {
        ["fullName"] = "Kalashnikov AK-74 5.45x39 assault rifle",
        ["displayName"] = "AK-74",
        ["displayType"] = "Assault Rifle",
        ["weight"] = 3.3,
        ["value"] = 38000,
        ["levelReq"] = 7,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["equipSlot"] = WEAPONSLOTS.PRIMARY.ID,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/weapons/ak74.png", "smooth"),

        ["sizeX"] = 5,
        ["sizeY"] = 2,

        ["caliber"] = "5.45x39",
        ["ammoID"] = "efgm_ammo_545x39",
        ["defAtts"] = "XQAAAQAmAgAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8NWDT+kEGPPnFlfSScSitmwGLrqnyyN98JIPzpwPIX/9KgyF1GotiIuhFjeTGCSDJNctN6I8y9DxmfRJ9NhrlCsOICkjgfTK9wJs93JWXc1UzZNryCAvuBo3eDytRNqk+TwEb/gwgAC2ek6u/pQcEgS2dVrjwE/5HWSVXhnkcDGxhxRyEKxDtNtlbIClhiAfkiz039xdTxVd9/+XPgmKlytFqJbRMYh5Kcqylt0m80RZe10reQMgA=",
        ["duelAtts"] = {
            "XQAAAQAmAgAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8NWDT+kEGPPnFlfSScSitmwGLrqnyyN98JIPzpwPIX/9KgyF1GotiIuhFjeTGCSDJNctN6I8y9DxmfRJ9NhrlCsOICkjgfTK9wJs93JWXc1UzZNryCAvuBo3eDytRNqk+TwEb/gwgAC2ek6u/pQcEgS2dVrjwE/5HWSVXhnkcDGxhxRyEKxDtNtlbIClhiAfkiz039xdTxVd9/+XPgmKlytFqJbRMYh5Kcqylt0m80RZe10reQMgA=",
            "XQAAAQBCAwAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8NWDT+kEGPPnFjshQV2iWEE3HED6lOBznMWduaFi5rnTonUSmxmS019TCacD8s6pxkejmG44N0WGVFA0JPcCGIh0K1SyZ51xcGI5WbzKp7EKPtpHWpZ6GMATJKx0HgZrBlyDcTQtq1Tl6GyGsaOk5TtFTQdGKI0qTdca8ZmqzyWnjafBxa6PxE677CPltyB0Nw7xH/KDHjG6Oj5ANZR7yztWlwUzlHgreajkFa5aaesZVsi7YLK9WoLTIzD+CsIaKMnwJxCIoUVHqlRPrIBYl9l0zEYB0Q2uOI1H9fj8HeaUuXSHn4fFwOiI3BxALvVDG3tWtHczoo4jkCeh8ujc41bTamEtNCVFImqMcS6p6oC8R9uiqK",
            "XQAAAQDdAwAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8NWDT+kEGPPnFjshAgt7e+ktc496fkxw/gc0qwHzR3PVi76qdo4FR6uSPHeslQpPCplDU6mOXEzOloH4PbpSJts5DTQncah85YuGME5E9wkuQYS6mLNv+k/l5fQgAxX2uhASBzw4RK5b6zP/Q3B8/rsv1in7g9d2r4xbFo18goCSH6NVSbIOM8wd/DrAVc30sJn/zQ/7TQBH/85uV4crAuHBuoKNb4o/4Uo20vQwj9Ia2bs7Vl3Zf5CrkjL8tuRkVMdGf9DzkTX30Xg0hZni0oLvalStgYM1lPIngoBXAsjWBBOvUMKdGXE5fcRMe3vVxHtiSfqIQMJwRVtGOfS3saABEJSeaALNAevrHwbhNjM0SctwBD+kni2+dK0ljuvfa/4xwww+eCok9FVqAA"
        }
    }

    EFGMITEMS["arc9_eft_ak74m"] = {
        ["fullName"] = "Kalashnikov AK-74M 5.45x39 assault rifle",
        ["displayName"] = "AK-74M",
        ["displayType"] = "Assault Rifle",
        ["weight"] = 3.6,
        ["value"] = 40000,
        ["levelReq"] = 7,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["equipSlot"] = WEAPONSLOTS.PRIMARY.ID,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/weapons/ak74m.png", "smooth"),

        ["sizeX"] = 5,
        ["sizeY"] = 2,

        ["caliber"] = "5.45x39",
        ["ammoID"] = "efgm_ammo_545x39",
        ["defAtts"] = "XQAAAQAhAgAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8NWDT+kEGPPnFlfSScSybP+C3Y0ij7z9iVh7t2mLczDAV3rxV/Tab/iWNW9/ErKFP8/+D+Vim0am/Po/HkaFLcHxy1NAWYDWhE5TToWI9DcWlSySfGeqJ5X0F+A9G4JpJ5+ITrwjilXBDXYGI7RsX2jg4Rm3sgACPoO8EI1B12xnH0ZXUUO/fkPxxhECig2eKQajc16XJKoEAjfqQweUxCYKPm8wUCuyU4BhqH1tEJhgoO5wA=",
        ["duelAtts"] = {
            "XQAAAQAhAgAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8NWDT+kEGPPnFlfSScSybP+C3Y0ij7z9iVh7t2mLczDAV3rxV/Tab/iWNW9/ErKFP8/+D+Vim0am/Po/HkaFLcHxy1NAWYDWhE5TToWI9DcWlSySfGeqJ5X0F+A9G4JpJ5+ITrwjilXBDXYGI7RsX2jg4Rm3sgACPoO8EI1B12xnH0ZXUUO/fkPxxhECig2eKQajc16XJKoEAjfqQweUxCYKPm8wUCuyU4BhqH1tEJhgoO5wA=",
            "XQAAAQARAwAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8NWDT+kEGPPnFjshQV2iWEE3HED6lOBznMWduaFi5rnTonUSmxmS0174sxx4qILYSUhate+cYBHoD3O5DrA5NjCVeLh53rPflb0HYQY/UNM45njsylSDmMmkq2FXEtCNHhFQE6yvPuXMfZgdcW+Jl/iT4LuiB6IjUvmETdnwiX+9ldhHY/LpbIwf8gQkK3oOIGi1cl3PW1A745Aiu87QEe0ISm6fP0StBRdPnZsDTKpCxe9Fr3iuTWx7mF7n9UreT8BxK9h+qcUnUBFgPifo78COnixXZBqkt7jgTqpwrf6gu03oDkTTQuN+DXVGZdoaYZ/8rxXJVC39YG+caD7gcjIOBhpg==",
            "XQAAAQBgAwAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8NWDT+kEGPPoLDgg6ncRjqGGaRX5cIjcexPmndMIe29Em8cAccf1YC63W+4A/6FSwfuIwYcPsvGiFJxemxfIIFmbLdp1DWPB03+QOn5910b0oP8NwTQp0q5BxPsy4WfHDq9TKcu1DI55fqspaxp8Wh6brguwYSHlm2U8jtLGnBdH/tHgyVIHR3N1ZaBniFmbfIDGQ9nE8uCcx+f+uyOP3/f9Bc6qh0QqXihSw7gSPy9PhpMMrMdazKyofqw6KreZDMECiQLZcPZMFEaP7lCPMY42f5Nyb5sd/TL5tMeI8przcYUVsvowphsXOQH8NJvgYUQmeCoopNT+hr553cua5rqxJtqemoRU0nBfjh4K3klg=="
        }
    }

    EFGMITEMS["arc9_eft_akm"] = {
        ["fullName"] = "Kalashnikov AKM 7.62x39 assault rifle",
        ["displayName"] = "AKM",
        ["displayType"] = "Assault Rifle",
        ["weight"] = 3.5,
        ["value"] = 46000,
        ["levelReq"] = 6,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["equipSlot"] = WEAPONSLOTS.PRIMARY.ID,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/weapons/akm.png", "smooth"),

        ["sizeX"] = 5,
        ["sizeY"] = 2,

        ["caliber"] = "7.62x39",
        ["ammoID"] = "efgm_ammo_762x39",
        ["defAtts"] = "XQAAAQAhAgAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8NWDT+kEGPPnFlfSyGhIy8o/wiKvL93nxHBIW4c+xoXNI8ovSyL1sZpt99SrYfcdc39AvFM6fBpD/3aCZYsTH2F0+2h4fFmPjwd86z9yxr7drQaQE2UQCXdnDp1rXaX7VSXQv+KFhY/L3ThmKPrQqNufn0DCmaYmY2es+b1MgRalpzhEt5tO0Nz6aW4qYfSEZfOne5VvZQiFQCAnHIlzY6uJGknA5uUq3hbNIA",
        ["duelAtts"] = {
            "XQAAAQAhAgAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8NWDT+kEGPPnFlfSyGhIy8o/wiKvL93nxHBIW4c+xoXNI8ovSyL1sZpt99SrYfcdc39AvFM6fBpD/3aCZYsTH2F0+2h4fFmPjwd86z9yxr7drQaQE2UQCXdnDp1rXaX7VSXQv+KFhY/L3ThmKPrQqNufn0DCmaYmY2es+b1MgRalpzhEt5tO0Nz6aW4qYfSEZfOne5VvZQiFQCAnHIlzY6uJGknA5uUq3hbNIA",
            "XQAAAQCjAgAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8OSdG+ffqYKcUXeSURz877uXgINC8Pc1MbRbihhlAdeKGDHf7D34PPxmihDTt+PCe175k0HCEzajeTPSwxVq7GDF3wc9EkwXpa0Fw6yQ1SBQ9nRquXPxtqcR/O29Qb2KSGIl0spbZnGWPIDBjr2PM+2iJAC6DcW4c+qRs1d4eIwmXxo/fj8MkPBuPOYIqLvE85nNOYzDPAK1N8QlgVee0WsxyBIaCrbB6qrx2WBVoWfiPjT9s9MlrPTpuQk3QlrKyRMhBDPUSPbsSVy9DFCmD/zRg=",
            "XQAAAQCkAwAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8NWDT+kEGPPnFjshPgqo/X5PQkzvmzIyC9o0UxeDRrEHF6efiKRZzY2DcF7V27zEyU92JiIjj8Cni31Xq2oJ/xcU3bLIUx+9H40SuNV64uCI42LhTIFkup7k23Ckf20voQ1T2y7AbOZEifn5dI9TTyCPdD1USCmNUm3hr0eIn/wZUITrJj4SY4CdiSoOygD+PzQaetGFpzMH1764+N4v3K6bn1zlvH8cP6W6y2prWpqwBDrIH72JOkZ7XbWoCgOP0TLFKIP4/P3Y2qwdmlLFzWuc4RkAxdFBdsoB3Bou8nQsyFkPaqBHRyQtwgrDx+WkM1x7pCsoyvaUK3HAj7c6E2twre7Q1q3svWIJ63zuY/tBp5vlLS8Ajdq3UVDd5lWXSlnDqWLuJmU04kqc6mmQ=="
        }
    }

    EFGMITEMS["arc9_eft_akms"] = {
        ["fullName"] = "Kalashnikov AKMS 7.62x39 assault rifle",
        ["displayName"] = "AKMS",
        ["displayType"] = "Assault Rifle",
        ["weight"] = 3.4,
        ["value"] = 44000,
        ["levelReq"] = 6,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["equipSlot"] = WEAPONSLOTS.PRIMARY.ID,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/weapons/akms.png", "smooth"),

        ["sizeX"] = 5,
        ["sizeY"] = 2,

        ["caliber"] = "7.62x39",
        ["ammoID"] = "efgm_ammo_762x39",
        ["defAtts"] = "XQAAAQACAgAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8NWDT+kEGPPnFlfSyGhIy8o/wiKvL93nxHBIW4c+xoXNI8ovSyL1sZpt99SrYfcdc39Atnyt4+MSL8FR1c8qG5KgOkAQW8ZPFremApexmyQYv+4oOojOjTOMITQoGMyenBqlKsSfxVnv4k3Pyjih2HqDeiTqKxVs0o+3377oApURVXEe0UWRmtoafw+i8ugX4Bzrizxw9vUXgTSfbMOozCJXgorGkJtLkavNlq",
        ["duelAtts"] = {
            "XQAAAQACAgAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8NWDT+kEGPPnFlfSyGhIy8o/wiKvL93nxHBIW4c+xoXNI8ovSyL1sZpt99SrYfcdc39Atnyt4+MSL8FR1c8qG5KgOkAQW8ZPFremApexmyQYv+4oOojOjTOMITQoGMyenBqlKsSfxVnv4k3Pyjih2HqDeiTqKxVs0o+3377oApURVXEe0UWRmtoafw+i8ugX4Bzrizxw9vUXgTSfbMOozCJXgorGkJtLkavNlq",
            "XQAAAQCtAgAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8NWDT+kEGPPnFjslbt4xjmVkJBjle8bjtok2Ua8haAP+W7CrzgCP8lRbkXtVuNpupiKqw+wFzKqh1LlSWwL0axyVj03NZ465BM9tYdg1EO3ANgQ8I387Bs4AdigixIaKS+R+kutGK47JoPUA54cY3lRvEfM8gYSHM0cRu8OaqqKfnR1+PdzDEqCiaHSvHzt+1O1UIQ0f1dlAfI9nW9NLr73An1CfwW50aZikcPEY2D1oEiaXoI/ofSS3phd5MhMz93Fe6uG43xuCIwljLHdRCtMymJvv2dNk8xcaIvj+IBKkQA",
            "XQAAAQBbAwAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8NWDT+kEGPPnFjslAXRm2oGP1QxSv8Ej6z2NALe32xGObzHUEI0QLGYs7nEBf4MrJwQigQO24bpboIUIy6or+O0t7Gf4PpTOyl8ib2Hgl+rMy64oIf7Gz8kWb5K/PFfrwuqf7vrov7tvz67pUw6n797lQ1JaqroMI+RCRtiEsLaJzj/+7QMCjxWLbfmAZeO8ApzpHzvu9Ve9UeY8+npHfneqmATG0bEET5E5wUd7eot2NTpNXPxYAsYqeI40ZUtMKvq43YcSwMDOc6nSF+7Sk+67wf3Qwx5jMejdsXPVMVzDawzbsVFoZs8gT/eRwm8Zn526XlquXX35/RQQUA"
        }
    }

    EFGMITEMS["arc9_eft_aks74"] = {
        ["fullName"] = "Kalashnikov AKS-74 5.45x39 assault rifle",
        ["displayName"] = "AKS-74",
        ["displayType"] = "Assault Rifle",
        ["weight"] = 3.1,
        ["value"] = 35000,
        ["levelReq"] = 7,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["equipSlot"] = WEAPONSLOTS.PRIMARY.ID,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/weapons/aks74.png", "smooth"),

        ["sizeX"] = 5,
        ["sizeY"] = 2,

        ["caliber"] = "5.45x39",
        ["ammoID"] = "efgm_ammo_545x39",
        ["defAtts"] = "XQAAAQAnAgAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8NWDT+kEGPPnFlfSScSitmwGLrqnyyN98JIPzpwPIX/9KgyF1GotiIuhFjeTGCSDJNctN6BTySRMfHDIfbSAKxpBDZq+GKhGskyxMt2ZsyF/cYJ8evGfBHLi4OO71kf2GvuG67phqgfQ8b0EKImJwbf+GbLs762Ta7vR9BfkOjN1W9KxUFehje0Yzi5g+ZMTYcoRJ/VJHlSb0RcpYdWZSy4f0non5h+n81LAxQqZRULDI/VbcaxiDj",
        ["duelAtts"] = {
            "XQAAAQAnAgAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8NWDT+kEGPPnFlfSScSitmwGLrqnyyN98JIPzpwPIX/9KgyF1GotiIuhFjeTGCSDJNctN6BTySRMfHDIfbSAKxpBDZq+GKhGskyxMt2ZsyF/cYJ8evGfBHLi4OO71kf2GvuG67phqgfQ8b0EKImJwbf+GbLs762Ta7vR9BfkOjN1W9KxUFehje0Yzi5g+ZMTYcoRJ/VJHlSb0RcpYdWZSy4f0non5h+n81LAxQqZRULDI/VbcaxiDj",
            "XQAAAQD2AgAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8NWDT+kEGPPnFjskj5PLiCdqpBmPRo+JsqdrBY6r8vJDG34S86Phwf5aDeZFnWw5ZXazU63H9Sw1SKShoFMDTmDxAd4W3mpZsC1fBAuscUw+xmdt/Wk5UEpRMKh8GzJg38E9YD0kOCrJ3tfVf8Y6blbXunIDMU2ZR7h/N9eCHWd6da5pBPYsTT6qHJoxZqQlmsRuZ0x3hE6y3Yh++Scxe1e6HR4ce78DE2wvJ8S8bYAjQ87L1zb8JXTIfQHwLqwXNyAQQmOzbC94pr3VeIpDEhZmDYF0xW4i1zNMtkTDkdaL1nrR6bGWZIhfLWuFvdFcZc3jh5wqFvQ++L2NCQqCOng1g=",
            "XQAAAQC4AgAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8OSdG+ffqYKcUXeSfIW1m8a/rKhLe9LbLl9EPbv5V3eJxONsN0Zw1ZZxJDpnH9zuGNpLykr9UTuioSdZHUBCQz7Q5h4sImNPWo03x4xQxkkXXeF5SjhD0FbUeVDC4n/9BHkkFzO+iHI0JJ81DAw/8rRv4ET7VLpuASvHD+ipzd25glIVbQuKa+8tXJ1EDWUYIVAB3cIVzGP5O68z69qpCusz09rZ7IseqQY2rz9tVaKCvZ71OHmuhkD+p9Cs4pA1zxWQDFQy86i1UjxHe8XMODbWbEA0KYraougqvPcgGeFizWeuKix4tWHTn0lLZS075Q9OhcU086HFkTV86T"
        }
    }

    EFGMITEMS["arc9_eft_aks74u"] = {
        ["fullName"] = "Kalashnikov AKS-74U 5.45x39 assault rifle",
        ["displayName"] = "AKS-74U",
        ["displayType"] = "Assault Rifle",
        ["weight"] = 2.6,
        ["value"] = 29000,
        ["levelReq"] = 1,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["equipSlot"] = WEAPONSLOTS.PRIMARY.ID,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/weapons/aks74u.png", "smooth"),

        ["sizeX"] = 4,
        ["sizeY"] = 2,

        ["caliber"] = "5.45x39",
        ["ammoID"] = "efgm_ammo_545x39",
        ["defAtts"] = "XQAAAQDaAQAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8LcWZNz742AnWnBW5VFLsMbYkg5JCtgcCZFQzZvKB7kdZlb7hYagJ7xTPFZ2McEz65077s8B+FWvzBE8FH3UO1VnwHvhCXw7ua73XK/ipwVxqxGmfGuH6rK0r8VL632B6ztnI8PKNABt3A2EItiEhsYVqkVySGPj2sdgNrDFN6ojMeJ2C0knLtyPiBB1fHZ0rAgFPuOvPzMd1jAA==",
        ["duelAtts"] = {
            "XQAAAQDaAQAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8LcWZNz742AnWnBW5VFLsMbYkg5JCtgcCZFQzZvKB7kdZlb7hYagJ7xTPFZ2McEz65077s8B+FWvzBE8FH3UO1VnwHvhCXw7ua73XK/ipwVxqxGmfGuH6rK0r8VL632B6ztnI8PKNABt3A2EItiEhsYVqkVySGPj2sdgNrDFN6ojMeJ2C0knLtyPiBB1fHZ0rAgFPuOvPzMd1jAA==",
            "XQAAAQAHAwAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8NWDT+kEGPPnFjshAgt7e+ktc496fkxw/gc0qwHzR3PVi76qdo4FR6uSPHeslQpPCplDU6mOXEzOloH4PbpSJts5DTQncah80RTbyRj1srMWlEBX9PyFRmh9r3azqunrwPtQMiDmd8GHv9HhckUYleMCBarPS/J0s0q3wsle1jOA1JMM6IvaUoV9Ysa6nhGKObQJLz+GHO8FbdG8fbslb0c+qkJpBAUq2o178caHArfEkDFpk9u/XC1vrkIX6VAOMwBYjSeklrzTV1K+Brh1Rd/aXCgr7CW66qMeSfesYJ9IzKuVGEsupbG/lTr2DxW2/nkhNiwoO7U4A=",
            "XQAAAQAIAwAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8OSdG+ffqYKcUXeSfIW1m8a/rKhLe9LbLl9EPbv5V3eJxONsN0Zw1ZZxJG686G1ArRe450LrKJr8/w5VpLVe+MOzKCxrIVGiRANI6ccE6czqtqBmc5n2LIE3k9iIwBSyHFCc4V9SWDMNEIEh4X15pQ0vYXTJM5SPM9Ycw4CD7P3Bi1Kz/aMs/YBXgMMbV56M/QguCWyazq62uYeM2QFcYIGHo1JZEuiXlwDJ2X+bEBz69wmIYZVC3n9MxGql75oWh+RVoEd4pIaj3JVPA97t9RCjCOjYm2x+jjglPDTksftIqPQOJEBHIMXey9cTvkh72Ty+hjvxYIjbuWgZ98"
        }
    }

    EFGMITEMS["arc9_eft_an94"] = {
        ["fullName"] = "AN-94 5.45x45 assault rifle",
        ["displayName"] = "AN-94",
        ["displayType"] = "Assault Rifle",
        ["weight"] = 3,
        ["value"] = 82500,
        ["levelReq"] = 13,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["equipSlot"] = WEAPONSLOTS.PRIMARY.ID,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/weapons/an94.png", "smooth"),

        ["sizeX"] = 5,
        ["sizeY"] = 2,

        ["caliber"] = "5.45x39",
        ["ammoID"] = "efgm_ammo_545x39",
        ["defAtts"] = "XQAAAQACAQAAAAAAAAA9iIIiM7hMNz0dhIkbkvLjTdSR5gRNNIHH3iMmwXKHiTIjWV8SKVgpVgINXcNRf+a7fNmxl4D9sXf/AvHBRC15m0D6J5s+jyZ+HlDt8WA8u7kcYTxENNkyVJxLiXQn9OWycuRhf0t/HE3OZhkJOhGMJkeUg5fxReDWsNZAmlqbv7kqGLY6lurBIwA=",
        ["duelAtts"] = {
            "XQAAAQBDAQAAAAAAAAA9iIIiM7hMNz0dhIkbkvLjTdSR5gRNNIHH3iMmwXKHiTIjWV8SKVgpVgINXcNRf+a7fNmxl4D9sXf/AvHBRC15m0D6J5s+jyZ+HlDt8yVZ3XbOtM6M4Zj519ZrmW7OQOhvIpGKj7VQyWqLDPYq7sIO28+FzG+Qo/6E0w2750XKKIiaHkOYD3jQF/QJR1bagBpC4+CvAA==",
            "XQAAAQBLAQAAAAAAAAA9iIIiM7hMNz0dhIkbkvLjTdSR5gRNNIHH3iMmwXKHiTIjZgBMPda9KbI2gKWu6jdXAhVgJrz9f/qJqiyctccfshqDO2Srdf58McUk0IiFRagZ/nrVyfq8Z0AWHGp3Ap+VGU9E2+O7izxXJ4IFREl3T8rNbH1hzs9gCfuSvs+DxZd49vD1gZU6LpAS6TANL4WICNTd8L+Db/8yeY+FxsdjGcg=",
            "XQAAAQCHAgAAAAAAAAA9iIIiM7hMNz0dhIkbkvLjTdSR5gRNNIHH3iMmwXKHiTIjZf91tVR1UmXH3VomVk1f6ZaIbDqXGwIPdjtCxIRmoElpzpi4JsRVrQi+NdT9E2qaBA4+aaZHzAX/TrdNqfcib2BxL7DxEYPGJtJ7LEWWkQhaKR6sN+PwUhDYsOPpedj0/1Wir/bXOIJMehZdRxuimOZ9+yq+w5+thLxvWWml2pUo+CWAFK4jlB4/AftbPqhu40dgLMYKiCPhPMwDTwBIO/7Lp+ASBSBHdKySZhjoovMdeAV26ehVRgQD+zVUNx2fUES7dxv0s5824jdLAi/pP3rhd/diLXuFWXzPfrzSLRR6VeNaPe9I4A=="
        }
    }

    EFGMITEMS["arc9_eft_asval"] = {
        ["fullName"] = "AS VAL 9x39 special assault rifle",
        ["displayName"] = "AS VAL",
        ["displayType"] = "Assault Rifle",
        ["weight"] = 2.5,
        ["value"] = 145000,
        ["levelReq"] = 37,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["equipSlot"] = WEAPONSLOTS.PRIMARY.ID,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/weapons/asval.png", "smooth"),

        ["sizeX"] = 5,
        ["sizeY"] = 2,

        ["lootWeight"] = 65,

        ["caliber"] = "9x39",
        ["ammoID"] = "efgm_ammo_9x39",
        ["defAtts"] = "XQAAAQCSAQAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8OwmVfT2hq/H64qBlSsLc/OGn6XwHM3Rbx0N1ed9Tqdupk/nUylj0UY2YpYpkPX3jeqgqAnCrVaPLvk0QTUg3LiNYYr49MDIapMWEO2/dbjsxcacl4KCmDehoHgxY0hbp4PPja3elSuaXxpvgvSz44rShom0jdSFYl4PdazbHs57zFavwA",
        ["duelAtts"] = {
            "XQAAAQCSAQAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8OwmVfT2hq/H64qBlSsLc/OGn6XwHM3Rbx0N1ed9Tqdupk/nUylj0UY2YpYpkPX3jeqgqAnCrVaPLvk0QTUg3LiNYYr49MDIapMWEO2/dbjsxcacl4KCmDehoHgxY0hbp4PPja3elSuaXxpvgvSz44rShom0jdSFYl4PdazbHs57zFavwA",
            "XQAAAQCeAQAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8OwmVfT2hq/H64qBlSsLc/OGn6XwHM3Rbx0N1fybkly5t1lPJVg7w+L/iJeqRYxp7M469cAp6GThYGUD1FgaCKZCWF+0+ekasLqFeOe7KQO8pfUU5wqDgc5HPRXTUm0O4GK/Etyu5SjiDYSGWEDsfyo4SSTNisIAdP3UHrPZzT2IVtcquXSyAH/EYQ",
            "XQAAAQAWAwAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8OwmVfT2hq/H64qBlSsLc/OGn6XwHM3Rbx0N1ed9Tqdupk/nUylj0UY4VjeRA1JSemFIaFzWojxxm3ax6F3muEAzXOOmovsaRHn1A8VFgIWONhwayiSYa+ObUQlvVO7oAiJlkRuhvzEMljiYL0JU0TElBPYt2VA0NJlZIIvea7M6kW2LCsSSiWbiEgPMGi722g/Ww4/a+Q/kPAQUIfVeRB9yvpzB1MIxHggCWzlqCVRvuFjbrgwZOqPUndLLDBbfK5tty700rvXdPaUDRc923R4y17ZwlmmTYWuVlPF3NYVq//Z5aY62tjzt5O"
        }
    }

    EFGMITEMS["arc9_eft_ash12"] = {
        ["fullName"] = "ASh-12 12.7x55 assault rifle",
        ["displayName"] = "ASh-12",
        ["displayType"] = "Assault Rifle",
        ["weight"] = 6.1,
        ["value"] = 90000,
        ["levelReq"] = 28,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["equipSlot"] = WEAPONSLOTS.PRIMARY.ID,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/weapons/ash12.png", "smooth"),

        ["sizeX"] = 4,
        ["sizeY"] = 2,

        ["lootWeight"] = 75,

        ["caliber"] = "12.7x55",
        ["ammoID"] = "efgm_ammo_127x55",
        ["defAtts"] = "XQAAAQCeAQAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8Lcjh5PiK/llZGDr7oa+u0gaZ5EJru7gxOqJdvNbXpy5tlUiCzfDxOhcoz5+HaAwLcuGJng8zD00WC4H58kQa5GFmHMGDajP9AjQuzCyaf/ErixY5umfnP41eoXt+tOg6oIuPRiquOyhx7c78EIYCpis14lvAw28laBPvvJoVLaNT9SgA=",
        ["duelAtts"] = {
            "XQAAAQCeAQAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8Lcjh5PiK/llZGDr7oa+u0gaZ5EJru7gxOqJdvNbXpy5tlUiCzfDxOhcoz5+HaAwLcuGJng8zD00WC4H58kQa5GFmHMGDajP9AjQuzCyaf/ErixY5umfnP41eoXt+tOg6oIuPRiquOyhx7c78EIYCpis14lvAw28laBPvvJoVLaNT9SgA=",
            "XQAAAQC1AQAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8Lcjh5PiK/llZGDr7oa+unZPJfG1TnZ2rozQkEXAo4yaBMo4D0bzO99vWZUuIOfpSFqtw2iBfPv/Y2xHWvLIac4h+KrvN/u1cQw545eHPVTuU1HNC+IOoM5qyc6NIYAy5KVg+h7gcKZTHX60Jxh/UBFuPwqajQxzrmA1aXW9ADtsDkK7JAqAzmXPM5BWsGYg7D6AKEwrXMO6LauycMYKmwad/LsFsziuk5XKA=",
            "XQAAAQCrAQAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8Lcjh5PiK/llZGDr7oa+u0gaZ5EJru7gxOqJdvNbXpy5tlU3umU1ADwHlh7gVClFsTvHgWS2bHtpC7V1a+K6/Ajr85zZNpZYE7nhXiZv7oDOLUEQo1gWYgyNxVOaV/pOZvCbne+Y/LP/nGRRKMcDlxyMAaGzjvzQI18PggVugXn2Frf+HP9fEhpM02NHR231K275euPLvFof2GZMWvZk0A"
        }
    }

    EFGMITEMS["arc9_eft_m4a1"] = {
        ["fullName"] = "Colt M4A1 5.56x45 assault rifle",
        ["displayName"] = "M4A1",
        ["displayType"] = "Assault Rifle",
        ["weight"] = 2.9,
        ["value"] = 97000,
        ["levelReq"] = 23,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["equipSlot"] = WEAPONSLOTS.PRIMARY.ID,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/weapons/m4a1.png", "smooth"),

        ["sizeX"] = 5,
        ["sizeY"] = 2,

        ["caliber"] = "5.56x45",
        ["ammoID"] = "efgm_ammo_556x45",
        ["defAtts"] = "XQAAAQABAwAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8ONwzg/TnvSdOuj9Kx9YEwhGAFo9OdI268mAArnELh5agZrRYl48tzyKSHZRxI8QcbeeBN+HCcijbalGB5/5S4ud0YP8XQL0kyyAzg4dZq5v9C9Wgv/bLG0NZqUJAylj3Idh4haZYZGesG1yvvOsxry08LzOH4dRl5daY6BYz/Rk2MD1eDXcxDTMFpeaRixzbF65RRu/z9uAt+9nPYoM8toJT12NTIjQiOl5z5wO+nUYwRfdvjMzBr05lk5qree48Vrp2T/7brPVo+4MqBalIlt3aJqtzo2oRIcI0V04b9ZtZQkcbp7ZcrFOHoirKYvsiogOt3JSpRHQ==",
        ["duelAtts"] = {
            "XQAAAQABAwAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8ONwzg/TnvSdOuj9Kx9YEwhGAFo9OdI268mAArnELh5agZrRYl48tzyKSHZRxI8QcbeeBN+HCcijbalGB5/5S4ud0YP8XQL0kyyAzg4dZq5v9C9Wgv/bLG0NZqUJAylj3Idh4haZYZGesG1yvvOsxry08LzOH4dRl5daY6BYz/Rk2MD1eDXcxDTMFpeaRixzbF65RRu/z9uAt+9nPYoM8toJT12NTIjQiOl5z5wO+nUYwRfdvjMzBr05lk5qree48Vrp2T/7brPVo+4MqBalIlt3aJqtzo2oRIcI0V04b9ZtZQkcbp7ZcrFOHoirKYvsiogOt3JSpRHQ==",
            "XQAAAQCVAwAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8ONwzg/TnvSdOuj9Kx9YEwhGAFo9OdI268mAArnEKqcPqoZtM/5PuRrPaaINzSnhMMfZzgRf0oEH0hk6SPwSv7X6NjvNXEfAtyQUonPVCcEspuscIpiQuIjRXF7DqSCymH5EPK2Y+OdmtGW5HSvI1Nr6vWtCYljVLTCQ0exfgN5+CEuYpeJmuet1Yy3pbMtnwNrEc47xa64ndxQ15bDPozQ7z90GWDZT/D2c+YtGX0KMwnVEld2WCg9YxGLqlGIWz9Qm3Pn9Z28xqwQNcR5ERdCemBt0K1FQzKcRt7+v1DyJ7YiCcFPmV4w5T0sFlIgzIFDBvLTx8in+lVGu6Cj2XLo17H2a/SwsSN3wFcuIcI6ZeNBxnf4QISqwV9AA==",
            "XQAAAQCwAwAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8ONwzg/TnvSdOuj9Kx9YEwhGAFo9OdI268mAArnEKqcPqnrw6/qUbjSE2GuTTvCFF2iEga6a5W+ZDTEHwuDL1zNb7UBopC0HaezTgX1rY3WAWkaxoizDMynqbpXOelZMJ/Q4LwqEBwgE9oyS5ifgdho3B4nRSKfU/Bofq8NBUEf4FKPESW+MLjhD1okyPBklMn//t4pgqYjrhPSN461TR1vV9qNXKA0jUTltDDGRaBlXZZOdt0hKCSej/5gpGeFzQOBvwFQkbpkS0J0TrEgPeKdDo+r/tWYKPKUebFBDIMsz7LPdNCeKSXqaj8b60QkOCiGlTY9++clvqOTgS2iIUYcRXpKm8YvxIW/31QuJcHRp3m9ppDD1KAMO0Guy2txchpLT0TcQ==",
            "XQAAAQDABAAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8ONwzg/TnvSfVC0aV+Zy2yYaIJkZwp8zsKn1/U3WIRa+zeKUepi+hV3BCAw2U3kgDSj3Yz83deCI8Ykqjs7YEG+bi13cI1FD9M5BHSep/MOQp49UyuTIJn/J500kQYI4SOndRZ2BB1umDpVXjtzFKiw1t/+bJfC7Ifge9yDkmGpmM7PUiBDuOAyZB10dtHaKWSJdj4mxLxHpsBu5/dlljhPpng6M/VOlKFncC7P7d+5miQ+4J1YsRKzbKRM25ey7zD+EJwq2DgqT2ffdyo5EyprRE7StUpTOmUNY+IgzX951+yX9FfzMZX5wMqYjL60wwlstC00y4K/wWEnnvy1BJ+f9Mf/e7p8jIRbQGriyj3NaXKEHorxj2Q4DZS3L7u4ooAUZBTo3bqOIemMHxBskuQjUrRl8AVO1JX6/z6bYXXPxuAqofAGS3XWT0AgPUzIpqWGthVG8IEeHYLTflJnOZq+nYekSWfv75kFN+CA41ngA==",
            "XQAAAQD5AwAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8ONwzg/TnvSdMzJPZ7gDzyNvr8+f2G3Iksit3BiglfQUARkkA4ESggPkGiyNnffwIsOSzVvR7fzgB3b0lEZ9zUPrp4iF2+xTjwS+168nWSqOG+OVIojgTA6ela5+zhV3250Teoy7HlZLQNA1FY71CezwLM6TilU2hvR7fTaxwbkFdN6LXy9U8iix+UyJos4kLYfgPZwiN3IjSr3En+Zv7GMQwQpXTA9l4WAwq17gOyJKcL6j5fWD4kLALEDbFMAst0OZJV+RVPQ9DD5Wn6q/nLMq9HeBie3OC9cEwkFwHwi8Pdt932BInueH6dZ/ryOM1r7pNQ2VetP8t5NvNyQTgw3jkDF+MSxgar/N0ojGsi0WIGw4POHHO5BFmt1TJLnZvRu9mgJNAq7JY/1eWkpdG2AcWeYkOX8Y6ji7IpfDwJcbfg3ZS4/t/hRg=="
        }
    }

    EFGMITEMS["arc9_eft_sa58"] = {
        ["fullName"] = "DS Arms SA58 7.62x51 assault rifle",
        ["displayName"] = "DSA SA58",
        ["displayType"] = "Assault Rifle",
        ["weight"] = 3.9,
        ["value"] = 108000,
        ["levelReq"] = 22,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["equipSlot"] = WEAPONSLOTS.PRIMARY.ID,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/weapons/sa58.png", "smooth"),

        ["sizeX"] = 5,
        ["sizeY"] = 2,

        ["caliber"] = "7.62x51",
        ["ammoID"] = "efgm_ammo_762x51",
        ["defAtts"] = "XQAAAQDSAgAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8OSPFaQ+Z9j7jFV/QkWSo8LF+HuEPkjjdPYu1ECAHLWrbSjF+V6XRHGwHs6qPztm+72vAncD3zcqemaa+4eLgG/GWVH8hbIr/NcIAL5P/2ZsKX/iK62hXF9TSM56Qai5nL/b/efkp81vIa+kT9BDbplJP1czlCfdAYwjpwNkO4CcFjKPplwQXe8dZC1JZaBVaovscQbjBs0RaRXH5XsdxvPdvXMmC0/kZOWYmkBQrD/mKs2yk2NJhqIBTv/xM/FCQRSQKG",
        ["duelAtts"] = {
            "XQAAAQDSAgAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8OSPFaQ+Z9j7jFV/QkWSo8LF+HuEPkjjdPYu1ECAHLWrbSjF+V6XRHGwHs6qPztm+72vAncD3zcqemaa+4eLgG/GWVH8hbIr/NcIAL5P/2ZsKX/iK62hXF9TSM56Qai5nL/b/efkp81vIa+kT9BDbplJP1czlCfdAYwjpwNkO4CcFjKPplwQXe8dZC1JZaBVaovscQbjBs0RaRXH5XsdxvPdvXMmC0/kZOWYmkBQrD/mKs2yk2NJhqIBTv/xM/FCQRSQKG",
            "XQAAAQDKAQAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8OSPFaQ+Z9j7jFV3rzTmELHJeXQPtfmKYBA5xGpgo9I5ORrL6SsJyJt21CVlWvsXwiRwQWmdpRB0kcE0Jx13KER29uej/BHKjjIIPovgTPUeH99WdQMcs/Uje7cJNDFXQHKzzdMr56R3iP+uDf37ZYVqGWfQVvX/8a5wF0G+G8i4HNCCaAXJVJK87sMufT/Uj1AnR7jGnip+SAWEwA",
            "XQAAAQApAwAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8OSPFaQ+Z9j7jFTJaIOD+qOgrN0D28E5tIJi59ISWs1NmHUoVL+1yx0OW7qoLuFeF/++nNUZ0kvWjc++Yz1r+G2GlQYKgaruZKIsb2/tto/1aWDhLZLi4wrL47FmpwJEC2249FvwvVHJ7CpjmRzkCbwfxeYYe+LS/JWSvqiwtqb3vL8ObeKrtnT1WkkBD4bS8YEM3JhB3CAi3r1MopljeuN9pPL8b/+8M54gahWTeVeyQ66xJyEGjzLb6XuEautErIvkv0Tyyxb2ZZx/u0yN3QeMe7mkn0dI+4JISixhYX8ACNGSkNV9mtJcKsAUWmvEMn0bgyin4l9AA="
        }
    }

    EFGMITEMS["arc9_eft_mdr"] = {
        ["fullName"] = "Desert Tech MDR 7.62x51 assault rifle",
        ["displayName"] = "DT MDR 7.62",
        ["displayType"] = "Assault Rifle",
        ["weight"] = 4.4,
        ["value"] = 189000,
        ["levelReq"] = 30,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["equipSlot"] = WEAPONSLOTS.PRIMARY.ID,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/weapons/mdr.png", "smooth"),

        ["sizeX"] = 4,
        ["sizeY"] = 2,

        ["lootWeight"] = 75,

        ["caliber"] = "7.62x51",
        ["ammoID"] = "efgm_ammo_762x51",
        ["defAtts"] = "XQAAAQD4AQAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8ONwqzmFISRLjG/VemL4oZlhMCtKZULDcmVXRhJNGlioWR8BkkaIttiYQupxDEIfTeGA7uawLFRKY/x3l2r8NjPnsTTYc9PxAfJBRmw2WAq1b6oq07A3t91rQ7nIyj6v6oXuhN8gDnoTHGCV5Zge4enwyPxKYAZMp1HayVY03PYyXPtDVuvI4fwAW/Halwd8LLzMvSwRSGdbwqDx8FrbBw",
        ["duelAtts"] = {
            "XQAAAQD4AQAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8ONwqzmFISRLjG/VemL4oZlhMCtKZULDcmVXRhJNGlioWR8BkkaIttiYQupxDEIfTeGA7uawLFRKY/x3l2r8NjPnsTTYc9PxAfJBRmw2WAq1b6oq07A3t91rQ7nIyj6v6oXuhN8gDnoTHGCV5Zge4enwyPxKYAZMp1HayVY03PYyXPtDVuvI4fwAW/Halwd8LLzMvSwRSGdbwqDx8FrbBw",
            "XQAAAQB+AgAAAAAAAAA9iIIiM7tupQCpjrtF9qJbeNZaSCEX4Y6O26Hmp1HRpqw8uiVK1lgkq65OWmX0/tg5xyt7BSf4T3zq0xPV+EuN/TWHDiPN0Ci66JUUiGObWJ6CMt9ilUECn+HFZEfSNlEEHkYB/f4z0Pfeho0J8UWpZbM7gvNn/RCFwuBVWaCwVo+JLYCMxvwpIptkRAEglQJa4gXztd/39+2rTwZTacN5RCHrEDHPtu98cqNwnxUb155dxnAX2HBeUAUFQwMFqOeGn6hoXcrwpn1FwOkm4/ZtJqouomt+AA==",
            "XQAAAQCOAgAAAAAAAAA9iIIiM7tupQCpjrtF9qJbeNZaSCEX4Y6O26Hmp1HRpqw8uiVK1lgkq65OWmZJtDbeMwvfH5bkjsWjIF8wNlr6Qh5L//WLqXzgHaz1w91x0ztpGZD8/UrC+XC7/0nbLZtnui1kDmP3O9rfxBk8HZD3xExpV5l8V3xyxtprN3CXSa+Zuok4AsBD1bGpihX/TpMadicctomws1uLrY6s9wFZYmVEZuRuHFN6cFa4OOXmisO0arpwl8cpUA7givj5w9T+lZVRn00rOO/HsITKrsm2WWpY4mbIoJz5cBVqnsA0LYKarci/aJZOj2zq"
        }
    }

    EFGMITEMS["arc9_eft_mdr556"] = {
        ["fullName"] = "Desert Tech MDR 5.56x45 assault rifle",
        ["displayName"] = "DT MDR 5.56",
        ["displayType"] = "Assault Rifle",
        ["weight"] = 3.9,
        ["value"] = 83000,
        ["levelReq"] = 14,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["equipSlot"] = WEAPONSLOTS.PRIMARY.ID,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/weapons/mdr556.png", "smooth"),

        ["sizeX"] = 4,
        ["sizeY"] = 2,

        ["caliber"] = "5.56x45",
        ["ammoID"] = "efgm_ammo_556x45",
        ["defAtts"] = "XQAAAQA8AgAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8ONwqzmFISRLjG/VemL4oZlhMCtKZULDcmVXRhJNGlioWR8BkkaIttiYQupxDEIfTeGA7szStyP1abuabMk2pZ1RHFmvPXZDFNsQxVOHYjjaBTVtxztjaHlzfTLymJyZSQaz0G7CgE/zPv3fYK39RivcrJynHmCMoSNpyd3t3NENOpOI3iU2XeqyhNRRhNh4NV3vI7Ahtq+P6NLCklaW+PoVAYZQ2yeE7A",
        ["duelAtts"] = {
            "XQAAAQA8AgAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8ONwqzmFISRLjG/VemL4oZlhMCtKZULDcmVXRhJNGlioWR8BkkaIttiYQupxDEIfTeGA7szStyP1abuabMk2pZ1RHFmvPXZDFNsQxVOHYjjaBTVtxztjaHlzfTLymJyZSQaz0G7CgE/zPv3fYK39RivcrJynHmCMoSNpyd3t3NENOpOI3iU2XeqyhNRRhNh4NV3vI7Ahtq+P6NLCklaW+PoVAYZQ2yeE7A",
            "XQAAAQD9AgAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8ONwqzmFISRLjG/VemL57ghBPEwQ3CkKEW1kydSkHU/P4eoDyB9SzKkgFbdy3JnB3+4BU1iFU3MPuYi3i0o4uGAH4C+g+3yjV8tR3/nG7bjjBU+9JMdmV70oH/VkXuGvS3TFfUsSIUxeKuDjUSq5dGYugzSRZ0V/hwJXxREIuLURthTkshI7Pbj1NsCUSX7ZktA7Acafu0lQYVfF+GtA31Bt6rh3NjerHy6yPZanUupAU5uMbjXMGsgP9E7RTaoOKReGy1oO8Du/sdM7mBXGuWrZ1yf9p7FOuVh9urmz9GTq1X7iQHac6UTPTmAA==",
            "XQAAAQC/AwAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8ONwqzmFISRLjG/VemL57ghBPEwQ3CkKEW1kydSkHU/P4eoDyB9Sy8IPrvR6s0mD1uKycswmNYHjNpY6GhMFDghW985Yy5RhrxI/6ilhue6O0jKcd6bpU17WI6bzkk3vHxjy942MfFlq9iMaof053xtS1mUjdYlY5lPGUqG3IjcLnCT91NeqYbFpKanOt8dMHFByQJ79xDdg4UXqUM5zWvtgKeqnMypL1+Mz6Ne4odXGSUi1yBFBWPU7MmvKWLMwD5unKXpHNX7Az2BsUhVqZ4iqHHjYVNycxElZxym/PVnNjuU+LXgTTGGFBcmBQHfoQNCzy1Rbr/eF9wwXfPy4qLhO2bsJVJdHlo68QP/+S0bENBzP+jFT+wXp4Taco5HQ=="
        }
    }

    EFGMITEMS["arc9_eft_scarh"] = {
        ["fullName"] = "FN SCAR-H 7.62x51 assault rifle",
        ["displayName"] = "SCAR-H",
        ["displayType"] = "Assault Rifle",
        ["weight"] = 3.8,
        ["value"] = 149000,
        ["levelReq"] = 20,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["equipSlot"] = WEAPONSLOTS.PRIMARY.ID,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/weapons/scarh.png", "smooth"),

        ["sizeX"] = 5,
        ["sizeY"] = 2,

        ["caliber"] = "7.62x51",
        ["ammoID"] = "efgm_ammo_762x51",
        ["defAtts"] = "XQAAAQCvAwAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8Lchzpvw0LefC8cKmSsx2FONi6w2fdtBqbRE9Vb00gVDvijCNLXoLoPgvffNK3Ts0h+hlNZzplarnB0yQ1tBql+DJXHQE5KjnHwrHTsv99djgpg623p2x8ZIXRr9Hj0bkJ+fo0BE0Ktx1Np1bwp1Ih15WjqZW6ODVgWg+t0eBEfZ6G2XhERPOLgRUqR4lA41QPVpN5CBrvXz8vYqez4KtrMRYyxW6kL38KYR9g8LWYhZYV2qKDoUAnUqh7aBSE70USzJjb0yj8li0BI8sZifzAZKv+NVhSR9gHgwvSdmScKTpK",
        ["duelAtts"] = {
            "XQAAAQCvAwAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8Lchzpvw0LefC8cKmSsx2FONi6w2fdtBqbRE9Vb00gVDvijCNLXoLoPgvffNK3Ts0h+hlNZzplarnB0yQ1tBql+DJXHQE5KjnHwrHTsv99djgpg623p2x8ZIXRr9Hj0bkJ+fo0BE0Ktx1Np1bwp1Ih15WjqZW6ODVgWg+t0eBEfZ6G2XhERPOLgRUqR4lA41QPVpN5CBrvXz8vYqez4KtrMRYyxW6kL38KYR9g8LWYhZYV2qKDoUAnUqh7aBSE70USzJjb0yj8li0BI8sZifzAZKv+NVhSR9gHgwvSdmScKTpK",
            "XQAAAQAtBAAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8Lchzpvw0LefC8fUEuTRQwP6//dApjvK/cbUeClKyPdssEEZT9mJgp4ZEj3E8fGJczjS9POecvHrP0H2xjsS0y7pHhC6xwokEBd/ar5Z4u3lNFm9FyjKXUfLMhOZLAa49Q8uDctUQFGlL3evzM3/Bu6FL4SlaKBECRyOKr5irp56Rf2n5MLn+vPsI5mc40KIvj137Oy6rXL1tTNgf9P00EmLWFskVV+HV81NjS9ZDXEE2pB5VZBSuoCZhJjBskR2EROLVx/JeSKLXrsxwrs654A3R9VmA6PaaT2w60ydpImwlrsXOmngK8dENNveHubPWz6gFVyD2AZQe5IYuVak6Oo8E7yK8Z/4vPLoYYkNHj28FbZPsU",
            "XQAAAQDxAwAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8Lchzpvw0LefLbRq5NodydVADfSzTVRjhGwpfvaoULwUVgmaDJSEVCJ7fduRjF4e3rrpOdkaZH5S+d3jN/Y3y4skp2JM6Jg5ww3lVJVlQpP/3CRRrNpahcuD2gv9e2fwq+LX/A98BxSipW9R7fIK9RveyhZKOcefZ0rcUEVOi/IipSXw/EOGdAJ2irMoj+x0yi2MrCFUgLCxCMv5W7KOfGGzv7v0Lb48ZgOnVYJBNNCM7C4D+CsSlAdvugavD4cVVrj/XRppZgVuwoDbKQpRk52yIBj4pTy7jHHfcfD0plEroUTnP43u/n9O2GpBwOJyRDgtSa+nbZ96YwQtiZgcLG98+He2O43N+8lF/HGWtuzHyKySOb+e8fu//iLRt7pjBKGwA="
        }
    }

    EFGMITEMS["arc9_eft_scarl"] = {
        ["fullName"] = "FN SCAR-L 5.56x45 assault rifle",
        ["displayName"] = "SCAR-L",
        ["displayType"] = "Assault Rifle",
        ["weight"] = 3.2,
        ["value"] = 64000,
        ["levelReq"] = 20,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["equipSlot"] = WEAPONSLOTS.PRIMARY.ID,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/weapons/scarl.png", "smooth"),

        ["sizeX"] = 5,
        ["sizeY"] = 2,

        ["caliber"] = "5.56x45",
        ["ammoID"] = "efgm_ammo_556x45",
        ["defAtts"] = "XQAAAQCTAwAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8Lchzpvw0LefC8cKmSsx2FONi6w2fdtBqbRE9Vb00gVDvijCNLXoLoPgvffNK3Ts0h+hlNZzplarnB0yQ1tBql+DJXHQE5KjnHwrHTsv99djgpg623p2x8ZIXRr9Hj0bkJ+fpSP5oQl1gUd/uBzgHZXPqYDia3zGatZntVOmvdLNRO6b62mBLy/jeajU1y4EMLAz2jReJ3sKDWbGuBmk3qznnO0wjcIWxrS5ijwqLbZ4qrwsohYL1bynfst1WEfzM57lgSYhmRNvLgzdoGMHRlj69by0vLYwo5wfaPy5sLVqYFK+DYAA==",
        ["duelAtts"] = {
            "XQAAAQCTAwAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8Lchzpvw0LefC8cKmSsx2FONi6w2fdtBqbRE9Vb00gVDvijCNLXoLoPgvffNK3Ts0h+hlNZzplarnB0yQ1tBql+DJXHQE5KjnHwrHTsv99djgpg623p2x8ZIXRr9Hj0bkJ+fpSP5oQl1gUd/uBzgHZXPqYDia3zGatZntVOmvdLNRO6b62mBLy/jeajU1y4EMLAz2jReJ3sKDWbGuBmk3qznnO0wjcIWxrS5ijwqLbZ4qrwsohYL1bynfst1WEfzM57lgSYhmRNvLgzdoGMHRlj69by0vLYwo5wfaPy5sLVqYFK+DYAA==",
            "XQAAAQDiAwAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8Lchzpvw0LefC8p483EsQaun+djmRDHm3jMVbTK7rT7drjsCnVXSqq+j4N4gOKeKSN+00dk34/XqyVRUqU+MsqTzEloVgDlfhQVcCr1M/mvdzuDHeRfbAaIX5kXerOqSNR5Gu43W3GgPSypWXHQhde91wescARg7SAm9nLP9fDGsjlTaedF5HOtTujAr4flOqgXr6MSyeIQPpaJT/8hG1s5za0Sf5Vyq6ACtLA0BM2kXospdfXI5GRnzVH2k3J1r7q4npVggEIm3AuU4zuDsvCD/O73p/f4bnZWKFnlGslZ/c8WojgLO3sG+1k+yw+lh4orz5AxdJAHNvz/Xz3fYIqnA7WfA==",
            "XQAAAQAxBAAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8Lchzpvw0LefC8fUEtgdNic8Uqb71W5J59bMKUmZ96q9HnoEewkdDo0Z7tQp7xF20ZLiGAT85G8m40JDWFQFOE4Estb5YVO/9Cmxi0F2IW7uLSi15HR8QZnCwtrHxE3UTBsMPYfccTXrOS/SRDt2ll+Emt+BXZnKkieGSrRP1qWdAsbvmn/b7848Bkuyn5G45dK3lXrDp1GdonTscOpmFvvDAkuNzjP+Qvmo5Dju3hasxFsjkU+9GFgEqKWAfH7IhAlBHJfqiDF+ck93/CtVD3R0k0dz0DtrYzDyFVcncFpP+QXDN+jyxkGRvIJy5p3HuaWbA4Ir8A2EDijYOBLoMOUH4B/3LIf5jjsZuRk4cknJc6/tNVfueAOAns8gL4PsMb8gZM4h/ad6b7jHFbvesVZ2wA"
        }
    }

    EFGMITEMS["arc9_eft_hk416"] = {
        ["fullName"] = "HK 416A5 5.56x45 assault rifle",
        ["displayName"] = "HK 416A5",
        ["displayType"] = "Assault Rifle",
        ["weight"] = 3.8,
        ["value"] = 139000,
        ["levelReq"] = 29,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["equipSlot"] = WEAPONSLOTS.PRIMARY.ID,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/weapons/hk416.png", "smooth"),

        ["sizeX"] = 5,
        ["sizeY"] = 2,

        ["lootWeight"] = 75,

        ["caliber"] = "5.56x45",
        ["ammoID"] = "efgm_ammo_556x45",
        ["defAtts"] = "XQAAAQBUAwAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8ONwzg/8xPddUIcJzvtQD1KU7srpRLtA975iQzkGu1iCVddOzJGUaKhmxG58LYnmpfteaZRuBnLbRn2c1sWgRVNteDRAcEffZDHLJVMHsOZkim5FCv+yaXcGRadq388nbXl0llD5GKT6H/wYm+qA35tCsllQ5kmlxetwyXQQqaa4prMpNNYqm6ijjPUV3ZdPq4xbXusdXvJZzMag96690TVOOWkpnrzeGGygm0BbEXtEYz/i6b+lq1sfZPz5zG8RLsGMjL7G3dodBsvpBuvPTnfVO8F+R+HQaW/eyp53aYniBY3FSLPL1JVTYjv0UlJ/8RlLi+NJpvYA==",
        ["duelAtts"] = {
            "XQAAAQBUAwAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8ONwzg/8xPddUIcJzvtQD1KU7srpRLtA975iQzkGu1iCVddOzJGUaKhmxG58LYnmpfteaZRuBnLbRn2c1sWgRVNteDRAcEffZDHLJVMHsOZkim5FCv+yaXcGRadq388nbXl0llD5GKT6H/wYm+qA35tCsllQ5kmlxetwyXQQqaa4prMpNNYqm6ijjPUV3ZdPq4xbXusdXvJZzMag96690TVOOWkpnrzeGGygm0BbEXtEYz/i6b+lq1sfZPz5zG8RLsGMjL7G3dodBsvpBuvPTnfVO8F+R+HQaW/eyp53aYniBY3FSLPL1JVTYjv0UlJ/8RlLi+NJpvYA==",
            "XQAAAQCbAwAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8ONwzg/8xPddUIcJzvtQD1KU7srpRLtA975iL1FT1faZVOtoh5Yc0oTjVVooqIzsqvJT0w+yVV4sm38paBFqHjkdhtaXByE5cgsgam7c3youDX4KmZUV3/zoj7SDIbBP/nL/oh8zb++mBW102fgggEXy3ajKrF19FiKSBRAZkbIs5fZZxyzVKDFUFDjMcL8ZFqkifJqX+vU+Xr38+6L4dbAzrz1YbhWZoq9/grVOWn78UH1z/dfqvJVbZ+Dwp+KhKf6bhwkbivnCTmlkNRWrtcaTFk7jfzS8SzBepqRgyJamB29/OeMrnTuQmOifdX24k+TUwTBp+ILbhwvqred34BrRLbICHEjArSFC5I10NZNC8D8sS5b6qlgA==",
            "XQAAAQA8BAAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8ONwzg/8xPddUIcJzvtQD1KU7srpRLtA975iL1FT1jNQrWwbd2kE93Q0MT4Bi/KfXWf7a77iQEqFhwZZ8mWLk4/bsDe8aIUGBsp1vQ3FpoIrmyrkil+Hdf2969RpLyWKH/2Sd9WGE5zQSSB3QWvJx59JdEmC9S1sd81gKS2miHykearNViIm+PLDUY3XkIxngOVTCKd9mZazudc3LXFkFJfS8RRZvUGjQxR9dpjL9bjfX7MhhLygxOY3tsPlZX4ysQg+pw8z9cLSJ/HiQgzzKLwYgwlzPFFONy0F9VG6xrvtt7qDMXJcLkrJBvdzbMrDiLcyWX5CUNkWlp+AFd6ctwpOT+RfCCB8eOi327V38ofqo5ItqW2LzAfAGxzB0r8othE+1AyTZm/l33n8BCEKrkUt7TLhsVefKAzScf39AYf6CFPk7cuPHj7INqkULFoWuoNiw="
        }
    }

    EFGMITEMS["arc9_eft_g36"] = {
        ["fullName"] = "HK G36 5.56x45 assault rifle",
        ["displayName"] = "G36",
        ["displayType"] = "Assault Rifle",
        ["weight"] = 3,
        ["value"] = 47000,
        ["levelReq"] = 12,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["equipSlot"] = WEAPONSLOTS.PRIMARY.ID,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/weapons/g36.png", "smooth"),

        ["sizeX"] = 6,
        ["sizeY"] = 2,

        ["caliber"] = "5.56x45",
        ["ammoID"] = "efgm_ammo_556x45",
        ["defAtts"] = "XQAAAQD9AQAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8MXq1bvq6bgjOSIGCJgLqbsTlF0WfwVNrBtJxovR3TGwJB9vxZpkenqFGqgI+S6lhrRXjW8nAjeuQIEojfe/G/0tPbd0TbBOrG30rYlqGhwt7UwkcVdCWnvOCVUbB6GOvcvzXsHiv05wkgRSPi786QKDPyYPjUWTPog9WH7UQPlgwlHkO8pYGOvi487KHq7ejUGOhU5JjdQUHgpB/vwl9moduMKFWr/Q5VPIgA",
        ["duelAtts"] = {
            "XQAAAQBNAgAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8MXq1bvq6bgjPzV6n1mohxynBaDzb50+59XEuh69BuMArLVz1sPmb6PdcTobYOGxxx/qost4lRA9JX0SY78KP+GnaxKGHUQ40ODxxopkirBtl3+yzdKimAlJhfvLFRNuWanVIs8QGA6SLPpmIvYWtJvdyZo3NTJS1VxCYWXqPaozWF99B4c/Oo5ls3b5AE7ZIA9NGz2U2Juw+4ptkXetwerCdqYDum9g==",
            "XQAAAQCqAwAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8MXq1bvq6bgjPzV6n1mohxynBaDzb50+59XEuh7B0pFlHBHE8MP7ozY5NnsyPjf6iVQQR0s2rj9Qvj7obskS096ohRhAPpanaCXCo0BkhBGWMkS2Yu781Z0LGIYUI7q3qKmymR6QO94dNDMBpL4gWXetfZx8B/y9QutXDhsE+d7GvVYuoKUIFJ7lPnWDaw3PqjGbV8InSToJrS2SqSUo7JZPiIFVE3p3RIOoAXZsMeY8d2f9mqsqbDJVYtsfSQKCUcMtSsxdPBWukDhl6V2M5Znfcbl32LcbVgycRGDw4nQ8zKHmpriHntk6YoAaETiB7MyvU4j/zJoTY9Y093O0wkyX1LE/2N74vdN3dNZ17n0ww=",
            "XQAAAQAkAwAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8MXq1bvq6bgjPdEx0v+Y+n9eQw3zmy+7DX47vxpDSNLWhq28c/dK/2JFOkdqM+JGyQQEWwXVVezgTknpPrN/jx/wm0vMiXTa/8azubZ231LOOslKk13HZxa9LcSI7iKSUheRWw7t3s9o27al9+lIjwnCxaQi1Qjax7ECP+YsupcmMK7u6tlcxMXfCXnrbHPbo4ee/mFOxAi7Tx7xD/Skct6H4P01H0ERRERtEiHCDmamheJVHFjCzG71TJb7G/5UsnvNeFfSiBJGOnhn6x9xuCnJqD+OzHKE/h+RON7oizsESqEvBvtqtfNfGkI9su4A=="
        }
    }

    EFGMITEMS["arc9_eft_9a91"] = {
        ["fullName"] = "KBP 9A-91 9x39 compact assault rifle",
        ["displayName"] = "9A-91",
        ["displayType"] = "Assault Rifle",
        ["weight"] = 2.4,
        ["value"] = 36000,
        ["levelReq"] = 1,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["equipSlot"] = WEAPONSLOTS.PRIMARY.ID,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/weapons/9a91.png", "smooth"),

        ["sizeX"] = 4,
        ["sizeY"] = 2,

        ["caliber"] = "9x39",
        ["ammoID"] = "efgm_ammo_9x39",
        ["defAtts"] = "XQAAAQBBAQAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8OxEj3M6NEz8aDJRJgCO71iBAJt5wSUKAbDrCLqIIbEgbmW76rULjIaHb3prbj4/85H8qolydNzsXrEQsuea+jWEhoj8hAkeQGbBFmj8RHquOzwBBXq9IHdbh2lXhcIYIffJOIsG6syZVOB7HcxYSfXeR7LYv+KHF0l4YROQA=",
        ["duelAtts"] = {
            "XQAAAQBBAQAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8OxEj3M6NEz8aDJRJgCO71iBAJt5wSUKAbDrCLqIIbEgbmW76rULjIaHb3prbj4/85H8qolydNzsXrEQsuea+jWEhoj8hAkeQGbBFmj8RHquOzwBBXq9IHdbh2lXhcIYIffJOIsG6syZVOB7HcxYSfXeR7LYv+KHF0l4YROQA=",
            "XQAAAQCpAQAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8OxEj3M6NEz8aDJRJgCO71iBAJt5wSUKAbDrCLqII+iG1ERnflcBb83EI+duNXgc8/q3k2jrn/0rkJ3uJmYWMfkcKbh2Qxnwnp4YsPtAS3T+2kqs1kZ0NTnxKgWPKdU7TtwzABLqxHjIIz7LjiS1hni4iekxd84mxLdBVQDYyvM6Q+PbsBo5DBndx9gnxRuIQmzXuApJDtYI7d",
            "XQAAAQD8AQAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8OxEj3M6NEz8aDJRJgCO71iBAJt5wSUKAbDrCLqII+iG1ERnflcBb83EI+duNXgc8/q3j2mGSZd3dvcklpQ29VClY00Dtb85UPFAQrwa8zNhFpFmrVBhsxeMd7x4x0z/+R95F5ZmEPyhYDS/3S0PID0Ozq9/wvYo9G1OOS9gko4rE303bDFDqb1T4o4J4qJC/JcbHePtOlMSdIZT6RTWLF4XkRbyvMxYvfnJ+hYlMhQVRMeA=="
        }
    }

    EFGMITEMS["arc9_eft_mk47_mutant"] = {
        ["fullName"] = "CMMG Mk47 Mutant 7.62x39 assault rifle",
        ["displayName"] = "Mk47",
        ["displayType"] = "Assault Rifle",
        ["weight"] = 2.3,
        ["value"] = 110000,
        ["levelReq"] = 29,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["equipSlot"] = WEAPONSLOTS.PRIMARY.ID,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/weapons/mk47_mutant.png", "smooth"),

        ["sizeX"] = 4,
        ["sizeY"] = 2,

        ["lootWeight"] = 75,

        ["caliber"] = "7.62x39",
        ["ammoID"] = "efgm_ammo_762x39",
        ["defAtts"] = "XQAAAQAkAwAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8Lchzpvw0LefC8nJifjVbTknHCQBjxUoQrnXPJE9wVW1sa2b3/dGIriqHhC9sLIkt8/JzzkdUEJ5nYk8T3lqyL22ZE1nvjUItPtSzo866Tp0eCSJaACFrWrJ8YcYaYztbxHFp6JS7x5FMSjLlzJNh2WYabJqumoLED74PSOkpXUHoChT5JEVUPXArnvXUUmh/B0SxRZsXUShWtLcYL7xA8185qm6V4YJrRvQZqI6+h/yqwsrgCkidnvmmksQjWyFV0KoH/5QKKkltDU66v3OzX6zZi7O8g1LJUnxM1COq0qyngret0kIyDwtmewwOxuVfQ",
        ["duelAtts"] = {
            "XQAAAQAkAwAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8Lchzpvw0LefC8nJifjVbTknHCQBjxUoQrnXPJE9wVW1sa2b3/dGIriqHhC9sLIkt8/JzzkdUEJ5nYk8T3lqyL22ZE1nvjUItPtSzo866Tp0eCSJaACFrWrJ8YcYaYztbxHFp6JS7x5FMSjLlzJNh2WYabJqumoLED74PSOkpXUHoChT5JEVUPXArnvXUUmh/B0SxRZsXUShWtLcYL7xA8185qm6V4YJrRvQZqI6+h/yqwsrgCkidnvmmksQjWyFV0KoH/5QKKkltDU66v3OzX6zZi7O8g1LJUnxM1COq0qyngret0kIyDwtmewwOxuVfQ",
            "XQAAAQBVBAAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8Lchzpvw0LefC8hv59A4CQeaGlaPJjqs5VnIN0AFBsBso51IxEtxO+V9oI/mkTrB6WdzgxxgkQEKpLSWpMvbFUuv4BwX0ACVYk58M2LzfZZDOBiLjVelpsIUVA8m9RX3aN6dnrFg8i7GGgN1sZw9s3KIWVOhH1mHn6tA/IW6OGHbeeh4HAB3zMZZ08PmnAl/UjlcHyIPyUPgtEsDa5Q31GDibmF9JD4niq7ed341bhYSuhgFGblLoyDIp3xYO8R99TH5ltgZbZYIPwkEVBEzMiNhSmBoWJ/F/lMyqr5Ntpd8NEfMnGT8WtEtq0xHtKWgXh65/qzHSlCQrY2EEza8lSjN2ZOG0oLF1y7Kp1Fhk7Y3CdnqRYuh/d3hPM/ep/QWtpLzgdi0nQ2j5kSyOFpFKzhYyJjG33QJMqLDC5z/AA",
            "XQAAAQAtBAAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8Lchzpvw0LefC8fUEtghrfk/qB9rIoG2QfmAbSBUGWf3tTTtifknJxejVHIQWDXPxv2VGd7QbZVkjGP+OLM5x1smWJWpJtIH5F3vGQma6e4ftDgSsjx2wj698u6pVhBzR0Sfoh0kQwNYYUWtiDVOXFEpEfq6FVClWqQoCFuI3DbY/6BLF0EtbRTSL2lEi1IK57Pz1pgiPFhwa7vTR0eUnc9WUAhx5CEXniF0YDTe3vGNC5z7FPuWr15j/sI46x+DAap0Pz37D+fEnFB9nKVG+k7GAsBUQBnPNAwCaBvWeDeGNAyR9CBIYz/CWlIn6hAsgVG+rTVUGoZrAOHXVNySKdQtWuOoix0fUGdOxKunGdFy8ArxqxLjjFMUDe6zK23sus3DQC08/XbGmZuSb+2TGTwQ=="
        }
    }

    EFGMITEMS["arc9_eft_rd704"] = {
        ["fullName"] = "Rifle Dynamics RD-704 7.62x39 assault rifle",
        ["displayName"] = "RD-704",
        ["displayType"] = "Assault Rifle",
        ["weight"] = 3.8,
        ["value"] = 88000,
        ["levelReq"] = 25,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["equipSlot"] = WEAPONSLOTS.PRIMARY.ID,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/weapons/rd704.png", "smooth"),

        ["sizeX"] = 4,
        ["sizeY"] = 2,

        ["caliber"] = "7.62x39",
        ["ammoID"] = "efgm_ammo_762x39",
        ["defAtts"] = "XQAAAQBtAgAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8NWDT+kEGPPnGI9Ho0W6AoGsTnmW59C2oiRFRBLwgoxe4xV0WX6qxNx8dyJP/FQw1B3pV0KKOxnfGbRot9mzre6sDSWfks4hMl1SaxfynBKxJqOIslgwM5T8W8PwovOlUaB/xS7JArBkKF0e7Qnj+tsBEsHJNM36FMgi3SNVvtbWFhloUvN6wUNCbT4u3uCH/owxYXyZfzMwwZHkXfyowvkaATWQWjbNJv8IcEJVUkYj5zgJdDMiFvsIk0TuXbSt/PMLL+sTx7kuKhwzk6SWAO138NTu2BE0EaSlj8AUUA",
        ["duelAtts"] = {
            "XQAAAQBtAgAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8NWDT+kEGPPnGI9Ho0W6AoGsTnmW59C2oiRFRBLwgoxe4xV0WX6qxNx8dyJP/FQw1B3pV0KKOxnfGbRot9mzre6sDSWfks4hMl1SaxfynBKxJqOIslgwM5T8W8PwovOlUaB/xS7JArBkKF0e7Qnj+tsBEsHJNM36FMgi3SNVvtbWFhloUvN6wUNCbT4u3uCH/owxYXyZfzMwwZHkXfyowvkaATWQWjbNJv8IcEJVUkYj5zgJdDMiFvsIk0TuXbSt/PMLL+sTx7kuKhwzk6SWAO138NTu2BE0EaSlj8AUUA",
            "XQAAAQCMAwAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8NWDT+kEGPPnGI9Ho1Bc4tctaS/+wFT1tNSwFXAn5mPVcMKy1MKN6tTUuI6OjYf73OI8vCnsrvGBCDKuAFHRrZMCp0VJhzZ/wLuHuCutxvEXn0WaCANsLSHaQb+9Gq+Ey+qZHMdpRxb56gT4zcAQJFncP+W3hEJMCYzMaqZRMA7Ez8gVVEMJ9BgKifwukd1NjCutVzLZ1XS/N4aLvxeaDTSZ1EVk6nKkoe67tuFteGs2OH9/YIUCVZYIpQskTExwi8ZC2OF9FYYIhRajtVwnaL1VSijddq6nmfRFYzrNMsNX24NLk+bkADrwvciEaxLuqVP1sJ8z4NYFn+YrVgTacCByLWbZ5XFBEIjIoTP9+8FngKwmRTekfNhULtzXJ5PXKx6lr1vI6NZs1QZ8iShA==",
            "XQAAAQBcAwAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8NWDT+kEGPPnGI9Ho0gyLIhWC5a93dzJa4NaZKss60fLiEWpcfPazzuXWUzfXtx0JXv4ozusm7lr8b0ifqhn6oXZZgYQr1/AukjwmUqWFLy5w2zdg0WDsYToObfEJHLBugCgcQk/vxmfCRE+vJE4NiqwLJn4TYwpGYil/J71Mk13gMDAGN+AfZD153hwKUxkFlvRJrOlRK8kvPb+svYUJoD5omVJuIMkCvOhj7gdxa+PxzGzsmBtMgFxz2UHT60bvpmaKbbklAARcgXBcU1mDlrrfhESaVTBrvNlQyK5HWYzNfvE4jd0Xegv6qSGTYWfzFIIoFW/qj1LaPc1tCf1yMd5Gvo7w56LXgL0qkfIQQdxkhim91wxdix4+S+CSJ/rFu"
        }
    }

    EFGMITEMS["arc9_eft_scarx17"] = {
        ["fullName"] = "FN SCAR-H X-17 7.62x51 assault rifle",
        ["displayName"] = "SCAR-H X-17",
        ["displayType"] = "Assault Rifle",
        ["weight"] = 3.8,
        ["value"] = 169000,
        ["levelReq"] = 30,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["equipSlot"] = WEAPONSLOTS.PRIMARY.ID,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/weapons/scarh.png", "smooth"),

        ["sizeX"] = 5,
        ["sizeY"] = 2,

        ["lootWeight"] = 75,

        ["caliber"] = "7.62x51",
        ["ammoID"] = "efgm_ammo_762x51",
        ["defAtts"] = "XQAAAQBqAwAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8Lchzpvw0LefC8cKmSsx2FONi6w2fdtBqbRE9Vb00gVDvijCNLXoLoPgvffNK3Ts0huoSj2t/J0Qabzrcgv9pIaOT9CCdac3Y+YiE7NjVh97i2MicncONHdm6NmZli1bQsBg+UTHTU98QHIxHQLweawMprPi2gNBjCbnVttJXN95pQwlC0EmP5DBXXneqo6nXKML8S5RR1fGFOKRvar9owEqwt4A1DEstTSYzieAWWa+SXpmEeUk1ILuF0+09C2JkHAU7J9gP7ARmjV8LngiaZT1VbsnJvpbHAiNAFCd/mMbzcEazLVyfG",
        ["duelAtts"] = {
            "XQAAAQBqAwAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8Lchzpvw0LefC8cKmSsx2FONi6w2fdtBqbRE9Vb00gVDvijCNLXoLoPgvffNK3Ts0huoSj2t/J0Qabzrcgv9pIaOT9CCdac3Y+YiE7NjVh97i2MicncONHdm6NmZli1bQsBg+UTHTU98QHIxHQLweawMprPi2gNBjCbnVttJXN95pQwlC0EmP5DBXXneqo6nXKML8S5RR1fGFOKRvar9owEqwt4A1DEstTSYzieAWWa+SXpmEeUk1ILuF0+09C2JkHAU7J9gP7ARmjV8LngiaZT1VbsnJvpbHAiNAFCd/mMbzcEazLVyfG",
            "XQAAAQB0AwAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8Lchzpvw0LefLbRq5NodydVADfSzTVRjhGwpfvaoULwUVgmaDJSEVCJ7fduRjF4e3rrpOdkaZH5S+d3jN/Y3y5lkQEgJYMNPir7U7F4joYA5LLpPlS1bUgW4girWVKkjLS4FCBSZk+FcW14FnGgYi+nz8HFvJT0RQx5pduxHlwzwmhg+3bGqQHTni3qk8Z/rd2K6Q3scyAw8Z7CDzh3JxlcyujvR9RWmv5q8z34EpDkQBeESdfvAFrBIywh/B+dzlRuMlrOJxPodubcR3IU4PmUgcQwDDQmNZcGZ6AUSdO/rfOm5/3/HhzaMQYV7whCsa1S9WzC/9frPCrfzaOSA==",
            "XQAAAQDtBAAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8Lchzpvw0LefLbRq5NodydVADfSzTVRjhGwpfvaoULwUVgmaDJSEVCJ7fduRjF4NVK49G/hB5v9L6Ds4PNQYOQhZX3X2h5HjQDropv5FMh43fe4/po5n20/cA0qnCRmkIu403YDoQwYaoo8KXN1ofqrLwF+51DRFaCiJta7CuXtvLgR+gG9UrdjAuS1SZBQ0K2e27Poip8z/63XqGPuGNtCSqjahkjFP3dBcuI71MnWxAVp/scnXnPbYNlYszP5HzkPddBki3ILS6Q8d1uTA9bHwTukaMJ5PFhnwMFrQnNSzeVfnaVQBhxr5/dJgkIX1O1aKKSQK7wsrt0vjX7PQMYRdp4aCSvc0wSyQrtBOMIJWrGNhBIgf4tGITnyhu957Y7+Wa4agYYoGttKVk4IezmDLdeXIdDAZvN+QoeNPdK1vIZQ5d+NYJ9FvARZ1VXvyWR2iH13BweoOn8gP+/bsvuQeBu964F9Upc/jo2"
        }
    }

    EFGMITEMS["arc9_eft_mcx"] = {
        ["fullName"] = "SIG MCX .300 Blackout assault rifle",
        ["displayName"] = "MCX .300 BLK",
        ["displayType"] = "Assault Rifle",
        ["weight"] = 2.7,
        ["value"] = 97000,
        ["levelReq"] = 21,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["equipSlot"] = WEAPONSLOTS.PRIMARY.ID,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/weapons/mcx.png", "smooth"),

        ["sizeX"] = 4,
        ["sizeY"] = 2,

        ["caliber"] = ".300",
        ["ammoID"] = "efgm_ammo_300",
        ["defAtts"] = "XQAAAQAdAwAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8NVkzy8EViB521uhMOB77JnlX7Rf/HlUVbSUxcN9VszlqQdLv7dF0JZ1wMfEP6+N2HYFKR9bEG2TOe6lmbipfzzu7o5Ky8Exbt4OpGoxP/uHNS2BLN/DPj5OCXszFeLpZ5lRsbTRyOuG/LN/wIJIco9iS8BsAfDdjO7tQtFFh3cyiqoicfwUfGNCc34/UyRckGL6bBjmN7zY6yErBPr9CujPk5uoquMJ4O2GyXTciXj8TNXAmGq/4zJdn9FUoBfXaegO2lqB38h/qDpv96EWdziuNphNAZxi9st5R69SQZOmY=",
        ["duelAtts"] = {
            "XQAAAQAdAwAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8NVkzy8EViB521uhMOB77JnlX7Rf/HlUVbSUxcN9VszlqQdLv7dF0JZ1wMfEP6+N2HYFKR9bEG2TOe6lmbipfzzu7o5Ky8Exbt4OpGoxP/uHNS2BLN/DPj5OCXszFeLpZ5lRsbTRyOuG/LN/wIJIco9iS8BsAfDdjO7tQtFFh3cyiqoicfwUfGNCc34/UyRckGL6bBjmN7zY6yErBPr9CujPk5uoquMJ4O2GyXTciXj8TNXAmGq/4zJdn9FUoBfXaegO2lqB38h/qDpv96EWdziuNphNAZxi9st5R69SQZOmY=",
            "XQAAAQB3AwAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8NVkzy8EViB521uhMOB77JnlX7Rf/HlUT4rO8T2o2vK3zxBAtEjbb66VbwqTP7vADxQdnPi8qlwMv3i7SOSTzl0sk5Y2Jzixk0KrAcNAyO/SHsBTZLXjFfyUWYkxF/aoMnRA9RvjCXy0SB8LWT7RfFLcUSrnCHlOaMIPM8+QbanOu5DorXIdMhmknMeWwxotMzzqSaNMbzArz7OSTqDT8AUj1vUi3a37ofgFTT9E0V8Jj6YdPUgoxbLPCLMJbtaHCSSb0gH/B4jN/U5+YVMVfMuBcurUKsbvxMYRTT74UGHfT4t2MI2NK372pR2lnDhxt6Mo1G1ZIBTniqqbnehjVWSYH1UuyRIa/hlh1Z0cV1Qjs2Qw==",
            "XQAAAQDGAwAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8NVkzy8EViB521uhMOB77JnlX7Rf/HlUVbSUxcN9VszlqQdLv7dF0JZdlENFGcCy83c8GNX4De1u1ddxF/9+ENurDUM2uWDqrnW+X+rqv3/NjN629mw5xPm1kL7h/1rkuwGODchRS+SLCMO47x5KIszI4qoUSTwhRyBf5MWJFEZ4Pq6KvizElnF8GiB4gHTYOmOU0vilp/dZosC5jdLpvq/UpCMFc5l2DElz+MfPBLGQKXhot3yrtOKxyJkLGveTubrzUfwS4/EnT636d5HNDBTDWifZv6rsyWqtmqY93994MjYM/wZG6g3ZzkMZjluZ/IXHpRc0k4O5/NmNibiWwPIfbw4CF4NUUs8eiPSxaM/8XjDZtR+I65+ziAaOl/jDfOpQWkqn0rAA=="
        }
    }

    EFGMITEMS["arc9_eft_spear"] = {
        ["fullName"] = "SIG MCX-SPEAR 6.8x51 assault rifle",
        ["displayName"] = "MCX-SPEAR 6.8",
        ["displayType"] = "Assault Rifle",
        ["weight"] = 4.2,
        ["value"] = 249000,
        ["levelReq"] = 42,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["equipSlot"] = WEAPONSLOTS.PRIMARY.ID,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/weapons/spear.png", "smooth"),

        ["sizeX"] = 6,
        ["sizeY"] = 2,

        ["canPurchase"] = false,
        ["lootWeight"] = 65,

        ["caliber"] = "6.8x51",
        ["ammoID"] = "efgm_ammo_68x51",
        ["defAtts"] = "XQAAAQCcAwAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8OSoeUBP1Ca6xQ9hHtW/bYXYqRd2dsqgaXb7nIqkg11g1cQNMakbKvTttl2nuw1Xh7+2zy8kXwuBVXVfb0oZ0sQU720KkI7u9mCZUx6Oc6P6gMSwyGv5ZqluSU2GU400dWqr++epGrAhypcxQFxyCdtCigys0IadzVVrPxLGVNgrC3f0fyEqPuk/knkBpwSDppmDIJLVx4EwHtR4dEKjRbVFJueC/JOub/ZCz9phkncUk6Co8MTDvAi8yUM6QNxr6Q8GTVhg5rj6o2AJDHmHU8ISvN5NqYmNVjDuf3O8VwFip467e5yQNsV2PaCo4xEVxotgO9GDmvE/POgqBOhHw/XQZWjUSYcr4=",
        ["duelAtts"] = {
            "XQAAAQB+AwAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8OSoeUBP1Ca6xQ9hHtW/bYXYqRd2dsqgaXb7nIqkg11jsIsCmcmsnxvoS8X1iknis2mSb4WK+dacihTrpc7gB80zc9JM3Y41MwmUmX5TQbP7b3KkI354ZeF91J5ztOxPWzngG2jEJdHPoNy0QvX1LuYvmwlsMcIxe4SYNAJQkDSQo6jxbhe//pY+Xf31QDghEgpAvZXQW+vHFscyi/THlS6DyowikUcVXwI1v2GbWK3RTQKDuGrgsd8FoT8zEtBxea88qq/NAmY2WIy4YjxBFQ8RFiZCEVtOhIREW2s0OLjaUu6mnF7RLp8VEZE0XqF/8GoDVvlFp4D4vqhyUqZL9rl+AA",
            "XQAAAQAfBAAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8OSoeUBP1Ca6xQ9hHtW/bYXYqRd2dsqgaXb7nIqkg11g1cQNMakbKvTttl2nuw1Xh7+2zy8kXwuBVXVfb0oZ0sQXRknnvMomu8uKvyjEyBuRRsTUD/8EKfwlH1P+vg0a8m53CXR2oZS/4E9zT/Z1Ksgj04At85/v8v3JU1eoxovkZ1PQ5odbdDxyO7pGymZ6pFJtH3EDKxAByH+Chy5S0Lie9OI8EcLrtdOMDm6adRQ1p/NMGZsdLl0D6ZHmnWKz1OtspnbrIYMoY195VO4G0lJKWf+QF/bnIXqlIsLUj9u67uq84587HI+u8w/SEWzcpog5nXs0yZ6JR4OUezsa902/z4NA4u2sE1YWJQ4GWQ7SRiPuiqsFnkpKngx0Yb9db1Pju9vWPl67BAKK9PAc84DUSeZQ==",
            "XQAAAQAgBAAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8OSoeUBP1Ca6xQ9hHtW/bYXYqRd2dsqgaXb7nIqkg11g1cQNMakbKvVlwsdUJYXm8wVOsNH0e0nBFttljKnHOAbebSRWy5O/G8r8hjI+Sc3TCERVLmjhhLGk/ca/xSdZrZf81bj6zctD8FWLu95V7GGSOjAUuReAIO+7Z46+ZVyETnz9pbp3CeSPBGKgcWbh2BAQGbfx4hJYHiwLV2vnw0WFtcIl2yhYP+3BGMCptaD7YEG7upkfhIfrTP+M5pjVXnSbxRhlGW2ryRvWfXIglwq3nBxVuFTxxrmYYkhuDv80mxiUMmfejc6x/o9ba7PTsgebAgq/3e4zOdTY+/Odt+TwbXgWhdOACB7e2DmjyUKqo5fyy5I7z8J6vTaCqZEF1zVH90S61yz4vVAA=="
        }
    }

    EFGMITEMS["arc9_eft_auga1"] = {
        ["fullName"] = "Steyr AUG A1 5.56x45 assault rifle",
        ["displayName"] = "AUG A1",
        ["displayType"] = "Assault Rifle",
        ["weight"] = 3.8,
        ["value"] = 43000,
        ["levelReq"] = 7,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["equipSlot"] = WEAPONSLOTS.PRIMARY.ID,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/weapons/auga1.png", "smooth"),

        ["sizeX"] = 5,
        ["sizeY"] = 2,

        ["caliber"] = "5.56x45",
        ["ammoID"] = "efgm_ammo_556x45",
        ["defAtts"] = "XQAAAQBBAQAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8LcnIp+MP5IAjMvmwgz+41xGNe7eZvA/1nI9Cc3a4tADEWgmIIhGF5MEPPSKpKJWeT1US7B+nAYrV/yEFLebEoK48CLni5W3/utnI27rSaRShCcF3Hte0TQh+sAISDqtmxsDQVioObg8U4lpY3LX/tA3qAUgIVmZTbg41LAA==",
        ["duelAtts"] = {
            "XQAAAQBBAQAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8LcnIp+MP5IAjMvmwgz+41xGNe7eZvA/1nI9Cc3a4tADEWgmIIhGF5MEPPSKpKJWeT1US7B+nAYrV/yEFLebEoK48CLni5W3/utnI27rSaRShCcF3Hte0TQh+sAISDqtmxsDQVioObg8U4lpY3LX/tA3qAUgIVmZTbg41LAA==",
            "XQAAAQCtAgAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8LcnIp+MP5IAjLeVHoKL40hfYxDKj7oLj4ZNU256mz11eCzL7NAQY8C/rWXAyta9kKB3spGYOsBTP0oLSpH/YAai9zCXD+GnO2V3CgWx6jV8iuTdUEgkWK0HNyVSv9/sdxW4wuPBVXn2q0BaYQBFdugoRaknB350FAMld7FSdxlRNUYk5CPxKcCcQZmQAPMr9aq4+A1yBeJ45yX+Ft0bSl4URBGO1pNztV7jJfNIH8WxijeTR3pCl69GQA",
            "XQAAAQAUAwAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8LcnIp+MP5IAjMvn2ZZdepfBFMxUnrI2O2TNKOjZLPHyOzrAdbrBziBMRib3n4YFv20D194Iq/+SGW3xQl1Bj5iM+0Iy2OBxpOOuI/lF1VbLGKimfGosF+NqDFFSO0yJuz0Ea1tvJPra1WLD6crTiDhrmsHZ+VTA4Bs0u3zrtJxi7MvBFoX9Dsul6co0GHFyMN+r/z9puGOquVHxQk7NEFiB2Fkc8KWjCi7vCjKJ8T885eKb/8ABU7InmwHiMDuuGzwlC8pnQs0mDeD7MDbgQEYyY/Q2Ddtj1TZryF3dVIiQ=="
        }
    }

    EFGMITEMS["arc9_eft_aug"] = {
        ["fullName"] = "Steyr AUG A3 5.56x45 assault rifle",
        ["displayName"] = "AUG A3",
        ["displayType"] = "Assault Rifle",
        ["weight"] = 4,
        ["value"] = 56000,
        ["levelReq"] = 9,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["equipSlot"] = WEAPONSLOTS.PRIMARY.ID,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/weapons/aug.png", "smooth"),

        ["sizeX"] = 5,
        ["sizeY"] = 2,

        ["caliber"] = "5.56x45",
        ["ammoID"] = "efgm_ammo_556x45",
        ["defAtts"] = "XQAAAQCyAQAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8LcnIp+MP5IAjLeVHoKL40hfYxDKj7oLj4ZNU256mz11eCzL7NBE0YCNJ4X4Zy+lv/FTEoou8qGqAYsurmuNrNiiMpqqkHCQ9drsIXXRRAAnzmy81uZfG5KASdPAOoFE7ujOpke/rjelaKNyB6TTsE5W0MW77oakZuqPt2JWdj0Hy+lpseDAvazaw=",
        ["duelAtts"] = {
            "XQAAAQCyAQAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8LcnIp+MP5IAjLeVHoKL40hfYxDKj7oLj4ZNU256mz11eCzL7NBE0YCNJ4X4Zy+lv/FTEoou8qGqAYsurmuNrNiiMpqqkHCQ9drsIXXRRAAnzmy81uZfG5KASdPAOoFE7ujOpke/rjelaKNyB6TTsE5W0MW77oakZuqPt2JWdj0Hy+lpseDAvazaw=",
            "XQAAAQB4AgAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8LcnIp+MP5IAjMvn2ZZdepfBFMxUnrI2O2TNKOjZLPHyOzrAdbrBziBMRib3n4YFv20D194Iq/6dCrcEwF6Gze2Vmr2G1k/OuUMUIq7wRllmOVQ35/GtXSE2XmYBLDaSDnEVtwKck/0HSAASPHYVp+XtuPZeD57FRWydfaXwDL3DpzyTbLYUMyf9Uyyfs5Ps1f3Lo33u1O2c1VH/ShmfXSYEJBYYDphu9WnEkxOKUpFO22L6pAcjZSbhMICwEOLmAo",
            "XQAAAQBbAwAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8LcnIp+MP5IAjLeVHoKL40hfYxDKj7oLj4ZNU256mz11eCzL7NBE0YCNJ4X4Zy+lv/Grz3/It6r7jcgxuTToNL+X0T6ufZ4LEXo0J/MEt6+QE4EHAwxFK5lKXd9SYmBC7c3yXOzNIlE5tUj7V0Xx77VPnNZ7IKOtDvRJeNrS8lmXYZ7vMou6oVjYvf4Z7dgJcvaLnTNxI6OdN/01yUT9DX0QXN/YPXXw+5bzOPf659Oar6IMBcPQa151rfNOUQaepcD7eP0k9P9gXxgTTbGE9HEO0/PhwfQ3PLdz6SHoXKb2LbEeGUaScA62QlRXbwFgTbk7A="
        }
    }

    EFGMITEMS["arc9_eft_avt"] = {
        ["fullName"] = "Tokarev AVT-40 7.62x54R automatic rifle",
        ["displayName"] = "AVT-40",
        ["displayType"] = "Assault Rifle",
        ["weight"] = 4.2,
        ["value"] = 61000,
        ["levelReq"] = 15,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["equipSlot"] = WEAPONSLOTS.PRIMARY.ID,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/weapons/avt.png", "smooth"),

        ["sizeX"] = 6,
        ["sizeY"] = 2,

        ["caliber"] = "7.62x54",
        ["ammoID"] = "efgm_ammo_762x54",
        ["defAtts"] = "XQAAAQB6AQAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8OSzbA7bh+n22rgF3eZfKtFbSq5Sv+U+sy+44faPgqnhcKVRO4XjwHGPSoIh7Eyzb+O4+J8wGaj+XHNqll6K87d1ISHf4dqwegtt2oyHmnvVS5LvAV7DerEoOhNerbQm4BKVKDKlTI3EcZpy/eUCv548mEYlvgQBoJnVPfzwwniUzv7Y5AuQ==",
        ["duelAtts"] = {
            "XQAAAQB6AQAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8OSzbA7bh+n22rgF3eZfKtFbSq5Sv+U+sy+44faPgqnhcKVRO4XjwHGPSoIh7Eyzb+O4+J8wGaj+XHNqll6K87d1ISHf4dqwegtt2oyHmnvVS5LvAV7DerEoOhNerbQm4BKVKDKlTI3EcZpy/eUCv548mEYlvgQBoJnVPfzwwniUzv7Y5AuQ==",
            "XQAAAQB6AQAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8OSzbA7bh+n22rgF3eZfKtFbSq5Sv+U+sy+44faPgqnhcKVRO4XjwHGPSoIh7Eyzb+O4+J8wGaj+XHNqll6K87d1ISHf4dqwegtt2oyHmnvVS5LvAV7DerEoOhNerbQm4BKVKDKlTI3EcZpjGzrUpmsVbObipc2xgipczd6X/2KSKZ5rf9HQ=="
        }
    }

    -- light machine guns
    EFGMITEMS["arc9_eft_m249"] = {
        ["fullName"] = "M249 SAW 5.56x45 light machine gun",
        ["displayName"] = "M249 SAW",
        ["displayType"] = "Light Machine Gun",
        ["weight"] = 7.7,
        ["value"] = 249995,
        ["levelReq"] = 33,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["equipSlot"] = WEAPONSLOTS.PRIMARY.ID,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/weapons/m249.png", "smooth"),

        ["sizeX"] = 5,
        ["sizeY"] = 2,

        ["lootWeight"] = 75,

        ["caliber"] = "5.56x45",
        ["ammoID"] = "efgm_ammo_556x45",
        ["defAtts"] = "XQAAAQCHAQAAAAAAAAA9iIIiM7hMNz0dhIkbkvLjTdSR5gRNNIHH3iMsoRz+yL9kOdEqJeLavTwezUAEDoM+p9GvXx6woPy+Q/2yd3GqqyA1W+Mbk5bPXi69/vnB+d2vU2eE0sGaK94iwqGmTIYr6JU/Oa7jOtp4mW8Yy0Dub4i20Mp0/P7AQ189juExNbjXpNGxRruHsT2mSrm/QqP2cGVcOcQRKvPnGz8=",
        ["duelAtts"] = {
            "XQAAAQCHAQAAAAAAAAA9iIIiM7hMNz0dhIkbkvLjTdSR5gRNNIHH3iMsoRz+yL9kOdEqJeLavTwezUAEDoM+p9GvXx6woPy+Q/2yd3GqqyA1W+Mbk5bPXi69/vnB+d2vU2eE0sGaK94iwqGmTIYr6JU/Oa7jOtp4mW8Yy0Dub4i20Mp0/P7AQ189juExNbjXpNGxRruHsT2mSrm/QqP2cGVcOcQRKvPnGz8=",
            "XQAAAQBSAgAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8NqJ/6NP9t3Genn6+fgikxTgZybBkpyPZq+b+1vNAUKpBZVqdLdicBGq9LhISqqlqMrqKtfx2pth0xJ3ebdaw+wKCeDtrpvk80MXwfjN3cq+aWenLGokAbeOwpcLsOoeQmGZgeKLk4Bva0n3TJGAhGWJ5uVOA4FtwkxtxEDEOr6IiRUTrfip01AT8sMFphZb8SqY2Yw7Sk2LTV5XQ9wFp7fAGSUbWglaE2YKjgFs6Hsinp3vpvH6jyji5D7OwDOf2KRE74SplF+VyEK9cjqM3EAA==",
            "XQAAAQDnAgAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8NV4/QsCrXIwPOwVEPPKTlzsLIHq7HCwwpC/bHU4GvUwjHZqDrngm0zUxZIMrr8SgTtfIybiPrHTMrbPDYMeOc/94NwzcY1g7bo1JcyBH8nW5Xys1B4m4WIAbIW5LHpeKLCYtp1gGGFpjOHF8Q0F5dPbvmJ38tFynpvwcjscmtOVm7IZtb6zTfNGkUmfaYEQtu336H2HhHbvgAM7cPP45GyZ3snJa6ozLxEgT6ByvGNv4T8I1Wdjt2jYT6Qz5auc4amNjfvqvuusmzOrSf57oQc35aFPIa3yQG6ye8EbOP3BbERVsRsgKuNmz1z1fEGiiFYunBxROFnYY0Z/I+5w=="
        }
    }

    EFGMITEMS["arc9_eft_m60e4"] = {
        ["fullName"] = "U.S. Ordnance M60E4 7.62x51 light machine gun",
        ["displayName"] = "M60E4",
        ["displayType"] = "Light Machine Gun",
        ["weight"] = 10,
        ["value"] = 100000,
        ["levelReq"] = 16,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["equipSlot"] = WEAPONSLOTS.PRIMARY.ID,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/weapons/m60e4.png", "smooth"),

        ["sizeX"] = 5,
        ["sizeY"] = 2,

        ["caliber"] = "7.62x51",
        ["ammoID"] = "efgm_ammo_762x51",
        ["defAtts"] = "XQAAAQBUAgAAAAAAAAA9iIIiM7hMNz0dhIkbkvLjTdSR5gRNNIHH3iMso2fmTz8F3jy5pVr3uGXDL8fbOjv/zKw7ozNLG1nGdWzDvHAdCwDTMX9X/3j/xK3T+dxjdbxHrI7i1GBfkAxdqaA9Zd0SaHMWQquI5eJnyFO2VS61xiJY+jhXgz6DR5o+mvju9nG1wnFbkH8yrSDOyq5tjKTAFu68riDxMtL9lkaeDSxoXFnDEow5fM0GFiKB5MNNFKSUWHyZLnKNo42BxU4B5P4Sn2hL1Ya+IA==",
        ["duelAtts"] = {
            "XQAAAQBUAgAAAAAAAAA9iIIiM7hMNz0dhIkbkvLjTdSR5gRNNIHH3iMso2fmTz8F3jy5pVr3uGXDL8fbOjv/zKw7ozNLG1nGdWzDvHAdCwDTMX9X/3j/xK3T+dxjdbxHrI7i1GBfkAxdqaA9Zd0SaHMWQquI5eJnyFO2VS61xiJY+jhXgz6DR5o+mvju9nG1wnFbkH8yrSDOyq5tjKTAFu68riDxMtL9lkaeDSxoXFnDEow5fM0GFiKB5MNNFKSUWHyZLnKNo42BxU4B5P4Sn2hL1Ya+IA==",
            "XQAAAQDJAgAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8NV4/QsCrTW4GExWCYJo+2ZeYWl/b687FsWG+EFasdGduxOIPTJ2DCzC2+pevYxJIvJxBv2Y9B70y3GHo5VFFNAp6YWZdpcRbp4gxtvTarTVmgYfnS63bkSgTSRI0u4N1ZQrF1G/+pDlKjNVfS2Vuu3DDyIgvgLaNvzz277dR++JdCA/0BCB2ucdCzfIT0EAXrFajOeM2AMbNdW80FVgAwElmgOVJiBbdTdZL1OL226izb+7wFKQfOZShtvvuMjN7Yo7loTeVrKxAsKtdGY4Nluu5gXwdj03ZV4A==",
            "XQAAAQAeAwAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8NV4/QsCrWflBWtCjWpgKVmoT7KQcXMLkFyVv8yk6usXML+x5gRINSp/eoYcIPeSTzZCB8T1RlTr0Blmg/7DqIBNV4vnJ9gHyxeBJUFrwlOU9wJHUSdzUSfBuw1z7rysVN1wKAcLFew2Xs8HpPxySqJEmz81y/fg37PP2GB0Hu2/Zb6WkBUQuafcyroRsApcuST08NghDST0FS5HiZVgT1O1aDMxswT8o7oXwr9L/aj7c1j8zZbadNqFMbp5hNwWl/jt9K/tZCSA8AZSzJ4AIK9mKB07PgCZNXT1IPkGSEQp6htwKcBaKzSZqWdbyy9t/FpZs="
        }
    }

    EFGMITEMS["arc9_eft_m60e6"] = {
        ["fullName"] = "U.S. Ordnance M60E6 7.62x51 light machine gun",
        ["displayName"] = "M60E6",
        ["displayType"] = "Light Machine Gun",
        ["weight"] = 9.4,
        ["value"] = 110000,
        ["levelReq"] = 18,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["equipSlot"] = WEAPONSLOTS.PRIMARY.ID,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/weapons/m60e6.png", "smooth"),

        ["sizeX"] = 5,
        ["sizeY"] = 2,

        ["caliber"] = "7.62x51",
        ["ammoID"] = "efgm_ammo_762x51",
        ["defAtts"] = "XQAAAQCpAgAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8OSSsLLcJyAHCCocixFdnSv7HKuyXN99OF0r8E7y72hI9xM4LhZpazFPnoHK2XoCtAqnqs4JGM0rw+mGc6h3DXdBmlNItS6v+yeYD6W3SxhPJ4sDDaQfNGtQ2nRsCXnF8WyPAWAXHcPoSl5uPWm3mVw5CBlrC1Ba9TO3tsNFe5I5AQWUphNDBYBOdTtXYHRk666tjWYWY6S1byamgiDKCwwprLOuLajl+uAB1pdLrTKoYCCag9B8ZIXGmoVJY+9VCN+TQ7oQ==",
        ["duelAtts"] = {
            "XQAAAQCpAgAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8OSSsLLcJyAHCCocixFdnSv7HKuyXN99OF0r8E7y72hI9xM4LhZpazFPnoHK2XoCtAqnqs4JGM0rw+mGc6h3DXdBmlNItS6v+yeYD6W3SxhPJ4sDDaQfNGtQ2nRsCXnF8WyPAWAXHcPoSl5uPWm3mVw5CBlrC1Ba9TO3tsNFe5I5AQWUphNDBYBOdTtXYHRk666tjWYWY6S1byamgiDKCwwprLOuLajl+uAB1pdLrTKoYCCag9B8ZIXGmoVJY+9VCN+TQ7oQ==",
            "XQAAAQAcAwAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8NqJ/6NP9t3Genn7BaWameyEZG4bWevVJGnF+iMvSPsgY4mWA1g6P5DP7MeftLPw6OG+8ykn9fqGH2gJk76jWKXUWwX/GcrJ9ZXH7KyGaKzDdU2PbwFjt7a5TeS7bSfYGASOm+IUy6XNHRcLuKcyO6BMNAv9S6LWbQqHVb8IHn+1q8r3jQDYzS2GkacRiOL8PQs+WcwuKgzwtLr8ooBkWPrNEsOiwiNfnQjJWbaIp/HUl1+NAFAeFvIP57NYmWvx8qxdh+Ukv0jTSXyZXxX/cebtS+fN53KaADup1q9uh3DoOoz0i8fLEA",
            "XQAAAQAnAwAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8NV4/QsCrClhAsuCdDw6WysGmFwB87+4+kfaxr+7jxE1g6zA9I+ExV+NtVkgIhAm3k8SBRxRMclY8j0g17im0MJHl00hI6zKMW53pHvoYbw8Fj1bLuv2f8DIDMZ7VpPl+/taA1js/yUAnfCwIdQTzbqvXvcaUsl4UeRQRkHeZkYAzpk0PJ6U378ARptIlHXrKBiI+oapIkiPiQJCJsLpfATDpeYpzNvXVYz1Tgwb9XdpnJToacEeZlIjoRVIVxWphkj1h/9L6hSgSWbqIoE7O7fwIc39M8brWJjYMvqyySN9i0IGfiCmlLHRJUSlmn4fphOuYbctkRMlXhQA=="
        }
    }

    EFGMITEMS["arc9_eft_pkm"] = {
        ["fullName"] = "Kalashnikov PKM 7.62x54R machine gun",
        ["displayName"] = "PKM",
        ["displayType"] = "Light Machine Gun",
        ["weight"] = 8.9,
        ["value"] = 205000,
        ["levelReq"] = 29,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["equipSlot"] = WEAPONSLOTS.PRIMARY.ID,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/weapons/pkm.png", "smooth"),

        ["sizeX"] = 6,
        ["sizeY"] = 3,

        ["lootWeight"] = 75,

        ["caliber"] = "7.62x54",
        ["ammoID"] = "efgm_ammo_762x54",
        ["defAtts"] = "XQAAAQB1AQAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8LmM+VxqdivxON2A4c/UqwSJhqDo+4MgoaYe3T9Uq9jxbrXbeouPZLy1sIP/T9DyOZBwzjl8btLjhrC3FgFrmdqNCYWkz30yzsETGz/5o6wAs0ZzQw8mceqa3lJoSXZGbka9NLvH0SOwaeLSmbAtj5lQrj3w6en7CSh2yTolf1HY02GOWY",
        ["duelAtts"] = {
            "XQAAAQB1AQAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8LmM+VxqdivxON2A4c/UqwSJhqDo+4MgoaYe3T9Uq9jxbrXbeouPZLy1sIP/T9DyOZBwzjl8btLjhrC3FgFrmdqNCYWkz30yzsETGz/5o6wAs0ZzQw8mceqa3lJoSXZGbka9NLvH0SOwaeLSmbAtj5lQrj3w6en7CSh2yTolf1HY02GOWY",
            "XQAAAQAfAgAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8LmM+VxqdivxON6Som3vL2ybUBNPLkDFs7ArpEbRhf//vDzHLbNjwl/yaXH2T1ONzPLqsmTZxaol+68OhMlg8o1gLJTfMVPUphYGUiMWL+gJi2jd3kVt44O8fptge5liv6IZ5axM61U1YyeuUJw/oUm223J9qhq7IfA04mWviUbvdE7FVwBihXRNHYvYhw0K7tLWKdVXT0Z0yQx6Rz3niTpXoudBxyS4FRiVgs8a5woqPCw6DYqU4KxhA=",
            "XQAAAQCOAgAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8LmM+VxqdivxON2A4c/UqwSJhqDo+4MgoaYe3T9Uq9jxbrXbep9+NJScGfaAokZQ7ZurBC+wkjhxNAC174ae8ELsrDUQvUBQtbbsqEbaawbzGB49Zz6tbR9NuSO8goiWyeFfNQm/czjaEBPm2s5JgmF70k2rklctqAScTaBC8PPPOFRLLBjeIy7xAiQLcOhkRSrNnKLHv5OIcBARToju8dGwxslSA3kYZsFEUfrIgATt9CDudQfm7Y39q+XxmepIGc"
        }
    }

    EFGMITEMS["arc9_eft_pkp"] = {
        ["fullName"] = "Kalashnikov PKP 7.62x54R infantry machine gun",
        ["displayName"] = 'PKP "Pecheneg"',
        ["displayType"] = "Light Machine Gun",
        ["weight"] = 9.6,
        ["value"] = 230100,
        ["levelReq"] = 31,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["equipSlot"] = WEAPONSLOTS.PRIMARY.ID,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/weapons/pkp.png", "smooth"),

        ["sizeX"] = 6,
        ["sizeY"] = 3,

        ["lootWeight"] = 75,

        ["caliber"] = "7.62x54",
        ["ammoID"] = "efgm_ammo_762x54",
        ["defAtts"] = "XQAAAQBAAQAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8LmM+VxqdivxON6Som3vL2ybUBNPLkDFs7ArpEbRhf//vDzHLbNjwl/yi0+ghuUFk0qpomQmY51j7k5NmwRm4tC6nxVy7gbHQo7OSzUJB2xaJHe+Xp4GXZ/5OAUrxrBimVt5hyP/sKIQjw7g8P+evKxFjVgPcA",
        ["duelAtts"] = {
            "XQAAAQBAAQAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8LmM+VxqdivxON6Som3vL2ybUBNPLkDFs7ArpEbRhf//vDzHLbNjwl/yi0+ghuUFk0qpomQmY51j7k5NmwRm4tC6nxVy7gbHQo7OSzUJB2xaJHe+Xp4GXZ/5OAUrxrBimVt5hyP/sKIQjw7g8P+evKxFjVgPcA",
            "XQAAAQAQAgAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8LmM+VxqdivxON6Som3vL2ybUBNPLkDFs7ArpEbRhf//vDzHLbNjwl/yi0+ghuUFk0qpoWVYYUnP9Pw/PCCSNOSIRwMlK91pNF57k80GbM+rNp+tZFPIT1+AR8ZMdM2gzeUw+fMg5EZv4OD5rahT9bqN6KMJJ4sGR1gIIyNIO83ZviPEBPv1txrJNp8tSWCMZnsTEmdHAZ5sQq7jrp+r7REVrMuh/pJ2J4eNj0Mz7PmA==",
            "XQAAAQABAgAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8LmM+VxqdivxON6Som3vL2ybUBNPLkDFs7ArpEbRhf//vDzHLbNjwl/yaXH2T1ONzPLqsmTZxeMKVSU7wjWXoEYxUBQZXwGRrV8RwBc/MzyQl0OEhZJK/TTn7PIesjA9RS+8BdaFO1GdJuLkpIgnRgfhTEGnVmS2GEmRoYqtQhDeP4nkqXKyd/kjYD5m3dfl1F8Q/GG59WTIjFraV1f1X0HwdQ0XXc6lBNUs02pKyDqDXbScN89Clrl2o7t6O68YVO"
        }
    }

    EFGMITEMS["arc9_eft_rpd"] = {
        ["fullName"] = "Degtyarev RPD 7.62x39 machine gun",
        ["displayName"] = "RPD",
        ["displayType"] = "Light Machine Gun",
        ["weight"] = 7.4,
        ["value"] = 99000,
        ["levelReq"] = 24,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["equipSlot"] = WEAPONSLOTS.PRIMARY.ID,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/weapons/rpd.png", "smooth"),

        ["sizeX"] = 6,
        ["sizeY"] = 3,

        ["caliber"] = "7.62x39",
        ["ammoID"] = "efgm_ammo_762x39",
        ["defAtts"] = "XQAAAQCiAQAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8OIg2Alsq6N5HJfzqGetoWgtBPuIFPieR7POjErtXp2hCvFJRW9NnJMkzk6x1OSJgTacqq2lLYClfHwBgbnP83d0UWq0A99jh/OIqT0b5jejBLSseE7AwTBYDbNdIr7/tWgsUDbjHMrFthXNQo+SDQl70q0QOkxRbNeUWcXrMiC8JogPK3ONwvewZBJL+tH5Y=",
        ["duelAtts"] = {
            "XQAAAQCiAQAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8OIg2Alsq6N5HJfzqGetoWgtBPuIFPieR7POjErtXp2hCvFJRW9NnJMkzk6x1OSJgTacqq2lLYClfHwBgbnP83d0UWq0A99jh/OIqT0b5jejBLSseE7AwTBYDbNdIr7/tWgsUDbjHMrFthXNQo+SDQl70q0QOkxRbNeUWcXrMiC8JogPK3ONwvewZBJL+tH5Y=",
            "XQAAAQC9AQAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8OIg2Alsq6N5HJfzp+h2D6DMdnGedNREttuRTojpCRut7mF6zJgyj4Kx98PB3x9sFl5GNcp9nb686mXMxXN2j81Tfe5q7oNBSyIhQYsE/DABxE0yXe23ONV/c0J2TgxzgyDPixb6XqrLC0d8Wm+F4ZVBaoZkVIVO1nPqAW1HEsJZStQzixfPd8WqWA",
            "XQAAAQAoAgAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8OIg2Alsq6N5HJfzqGetoWgtBPuIFPieR7POjErtXp2hCvFJRW9NnJMkzk6x1OSJgTacqq2lLYClfHwBgbnP83d0UWq0A99jh/OIqT0b5jejBLSsdd2KN7VrC5HmZuVh8vYBo60h131HONieAu+W5ei5JjGCTXrj7f7Y1tXO6rrYmvoNzhyOCl6AoGbFyoJ4LWfJDNcpweVhBcUIL1Bqu/MHWtf4RuuxItqHMaqG9t6Gs90yjJYA=="
        }
    }

    EFGMITEMS["arc9_eft_rpk16"] = {
        ["fullName"] = "RPK-16 5.45x39 light machine gun",
        ["displayName"] = "RPK-16",
        ["displayType"] = "Light Machine Gun",
        ["weight"] = 3.6,
        ["value"] = 68000,
        ["levelReq"] = 12,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["equipSlot"] = WEAPONSLOTS.PRIMARY.ID,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/weapons/rpk16.png", "smooth"),

        ["sizeX"] = 5,
        ["sizeY"] = 2,

        ["caliber"] = "5.45x39",
        ["ammoID"] = "efgm_ammo_545x39",
        ["defAtts"] = "XQAAAQAkAwAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8OIg4EaB9tZlmxUqnNjWMtFUXsgURvra4DARqTRAAJ1RKCUZtu9ifdkwwgWqxrTiSkIN3cRyq1JU2zssDBPUgNM9gWFKMq3C5EZmUZjMNKqDyYhvdAEOAmXPBRkJNvoLbqNcdgeXAss6ysNQczRunkqp/viMiUYfhEyl0PGwrQHoJJwGi8gR7dtgM5nmcARnITnfgcNZjG1lESXIsA+hpMDBBnh3dOtiNGTNv98XUJ+RNmOr0g9JWKmxylNF5ZWJi7cuBE02UofijActj7CMzBFK7/rw==",
        ["duelAtts"] = {
            "XQAAAQAkAwAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8OIg4EaB9tZlmxUqnNjWMtFUXsgURvra4DARqTRAAJ1RKCUZtu9ifdkwwgWqxrTiSkIN3cRyq1JU2zssDBPUgNM9gWFKMq3C5EZmUZjMNKqDyYhvdAEOAmXPBRkJNvoLbqNcdgeXAss6ysNQczRunkqp/viMiUYfhEyl0PGwrQHoJJwGi8gR7dtgM5nmcARnITnfgcNZjG1lESXIsA+hpMDBBnh3dOtiNGTNv98XUJ+RNmOr0g9JWKmxylNF5ZWJi7cuBE02UofijActj7CMzBFK7/rw==",
            "XQAAAQDaAwAAAAAAAAA9iIIiM7tupQCpjrtF9qJbeNZaSCEX4Y6O26Hmp1HRpqw8uiVK1lhIr78Bn6lUdOaM6mHrSRyQIhifRSyvbMYkie6kwGRc+5/xDIfBA9K+9N1SF74QnxtzVqEEN+1wd2gHuA6/v/u28+d5yK0XZvmkomsJKTOjsGjffYN1BjbQO5oEoqhA03qPivlYjpxs1pbMG/dIDbhJSS/TimO1xGfJYugt9O7TR+PiwFcB/HvgWxXj0HXN1zVg5R9xzj2i6NqXjRHJDFHa63kBh/LxOnoMjUkLKvN6CbUKmTECY6UntNGFcABcLRn2duGxlY9rFVc4I73LmX905h9pjL54aZtv72zSmGb4Y1UpTjuhIK5cU9siSQ0Wet1ap+HpbkODOLfL3oxZKbNzaW/8oEwHAA==",
            "XQAAAQDsAwAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8NWDT+kEGPPnFlfSScSitKC3h96j2MfwFs9lVZzbkxhsM84Ocm2m1u9+uwYvb/EqFRbmUly+hD06CBFuejx+bq5QdxMxUW8F/cSVxU4v8jOPmOtLzIMMxmrTHkZjLINd06BYZVO9Sg6QCRX1uH/crGy2jl03ixMMhQE4WD2v6sZRw0s3FFvngQ+nmMNQV21M9H/NuI4YwgMAASPKKSE+XFGBHOr+DKzI0xH9XGoPsqT+fhsSYzsdO4K9fw3gHcifntUdwFcziidFaf6fACY68Nd2oUWDAf9xek4/+xc2wo0TQKqsKY7gwB0sqaKk1uXHzW89M524BbloKNAYS/exSfNt8MFARmPfTHcigzxW5jDrj0/BFdBKu9CzXlfJ3H94MQFmPfj7pzqg=="
        }
    }

    -- pistols
    EFGMITEMS["arc9_eft_m9a3"] = {
        ["fullName"] = "Beretta M9A3 9x19 pistol",
        ["displayName"] = "M9A3",
        ["displayType"] = "Pistol",
        ["weight"] = 0.8,
        ["value"] = 23000,
        ["levelReq"] = 1,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["equipSlot"] = WEAPONSLOTS.HOLSTER.ID,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/weapons/m9a3.png", "smooth"),

        ["sizeX"] = 2,
        ["sizeY"] = 1,

        ["caliber"] = "9x19",
        ["ammoID"] = "efgm_ammo_9x19",
        ["defAtts"] = "XQAAAQCDAQAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8LmM+VxqdivwEJTPh3E+VFN6tQFSEw8nl+xsNZHkUqRC+DuxEPE4Hmq2ZF39I5/fW7oBi14Z7pNIIvvvTcmGH8EPSRl1Mgu31LkWQpOtv6A9h6lrhDeArrse4Q9wLpJvvlZzE2wk3jB1y52JTzihtkZKJlfFjhCjnhAA==",
        ["duelAtts"] = {
            "XQAAAQCDAQAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8LmM+VxqdivwEJTPh3E+VFN6tQFSEw8nl+xsNZHkUqRC+DuxEPE4Hmq2ZF39I5/fW7oBi14Z7pNIIvvvTcmGH8EPSRl1Mgu31LkWQpOtv6A9h6lrhDeArrse4Q9wLpJvvlZzE2wk3jB1y52JTzihtkZKJlfFjhCjnhAA==",
            "XQAAAQCYAQAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8LmM+VxqdivwEJTPh3E+VFN6tQFSEw8nl+xsNZHkUqRC993zXCzGjm0oiG3Rjnl1QVB49eYpgNoUdThJyUUxEQic/0JVWubBikJ1fuLdhZukqLMCl8PY8H8sGkZW0fBlMuPtmDkJWkvfAlN2nMSXXkGr4qT40apwirXwAjeEmCFABfhALQo6A=",
            "XQAAAQAqAgAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8LmM+VxqdivwEJTPh3E+VFN6tQFSEw8nl+xsNZHkUqRC+DuxEPE4Hmq0GXD717X3lMkG6u0+fLX0B0eMHv/iIveLj0x7jtlNjDew6nM77x13+qBH6lj4atjNx3EJ/Yx3+2H/VaQPRGNdWR7Xg737+WMU+ZhTTyFpVWKamULXy81I0e8CCmgKoaZCDfr3M1xs6g0CEo8g2QOVz4xcFxG8sFafiHXbiri9cF"
        }
    }

    EFGMITEMS["arc9_eft_pd20"] = {
        ["fullName"] = "20x1mm toy gun",
        ["displayName"] = "Blicky",
        ["displayType"] = "Pistol",
        ["weight"] = 0.1,
        ["value"] = 10000,
        ["levelReq"] = 5,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["equipSlot"] = WEAPONSLOTS.HOLSTER.ID,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/weapons/blicky.png", "smooth"),

        ["sizeX"] = 2,
        ["sizeY"] = 1,

        ["caliber"] = "20x1",
        ["ammoID"] = "efgm_ammo_20x1",
        ["defAtts"] = "XQAAAQAXAAAAAAAAAAA9iIIiM7hMNz0dkAd2RJ793J7f29M/CuuhAA=="
    }

    EFGMITEMS["arc9_eft_m1911"] = {
        ["fullName"] = "Colt M1911A1 .45 ACP pistol",
        ["displayName"] = "M1911A1",
        ["displayType"] = "Pistol",
        ["weight"] = 1.2,
        ["value"] = 19000,
        ["levelReq"] = 1,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["equipSlot"] = WEAPONSLOTS.HOLSTER.ID,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/weapons/m1911.png", "smooth"),

        ["sizeX"] = 2,
        ["sizeY"] = 1,

        ["caliber"] = ".45",
        ["ammoID"] = "efgm_ammo_45",
        ["defAtts"] = "XQAAAQAJAgAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8LmM+Vxqdiva/+T8TWXFyZ6L+YGhlUEFGCfP6ZxRzhhtO4thQe+Y8iks9vtbjX/1mlPDmp6O4OLhhuzMvFkTlrQfPfK3ivuCRfw5mF2t9J9NMfTJXBYIwDkT8TIZrYGTDnj2E5r2njE2qO1+VknMQZ+JwujYf7xqN5yt85euuFXh09YHiN3D6NJTg6xDdwtlRy",
        ["duelAtts"] = {
            "XQAAAQAJAgAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8LmM+Vxqdiva/+T8TWXFyZ6L+YGhlUEFGCfP6ZxRzhhtO4thQe+Y8iks9vtbjX/1mlPDmp6O4OLhhuzMvFkTlrQfPfK3ivuCRfw5mF2t9J9NMfTJXBYIwDkT8TIZrYGTDnj2E5r2njE2qO1+VknMQZ+JwujYf7xqN5yt85euuFXh09YHiN3D6NJTg6xDdwtlRy",
            "XQAAAQCaAgAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8LmM+Vxqdiva/+T8TVGz12MZlTBvfFuwVHr2M0vIvxQabJdixi//02kBQ2+EBuBeF++RbzJP5/Kimjlpj0WHt6wHSEeQ9GGXxPj8sC7o66KlTUrATqvoU4JLPrS5S/ImiYYdu4xSSDiKMBhaRPM4J+RGpvLud8ETQ3ereN3ogsIRazM8IcdCNVYSUPueU0XP3uoRPgnnVf4REq8QrSyXt3hz+N3kAkbtzQ4IoXuVLM/YQJGbU5+FrB/wtIYYrxv6Qz5cPbCLEK",
            "XQAAAQDfAgAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8LmM+Vxqdiva/+T8TWXFyZ6L+YGhlUEFGCfP6ZxRzhhtO4thQe+Y8iks9vtbjX/1mlPDmp6O4OLhhu0KMy3FIbaFBqaOPS25yqXkakfI/2IExWGkFSKeL5hsh40xpyagDGAbIwKNBjEUu+/LCSxN5MVPZirkaEJwtayNoFZWCB+GAwjv2Ep7UHix94RJqsHXIWl1j74UiunOF/zkmBMGFPM6jy9RjrdOI/QcQV0KSYHGS4oEhw3mbgck3JjIG7eYKmA8rx3f9l/nqJcJkgfGLpTHrCg8Gc",
            "XQAAAQAwAwAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8LmM+Vxqdiva/+T8TWmHF0Cly6AHG2UUIhFPYlMHI0DjQP6V0b+4xigeU3VTb/5bQ+FeGA0phdsXP1JIh9xiGYLvByb0+MbjryPAyFwNuzmATxsCDa1bVz5sSRKiqUpu0uNtWQNxei2Dv2D2A6gAwo8+q0jrkOXXspPBeFdU9O1dP6o8hjjImHKFfUDvd25UeVi8JaYTeu0rxYRJCoBhDZpzVcE6xUlTkY4DFgcgrKVGXJs2yW9XWlnwDF46TF2j5w4ajW6Kz0h5hsR7mcYJMCzKZF3Iwap4TQ3k+yqoGKeoBCOg=="
        }
    }

    EFGMITEMS["arc9_eft_m45"] = {
        ["fullName"] = "Colt M45A1 .45 ACP pistol",
        ["displayName"] = "M45A1",
        ["displayType"] = "Pistol",
        ["weight"] = 1.1,
        ["value"] = 22000,
        ["levelReq"] = 4,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["equipSlot"] = WEAPONSLOTS.HOLSTER.ID,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/weapons/m45.png", "smooth"),

        ["sizeX"] = 2,
        ["sizeY"] = 1,

        ["caliber"] = ".45",
        ["ammoID"] = "efgm_ammo_45",
        ["defAtts"] = "XQAAAQAJAgAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8LmM+Vxqdiva/+T8TVGz12MZlTBvfFuwVHr2M0vIvxQabJdixi//02kBQvQE1BNSe+/x4UWJGqsdu0r0fjAJV8uPf4/9yf+Oa6i2nzhe+E/pAfpR4BznYJwkvGIHjKA6KtHKxQIslWZOjXQ7OqGi4qZT5NtitnZJtizjAPZf/nSJs9PdJfcS2+CyOZXDohKl62quGEQuCnXlubjg==",
        ["duelAtts"] = {
            "XQAAAQAJAgAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8LmM+Vxqdiva/+T8TVGz12MZlTBvfFuwVHr2M0vIvxQabJdixi//02kBQvQE1BNSe+/x4UWJGqsdu0r0fjAJV8uPf4/9yf+Oa6i2nzhe+E/pAfpR4BznYJwkvGIHjKA6KtHKxQIslWZOjXQ7OqGi4qZT5NtitnZJtizjAPZf/nSJs9PdJfcS2+CyOZXDohKl62quGEQuCnXlubjg==",
            "XQAAAQB9AgAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8LmM+Vxqdiva/+T8TWmHF0Cly6AHG2UUIhFPYlMHI0DjQP6V0b+4xigeU3VTb/5bQ+FeGA0phdsXP1JIh9xiGYLvByb0+MbjryPAyFwNuzmATxsCDTMa5iWdtkLDZ70/T9MtqpMyyjSeDSbZbtFXWEDtBrOy2LN++zQBOB81nS2QBOdLXMl/jR92zKW8NxCvuZhKMR+gOQjzTH28YpXTKagChKwi9e4+97Uiyq6WY3xSkHs+lsjUP9Fyqt+w==",
            "XQAAAQB5AgAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8LmM+Vxqdiva/+T8TWXFyZ6L+YGhlUEFGCfP6ZxRzhhtO4thQe+Y8ihiiI0o/oPhY6VNYa4LvGUw/26WM1z2ZVqHk3i276s9oVv3+dIGmL1a8TJ2ppizDIzhfvfVlY6Li9ZM2sVSKpP+B4h87HX61h/tQTIaudSiJPFdiE2+j8UTCjEtpM/+uw0XBg8PUNzAy2KCCe5n9nXyeTS7541zqBv9IRsM/uCoGVJf42VFapvkDDA6OdjILGWYst9E7yUqo="
        }
    }

    EFGMITEMS["arc9_eft_deagle_l5"] = {
        ["fullName"] = "Magnum Research Desert Eagle L5 .357 pistol",
        ["displayName"] = "Desert Eagle L5",
        ["displayType"] = "Pistol",
        ["weight"] = 1.5,
        ["value"] = 32000,
        ["levelReq"] = 6,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["equipSlot"] = WEAPONSLOTS.HOLSTER.ID,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/weapons/deagle_l5.png", "smooth"),

        ["sizeX"] = 2,
        ["sizeY"] = 1,

        ["caliber"] = ".357",
        ["ammoID"] = "efgm_ammo_357",
        ["defAtts"] = "XQAAAQCOAQAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8LmM+Vxqdivswh+weqM2t5ghOvIx8KkqejxKzgldfViMxjx46Znco6smBqgrvGL0O8YJT4T7wgJccpjUYf5269cqJMCf+ilpumoHK8Ntg1+FepHm5oovFm5h8yqEygpQHVjnZ4Nrbct08Y75391QU/Vr6NU6avpWOzXnBRQcQDAA==",
        ["duelAtts"] = {
            "XQAAAQCOAQAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8LmM+Vxqdivswh+weqM2t5ghOvIx8KkqejxKzgldfViMxjx46Znco6smBqgrvGL0O8YJT4T7wgJccpjUYf5269cqJMCf+ilpumoHK8Ntg1+FepHm5oovFm5h8yqEygpQHVjnZ4Nrbct08Y75391QU/Vr6NU6avpWOzXnBRQcQDAA==",
            "XQAAAQB7AQAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8LmM+Vxqdivswh+weqM2t5ghOvIx8KkqejxKzgldfViMxjx46aRmVA4KVPT9l2HpLFQcAIH7+AHwimVGovQL6bd8bM1S2CeOuaqtK0YUbOg0uuWp6STRWrPn1Yl1JsAy4a66sJmFiC1bhfTImbznkDEzNBfgEXxv+NmbpTVAOB1wd7+VnQASk=",
            "XQAAAQD0AQAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8LmM+Vxqdivswh+weqM2t5ghOvIx8KkqejxKzgldfViMxjx46Znco6smBqgrvGL0O8YJT4T7wgOcGSpViv86vXwK3D9auBH888UCZ55yO4LbnVPZXribdSIYYlgA8wJnlDwrk8047JbR8m6eno7Jw8OrO1hGd6KADkhrXy0fOegpGVgJHiNFuINtXGS0TtunewQe4OOTfvaPM=",
            "XQAAAQCjAQAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8LmM+Vxqdivswh+weqM2t5ghOvIx8KkqejxKzgldfViMxjx46Znco6smBqgrvGL0O8YJT4T7wgOcGS2zPCBUcpMrLgbUmgcCrYfAdBNsmv4WwBI7btdnClyoSge1SUEp//APT1FesnlvutwmVXQP2UXHEYB+XfXdYPecaMi4SvyIWCNOCQ2y3BgZJ0iTI="
        }
    }

    EFGMITEMS["arc9_eft_deagle_l6"] = {
        ["fullName"] = "Magnum Research Desert Eagle L6 .50 AE pistol",
        ["displayName"] = "Desert Eagle L6",
        ["displayType"] = "Pistol",
        ["weight"] = 1.7,
        ["value"] = 38000,
        ["levelReq"] = 8,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["equipSlot"] = WEAPONSLOTS.HOLSTER.ID,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/weapons/deagle_l6.png", "smooth"),

        ["sizeX"] = 2,
        ["sizeY"] = 1,

        ["caliber"] = ".50 AE",
        ["ammoID"] = "efgm_ammo_50ae",
        ["defAtts"] = "XQAAAQB1AQAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8LmM+Vxqdivswh+weqM2t5jQa6lgmam1bVV9wqHc/InvQl2sKu4I6dhqSCkrPRwoNttNR6fAeglycM1HiUxpoKzGlKvMjh+VEul0WOs3iIX3F3hb8XZ41U/VsWr8dMwwBnCgT27aU36knR7GmGNHv/+DtzE7QVQtyLiTVcbSs2OW3jLLzqAA==",
        ["duelAtts"] = {
            "XQAAAQB1AQAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8LmM+Vxqdivswh+weqM2t5jQa6lgmam1bVV9wqHc/InvQl2sKu4I6dhqSCkrPRwoNttNR6fAeglycM1HiUxpoKzGlKvMjh+VEul0WOs3iIX3F3hb8XZ41U/VsWr8dMwwBnCgT27aU36knR7GmGNHv/+DtzE7QVQtyLiTVcbSs2OW3jLLzqAA==",
            "XQAAAQCNAQAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8LmM+Vxqdivswh+weqM2t5jQa6lgmam1bVV9wqHc/InvQl2sKu4PMzSBInf/tPCmla/f5I0Az0GDK6UDgZAfcRWjUvikob8eZo123xxmWslzTN2EsV7ucaUasOKqw+HthhFvvilDBJC9G/keJ6H8LMR6mrziQ4fBKUAB/XRhlrObU9Qyf7wrqbflXPvhS1yk30F144N+HxQQ==",
            "XQAAAQCMAQAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8LmM+Vxqdivswh+weqM2t5jQa6lgmam1bVV9wqHc/InvQl2sKu4I6dhqSCkrPRwoNttNR6fAeglzTdhEEqL0dgmUgN3wi+kkQ+K6jMsNXyn+NCKPnYI+DPysDYLDB2pej8Y/EoFnYt+xOYtl3LVDd4xfpVEqmbaJ80Ept+6ilCH8O5f7ZRoqJJa6PsMcPDHQjLAQ=="
        }
    }

    EFGMITEMS["arc9_eft_deagle_xix"] = {
        ["fullName"] = "Magnum Research Desert Eagle Mk XIX .50 AE pistol",
        ["displayName"] = "Desert Eagle Mk XIX",
        ["displayType"] = "Pistol",
        ["weight"] = 1.9,
        ["value"] = 43000,
        ["levelReq"] = 10,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["equipSlot"] = WEAPONSLOTS.HOLSTER.ID,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/weapons/deagle_xix.png", "smooth"),

        ["sizeX"] = 2,
        ["sizeY"] = 1,

        ["caliber"] = ".50 AE",
        ["ammoID"] = "efgm_ammo_50ae",
        ["defAtts"] = "XQAAAQBxAQAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8LmM+Vxqdivswh+weqM2xeCHfXrhUWtKNsXbe+5XDYmGj0t/koPy+Xq92uCt+K1b4FZ8g/hvjMTFuFnPQCMzIfl7bnx9LzZYJwze3ZyIDflOo/FE/iHGwU1UnEQfokAnehpB6GaY7U+lNnUOmYxuPR8miv/wQgfxpcx+Y=",
        ["duelAtts"] = {
            "XQAAAQBxAQAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8LmM+Vxqdivswh+weqM2xeCHfXrhUWtKNsXbe+5XDYmGj0t/koPy+Xq92uCt+K1b4FZ8g/hvjMTFuFnPQCMzIfl7bnx9LzZYJwze3ZyIDflOo/FE/iHGwU1UnEQfokAnehpB6GaY7U+lNnUOmYxuPR8miv/wQgfxpcx+Y=",
            "XQAAAQC2AQAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8LmM+Vxqdivswh+weqM2xeCHfXrhUWtKNsXbe+5XDYmGj0t/koPy+Xq92uCt+K1b4FZ8iXVJ3YOj7Vkd9zQDqEnEAp6t01+xSJJFpyndzCDrAp+dNtOlDVS/TmxVl4p8US6G/Jh1bXIymTnQ3z7LF/cMoq5QOBMmRbHLWOMlWrV5G+7+VtbBHLPl6I8IsVDT4lCA==",
            "XQAAAQC2AQAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8LmM+Vxqdivswh+weqM2xeCHfXrhUWtKNsXbe+5XDYmGj0t/koPy+Xq92uCt+K1b4FZ8iXVJ3YOj7fg3Pz7U0z2MKu3kOtZwE19jJESJZW+O6us+MuYAO8Zlz+DD6hzUizR+0LTgSZqi+rtL6F5zWUrjx3tCdvzXDonZh8ZJD5VByHsMaqsUEbca8HpCzaRhgJAA=="
        }
    }

    EFGMITEMS["arc9_eft_fn57"] = {
        ["fullName"] = "FN Five-seveN MK2 5.7x28 pistol",
        ["displayName"] = "FN 5-7",
        ["displayType"] = "Pistol",
        ["weight"] = 0.6,
        ["value"] = 44000,
        ["levelReq"] = 12,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["equipSlot"] = WEAPONSLOTS.HOLSTER.ID,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/weapons/fn57.png", "smooth"),

        ["sizeX"] = 2,
        ["sizeY"] = 1,

        ["caliber"] = "5.7x28",
        ["ammoID"] = "efgm_ammo_57x28",
        ["defAtts"] = "XQAAAQAMAQAAAAAAAAA9iIIiM7hMNz0dhIkbkvLjTdSR5gRNNIHH3iLx7t5wr3FFXY/9RrihzPm/gZGThPmW/5f0k3e4vh0z8FkTFaDqOgHBWJGFX3r6Fdlg/2RrXUciz4JBF5REP4W2XIDOp389OhAQn3eo0puY/4A=",
        ["duelAtts"] = {
            "XQAAAQAMAQAAAAAAAAA9iIIiM7hMNz0dhIkbkvLjTdSR5gRNNIHH3iLx7t5wr3FFXY/9RrihzPm/gZGThPmW/5f0k3e4vh0z8FkTFaDqOgHBWJGFX3r6Fdlg/2RrXUciz4JBF5REP4W2XIDOp389OhAQn3eo0puY/4A=",
            "XQAAAQAwAQAAAAAAAAA9iIIiM7hMNz0dhIkbkvLjTdSR5gRNNIHH3iLx7t5wr3FFXY/9RrihzPm/gZGThPmW/5f0k3e4vh0z8FkTFaDqOgR3lG59n1bzFCtCM2NN8vNZaNa+bgpRANNYWDqfkwFjR0CnfShs4lemJ+DUuoQrxW3Lg+QuiHzpXvYnYPBrH2I=",
            "XQAAAQBiAQAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8EeEdm5bmiqTBRuzRxt+F8mWuW5pT78mO36a/rDlQkGjU+3hq3aegIneKy+1IKF2LMHngLd8aiNGBmm3jfEFmyHTxR095ynOre7GIqXni5HPynKnz4mPVd8Ah9NiuahxolfZyrqLxG4cvFIu2nqWLQJD45ZdWWk2USdu9qa6eyx4w="
        }
    }

    EFGMITEMS["arc9_eft_glock17"] = {
        ["fullName"] = "Glock 17 9x19 pistol",
        ["displayName"] = "Glock 17",
        ["displayType"] = "Pistol",
        ["weight"] = 0.8,
        ["value"] = 19000,
        ["levelReq"] = 1,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["equipSlot"] = WEAPONSLOTS.HOLSTER.ID,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/weapons/glock17.png", "smooth"),

        ["sizeX"] = 2,
        ["sizeY"] = 1,

        ["caliber"] = "9x19",
        ["ammoID"] = "efgm_ammo_9x19",
        ["defAtts"] = "XQAAAQBCAQAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8LmM+Vxqdivt1xkDF9J/BRcigS9VhIYXZ5jzcY0QKC4UDg7zw2J4NcnLrn7qGmfbrcIn3ZOxTbRObyQ+TN50SFIJhk4W7/rr4DmKjva9hcJV4mRdtdDl5y7njjTqZ9/obcJWyBUMOHjtHNwFf6XAzu",
        ["duelAtts"] = {
            "XQAAAQBCAQAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8LmM+Vxqdivt1xkDF9J/BRcigS9VhIYXZ5jzcY0QKC4UDg7zw2J4NcnLrn7qGmfbrcIn3ZOxTbRObyQ+TN50SFIJhk4W7/rr4DmKjva9hcJV4mRdtdDl5y7njjTqZ9/obcJWyBUMOHjtHNwFf6XAzu",
            "XQAAAQDgAQAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8LmM+Vxqdivt1xkDFpxgxCVMmCc6mHJmbxBPopDqtTtrLsjxvhXEI6Zo64/LFub3fTXw4gUpCcwOFTJ/wbZ4pp9vZUjiDZj+/PZkNkPeivhaTyTFuRqikHPEYWn8iJ+BZzD78Q9CyuyCyE7zK83YhQeb00Gws7rQcmrASCaS+0yahnhs8ANxDAGDG5yCF059z5h2WXeJfz2yrAU9dKTTZtpdbLvmR4ElqgAA==",
            "XQAAAQBWAgAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8LmM+Vxqdivt1xkDFpxgxCVMmCc6mHJmbxBPopDqtTtrLsj5FW1ESGfIV4Y+Mxc9ze5q3p1kKw7fJ0OojkKMeQBEcE+uYSAs1ZRdIzDMz4N3jISLuNQIHKDn5Ow77gPvD9KDVwfNktJZ/SeYGLwyIm6ngZAAx7bTVTCLz9M4wlZ40quguafHYlMk3NHAMBK7QovwRNhQJZzFlngyvraCQZSFHg+P80+wdUXC5oxUUt1qRYkWEikcrAwurcArE7H29H5ahywA==",
            "XQAAAQAbAgAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8LmM+Vxqdivt1xkDFpxgxCVMmCc6mHJmbxBPopDqtTtrLsjxvhXD3IcIcA21yeJtO6yDLKPyy7j3Abfn1Ycaoxo+ifu7+1BK1C1sRlEizO8YsHI2AYAa4oNXUBfKd4BGZFczm80yNGvf3PqXvQhRhyYeaDfPJLRdV/cvA2/tKZUhXc/xJGmLiE8VVcZIJ6wECQq4OaF/S92spE6WuYsoaLtzX2oHCmPKjgeaOvvexrNcMBzg==",
            "XQAAAQDMAQAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8LmM+Vxqdivt1xkDF9J/BRcigS9VhIYXZ5jzcY0QKC4UDg7zw2J4LRqu477rHxlB9OeHyWHDvC2LDUz/lnjDME4iAvLhRB9WoOHcFqCMZosesU4lbCLYR2AODG5cNRzZ4yJpU+d1hgu1205s2tsDeNz0mJ5UX/F9Fl/RcBK6djy/5AIbX0LdC+B+XAPvqict2c6qj9XTA6XzCXluOdR8BUPQ==",
            "XQAAAQDkAQAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8LmM+Vxqdivt1xkDFljxK4mbKcc3/RWfv9dmOyGkRuCCNy87yWgpMHRzeGTDTyou9rQGO4NfKPsFDZjOc1xSVg7UkiV6j4yQ3yJsju75aTLvwa8jYm6VLrsJvWIdrtL1xQGq4rTzSkuORF/apwWFQKYZC/YKepuXzs8f0Z0YQSMkiUenjKh4y7k3kN+B0dsh130MrIgDLr8bJa61/MoiA="
        }
    }

    EFGMITEMS["arc9_eft_glock18c"] = {
        ["fullName"] = "Glock 18C 9x19 machine pistol",
        ["displayName"] = "Glock 18C",
        ["displayType"] = "Pistol",
        ["weight"] = 0.8,
        ["value"] = 37000,
        ["levelReq"] = 4,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["equipSlot"] = WEAPONSLOTS.HOLSTER.ID,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/weapons/glock18c.png", "smooth"),

        ["sizeX"] = 2,
        ["sizeY"] = 1,

        ["caliber"] = "9x19",
        ["ammoID"] = "efgm_ammo_9x19",
        ["defAtts"] = "XQAAAQAuAQAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8LmM+Vxqdivt1xk4SiRjwdbJ+RltR5p3e6xTPK4jcJw9qY6Bkjo4aprpMte/wKgyPzNA+TIK46D/sfb/qyPHGYEpI7eWlZZskfihX3L1xEWEH0uQhZ1CnIYjmkotENPSDug5CKHs0Ulr3f4g3lcmT07gA=",
        ["duelAtts"] = {
            "XQAAAQAuAQAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8LmM+Vxqdivt1xk4SiRjwdbJ+RltR5p3e6xTPK4jcJw9qY6Bkjo4aprpMte/wKgyPzNA+TIK46D/sfb/qyPHGYEpI7eWlZZskfihX3L1xEWEH0uQhZ1CnIYjmkotENPSDug5CKHs0Ulr3f4g3lcmT07gA=",
            "XQAAAQCGAQAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8LmM+Vxqdivt1xk4SiRjwdbJ+RltR5p3e6xTPK4jcJw9qY6Bkjo4aprpMte/wKgyPzNA+TIK4Y5dGpQtFuVW8VuP3xpwA4Ww8kjqEPKrUpeLUKo/SlRQJBQq4e94Ln/0aXyh/I4OTAKrcVqmi8jChOfoPajgNxEBRWa8RUgrP4WiPw6mMuAQUuht9k7EODUiNvNmQ=",
            "XQAAAQB+AQAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8LmM+Vxqdivt1xk4SiRjwdbJ+RltR5p3e6xTPK4jcJw9qY6Bkjo4aprpMte/wKgyPzNA+TIK4Y5av0O10DHf5UzU3fQ7hJXEjBwii2DH940sfjw0SAy8LeT4T5luQOGo+JD6VB+UZa+dFTCkIPCEKPU35q4l1DQDa66Oo39wWDeStdi5vG4wU1QfVdpQz6M4qHwgA=",
            "XQAAAQDvAQAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8LmM+Vxqdivt1xk4SiRjwdbJ+RltR5p3e6xTPK4jcJw9qY6Bkjo4aprpMte/wKgyPzNA+TIK7w0JTa//gnyzNpQ/tS9WKcIgbKbfjr6RVHjRxnExhk9Wc0jEkWls/Pt5vkvbHpRK0z/s35BC3Nm80vWWAeMW8YB/T1Cn7GRCd0ynbCCVgEosvMroXSwV+tfwjQivH9/FMFvvsKAv0YyZLTO9+M5+vmoP8w5QA="
        }
    }

    EFGMITEMS["arc9_eft_glock19x"] = {
        ["fullName"] = "Glock 19X 9x19 pistol",
        ["displayName"] = "Glock 19X",
        ["displayType"] = "Pistol",
        ["weight"] = 0.6,
        ["value"] = 20000,
        ["levelReq"] = 2,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["equipSlot"] = WEAPONSLOTS.HOLSTER.ID,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/weapons/glock19x.png", "smooth"),

        ["sizeX"] = 2,
        ["sizeY"] = 1,

        ["caliber"] = "9x19",
        ["ammoID"] = "efgm_ammo_9x19",
        ["defAtts"] = "XQAAAQAqAQAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8LmM+Vxqdivt1xlyTi2kEhSDJ0/hjFF+ZhmDnWCz/XusxgpHtc5BJM3wDICpGycXMrvH9E1L9NKRh70J5M7syVS/SO+SoYGiVU1WhrrhKYepHGjrFocqvFzPAhbv6IyvMcLkdzussozVm0VRU=",
        ["duelAtts"] = {
            "XQAAAQAqAQAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8LmM+Vxqdivt1xlyTi2kEhSDJ0/hjFF+ZhmDnWCz/XusxgpHtc5BJM3wDICpGycXMrvH9E1L9NKRh70J5M7syVS/SO+SoYGiVU1WhrrhKYepHGjrFocqvFzPAhbv6IyvMcLkdzussozVm0VRU=",
            "XQAAAQBBAQAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8LmM+Vxqdivt1xlyTi2kEhSDJ0/hjFF+ZhmDnWCz/XusxgpHtc5BJM3wDICpGycXMrvH8wa0M293Xh9xlbpHZ67MnZYKA240OlYhhYxsci8OBBQmlDyCWLfz0leu27UEg1kCv8c2W2wZ3qs0drEWtz/Rf4oT2TYOsb/f7YO8wA",
            "XQAAAQDTAQAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8LmM+Vxqdivt1xlyTi2kEhSDJ0/hjFF+ZhmDnWCz/XusxgpHtc5BJM3wDICpGycXMrvH9E1L9NKRh70J5M7syVS/SO+SoYGiVU1WhrrhKYKurIgBKejQ4f4fGr5cpTTldeEENMpbkKizpN3GbyUlyYvgJ38PAIKXxnUG+haTnLThgGDWMfi5zKpG2dXvDN85KlNmvOroUfFA=="
        }
    }

    EFGMITEMS["arc9_eft_usp"] = {
        ["fullName"] = "HK USP .45 ACP pistol",
        ["displayName"] = "USP .45",
        ["displayType"] = "Pistol",
        ["weight"] = 0.8,
        ["value"] = 26000,
        ["levelReq"] = 4,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["equipSlot"] = WEAPONSLOTS.HOLSTER.ID,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/weapons/usp.png", "smooth"),

        ["sizeX"] = 2,
        ["sizeY"] = 1,

        ["caliber"] = ".45",
        ["ammoID"] = "efgm_ammo_45",
        ["defAtts"] = "XQAAAQCvAQAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8LmM+VxqdivzBHMTRxglFdvimLKcy1jyOrRsYPl3qRiyX4XvjyVJvyHklho+t8gVZExOXjbfMkt+e9MdetDvqhYhw4iEVFfHmEe4ABTlm9B4kQRHkUBMLkfXdinWNgD3hmkMtGlR4KynTRLT3yBnmgN2LpPMtWEaBY52V7UG6lgA==",
        ["duelAtts"] = {
            "XQAAAQCvAQAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8LmM+VxqdivzBHMTRxglFdvimLKcy1jyOrRsYPl3qRiyX4XvjyVJvyHklho+t8gVZExOXjbfMkt+e9MdetDvqhYhw4iEVFfHmEe4ABTlm9B4kQRHkUBMLkfXdinWNgD3hmkMtGlR4KynTRLT3yBnmgN2LpPMtWEaBY52V7UG6lgA==",
            "XQAAAQC0AgAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8LmM+VxqdivzBHMTR2TEtlOqQIs8UVemBdqRlN8srGGNpzS/0YO3wUlo4Yru6Js7l0h+dNl42m7wEjFYkHeFrELJh1fzTVi6VYmYyXwS6dXq+p5NEDRssUnQ78byLtVF2rasmfVR3Ncb6F+J9VYGcsok6wChT5A/eHrz+jP15DbpTPXi8T6lrIgVXO0YGegsAnCiX/nO3cYUeednfWz1OMslCnvaIEVYURSAoLO71T2RWT3K3Vc7sh/UrQ1efXwvwlkzYfwrPtp/GE2ng4cBQ=",
            "XQAAAQD8AQAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8LmM+VxqdivzBHMTRSlQg+APRZ8sqkax4RYs5p7Oih4r5NWOtIthU1rGG15I2j6iY/65K2eojQN1gVoIApID5L0LD7TZVQ2oTZgUmxcr3pwGhwIoXFml8WfWgsI6TgNCGUQo2rKLxom0N0YZvfIOkgJNIgaWu4Xo9d8YyO02K23TFWCMJSnqE2kHPwIeiXbnI3kubHWAA="
        }
    }

    EFGMITEMS["arc9_eft_pl15"] = {
        ["fullName"] = "Lebedev PL-15 9x19 pistol",
        ["displayName"] = "PL-15",
        ["displayType"] = "Pistol",
        ["weight"] = 0.9,
        ["value"] = 24000,
        ["levelReq"] = 10,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["equipSlot"] = WEAPONSLOTS.HOLSTER.ID,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/weapons/pl15.png", "smooth"),

        ["sizeX"] = 2,
        ["sizeY"] = 1,

        ["caliber"] = "9x19",
        ["ammoID"] = "efgm_ammo_9x19",
        ["defAtts"] = "XQAAAQAbAQAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8LmM+VxqdivxOSNEdVv0L37daJtxpkfSMuD7nd72zoac4KV1tNG0hnWlS9vugxfb2i5nikGPX/x7fgjwzzvtOLnl9U+WgreiAiqVOJ9kq/5obz9InMIAXOjbfPysfPs4rMWPK8DUOL",
        ["duelAtts"] = {
            "XQAAAQAbAQAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8LmM+VxqdivxOSNEdVv0L37daJtxpkfSMuD7nd72zoac4KV1tNG0hnWlS9vugxfb2i5nikGPX/x7fgjwzzvtOLnl9U+WgreiAiqVOJ9kq/5obz9InMIAXOjbfPysfPs4rMWPK8DUOL",
            "XQAAAQBUAQAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8LmM+VxqdivxOSNEdV0u4UEBWX2AdVZQ4BakmQijfL7sTTm+wFn9M8fxO9HY5yvWlCbUa/H1V1VDh8lkLqIZa3AryyReTVNbLiScGgC9rOzQEPiY56Ohrx5HNDQGp8TQdVfuEjSwYbqphOdgh1/4tF2YyQlBYs3zcOO9IQS7hwD4Wh"
        }
    }

    EFGMITEMS["arc9_eft_pm"] = {
        ["fullName"] = "Makarov PM 9x18PM pistol",
        ["displayName"] = "PM",
        ["displayType"] = "Pistol",
        ["weight"] = 0.7,
        ["value"] = 15000,
        ["levelReq"] = 1,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["equipSlot"] = WEAPONSLOTS.HOLSTER.ID,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/weapons/pm.png", "smooth"),

        ["sizeX"] = 2,
        ["sizeY"] = 1,

        ["caliber"] = "9x18",
        ["ammoID"] = "efgm_ammo_9x18",
        ["defAtts"] = "XQAAAQDfAAAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8N0MrcAX4ZC/nXwXwJMUX9VzIJ9eJoIzCxxdGJugl7TlFzel6UwwEdsDy/8G80rRx4/ISGjd3kGS6R64Nw6B+419FI8Iuegof64zUxQc/BQvc+KZA=",
        ["duelAtts"] = {
            "XQAAAQDfAAAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8N0MrcAX4ZC/nXwXwJMUX9VzIJ9eJoIzCxxdGJugl7TlFzel6UwwEdsDy/8G80rRx4/ISGjd3kGS6R64Nw6B+419FI8Iuegof64zUxQc/BQvc+KZA=",
            "XQAAAQB0AQAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8N0MrcAX4ZC/nXwXwJMUX9VzIJ9eJoIzCxxdGJdo2ufhTgcMM10pyhJR8ejQ4/BHWRr05Xrj5F5rlCasHL+WlmxqxhhWQg0TBtaQEd7lTntmzVQj4EXMFfp5F223sHNdigXnngUW+M9HmsGtOp89yarZaPiE7Zz9qJPVOozJxnqQug"
        }
    }

    EFGMITEMS["arc9_eft_mp443"] = {
        ["fullName"] = "Yarygin MP-443 Grach 9x19 pistol",
        ["displayName"] = "MP-443 Grach",
        ["displayType"] = "Pistol",
        ["weight"] = 0.9,
        ["value"] = 18000,
        ["levelReq"] = 1,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["equipSlot"] = WEAPONSLOTS.HOLSTER.ID,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/weapons/mp443.png", "smooth"),

        ["sizeX"] = 2,
        ["sizeY"] = 1,

        ["caliber"] = "9x19",
        ["ammoID"] = "efgm_ammo_9x19",
        ["defAtts"] = "XQAAAQCKAAAAAAAAAAA9iIIiM7hMNz0dhIkbkvLjTdSR5gRNNIHH3iMsviapv77xMa1x/jpy6bAjUW6sPbpwOYKac6uJtf5N1dKAFULp44UjPYFMBCK134yz1vswcmhn56o/AA==",
        ["duelAtts"] = {
            "XQAAAQCKAAAAAAAAAAA9iIIiM7hMNz0dhIkbkvLjTdSR5gRNNIHH3iMsviapv77xMa1x/jpy6bAjUW6sPbpwOYKac6uJtf5N1dKAFULp44UjPYFMBCK134yz1vswcmhn56o/AA==",
            "XQAAAQDrAAAAAAAAAAA9iIIiM7hMNz0dhIkbkvLjTdSR5gRNNIHH3iMsviapv77xMa1x/jpy6bAjUW6sPbpwOYKac6uJtf5P3hdFv6loQIet59iaTQLE2b7q/txw8i726Rg2g2mCmOqVGGnR783zDbIPAKSr1RCm7iyXecxw2YicC7zuGSJ7srM0hm38AA==",
            "XQAAAQBfAQAAAAAAAAA9iIIiM7hMNz0dhIkbkvLjTdSR5gRNNIHH3iMsviapv77xMa1x/jpy6bAjUW6sPbpwOYKac6uJtf5P3hdFv6loQIet59iaTQLE2b7q/t2LgQhTh9l0pMPJ5iU8h9WdJ8oS/1MchRgMs26pJavUPsX4HsDuLBZSUF7QJtgASIucr6xZwXDpPOg8qOzernRCAA=="
        }
    }

    EFGMITEMS["arc9_eft_pb"] = {
        ["fullName"] = "PB 9x18PM silenced pistol",
        ["displayName"] = "PB",
        ["displayType"] = "Pistol",
        ["weight"] = 0.9,
        ["value"] = 17000,
        ["levelReq"] = 2,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["equipSlot"] = WEAPONSLOTS.HOLSTER.ID,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/weapons/pb.png", "smooth"),

        ["sizeX"] = 3,
        ["sizeY"] = 1,

        ["caliber"] = "9x18",
        ["ammoID"] = "efgm_ammo_9x18",
        ["defAtts"] = "XQAAAQCwAAAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8Nz6D0gX5ySkZNvQ9kVxN2oB2e+x5mololx5+0qIIQff+f9wIHQK6as1lei0/0i8/97/7VIpwTc/v8m0jOypdFCAMSb8RdVo4qB+kRFA==",
        ["duelAtts"] = {
            "XQAAAQCwAAAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8Nz6D0gX5ySkZNvQ9kVxN2oB2e+x5mololx5+0qIIQff+f9wIHQK6as1lei0/0i8/97/7VIpwTc/v8m0jOypdFCAMSb8RdVo4qB+kRFA==",
            "XQAAAQCxAAAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8Nz6D0gX5ySkZNvQ9kVxN2oB2e+x5mololx5+0qIIQff+f9wIHQK6as1lei0/0i8/975F2tjSq3ncrM7oVW9zIoitN6vIXyoxm0l4TrQA="
        }
    }

    EFGMITEMS["arc9_eft_rsh12"] = {
        ["fullName"] = "RSh-12 12.7x55 revolver",
        ["displayName"] = "RSh-12",
        ["displayType"] = "Pistol",
        ["weight"] = 2.2,
        ["value"] = 78000,
        ["levelReq"] = 16,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["equipSlot"] = WEAPONSLOTS.HOLSTER.ID,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/weapons/rsh12.png", "smooth"),

        ["sizeX"] = 2,
        ["sizeY"] = 1,

        ["caliber"] = "12.7x55",
        ["ammoID"] = "efgm_ammo_127x55",
        ["defAtts"] = "XQAAAQCSAAAAAAAAAAA9iIIiM7hMNz0dhJSTKmZ7v+v6J9rfJDxrK5jGCg9Ongj2ouH9rTzyEctbtT8fV//t2AQ2AZxawi8qmKMSgUzbkr8ItspwpeCSHI3kSOweFs81HRO3DZClNaakAA==",
        ["duelAtts"] = {
            "XQAAAQCSAAAAAAAAAAA9iIIiM7hMNz0dhJSTKmZ7v+v6J9rfJDxrK5jGCg9Ongj2ouH9rTzyEctbtT8fV//t2AQ2AZxawi8qmKMSgUzbkr8ItspwpeCSHI3kSOweFs81HRO3DZClNaakAA==",
            "XQAAAQAkAQAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8NV4/QsCrClhAsuCgVS8l5its18eN63xCobOvEHPEkbvX65EpSQLaHIVhih4Mdjz1lJP0LH6JEez/KjEIuil8NrwkDI+6DF9PGXGzxnVHBilwJcQdP9v0yrORkyZ14a9YvEF11AZfbn49eIKi/YqvlIi8cq1BBjvuUcgtXGScHgaV1",
            "XQAAAQDtAAAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8NV4/QsCrRINBPVkHZhhYOqsxsmimfJ0O28oCM9juEb7tmcvwie+WEcFt5+SQKD2sQfKJxxDDTs7cTzZNvdYz8n/RIGHlPS5CcWRWtH8Eo2mj1zhIKNbWkhy7e/4khE4/bfmo6/kK6SGZLbZ4A"
        }
    }

    EFGMITEMS["arc9_eft_p226r"] = {
        ["fullName"] = "SIG P226R 9x19 pistol",
        ["displayName"] = "P226R",
        ["displayType"] = "Pistol",
        ["weight"] = 0.8,
        ["value"] = 41000,
        ["levelReq"] = 5,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["equipSlot"] = WEAPONSLOTS.HOLSTER.ID,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/weapons/p226r.png", "smooth"),

        ["sizeX"] = 2,
        ["sizeY"] = 1,

        ["caliber"] = "9x19",
        ["ammoID"] = "efgm_ammo_9x19",
        ["defAtts"] = "XQAAAQBMAQAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8LmM+VxqdivxKVF5T+C7zd3vec1rvrAoEdFGwNxOIARyiqMLUYwCcRpAng5F3a8P++FMOSod0D0BXl1e77r2cWTrbxmXSuPJVJXprMK9aBhNpA5UGQXVURYk9qsVNl6LiGhdn8PS8HDLdoOpE1cAfNLxO8yZs=",
        ["duelAtts"] = {
            "XQAAAQBMAQAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8LmM+VxqdivxKVF5T+C7zd3vec1rvrAoEdFGwNxOIARyiqMLUYwCcRpAng5F3a8P++FMOSod0D0BXl1e77r2cWTrbxmXSuPJVJXprMK9aBhNpA5UGQXVURYk9qsVNl6LiGhdn8PS8HDLdoOpE1cAfNLxO8yZs=",
            "XQAAAQCIAQAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8LmM+VxqdivxKVF5T+H7ja5EdcpulhMKD2oQkcKvPK52DSF2Mijs4tmKtO45ZtMp6B7OVpSJ6ZKJOdVlr8lK+LY1Y9G9lH1sMQxL6msLsOTU+XoFeZS6rIuCXVJzEH+pDqnACpVuJwRM+2/bDxLRjYk4mQ4tRQc/dsQUMIhb+Tq/OzT6JUUgJOybtcPrhzpaOyiXdQ",
            "XQAAAQDMAQAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8LmM+VxqdivxKVF5T+H7ja5EdcpulhMKD2oQkcKvPK52DSF1eELwEg1scDqiuAJ30n4oQEtpXWWsudlT1YUpRWbvR5am7z/+E+6D82nzKyBBk2+CgjGelHLsJYIeX2ibg3h/i3fm8Ue4aLjqty4yE9Gz8ELPuQpAAW9elMRmhS6kbmorGhVB7DiJyirCHNb30XCFRIOWzu0IT5nl80RaMueVBMqjMeAA=="
        }
    }

    EFGMITEMS["arc9_eft_sr1mp"] = {
        ["fullName"] = "Serdyukov SR-1MP Gyurza 9x21 pistol",
        ["displayName"] = "SR-1MP",
        ["displayType"] = "Pistol",
        ["weight"] = 0.8,
        ["value"] = 32000,
        ["levelReq"] = 8,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["equipSlot"] = WEAPONSLOTS.HOLSTER.ID,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/weapons/sr1mp.png", "smooth"),

        ["sizeX"] = 2,
        ["sizeY"] = 1,

        ["caliber"] = "9x21",
        ["ammoID"] = "efgm_ammo_9x21",
        ["defAtts"] = "XQAAAQBXAAAAAAAAAAA9iIIiM7hMNz0dhIkbkvLjTdSR5gRNNIHH3iMsviZ+8MTSN7UCyyRm0aGA+jNdSGXjQWiRJbBIjQEMikyPT7J/h14DxwI6DqLvMGhtAA==",
        ["duelAtts"] = {
            "XQAAAQBXAAAAAAAAAAA9iIIiM7hMNz0dhIkbkvLjTdSR5gRNNIHH3iMsviZ+8MTSN7UCyyRm0aGA+jNdSGXjQWiRJbBIjQEMikyPT7J/h14DxwI6DqLvMGhtAA==",
            "XQAAAQBbAQAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8NV4/QsCrW0jf7dDYPzyaWPypBQdrOAHkcVLWt8WEHYm6VLC/saLIwfnJQ8fr/NEk+mh1wV5a/ltgaBsHWZZ2UMLnFG/cMm+SH3ergMDRo2nTx8UMKx9wCoMW7UCzhcHVj2+gOTrghfHXi2Xaw19Xt16tL60lg",
            "XQAAAQAdAQAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8NV4/QsCrW0jf7dDYOZoqWPypBQdrOAHkcVLWt8WEHYm6VLC/saLIwfnJQ8fr/NEk+mh1wV5a/ltgaBsHWZZ2UPoxHOOgRYThTjhwZp0OKTDNd8FXw83mkMoSoXxqlsFO918ro24YXtCj2VcNq3H/2bCg4C26agIA="
        }
    }

    EFGMITEMS["arc9_eft_apb"] = {
        ["fullName"] = "Stechkin APB 9x18PM silenced machine pistol",
        ["displayName"] = "APB",
        ["displayType"] = "Pistol",
        ["weight"] = 1.6,
        ["value"] = 34000,
        ["levelReq"] = 6,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["equipSlot"] = WEAPONSLOTS.HOLSTER.ID,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/weapons/apb.png", "smooth"),

        ["sizeX"] = 4,
        ["sizeY"] = 1,

        ["caliber"] = "9x18",
        ["ammoID"] = "efgm_ammo_9x18",
        ["defAtts"] = "XQAAAQBBAQAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8LceiiH+OYU8CKsAUrAdr/tENAyThefN6cDVAvNEE2F5mDkS3Rk1uREfnqeAx7q76URnhkxW9ezdHaZGJlkZD9FmCgkjjCQDJ1B0mOn3eT4vC72j3iq1TLR4PqnlLWvjo9JegVAA==",
    }

    EFGMITEMS["arc9_eft_aps"] = {
        ["fullName"] = "Stechkin APS 9x18PM machine pistol",
        ["displayName"] = "APS",
        ["displayType"] = "Pistol",
        ["weight"] = 1.0,
        ["value"] = 28000,
        ["levelReq"] = 5,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["equipSlot"] = WEAPONSLOTS.HOLSTER.ID,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/weapons/aps.png", "smooth"),

        ["sizeX"] = 2,
        ["sizeY"] = 1,

        ["caliber"] = "9x18",
        ["ammoID"] = "efgm_ammo_9x18",
        ["defAtts"] = "XQAAAQDoAAAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8LceiiH+X7VuJllh2JgrygyhJzeJeRAUMgmKPwWdZCzRqYZexKUns3rzBSsK2Hj+avMZYkJ4b9wJXw3J+GnkWctfYm9Dgy6D19uNPzAA=="
    }

    EFGMITEMS["arc9_eft_tt33"] = {
        ["fullName"] = "TT-33 7.62x25 TT pistol",
        ["displayName"] = "TT",
        ["displayType"] = "Pistol",
        ["weight"] = 0.8,
        ["value"] = 9000,
        ["levelReq"] = 1,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["equipSlot"] = WEAPONSLOTS.HOLSTER.ID,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/weapons/tt33.png", "smooth"),

        ["sizeX"] = 2,
        ["sizeY"] = 1,

        ["caliber"] = "7.62x25",
        ["ammoID"] = "efgm_ammo_762x25",
        ["defAtts"] = "XQAAAQC/AAAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8Oc2p/mgB/xAKAv4zbPEDsMJKGrN0dVZcBOr2DjQYRbMT4MiiumWQx+UK95/Nvc39bwvVU1RkDteZAwlo0mn6ASN/g31UowrgJXSPvZCEto68A",
        ["duelAtts"] = {
            "XQAAAQC/AAAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8Oc2p/mgB/xAKAv4zbPEDsMJKGrN0dVZcBOr2DjQYRbMT4MiiumWQx+UK95/Nvc39bwvVU1RkDteZAwlo0mn6ASN/g31UowrgJXSPvZCEto68A",
            "XQAAAQAqAQAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8Oc2p/mgB/xAKAv4zbPEDxyOZoJ58U8oki/2eQkt8Lzck2Kx2n8cnyybSAD6yICbRior8KjznzoqXiw41VmvxR4toZTQuT6doYQ2vCd/hOoi6nZJcI1TvsTyr/xrDFRS14qa+K7Z8b5n2lMAA="
        }
    }

    EFGMITEMS["arc9_eft_cr200ds"] = {
        ["fullName"] = "Chiappa Rhino 200DS 9x19 revolver",
        ["displayName"] = "CR 200DS",
        ["displayType"] = "Pistol",
        ["weight"] = 0.7,
        ["value"] = 21000,
        ["levelReq"] = 1,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["equipSlot"] = WEAPONSLOTS.HOLSTER.ID,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/weapons/cr200ds.png", "smooth"),

        ["sizeX"] = 1,
        ["sizeY"] = 1,

        ["caliber"] = "9x19",
        ["ammoID"] = "efgm_ammo_9x19",
        ["defAtts"] = "XQAAAQC1AAAAAAAAAAA9iIIiM7hMNz0dhIkbkvLjTdSR5gRNNIHH3iMxyb1USyArYDmk731f5dmwXd1V2F4KB2PoMgWnJCTwClBVT2CAhNumNQnOhBgvFvtbRGRj8/vmD9myG6J5DmZhnZIA"
    }

    EFGMITEMS["arc9_eft_cr50ds"] = {
        ["fullName"] = "Chiappa Rhino 50DS .357 revolver",
        ["displayName"] = "CR 50DS",
        ["displayType"] = "Pistol",
        ["weight"] = 0.9,
        ["value"] = 27000,
        ["levelReq"] = 3,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["equipSlot"] = WEAPONSLOTS.HOLSTER.ID,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/weapons/cr50ds.png", "smooth"),

        ["sizeX"] = 2,
        ["sizeY"] = 1,

        ["caliber"] = ".357",
        ["ammoID"] = "efgm_ammo_357",
        ["defAtts"] = "XQAAAQD0AAAAAAAAAAA9iIIiM7hMNz0dhIkbkvLjTdSR5gRNNIHH3iMxyb1USyArYDmk731f5dmwXd1V2F4KB2PoMgWnJCTwClBVT2CAhNumNQnOhBgvFvtbRSBdDSX/JEhDflFLZp4RsgU48ZBAfbFtCxzD2A==",
        ["duelAtts"] = {
            "XQAAAQD0AAAAAAAAAAA9iIIiM7hMNz0dhIkbkvLjTdSR5gRNNIHH3iMxyb1USyArYDmk731f5dmwXd1V2F4KB2PoMgWnJCTwClBVT2CAhNumNQnOhBgvFvtbRSBdDSX/JEhDflFLZp4RsgU48ZBAfbFtCxzD2A==",
            "XQAAAQCFAQAAAAAAAAA9iIIiM7hMNz0dhIkbkvLjTdSR5gRNNIHH3iMxyb1USyArYDmk731f5dmwXd1V2F4KB2PoMgWnJCTwClBVT2CAhNumNQnOhBgu/7FQ2ztjsGXlZAaPcWUFF9+/ao7A9doMqPeW0mMTn0pbP7RJxwnW6bVp9fYeLsGdptb+14wuerxIY+Q33w1Q9AcI/K7PUhJhgSmMJ9kLTnXRC7Lz0AA="
        }
    }

    -- shotguns
    EFGMITEMS["arc9_eft_m3super90"] = {
        ["fullName"] = "Benelli M3 Super 90 12ga dual-mode shotgun",
        ["displayName"] = "M3 Super 90",
        ["displayType"] = "Shotgun",
        ["weight"] = 3.3,
        ["value"] = 39000,
        ["levelReq"] = 10,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["equipSlot"] = WEAPONSLOTS.PRIMARY.ID,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/weapons/m3super90.png", "smooth"),

        ["sizeX"] = 5,
        ["sizeY"] = 2,

        ["caliber"] = "12/70",
        ["ammoID"] = "efgm_ammo_12gauge",
        ["defAtts"] = "XQAAAQAZAgAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8NUZMP40QWndnxL8Md9bjhwTqWECpCpnCIWQQlz5538GEncsfHe2QOxB/tCr1SkG+XMF4y+5EAaoyzoUra4P37r8hyWHh6bC7xUkNi72e+GWwopRDL0QZ42TJtYRBkpsBU4yOy8RxOlDlywYEDFP6hJGYa2VLwydXNBZVA4jAvAZLlYZmzj8eW8lyPx1b0JJ2Bo5ng",
        ["duelAtts"] = {
            "XQAAAQAZAgAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8NUZMP40QWndnxL8Md9bjhwTqWECpCpnCIWQQlz5538GEncsfHe2QOxB/tCr1SkG+XMF4y+5EAaoyzoUra4P37r8hyWHh6bC7xUkNi72e+GWwopRDL0QZ42TJtYRBkpsBU4yOy8RxOlDlywYEDFP6hJGYa2VLwydXNBZVA4jAvAZLlYZmzj8eW8lyPx1b0JJ2Bo5ng",
            "XQAAAQCJAgAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8NUZMP40QWndnxL8Md9bjhwTqWECpCpnCIWQQlz5538GEmLUhv2JYZRjY4W8ufTWyrpZKTOowfc0HbwldA9BAl6L4IG6XV1bkjm38fvokKF02R69N+SOHkWz2KwIbYS7tB9wlgJqAPBaoTlVLEyAkZU0f6FR4X/zsSHIv0iKhT1oKhjWuZNYuml3WcmXHjyuqgYEWBm+GB00V/H2eZ30yKwiyuHIQWiN/0DW/GItZlrIxwsUkdjg1jMlnst9TDTSbNUwA=",
            "XQAAAQDtAgAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8NUZMP40QWndnxL8Md9bjhwTqWECpCpnCIWQQlz5538GEmLUhv2JYZRjY4W8ufTYnsMmkhjDeWF4QUnDU1Dav19qSlFTx7ZXLZ5YIHbW4psZQbg+SUWcvKFafvcAWYO8I9RywrevWA+yzm8kOag2/MGwTW8pgA4iHrCkk0CokbrT7T5GszyXnnTD7KVp8RvorSblTFSqJbl5Qmhcln9GqwGk0D5H9LxzDlmAENd5mOxBEMcXO3wERhXPGKkFx0lZlj01B1UAdPv26Wa1ykHh/JX6nl"
        }
    }

    EFGMITEMS["arc9_eft_m590"] = {
        ["fullName"] = "Mossberg 590A1 12ga pump-action shotgun",
        ["displayName"] = "590A1",
        ["displayType"] = "Shotgun",
        ["weight"] = 3.4,
        ["value"] = 30000,
        ["levelReq"] = 6,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["equipSlot"] = WEAPONSLOTS.PRIMARY.ID,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/weapons/m590.png", "smooth"),

        ["sizeX"] = 5,
        ["sizeY"] = 1,

        ["caliber"] = "12/70",
        ["ammoID"] = "efgm_ammo_12gauge",
        ["defAtts"] = "XQAAAQB4AQAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8NUcBpvXLm8lkMPKMXHqRiLKF55cbAc904tXTkm4W3W0yA1OsnrOfILaJM92KjwQxOWOEiHWrxIttmXwMpPhLwJGHdLcEZKnM+sQhY0Mxo+PT7UJUE9juj8OJF2CtNTm65I3LJwsJBQF1xBJE5AzpLmZ4iFuIWF0O3IHceGU631S47JYA=",
        ["duelAtts"] = {
            "XQAAAQB4AQAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8NUcBpvXLm8lkMPKMXHqRiLKF55cbAc904tXTkm4W3W0yA1OsnrOfILaJM92KjwQxOWOEiHWrxIttmXwMpPhLwJGHdLcEZKnM+sQhY0Mxo+PT7UJUE9juj8OJF2CtNTm65I3LJwsJBQF1xBJE5AzpLmZ4iFuIWF0O3IHceGU631S47JYA=",
            "XQAAAQAjAwAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8NUcBpvXLm8lkMPKMXHqRiLKF55cbAc904tXTkm4W3W0yA1OsnrOfILaJM92KjwQxOWOEiHWrxI3xMPew6R+zoMCE3MiHBBukMS8n9idk5QOhb6WPoF1B5AUcCGcUvpM26nNmO9o9S5+QwMPT1hM2tt3YHf70NliRtRV7NUCsQm5/7Zd3uwCyQoAqOjQPpTlla6XX+qZi3nac+Bx00M6dgYUFcmR/SF5VD/s74rEr2pFVJWliMvX4LP89t9nvTS65pSIaIfA35xcAVCzmV0VYxLo9Q",
            "XQAAAQCTAwAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8NUcBpvXLm8lkMPKMXHqRiLKF55cbAc904tXTkm4W3WzxSEVN1UnSn3nmxuMW7fVj3F/IJzAB7h0cnY1LbQ97MO3hW4a2nbkLc3AosqckxkHKtaovq+W5CRvbPWE4G4z+6gLm7QAstElpdmiFwFxactzyx6cqDScxG1g0ZIMBmc6NtpQ3NB7okzAQvoAQlmfu9N2+VdRht3lGReP7MwKMyPs2+KX/CE6Jbe2TwXEQ3Yp0+zo80oRAYat63l1gPfA6ojl48iD3Zv5fgodNxqvoscq7RX/zZ1r9VVdygufNTNR0JM/QpA8HYKsIvsxcwgJdfBR9Iw3VDhNvxO062rg=="
        }
    }

    EFGMITEMS["arc9_eft_mr133"] = {
        ["fullName"] = "MP-133 12ga pump-action shotgun",
        ["displayName"] = "MP-133",
        ["displayType"] = "Shotgun",
        ["weight"] = 3.5,
        ["value"] = 25000,
        ["levelReq"] = 2,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["equipSlot"] = WEAPONSLOTS.PRIMARY.ID,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/weapons/mr133.png", "smooth"),

        ["sizeX"] = 5,
        ["sizeY"] = 1,

        ["caliber"] = "12/70",
        ["ammoID"] = "efgm_ammo_12gauge",
        ["defAtts"] = "XQAAAQBAAQAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8NV9soqBkgp9xKO7Kzg2dCl/HKiW+fRuX8JPD3U0v7srDXOXCUG85bOAsJeBrjxnVOSUD/930s/nAksh6vnoQpbsS0eP+sfldKbHkVMdUcGb6Nfj7B0HxCOF5gUFyhFKPHIfPbFq5vPHcilqPQc7XZZFGVyzeCGxLw0qn8gA==",
        ["duelAtts"] = {
            "XQAAAQBAAQAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8NV9soqBkgp9xKO7Kzg2dCl/HKiW+fRuX8JPD3U0v7srDXOXCUG85bOAsJeBrjxnVOSUD/930s/nAksh6vnoQpbsS0eP+sfldKbHkVMdUcGb6Nfj7B0HxCOF5gUFyhFKPHIfPbFq5vPHcilqPQc7XZZFGVyzeCGxLw0qn8gA==",
            "XQAAAQAXAgAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8NV9soqBkgp9xKO7Kzg2dCmPkwmlbXlBRTBCUcxF1wuDG3V/sX6LdWOzt37xZ94HVSfWIY0gll1UDnRiqjz48dR8wNShmBNfeMAhOwGYAwoI+352ZrqxqWY7uy6DSGVuDacZeEccFv3FZaUgxQhcOsBm2fi1X2V2QDiSwoxzmjB3vHGSecH4SmpXvLqdOsSCoH3LF3ZLy6h/WjPrBXLjgzjqH9dT3U0F7HuS23jjiyoexE5+q+1nMOJTgA",
            "XQAAAQA4AwAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8NV9soqBkgp9xKO7Kzg2dCl/HKiW+fRuX8JPD3U0v7srDX3jCKJBOqMFtc57FnrB8+q/ht4lWo0U9jUYxXoVBWVccp69gxBL+2o5sV11Nrc8Jbn2jfgXfVS5ETDowsBwcMWH5XVd3Mi4SoVhdTdKG9pS8z+A+YYHSibEIGZILlkzu5xOJTpmYrvRRT/TYZvYihXIw1i9NpXj2b0TggKww1Nty3wQCPgaBcx2fiKSB+KZkjJpE3tXqSkxrJw5LLJodPoz8eIEgHTpptyNufe4uDS4/8uxz6a+j9kTp8xr2KWnKF9HAT5gzET9V8nkVdoewA"
        }
    }

    EFGMITEMS["arc9_eft_mr153"] = {
        ["fullName"] = "MP-153 12ga semi-automatic shotgun",
        ["displayName"] = "MP-153",
        ["displayType"] = "Shotgun",
        ["weight"] = 3.6,
        ["value"] = 40000,
        ["levelReq"] = 4,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["equipSlot"] = WEAPONSLOTS.PRIMARY.ID,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/weapons/mr153.png", "smooth"),

        ["sizeX"] = 7,
        ["sizeY"] = 1,

        ["caliber"] = "12/70",
        ["ammoID"] = "efgm_ammo_12gauge",
        ["defAtts"] = "XQAAAQBYAQAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8NV9soxclwG/vLo5K6RnuIXLbaswlwWOWqkxbEnzZoRppkn//6LvHIYf42vOIuzYGB92XfwC1K+Hvk9FW8Y5JGcvka/pJrFbQms3J70HDEavIcmrYNDwhwLsp2NTO2jx+D03bcbwKpjNWdfaiVxe+cls+Arwjr4KBGTSZU/bs05Hzt8Aql6ec=",
        ["duelAtts"] = {
            "XQAAAQBYAQAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8NV9soxclwG/vLo5K6RnuIXLbaswlwWOWqkxbEnzZoRppkn//6LvHIYf42vOIuzYGB92XfwC1K+Hvk9FW8Y5JGcvka/pJrFbQms3J70HDEavIcmrYNDwhwLsp2NTO2jx+D03bcbwKpjNWdfaiVxe+cls+Arwjr4KBGTSZU/bs05Hzt8Aql6ec=",
            "XQAAAQBiAgAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8NV9soxclwG/vLo5K6Rnoew+alxn+nL3Fc99oS44ex66nVipnkekSsu3oNq6nx7iP42i4IHI8WRJYkwfNWUColQFOo4NHrRkkZZdURVbjFvOukcbPQajDS/0C58Qb+4zhrAGlpLf2xDNUdfAh8uHf9N5nQPYVGHox3Ru8D2ntH7KGYI7wz7Znh4+G6Iex2goVNOg7MQxbiFwbB0etPNcTGtHGLuYkV6TYSxaF9KWYQdIsGQ16ekKyoJSoDndyy+q4A",
            "XQAAAQA9AgAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8NV9soxclwG/vLo5K6RnuIXLbaswlwWOWqkxbEnzZoRpplCxHb5+8KllnR6P0uHePxg5vaHPazwbiRPAsLV+EfnH5r/DHTEQAcWvCpW/64GID6zbuZcoNFYebZ+9xnCzPkz9aQseUy4z3JPmOYfNtz4Y29dHuQCPGO+armfvdnr5HqOGji+KtvYH9DgeRu9KAzCShkmw3H4bgtXI3s1sBwRLi3lGspvehMUCiCMOEpJKkR0XlkBh0n5ZgKzGQJgg=="
        }
    }

    EFGMITEMS["arc9_eft_mr155"] = {
        ["fullName"] = "MP-155 12ga semi-automatic shotgun",
        ["displayName"] = "MP-155",
        ["displayType"] = "Shotgun",
        ["weight"] = 3.4,
        ["value"] = 45000,
        ["levelReq"] = 4,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["equipSlot"] = WEAPONSLOTS.PRIMARY.ID,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/weapons/mr155.png", "smooth"),

        ["sizeX"] = 5,
        ["sizeY"] = 1,

        ["caliber"] = "12/70",
        ["ammoID"] = "efgm_ammo_12gauge",
        ["defAtts"] = "XQAAAQA+AQAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8NV9soxedGhWiR+Gfozfg60lFT777G0lvDHIXNd3q17CVbvQWfGkpYPyx7Q/ct964SG8bX1rGdig/ZJ/qAPGOBdvRCTIiOqlvQYFfoo555XMkHwZl1LjDxvh2iPxa38AAH41J0vXZifhs5l4Vdbnnc+E79nnVfQC+/Tca2",
        ["duelAtts"] = {
            "XQAAAQA+AQAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8NV9soxedGhWiR+Gfozfg60lFT777G0lvDHIXNd3q17CVbvQWfGkpYPyx7Q/ct964SG8bX1rGdig/ZJ/qAPGOBdvRCTIiOqlvQYFfoo555XMkHwZl1LjDxvh2iPxa38AAH41J0vXZifhs5l4Vdbnnc+E79nnVfQC+/Tca2",
            "XQAAAQCTAwAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8NV9soxedGhWiR+Gfozfg60lFT777G0lvDHIXNd3q17CVcQWfuk2x8Ld3xvVIDex3OOhkftcmGZ4VJMwvQGFiF8onPjffkwX3N8nI6mvrR6nktJ6uO/KiAJmq1bZxOtzVlMjxBukGnWM5g9UgNfVmqPfvr/pYW3I/WNH7cibK0q5g3+Z7FG1wR9oFl5qLpw2y0MEB1tu5owJWNuKMcm4Efp6TssMeSAr7O9gCwbcM180cFIYDcddtxG0SSptaGgGKb14/GqUwSAMqDLxuhd9GrnYX4rT7ip5TeEOU9NUNa7J/PCNsPVjcbMtSgiAA=",
            "XQAAAQC6AgAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8NV9soxedGhWiR+Gfozfg60lFT777G0lvDHIXNd3q17CVbvQWfGkpYPyx7Q/ct964SG89Nvvc4fWLJWoEZ0o43wN8FG9wAQ40LEF3cOXA14fXaYOrjH9J/54Tai9I3/rCrkLy7TbLX2O1jjpp92rstm4S4PjPNFa1YZZshhP9m0ZetT3M4zM99VN7fpomU8fTZbkRJ0IrTKsk8V2xGzVRaDVuOxFATgJfBsgNgTVNcdgnZnltdCeN0C1IlFP68EvzZgoUgIN3BWAA="
        }
    }

    EFGMITEMS["arc9_eft_mr43_sawedoff"] = {
        ["fullName"] = "MP-43 12ga sawed-off double-barrel shotgun",
        ["displayName"] = "MP-43 Sawed-off",
        ["displayType"] = "Shotgun",
        ["weight"] = 2.1,
        ["value"] = 19000,
        ["levelReq"] = 1,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["equipSlot"] = WEAPONSLOTS.HOLSTER.ID,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/weapons/mr43_sawedoff.png", "smooth"),

        ["sizeX"] = 3,
        ["sizeY"] = 1,

        ["caliber"] = "12/70",
        ["ammoID"] = "efgm_ammo_12gauge",
        ["defAtts"] = "XQAAAQCFAAAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8NV9tY8mxdjo2DonfYbDKLCbCIbLM3cKUS2n/zqm05+D37Ngjxrrie0dZPauCRtFna98ClsfTrXDgm4SYU6WFi4y8Lhhc7uOLu6w==",
        ["duelAtts"] = {
            "XQAAAQCFAAAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8NV9tY8mxdjo2DonfYbDKLCbCIbLM3cKUS2n/zqm05+D37Ngjxrrie0dZPauCRtFna98ClsfTrXDgm4SYU6WFi4y8Lhhc7uOLu6w==",
            "XQAAAQCLAAAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8NV9tY8mxdjo2DonfYbDKLCbCIbLM3cKUS2n/zqm05+D37Ngjxrrie0dZPauCR2SmPy17Qfdy8/LlpSYG12E65z8SeuWgKfuz0qtXhahfo",
            "XQAAAQCIAAAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8NV9tY8mxdjo2DonfYbDKLCbCIbLM3cKUS2n/zqm05+D37Ngjxrrie0dZPauCR3qDagO+KmbcJbAOG6ElwbFXzVtiZvi5Rmd+QWC94AA=="
        }
    }

    EFGMITEMS["arc9_eft_mr43"] = {
        ["fullName"] = "MP-43-1C 12ga double-barrel shotgun",
        ["displayName"] = "MP-43-1C",
        ["displayType"] = "Shotgun",
        ["weight"] = 3.6,
        ["value"] = 20000,
        ["levelReq"] = 1,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["equipSlot"] = WEAPONSLOTS.PRIMARY.ID,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/weapons/mr43.png", "smooth"),

        ["sizeX"] = 6,
        ["sizeY"] = 1,

        ["caliber"] = "12/70",
        ["ammoID"] = "efgm_ammo_12gauge",
        ["defAtts"] = "XQAAAQCYAAAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8NV9tY8mxdjo2DonfYuRH8meGEWV+yPXPsnXJtugMF/FY1SGQeBs3hw/sKrnsf0G5RjtwhndWjrRxVt/j+JZ6kyKzQG6lJyeUTkaA=",
        ["duelAtts"] = {
            "XQAAAQCYAAAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8NV9tY8mxdjo2DonfYuRH8meGEWV+yPXPsnXJtugMF/FY1SGQeBs3hw/sKrnsf0G5RjtwhndWjrRxVt/j+JZ6kyKzQG6lJyeUTkaA=",
            "XQAAAQCvAAAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8NV9tY8mxdjo2DonfYkpWLCbCIbLM3cKUS2n/zqm05+D37Ngjxrrie0cJqQzHM8xcRgEvb2pokdfjz38hJ99PR17W8xZxp3s9gRnzrJke9isIAGAA=",
            "XQAAAQCtAAAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8NV9tY8mxdjo2DonfYuVGKQ5tdx9kNKdFhDBXdnXGfsros258VVwNMle+tPwZzhM+QaLviJInR93yiKLzZedk1Y/Ohn+9+BALy+EUWlEDQOMA="
        }
    }

    EFGMITEMS["arc9_eft_aa12"] = {
        ["fullName"] = "MPS Auto Assault-12 Gen 1 12ga automatic shotgun",
        ["displayName"] = "AA-12",
        ["displayType"] = "Shotgun",
        ["weight"] = 5.0,
        ["value"] = 120000,
        ["levelReq"] = 30,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["equipSlot"] = WEAPONSLOTS.PRIMARY.ID,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/weapons/aa12.png", "smooth"),

        ["sizeX"] = 5,
        ["sizeY"] = 2,

        ["lootWeight"] = 75,

        ["caliber"] = "12/70",
        ["ammoID"] = "efgm_ammo_12gauge",
        ["defAtts"] = "XQAAAQDuAAAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8LcFEZt27uts1h9rv7GPLtHmlYv2Jo2nuh7ASujjecKKRJrBb423B5Rb+LCwMHmYzVDazfSYQvIVkx69fGD/hkToa/2CzZ878TuqbaYhkFofeMRzEdbKzxIHhUKn0rrlE3QNfG/wA=",
        ["duelAtts"] = {
            "XQAAAQDuAAAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8LcFEZt27uts1h9rv7GPLtHmlYv2Jo2nuh7ASujjecKKRJrBb423B5Rb+LCwMHmYzVDazfSYQvIVkx69fGD/hkToa/2CzZ878TuqbaYhkFofeMRzEdbKzxIHhUKn0rrlE3QNfG/wA=",
            "XQAAAQA1AQAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8LcFEZt27uts1h9rv7ts9X9wYmOSVlwDEWoLTujDfVNVAaiU0gp9fmKygwOmKkWY9S/MTq6lyUkE5+VMwg5IPe6rnFKI4gfMAtJL8gu+oRBRGDho2bWKWJdJrDsaxU3hwzpHbSo2m/7ZbXoHxTKBfit2BFYdyh7reCuoTPAA==",
            "XQAAAQDtAQAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8LcFEZt27uts1h9rv7uZ7Z46L7zwkuom9qcj98ytpcoXgGhNzOuW7+LHDsnXJSqGzE+7wN1F8nAMtR7FXRYTxUR7PpV/arcedN4x6CydKzIA4Xi3Hls0RHOKq+B84V0yHsMDDWR1Yrd9ic0p+TYVAx3R5MRBJmKEhU9kru3J1M/r/s2KYEc5OLNxSkCOg/6/UUjq7pnki2HahvuKcsNmUTAeJt4ou6cyLYTJ8A"
        }
    }

    EFGMITEMS["arc9_eft_mts255"] = {
        ["fullName"] = "MTs-255-12 12ga shotgun",
        ["displayName"] = "MTs-255-12",
        ["displayType"] = "Shotgun",
        ["weight"] = 4.2,
        ["value"] = 24000,
        ["levelReq"] = 1,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["equipSlot"] = WEAPONSLOTS.PRIMARY.ID,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/weapons/mts255.png", "smooth"),

        ["sizeX"] = 6,
        ["sizeY"] = 1,

        ["caliber"] = "12/70",
        ["ammoID"] = "efgm_ammo_12gauge",
        ["defAtts"] = "XQAAAQBoAQAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8NWBZxcXd4lgpEYOABEMGVgtCK/aSLEaxnwae0hch5Ptd1XInQcH+dbu9HJcNSDVgmdJVbNux7pih1EapIy244Q6vvsSvlwxOScXyS4yBYAD8Dee7noa5Q817A6O0TvIJgIUDC6yM2EQceVON8lWXSCFefVJB/ktJsloM=",
        ["duelAtts"] = {
            "XQAAAQBoAQAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8NWBZxcXd4lgpEYOABEMGVgtCK/aSLEaxnwae0hch5Ptd1XInQcH+dbu9HJcNSDVgmdJVbNux7pih1EapIy244Q6vvsSvlwxOScXyS4yBYAD8Dee7noa5Q817A6O0TvIJgIUDC6yM2EQceVON8lWXSCFefVJB/ktJsloM=",
            "XQAAAQCDAQAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8NWBZxcXd4lgpEYOABEMGVgtCK/aSLEaxnwae0hch5Ptd1XInQcH+dbu9HJcNSDX0jkmOB6LwQdTT0WY+2w7/P2C/LIzyaOmFjdaMWksE7QqCn+B4Emk24YtHRbDs0wYkN/YOt3nH011tevP6FRY9XUPHqjdw9g0bzGTWHOIbJ9bMPp5JTK3g2AA==",
            "XQAAAQCtAQAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8NWBZxcXd4lgpEYOABEMGVgtCK/aSLEaxnwae0hch5Ptd1XInQcH+dbu9HJcNSDX0jjZHo+74o02fbCh1DaLbw1MBoHgpSnFD09vWS4Q24p4Uf7dAxXnwwXeFl3y0yoZRi8ANsB9JZ4f+Ed/wGjflQVsEgirI6b+hur3UtcAgAB3SDUmNF49TfJjsgRZckRAA="
        }
    }

    EFGMITEMS["arc9_eft_m870"] = {
        ["fullName"] = "Remington Model 870 12ga pump-action shotgun",
        ["displayName"] = "M870",
        ["displayType"] = "Shotgun",
        ["weight"] = 3.1,
        ["value"] = 35000,
        ["levelReq"] = 12,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["equipSlot"] = WEAPONSLOTS.PRIMARY.ID,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/weapons/m870.png", "smooth"),

        ["sizeX"] = 5,
        ["sizeY"] = 1,

        ["caliber"] = "12/70",
        ["ammoID"] = "efgm_ammo_12gauge",
        ["defAtts"] = "XQAAAQBLAQAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8NUglz4qzXk+esKjOEbvYtjoW6dJrfCWOEsB7khQXO/X8w2x8X/CWqjxaOmmEQ56IXjItMHtn3T1YVFg4KDwe51dsSHW0bru0MlZLg/GlxF/Zvj07/T5iWe8gnctmBB24xvg4QQHazoufFdYXFyHnwx9QiFww3G+znn5a9N44=",
        ["duelAtts"] = {
            "XQAAAQBLAQAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8NUglz4qzXk+esKjOEbvYtjoW6dJrfCWOEsB7khQXO/X8w2x8X/CWqjxaOmmEQ56IXjItMHtn3T1YVFg4KDwe51dsSHW0bru0MlZLg/GlxF/Zvj07/T5iWe8gnctmBB24xvg4QQHazoufFdYXFyHnwx9QiFww3G+znn5a9N44=",
            "XQAAAQDsAgAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8NUglz4qzXk+esKjOEbvYtjoW6dJrfCWOEsB7khQXO/VkWzd8rKz7CKPZmgYj7Ul/BgS5/rD1UakOm5nJ5vgidIgakbmZg0m9VqbDLnBkIDy3cnapgG0Wtm+LGxqejCTNcHzDEeC/gYC5AIIJq8mIJSYIKXnCABe/iXZmGIFeBFZ2JLxFJVPVJXnzxuluh9+yNxQ8k8VbJ76r3r7PR6JsKS0LWYhuH6IcJi3I9qHnfWWNiGzk1Z/pYpp42J/BtGI573Fgo6FAutABraL53IrkzMmQe7p002awGnspWRJYtxvYA",
            "XQAAAQDJAgAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8NUglz4qzXk+esKjOEgFSqLPnjjuKuH9tNbNaP7sWuO1Ue7DDR/gk2yVuBRpICs30YE0BD6/xGQjLgl7xtBow3ljtrzs+I1gLfjR8I2g3PiHf7rhRkU1Eo4yGDMSXWZp8lDjLDFEIdC9FRLgLhFHCLWDiP9PLnh4qoLI5FHN2mY3UXnF9A8v0L8NhlQe+a7qbHIvfhWiTqGoPNk6lUQYrH8J2iiQX7AMiqUGsdFbZZ+Y4e3Twn/LL7gsZPib6KoOSzsvtBx7+vrYxA5kmIkMUvAQEA"
        }
    }

    EFGMITEMS["arc9_eft_saiga12fa"] = {
        ["fullName"] = "Saiga-12K 12ga automatic shotgun",
        ["displayName"] = "Saiga-12K FA",
        ["displayType"] = "Shotgun",
        ["weight"] = 5.6,
        ["value"] = 140000,
        ["levelReq"] = 36,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["equipSlot"] = WEAPONSLOTS.PRIMARY.ID,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/weapons/saiga12fa.png", "smooth"),

        ["sizeX"] = 6,
        ["sizeY"] = 2,

        ["lootWeight"] = 75,

        ["caliber"] = "12/70",
        ["ammoID"] = "efgm_ammo_12gauge",
        ["defAtts"] = "XQAAAQB4AwAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8NWDT+kEGPPXAnnu00OGUPFCojWFr8rsYIfBsTYl9178LFdS6tG1B2ZxwsgSbecQ/C3Meb3KSmwYqU2FIwUpWXOQ6H1K9jhG5VvQICUy6gbyLNJmr/IFwdX4ih0KRHToRvciL8+cMf+QnkIRcL7vxWrn7v7J9J2trJsMMUaUVqK1FxLSPMIoUKXdM1C6XlAM5BcgTs+8lOEc1SKDfArWDoNdia/mMoBNcruWFT1M13A87NU+/i1ihxE6rYH8qHJdWjvI5c0oWXqt9ncbNG+Au3mZCwxjDHdwbowTJPajaQS5rfgm5pQv4yE1VGUhiX8h05NWQJTFwlOxGHyc6OPxss+ipQzJMKOrpKt9bylJcCw27lvTslJxs56eYovlCXmJlhMzDnPaSArmoA",
        ["duelAtts"] = {
            "XQAAAQB4AwAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8NWDT+kEGPPXAnnu00OGUPFCojWFr8rsYIfBsTYl9178LFdS6tG1B2ZxwsgSbecQ/C3Meb3KSmwYqU2FIwUpWXOQ6H1K9jhG5VvQICUy6gbyLNJmr/IFwdX4ih0KRHToRvciL8+cMf+QnkIRcL7vxWrn7v7J9J2trJsMMUaUVqK1FxLSPMIoUKXdM1C6XlAM5BcgTs+8lOEc1SKDfArWDoNdia/mMoBNcruWFT1M13A87NU+/i1ihxE6rYH8qHJdWjvI5c0oWXqt9ncbNG+Au3mZCwxjDHdwbowTJPajaQS5rfgm5pQv4yE1VGUhiX8h05NWQJTFwlOxGHyc6OPxss+ipQzJMKOrpKt9bylJcCw27lvTslJxs56eYovlCXmJlhMzDnPaSArmoA",
            "XQAAAQDTAgAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8NWDT+kEGPPXAnnu0/mq58nMh2bQY89H0x80uWrd2ZK5H1YkT7xiV+5eAu6QHdhI/wr85wzs8t0WIq6ZPgJHvsjd6VZ2pXS2r11FYUKetpP9vagbahw0Cn++czB99r8m5kjxLHgjQGfzWgla9GloEIId6nrzXyyi4L4PSPEPNWRk9jXErSL0BixAduc0xZSUOSK+XrbgJC9PKUeBtmOWmWOrAOZ1I3CFGUMClqa9MM+XUbwLBFcFXn4rNcXwTNseAjQumdpyid0qUP54KVy/DwTMu86njZNUM87+isAjcCRz8VGEjKwm0Ps2OFjB30JzU7QmqCMbT+4USALA==",
            "XQAAAQBpBAAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8OSPTtC5Psez9ZTnS8YLQTM2ltmsJ2NHtb8I4jTTgElGJX1jRAbXyv4hjkQlMEOqhzRyz4DoyfaaAf12CcxNHIvKTt27/cNFnDek1h58dAusjyifDtLCr4wp8vnW+XwGciskybyQ96CyPF4mxFwyGuP4PZz5HyejFS1PjjJ7oTpVmfWGpjcReA+yblDWE0heZjrdScUccIxqIP8tWlespTB+yisKWj8ZNRKJQVhQicIwSwRjwyeEXHH6xlGOC5zkJ0PzGhXBUqRPyGhN5xqzNwaxNb+qgD1UJIITxKGkOvr+FuyORkhYLEZ5cShd/70WNafRvrCjoHThp5N6vCocj/kfatGx/Y2Z15sBughRB2EThb2eNvl1rrg3jNF+rqs7x1rgoiQb0R5sm7bfUf9dsgttcaGp5tb40SuwWG0n65UOOFy200ng=="
        }
    }

    EFGMITEMS["arc9_eft_saiga12k"] = {
        ["fullName"] = "Saiga-12K ver.10 12ga semi-automatic shotgun",
        ["displayName"] = "Saiga-12K",
        ["displayType"] = "Shotgun",
        ["weight"] = 3.6,
        ["value"] = 40000,
        ["levelReq"] = 10,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["equipSlot"] = WEAPONSLOTS.PRIMARY.ID,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/weapons/saiga12k.png", "smooth"),

        ["sizeX"] = 5,
        ["sizeY"] = 2,

        ["caliber"] = "12/70",
        ["ammoID"] = "efgm_ammo_12gauge",
        ["defAtts"] = "XQAAAQD2AQAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8OSPTtC5Psez9ZTnS8YLQTM2ltmsJ2NHtb8I4jTTgElGJX1jRCeY3UByXmTpt6X9CGQvKIFNVGbhmZnMvU5UDKxjByS8kDpBAffIAeSK8fVDHWQSh9hChsuIyWKHpPytQJmI84QcinH/JolfNyzbUk19Xe1t6KYvWVoGRbyhy1tGTFGz/1BH8vIIhUosjdyhQiuNyKXiR7/xTwaS3PTkg6ogeUry0oTpcA",
        ["duelAtts"] = {
            "XQAAAQD2AQAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8OSPTtC5Psez9ZTnS8YLQTM2ltmsJ2NHtb8I4jTTgElGJX1jRCeY3UByXmTpt6X9CGQvKIFNVGbhmZnMvU5UDKxjByS8kDpBAffIAeSK8fVDHWQSh9hChsuIyWKHpPytQJmI84QcinH/JolfNyzbUk19Xe1t6KYvWVoGRbyhy1tGTFGz/1BH8vIIhUosjdyhQiuNyKXiR7/xTwaS3PTkg6ogeUry0oTpcA",
            "XQAAAQDJAgAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8NWDT+kEGPPXAnnu1b6vzh1OwKssR3FEEnP7m2voYKdJ/9AsXdIfWKaAVqU5edNz0Uhvs67dwnBgG/fPUgKwmoY53pFjam8LMsI46SRclcXUqb+YnFofn/V3NOPmnggNi6ZHQ/qhjcuNXxDVP7rqRH/kbcCNEQVGdbhmy4R9MgEfsMcSu8fKhQ2QbA98cjRF6d6/euabgqpSdnd0aNwcfiOqi+6BxJAPRk2Uf3W+aC47aZ4NGzGz5Gu6kbzru9T2rw4lMFSBNTB+sTP/FV6g8MSDEXnSWLHP1Mf97D0iVJoUDHCb2vD5LnfGwSHgrh7ximmQjFR1YccNH9AA==",
            "XQAAAQBiAwAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8OSPTtC5Psez9ZTnS8YLQTM2ltmsJ2NHtb8I4jTTgElGJX1jQ4ZT31zvGZUlH6rE6ojifD8uILMuVdqGyTuh5o1If/OXP1bhKU5Yq91/Eqw+t9wrGLCo3UTw7XnXXUtSVa3nxPE5WerpA9c9RYzwHGqCTo+j4t8Q+20Zb1+A6/L4q3PHxoANwK0bIbDrzrRsRNy+oEvkxLc4L3KCDpksLDSq9ufPDm/NH346Nsh5v9OmqrJ1y9Emg8rnAafCbIFrTPU0grEPDtA3lqQONgv7Gh7Yx+Q2W69vlWbJX45j5AQk0fPtwMoZ50H8wve/i1xVZ0AGLqK5mgJQoZ1v26QGbafz1qPskiwMytbmyywe0nMSfzt9A="
        }
    }

    EFGMITEMS["arc9_eft_ks23"] = {
        ["fullName"] = "TOZ KS-23M 23x75mm pump-action shotgun",
        ["displayName"] = "KS-23M",
        ["displayType"] = "Shotgun",
        ["weight"] = 3.8,
        ["value"] = 75000,
        ["levelReq"] = 31,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["equipSlot"] = WEAPONSLOTS.PRIMARY.ID,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/weapons/ks23.png", "smooth"),

        ["sizeX"] = 6,
        ["sizeY"] = 1,

        ["canPurchase"] = false,
        ["lootWeight"] = 75,

        ["caliber"] = "23x75",
        ["ammoID"] = "efgm_ammo_4gauge",
        ["defAtts"] = "XQAAAQAYAQAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8NBwAdi2xdjoyRPEwHyL9ndUw3Qf4JJVzUDILPXYi0ZSvk6zeiSBatUDV6mIl5YsUsk5YzqiQoidcyuB0VRdj0VBjkk9xiNowuHAQHOew9TZrAo77PynKhjolR0ippc3hLpRsDgfcJ0YoHXNA=",
        ["duelAtts"] = {
            "XQAAAQAYAQAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8NBwAdi2xdjoyRPEwHyL9ndUw3Qf4JJVzUDILPXYi0ZSvk6zeiSBatUDV6mIl5YsUsk5YzqiQoidcyuB0VRdj0VBjkk9xiNowuHAQHOew9TZrAo77PynKhjolR0ippc3hLpRsDgfcJ0YoHXNA=",
            "XQAAAQB7AQAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8NBwAdi2xdjoyRPEwHptKq+pCwem1kAYj29FxlfY7hUgY5LDaIDaGlIrQicHQW9kGdrlL+vcsSSLqdS5SCnUa/lE3Aac5F2uTNRznlXL7DmGlRAIjSGauRJmpwApTQXmcsyt+72NzC/T+BlYytAAZ0zB6TuqPO9Dn63jsBwLSUg1oXMSyCweK5cHjC",
            "XQAAAQAuAQAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8NBwAdi2xdjoyRPEwHyL9ndUw3Qf4JJVzUDILPXYi0ZSvk6zeiSBatUDV6mIl5YsUsk5YzqiQoidf/4UXaouiWxAcwoSZnSMDZjaYAdXFHAA02nsdiWGPpJQJpTS7Gb1TWQPbm2yqfzsFE/DCE/eBjISWYqg=="
        }
    }

    EFGMITEMS["arc9_eft_toz106"] = {
        ["fullName"] = "TOZ-106 20ga bolt-action shotgun",
        ["displayName"] = "TOZ-106",
        ["displayType"] = "Shotgun",
        ["weight"] = 2.7,
        ["value"] = 17000,
        ["levelReq"] = 1,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["equipSlot"] = WEAPONSLOTS.PRIMARY.ID,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/weapons/toz106.png", "smooth"),

        ["sizeX"] = 4,
        ["sizeY"] = 1,

        ["caliber"] = "20/70",
        ["ammoID"] = "efgm_ammo_20gauge",
        ["defAtts"] = "XQAAAQD+AAAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8NVhYAGVeSOkq5ioj8jMxwGGwTsYJMDWKx/nbgAnY9n5tQLn+yaXuDFCl3lEI+VyTEauuBOLYO4n+5q0sQC4B4Sjo09VUcbtNDl5o5r11sKBBTpJ3ITsV0vDiebHG+CokOLec/1PxJDlymrw==",
        ["duelAtts"] = {
            "XQAAAQD+AAAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8NVhYAGVeSOkq5ioj8jMxwGGwTsYJMDWKx/nbgAnY9n5tQLn+yaXuDFCl3lEI+VyTEauuBOLYO4n+5q0sQC4B4Sjo09VUcbtNDl5o5r11sKBBTpJ3ITsV0vDiebHG+CokOLec/1PxJDlymrw==",
            "XQAAAQAYAQAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8NVhYAGVeSOkq5ioj+x+BwGGwTsYJMDWKx/nbgAnY9n5tQLn+x/HYyDbtjM+Mu5xLt6sMhO8ERjdz22YmHa9+vF4KPzGg67Vs2hY8l2+5m2NFqgc7Oudl5qXlAineSDHtuTSYqDfZ+8nbOUu3jjusAiRTYkOFs",
            "XQAAAQBgAQAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8NVhYAGVeSOkq5ioj/5WhwGGwTsYJMDWKx/nbgAnY9n5tQLn+x/HYyDbtjNEPduTcgYONf/VgE1MzIJROa635c3pSGCTEt5CZFxqfkSaxFK+ySndC9enZ79E0CmWMT9E6vmFmYI3U/c0TB+awkgxuD4pacurafbTCDJLwaNc6Q2FWyAA=="
        }
    }

    -- sniper rifles/marksman rifles
    EFGMITEMS["arc9_eft_ai_axmc"] = {
        ["fullName"] = "Accuracy International AXMC .338 LM bolt-action sniper rifle",
        ["displayName"] = "AI AXMC",
        ["displayType"] = "Sniper Rifle",
        ["weight"] = 5.7,
        ["value"] = 270000,
        ["levelReq"] = 45,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["equipSlot"] = WEAPONSLOTS.PRIMARY.ID,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/weapons/axmc.png", "smooth"),

        ["sizeX"] = 5,
        ["sizeY"] = 2,

        ["canPurchase"] = false,
        ["lootWeight"] = 40,

        ["caliber"] = ".338",
        ["ammoID"] = "efgm_ammo_338",
        ["defAtts"] = "XQAAAQDhAwAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8LcsYCbthEf9oFSoSxAkrJ5MHEtbkpwPQvQB1xFtCyk1QLE+imKyPumFPHpcXKuIe+j4b3sDvYqfe7IxMhskP2yHt/GS6VwCdLv1JnbWDvOkzqVT0vfDRHIIBDfbBCeWE8UAItC5RpezcbUMzJe3DEJiZN6RO2H0yuwdj5fc6uqC17vEP2AFNDhK/TKz9ahfIuuo8wZ77EN1GK2LnmvIDyXyP4GEUWCnMW227BnoYs50TuigRg/r1bitCvXeRVhepEt2M/Wg==",
        ["duelAtts"] = {
            "XQAAAQASBAAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8LcsYCbthEf9oFSoSxAkrJ5MHEtbkpwPQvQB1xFtCyk1QLE+imKyPumFPHpcXKuIe+j4b3sDvYqfe7IxMhskP2yHt/GS6VwCdLv1JnbWDvOkzqVT0vfDRHIIBDfbBCeWE8UAItC5RpezcbUMzJe28YU0xgjDFWbExm2u/gb9U/wevno60RRm+ZJBC5NZv+cR1z5nzlmvFbVzkYxg63fxY+NhWBlpjeWfSTIO++jiNhCifU6ensxTngEFH1RzN711tW8p/u2xq/rbSUd/eQ1VVbmK9u7TWI",
            "XQAAAQA1BAAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8LcsYCbthEf9oFSoSxAkrJ5MHEtbkpwPQvQB1xFtCyk1QLE+imKyPumFPHpcXKuIe+j4b3sDvYqfe7IxMhskP2yHt/GS6VwCdLv1JnbWDvOkzqVT0vfDRHIIBDfbBCeWE8UAItC5RpezcbUMzJe3AFnpYnw44e0qAkoHrd3XzcghU9YIJPUs+hVRyiLOLFcklIZFFyRLGQw6s5UZkrPw3px8GAdz7kjHV6vRZWGLGYxEc9xXhEtAb7L7+0ZoSLMVq1VhvqhABAlru18JdFq9YZUAWzZkWralkREtaXGcQSYoRC1Ig=",
            "XQAAAQD5AwAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8LcsYCbthEf9oFSoSxAkrJ5MHEtbkpwPQvQB1xFtCyk1QLE+imKyPumFPHpcXKskJhSCMU0JkhZtWxnt7In3Mt16embJ/H1PXFVaAtOlFkX1OBS6xSKmVWLrM8SFcwUuAnEN13Xr5qQutKb4m0rfdupG94wNSHrBLX7mXvxMFsaPO6qKpv5WpmfzdFWEuP5sjm9VM9O9wjxvZ8XbCBczcF42m2IKk5xFvZCSwILv8XZZTexHPNpjCeod8nsOjARLz0lbu+Ot2DssoO5mET7yXmP2pihCIn6IU1Wvs5giwewZ8ZLAtf+r0fB+jfgA=="
        }
    }

        EFGMITEMS["arc9_eft_ak50"] = {
        ["fullName"] = "AK-50 .50 BMG sniper rifle",
        ["displayName"] = "AK-50",
        ["displayType"] = "Sniper Rifle",
        ["weight"] = 12.8,
        ["value"] = 600000,
        ["levelReq"] = 48,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["equipSlot"] = WEAPONSLOTS.PRIMARY.ID,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/weapons/ak50.png", "smooth"),

        ["sizeX"] = 7,
        ["sizeY"] = 2,

        ["canPurchase"] = false,
        ["lootWeight"] = 25,

        ["caliber"] = ".50 BMG",
        ["ammoID"] = "efgm_ammo_50bmg",
        ["defAtts"] = "XQAAAQAJAgAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8MZPzvHDqVW9Zr+l1XqbTku0XrI40dVyapGHi+sNSHLbu8NvEE+5m/7y1Uc3pCqoaAsC9b1LCp3S5vzlKWdbSHnSMBTjM4TqruOeDpGWYwCaEEuqRZtK1OS0OmXLEYJEDTDufsiz9zMrLV4gApem0FhjHku3hIRvpAKQj03bppFtFbgk+LHUc9gyCB",
        ["duelAtts"] = {
            "XQAAAQA8AgAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8MZPzvHDqVW9Zr+l1XqbTku0XrI40dVyapGHi+sNSHLbu8NvEE+5m/7y1Uc3pCqoaAsC9b1LCp3S5Txn8NjJYH/6pQXKDLp6jucIbFAcmLjPE3b7aW6sgZznpX0Zh+SG1Rr8j5KkZwMJuDKYK3pxdQLGwisbbonodoVI57Hj8e6+1WOaQF7I/0GIzcd/8WZOMuv1EZeJqxu4k+vZ8/HW1/Qj1MTQ==",
            "XQAAAQB3AgAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8MZPzvHDqVW9Zr+l1XqbTku0XrI40dVyapGHi+sNSHLbu8NvEE+5m/7y1Uc3pCqoaAsC9b1LCp3S5vismXf9ofdl7aRaqslHmhDr9zAlS9nSaPhuJy8YoAonhtSnNisGuBejm8wpU5RMbVC/KQLgeZu98Tz3zKZZySwH/Kl23HwjESn6xPeEtHtqdkppYkUP3hRGRL9Y/LVeD2sfyuQzh1KNDWPx0rHjr1t+00LwA=",
            "XQAAAQBEBAAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8OSy5Op230jtwEtUV0UKHHWN3OucipFH8cqbbG6LM9wn2Ic03eay8/MtpQAzEww8TJuiF+BkFhbTedREgci2VUoPv4SlRZKMVzdXQlsFZLtEC7vYq/LTVQRyboacZkuMU1jglR93aXXM3qb/efIyE7Vpl0SLEQVIVINEXcZud0GdCY7TvESkI+wDEfw29IbOC1O+s9AutCsbsHwS1dExe6scS8bDwKgj0VQ5z4PrtiMEqPq7dEC1KWHSpHmJKHJAPhyGWGL9HRWqFpg4GzyKOLMDrzMybGgZE6g0Rf+v1PkIZFAO6B7tJw30/89FpVIw1UBoXhY8GnqL0K8yI="
        }
    }

    EFGMITEMS["arc9_eft_g28"] = {
        ["fullName"] = "HK G28 7.62x51 marksman rifle",
        ["displayName"] = "G28",
        ["displayType"] = "Marksman Rifle",
        ["weight"] = 5.4,
        ["value"] = 210000,
        ["levelReq"] = 36,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["equipSlot"] = WEAPONSLOTS.PRIMARY.ID,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/weapons/g28.png", "smooth"),

        ["sizeX"] = 6,
        ["sizeY"] = 3,

        ["lootWeight"] = 65,

        ["caliber"] = "7.62x51",
        ["ammoID"] = "efgm_ammo_762x51",
        ["defAtts"] = "XQAAAQAsBAAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8Lchzpvw0LefC8hu4+7dXYbNKzz014YolWmVqMYRuK5YCam2fgKlEcPvm+rzjsun8OdBpgt/uNSe/ayL7WJrLzw6FF1DHgRU/lqG3hEf61nWTu+CPJYddv3r4ez8tOMz+eOV8+mkLKbetrK2wKBNbLmPmSyVdJEyIH9VwuPJNniIkCb8dFC43uVgLlR6InZkEkfTCj1y2lg2ed0HeuCRQGVwiDp8GKbjgBp0Xd7vFbiW1eSlLF9oUcCdJWeDBTZ51Iiwu/AT9Bm2VOLM89IekkmaqlaLsx6VnaSyM1tAXeP+1R4HH1VlZu7N1MvD8m7XcnMuR4kyRw7CouhSNNSjZMvLWI1QP2JMaWgziL8H1MxqJv",
        ["duelAtts"] = {
            "XQAAAQAsBAAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8Lchzpvw0LefC8hu4+7dXYbNKzz014YolWmVqMYRuK5YCam2fgKlEcPvm+rzjsun8OdBpgt/uNSe/ayL7WJrLzw6FF1DHgRU/lqG3hEf61nWTu+CPJYddv3r4ez8tOMz+eOV8+mkLKbetrK2wKBNbLmPmSyVdJEyIH9VwuPJNniIkCb8dFC43uVgLlR6InZkEkfTCj1y2lg2ed0HeuCRQGVwiDp8GKbjgBp0Xd7vFbiW1eSlLF9oUcCdJWeDBTZ51Iiwu/AT9Bm2VOLM89IekkmaqlaLsx6VnaSyM1tAXeP+1R4HH1VlZu7N1MvD8m7XcnMuR4kyRw7CouhSNNSjZMvLWI1QP2JMaWgziL8H1MxqJv",
            "XQAAAQBIAwAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8Lchzpvw0LefC8fUEuTRQwP6//dApjvK/cbUeClKyPdssEEGPkHgurZaePz8ciu/hI0myIShnD554tAg6AZ3DtTV1mCPkVaMZDHwngUJ/UqbMNNflcWnWX/zYwjcwi8+YRRO0NnExb0L3VMnmZPqaMPHzyfVSNJf4qljpKcD2iz4XMWMjkrlF8aVuNcwWDC8Qy7tIFJAjTJ+4hrlQi9SmcglwG//EXxkPs6obfd740Dak8lXKmpNk/7uiIM7M3+lARyWDZOGlsxvcyBzAnxHiJmYgWmSjRZmvChOifzeMFXAwAHjSweAA=",
            "XQAAAQCMAwAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8Lchzpvw0LefC8dSpQqrEI9a4p+RnhtB3YfFUppEzXG/Vl4ey+2Bloq0s+BkETEg3yvLiTqLQc7qxU2lvEYRNuHwptWqjaIb9/7YDu4bpiY9+jPGq5VPGUd3Yjr+LxDTm/TrsO7aEXxXVcCJsvTtfa27sJLgTtXnOLWAq2FwKGjaGxTv3VU0E9+Q6jrDWeQHQWiIK5vRoFAzhPM3dP7oowahQPQ/yP8gdWTBp5QZQNE8z45KWykawXSXYdZGU6yV2ojitPmFmKUXpCDUJnV5KyNUKysFVkUv6ODrT+lVz6qVSgcIW20qS5CT6CkbKTnatSs87v6wA="
        }
    }

    EFGMITEMS["arc9_eft_sr25"] = {
        ["fullName"] = "Knight's Armament Company SR-25 7.62x51 marksman rifle",
        ["displayName"] = "SR-25",
        ["displayType"] = "Marksman Rifle",
        ["weight"] = 3.8,
        ["value"] = 120000,
        ["levelReq"] = 26,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["equipSlot"] = WEAPONSLOTS.PRIMARY.ID,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/weapons/sr25.png", "smooth"),

        ["sizeX"] = 5,
        ["sizeY"] = 2,

        ["caliber"] = "7.62x51",
        ["ammoID"] = "efgm_ammo_762x51",
        ["defAtts"] = "XQAAAQBaAwAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8Lchzpvw0LefC8cKmSsx2FONi6w2fdtBqbRE9Vb00gVDviwUYh2V4s4R3AT9EDGmFdHaCJ9XkU0X5rNKcaJfu+dFjahOnSsKR+r1GtBTDV9nhVaB6IZCnaPlFxePEyr7gw2YsmwtbO1jtTOy3Izs1eW6OnFHWEi1Gx4NL0RV/JYLC6/12Om2Pxsy2sEcHlJeHOH6SIu7l82AwRplvdv5FHtu5OTZec8R/DU65bOZk+53V2JpJF1VYxq8NwaI5LOx70PMrXS5yu8JgKsBwt63I6Vx4fMb30obWeBJzYHXtmXRMuiU/10IpWY+vnH1xIpAVOb5TA",
        ["duelAtts"] = {
            "XQAAAQBaAwAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8Lchzpvw0LefC8cKmSsx2FONi6w2fdtBqbRE9Vb00gVDviwUYh2V4s4R3AT9EDGmFdHaCJ9XkU0X5rNKcaJfu+dFjahOnSsKR+r1GtBTDV9nhVaB6IZCnaPlFxePEyr7gw2YsmwtbO1jtTOy3Izs1eW6OnFHWEi1Gx4NL0RV/JYLC6/12Om2Pxsy2sEcHlJeHOH6SIu7l82AwRplvdv5FHtu5OTZec8R/DU65bOZk+53V2JpJF1VYxq8NwaI5LOx70PMrXS5yu8JgKsBwt63I6Vx4fMb30obWeBJzYHXtmXRMuiU/10IpWY+vnH1xIpAVOb5TA",
            "XQAAAQCcBAAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8Lchzpvw0LefLbRq5NodydVADfSzTVRjhGwpfvaoULwzeKtXIcAAfjIMRbTLeeM5sJY7GC1k9QYJIbdc0rFjaK8dJX/7Gc+1+0wJvV/xZftqJ94gAalhJBJmKbwjQYEho6sX//hWmUK41RDYSksbedV7PsgLVmCI3L77Diz3AyYf1PYjWF9s6PakIgnK4/DmHI10mLGK6A7Dd+LUgV2c1JCkHaTWgzPAWwrw2yZ8W8ptqU3HgPj73F/9Gcl6PfGwP1JEzeBEuIY+40hRvhhA5rGB0Ak4SH83hXE0fc5g5vueZrkyAZ340my9vl1xpBltOlXg5RAQAcfQC3FkAebkb3qlIMqMG/iUFBZG2deSJaU7haeAGZ5VgpjKMD7tOlkeAjGZJDdo4DxIq4QqAr+QRUJkC8zDkWDrWTr/BijMihfiPbmmoJEfEXe1Dj2QBo1El30OKTynrCAA==",
            "XQAAAQCWAwAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8Lchzpvw0LefC8cKmSsx2FONi6w2fdtBqbRE9Vb00gVDviwUYh2V4s4R3AT9EDGmFdHaCJ9XkU0X5rNKcaJfu+dFjahOnSsKR+r1GtBTDV9nhVaB6IZCnaPlFxePEyr7gw2YsmwtbO1jtTOy3Izs1eW50GEJMy8WIHADzNCpRi6SEIGJqHKPxx3ULVjRsI4WiIDOjEfxDw4203pveJYbPUXpCGshQsbbkjeImGBALyt0dNU1E6BuvpIxV20RfJgNBvPgABH7MpZLlVdNg1uz6djZ1FIi1boch/Zbrnj6WGmxRvUnjCp2DOnKme4RRRwVV6cEfU4RByJjq8WZRsKpxY3C7e1lzC7i1mCdDXs648XBEVPA=="
        }
    }

    EFGMITEMS["arc9_eft_dvl10"] = {
        ["fullName"] = "Lobaev Arms DVL-10 7.62x51 bolt-action sniper rifle",
        ["displayName"] = "DVL-10",
        ["displayType"] = "Sniper Rifle",
        ["weight"] = 5.0,
        ["value"] = 150000,
        ["levelReq"] = 28,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["equipSlot"] = WEAPONSLOTS.PRIMARY.ID,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/weapons/dvl.png", "smooth"),

        ["sizeX"] = 5,
        ["sizeY"] = 2,

        ["lootWeight"] = 75,

        ["caliber"] = "7.62x51",
        ["ammoID"] = "efgm_ammo_762x51",
        ["defAtts"] = "XQAAAQCKAQAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8L6/0wnr/Jsa1p1kHyfvXikOJS7PNC7qaXt4+w3qSztc3+cFQrBWa+C57ISiJHQGQP8/jtqaT4Ps7YabTcGDFQZbKeE7+q+jP4p/y+1HWCJQ1+yUopZIsi7MgifhFwXRiugBfSx/+G1bRwBjHcYWTFVatptm2ErIrcX1G4pKoVaJpkjG4B///SSYIsBbVA",
        ["duelAtts"] = {
            "XQAAAQDPAQAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8L6/0wnr/Jsa1p1kHyfvXikOJS7PNC7qaXt4+w3qSztc3+cFQrBWa+C57ISiJHQGQP8/jtqaT4Ps7YabTcGDFQZbKeE7+q+jP4p/y+1HWCJQ1+yUopZIuaMnDKcnZKoVLngqtXvRkNPyVlatMYp+gYHnPxEGal4zfAfsgzGqmKTfrw3R8ukBglMW7cEQGM2ZJSlp71KpHPfpa4oA==",
            "XQAAAQClAQAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8L6/0wnr/Jsa1p1kHyfvXkjj0kodlUtMYcOfYnzMc2iKb3U3KJo+nPdch/AoQfXnFzlhZIUZkdQpsvekFrKuvBvzK9y9SwRii201MeisQqiPc7TyU44/orrzuEEE1VAv2faZE5rDXlGe4vUVN7SpRe06jyWBmiAATzPw8r9/r+0SPprqOe6s87vZCTId6He2MoLTws8x2hRn892Ug5C77y",
            "XQAAAQDHAQAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8L6/0wnr/Jsa1p1kHyfvXkjj0kodlUtMYcOfYnzMc2iKb3U3KJo+nPdch/AoQfXnFzlhZIUZkdQpsvekFrKnDq+lV8aVVsrLgKUlLfI+96rXLNXnbMhpC3z/VtdfnFKg1g7bccv4Z1S5yKLKaFOlW4JOwnHWfYA4sTpbBsRftb6aF6XWjRCshKuial5Yqk0QCYZlj3B/GuECNz3JHO/vAP7K2Wvw10yi86nY16"
        }
    }

    EFGMITEMS["arc9_eft_mk18_mjolnir"] = {
        ["fullName"] = "SWORD International Mk-18 .338 LM marksman rifle",
        ["displayName"] = "Mk-18 Mjölnir",
        ["displayType"] = "Marksman Rifle",
        ["weight"] = 6.5,
        ["value"] = 330000,
        ["levelReq"] = 48,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["equipSlot"] = WEAPONSLOTS.PRIMARY.ID,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/weapons/mk18_mjolnir.png", "smooth"),

        ["sizeX"] = 6,
        ["sizeY"] = 2,

        ["lootWeight"] = 35,

        ["canPurchase"] = false,

        ["caliber"] = ".338",
        ["ammoID"] = "efgm_ammo_338",
        ["defAtts"] = "XQAAAQCsAgAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8Lchzpvw0LefC8hv59A4CQeaGlaPJjqs5VnIN0AFBsBso51IxEtxO+V9oImpdKBMLjMp8B1B8RQhyHZ0PAZ8l5m1PkQ4B4+g8NbgGo+77Q7nIEw5n8PxyZk2bq8VQZFHgqL83a3jATxjootibVO+Co4a5GqaCilhv8mnFlKlMU+FCT/yClCvHu+/ewsG0r7FcNExntkZXr6hfanCTwIRjD+EFEwMh0XXdqLeea0UY1l7wwrTswFUz+",
        ["duelAtts"] = {
            "XQAAAQCsAgAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8Lchzpvw0LefC8hv59A4CQeaGlaPJjqs5VnIN0AFBsBso51IxEtxO+V9oImpdKBMLjMp8B1B8RQhyHZ0PAZ8l5m1PkQ4B4+g8NbgGo+77Q7nIEw5n8PxyZk2bq8VQZFHgqL83a3jATxjootibVO+Co4a5GqaCilhv8mnFlKlMU+FCT/yClCvHu+/ewsG0r7FcNExntkZXr6hfanCTwIRjD+EFEwMh0XXdqLeea0UY1l7wwrTswFUz+",
            "XQAAAQDrAwAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8Lchzpvw0LefDAdeOPyJUtGKkHRzobk5/psrcz4N0oG+L2KbxBmQ9DJTSN8PFm8PZmaeWMZOl8cbQuzlSdJzSwrbqM7S9DBwR5fCYtGs9hTCf0Tl0v1BLTacZ3a0Kw0qBqSAARgqKTnBldgJSZh6EHlIAy2LQtCi6PaYuTW7Gys0+yw90rmb9nbysmejZINhuCiSKlAlrncO3Ao8pRHpRPy8c8hRGthXyCILqjHVBGij7IVxhfq077Yki44I2ROGnYN3ucs2zFWwV9zcj3FS0OdKeCIJic0W1Pd65OMc5SiqHUFNG596fankr6w2kBsn11O+bWLrwNZy1f7e99WWhmUbGTs7fFbT1yZhs1GpKkUMiXzTu/rWYA",
            "XQAAAQD3AwAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8Lchzpvw0LefC8fUEtghrfk+hLFpBm19wUbqdE2VZMry1TEhbdxKtV0+Lh+gb93E05bt3sVUFKIba4QysbWDSQWB2PjaakFe/kbzRp6e4WPmjR2tO3bBLhfFdxQWsAF3F2MPLpSM9Ez3dIXo9SfHW21qbMCS1QtZabYULx8kT54LMThuWkndV055w0QnhEGEbVf5xd9PEWLqkics8dVs9fmN8wJStylqfNThsGZJ498mV4lzo3ihsEiHQsBdi3OGIOMieN2kG/nAy9fp8eSC6cC0jP06E3+Zi90XHLaOY2qXuKSE9drnjb/c2yjhu8yqrGDrEqitm+VPAUCgvyV0jEhNYwKX7db7naRjFtU2OtEVX2hcUe7nfHgWqQ8jOS"
        }
    }

    EFGMITEMS["arc9_eft_mosin_infantry"] = {
        ["fullName"] = "Mosin 7.62x54R bolt-action rifle (Infantry)",
        ["displayName"] = "Mosin Infantry",
        ["displayType"] = "Sniper Rifle",
        ["weight"] = 4.8,
        ["value"] = 38000,
        ["levelReq"] = 1,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["equipSlot"] = WEAPONSLOTS.PRIMARY.ID,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/weapons/mosin_infantry.png", "smooth"),

        ["sizeX"] = 6,
        ["sizeY"] = 1,

        ["caliber"] = "7.62x54",
        ["ammoID"] = "efgm_ammo_762x54",
        ["defAtts"] = "XQAAAQBmAQAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8NV4+pY+0XkZKHWxkZKCKF0+Ob5fNs3s5OFKWT+HASlx6CN4+PJGFPkL3i5sLLz+TOvImFE2UK7JKi1QOyK1JJP3tN/dQxofSuCMLUjYAvvlOko63tO1HwDkD4IoUYtSvcGXUy5gvrkEDaCMnpVA==",
        ["duelAtts"] = {
            "XQAAAQBmAQAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8NV4+pY+0XkZKHWxkZKCKF0+Ob5fNs3s5OFKWT+HASlx6CN4+PJGFPkL3i5sLLz+TOvImFE2UK7JKi1QOyK1JJP3tN/dQxofSuCMLUjYAvvlOko63tO1HwDkD4IoUYtSvcGXUy5gvrkEDaCMnpVA==",
            "XQAAAQAuAQAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8NV4+pY+0XkZKHWxkZKAhCBv+b5fNs3s5OFKWT+HASlx6CN4+PJGFPkFXYNn3M/60zKLcFSWviKJ88AbbHFhmcMHG3tbipY+cpN7b4esHToYHWGLFz8Clcb6tWZwWyE0xSv7aFkpv1XndujBJYsLQo3QKHYw==",
            "XQAAAQBZAQAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8NV4+pY+0XkZKHWxkZKBf7IGu2lWGmK/HocBlnLH+8/bGsx5ZKW0ap1fFZq537VY9Zdq8whBURrTfQcry4FTBj8EkSDfHgNhVk2MgWlgxl/STGJfjdwY+9iXvyairf4Ol1E4chifa94EaUo7pJENwgQcS7ujBwPFvP/9vupM8Gtg=="
        }
    }

    EFGMITEMS["arc9_eft_mosin_sniper"] = {
        ["fullName"] = "Mosin 7.62x54R bolt-action rifle (Sniper)",
        ["displayName"] = "Mosin Sniper",
        ["displayType"] = "Sniper Rifle",
        ["weight"] = 4.8,
        ["value"] = 44000,
        ["levelReq"] = 4,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["equipSlot"] = WEAPONSLOTS.PRIMARY.ID,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/weapons/mosin_sniper.png", "smooth"),

        ["sizeX"] = 6,
        ["sizeY"] = 1,

        ["caliber"] = "7.62x54",
        ["ammoID"] = "efgm_ammo_762x54",
        ["defAtts"] = "XQAAAQBmAQAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8NV4+pY+0XkZKHWxkZKCKF0+Ob5fNs3s5OFKWT+HASlx6CN4+PJGFPkL3i5sLLz+TOvImFE2UK7JKi1QOyK1JJP3vegGGaON+2VPul/8++WqyUZNeaa6DChd06BdK8dCBUUYi/z5yiDWpIYeeA",
        ["duelAtts"] = {
            "XQAAAQBmAQAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8NV4+pY+0XkZKHWxkZKCKF0+Ob5fNs3s5OFKWT+HASlx6CN4+PJGFPkL3i5sLLz+TOvImFE2UK7JKi1QOyK1JJP3vegGGaON+2VPul/8++WqyUZNeaa6DChd06BdK8dCBUUYi/z5yiDWpIYeeA",
            "XQAAAQAFAgAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8NV4+pY+0XkZKHWxkZKCKF0+Ob5fNs3s5OFKWT+HASlx6CN4+PJGFPkL3i5sLLz+TOvImFE2UK7JKi1QOyK1JJP3vegGGaON+2VPul/8++Wqx9hst5jXl1HwfEXbZrtPBcOmFxktp4YaxyzxZh2WJ6on06Eml+fTHIL80GqdpACZhTYgTmBHnMXqqNTwES6svKBj8A",
            "XQAAAQAkAgAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8NV4+pY+0XkZKHWxkZKCKF0+Ob5fNs3s5OFKWT+HASlx58EPoUAikbHspKkOaFhCayEVFQjLfYFIuCwRDnGXgFEDOaYwHBAHqsuqSSrh/2AgP+hGOSPWX2ArbglWRn3/12ByXJz65pWv6LFcD9/hfYCILyzLzaiIVaBaHcJaVIiLrBbdjxC0Uouc9J7vZKhBL5czFpoGXoaMQh95HSEuT6NJaQelBcfdEziYdJB53dwAA="
        }
    }

    EFGMITEMS["arc9_eft_mp18"] = {
        ["fullName"] = "MP-18 7.62x54R single-shot rifle",
        ["displayName"] = "MP-18",
        ["displayType"] = "Sniper Rifle",
        ["weight"] = 2.8,
        ["value"] = 17000,
        ["levelReq"] = 1,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["equipSlot"] = WEAPONSLOTS.PRIMARY.ID,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/weapons/mp18.png", "smooth"),

        ["sizeX"] = 5,
        ["sizeY"] = 1,

        ["caliber"] = "7.62x54",
        ["ammoID"] = "efgm_ammo_762x54",
        ["defAtts"] = "XQAAAQDiAAAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8NV6VfczERS4GZYjxV/r216Up0BZRyLU8Dd5/9fAAPNftYJczs1AaTA/zqPr5a6PhnJBEbni2Tbknz12sfUGtXzyYmLojKU77pXszKSY9zLBhn2yCAJujtDC+tQwW5S24WoA==",
        ["duelAtts"] = {
            "XQAAAQDiAAAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8NV6VfczERS4GZYjxV/r216Up0BZRyLU8Dd5/9fAAPNftYJczs1AaTA/zqPr5a6PhnJBEbni2Tbknz12sfUGtXzyYmLojKU77pXszKSY9zLBhn2yCAJujtDC+tQwW5S24WoA==",
            "XQAAAQAtAQAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8NV6VfczERS4GZYjxV/r216Up0BZRyLU8Dd5/9fAAPNftYJczs1AaTA/zqPr5a6PhnI3bQoFKvjgSDb9Fm8zNHDLagqBus0m14DQwEFR9Sa5mU26tT8EXUNpz0/PG+tzJisXNqVFQ6luRu1BAswGXlyBVXRT6CbGucj0Kg",
            "XQAAAQAsAQAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8NV6VfczERS4GZYjxV/r216Up0BZRyLU8Dd5/9fAAPNftYJczs1AaTA/zqPr5a6PhnJBEbni2TbtKfmzXgxNQfokLNo4mDkc6BCLXJ87kjEwbi/sRmgB2bNb7VgmIndKS1C0mQm8PBGU4m/XeDc3YjcZtXhu6ppvydAA=="
        }
    }

    EFGMITEMS["arc9_eft_t5000"] = {
        ["fullName"] = "ORSIS T-5000M 7.62x51 bolt-action sniper rifle",
        ["displayName"] = "T-5000M",
        ["displayType"] = "Sniper Rifle",
        ["weight"] = 5.9,
        ["value"] = 88000,
        ["levelReq"] = 20,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["equipSlot"] = WEAPONSLOTS.PRIMARY.ID,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/weapons/t5000.png", "smooth"),

        ["sizeX"] = 5,
        ["sizeY"] = 2,

        ["caliber"] = "7.62x51",
        ["ammoID"] = "efgm_ammo_762x51",
        ["defAtts"] = "XQAAAQBTAwAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8ObRiu3tibt3IP5oBbAn23oHzYA8d1/1rQ/6F6KFMvcaM/pLh9ayXkhgZ14kGEirPqWpP/6dxSMYHyxausiP7ggK1p8DCF9BmSb4P3uaSQI9UKX1Tr7qt2eR2Yx9fs4nwR58vTFh2I8lu11HcNFQaAswMKFbD2SaXMhqfJwu83TYJB1+grgXPZyR68JdCcWX6U5YtKl8drOluEj1jijLNSQfwc9v06T2Nqcukz6M37sCCB3fHwFA==",
        ["duelAtts"] = {
            "XQAAAQBtAwAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8ObRiu3tibt3IP5oBbAn23oHzYA8d1/1rQ/6F6KFMvcaM/pLh9ayXkhgZ14kGEirPqWpP/6dxSMYHyxausiP7ggK1p8DCF9BmSb4P3uaSQI9UKX1Tr7qt2eR2Yx9fs4nwR58vTFh2I8lu11HcNFQaAswMKFbD2SaXMhqfJwu83TYJB1+grgXPZyR68JdCcWX6U5YorP/zFWj109l4ESeq8tIUNxhI9oLWMYrTKyTbvKNqo/A0E43mthzK/jAXJvOICmHOW",
            "XQAAAQCwAwAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8ObRiu3tibt3IP5oBbAn23oHzYA8d1/1rQ/6F6KFMvcaM/pLh9ayXkhgZ14kGEirPqWpP/6dxSMYHyxausiP7ggK1p8DCF9BmSb4P3uaSQI9UKX1Tr7qt2eR2Yx9fs4nwR58vTFh2I8lu11HcNFQaAswMKFbD2SaXMhqfJwu83TYJB1+grgXPZyR68JdCcWX6U5Ypuv3HSJsFgIOj2bXUHOGUrjl09sr74lM3rvQZaewyv797Xv2+KaR26yU3NG74bK6xFPJgxeDGlU6vDwxe8agFgu3lb5H4MjfpSqw==",
            "XQAAAQBYBAAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8ObRiu3tibt3IP5oBbAn23oHzYA8d1/1rQ/6F6KFMvcaM/l6iGSY8pUBTfBe8NDC17ogy35d7vZgq5Tt3gKqgpee2m/7sB2rIB1xCiGXWzyRgkUu9g6C/0GAoNOHrat8n4XPs/GDViU5gUkanJu3KU521Ft70gnxokF+35g6nlwN4Jh7yAsNeWFSxN0JPsR7SCqltmftuZcYWta9yvtz5+WBxLbBcNV6LUSV6JN3TXQooByaWYVF8aw71svH/jflGlLyP28i9M8hKMIcI6f0ht10FjCxtId3qDhiPskyDTGt/j59dnUWmiO71Kp+i/NS21tmX9kcELc1ajsuUA"
        }
    }

    EFGMITEMS["arc9_eft_tkpd"] = {
        ["fullName"] = "TKPD 9.3x64 carbine",
        ["displayName"] = "TKPD",
        ["displayType"] = "Marksman Rifle",
        ["weight"] = 5.9,
        ["value"] = 415050,
        ["levelReq"] = 48,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["equipSlot"] = WEAPONSLOTS.PRIMARY.ID,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/weapons/tkpd.png", "smooth"),

        ["sizeX"] = 6,
        ["sizeY"] = 2,

        ["canPurchase"] = false,
        ["lootWeight"] = 30,

        ["caliber"] = "9.3x64",
        ["ammoID"] = "efgm_ammo_93x64",
        ["defAtts"] = "XQAAAQCKAwAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8OcoBWPJpIn/7bo8AQ+FEnJ235Vu+Dl8j/rD2rEVZRgbQUIo//ohe5VRwVkj/Mj5yCITKA2R2eJ64C6s7en/Kqv1FWBUQKWDbdQ30wp/e+JMwerXq0yn82z3YNjs82vkTWMwDDzTulY+2i9e/4RUySzdgTaMjcFKR+ftqt9zYk/0hmib27RfdsrlAvdjaeN6rghzZk7PI+hL9mxNRa19ORDvOSCGM/kUEX6Paxw3MNjJTKJ7fAokVNOxd2ALU64BIpDz9aARQklmeGYmfsSj3YHIBYmz3ysABmKyFqffr2NaYs420UAA==",
        ["duelAtts"] = {
            "XQAAAQCKAwAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8OcoBWPJpIn/7bo8AQ+FEnJ235Vu+Dl8j/rD2rEVZRgbQUIo//ohe5VRwVkj/Mj5yCITKA2R2eJ64C6s7en/Kqv1FWBUQKWDbdQ30wp/e+JMwerXq0yn82z3YNjs82vkTWMwDDzTulY+2i9e/4RUySzdgTaMjcFKR+ftqt9zYk/0hmib27RfdsrlAvdjaeN6rghzZk7PI+hL9mxNRa19ORDvOSCGM/kUEX6Paxw3MNjJTKJ7fAokVNOxd2ALU64BIpDz9aARQklmeGYmfsSj3YHIBYmz3ysABmKyFqffr2NaYs420UAA==",
            "XQAAAQCjAwAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8OcoBWPJpIn/7bo8AY7I0yktT1+4dDy+R30JDVUEtKDt7WXoGZoK1K2ekxVLyxSslFJeR7U6l3EIYuOfpZ5rOIouJzH+4RsXsr7UAVy4ZevodsL5SCkpxsK02qX9Fj9qXzOeIfEEgiOX1RrrA3jH5oYs13TsnW5t9cZNZpmcaGb994+znOKRJilTX5Phs//xTQ76XoB+kKWPYSU3/wpbwIru1g9Uvf+2LKI5P+E3xWTNhi0+oowU12imXFAlkjoJ8hWEFFSYgAXl7hbSWFaQfQFlONIaNWuB2l3nWvicmefwUeLX7PvA1jKcUx9b4/Hrqz9RLM8e9VK5M5Qa0MqpZ39maL",
            "XQAAAQASBAAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8OcoBWPJpIn/7bo8AQ+FEnJ235Vu+Dl8j/rD2rEVZRgbQUIo//ohe5VRwVkj/Mj5yCITKA2R2eJ64C6s7en/Kqv1FWBVkln8fyuSnYK5eVc79QvPc40ivWRLckxRMYaqimcZjcG81GxL3HRsDmZ6fKG2nZtjF7syuDodo5+M+nw4JzXCRcoeNZyhJOo0iBmlo9ZUuzy18KDCikRA2uYBzQmCLASE/YujCbQMy8bJs25B21pWuUet0ht9U+c55EhnFmHEJJXA0mYp6PCnuQNtKeSM+7doItzYPAPYQ1CVuPsCDJRkWtwfgMRV/f3o1w7bu4u/MiTqAL/Zvdsun9pBRsA6cMGWPKHOLndXJgYR0FjRL0vH4UcRfOa92g"
        }
    }

    EFGMITEMS["arc9_eft_m700"] = {
        ["fullName"] = "Remington Model 700 7.62x51 bolt-action sniper rifle",
        ["displayName"] = "M700",
        ["displayType"] = "Sniper Rifle",
        ["weight"] = 4.0,
        ["value"] = 63000,
        ["levelReq"] = 8,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["equipSlot"] = WEAPONSLOTS.PRIMARY.ID,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/weapons/m700.png", "smooth"),

        ["sizeX"] = 5,
        ["sizeY"] = 1,

        ["caliber"] = "7.62x51",
        ["ammoID"] = "efgm_ammo_762x51",
        ["defAtts"] = "XQAAAQAPAQAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8NUfBrxG5/o6wCZICOBvnuThI2G4SXoY5YVE6djRZzT+hLefB8oK6y+WP73ZLPfot111L1Z8yv/Klzy9wOI8rA2th1khRAIQn3Zxm2dJNQkqO2nZexAlJLFGg30dKLB+fUGNNJBuFy1WcFa6ehPHnKQA==",
        ["duelAtts"] = {
            "XQAAAQCGAQAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8NUfBrxG5/o6wCZICOBwJh3caA0NMDX7fc7QgFE2i2HvW1MzZeJ+Mtr7E+NNkkA8zo/WNEH4/VVi0MZXTYpJ7lJW2YN8cI8/kqtTo4FXzsKRpLFnKi1HV7LTPpF60DBQ/OJvKNGOuSZKDERH+0OaXDR5uGYLPhGoF2H9ysli4PdA0IKvXNCyZUHO3qJw==",
            "XQAAAQA/AgAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8NUfBrxG5/o6wCZICOBvnuThI2G4SXoY5YVE6djRZzT+hLefB8oK6y+WP73CXXAPU3DotmdZ7m/gDyLxdxw0L6FonLdpBPDEDM0x2n+s1rY6MtiVSwj2u8f2IBSsKeG47DMn2lBrftFQBp1Z+h1P6jZUjPnwGJfQYtKSpCqL5VKJMNbwQyajvHtoib652VNJDmBQAr9eDQSaWbRMpR4mgtfmY3yCH1a4YNYpxs0EcmptKDQxfTiQ==",
            "XQAAAQDJAwAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8NUfBrxG5/o6wCZICOBvnuThI2G4SXoY5YVE6djRZzT+ZJOmfodyyVUpJ+9LfxuwwO7+61S63njypeRg6WIaY8DalKS9O81DBstzYdPxSyvtFvjuO4XDl+ujXpuwujUZ3LBVtAlbPFv+/BrEDwxRHFG0HbtUrKOpHNnXs67rhzvBRhlvcftZeNQTTkOitidVaIhfAqSgtJvWc76gPuymAUfodZnjutpr7cMB0iuNNbkfnxV4d2NAIQytMxYau270Qh5XVJ9IDVcvIb2ufE6DjCOl5s2VYQub0Y5f+Y4R+Svo1yP11RlxgDZSvMJMSbu8eCGgUlE4qF/tdjAYytgcAl/Q/AlEXpXMuXEX0SI9SPke3bsKqVJU06sdlwJpl44ffvRYA="
        }
    }

    EFGMITEMS["arc9_eft_mxlr"] = {
        ["fullName"] = "Marlin MXLR .308 ME lever-action rifle",
        ["displayName"] = "Marlin MXLR",
        ["displayType"] = "Sniper Rifle",
        ["weight"] = 3.0,
        ["value"] = 70255,
        ["levelReq"] = 17,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["equipSlot"] = WEAPONSLOTS.PRIMARY.ID,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/weapons/mxlr.png", "smooth"),

        ["sizeX"] = 5,
        ["sizeY"] = 1,

        ["caliber"] = ".308 ME",
        ["ammoID"] = "efgm_ammo_308",
        ["defAtts"] = "XQAAAQBHAgAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8NWIc8JEM7NCCZf/J8JCP4tIuIEY6acQEF0OEtXkIjDhlEIYFnknGGhDLWgCcEIxWy+NaotQ9aQE4OnvMOHIti/qf01KaPR+MrgzE/mGQaQKXvABekpgeYPhV3ojrSGdbNdux8/sYI6VzNCf88FKhngQvROdgq+k3LbgZm2aYNtLIJ/xM09rrCFQ/DEv6TI0Xb+09FOr3mRUTb1j+cgbFA",
        ["duelAtts"] = {
            "XQAAAQBHAgAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8NWIc8JEM7NCCZf/J8JCP4tIuIEY6acQEF0OEtXkIjDhlEIYFnknGGhDLWgCcEIxWy+NaotQ9aQE4OnvMOHIti/qf01KaPR+MrgzE/mGQaQKXvABekpgeYPhV3ojrSGdbNdux8/sYI6VzNCf88FKhngQvROdgq+k3LbgZm2aYNtLIJ/xM09rrCFQ/DEv6TI0Xb+09FOr3mRUTb1j+cgbFA",
            "XQAAAQCJAwAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8NWIc8JEM7NCCZf/J8JCP4tIuIEY6acQEF0OEtXkIjDhlEIYFnc8yyDAWiDOml/04arsO9YABx4sds7e4n6Qxx9Qc3NHGyBkPt9IFg+2S1BliHH4ZNCEoiBaKKsMPEAPxSaZgfTq8n1aM8OWBZ2vfcc5eoTr6Frj5GHZG1bOMCagLE7FRwq9SfU0rnredk6ZRwwLBKuLYB7IGY4PnMWn8zs888zBIo2JFpKbEnWYmnnjXo6Rpxlgq6ijLTbF9llaUErLOK3m6ewFSEU4cnEP6nNhNnvzzHA4WxiqeyNrkXg/ynT9bOumfCzX45usGzq+xXQA==",
            "XQAAAQBFAwAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8NWIc8JEM7NCCZf/J8JCP4tIuIEY6acQEF0OEtXkIjDhlEIYFm7U37LgEeKM2RgawaPSw5HAb4QIyXLgLfS1mRVQ5Fm4t9dYfYUkkXZJwYjR2zEDB917w8nJwQ/gfA6lf7VW4IRSulRRRkwepyAB9R431RCEqITHtYGLhGUQwmkdE/ULRXjePvr8DFiGLy3Qq926INkwgnfNbcm3P9UMHlzkGmVeKN+4iQxt+v8vQR8Vy9HajvKRHRITY1R9oCjsMnLKy9lF1cyoGNCrNbAyAgXVIdwIS2ZjBYXO5AaOw="
        }

    }

    EFGMITEMS["arc9_eft_rsass"] = {
        ["fullName"] = "Remington R11 RSASS 7.62x51 marksman rifle",
        ["displayName"] = "RSASS",
        ["displayType"] = "Marksman Rifle",
        ["weight"] = 4.9,
        ["value"] = 130000,
        ["levelReq"] = 34,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["equipSlot"] = WEAPONSLOTS.PRIMARY.ID,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/weapons/rsass.png", "smooth"),

        ["sizeX"] = 5,
        ["sizeY"] = 2,

        ["lootWeight"] = 75,

        ["caliber"] = "7.62x51",
        ["ammoID"] = "efgm_ammo_762x51",
        ["defAtts"] = "XQAAAQC5AgAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8Lchzpvw0LefC8nH/Q5D/5WQm8ZkY/7e2UXLJ+U/sr/LGlYPiAkUENKsUNQ0OZJKV4xujGrotTXTK8lWcV3TAANhKb/Y1Xlt99olDTPMak9UrUGXYynFY3+5gltTTTt/P/SxEFydUMCy2KHtPyB8Ob/wjkKc34cULXS3sZffRqyqs+BoiZk95dUmpFTX4ngnqMF4+KpxEyzSjMxMIUumYijLMTfQNL60+WWkBdmCA8JlHVj/2AgnNI42dWJ+MGwrAtAA==",
        ["duelAtts"] = {
            "XQAAAQD9AgAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8Lchzpvw0LefC8nH/Q5D/5WQm8ZkY/7e2UXLJ+U/sr/LGlYPiAkUENKsUNQ0OZJKV4xujGrotTXTK8lWcV3TAANhKb/Y1Xlt99olDTPMak9UrUGXYynFY3+5gltTTTt/P/SxEFydUMCy2KHtQVggliclpBYMwnh2DTF38SIteFcM1D3JwTSVaEdEy2DcX/5CCxCHy/+NtmSwkmgJyFpwG+R1R6nkojmGF3lJub0igDMuY3e1AbY4uiF/21lC8itWHtC/SDUZqmApVpyYBy7bXG/4f18St+Go0=",
            "XQAAAQA7AwAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8Lchzpvw0LefC8dSpQqrEI9a4p+RnhtB3YfFUppEzXG/VmHHZN6OzQMYXmeLj+osR6NWZPFu5CSlg6Z19eoAAA0KR9mnUu0D4PmcfV6WI1q3sFA2lFyJ67WhZD4SKIy9ZXsjE/PNDgxWzcOEBSkwAUU9nA5FjxyHg1Kp5ztAFh8Uh8nZtZz5/HvdSmryXil1c2qrquHDdeM5NnJ3l+c/jiBpfy6YigzDfjfkhsRqcf+ljOLPGlpJ953D0+bm5108UlKLxO0EIVs0gynUEaXW1AXWA3IyY0OQ2WCVkHR1Q6x4l91tgB8awTv6V4+HssdvSG03P8QveY",
            "XQAAAQBnBAAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8Lchzpvw0LefC8fUEuTRQwP6//dApjvK/cbUeClKyPdta5V6pGVmb0MWeiOCcKO0NBtvyFQbrdz6jH0Tfl8ZyPvV1x9+iVw3c0fBs6gdqMQQCsIMiJHGegV1SsBwI+CmUHfZIzSQ/HTDYMyeaGm6HB/xHxOFPyhKZZeMgXfvoBFwBufMsRJk9z1qjXQaLI9Yj7TzUEy4SBb+tcHauLigpQB1WQiZ/E0dOJ9/rX8O0XeO32f5Hxr17qDUyq9iEvc7wtrKcjAyprBtwppFOBnGhFID3IzQ4g9dqJF96Ry5s3RTdP+CNbGIVzPznZlfBu0+rAWKL+++cCxYU8ghR29TDNldf1slI40U1UYPtf9igVquvkhLDA1agXAMx1KnYm+EknysxoLDdPQ9pAc7hvtqONQTlp2wyVndNo3iRKBTmvJf4aevu/owA="
        }
    }

    EFGMITEMS["arc9_eft_m1a"] = {
        ["fullName"] = "Springfield Armory M1A 7.62x51 rifle",
        ["displayName"] = "M1A",
        ["displayType"] = "Marksman Rifle",
        ["weight"] = 3.9,
        ["value"] = 105000,
        ["levelReq"] = 18,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["equipSlot"] = WEAPONSLOTS.PRIMARY.ID,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/weapons/m1a.png", "smooth"),

        ["sizeX"] = 5,
        ["sizeY"] = 2,

        ["caliber"] = "7.62x51",
        ["ammoID"] = "efgm_ammo_762x51",
        ["defAtts"] = "XQAAAQClAQAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8NUWEgbTj3U/7wMBbhp+3V3U++qZq9cNzZu4MkjHnVzmx7ZyhChGagN5roUUg3zO9DT+aeuSPLUn12Kh/p8oGsNBFu58FtMzE1JVRLfl5pJm0u8S5o6rcHPrHykKvygcv6uhT74SK9HVjdHSbSHdbiNAx5VlMQYjxfmlYPLrcVZEWydTtL8z4Pqjx8zG4ViA==",
        ["duelAtts"] = {
            "XQAAAQClAQAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8NUWEgbTj3U/7wMBbhp+3V3U++qZq9cNzZu4MkjHnVzmx7ZyhChGagN5roUUg3zO9DT+aeuSPLUn12Kh/p8oGsNBFu58FtMzE1JVRLfl5pJm0u8S5o6rcHPrHykKvygcv6uhT74SK9HVjdHSbSHdbiNAx5VlMQYjxfmlYPLrcVZEWydTtL8z4Pqjx8zG4ViA==",
            "XQAAAQC1AgAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8NUWEgbTj3U/7wMBbjEwLHfY+tCD/dcMKtu57Baqx5YHFsFcAzN9Wa9rK4LWxltBKnXciatvZswFAAfbXqAWu4hLci0rbzc9yfGDGJ2RrOBLhdjBk2l1fe5w4Ke3oSXX2HmZw13IJtmUaApFs68CvV5xYJ7AkthTgddPHUGZ5Fj3kObUBW4sUuhw3QVSfIsCyXdFuz3cIRHk091epGIj86v5rAc+Xps9P8Q03Sw5NybRyV6v2jz37kwdpphzQ1hNu85F+FqGoWLPaYAA==",
            "XQAAAQCoAgAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8NUWEgbTj3U/7wMBbhp+3V3U++qZq9cNzZu4MkjHnVzmx7ZyhChGagOJ4nhcU6TPovlWccsZYSpgdew0/Mk04FCxe0lmL0rRsU+ZiBPGDGnbmnAVQNnWomiZs2jIbbZ9uYGn2Ja74lLwNK1/YLs4RHb43cibjSZ6HIhoV0wiWOyU0pduBOMZ/nwOqfzwL84Sk9Lp0izyjzzWvvjHjcQl6myi3iMdY4LQ7DRiDlzOprgA=="
        }
    }

    EFGMITEMS["arc9_eft_sv98"] = {
        ["fullName"] = "SV-98 7.62x54R bolt-action sniper rifle",
        ["displayName"] = "SV-98",
        ["displayType"] = "Sniper Rifle",
        ["weight"] = 5.1,
        ["value"] = 74000,
        ["levelReq"] = 13,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["equipSlot"] = WEAPONSLOTS.PRIMARY.ID,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/weapons/sv98.png", "smooth"),

        ["sizeX"] = 6,
        ["sizeY"] = 2,

        ["caliber"] = "7.62x54",
        ["ammoID"] = "efgm_ammo_762x54",
        ["defAtts"] = "XQAAAQBLAQAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8OSytTkJgaUnpNNGc+Gl6jVHV/uSNDf/kO4OHmIYepg0elfMCMxvyZU1WTuQFb/dnwV8M4PC6lSZdZMuezE7eF3HWlgqW7PFipSfyrVe9jbv03iHjENH3dhywatmAwUqycXPSurpMpqxJ3HYd+hhPLgZfgpR0jPJd5szGtky82jQ==",
        ["duelAtts"] = {
            "XQAAAQBLAQAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8OSytTkJgaUnpNNGc+Gl6jVHV/uSNDf/kO4OHmIYepg0elfMCMxvyZU1WTuQFb/dnwV8M4PC6lSZdZMuezE7eF3HWlgqW7PFipSfyrVe9jbv03iHjENH3dhywatmAwUqycXPSurpMpqxJ3HYd+hhPLgZfgpR0jPJd5szGtky82jQ==",
            "XQAAAQASAwAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8OSytTkJgaUnpNNGc+Gl6jVHV/uSNDf/kO4OHmIYepg0elfMCMxvyZU1WV+lFnRB+RDjzwSyAc+CTN4y7lOuMrmFgOMS+FftrQcvhx20JAN6jXQr59JAKNsiK2ct/+QgFW8PQsDHCSOfVBPFCw551Kf4j44rSrwTgpXfcS1hofy+7Lo5ObgwgZqubmEtRvn1lH0s+uLMJRkKlkpecOcu88GSV6ssFKaS7fSs2NGqfMIztFIogLXPMSUuVq5nclB/1+e1gMGWoXEGGwPUOJ",
            "XQAAAQCfAQAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8OSytTkJgaUnpNNFu1bbpmsvOeCeWqb9LWE2G+5A2E9WGLXD97UauavWB3MQXSHE0YS9Q2WT4p2qebvWNPrBRz98kvXXjzdRyW+5xnyZnlvpr+hw1BiE3W4dqU41I/cVqt0tKNF66v9ZYmhrTKfUJBrk3nZMPxjpNKw6t+CJQEtGrPQoIK3ykRFpLBEWt+xl4="
        }
    }

    EFGMITEMS["arc9_eft_svds"] = {
        ["fullName"] = "SVDS 7.62x54R sniper rifle",
        ["displayName"] = "SVDS",
        ["displayType"] = "Marksman Rifle",
        ["weight"] = 4.3,
        ["value"] = 85000,
        ["levelReq"] = 19,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["equipSlot"] = WEAPONSLOTS.PRIMARY.ID,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/weapons/svds.png", "smooth"),

        ["sizeX"] = 6,
        ["sizeY"] = 2,

        ["caliber"] = "7.62x54",
        ["ammoID"] = "efgm_ammo_762x54",
        ["defAtts"] = "XQAAAQBvAgAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8OSy5Op2fcAEZMuyaASWAz0/M7SqAjtmacTwu80ueelzptgu4g0+pF5hx9p4QDd/RDvkDYZMtgN7RlbE+FpjS0JnhcRJMOxD3V35XFgdgYu+X2w5Hln8J+LmSldVJMIdldC3dAacAYun6GPlg2I8iu4Lq+Hc0FUBQPTcLfF22MgWS/8nNfFHQBZ/5v83vKP+3/LRV/0wYSyc8fCy+Jk2NStIYUKrI=",
        ["duelAtts"] = {
            "XQAAAQBvAgAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8OSy5Op2fcAEZMuyaASWAz0/M7SqAjtmacTwu80ueelzptgu4g0+pF5hx9p4QDd/RDvkDYZMtgN7RlbE+FpjS0JnhcRJMOxD3V35XFgdgYu+X2w5Hln8J+LmSldVJMIdldC3dAacAYun6GPlg2I8iu4Lq+Hc0FUBQPTcLfF22MgWS/8nNfFHQBZ/5v83vKP+3/LRV/0wYSyc8fCy+Jk2NStIYUKrI=",
            "XQAAAQCqAwAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8OSy5Op2fcAEZMuyaASWAz0/M7SqAjtmacTwu80ueelzptgu4g0+pF5hx9p4QDd/Q6YS5tznBiG+cryh3S1mI86OKLSxekwoPFIxBToCYmHKMapa19aJ87ZsQQaR+DCE6aG6Gw1vrJjTQjUbWvGQRjLKkKT5HA6W180PneA/LnPjbjYEXeCoRfGVEw/E/KCJoUBwuU07dvc7esgChQvcHCI6a4sTt4yuTgGY1avenHoPtg1p7V/BaAz6dw9WMWP7mk/c4TAtiEDehvdrgn1dMcudXCxGlJMmH7jsBsgp0SfjTQ4XYTIj+9oqe2zMTyATDtO/OOS0PNeCoESARz",
            "XQAAAQDKAwAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8OSy5Op2fcAEZMuyaASWAz0/M7SqAjtmacTwu80ueelzptgu4g0+pF5hx9p4QDd/RDvkDYZMtgN7RlbE+FpjS0JnhcRJMOxD3V35XFgjd3zzZ0amb9TQ3gpQ6nfznBwjYFWoLctY2G0UK7JLOA3fm3/XKwe3N030+Arl4j0omBbqYxChij62rugg2HywhXh8Inc8C7U++jv7ZVDLvY+NvDXGhiwDB6Tp8hqyD2cZmEmyaC6IMtcsN1vQu8hJDZOH9nglVg9SHnDfvrbWnji/VPjJKpoYWQ+/+HJp/K2OuUKN7ITmeFChXVOtYQAHLwL+a2bs0MyTrbwd0LKQNUIdIdmVraOkNc5xTAYfFa"
        }
    }

    EFGMITEMS["arc9_eft_vpo215"] = {
        ["fullName"] = "Molot Arms VPO-215 Gornostay .366 TKM bolt-action rifle",
        ["displayName"] = "VPO-215 Gornostay",
        ["displayType"] = "Sniper Rifle",
        ["weight"] = 3.3,
        ["value"] = 27000,
        ["levelReq"] = 3,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["equipSlot"] = WEAPONSLOTS.PRIMARY.ID,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/weapons/vpo215.png", "smooth"),

        ["sizeX"] = 5,
        ["sizeY"] = 1,

        ["caliber"] = ".366",
        ["ammoID"] = "efgm_ammo_366",
        ["defAtts"] = "XQAAAQBiAQAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8Ow/iPem4evSEh1ZVBQmKe6TaWo6POdajS5pypMmDY20hbHcZSWr7CxGfmXs85U87DKMtHcVIC0q5r3emPMZeQY6fJyMV2DpZXb0TEMuHcUwO1tU5prVUPsBo7HimY3Il6WrUtItPKOdFNc21rxdVWIB54CVOib0iEWQ==",
        ["duelAtts"] = {
            "XQAAAQBiAQAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8Ow/iPem4evSEh1ZVBQmKe6TaWo6POdajS5pypMmDY20hbHcZSWr7CxGfmXs85U87DKMtHcVIC0q5r3emPMZeQY6fJyMV2DpZXb0TEMuHcUwO1tU5prVUPsBo7HimY3Il6WrUtItPKOdFNc21rxdVWIB54CVOib0iEWQ==",
            "XQAAAQCWAQAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8Ow/iPem4evSEh1ZVBQmKe6TaWo6POdajS5pypMmDY20hbHcY2Sc/hpq2gNBS+1uIe9k6h/UNXBBq6SkbDUezh1RqqvPIV+TuCi1Bq8crhMv14wl0GedUsfxDeJ6I0m2FbbjmdT7nE7HY11x4JfnGrmiT6o/4beGRLuHDRdJ0NTL+WWI2X1GmEB+Q9o3Xcd+alhLxX/kFPV9yLLaLYIA==",
            "XQAAAQD5AQAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8Ow/iPem4evSEh1ZVBQmKe6TaWo6POdajS5pypMmDY20hbHcY2Sc/hpq2gNBS+1uIe9k6h/UNXBBq6SkbDUezh1RqqvPIV+TuCi1Bq8crhMv14wl0GedUsfxDeJ6I0m2FbbjmdT7nE7HY11w/Ws24Mxe4VifNS6D3njHpYwz11zPs1TQzg4SHVN4uz7fr8xkYCN7dqkohUsOcUOAT2ywnmH+pD4w82YOdBFiw9gsdOcvQtvcDpes3r5gA="
        }
    }

    EFGMITEMS["arc9_eft_vss"] = {
        ["fullName"] = "VSS Vintorez 9x39 special sniper rifle",
        ["displayName"] = "VSS Vintorez",
        ["displayType"] = "Marksman Rifle",
        ["weight"] = 2.6,
        ["value"] = 143000,
        ["levelReq"] = 37,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["equipSlot"] = WEAPONSLOTS.PRIMARY.ID,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/weapons/vss.png", "smooth"),

        ["sizeX"] = 5,
        ["sizeY"] = 2,

        ["lootWeight"] = 65,

        ["caliber"] = "9x39",
        ["ammoID"] = "efgm_ammo_9x39",
        ["defAtts"] = "XQAAAQBtAQAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8OwmVfT2hq/H64qBlSsLc/OGn6XwHM3Rbx0N1ed9Tqdupk/nUylj0UY2YpYpkPX3jeqgqAnCrVaNv1fySJhu99NEpabNPsEGTjXDLy7jmO+jBxswQ7Nq0MpQq9SWRznk2rHKBFdXEEuWDGJSVnjp0XHF7iu5IsLOUKVfodqQ1AEA==",
        ["duelAtts"] = {
            "XQAAAQBtAQAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8OwmVfT2hq/H64qBlSsLc/OGn6XwHM3Rbx0N1ed9Tqdupk/nUylj0UY2YpYpkPX3jeqgqAnCrVaNv1fySJhu99NEpabNPsEGTjXDLy7jmO+jBxswQ7Nq0MpQq9SWRznk2rHKBFdXEEuWDGJSVnjp0XHF7iu5IsLOUKVfodqQ1AEA==",
            "XQAAAQCoAQAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8OwmVfT2hq/H64qBlSsLc/OGn6XwHM3Rbx0N1fybkly5t1lPJVg7w+L/iJeqRYxp7M469cAp6GThWxCQqh8xejVIMTSNBVSnWkCAqlT6/EsHbAvSlr+pHarSR7Soh5CJybwZEPdvxnVXU8Ed47rIBoDBllTmjUZdj9iOZ2QpbNytUyjNbJBRZXFQRBPalVO0iM80ITRlS28uBwO2+liAA=",
            "XQAAAQDjAgAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8OwmVfT2hq/H64qBlSsLc/OGn6XwHM3Rbx0N1ed9Tqdupk/nUylj0UY4VjeRA1JSemFIaFzWojxxm3ax6F3nN+lAWWBJ/myEk0QS8g7BUWgduvEDqQ8R2gquYenCPPcWNwersXVzTBbxnkc3wMI/TgOnnrObXrdaZaFKLK6bGijHUXLrAaqgurrD0XyfaCKnTnuwfHNBTGsRbz3hpZJkEMkxJWEYZrtI1mA2J2JYmJoQdxymPctfQ6wdRt39W492gFBBDE6iq/tJY6TU3izcFd5m6PZOSKwD9265OHjoq/9l2pHazdoA=="
        }
    }

    EFGMITEMS["arc9_eft_sako_trg"] = {
        ["fullName"] = "Sako TRG M10 .338 LM bolt-action sniper rifle",
        ["displayName"] = "Sako TRG M10",
        ["displayType"] = "Sniper Rifle",
        ["weight"] = 6.7,
        ["value"] = 249500,
        ["levelReq"] = 48,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["equipSlot"] = WEAPONSLOTS.PRIMARY.ID,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/weapons/sako.png", "smooth"),

        ["sizeX"] = 6,
        ["sizeY"] = 2,

        ["canPurchase"] = false,
        ["lootWeight"] = 35,

        ["caliber"] = ".338",
        ["ammoID"] = "efgm_ammo_338",
        ["defAtts"] = "XQAAAQD4AgAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8OSPUS50ueaV1GG+rPRo5+8m2Sm656FXjCbKUY7J6DBmUnL9FXWbbSS2BVCo31BNK4Bvrc6zYshs41G/Zc61xYlL+L4GI5NKRlP/Aa75K43e/UAnao6/4jXc0TuG5WT/TP851aNFst+XIAdAV99s+P2SyECbvjN8tB0TUBR9QTBY5YjsR11tMSKoEpUaLETGViO0j1zwi7Z4wTQqZYwgHBEj+eecA8ksrgWYkTCjvBcf1xAA==",
        ["duelAtts"] = {
            "XQAAAQArAwAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8OSPUS50ueaV1GG+rPRo5+8m2Sm656FXjCbKUY7J6DBmUnL9FXWbbSS2BVCo31BNK4Bvrc6zYshs41G/Zc61xYlL+L4GI5NKRlP/Aa75K43e/UAnao6/4jXc0TuG5WT/TP851aNFst+XH/rnezZMf6ogXNjbU0FShfZbPc2CyNI3c/fcxO/pncPY4cJTQIPkl4nG9MXzjqp6zUiGkm0xEBpsFhdnkonlMI0yNHGJ/RuzDnLV47wsyaNZ3zTymjwKHp3sBZcT2ymbY=",
            "XQAAAQBwAwAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8OSPUS50ueaV1GG+rPRo5+8m2Sm656FXjCbKUY7J6DBmUnL9FXWbbSS2BVCo31BMj0oBqGADFuRYHfmpivoXZpFkBuWDUDTTKFRjzxJJ/xwnEisZgseN1oOP0I+26+axiW8lJKwj0ZiD4mw8XecXbO69BKlnCLfvFD+QNEfLTwM8neYZq6zbekfR2Ql0LYB8mO8qCH6HTdJgIdX2Xvjc5AVvCz/i6kN2qGvDv5XkGUmMaNzk/Skkn40njldMTvpN64nxkuYWjySN526yoXjHudaEvhMuoA",
            "XQAAAQDBAwAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8OSPUS50ueaV1GG+rPRo5+8m2Sm656FXjCbKUY7J6DBmUnL9FXWbbSS2BVCo31BMj0oBqGADFuRYHfmpivoXZpFkBuWDUDTTKFRjzxJJ/xwnEisZgseN1oOP0I+26+axiW8lJKwj0ZiD4mw8XecXbO69BKlnCLfuXcfDkxcj97wMjkC0IdCvbiyWi13xjUsaAWLEatxkjt31eEHPCazgnrTcwKldkCLtZQD2wriY9HfRmCArhOUr/xs0hPFnig9Zw4lUp0kd3IHIgS3mEA5AXZ5VBEO5gZfTRB1jvsIjbd/xaa2HtRu6YLmwSuPBh7GoS5AA=="
        }
    }

    -- submachine guns
    EFGMITEMS["arc9_eft_mp9"] = {
        ["fullName"] = "B&T MP9 9x19 submachine gun",
        ["displayName"] = "MP9",
        ["displayType"] = "Submachine Gun",
        ["weight"] = 1.3,
        ["value"] = 43000,
        ["levelReq"] = 8,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["equipSlot"] = WEAPONSLOTS.PRIMARY.ID,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/weapons/mp9.png", "smooth"),

        ["sizeX"] = 3,
        ["sizeY"] = 2,

        ["caliber"] = "9x19",
        ["ammoID"] = "efgm_ammo_9x19",
        ["defAtts"] = "XQAAAQCKAQAAAAAAAAA9iIIiM7hMNz0dhIkbkvLjTdSR5gRNNIHH3iMsyB8XQoVZc5MYQexI1ffzpCrvKqfdB+rsPaHaT2Blw9LmEBuv1mA/ZRmzKcRiqXPL89IDAsS6U+YMW22DXenZavSF1ISlOL7FxvzWoLrgHpOOSm5JzIoRwanakCwORxSktHUHCH/ES6bJl4MUG9iYDnuo6Q==",
        ["duelAtts"] = {
            "XQAAAQCKAQAAAAAAAAA9iIIiM7hMNz0dhIkbkvLjTdSR5gRNNIHH3iMsyB8XQoVZc5MYQexI1ffzpCrvKqfdB+rsPaHaT2Blw9LmEBuv1mA/ZRmzKcRiqXPL89IDAsS6U+YMW22DXenZavSF1ISlOL7FxvzWoLrgHpOOSm5JzIoRwanakCwORxSktHUHCH/ES6bJl4MUG9iYDnuo6Q==",
            "XQAAAQAAAgAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8NV6XhpGg4daTv0IrapxXkxEjddl3YxKcOMP1Yvv3Qv23PIdgQZ0cLqz8FO5PuNuDTeK5+Th1ntZsmo070Vh75avlZepSePxEOvTW/Z/Z/L9z3lA5dmZFXpumw7tWxy2vt9Cq0cfSEH/FFYanRQ6oGZas9Vg49I+SMWBG7MLkQ5/UYS4FmAzYVHTXL7Sck3DnP0NUB1Y8=",
            "XQAAAQC3AgAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8NV6XhpGg4daTv0IrapxXkxEjddl3YxKcOMP1Yvv3Qv23PIdgQZ0cLouWDneVXYUHjaoppqOaPo9F8y90Ys/2pKtDMXdPqLU+AS9c4zj9sGLeYCa5siHeXu6nEIwFVaOVHUjyKQGt37jQQwHJm5H7eBetxpZ9kSSQ0dsea4ytK2LgDywQQ9qnFwH0ajuWtoJ7iEhQ780yz5LMBfWhd6CpeuV6xaTm9dTypYw2rd1OVoeziyVaWWxahXbbDQcVWeFePI1ZQtYrqIMWKk+Dbt7HeQA=="
        }
    }

    EFGMITEMS["arc9_eft_mp9n"] = {
        ["fullName"] = "B&T MP9-N 9x19 submachine gun",
        ["displayName"] = "MP9-N",
        ["displayType"] = "Submachine Gun",
        ["weight"] = 1.4,
        ["value"] = 60000,
        ["levelReq"] = 11,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["equipSlot"] = WEAPONSLOTS.PRIMARY.ID,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/weapons/mp9n.png", "smooth"),

        ["sizeX"] = 3,
        ["sizeY"] = 2,

        ["caliber"] = "9x19",
        ["ammoID"] = "efgm_ammo_9x19",
        ["defAtts"] = "XQAAAQBkAQAAAAAAAAA9iIIiM7hMNz0dhIkbkvLjTdSR5gRNNIHH3iMsyB8XQoVZc5LZUctUjjB8hqkZn7PgjNJBHUDMSCfKQdTCQa/QYOQH7cDRfRaTVJ767wECL5eTBfe6RNmzmxLzZn9tAPPZgf41fsi324dNSCCqQJvh0p3Sb3lrktclA2Vw2NHxERhLYg8r",
        ["duelAtts"] = {
            "XQAAAQBkAQAAAAAAAAA9iIIiM7hMNz0dhIkbkvLjTdSR5gRNNIHH3iMsyB8XQoVZc5LZUctUjjB8hqkZn7PgjNJBHUDMSCfKQdTCQa/QYOQH7cDRfRaTVJ767wECL5eTBfe6RNmzmxLzZn9tAPPZgf41fsi324dNSCCqQJvh0p3Sb3lrktclA2Vw2NHxERhLYg8r",
            "XQAAAQA+AQAAAAAAAAA9iIIiM7hMNz0dhIkbkvLjTdSR5gRNNIHH3iMsyB8XQoVZc5LZUctUjjB8hqkZn7PgjNJBHUDMSCfKQdTCQa/QYOQH7cDRfRaTVJ767wECL5eTAddKGGCUviyIQzOQn7c2o5M51zg/eMJ5MNOkL+S6FYelC2RbMKgQF8zg",
            "XQAAAQDbAQAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8NV6XhpGg4daTv0IrapxXkxEjddl3YxKcOMP1Yvv3Qv23PIdgQZ0cLqz8FO5PuNuDTeK5+Th1ntZgqCYMkQSVL2tWsosCtmHFiI7/7f0a8ss/rn+AIcUhVcno3yfcJ7bSiDaLJitQiE8tRpUyhRM1DeEjoKj7m/tg4XJiW5RR37pj7TjHNvIbt3zPvhW4K"
        }
    }

    EFGMITEMS["arc9_eft_fn_p90"] = {
        ["fullName"] = "FN P90 5.7x28 submachine gun",
        ["displayName"] = "P90",
        ["displayType"] = "Submachine Gun",
        ["weight"] = 2.9,
        ["value"] = 92000,
        ["levelReq"] = 28,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["equipSlot"] = WEAPONSLOTS.PRIMARY.ID,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/weapons/p90.png", "smooth"),

        ["sizeX"] = 3,
        ["sizeY"] = 2,

        ["lootWeight"] = 80,

        ["caliber"] = "5.7x28",
        ["ammoID"] = "efgm_ammo_57x28",
        ["defAtts"] = "XQAAAQBMAgAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8Ny5IZ7Zcx4cUYhoInAEZ+nl9GVj4rv1KsgZ4x2lhRagjdJTg3JU/kscQERrXasfT6UaKVuZt2bsQiG2/t/UNQA4RMAWLsptpRXm6CBu4uWV5sUH8F4Mm5qQlRjtsaS+Epco+oyrNDfMEv0/EQOU8gwsN890XzZHleJwcAoTA6xDmd3TkYNJmem/wVs/lccsmtTDhbR2Mn6YVhBos=",
        ["duelAtts"] = {
            "XQAAAQBMAgAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8Ny5IZ7Zcx4cUYhoInAEZ+nl9GVj4rv1KsgZ4x2lhRagjdJTg3JU/kscQERrXasfT6UaKVuZt2bsQiG2/t/UNQA4RMAWLsptpRXm6CBu4uWV5sUH8F4Mm5qQlRjtsaS+Epco+oyrNDfMEv0/EQOU8gwsN890XzZHleJwcAoTA6xDmd3TkYNJmem/wVs/lccsmtTDhbR2Mn6YVhBos=",
            "XQAAAQDzAQAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8Ny5IZ7Zcx4cUYhoInAEZ+nl9GVj4rv1KsgZ4x2lhRagiV+u9sWtRMoYxCNatJkmkHKQTZ7JJLmZbcRhxgj86lfPOSgXd/wjJoSruTk8idq19uiX7O1NM9hO6wkBkI1yYtVrKqu2zY52Za+urJmhj5B+ZIBURqTQooJS83dQnyEOdMIlsN9Wd7V7lLnkDPNFEb375btn5dtFrahjAjc/SDfJlSOgyjYyQiIko=",
            "XQAAAQAzAwAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8Ny5IZ7Zcx4cUYhoInAEZ+nl9GVj4rv1KsgZ4x2lhRagjdJTg3JU/kscQERrXasfVRhDudSQJV3339fsdGNOpjgT7dXq2Z+4ll/4F+5pD/ttPXjUZ0OL8eiKQOyZHbU4GAmwccSpITU1TzClrlkDfrDB8OUux5bdz/ykR4Oi/euegUDONPnLBT1mxgqTIeaQ+bmVxotxn13E1Pj6HgQuFlt1nHreG9/+D48XMBycCsUPGXHld3iBmYSlI1Hq1ZA/llnnXfgHSwyYv/mYEH9X4+YI04SuK4eLAPLKRiBL8PDh5VU+J7lD90U74fAA=="
        }
    }

    EFGMITEMS["arc9_eft_mp5"] = {
        ["fullName"] = "HK MP5 9x19 submachine gun",
        ["displayName"] = "MP5",
        ["displayType"] = "Submachine Gun",
        ["weight"] = 2.4,
        ["value"] = 41000,
        ["levelReq"] = 2,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["equipSlot"] = WEAPONSLOTS.PRIMARY.ID,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/weapons/mp5.png", "smooth"),

        ["sizeX"] = 3,
        ["sizeY"] = 2,

        ["caliber"] = "9x19",
        ["ammoID"] = "efgm_ammo_9x19",
        ["defAtts"] = "XQAAAQCbAQAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8NV6WhTi7Ui/5BdiqeDJy8MVUdk9skb/TP9x4IQXLk+dJw1ASm2Bc56n23sNdESJMDpvQGDRKmlwcv2uQem6GgQKNCB/Yrfsu0zjVfJf9BWLnxdPIcWYoQ0efbGWHjXAIDv2JSFSOWXOu8kXdQ/60VM9uUucTdVaS4I39SYw==",
        ["duelAtts"] = {
            "XQAAAQCbAQAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8NV6WhTi7Ui/5BdiqeDJy8MVUdk9skb/TP9x4IQXLk+dJw1ASm2Bc56n23sNdESJMDpvQGDRKmlwcv2uQem6GgQKNCB/Yrfsu0zjVfJf9BWLnxdPIcWYoQ0efbGWHjXAIDv2JSFSOWXOu8kXdQ/60VM9uUucTdVaS4I39SYw==",
            "XQAAAQDjAQAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8NV6WhTi7Ui/5BXco24GV1jXLBzzvFFq7tz+8Yb2bmkRD5LnLLTp/H6IwXny7lAoqMAcnlHhAYcWXg+6YHx/izGKtNwfNfmkjN5BZYZOzTep9n1ZW4OWXYBpqgVB5o2CQ5YtOm6kmjKxGdrfttyDYYc7+dWTk2mnWYmdxzhsD3TfEqWO1zdp3xVVUHaZ8v5K7imHp+BEA=",
            "XQAAAQCxAgAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8NV6WhTi7Ui/5BdiqeDJy8MVUdk9skb/TP9x4IQilSnSAlCMegPnb75gAAl2LE0WfIqK13M3RRGGiriWv3hloXS7o/mH4LGbwBJC/2jjXbQqydqKM0TmVbTULbBqGWY5IQ82ugsunqGhlf/iji5gKjyZBjIlFc5gpynCalgnTLkKseHp0CfjyIyFUvPhcMb0y/Z8o1Li9FsPVHRfx68KY5dUDOEHw+KKH2VhXilQmYvFCxVSGnyPrYDAzNTorzw+Hm+Ie/sigV0K+/rvxw"
        }
    }

    EFGMITEMS["arc9_eft_mp5k"] = {
        ["fullName"] = "HK MP5K 9x19 submachine gun",
        ["displayName"] = "MP5K-N",
        ["displayType"] = "Submachine Gun",
        ["weight"] = 1.8,
        ["value"] = 32000,
        ["levelReq"] = 1,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["equipSlot"] = WEAPONSLOTS.PRIMARY.ID,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/weapons/mp5k.png", "smooth"),

        ["sizeX"] = 2,
        ["sizeY"] = 1,

        ["caliber"] = "9x19",
        ["ammoID"] = "efgm_ammo_9x19",
        ["defAtts"] = "XQAAAQBLAQAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8NV6WhTi7Ui/4zrwVOyrfUx7fgXQ8ALMhtStnN/OQ+C36mWZp8UwJ5uH0SWZv3pKOwPGG/asqqBXKosYoeIhiF5PLQkB4gd2YGJDJHYaI+6lCLhpsO8Vk3EFMbHjO34SpSfB/6qMDHEJthcKju1G/19g==",
        ["duelAtts"] = {
            "XQAAAQBLAQAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8NV6WhTi7Ui/4zrwVOyrfUx7fgXQ8ALMhtStnN/OQ+C36mWZp8UwJ5uH0SWZv3pKOwPGG/asqqBXKosYoeIhiF5PLQkB4gd2YGJDJHYaI+6lCLhpsO8Vk3EFMbHjO34SpSfB/6qMDHEJthcKju1G/19g==",
            "XQAAAQA2AQAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8NV6WhTi7Ui/4zrwVOyrfUx7fgXQ8ALMhtStnN/OQ+C36m7yVt+XhALTNG4GOnjD81dMbpxAdCSlnZNbiEfVgH7lVOZd2a9aPbJqYOhkyojyrLmyJ0RtNA6y5BNdCbGhre3kmzxZ1qvsGn2AA=",
            "XQAAAQCUAQAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8NV6WhTi7Ui/4zrwVOyrfUx7fgXQ8ALMhtSto7FDa9NSPpshbySDI/UVPrHJYkKEK+59WB5dxxHDjaCJNTWJ6NLM5LmugN4wuosSnprRJAKmxEWA8X1Q0gNg3ymZRBuBnGuM7rGeh/At24JPmHcYWp9xASCZveMu7bz5LjB9NkaTyVQP9jzw=="
        }
    }

    EFGMITEMS["arc9_eft_mp7a1"] = {
        ["fullName"] = "HK MP7A1 4.6x30 submachine gun",
        ["displayName"] = "MP7A1",
        ["displayType"] = "Submachine Gun",
        ["weight"] = 2.2,
        ["value"] = 83000,
        ["levelReq"] = 26,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["equipSlot"] = WEAPONSLOTS.PRIMARY.ID,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/weapons/mp7a1.png", "smooth"),

        ["sizeX"] = 3,
        ["sizeY"] = 1,

        ["caliber"] = "4.6x30",
        ["ammoID"] = "efgm_ammo_46x30",
        ["defAtts"] = "XQAAAQBoAQAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8NV6XBeOzbVc3/+oJVTjqv2y1/N6rCbsp5PT5ky5xEMVwRLNgW0fN8cTRAuAizUrBVXXF/YybHeXMOq38nmuYZjE8rO8MdHthSgqamIKXz4/vfLxrEx5t5AeABJfq8yRXBa5WJ7l0Q9DHa5FunPA8b8LPQdhozbE/jMgtnf9G3",
        ["duelAtts"] = {
            "XQAAAQBoAQAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8NV6XBeOzbVc3/+oJVTjqv2y1/N6rCbsp5PT5ky5xEMVwRLNgW0fN8cTRAuAizUrBVXXF/YybHeXMOq38nmuYZjE8rO8MdHthSgqamIKXz4/vfLxrEx5t5AeABJfq8yRXBa5WJ7l0Q9DHa5FunPA8b8LPQdhozbE/jMgtnf9G3",
            "XQAAAQDXAQAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8NV6XBeOzbVc3/+oJVTjqv2y1/N6rCbssgz6/37r+XBFNJrm2sxuRFXG43VkFXnNuT3FIYOQ/J7j04pMQqDt41GcfkfB4ZQTUdhbcGp4hRBojrpScDw/e3sCEoEwcTNoqX/xs9eYeDUeT3+LI1YjOo1oag/WyI3Ee9n6tzAh/uouJXD+a+2S4XSoZdo7EuKp1aiRVfuqA+1hOjseIKtFpGKG5HAA==",
            "XQAAAQDzAQAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8NV6XBeOzbVc3/+oJVTjqv2y1/N6rCbsp5PT5ky5xEMVwRLNgW0fN8cTRAt7QJhEd6jq7/tzSfW8Z6Pt5eeKt4h9uHZ7OluEig7Y+GCbcWA0oJw8aRx9qz9zJllz/lPCHI++gYXFBabcjO8QZfqcAiF8UgjwbmkQONCltY4j63r2w4RTF3gsPJEdA0mh/ygZyU6v7o0gG2dbB6tY8OC07VRieaOXxM"
        }
    }

    EFGMITEMS["arc9_eft_mp7a2"] = {
        ["fullName"] = "HK MP7A2 4.6x30 submachine gun",
        ["displayName"] = "MP7A2",
        ["displayType"] = "Submachine Gun",
        ["weight"] = 2.2,
        ["value"] = 112000,
        ["levelReq"] = 30,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["equipSlot"] = WEAPONSLOTS.PRIMARY.ID,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/weapons/mp7a2.png", "smooth"),

        ["sizeX"] = 3,
        ["sizeY"] = 1,

        ["lootWeight"] = 80,

        ["caliber"] = "4.6x30",
        ["ammoID"] = "efgm_ammo_46x30",
        ["defAtts"] = "XQAAAQBoAQAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8NV6XBeOzbVc3/+oJVTjqv2y1/N6rCbsp5PT5ky5xEMVwRLNgW0fN8cTRAuAizUrBVXXF/YybHeXMOq38nmuYZjE8rO8MdHthSgqamIKXz4/vfLxrEx5t5AeABLGPYyRXBa5WJ7l0Q9DHa5FunPA8b8LPQdhozbE/jMgtnf9G3",
        ["duelAtts"] = {
            "XQAAAQBoAQAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8NV6XBeOzbVc3/+oJVTjqv2y1/N6rCbsp5PT5ky5xEMVwRLNgW0fN8cTRAuAizUrBVXXF/YybHeXMOq38nmuYZjE8rO8MdHthSgqamIKXz4/vfLxrEx5t5AeABLGPYyRXBa5WJ7l0Q9DHa5FunPA8b8LPQdhozbE/jMgtnf9G3",
            "XQAAAQCVAQAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8NV6XBeOzbVc3/+oJVTjqv2y1/N6rCbsp5PT5ky5xEMVwRLNgW0fN8cTRAt7QJhEd6jq7/tzSfW8Z6Pt5cOMs+XJGmE2O9IXFl8iPKFEUO/ss7/Df0c+pJzOuyqnXqDwl1e6vCJYoKufB+WMimAPtwDeWBT9AVSsRwMLkDOXSspjFQMEGcTLK1wjRLu8kCFq01B3cg",
            "XQAAAQAOAgAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8NV6XBeOzbVc3/+oJVTjqv2y1/N6rCbssgz6/37r+XBFNJrm2sxuRFXG43VkFXnNuT3FIYJ4XE2Vpwv1rfb+zLEbOKNV3tLLBX8DEZYtFG+Z1OByOz3aWXs6oWU89s10NLCeohQam0TxPsT+7H/ZJcr2ghoQ+D3ZE0dN7f8SpHMYMDweelnW9OnVHYVNvPZtcbfPcsac4G9m1DWhls7QKvP9UEKewxwKrAbTvg1Yi11g=="
        }
    }

    EFGMITEMS["arc9_eft_ump"] = {
        ["fullName"] = "HK UMP .45 ACP submachine gun",
        ["displayName"] = "UMP .45",
        ["displayType"] = "Submachine Gun",
        ["weight"] = 2.2,
        ["value"] = 35000,
        ["levelReq"] = 5,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["equipSlot"] = WEAPONSLOTS.PRIMARY.ID,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/weapons/ump.png", "smooth"),

        ["sizeX"] = 3,
        ["sizeY"] = 2,

        ["caliber"] = ".45",
        ["ammoID"] = "efgm_ammo_45",
        ["defAtts"] = "XQAAAQDEAQAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8LmM+VxqdivzAkNlrd254f2zsoAbSMkGc7K6jqT3wmPoeiLRGobkYLeRB+RlYSNPlrjogENZ5LAajivJRLfrO+7bb9wBK9R2qy+ZF9p6RJySe79wzSD62bV4CmCHDKZ54raGVc8AzqsobkJW01xMjAkg/ILIRZwXI1TAI=",
        ["duelAtts"] = {
            "XQAAAQDEAQAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8LmM+VxqdivzAkNlrd254f2zsoAbSMkGc7K6jqT3wmPoeiLRGobkYLeRB+RlYSNPlrjogENZ5LAajivJRLfrO+7bb9wBK9R2qy+ZF9p6RJySe79wzSD62bV4CmCHDKZ54raGVc8AzqsobkJW01xMjAkg/ILIRZwXI1TAI=",
            "XQAAAQBKAgAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8LmM+VxqdivzAkNlriDPa3WXSCzu8WoBVQiIJPTxqbEnuzIE3oLAlWrAYi0wBuCnS2Ro/2no6lvPETKcw6PQSd7POJIwy5Dhxw2FV13GT1KJD6MY/uJ0qri85EGp3IzxvcMN1Cuojtb8Vf5ukN10GZCUVdlT++RMNGUa/ClTk/wqt2jKSt7vPpVk3CyKi3bz+5zL1K+GgOXQcpGFf7ajiflzUw3BDtSIbRqFeT7Nxpx4OL+w==",
            "XQAAAQBNAgAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8LmM+VxqdivzAkNlriDPa3WXSCzu8WoBVQiIJPTxqbEnuzIE3oLAlWrqudsBL1LLHfyt+TBCwd+99fBJN3nb4AkqX6T2WBPmj2BTsz2RmejNBNf1jjeUmiv0c2qQSqhDrFCqm2lH9sWldVFVzxKgggqOI5seycWrkX0lrVWCxH2TlCP/BbtrZ0Wy7c1J7qUouebB15NQY4aAKE7+800tw162UeoXLz6sJbjgJVULACSvpaKVDt"
        }
    }

    EFGMITEMS["arc9_eft_uzi"] = {
        ["fullName"] = "IWI UZI 9x19 submachine gun",
        ["displayName"] = "UZI",
        ["displayType"] = "Submachine Gun",
        ["weight"] = 3.7,
        ["value"] = 29000,
        ["levelReq"] = 1,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["equipSlot"] = WEAPONSLOTS.PRIMARY.ID,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/weapons/uzi.png", "smooth"),

        ["sizeX"] = 3,
        ["sizeY"] = 2,

        ["caliber"] = "9x19",
        ["ammoID"] = "efgm_ammo_9x19",
        ["defAtts"] = "XQAAAQBUAQAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8OnI8vYf1rCestvC7ZomSDqkEaST9pI/tJWGuLhGPu7F3/hH5jrMd8VPdZo9VfZwp5bXMJsXWD218BSfizcep/epC73lPWFlJdkXkIgRjbmaVBXd3Uky4/py6cCyEUADpEnhlTeCsizpJ6fVOAg8u2peV75Uu5OUoZt5OLno6yow==",
        ["duelAtts"] = {
            "XQAAAQBUAQAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8OnI8vYf1rCestvC7ZomSDqkEaST9pI/tJWGuLhGPu7F3/hH5jrMd8VPdZo9VfZwp5bXMJsXWD218BSfizcep/epC73lPWFlJdkXkIgRjbmaVBXd3Uky4/py6cCyEUADpEnhlTeCsizpJ6fVOAg8u2peV75Uu5OUoZt5OLno6yow==",
            "XQAAAQCEAQAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8OnI8vYf1rCestvC7ZnMLFyQuOYIWPvaNss3j5SZ0ptqHiLp9ZpYUuhDPyp3DvbaGvWItMH1Soxk2gCfYMBrSipVzlmYIOOMSSBrW1iC/b8GzkkkzSHYzTOEIEIXnOF5vdtVo20eZ4o0PK672A/q9iEduYyXac5i5LaIdpBFIa4qxOTnEtrdKpboZbDEapWe16SPwJ8uo=",
            "XQAAAQCTAgAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8OnI8vYf1rCestvC7fh6RIGIusBzAv8wEPc7Xv8e/mBMu8iGTnAjvv35JmRNaH3AYhMIeNg58owUvybAd18xycTlhzpQexrXHauBXwHsOX6PihMtgOT5EzKyO2rxCJL/3Qwyv/C3pMnKVVT2tnfJoWhnD4j93cNm9Q5fcpAOS/qaoG4rIJiYA/+MNnnCvQ1itYkq6WrZz6z5uBO9B70JgZ0cp2VwNS1l9DNJNSFJif8wzFZFxwdHrl1ggDE5gFhi4t95K0E9klxL3AO6BwldqehOYskJacyYOA"
        }
    }

    EFGMITEMS["arc9_eft_uzi_pro"] = {
        ["fullName"] = "IWI UZI PRO Pistol 9x19 submachine gun",
        ["displayName"] = "UZI PRO Pistol",
        ["displayType"] = "Submachine Gun",
        ["weight"] = 1.6,
        ["value"] = 68000,
        ["levelReq"] = 17,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["equipSlot"] = WEAPONSLOTS.PRIMARY.ID,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/weapons/uzi_pro.png", "smooth"),

        ["sizeX"] = 2,
        ["sizeY"] = 1,

        ["caliber"] = "9x19",
        ["ammoID"] = "efgm_ammo_9x19",
        ["defAtts"] = "XQAAAQBMAQAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8OnI8wUUtnKFsnDqksjQsUIr0a9ug53GItJaWG9dXHQsj4p7qnyx5LvF9XSMnbk5vTEPLZSjCOUQ31HUnwDqaOaQcMT2gbJSIRizo0Vpog5GN0YnpbZPPoCVxLg/vc+E3PpGfwFQBBzz3begaoPEp/UI6adqSCDkVxb9nEGOIO/XExtA==",
        ["duelAtts"] = {
            "XQAAAQBMAQAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8OnI8wUUtnKFsnDqksjQsUIr0a9ug53GItJaWG9dXHQsj4p7qnyx5LvF9XSMnbk5vTEPLZSjCOUQ31HUnwDqaOaQcMT2gbJSIRizo0Vpog5GN0YnpbZPPoCVxLg/vc+E3PpGfwFQBBzz3begaoPEp/UI6adqSCDkVxb9nEGOIO/XExtA==",
            "XQAAAQBdAgAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8OnI8wUUtnKFsnDqksjQsUIsHBdPHOE+NfNrxlbTvyBnKBs4OgcMDu88+QvwtFEpIHFYHGlDdAejEKBPSALBZ56C+uWOuv0gx6X09bndSJeynS7Qg8hTplWG8itUMC+cyl1HWyA0t0XjrVGOWO8s+6RwAVzFtI4O9uJvtFd+fHjJQTNYqwjSuPwIIBLPWqRurL5eXq5wbgwZcKWa7AukAvoB5D/dB8877BwAukUE0WjrMNzMCbKlm7tbSd6kJYKgQL7jH17rBSoyM=",
            "XQAAAQBLAgAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8OnI8wUUtnKFsnDqksjQskUZaPY45R5sb2z8eg/NhMlL1rKbpwOXgjW8TOkA/WaAwuTu7RZXS0FIhVGDnEjnuQNLrZyNuco1F3Lbz87XkharvDiIsd2YqbBSiZL0kRZsTIhhEevL8nLYOkbwqeOt66xJeZuMvu58q153BTZYHO65qsNlm7or64L+Y2jvSDvKcN4jnOtsvnT9np7Hg39Fro8c+IffdV45u9V9RONxl2hRjYT3fk2nHQBS/shPy5578va+THJcjGizDg"
        }
    }

    EFGMITEMS["arc9_eft_vector45"] = {
        ["fullName"] = "TDI KRISS Vector Gen.2 .45 ACP submachine gun",
        ["displayName"] = "Vector .45",
        ["displayType"] = "Submachine Gun",
        ["weight"] = 2.6,
        ["value"] = 88000,
        ["levelReq"] = 27,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["equipSlot"] = WEAPONSLOTS.PRIMARY.ID,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/weapons/vector45.png", "smooth"),

        ["sizeX"] = 3,
        ["sizeY"] = 2,

        ["lootWeight"] = 80,

        ["caliber"] = ".45",
        ["ammoID"] = "efgm_ammo_45",
        ["defAtts"] = "XQAAAQCPAgAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8LmM+VxqdivzWrVHCKHCrwkDoGD2H5i0vKMWG4xOnDh+DnfHsrok0+NhhHIvfShgaTM2uRxIz3c3fP25b6aNk1Wo6VIkLhe9IkMCHmUnCfE8JliQPXa2S/ax3xxIMjWVO9wrzDLpOhmUr8U1AnpPf9dvXBkMyoLK8u9w67ZGCc6zu4uJ2lpglAxXXqzQuEGTe03GznPKFlHtCHG8XTEWs7aDtjnLTW7BpFikGo5ieGcVbVL/6DI7laqmKH",
        ["duelAtts"] = {
            "XQAAAQCPAgAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8LmM+VxqdivzWrVHCKHCrwkDoGD2H5i0vKMWG4xOnDh+DnfHsrok0+NhhHIvfShgaTM2uRxIz3c3fP25b6aNk1Wo6VIkLhe9IkMCHmUnCfE8JliQPXa2S/ax3xxIMjWVO9wrzDLpOhmUr8U1AnpPf9dvXBkMyoLK8u9w67ZGCc6zu4uJ2lpglAxXXqzQuEGTe03GznPKFlHtCHG8XTEWs7aDtjnLTW7BpFikGo5ieGcVbVL/6DI7laqmKH",
            "XQAAAQD2AgAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8LmM+VxqdivzWrVHCKHCrwkDyG62H5i0vKMWG4xOnDh+DnfHsrok0+NhhFDWmEGLSc5EbqHMMjlI46XV6l9dT4bMITqE/dxI/gxBOxHWrBJ0yauuj4lHmiAq2iB7a5cRIfM+Nu9pTShnT3xFA3SWQIy4D76FS+HReUeuRdW7LhfOgXpWP/oGXigu4RKHtvd4Og1Llg921i8vuxRbZOapz8fKPrQ+TYqY4Mmfz2hgO+GNaoeJRcRSTO/NCZ2iwa8pZuWdek4TwZ6HWCf282xzbkwV5dhGJ+El0mF7I=",
            "XQAAAQCvAwAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8LmM+VxqdivzWrVHCKHCrwkDoGD2H5i0vKMWG4xOnDh+DnfHsrok0+NhhHIvfrlKJWLqdrxm7qOXifsHGBig6PYuUijQctkJc/H61qjD3XiZyR8RjhncTUbYPJYwiZu2nop6NXaN9fCAvibzSTl7F4bJXCl/c8hKIYGZjdsZb87Wc+92QfoGsGXcpzP1ZDi6dQS1noxCXkAfvklka01cDLjkcwVj/zZ+IhQNMq6Q8L1w0jponzpaUMUaNI697Stb2mr2n4CDpU5NnUnEGz761S0mCBEDBU+wIsTo9y29ABV6R/avThQtAHETiNj7cGnl+uWuyU4fFq7r0NKcBNGqUVFPaltrJTaEtXl+AhfqV+jV/ydIt+sb47"
        }
    }

    EFGMITEMS["arc9_eft_vector9"] = {
        ["fullName"] = "TDI KRISS Vector Gen.2 9x19 submachine gun",
        ["displayName"] = "Vector 9x19",
        ["displayType"] = "Submachine Gun",
        ["weight"] = 2.5,
        ["value"] = 72000,
        ["levelReq"] = 25,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["equipSlot"] = WEAPONSLOTS.PRIMARY.ID,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/weapons/vector9.png", "smooth"),

        ["sizeX"] = 3,
        ["sizeY"] = 2,

        ["lootWeight"] = 80,

        ["caliber"] = "9x19",
        ["ammoID"] = "efgm_ammo_9x19",
        ["defAtts"] = "XQAAAQCQAgAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8LmM+VxqdivzWrVHCKHFK/OKg6tQGfMxTw2sSYzH8DA+yRkukxMuVtnHLd5D+00z1/CuRNFHTCnwPKHYIf7LKMkE93bGmGNu+Y8Gq5MnyO+/Yfii5VZM1JsV31Gp+3yhsu1i7dJ5HK1wd58KR23artZsA/xG0D1QanKxMttmuNLMCEg/QdoFLkrCmcmrwFHrVSXCmZmDOFUTvZpz0KoOIqvseLpVg1/pFx56Kcr1vy1bQmerxUWRbd5ds9zBE6AA==",
        ["duelAtts"] = {
            "XQAAAQCQAgAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8LmM+VxqdivzWrVHCKHFK/OKg6tQGfMxTw2sSYzH8DA+yRkukxMuVtnHLd5D+00z1/CuRNFHTCnwPKHYIf7LKMkE93bGmGNu+Y8Gq5MnyO+/Yfii5VZM1JsV31Gp+3yhsu1i7dJ5HK1wd58KR23artZsA/xG0D1QanKxMttmuNLMCEg/QdoFLkrCmcmrwFHrVSXCmZmDOFUTvZpz0KoOIqvseLpVg1/pFx56Kcr1vy1bQmerxUWRbd5ds9zBE6AA==",
            "XQAAAQDMAgAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8LmM+VxqdivzWrVHCKHFK/OKg6tQGfMxTw2sSYzH8DA+yRkukxMuVtnHLd9LpSwK9rdkr4THM2aMtXYB0lL3e4S6MeXOVBa9AfRotItO9rp+xk8RXpyS/N7sROf1lLIHKVc3eh52H46LVauQw2sKUzU36CvRRAjB5RLo4/YEBcVD5VL7Z94KMsNqPXWpsrLzqawfU4X9GISnquIUgZyYF6ys74Kl4fBmriE0464M+5OP/+k1ZpzK9cmwkoFNoF782khTlcf/u6f7vx9J7QOnNSesxO9ytiAQBSqCiZ5Wh/AA==",
            "XQAAAQBRAwAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8LmM+VxqdivzWrVHCKHFK/O1i4vyuUQToZ2xIkT1vP6K1dQgQ+JZBqL0ipgLlteKoY6Pi/7E1d3WvAGW/temdmaZRx5xKPonin0DjIJ4NzjeEWAJgm6rxDDonLlXCTtNh/1W4Q7fvb5JPL1ln9QR9TJEhcmvDBymWiXvUMY2cpoO9LWzxddqkM2Mv9qqqsbqwmmwqDus41s6R76gFiFFsMOoJE+ecRWupWTEYa6vFk7xtRlNw0duxzEhI+V7Ask5xEUfyfyBJUqgNXrB9+MIhyiNe+COEDay0rkO1U+RD/b64jEFo/9XCFZNSYbHLT3zLyoIM6Gk3LV77vnb+UcVCF1PAsn0oA"
        }
    }

    EFGMITEMS["arc9_eft_pp1901"] = {
        ["fullName"] = "PP-19-01 Vityaz 9x19 submachine gun",
        ["displayName"] = "PP-19-01",
        ["displayType"] = "Submachine Gun",
        ["weight"] = 2.8,
        ["value"] = 22000,
        ["levelReq"] = 3,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["equipSlot"] = WEAPONSLOTS.PRIMARY.ID,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/weapons/pp1901.png", "smooth"),

        ["sizeX"] = 3,
        ["sizeY"] = 2,

        ["caliber"] = "9x19",
        ["ammoID"] = "efgm_ammo_9x19",
        ["defAtts"] = "XQAAAQDlAQAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8Ow0KSg3T7B5vIp3sexto8fQ4pxZDgD8ITlaBezlHariBt2nNgnR5HpjwrHzxjhb/9/KF6dD+MIHNTFA9Kaq3AwXyYvEabaCVx3g+ZYil6ymdOPUBQvS1UrOFsD2D8gDH2tRIcdU/Y4+2Ovh1ui0SKDd+eymaTj8Dwe8TxTXg7gl8WIkGtMU/bmc2opM5I1nzyKCAyGctDw44y",
        ["duelAtts"] = {
            "XQAAAQDlAQAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8Ow0KSg3T7B5vIp3sexto8fQ4pxZDgD8ITlaBezlHariBt2nNgnR5HpjwrHzxjhb/9/KF6dD+MIHNTFA9Kaq3AwXyYvEabaCVx3g+ZYil6ymdOPUBQvS1UrOFsD2D8gDH2tRIcdU/Y4+2Ovh1ui0SKDd+eymaTj8Dwe8TxTXg7gl8WIkGtMU/bmc2opM5I1nzyKCAyGctDw44y",
            "XQAAAQAOAwAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8Ow0KSg3T7B7v1SiaS/BbopiHYssDa0n90/5M+6l3sEiyd39JaxPzfUynF5WnXITpdsCOWaHy9CWwp0YMD4QAiMMUz9x6P+8bK6FO3CbZw992mJdX6pOLOuQqF2gfi5qPDcAMfiKLfzPOePUbKRJKfobWqbbin4XZQHLHTHvZBZ1PcDwG5vNG4RgeCkPm3OSlUK3vlsVu8X3FxoUaiD1Rh59/8MUj0ygUhMDmNoZr96+vYqmAIpaGjsD8xal9p4LmaPQ3RnjwYsbkZ1nVP3kcm9Ogo9axT05NNRgT925ZrWsMt9SmvviA=",
            "XQAAAQCuAgAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8OSdG+ffqYKclyD8T70y25Km5/sPJWP5d/JTnawe/U/XjSElCOExW1zt9+nf7o4C52T2zQfpYOCc/Mbh9A7+34HarLO9Ju3aw/TnD+s4tWurL0+KYNay9EKKIxuERRtccm6tVoDB0b0kiY2hbfuGKmYK5J0xXzqUBs+7SgRDVK7sNuahGfUh/ERqoLfDtmIu9Y1Fh7tHjqIU1wLBZqjBc9iptdiqfnG2KL6Pbv8X2jfwBrEMkmw8gHHLH4Q9ysqVf9qnscVaoc1ErC8e5Nz8rPkbU5RBEBkYQkzYMwR+G/aRsHMTzAbcEdFLpBSQBlLH6w"
        }
    }

    EFGMITEMS["arc9_eft_kedr"] = {
        ["fullName"] = "PP-91 Kedr 9x18PM submachine gun",
        ["displayName"] = "PP-91 Kedr",
        ["displayType"] = "Submachine Gun",
        ["weight"] = 1.5,
        ["value"] = 18000,
        ["levelReq"] = 1,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["equipSlot"] = WEAPONSLOTS.PRIMARY.ID,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/weapons/kedr.png", "smooth"),

        ["sizeX"] = 3,
        ["sizeY"] = 2,

        ["caliber"] = "9x18",
        ["ammoID"] = "efgm_ammo_9x18",
        ["defAtts"] = "XQAAAQCWAAAAAAAAAAA9iIIiM7hMNz0dhJSTKmZ7v+v6J9rfJDxrK5jGCg3BYDHYlRHvfWew2oXx4dsswxofgrYNO0HRMoNogTCUTYwLyG00L3Nll37QQlzZazSRsWCwnl8/RdAzcQ==",
        ["duelAtts"] = {
            "XQAAAQCWAAAAAAAAAAA9iIIiM7hMNz0dhJSTKmZ7v+v6J9rfJDxrK5jGCg3BYDHYlRHvfWew2oXx4dsswxofgrYNO0HRMoNogTCUTYwLyG00L3Nll37QQlzZazSRsWCwnl8/RdAzcQ==",
            "XQAAAQByAQAAAAAAAAA9iIIiM7hMNz0dhIkbkvLjTdSR5gRNNIHH3iMsx5GLCRZN3pPmBmThL96jbORejTkm6S3DomHjNJ0cGxxuwKFmfOxPRkbd5QbWsH5yoncAkzr3JY3+MkEi7fht86GKZYnljiUB0JAVUAblAFyK3SX3iYT+rTPpywW7NAm6FU2ZFg/D+uhycjNQREEGyGOXN+Jnb5OpPBklErgeAA==",
            "XQAAAQAxAQAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8NG7PYIe2Zjcond/+tKjSlpvPBn0GXEMAXBqmibksvHzMFTn7lZno7d2y8k1FkB9P1ivOLgYDeSZJDxCfsM1HB8jUsDTPuVqd/Rbkui1qcxjrd/4NZVj/PxpJjudl+8x2KrLJ+jUIqOdulAA=="
        }
    }

    EFGMITEMS["arc9_eft_ppsh41"] = {
        ["fullName"] = "PPSh-41 7.62x25 submachine gun",
        ["displayName"] = "PPSh-41",
        ["displayType"] = "Submachine Gun",
        ["weight"] = 4.0,
        ["value"] = 26000,
        ["levelReq"] = 1,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["equipSlot"] = WEAPONSLOTS.PRIMARY.ID,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/weapons/ppsh.png", "smooth"),

        ["sizeX"] = 4,
        ["sizeY"] = 2,

        ["caliber"] = "7.62x25",
        ["ammoID"] = "efgm_ammo_762x25",
        ["defAtts"] = "XQAAAQDnAAAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8N0RqirEVRWccrEPmZQy2AqJNRYYwzkZDcKZUlCD0pHntf2w3T13Rz/KFkXhFoHFcbVhF5Tm2+6qGo2yB8pxLI6BVj+ShG5w3yBPFISM1P9c92waE6nUkVmwA=",
        ["duelAtts"] = {
            "XQAAAQDnAAAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8N0RqirEVRWccrEPmZQy2AqJNRYYwzkZDcKZUlCD0pHntf2w3T13Rz/KFkXhFoHFcbVhF5Tm2+6qGo2yB8pxLI6BVj+ShG5w3yBPFISM1P9c92waE6nUkVmwA=",
            "XQAAAQDnAAAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8N0RqirEVRWccrEPmZQy2AqJNRYYwzkZDcKZUlCD0pHntf2w3T13Rz/KFkXhFoHFcbVhF5Tm2+6qGo2yB8pxLI6BVj+SjDTo/GdDwUD8PCDTPSddniDu8kQgA="
        }
    }

    EFGMITEMS["arc9_eft_saiga9"] = {
        ["fullName"] = "Saiga-9 9x19 carbine",
        ["displayName"] = "Saiga-9",
        ["displayType"] = "Submachine Gun",
        ["weight"] = 3.0,
        ["value"] = 17000,
        ["levelReq"] = 1,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["equipSlot"] = WEAPONSLOTS.PRIMARY.ID,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/weapons/saiga9.png", "smooth"),

        ["sizeX"] = 4,
        ["sizeY"] = 2,

        ["caliber"] = "9x19",
        ["ammoID"] = "efgm_ammo_9x19",
        ["defAtts"] = "XQAAAQDoAQAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8Ow0KSg3T7B5vIp3sexto6q0AlysynnEO7AtzYfdOUlVrvx/JoE923Gtn7IextB9sgNGPSe4VIllyjo36FhU/nFYdGyq3CmZqWXXd8kRbdFQ7nRL1Seo1iKx5h577Wfn4q5AY0ZjOMxO/l6+gimmN05PXaFNxchJr3hJXXDy4rW+8NPxNv6MDm6kgs6Ap55yydmmB8CfyhOeFNb5dAKwA=",
        ["duelAtts"] = {
            "XQAAAQDoAQAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8Ow0KSg3T7B5vIp3sexto6q0AlysynnEO7AtzYfdOUlVrvx/JoE923Gtn7IextB9sgNGPSe4VIllyjo36FhU/nFYdGyq3CmZqWXXd8kRbdFQ7nRL1Seo1iKx5h577Wfn4q5AY0ZjOMxO/l6+gimmN05PXaFNxchJr3hJXXDy4rW+8NPxNv6MDm6kgs6Ap55yydmmB8CfyhOeFNb5dAKwA=",
            "XQAAAQDsAQAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8OSdG+ffqYKcUX58jUioMpKaWK+9cAwCYY1t/5MSmtGGpxykjPHZ6nwpSjrgLsqHVf50hUCQHwJvGiRB/NZ/Xl6aUW0mH2gTkZEJeHWJBEFjPA3lNhCYaDKe4momEqqfxMXBRCbAcIyZBORWKVp/OtOojlZhW7k2jmGL0LIjZxrxQ1Ws6ButC26qQnYzbCYokE7rChaXJLPjvHWrE9r70LSgoVIbODs56nZtuapxkvHIHwNZRsceWcYNDcSyf7FwA=",
            "XQAAAQAlAwAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8Ow0KSg3T7B5vIp3sexto6q0AlysynnEO7AtzYfdOUlVrvx/JoE923Gtn7Iexr259L6napBv4EMEi7oW/Z/tDhvisXfWJzhh2KOAAfIebN/6iaDY7XGb0gHdTfV5lEbyRv0ZpQya0PLwC9uVqBd8vgARvSXBgHQyhLc1vtdSLL0cmZMM7OH8qzfKhO46q6UffGLxOoRerdWk7gENyZb2BKEcm4d/tImaQ0KDWSaeqzxeGlvGRwLMPrZ1ueervSxTOrBTeGcAVAz/3xI2zmaZT8iiIeBRtjvVCtTskJZEz+HQJ+cHVYsK2AZLERPbe8RAgG7LUo5AIEL8INHTV2l0g1Ko9pQNqqpJB6rA=="
        }
    }

    EFGMITEMS["arc9_eft_mpx"] = {
        ["fullName"] = "SIG MPX 9x19 submachine gun",
        ["displayName"] = "MPX",
        ["displayType"] = "Submachine Gun",
        ["weight"] = 2.8,
        ["value"] = 54000,
        ["levelReq"] = 10,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["equipSlot"] = WEAPONSLOTS.PRIMARY.ID,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/weapons/mpx.png", "smooth"),

        ["sizeX"] = 4,
        ["sizeY"] = 2,

        ["caliber"] = "9x19",
        ["ammoID"] = "efgm_ammo_9x19",
        ["defAtts"] = "XQAAAQAIAwAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8NV6pNTTPdW6lkrMILLX5Qrf3AjqprlCB+rMOMGzMDhpdxdn1+CTPrYuA8snl2O9gXUVRDBdq0xz4bmZRB1stPHoZFDIOB45A7TWOd3QR+6B11V++6ld/lqUAdsWUC2CWS25KDzyeTZ3LR0hwYWLCXGd/ugZ8DEEB2IwolVBtVRzETc0j5uo56eyEiuilaGz9XB/cLtBN017OouTyw7lazpNIvBLjlSPZbP+bRG2ajC8u6P3GptnJA6FMPlM/BQObqLaZ4wFjAZUNMAAA=",
        ["duelAtts"] = {
            "XQAAAQAIAwAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8NV6pNTTPdW6lkrMILLX5Qrf3AjqprlCB+rMOMGzMDhpdxdn1+CTPrYuA8snl2O9gXUVRDBdq0xz4bmZRB1stPHoZFDIOB45A7TWOd3QR+6B11V++6ld/lqUAdsWUC2CWS25KDzyeTZ3LR0hwYWLCXGd/ugZ8DEEB2IwolVBtVRzETc0j5uo56eyEiuilaGz9XB/cLtBN017OouTyw7lazpNIvBLjlSPZbP+bRG2ajC8u6P3GptnJA6FMPlM/BQObqLaZ4wFjAZUNMAAA=",
            "XQAAAQDhAgAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8NV6pNTTPdW6lkrMILLX5Qrf3AjqprlCB4eux5HLwKzNOp/oymp22T73s+V2PpYBrVzNY9zZsGUTWWVkmONgwBvv86eiJVX1hBJufB3QolKLFXTqLNmI3PiD2azEWQyAteA8GGCvVoFrx/4l0hbRZ3b4mi10TBNefgHAUFHHAopCkIAlWnkOx7tWrMa5k5Hmp/+5UMRXHq9uHofcSyAaS+qPxc0xPe2/RjAJWqxP49EnRl4mRaQfKtXlMAPFu9xLRioGfIK2ewrr03UBE2ze5UzUEU2rObvo3h/8xMF9UKh1mrjKXWUpxo4p3bLVB6puPLdCjuuAA=",
            "XQAAAQAiAwAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8NV6pNTTPdW6lkrMILLX5Qrf3AjqprlCB4eux5HLwKzNOqymzz2AfgOlxNPrz3RvmnM9meFapSJ73u8lSOiB/UxuDn2Xy7gpBIub8TPJXiK2/ki5NHPSJHjaFK8RiHmZ4VPPtC3JTKU81CIzcwwd/DmCHkUTAovxG1C/3wyo86zs8LTjQtdpYol4+Oo7ItWqmTYXYfrxQ5XqGTxRWS9/kv2AwEthw0WJvpm1SBwuOCXUW51lYN5LVOODyZPBIEqTiMkxnjhucfTj9paPpAskpdPYU/xmhq8B8m3DZ/WtZTyd22YLwRgnZYmptixeuI6BBg5RwLSk/PvAA="
        }
    }

    EFGMITEMS["arc9_eft_stm9"] = {
        ["fullName"] = "Soyuz-TM STM-9 Gen.2 9x19 carbine",
        ["displayName"] = "STM-9",
        ["displayType"] = "Submachine Gun",
        ["weight"] = 2.0,
        ["value"] = 43000,
        ["levelReq"] = 6,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["equipSlot"] = WEAPONSLOTS.PRIMARY.ID,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/weapons/stm9.png", "smooth"),

        ["sizeX"] = 4,
        ["sizeY"] = 2,

        ["caliber"] = "9x19",
        ["ammoID"] = "efgm_ammo_9x19",
        ["defAtts"] = "XQAAAQCzAgAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8ONwzg/TnvSdQ0A0yA5XazCbEH/vLw/nHkJ2XqRzfgqw5kSXxscJbZh4RNNwBeDAq3M0aMSoXkMANJpjU51sUzgNodJ4PPq0fK7Y+xa0tOjgmyE9wQpN2AbJlfR2U8LlPKf7ds4bdso0BXQ4Zy5JwA9aaD3KVbcL/4+UH2hqktQ1SLcr8FohdwocdF6EVjGIEn0vyzQNcdeh+o8I1vKa2vzB4WQTDeIeoEZ+FX5BWtzMWI0vYPqvEG9Pu0tZ/w6f7xdb53rUrkNXTEdIFnqbrmQ0Ey2A==",
        ["duelAtts"] = {
            "XQAAAQDkAgAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8ONwzg/TnvSdQ0A0yA5XazCbEH/vLw/nHkJ2XqRzfgqw5kSXxsBEg1epW+2g40B63A559oE1VTQvSIbIvgVyhcCmc+rgFe/GTNpgD2mmjTt7uC5TqsIH6Oyyufut7Ahw53M2E4bfOKQuunwxNv94/N6aOOjZKIOvsp0EdmuSfBoEazrjBKxTiJfRfKj/91dMhcBFVMRxwQif+XBz5AvSQIIuRGtu3JS+hAyC5zHbrRRbFIhyf5Hd9nx6W75rfIb3KRUmu9FlBl5wXkLAWMAkC56F4hV45WGwp8i07M9RtAVT3Vy5Q4jNQC0WQA",
            "XQAAAQCXAwAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8ONwzg/TnvSdQ0A0yA5XazCbEH/vLw/nHkJ2XqRzfgqw5kSXxsBEg1epW+2g40B63A559oE1VTQvSIbIvgVyhcCmc+rgFfARewoGAxhy4a8rn1yGItOWx5zZ4QqBM4kAvQ+Vj5/CgbwddHv4eUWFRtLPR+svP93JA1OSsJdeHaleDZ7TOyhIBjQX4OWR4hHiO73lW+Y1Yg/WeqveaBoEN3NkL9igA39+4edAZ5vLQMgsfBn9Eczf2KNKBFEdDarzj4zDMrywKKIR6TEzwkF/DiIO5ZSxLzpmx4aZ4pk8VFT/XEY/sspgLCX4DZrjsA5GoqWSGmISgs+xwakwdqtnHpyKh3XG+w3eCZJAUGbEYs088xHm2/WHU1RgHsWOUA",
            "XQAAAQC1AwAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8ONwzg/TnvSdQ0A0yA5XazCbEH/vLw/nHkJ2XqRzerF+wI1wssYcyGExAMTQNUDXY/GofH2h6k3ZNFe+yTYLo/o0G38jJb28iQGnI/WRmw72Ug92jE88bylioTWIJ8KGIkUQFiKpOZOmJdzl7kMksMov3yUXiR5g/hdyITEiL7ybr9dJIDrXIHlJqVL1Byfktx3MfUMk9RjsgTPUhLh6qzbycnjRd52goGKYi10Y42RPvwSgKAP3Jlv6KGo2WbMna5UtemHM+ZFG30N72Sj3bVIj6JzRQPUi1pv8LxFTUjhRd6NweGxKfe2tLWGCgztTm8/+Y7blgs1yX6KKPVJda9MMg0Ch6irero/QinXa1DWucjhqXJIhmeETVRqpscAA=="
        }
    }

    EFGMITEMS["arc9_eft_sr2m"] = {
        ["fullName"] = "SR-2M Veresk 9x21 submachine gun",
        ["displayName"] = "SR-2M",
        ["displayType"] = "Submachine Gun",
        ["weight"] = 1.7,
        ["value"] = 53000,
        ["levelReq"] = 14,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["equipSlot"] = WEAPONSLOTS.PRIMARY.ID,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/weapons/sr2m.png", "smooth"),

        ["sizeX"] = 3,
        ["sizeY"] = 2,

        ["caliber"] = "9x21",
        ["ammoID"] = "efgm_ammo_9x21",
        ["defAtts"] = "XQAAAQCSAQAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8OSrn2+R+UR2za4bcZe+/IwUlX0PcpLfPOK5eFMdlDveryivexZNi6fe+Y+ROyxqyj4Dv1Z9BlA2CEZjv7lZ1y1QgkdifYos3wNSlZWqfZQ5+VC+aMRnTvI4iuSZAjthOUSJlcjcAOmLrkR027m8H2Q2st5fIA",
        ["duelAtts"] = {
            "XQAAAQCSAQAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8OSrn2+R+UR2za4bcZe+/IwUlX0PcpLfPOK5eFMdlDveryivexZNi6fe+Y+ROyxqyj4Dv1Z9BlA2CEZjv7lZ1y1QgkdifYos3wNSlZWqfZQ5+VC+aMRnTvI4iuSZAjthOUSJlcjcAOmLrkR027m8H2Q2st5fIA",
            "XQAAAQDDAQAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8OSrn2+ZkMuyrJ5VBQLzUh1FrSwvTyyz5oOv81dzvAEc/QDFw//yOdzn0ANsL3/8vHqTC9CPg+LL36eMOrBRq0YEPuZsc1OXOSyhCSQyOQ1rDu91z8+TTZ/pwetyC8fj54BxGxHFkXWpuLUocJDZVnSrvaSQG96nl2QYIvx9dzdA8al4GHC4KQAU0A",
            "XQAAAQAoAgAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8OSrn2+R+UR2za4bcZe+/IwUlX0PcpLfPOK5eFMdlDveryivexZNi6fe+Y+ROywtAB4YH3SpDqGsDEbJFD3LjVd+k+NvzeYiXEZmc7qPb+WrFo/hiu+SNTUhKTOgHAz8b8ppG946eHokLC69oyvlnie4LnaqspllcwCk3EE/hNMXyJ5STAYRFZvjH9H/CTy9hR/W4aDlfzyKVHPObEOaYCWmRyQ1iPJ75zIp1hX8V0"
        }
    }

    -- launchers
    EFGMITEMS["arc9_eft_fn40gl"] = {
        ["fullName"] = "FN40GL Mk2 40mm grenade launcher",
        ["displayName"] = "FN40GL",
        ["displayType"] = "Launcher",
        ["weight"] = 3.0,
        ["value"] = 290000,
        ["levelReq"] = 40,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["equipSlot"] = WEAPONSLOTS.PRIMARY.ID,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/weapons/fn40gl.png", "smooth"),

        ["sizeX"] = 3,
        ["sizeY"] = 2,

        ["canPurchase"] = false,
        ["lootWeight"] = 25,

        ["caliber"] = "40x46",
        ["ammoID"] = "efgm_ammo_40x46",
        ["defAtts"] = "XQAAAQCrAAAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8LcZnpdAq+1HxvVFYM8yMuG3QVvnwhP32P3T9+b6yx6EtZbue8c+rXbC1/wisVwiACA9z7RE6ODiOAXKohmGfZ731lBAX2dwTm+1X5GW6w0B97mkHiGQA="
    }

    EFGMITEMS["arc9_eft_m32a1"] = {
        ["fullName"] = "Milkor M32A1 MSGL 40mm grenade launcher",
        ["displayName"] = "Milkor M32A1",
        ["displayType"] = "Launcher",
        ["weight"] = 5.4,
        ["value"] = 600000,
        ["levelReq"] = 46,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["equipSlot"] = WEAPONSLOTS.PRIMARY.ID,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/weapons/m32a1.png", "smooth"),

        ["sizeX"] = 4,
        ["sizeY"] = 2,

        ["canPurchase"] = false,
        ["lootWeight"] = 25,

        ["caliber"] = "40x46",
        ["ammoID"] = "efgm_ammo_40x46",
        ["defAtts"] = "XQAAAQAJAQAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8LcZnpdAq+1HxvVFYM8yMuG3QVvnwhP32P3T9+b6yx6EtZbue8dF7Fsj37UUn+7mk9v/HrNRAFGg6nQkIwWTKSU5Ht4euLD+2nV9cVQ5QTQEhTXHfBai51DvzIw0ZoLBPUIiwYXsBVck0Y40MSrORhD3wFxwGQfgA="
    }

    EFGMITEMS["arc9_eft_rshg2"] = {
        ["fullName"] = "RShG-2 72.5mm rocket launcher",
        ["displayName"] = "RShG-2",
        ["displayType"] = "Launcher",
        ["weight"] = 4.0,
        ["value"] = 900000,
        ["levelReq"] = 48,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["equipSlot"] = WEAPONSLOTS.PRIMARY.ID,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/weapons/rshg2.png", "smooth"),

        ["sizeX"] = 4,
        ["sizeY"] = 1,

        ["canPurchase"] = false,
        ["lootWeight"] = 25,

        ["caliber"] = "72.5",
        ["ammoID"] = "efgm_ammo_725"
    }

    -- melee
    EFGMITEMS["arc9_eft_melee_taran"] = {
        ["fullName"] = "PR-Taran Police Baton",
        ["displayName"] = "PR-Taran",
        ["displayType"] = "Melee",
        ["weight"] = 0.7,
        ["value"] = 25000,
        ["levelReq"] = 5,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["equipSlot"] = WEAPONSLOTS.MELEE.ID,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/melee/taran.png", "smooth"),

        ["sizeX"] = 1,
        ["sizeY"] = 2,

        ["canPurchase"] = false
    }

    EFGMITEMS["arc9_eft_melee_6x5"] = {
        ["fullName"] = "6Kh5 Bayonet",
        ["displayName"] = "6Kh5",
        ["displayType"] = "Melee",
        ["weight"] = 0.2,
        ["value"] = 15000,
        ["levelReq"] = 1,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["equipSlot"] = WEAPONSLOTS.MELEE.ID,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/melee/6x5.png", "smooth"),

        ["sizeX"] = 2,
        ["sizeY"] = 1,

        ["canPurchase"] = false
    }

    EFGMITEMS["arc9_eft_melee_akula"] = {
        ["fullName"] = "Akula Push Dagger",
        ["displayName"] = "Akula",
        ["displayType"] = "Melee",
        ["weight"] = 0.1,
        ["value"] = 600000,
        ["levelReq"] = 30,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["equipSlot"] = WEAPONSLOTS.MELEE.ID,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/melee/akula.png", "smooth"),

        ["sizeX"] = 1,
        ["sizeY"] = 1,

        ["lootWeight"] = 50,

        ["canPurchase"] = false
    }

    EFGMITEMS["arc9_eft_melee_wycc"] = {
        ["fullName"] = "Antique Axe",
        ["displayName"] = "Axe",
        ["displayType"] = "Melee",
        ["weight"] = 1.1,
        ["value"] = 70000,
        ["levelReq"] = 15,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["equipSlot"] = WEAPONSLOTS.MELEE.ID,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/melee/axe.png", "smooth"),

        ["sizeX"] = 1,
        ["sizeY"] = 2,

        ["canPurchase"] = false
    }

    EFGMITEMS["arc9_eft_melee_gladius"] = {
        ["fullName"] = "APOK Tactical Wasteland Gladius",
        ["displayName"] = "TWG",
        ["displayType"] = "Melee",
        ["weight"] = 1.2,
        ["value"] = 1000000,
        ["levelReq"] = 48,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["equipSlot"] = WEAPONSLOTS.MELEE.ID,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/melee/gladius.png", "smooth"),

        ["sizeX"] = 1,
        ["sizeY"] = 4,

        ["lootWeight"] = 25,

        ["canPurchase"] = false
    }

    EFGMITEMS["arc9_eft_melee_a2607"] = {
        ["fullName"] = "Bars A-2607 95Kh18 knife",
        ["displayName"] = "A-2607",
        ["displayType"] = "Melee",
        ["weight"] = 0.2,
        ["value"] = 9000,
        ["levelReq"] = 1,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["equipSlot"] = WEAPONSLOTS.MELEE.ID,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/melee/a2607.png", "smooth"),

        ["sizeX"] = 2,
        ["sizeY"] = 1,

        ["canPurchase"] = false
    }

    EFGMITEMS["arc9_eft_melee_a2607d"] = {
        ["fullName"] = "Bars A-2607 Damascus knife",
        ["displayName"] = "A-2607",
        ["displayType"] = "Melee",
        ["weight"] = 0.2,
        ["value"] = 9000,
        ["levelReq"] = 1,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["equipSlot"] = WEAPONSLOTS.MELEE.ID,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/melee/a2607d.png", "smooth"),

        ["sizeX"] = 2,
        ["sizeY"] = 1,

        ["canPurchase"] = false
    }

    EFGMITEMS["arc9_eft_melee_camper"] = {
        ["fullName"] = "Camper Axe",
        ["displayName"] = "Camper",
        ["displayType"] = "Melee",
        ["weight"] = 0.6,
        ["value"] = 30000,
        ["levelReq"] = 5,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["equipSlot"] = WEAPONSLOTS.MELEE.ID,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/melee/camper.png", "smooth"),

        ["sizeX"] = 1,
        ["sizeY"] = 3,

        ["canPurchase"] = false
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

        ["sizeX"] = 4,
        ["sizeY"] = 4,

        ["lootWeight"] = 25,

        ["canPurchase"] = false
    }

    EFGMITEMS["arc9_eft_melee_crash"] = {
        ["fullName"] = "Crash Axe",
        ["displayName"] = "SCA",
        ["displayType"] = "Melee",
        ["weight"] = 1.4,
        ["value"] = 2000000,
        ["levelReq"] = 40,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["equipSlot"] = WEAPONSLOTS.MELEE.ID,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/melee/crash.png", "smooth"),

        ["sizeX"] = 1,
        ["sizeY"] = 3,

        ["lootWeight"] = 25,

        ["canPurchase"] = false
    }

    EFGMITEMS["arc9_eft_melee_cultist"] = {
        ["fullName"] = "Cultist Knife",
        ["displayName"] = "C. Knife",
        ["displayType"] = "Melee",
        ["weight"] = 0.2,
        ["value"] = 750000,
        ["levelReq"] = 48,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["equipSlot"] = WEAPONSLOTS.MELEE.ID,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/melee/cultist.png", "smooth"),

        ["sizeX"] = 2,
        ["sizeY"] = 1,

        ["lootWeight"] = 25,

        ["canPurchase"] = false
    }

    EFGMITEMS["arc9_eft_melee_hultafors"] = {
        ["fullName"] = "Superfors DB 2020 Dead Blow Hammer",
        ["displayName"] = "Dead Blow",
        ["displayType"] = "Melee",
        ["weight"] = 8.4,
        ["value"] = 3000000,
        ["levelReq"] = 48,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["equipSlot"] = WEAPONSLOTS.MELEE.ID,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/melee/deadblow.png", "smooth"),

        ["sizeX"] = 4,
        ["sizeY"] = 1,

        ["lootWeight"] = 25,

        ["canPurchase"] = false
    }

    EFGMITEMS["arc9_eft_melee_fulcrum"] = {
        ["fullName"] = "ER FULCRUM BAYONET",
        ["displayName"] = "ER BAYONET",
        ["displayType"] = "Melee",
        ["weight"] = 0.4,
        ["value"] = 16000,
        ["levelReq"] = 1,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["equipSlot"] = WEAPONSLOTS.MELEE.ID,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/melee/fulcrum.png", "smooth"),

        ["sizeX"] = 2,
        ["sizeY"] = 1,

        ["canPurchase"] = false
    }

    EFGMITEMS["arc9_eft_melee_crowbar"] = {
        ["fullName"] = "Freeman Crowbar",
        ["displayName"] = "Crowbar",
        ["displayType"] = "Melee",
        ["weight"] = 1.9,
        ["value"] = 15000,
        ["levelReq"] = 5,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["equipSlot"] = WEAPONSLOTS.MELEE.ID,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/melee/crowbar.png", "smooth"),

        ["sizeX"] = 1,
        ["sizeY"] = 3,

        ["canPurchase"] = false
    }

    EFGMITEMS["arc9_eft_melee_kiba"] = {
        ["fullName"] = "Kiba Arms Tactical Tomahawk",
        ["displayName"] = "KATT",
        ["displayType"] = "Melee",
        ["weight"] = 1.8,
        ["value"] = 80000,
        ["levelReq"] = 10,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["equipSlot"] = WEAPONSLOTS.MELEE.ID,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/melee/katt.png", "smooth"),

        ["sizeX"] = 1,
        ["sizeY"] = 3,

        ["canPurchase"] = false
    }

    EFGMITEMS["arc9_eft_melee_kukri"] = {
        ["fullName"] = "United Cutlery M48 Tactical Kukri",
        ["displayName"] = "M48 Kukri",
        ["displayType"] = "Melee",
        ["weight"] = 0.4,
        ["value"] = 200000,
        ["levelReq"] = 20,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["equipSlot"] = WEAPONSLOTS.MELEE.ID,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/melee/kukri.png", "smooth"),

        ["sizeX"] = 2,
        ["sizeY"] = 1,

        ["lootWeight"] = 50,

        ["canPurchase"] = false
    }

    EFGMITEMS["arc9_eft_melee_m2"] = {
        ["fullName"] = "Miller Bros. Blades M-2 Tactical Sword",
        ["displayName"] = "M-2",
        ["displayType"] = "Melee",
        ["weight"] = 1.3,
        ["value"] = 1000000,
        ["levelReq"] = 30,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["equipSlot"] = WEAPONSLOTS.MELEE.ID,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/melee/m2.png", "smooth"),

        ["sizeX"] = 1,
        ["sizeY"] = 3,

        ["lootWeight"] = 25,

        ["canPurchase"] = false
    }

    EFGMITEMS["arc9_eft_melee_mpl50"] = {
        ["fullName"] = "MPL-50 entrenching tool",
        ["displayName"] = "MPL-50",
        ["displayType"] = "Melee",
        ["weight"] = 0.8,
        ["value"] = 10000,
        ["levelReq"] = 5,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["equipSlot"] = WEAPONSLOTS.MELEE.ID,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/melee/mpl50.png", "smooth"),

        ["sizeX"] = 1,
        ["sizeY"] = 3,

        ["canPurchase"] = false
    }

    EFGMITEMS["arc9_eft_melee_scythe"] = {
        ["fullName"] = "Old Hand Scythe",
        ["displayName"] = "Scythe",
        ["displayType"] = "Melee",
        ["weight"] = 3.9,
        ["value"] = 3500000,
        ["levelReq"] = 48,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["equipSlot"] = WEAPONSLOTS.MELEE.ID,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/melee/scythe.png", "smooth"),

        ["sizeX"] = 4,
        ["sizeY"] = 2,

        ["canPurchase"] = false
    }

    EFGMITEMS["arc9_eft_melee_rebel"] = {
        ["fullName"] = "Red Rebel Ice Pick",
        ["displayName"] = "RedRebel",
        ["displayType"] = "Melee",
        ["weight"] = 0.6,
        ["value"] = 2500000,
        ["levelReq"] = 30,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["equipSlot"] = WEAPONSLOTS.MELEE.ID,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/melee/rebel.png", "smooth"),

        ["sizeX"] = 1,
        ["sizeY"] = 3,

        ["lootWeight"] = 25,

        ["canPurchase"] = false
    }

    EFGMITEMS["arc9_eft_melee_voodoo"] = {
        ["fullName"] = "SOG Voodoo Hawk Tactical Tomahawk",
        ["displayName"] = "Hawk",
        ["displayType"] = "Melee",
        ["weight"] = 0.8,
        ["value"] = 3600000,
        ["levelReq"] = 35,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["equipSlot"] = WEAPONSLOTS.MELEE.ID,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/melee/voodoo.png", "smooth"),

        ["sizeX"] = 1,
        ["sizeY"] = 2,

        ["lootWeight"] = 25,

        ["canPurchase"] = false
    }

    EFGMITEMS["arc9_eft_melee_sp8"] = {
        ["fullName"] = "SP-8 Survival Machete",
        ["displayName"] = "SP-8",
        ["displayType"] = "Melee",
        ["weight"] = 0.6,
        ["value"] = 64000,
        ["levelReq"] = 25,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["equipSlot"] = WEAPONSLOTS.MELEE.ID,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/melee/sp8.png", "smooth"),

        ["sizeX"] = 1,
        ["sizeY"] = 3,
    }

    EFGMITEMS["arc9_eft_melee_taiga"] = {
        ["fullName"] = "UVSR Taiga-1 Survival Machete",
        ["displayName"] = "Taiga-1",
        ["displayType"] = "Melee",
        ["weight"] = 0.6,
        ["value"] = 500000,
        ["levelReq"] = 40,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["equipSlot"] = WEAPONSLOTS.MELEE.ID,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/melee/taiga.png", "smooth"),

        ["sizeX"] = 1,
        ["sizeY"] = 3,

        ["lootWeight"] = 25,

        ["canPurchase"] = false
    }

    -- grenades
    EFGMITEMS["arc9_eft_f1"] = {
        ["fullName"] = "F-1 hand grenade",
        ["displayName"] = "F-1",
        ["displayType"] = "Grenade",
        ["weight"] = 0.6,
        ["value"] = 15000,
        ["levelReq"] = 1,
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
        ["levelReq"] = 1,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["equipSlot"] = WEAPONSLOTS.GRENADE.ID,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["marketResetLimit"] = 5,
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
        ["levelReq"] = 1,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["equipSlot"] = WEAPONSLOTS.GRENADE.ID,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["marketResetLimit"] = 5,
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
        ["levelReq"] = 4,
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
        ["levelReq"] = 10,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["equipSlot"] = WEAPONSLOTS.GRENADE.ID,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["marketResetLimit"] = 3,
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
        ["levelReq"] = 1,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["equipSlot"] = WEAPONSLOTS.GRENADE.ID,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["marketResetLimit"] = 5,
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
        ["levelReq"] = 4,
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
        ["levelReq"] = 20,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["equipSlot"] = WEAPONSLOTS.GRENADE.ID,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/grenades/rgn.png", "smooth"),

        ["sizeX"] = 1,
        ["sizeY"] = 1,

        ["canPurchase"] = false,
        ["lootWeight"] = 50
    }

    EFGMITEMS["arc9_eft_rgo"] = {
        ["fullName"] = "RGO hand grenade",
        ["displayName"] = "RGO",
        ["displayType"] = "Grenade",
        ["weight"] = 0.5,
        ["value"] = 33000,
        ["levelReq"] = 20,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["equipSlot"] = WEAPONSLOTS.GRENADE.ID,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/grenades/rgo.png", "smooth"),

        ["sizeX"] = 1,
        ["sizeY"] = 1,

        ["canPurchase"] = false,
        ["lootWeight"] = 50
    }

    EFGMITEMS["arc9_eft_v40"] = {
        ["fullName"] = "V40 Mini-Grenade",
        ["displayName"] = "V40",
        ["displayType"] = "Grenade",
        ["weight"] = 0.1,
        ["value"] = 25000,
        ["levelReq"] = 10,
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
        ["levelReq"] = 10,
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
        ["levelReq"] = 10,
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
        ["levelReq"] = 10,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["equipSlot"] = WEAPONSLOTS.GRENADE.ID,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["marketResetLimit"] = 3,
        ["icon"] = Material("items/grenades/zarya.png", "smooth"),

        ["sizeX"] = 1,
        ["sizeY"] = 1
    }

    EFGMITEMS["arc9_eft_anm14"] = {
        ["fullName"] = "AN-M14 Incendiary",
        ["displayName"] = "AN-M14",
        ["displayType"] = "Grenade",
        ["weight"] = 0.2,
        ["value"] = 58500,
        ["levelReq"] = 20,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["equipSlot"] = WEAPONSLOTS.GRENADE.ID,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["marketResetLimit"] = 2,
        ["icon"] = Material("items/grenades/anm14.png", "smooth"),

        ["sizeX"] = 1,
        ["sizeY"] = 1,

        ["lootWeight"] = 75
    }

    -- specials
    EFGMITEMS["arc9_eft_sp81"] = {
        ["fullName"] = "ZiD SP-81 26x75 signal pistol",
        ["displayName"] = "SP-81",
        ["displayType"] = "Pistol",
        ["weight"] = 0.6,
        ["value"] = 25000,
        ["levelReq"] = 10,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["equipSlot"] = WEAPONSLOTS.HOLSTER.ID,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/special/sp81.png", "smooth"),

        ["sizeX"] = 2,
        ["sizeY"] = 1,

        ["caliber"] = "26x75",
        ["ammoID"] = "efgm_ammo_26x75",
        ["defAtts"] = "XQAAAQBMAAAAAAAAAAA9iIIiM7tupQCpjrtGalANz5MWYz8LcZnpdAm+MHx7QSWYVQ05R018qLGy4Ql10Wh0xRhQUdUgz8wGuxkTc1+wcUVnUX80pBNBJA=="
    }

    EFGMITEMS["arc9_eft_rangefinder"] = {
        ["fullName"] = "Vortex Ranger 1500 rangefinder",
        ["displayName"] = "R1500",
        ["displayType"] = "Special",
        ["weight"] = 0.2,
        ["value"] = 20000,
        ["levelReq"] = 1,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["equipSlot"] = WEAPONSLOTS.HOLSTER.ID,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/special/r1500.png", "smooth"),

        ["sizeX"] = 1,
        ["sizeY"] = 1
    }

    EFGMITEMS["arc9_eft_rsp30_white"] = {
        ["fullName"] = "ROP-30 (White)",
        ["displayName"] = "White",
        ["displayType"] = "Grenade",
        ["weight"] = 0.2,
        ["value"] = 12500,
        ["levelReq"] = 1,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["equipSlot"] = WEAPONSLOTS.GRENADE.ID,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/special/rop_white.png", "smooth"),
        ["iconColor"] = ICONCOLORS.White,

        ["sizeX"] = 1,
        ["sizeY"] = 2,

        ["canSpawn"] = false,
        ["canPurchase"] = false
    }

    EFGMITEMS["arc9_eft_rsp30_blue"] = {
        ["fullName"] = "RSP-30 (Blue)",
        ["displayName"] = "Blue",
        ["displayType"] = "Grenade",
        ["weight"] = 0.2,
        ["value"] = 12500,
        ["levelReq"] = 1,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["equipSlot"] = WEAPONSLOTS.GRENADE.ID,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/special/rsp_blue.png", "smooth"),
        ["iconColor"] = ICONCOLORS.Blue,

        ["sizeX"] = 1,
        ["sizeY"] = 2,

        ["canSpawn"] = false,
        ["canPurchase"] = false
    }

    EFGMITEMS["arc9_eft_rsp30_firework"] = {
        ["fullName"] = "RSP-30 (Firework)",
        ["displayName"] = "Firework",
        ["displayType"] = "Grenade",
        ["weight"] = 0.2,
        ["value"] = 12500,
        ["levelReq"] = 1,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["equipSlot"] = WEAPONSLOTS.GRENADE.ID,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/special/rsp_firework.png", "smooth"),
        ["iconColor"] = ICONCOLORS.Purple,

        ["sizeX"] = 1,
        ["sizeY"] = 2,

        ["canSpawn"] = false,
        ["canPurchase"] = false
    }

    EFGMITEMS["arc9_eft_rsp30_green"] = {
        ["fullName"] = "RSP-30 (Green)",
        ["displayName"] = "Green",
        ["displayType"] = "Grenade",
        ["weight"] = 0.2,
        ["value"] = 75000,
        ["levelReq"] = 1,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["equipSlot"] = WEAPONSLOTS.GRENADE.ID,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/special/rsp_green.png", "smooth"),
        ["iconColor"] = ICONCOLORS.Green,

        ["sizeX"] = 1,
        ["sizeY"] = 2,

        ["canPurchase"] = false,
        ["lootWeight"] = 75
    }

    EFGMITEMS["arc9_eft_rsp30_red"] = {
        ["fullName"] = "RSP-30 (Red)",
        ["displayName"] = "Red",
        ["displayType"] = "Grenade",
        ["weight"] = 0.2,
        ["value"] = 12500,
        ["levelReq"] = 1,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["equipSlot"] = WEAPONSLOTS.GRENADE.ID,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/special/rsp_red.png", "smooth"),
        ["iconColor"] = ICONCOLORS.Red,

        ["sizeX"] = 1,
        ["sizeY"] = 2,

        ["canSpawn"] = false,
        ["canPurchase"] = false
    }

    EFGMITEMS["arc9_eft_rsp30_yellow"] = {
        ["fullName"] = "RSP-30 (Yellow)",
        ["displayName"] = "Yellow",
        ["displayType"] = "Grenade",
        ["weight"] = 0.2,
        ["value"] = 12500,
        ["levelReq"] = 1,
        ["equipType"] = EQUIPTYPE.Weapon,
        ["equipSlot"] = WEAPONSLOTS.GRENADE.ID,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/special/rsp_red.png", "smooth"),
        ["iconColor"] = ICONCOLORS.Yellow,

        ["sizeX"] = 1,
        ["sizeY"] = 2,

        ["canSpawn"] = false,
        ["canPurchase"] = false
    }

-- AMMUNITION
    -- pistol cartirdges
    EFGMITEMS["efgm_ammo_762x25"] = {
        ["fullName"] = "7.62x25mm Tokarev",
        ["displayName"] = "7.62x25",
        ["displayType"] = "Ammunition",
        ["weight"] = 0.01,
        ["value"] = 80,
        ["levelReq"] = 1,
        ["equipType"] = EQUIPTYPE.Ammunition,
        ["appearInInventory"] = true,
        ["stackSize"] = 60,
        ["icon"] = Material("items/ammo/762x25.png", "smooth"),
        ["iconColor"] = ICONCOLORS.Yellow,

        ["sizeX"] = 1,
        ["sizeY"] = 1
    }

    EFGMITEMS["efgm_ammo_9x18"] = {
        ["fullName"] = "9x18mm Makarov",
        ["displayName"] = "9x18",
        ["displayType"] = "Ammunition",
        ["weight"] = 0.012,
        ["value"] = 90,
        ["levelReq"] = 1,
        ["equipType"] = EQUIPTYPE.Ammunition,
        ["appearInInventory"] = true,
        ["stackSize"] = 60,
        ["icon"] = Material("items/ammo/9x18.png", "smooth"),
        ["iconColor"] = ICONCOLORS.Yellow,

        ["sizeX"] = 1,
        ["sizeY"] = 1
    }

    EFGMITEMS["efgm_ammo_9x19"] = {
        ["fullName"] = "9x19mm Parabellum",
        ["displayName"] = "9x19",
        ["displayType"] = "Ammunition",
        ["weight"] = 0.005,
        ["value"] = 100,
        ["levelReq"] = 1,
        ["equipType"] = EQUIPTYPE.Ammunition,
        ["appearInInventory"] = true,
        ["stackSize"] = 60,
        ["icon"] = Material("items/ammo/9x19.png", "smooth"),
        ["iconColor"] = ICONCOLORS.Yellow,

        ["sizeX"] = 1,
        ["sizeY"] = 1
    }

    EFGMITEMS["efgm_ammo_9x21"] = {
        ["fullName"] = "9x21mm Gyurza",
        ["displayName"] = "9x21",
        ["displayType"] = "Ammunition",
        ["weight"] = 0.011,
        ["value"] = 190,
        ["levelReq"] = 1,
        ["equipType"] = EQUIPTYPE.Ammunition,
        ["appearInInventory"] = true,
        ["stackSize"] = 60,
        ["marketResetLimit"] = 600,
        ["icon"] = Material("items/ammo/9x21.png", "smooth"),
        ["iconColor"] = ICONCOLORS.Yellow,

        ["sizeX"] = 1,
        ["sizeY"] = 1
    }

    EFGMITEMS["efgm_ammo_357"] = {
        ["fullName"] = ".357 Magnum",
        ["displayName"] = ".357",
        ["displayType"] = "Ammunition",
        ["weight"] = 0.016,
        ["value"] = 100,
        ["levelReq"] = 1,
        ["equipType"] = EQUIPTYPE.Ammunition,
        ["appearInInventory"] = true,
        ["stackSize"] = 60,
        ["icon"] = Material("items/ammo/357.png", "smooth"),
        ["iconColor"] = ICONCOLORS.Yellow,

        ["sizeX"] = 1,
        ["sizeY"] = 1
    }

    EFGMITEMS["efgm_ammo_45"] = {
        ["fullName"] = ".45 ACP",
        ["displayName"] = ".45",
        ["displayType"] = "Ammunition",
        ["weight"] = 0.016,
        ["value"] = 210,
        ["levelReq"] = 1,
        ["equipType"] = EQUIPTYPE.Ammunition,
        ["appearInInventory"] = true,
        ["stackSize"] = 60,
        ["icon"] = Material("items/ammo/45.png", "smooth"),
        ["iconColor"] = ICONCOLORS.Yellow,

        ["sizeX"] = 1,
        ["sizeY"] = 1
    }

    EFGMITEMS["efgm_ammo_50ae"] = {
        ["fullName"] = ".50 Action Express",
        ["displayName"] = ".50 AE",
        ["displayType"] = "Ammunition",
        ["weight"] = 0.029,
        ["value"] = 420,
        ["levelReq"] = 1,
        ["equipType"] = EQUIPTYPE.Ammunition,
        ["appearInInventory"] = true,
        ["stackSize"] = 60,
        ["icon"] = Material("items/ammo/50ae.png", "smooth"),
        ["iconColor"] = ICONCOLORS.Yellow,

        ["sizeX"] = 1,
        ["sizeY"] = 1
    }

    EFGMITEMS["efgm_ammo_20x1"] = {
        ["fullName"] = "20x1mm",
        ["displayName"] = "Disk",
        ["displayType"] = "Ammunition",
        ["weight"] = 0.001,
        ["value"] = 10,
        ["levelReq"] = 1,
        ["equipType"] = EQUIPTYPE.Ammunition,
        ["appearInInventory"] = true,
        ["stackSize"] = 20,
        ["icon"] = Material("items/ammo/20x1.png", "smooth"),
        ["iconColor"] = ICONCOLORS.Yellow,

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
        ["levelReq"] = 1,
        ["equipType"] = EQUIPTYPE.Ammunition,
        ["appearInInventory"] = true,
        ["stackSize"] = 60,
        ["marketResetLimit"] = 1000,
        ["icon"] = Material("items/ammo/46x30.png", "smooth"),
        ["iconColor"] = ICONCOLORS.Yellow,

        ["sizeX"] = 1,
        ["sizeY"] = 1
    }

    EFGMITEMS["efgm_ammo_57x28"] = {
        ["fullName"] = "5.7x28mm FN",
        ["displayName"] = "5.7x28",
        ["displayType"] = "Ammunition",
        ["weight"] = 0.006,
        ["value"] = 310,
        ["levelReq"] = 1,
        ["equipType"] = EQUIPTYPE.Ammunition,
        ["appearInInventory"] = true,
        ["stackSize"] = 60,
        ["marketResetLimit"] = 1000,
        ["icon"] = Material("items/ammo/57x28.png", "smooth"),
        ["iconColor"] = ICONCOLORS.Yellow,

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
        ["levelReq"] = 1,
        ["equipType"] = EQUIPTYPE.Ammunition,
        ["appearInInventory"] = true,
        ["stackSize"] = 60,
        ["marketResetLimit"] = 800,
        ["icon"] = Material("items/ammo/545x39.png", "smooth"),
        ["iconColor"] = ICONCOLORS.Yellow,

        ["sizeX"] = 1,
        ["sizeY"] = 1
    }

    EFGMITEMS["efgm_ammo_556x45"] = {
        ["fullName"] = "5.56x45mm NATO",
        ["displayName"] = "5.56x45",
        ["displayType"] = "Ammunition",
        ["weight"] = 0.012,
        ["value"] = 270,
        ["levelReq"] = 1,
        ["equipType"] = EQUIPTYPE.Ammunition,
        ["appearInInventory"] = true,
        ["stackSize"] = 60,
        ["marketResetLimit"] = 800,
        ["icon"] = Material("items/ammo/556x45.png", "smooth"),
        ["iconColor"] = ICONCOLORS.Yellow,

        ["sizeX"] = 1,
        ["sizeY"] = 1
    }

    EFGMITEMS["efgm_ammo_68x51"] = {
        ["fullName"] = "6.8x51mm",
        ["displayName"] = "6.8x51",
        ["displayType"] = "Ammunition",
        ["weight"] = 0.024,
        ["value"] = 680,
        ["levelReq"] = 1,
        ["equipType"] = EQUIPTYPE.Ammunition,
        ["appearInInventory"] = true,
        ["stackSize"] = 40,
        ["marketResetLimit"] = 600,
        ["icon"] = Material("items/ammo/68x51.png", "smooth"),
        ["iconColor"] = ICONCOLORS.Yellow,

        ["sizeX"] = 1,
        ["sizeY"] = 1
    }

    EFGMITEMS["efgm_ammo_300"] = {
        ["fullName"] = ".300 Blackout",
        ["displayName"] = ".300",
        ["displayType"] = "Ammunition",
        ["weight"] = 0.014,
        ["value"] = 330,
        ["levelReq"] = 1,
        ["equipType"] = EQUIPTYPE.Ammunition,
        ["appearInInventory"] = true,
        ["stackSize"] = 60,
        ["marketResetLimit"] = 800,
        ["icon"] = Material("items/ammo/300.png", "smooth"),
        ["iconColor"] = ICONCOLORS.Yellow,

        ["sizeX"] = 1,
        ["sizeY"] = 1
    }

    EFGMITEMS["efgm_ammo_762x39"] = {
        ["fullName"] = "7.62x39mm",
        ["displayName"] = "7.62x39",
        ["displayType"] = "Ammunition",
        ["weight"] = 0.016,
        ["value"] = 290,
        ["levelReq"] = 1,
        ["equipType"] = EQUIPTYPE.Ammunition,
        ["appearInInventory"] = true,
        ["stackSize"] = 60,
        ["marketResetLimit"] = 800,
        ["icon"] = Material("items/ammo/762x39.png", "smooth"),
        ["iconColor"] = ICONCOLORS.Yellow,

        ["sizeX"] = 1,
        ["sizeY"] = 1
    }

    EFGMITEMS["efgm_ammo_762x51"] = {
        ["fullName"] = "7.62x51mm NATO",
        ["displayName"] = "7.62x51",
        ["displayType"] = "Ammunition",
        ["weight"] = 0.022,
        ["value"] = 360,
        ["levelReq"] = 1,
        ["equipType"] = EQUIPTYPE.Ammunition,
        ["appearInInventory"] = true,
        ["stackSize"] = 40,
        ["marketResetLimit"] = 600,
        ["icon"] = Material("items/ammo/762x51.png", "smooth"),
        ["iconColor"] = ICONCOLORS.Yellow,

        ["sizeX"] = 1,
        ["sizeY"] = 1
    }

    EFGMITEMS["efgm_ammo_308"] = {
        ["fullName"] = ".308 Marlin Express",
        ["displayName"] = ".308 ME",
        ["displayType"] = "Ammunition",
        ["weight"] = 0.024,
        ["value"] = 510,
        ["levelReq"] = 1,
        ["equipType"] = EQUIPTYPE.Ammunition,
        ["appearInInventory"] = true,
        ["stackSize"] = 40,
        ["marketResetLimit"] = 400,
        ["icon"] = Material("items/ammo/308.png", "smooth"),
        ["iconColor"] = ICONCOLORS.Yellow,

        ["sizeX"] = 1,
        ["sizeY"] = 1
    }

    EFGMITEMS["efgm_ammo_762x54"] = {
        ["fullName"] = "7.62x54mmR",
        ["displayName"] = "7.62x54",
        ["displayType"] = "Ammunition",
        ["weight"] = 0.024,
        ["value"] = 350,
        ["levelReq"] = 1,
        ["equipType"] = EQUIPTYPE.Ammunition,
        ["appearInInventory"] = true,
        ["stackSize"] = 40,
        ["marketResetLimit"] = 600,
        ["icon"] = Material("items/ammo/762x54.png", "smooth"),
        ["iconColor"] = ICONCOLORS.Yellow,

        ["sizeX"] = 1,
        ["sizeY"] = 1
    }

    EFGMITEMS["efgm_ammo_338"] = {
        ["fullName"] = ".338 Lapua Magnum",
        ["displayName"] = ".338",
        ["displayType"] = "Ammunition",
        ["weight"] = 0.049,
        ["value"] = 880,
        ["levelReq"] = 1,
        ["equipType"] = EQUIPTYPE.Ammunition,
        ["appearInInventory"] = true,
        ["stackSize"] = 40,
        ["marketResetLimit"] = 150,
        ["icon"] = Material("items/ammo/338.png", "smooth"),
        ["iconColor"] = ICONCOLORS.Yellow,

        ["sizeX"] = 1,
        ["sizeY"] = 1
    }

    EFGMITEMS["efgm_ammo_9x39"] = {
        ["fullName"] = "9x39mm",
        ["displayName"] = "9x39",
        ["displayType"] = "Ammunition",
        ["weight"] = 0.023,
        ["value"] = 400,
        ["levelReq"] = 1,
        ["equipType"] = EQUIPTYPE.Ammunition,
        ["appearInInventory"] = true,
        ["stackSize"] = 60,
        ["marketResetLimit"] = 800,
        ["icon"] = Material("items/ammo/9x39.png", "smooth"),
        ["iconColor"] = ICONCOLORS.Yellow,

        ["sizeX"] = 1,
        ["sizeY"] = 1
    }

    EFGMITEMS["efgm_ammo_93x64"] = {
        ["fullName"] = "9.3x64mm",
        ["displayName"] = "9.3x64",
        ["displayType"] = "Ammunition",
        ["weight"] = 0.042,
        ["value"] = 2200,
        ["levelReq"] = 1,
        ["equipType"] = EQUIPTYPE.Ammunition,
        ["appearInInventory"] = true,
        ["stackSize"] = 40,
        ["marketResetLimit"] = 150,
        ["icon"] = Material("items/ammo/93x64.png", "smooth"),
        ["iconColor"] = ICONCOLORS.Yellow,

        ["sizeX"] = 1,
        ["sizeY"] = 1
    }

    EFGMITEMS["efgm_ammo_366"] = {
        ["fullName"] = ".366 TKM",
        ["displayName"] = ".366",
        ["displayType"] = "Ammunition",
        ["weight"] = 0.019,
        ["value"] = 320,
        ["levelReq"] = 1,
        ["equipType"] = EQUIPTYPE.Ammunition,
        ["appearInInventory"] = true,
        ["stackSize"] = 60,
        ["marketResetLimit"] = 800,
        ["icon"] = Material("items/ammo/366.png", "smooth"),
        ["iconColor"] = ICONCOLORS.Yellow,

        ["sizeX"] = 1,
        ["sizeY"] = 1
    }

    EFGMITEMS["efgm_ammo_127x55"] = {
        ["fullName"] = "12.7x55mm",
        ["displayName"] = "12.7x55",
        ["displayType"] = "Ammunition",
        ["weight"] = 0.055,
        ["value"] = 700,
        ["levelReq"] = 1,
        ["equipType"] = EQUIPTYPE.Ammunition,
        ["appearInInventory"] = true,
        ["stackSize"] = 40,
        ["marketResetLimit"] = 600,
        ["icon"] = Material("items/ammo/127x55.png", "smooth"),
        ["iconColor"] = ICONCOLORS.Yellow,

        ["sizeX"] = 1,
        ["sizeY"] = 1
    }

    EFGMITEMS["efgm_ammo_50bmg"] = {
        ["fullName"] = ".50 BMG",
        ["displayName"] = ".50 BMG",
        ["displayType"] = "Ammunition",
        ["weight"] = 0.1,
        ["value"] = 1300,
        ["levelReq"] = 1,
        ["equipType"] = EQUIPTYPE.Ammunition,
        ["appearInInventory"] = true,
        ["stackSize"] = 20,
        ["marketResetLimit"] = 150,
        ["icon"] = Material("items/ammo/50bmg.png", "smooth"),
        ["iconColor"] = ICONCOLORS.Yellow,

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
        ["levelReq"] = 1,
        ["equipType"] = EQUIPTYPE.Ammunition,
        ["appearInInventory"] = true,
        ["stackSize"] = 20,
        ["icon"] = Material("items/ammo/12gauge.png", "smooth"),
        ["iconColor"] = ICONCOLORS.Yellow,

        ["sizeX"] = 1,
        ["sizeY"] = 1
    }

    EFGMITEMS["efgm_ammo_20gauge"] = {
        ["fullName"] = "20 gauge",
        ["displayName"] = "20/70",
        ["displayType"] = "Ammunition",
        ["weight"] = 0.04,
        ["value"] = 200,
        ["levelReq"] = 1,
        ["equipType"] = EQUIPTYPE.Ammunition,
        ["appearInInventory"] = true,
        ["stackSize"] = 20,
        ["icon"] = Material("items/ammo/20gauge.png", "smooth"),
        ["iconColor"] = ICONCOLORS.Yellow,

        ["sizeX"] = 1,
        ["sizeY"] = 1
    }

    EFGMITEMS["efgm_ammo_4gauge"] = {
        ["fullName"] = "23x75mmR",
        ["displayName"] = "23x75",
        ["displayType"] = "Ammunition",
        ["weight"] = 0.08,
        ["value"] = 420,
        ["levelReq"] = 1,
        ["equipType"] = EQUIPTYPE.Ammunition,
        ["appearInInventory"] = true,
        ["stackSize"] = 20,
        ["marketResetLimit"] = 80,
        ["icon"] = Material("items/ammo/4gauge.png", "smooth"),
        ["iconColor"] = ICONCOLORS.Yellow,

        ["sizeX"] = 1,
        ["sizeY"] = 1
    }

    -- launcher cartirdges
    EFGMITEMS["efgm_ammo_40x46"] = {
        ["fullName"] = "40x46mm",
        ["displayName"] = "40x46",
        ["displayType"] = "Ammunition",
        ["weight"] = 0.23,
        ["value"] = 21000,
        ["levelReq"] = 1,
        ["equipType"] = EQUIPTYPE.Ammunition,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/ammo/40x46.png", "smooth"),
        ["iconColor"] = ICONCOLORS.Yellow,

        ["sizeX"] = 1,
        ["sizeY"] = 1,

        ["canPurchase"] = false
    }

    EFGMITEMS["efgm_ammo_40x53"] = {
        ["fullName"] = "40x53mm",
        ["displayName"] = "40x53",
        ["displayType"] = "Ammunition",
        ["weight"] = 0.25,
        ["value"] = 18000,
        ["levelReq"] = 1,
        ["equipType"] = EQUIPTYPE.Ammunition,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/ammo/40x53.png", "smooth"),
        ["iconColor"] = ICONCOLORS.Yellow,

        ["sizeX"] = 1,
        ["sizeY"] = 1,

        ["canPurchase"] = false
    }

    EFGMITEMS["efgm_ammo_725"] = {
        ["fullName"] = "72.5mm Warhead",
        ["displayName"] = "72.5",
        ["displayType"] = "Ammunition",
        ["weight"] = 0.25,
        ["value"] = 50000,
        ["levelReq"] = 1,
        ["equipType"] = EQUIPTYPE.Ammunition,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/ammo/725.png", "smooth"),
        ["iconColor"] = ICONCOLORS.Yellow,

        ["sizeX"] = 2,
        ["sizeY"] = 1,

        ["canPurchase"] = false
    }

    -- flare cartirdges
    EFGMITEMS["efgm_ammo_26x75"] = {
        ["fullName"] = "26x75mm",
        ["displayName"] = "26x75",
        ["displayType"] = "Ammunition",
        ["weight"] = 0.04,
        ["value"] = 5000,
        ["levelReq"] = 1,
        ["equipType"] = EQUIPTYPE.Ammunition,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["marketResetLimit"] = 10,
        ["icon"] = Material("items/ammo/26x75.png", "smooth"),
        ["iconColor"] = ICONCOLORS.Yellow,

        ["sizeX"] = 1,
        ["sizeY"] = 1,
    }

-- MEDICAL

    EFGMITEMS["efgm_meds_ai2"] = {
        ["fullName"] = "AI-2 medkit",
        ["displayName"] = "AI-2",
        ["displayType"] = "Medical",
        ["weight"] = 0.5,
        ["value"] = 5000,
        ["levelReq"] = 1,
        ["equipType"] = EQUIPTYPE.Consumable,
        ["consumableType"] = "heal",
        ["consumableValue"] = 40,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/meds/ai2.png", "smooth"),
        ["iconColor"] = ICONCOLORS.Red,

        ["sizeX"] = 1,
        ["sizeY"] = 1
    }

    EFGMITEMS["efgm_meds_car"] = {
        ["fullName"] = "Car first aid kit",
        ["displayName"] = "Car",
        ["displayType"] = "Medical",
        ["weight"] = 1,
        ["value"] = 8500,
        ["levelReq"] = 4,
        ["equipType"] = EQUIPTYPE.Consumable,
        ["consumableType"] = "heal",
        ["consumableValue"] = 75,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/meds/car.png", "smooth"),
        ["iconColor"] = ICONCOLORS.Red,

        ["sizeX"] = 2,
        ["sizeY"] = 1
    }

    EFGMITEMS["efgm_meds_ifak"] = {
        ["fullName"] = "IFAK individual first aid kit",
        ["displayName"] = "IFAK",
        ["displayType"] = "Medical",
        ["weight"] = 1,
        ["value"] = 15000,
        ["levelReq"] = 7,
        ["equipType"] = EQUIPTYPE.Consumable,
        ["consumableType"] = "heal",
        ["consumableValue"] = 120,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["marketResetLimit"] = 5,
        ["icon"] = Material("items/meds/ifak.png", "smooth"),
        ["iconColor"] = ICONCOLORS.Red,

        ["sizeX"] = 1,
        ["sizeY"] = 1
    }

    EFGMITEMS["efgm_meds_salewa"] = {
        ["fullName"] = "Salewa first aid kit",
        ["displayName"] = "Salewa",
        ["displayType"] = "Medical",
        ["weight"] = 0.8,
        ["value"] = 28000,
        ["levelReq"] = 14,
        ["equipType"] = EQUIPTYPE.Consumable,
        ["consumableType"] = "heal",
        ["consumableValue"] = 200,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["marketResetLimit"] = 3,
        ["icon"] = Material("items/meds/salewa.png", "smooth"),
        ["iconColor"] = ICONCOLORS.Red,

        ["sizeX"] = 1,
        ["sizeY"] = 2
    }

    EFGMITEMS["efgm_meds_afak"] = {
        ["fullName"] = "AFAK tactical individual first aid kit",
        ["displayName"] = "AFAK",
        ["displayType"] = "Medical",
        ["weight"] = 0.8,
        ["value"] = 36500,
        ["levelReq"] = 21,
        ["equipType"] = EQUIPTYPE.Consumable,
        ["consumableType"] = "heal",
        ["consumableValue"] = 320,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["marketResetLimit"] = 2,
        ["icon"] = Material("items/meds/afak.png", "smooth"),
        ["iconColor"] = ICONCOLORS.Red,

        ["sizeX"] = 1,
        ["sizeY"] = 1
    }

    EFGMITEMS["efgm_meds_grizzly"] = {
        ["fullName"] = "Grizzly medical kit",
        ["displayName"] = "Grizzly",
        ["displayType"] = "Medical",
        ["weight"] = 1.6,
        ["value"] = 55500,
        ["levelReq"] = 28,
        ["equipType"] = EQUIPTYPE.Consumable,
        ["consumableType"] = "heal",
        ["consumableValue"] = 480,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["marketResetLimit"] = 1,
        ["icon"] = Material("items/meds/grizzly.png", "smooth"),
        ["iconColor"] = ICONCOLORS.Red,

        ["sizeX"] = 2,
        ["sizeY"] = 2,

        ["lootWeight"] = 50,
    }

-- KEYS

    EFGMITEMS["efgm_key_workshop_office"] = {
        ["fullName"] = "Workshop Office Key",
        ["displayName"] = "W. Office",
        ["displayType"] = "Concrete Key",
        ["weight"] = 0.2,
        ["value"] = 200000,
        ["equipType"] = EQUIPTYPE.None,
        ["consumableType"] = "key",
        ["consumableValue"] = 5,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/keys/civil.png", "smooth"),
        ["iconColor"] = ICONCOLORS.Green,

        ["sizeX"] = 1,
        ["sizeY"] = 1,

        ["canPurchase"] = false
    }

    EFGMITEMS["efgm_key_workshop_armory"] = {
        ["fullName"] = "Workshop Armory Key",
        ["displayName"] = "W. Armory",
        ["displayType"] = "Concrete Key",
        ["weight"] = 0.2,
        ["value"] = 250000,
        ["equipType"] = EQUIPTYPE.None,
        ["consumableType"] = "key",
        ["consumableValue"] = 5,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/keys/industrial.png", "smooth"),
        ["iconColor"] = ICONCOLORS.Green,

        ["sizeX"] = 1,
        ["sizeY"] = 1,

        ["canPurchase"] = false
    }

    EFGMITEMS["efgm_key_hotel_marked"] = {
        ["fullName"] = "Hotel Marked Room Key",
        ["displayName"] = "Hotel mrk.",
        ["displayType"] = "Concrete Key",
        ["weight"] = 0.2,
        ["value"] = 1250000,
        ["equipType"] = EQUIPTYPE.None,
        ["consumableType"] = "key",
        ["consumableValue"] = 5,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/keys/industrial_marked.png", "smooth"),
        ["iconColor"] = ICONCOLORS.Green,

        ["sizeX"] = 1,
        ["sizeY"] = 1,

        ["canPurchase"] = false,
        ["lootWeight"] = 25
    }

    EFGMITEMS["efgm_key_bigred_meeting"] = {
        ["fullName"] = "Big Red Meeting Room Key",
        ["displayName"] = "Br. Meeting",
        ["displayType"] = "Concrete Key",
        ["weight"] = 0.2,
        ["value"] = 200000,
        ["equipType"] = EQUIPTYPE.None,
        ["consumableType"] = "key",
        ["consumableValue"] = 5,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/keys/dorm.png", "smooth"),
        ["iconColor"] = ICONCOLORS.Green,

        ["sizeX"] = 1,
        ["sizeY"] = 1,

        ["canPurchase"] = false
    }

    EFGMITEMS["efgm_key_ow_admin"] = {
        ["fullName"] = "Old Warehouse Admin Key",
        ["displayName"] = "OW. Admin",
        ["displayType"] = "Concrete Key",
        ["weight"] = 0.2,
        ["value"] = 500000,
        ["equipType"] = EQUIPTYPE.None,
        ["consumableType"] = "key",
        ["consumableValue"] = 5,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/keys/industrial.png", "smooth"),
        ["iconColor"] = ICONCOLORS.Green,

        ["sizeX"] = 1,
        ["sizeY"] = 1,

        ["canPurchase"] = false
    }

    -- EFGMITEMS["efgm_keycard_bunker_entrance"] = {
    --     ["fullName"] = "Bunker Entrance Keycard",
    --     ["displayName"] = "B. Door",
    --     ["displayType"] = "Concrete Key",
    --     ["weight"] = 0.2,
    --     ["value"] = 90000,
    --     ["equipType"] = EQUIPTYPE.None,
    --     ["consumableType"] = "key",
    --     ["consumableValue"] = 5,
    --     ["appearInInventory"] = true,
    --     ["stackSize"] = 1,
    --     ["icon"] = Material("items/keys/keycard_green.png", "smooth"),
    --     ["iconColor"] = ICONCOLORS.Green,

    --     ["sizeX"] = 1,
    --     ["sizeY"] = 1,

    --     ["canPurchase"] = false
    -- }

    -- EFGMITEMS["efgm_keycard_bunker_armory"] = {
    --     ["fullName"] = "Bunker Armory Access Keycard",
    --     ["displayName"] = "B. Armory",
    --     ["displayType"] = "Concrete Key",
    --     ["weight"] = 0.2,
    --     ["value"] = 400000,
    --     ["equipType"] = EQUIPTYPE.None,
    --     ["consumableType"] = "key",
    --     ["consumableValue"] = 5,
    --     ["appearInInventory"] = true,
    --     ["stackSize"] = 1,
    --     ["icon"] = Material("items/keys/keycard_dark_red.png", "smooth"),
    --     ["iconColor"] = ICONCOLORS.Green,

    --     ["sizeX"] = 1,
    --     ["sizeY"] = 1,
    --     ["canPurchase"] = false
    -- }

    EFGMITEMS["efgm_keycard_storage_entrance"] = {
        ["fullName"] = "Storage Building Access Keycard",
        ["displayName"] = "Storage",
        ["displayType"] = "Concrete Key",
        ["weight"] = 0.2,
        ["value"] = 600000,
        ["equipType"] = EQUIPTYPE.None,
        ["consumableType"] = "key",
        ["consumableValue"] = 5,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/keys/keycard_pink.png", "smooth"),
        ["iconColor"] = ICONCOLORS.Green,

        ["sizeX"] = 1,
        ["sizeY"] = 1,
        ["canPurchase"] = false
    }

    EFGMITEMS["efgm_keycard_tunnels"] = {
        ["fullName"] = "Suspicious Keycard With Brown Marking",
        ["displayName"] = "Sus. B",
        ["displayType"] = "Concrete Key",
        ["weight"] = 0.2,
        ["value"] = 500000,
        ["equipType"] = EQUIPTYPE.None,
        ["consumableType"] = "key",
        ["consumableValue"] = 5,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/keys/keycard_brown.png", "smooth"),
        ["iconColor"] = ICONCOLORS.Green,

        ["sizeX"] = 1,
        ["sizeY"] = 1,

        ["canPurchase"] = false
    }

    EFGMITEMS["efgm_key_hotel_maintenance"] = {
        ["fullName"] = "Hotel Maintenance Key",
        ["displayName"] = "Hotel mai.",
        ["displayType"] = "Concrete Key",
        ["weight"] = 0.2,
        ["value"] = 100000,
        ["equipType"] = EQUIPTYPE.None,
        ["consumableType"] = "key",
        ["consumableValue"] = 5,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/keys/checkpoint.png", "smooth"),
        ["iconColor"] = ICONCOLORS.Green,

        ["sizeX"] = 1,
        ["sizeY"] = 1,

        ["canPurchase"] = false
    }

    EFGMITEMS["efgn_key_railway_checkpoint"] = {
        ["fullName"] = "Railway Checkpoint Key",
        ["displayName"] = "Rail Chk.",
        ["displayType"] = "Concrete Key",
        ["weight"] = 0.2,
        ["value"] = 100000,
        ["equipType"] = EQUIPTYPE.None,
        ["consumableType"] = "key",
        ["consumableValue"] = 5,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/keys/checkpoint.png", "smooth"),
        ["iconColor"] = ICONCOLORS.Green,

        ["sizeX"] = 1,
        ["sizeY"] = 1,

        ["canPurchase"] = false
    }

    EFGMITEMS["efgm_key_breakroom"] = {
        ["fullName"] = "Parking Garage Break Room Key",
        ["displayName"] = "Break R.",
        ["displayType"] = "Belmont Key",
        ["weight"] = 0.2,
        ["value"] = 200000,
        ["equipType"] = EQUIPTYPE.None,
        ["consumableType"] = "key",
        ["consumableValue"] = 5,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/keys/industrial.png", "smooth"),
        ["iconColor"] = ICONCOLORS.Green,

        ["sizeX"] = 1,
        ["sizeY"] = 1,

        ["canPurchase"] = false
    }

    EFGMITEMS["efgm_key_kitchen"] = {
        ["fullName"] = "Kitchen Key",
        ["displayName"] = "Kitchen",
        ["displayType"] = "Belmont Key",
        ["weight"] = 0.2,
        ["value"] = 200000,
        ["equipType"] = EQUIPTYPE.None,
        ["consumableType"] = "key",
        ["consumableValue"] = 5,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/keys/civil_belmont.png", "smooth"),
        ["iconColor"] = ICONCOLORS.Green,

        ["sizeX"] = 1,
        ["sizeY"] = 1,

        ["canPurchase"] = false
    }

    EFGMITEMS["efgm_key_fencedoff"] = {
        ["fullName"] = "Fenced Off Area Key",
        ["displayName"] = "Fenced A.",
        ["displayType"] = "Belmont Key",
        ["weight"] = 0.2,
        ["value"] = 200000,
        ["equipType"] = EQUIPTYPE.None,
        ["consumableType"] = "key",
        ["consumableValue"] = 5,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/keys/civil_belmont.png", "smooth"),
        ["iconColor"] = ICONCOLORS.Green,

        ["sizeX"] = 1,
        ["sizeY"] = 1,

        ["canPurchase"] = false
    }

    EFGMITEMS["efgm_key_office_marked"] = {
        ["fullName"] = "Office Marked Room Key",
        ["displayName"] = "Office mrk.",
        ["displayType"] = "Factory Key",
        ["weight"] = 0.2,
        ["value"] = 1450000,
        ["equipType"] = EQUIPTYPE.None,
        ["consumableType"] = "key",
        ["consumableValue"] = 5,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/keys/bloody_marked.png", "smooth"),
        ["iconColor"] = ICONCOLORS.Green,

        ["sizeX"] = 1,
        ["sizeY"] = 1,

        ["canPurchase"] = false,
        ["lootWeight"] = 25
    }

    EFGMITEMS["efgm_key_servers"] = {
        ["fullName"] = "Servers Key",
        ["displayName"] = "Servers",
        ["displayType"] = "Factory Key",
        ["weight"] = 0.2,
        ["value"] = 200000,
        ["equipType"] = EQUIPTYPE.None,
        ["consumableType"] = "key",
        ["consumableValue"] = 5,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/keys/pumping.png", "smooth"),
        ["iconColor"] = ICONCOLORS.Green,

        ["sizeX"] = 1,
        ["sizeY"] = 1,

        ["canPurchase"] = false
    }

    EFGMITEMS["efgm_key_cellars"] = {
        ["fullName"] = "Cellars Key",
        ["displayName"] = "Cellars",
        ["displayType"] = "Factory Key",
        ["weight"] = 0.2,
        ["value"] = 300000,
        ["equipType"] = EQUIPTYPE.None,
        ["consumableType"] = "key",
        ["consumableValue"] = 5,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/keys/pumping.png", "smooth"),
        ["iconColor"] = ICONCOLORS.Green,

        ["sizeX"] = 1,
        ["sizeY"] = 1,

        ["canPurchase"] = false
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
        ["iconColor"] = ICONCOLORS.Purple,

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
        ["iconColor"] = ICONCOLORS.Blue,

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
        ["iconColor"] = ICONCOLORS.Purple,

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
        ["iconColor"] = ICONCOLORS.Purple,

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
        ["iconColor"] = ICONCOLORS.Purple,

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
        ["iconColor"] = ICONCOLORS.Purple,

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
        ["iconColor"] = ICONCOLORS.Blue,

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
        ["iconColor"] = ICONCOLORS.Blue,

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
        ["iconColor"] = ICONCOLORS.Blue,

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
        ["iconColor"] = ICONCOLORS.Blue,

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
        ["iconColor"] = ICONCOLORS.Purple,

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
        ["iconColor"] = ICONCOLORS.Purple,

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
        ["iconColor"] = ICONCOLORS.Purple,

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
        ["iconColor"] = ICONCOLORS.Purple,

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
        ["iconColor"] = ICONCOLORS.Purple,

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
        ["iconColor"] = ICONCOLORS.Blue,

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
        ["iconColor"] = ICONCOLORS.Blue,

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
        ["iconColor"] = ICONCOLORS.Blue,

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
        ["iconColor"] = ICONCOLORS.Blue,

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
        ["iconColor"] = ICONCOLORS.Blue,

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
        ["iconColor"] = ICONCOLORS.Blue,

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
        ["iconColor"] = ICONCOLORS.Blue,

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
        ["iconColor"] = ICONCOLORS.Blue,

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
        ["iconColor"] = ICONCOLORS.Purple,

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
        ["iconColor"] = ICONCOLORS.Blue,

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
        ["iconColor"] = ICONCOLORS.Blue,

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
        ["iconColor"] = ICONCOLORS.Purple,

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
        ["iconColor"] = ICONCOLORS.Blue,

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
        ["iconColor"] = ICONCOLORS.Purple,

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
        ["iconColor"] = ICONCOLORS.Blue,

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
        ["iconColor"] = ICONCOLORS.Purple,

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
        ["iconColor"] = ICONCOLORS.Blue,

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
        ["iconColor"] = ICONCOLORS.Blue,

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
        ["iconColor"] = ICONCOLORS.Blue,

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
        ["iconColor"] = ICONCOLORS.Purple,

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
        ["iconColor"] = ICONCOLORS.Blue,

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
        ["iconColor"] = ICONCOLORS.Blue,

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
        ["iconColor"] = ICONCOLORS.Blue,

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
        ["iconColor"] = ICONCOLORS.Blue,

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
        ["iconColor"] = ICONCOLORS.Blue,

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
        ["iconColor"] = ICONCOLORS.Blue,

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
        ["iconColor"] = ICONCOLORS.Blue,

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
        ["iconColor"] = ICONCOLORS.Purple,

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
        ["iconColor"] = ICONCOLORS.Purple,

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
        ["iconColor"] = ICONCOLORS.Blue,

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
        ["iconColor"] = ICONCOLORS.Blue,

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
        ["iconColor"] = ICONCOLORS.Blue,

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
        ["iconColor"] = ICONCOLORS.Purple,

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
        ["iconColor"] = ICONCOLORS.Purple,

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
        ["iconColor"] = ICONCOLORS.Blue,

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
        ["iconColor"] = ICONCOLORS.Blue,

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
        ["iconColor"] = ICONCOLORS.Blue,

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
        ["iconColor"] = ICONCOLORS.Blue,

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
        ["iconColor"] = ICONCOLORS.Blue,

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
        ["iconColor"] = ICONCOLORS.Blue,

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
        ["iconColor"] = ICONCOLORS.Blue,

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
        ["iconColor"] = ICONCOLORS.Blue,

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
        ["iconColor"] = ICONCOLORS.Blue,

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
        ["iconColor"] = ICONCOLORS.Blue,

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
        ["iconColor"] = ICONCOLORS.Purple,

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
        ["iconColor"] = ICONCOLORS.Blue,

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
        ["iconColor"] = ICONCOLORS.Blue,

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
        ["iconColor"] = ICONCOLORS.Blue,

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
        ["iconColor"] = ICONCOLORS.Blue,

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
        ["iconColor"] = ICONCOLORS.Purple,

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
        ["iconColor"] = ICONCOLORS.Blue,

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
        ["iconColor"] = ICONCOLORS.Blue,

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
        ["iconColor"] = ICONCOLORS.Blue,

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
        ["iconColor"] = ICONCOLORS.Purple,

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
        ["iconColor"] = ICONCOLORS.Purple,

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
        ["iconColor"] = ICONCOLORS.Purple,

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
        ["iconColor"] = ICONCOLORS.Blue,

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
        ["iconColor"] = ICONCOLORS.Purple,

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
        ["iconColor"] = ICONCOLORS.Blue,

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
        ["iconColor"] = ICONCOLORS.Purple,

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
        ["iconColor"] = ICONCOLORS.Green,

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
        ["iconColor"] = ICONCOLORS.Brown,

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
        ["iconColor"] = ICONCOLORS.Blue,

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
        ["iconColor"] = ICONCOLORS.Purple,

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
        ["iconColor"] = ICONCOLORS.Blue,

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
        ["iconColor"] = ICONCOLORS.Blue,

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
        ["iconColor"] = ICONCOLORS.Purple,

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
        ["iconColor"] = ICONCOLORS.Blue,

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
        ["iconColor"] = ICONCOLORS.Blue,

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
        ["iconColor"] = ICONCOLORS.Purple,

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
        ["iconColor"] = ICONCOLORS.Purple,

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
        ["iconColor"] = ICONCOLORS.Purple,

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
        ["iconColor"] = ICONCOLORS.Purple,

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
        ["iconColor"] = ICONCOLORS.Blue,

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
        ["iconColor"] = ICONCOLORS.Brown,

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
        ["iconColor"] = ICONCOLORS.Blue,

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
        ["iconColor"] = ICONCOLORS.Blue,

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
        ["iconColor"] = ICONCOLORS.Purple,

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
        ["iconColor"] = ICONCOLORS.Blue,

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
        ["iconColor"] = ICONCOLORS.Blue,

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
        ["iconColor"] = ICONCOLORS.Blue,

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
        ["iconColor"] = ICONCOLORS.Blue,

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
        ["iconColor"] = ICONCOLORS.Blue,

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
        ["iconColor"] = ICONCOLORS.Blue,

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
        ["iconColor"] = ICONCOLORS.Blue,

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
        ["iconColor"] = ICONCOLORS.Purple,

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
        ["iconColor"] = ICONCOLORS.Blue,

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
        ["iconColor"] = ICONCOLORS.Purple,

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
        ["iconColor"] = ICONCOLORS.Purple,

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
        ["iconColor"] = ICONCOLORS.Purple,

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
        ["iconColor"] = ICONCOLORS.Blue,

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
        ["iconColor"] = ICONCOLORS.Purple,

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
        ["iconColor"] = ICONCOLORS.Purple,

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
        ["iconColor"] = ICONCOLORS.Blue,

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
        ["iconColor"] = ICONCOLORS.Blue,

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
        ["iconColor"] = ICONCOLORS.Blue,

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
        ["iconColor"] = ICONCOLORS.Purple,

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
        ["iconColor"] = ICONCOLORS.Blue,

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
        ["iconColor"] = ICONCOLORS.Blue,

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
        ["iconColor"] = ICONCOLORS.Blue,

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
        ["iconColor"] = ICONCOLORS.Blue,

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
        ["iconColor"] = ICONCOLORS.Blue,

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
        ["iconColor"] = ICONCOLORS.Blue,

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
        ["iconColor"] = ICONCOLORS.Blue,

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
        ["iconColor"] = ICONCOLORS.Purple,

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
        ["iconColor"] = ICONCOLORS.Purple,

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
        ["iconColor"] = ICONCOLORS.Blue,

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
        ["iconColor"] = ICONCOLORS.Blue,

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
        ["iconColor"] = ICONCOLORS.Purple,

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
        ["iconColor"] = ICONCOLORS.Blue,

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
        ["iconColor"] = ICONCOLORS.Blue,

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
        ["iconColor"] = ICONCOLORS.Blue,

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
        ["iconColor"] = ICONCOLORS.Blue,

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
        ["iconColor"] = ICONCOLORS.Blue,

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
        ["iconColor"] = ICONCOLORS.Blue,

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
        ["iconColor"] = ICONCOLORS.Purple,

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
        ["iconColor"] = ICONCOLORS.Purple,

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
        ["iconColor"] = ICONCOLORS.Blue,

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
        ["iconColor"] = ICONCOLORS.Blue,

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
        ["iconColor"] = ICONCOLORS.Blue,

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
        ["iconColor"] = ICONCOLORS.Blue,

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
        ["iconColor"] = ICONCOLORS.Blue,

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
        ["iconColor"] = ICONCOLORS.Purple,

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
        ["iconColor"] = ICONCOLORS.Blue,

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
        ["iconColor"] = ICONCOLORS.Blue,

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
        ["iconColor"] = ICONCOLORS.Purple,

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
        ["iconColor"] = ICONCOLORS.Blue,

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
        ["iconColor"] = ICONCOLORS.Blue,

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
        ["iconColor"] = ICONCOLORS.Blue,

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
        ["iconColor"] = ICONCOLORS.Blue,

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
        ["iconColor"] = ICONCOLORS.Blue,

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
        ["iconColor"] = ICONCOLORS.Blue,

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
        ["iconColor"] = ICONCOLORS.Blue,

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
        ["iconColor"] = ICONCOLORS.Blue,

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
        ["iconColor"] = ICONCOLORS.Blue,

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
        ["iconColor"] = ICONCOLORS.Blue,

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
        ["iconColor"] = ICONCOLORS.Blue,

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
        ["iconColor"] = ICONCOLORS.Purple,

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
        ["iconColor"] = ICONCOLORS.Blue,

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
        ["iconColor"] = ICONCOLORS.Blue,

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
        ["iconColor"] = ICONCOLORS.Blue,

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
        ["iconColor"] = ICONCOLORS.Purple,

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
        ["iconColor"] = ICONCOLORS.Blue,

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
        ["iconColor"] = ICONCOLORS.Blue,

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
        ["iconColor"] = ICONCOLORS.Blue,

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
        ["iconColor"] = ICONCOLORS.Purple,

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
        ["iconColor"] = ICONCOLORS.Blue,

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
        ["iconColor"] = ICONCOLORS.Blue,

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
        ["iconColor"] = ICONCOLORS.Blue,

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
        ["iconColor"] = ICONCOLORS.Blue,

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
        ["iconColor"] = ICONCOLORS.Blue,

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
        ["iconColor"] = ICONCOLORS.Blue,

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
        ["iconColor"] = ICONCOLORS.Blue,

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
        ["iconColor"] = ICONCOLORS.Blue,

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
        ["iconColor"] = ICONCOLORS.Blue,

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
        ["iconColor"] = ICONCOLORS.Purple,

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
        ["iconColor"] = ICONCOLORS.Blue,

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
        ["iconColor"] = ICONCOLORS.Blue,

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
        ["iconColor"] = ICONCOLORS.Blue,

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
        ["iconColor"] = ICONCOLORS.Purple,

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
        ["iconColor"] = ICONCOLORS.Purple,

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
        ["iconColor"] = ICONCOLORS.Blue,

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
        ["iconColor"] = ICONCOLORS.Blue,

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
        ["iconColor"] = ICONCOLORS.Blue,

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
        ["iconColor"] = ICONCOLORS.Blue,

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
        ["iconColor"] = ICONCOLORS.Blue,

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
        ["iconColor"] = ICONCOLORS.Blue,

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
        ["iconColor"] = ICONCOLORS.Blue,

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
        ["iconColor"] = ICONCOLORS.Blue,

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
        ["iconColor"] = ICONCOLORS.Blue,

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
        ["iconColor"] = ICONCOLORS.Blue,

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
        ["iconColor"] = ICONCOLORS.Blue,

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
        ["iconColor"] = ICONCOLORS.Purple,

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
        ["iconColor"] = ICONCOLORS.Purple,

        ["sizeX"] = 1,
        ["sizeY"] = 1,

        ["canPurchase"] = false
    }

    -- dog tags
    EFGMITEMS["efgm_tag_default"] = {
        ["fullName"] = "Dogtag",
        ["displayName"] = "Dogtag",
        ["displayType"] = "Tag",
        ["weight"] = 0.05,
        ["value"] = 1000,
        ["equipType"] = EQUIPTYPE.None,
        ["appearInInventory"] = true,
        ["stackSize"] = 1,
        ["icon"] = Material("items/tags/default.png", "smooth"),
        ["iconColor"] = ICONCOLORS.Blue,

        ["sizeX"] = 1,
        ["sizeY"] = 1,

        ["canPurchase"] = false,
        ["canSpawn"] = false
    }

sellMultiplier = 0.5

-- types:
-- 1 == any item (barring keys and attachments)
-- 2 == military box (weapons, attachments, ammunition)
-- 3 == ammunition box (ammunition, grenades)
-- 4 == medical box (medical items)
-- 5 == barter box (assorted barter items & keys)
-- 6 == attachment box (attachments)
-- 7 == safe (valuable barter items)
-- 8 == filing cabinet (some 1x1 barter items, and keys)

-- format: array[type][items]

function GenerateLootTables()

    LOOT = {}
    LOOT[1] = {}
    LOOT[2] = {}
    LOOT[3] = {}
    LOOT[4] = {}
    LOOT[5] = {}
    LOOT[6] = {}
    LOOT[7] = {}
    LOOT[8] = {}

    for k, v in pairs(EFGMITEMS) do

        -- generic loot pools
        if v.canSpawn == false then continue end

        -- excluded keys bc you can find them fucking everywhere
        if v.displayType != "Belmont Key" and v.displayType != "Concrete Key" and v.displayType != "Factory Key" and v.displayType != "Attachment" and v.displayType != "Accessory" and v.displayType != "Barrel" and v.displayType != "Cover" and v.displayType != "Gas Block" and v.displayType != "Handguard" and v.displayType != "Magazine" and v.displayType != "Mount" and v.displayType != "Pistol Grip" and v.displayType != "Receiver" and v.displayType != "Sight" and v.displayType != "Stock" then

            LOOT[1][k] = v

        end

        if v.displayType == "Assault Carbine" or v.displayType == "Assault Rifle" or v.displayType == "Light Machine Gun" or v.displayType == "Pistol" or v.displayType == "Shotgun" or v.displayType == "Sniper Rifle" or v.displayType == "Marksman Rifle" or v.displayType == "Submachine Gun" or v.displayType == "Launcher" or v.displayType == "Melee" or v.displayType == "Grenade" or v.displayType == "Special" or v.displayType == "Ammunition" or v.displayType == "Foregrip" or v.displayType == "Muzzle" or v.displayType == "Optic" or v.displayType == "Tactical" then

            LOOT[2][k] = v

        end

        if v.displayType == "Ammunition" or v.displayType == "Grenade" then

            LOOT[3][k] = v

        end

        if v.displayType == "Medical" then

            LOOT[4][k] = v

        end

        if v.displayType == "Building" or v.displayType == "Electronic" or v.displayType == "Energy" or v.displayType == "Flammable" or v.displayType == "Household" or v.displayType == "Information" or v.displayType == "Medicine" or v.displayType == "Other" or v.displayType == "Tool" or v.displayType == "Valuable" or v.displayType == "Belmont Key" or v.displayType == "Concrete Key" or v.displayType == "Factory Key" then

            LOOT[5][k] = v

        end

        if v.displayType == "Accessory" or v.displayType == "Barrel" or v.displayType == "Cover" or v.displayType == "Foregrip" or v.displayType == "Gas Block" or v.displayType == "Handguard" or v.displayType == "Magazine" or v.displayType == "Mount" or v.displayType == "Muzzle" or v.displayType == "Optic" or v.displayType == "Pistol Grip" or v.displayType == "Receiver" or v.displayType == "Sight" or v.displayType == "Stock" or v.displayType == "Tactical" then

            LOOT[6][k] = v

        end

        -- specific loot pools

        -- safe loot pool
        if (v.displayType == "Building" or v.displayType == "Electronic" or v.displayType == "Energy" or v.displayType == "Flammable" or v.displayType == "Household" or v.displayType == "Information" or v.displayType == "Medicine" or v.displayType == "Other" or v.displayType == "Tool" or v.displayType == "Valuable") and v.value >= 12000 then

            LOOT[7][k] = v

        end

        -- filing cabinet loot pool
        if ((v.displayType == "Electronic" or v.displayType == "Energy" or v.displayType == "Information" or v.displayType == "Other" or v.displayType == "Valuable" or v.displayType == "Belmont Key" or v.displayType == "Concrete Key" or v.displayType == "Factory Key") and v.sizeX == 1 and v.sizeY == 1) then

            LOOT[8][k] = v

        end

    end

end

function GenerateDuelLoadouts()

    -- types:
    -- 1 == assault rifles
    -- 2 == submachine guns
    -- 3 == light machine guns
    -- 4 == sniper rifles
    -- 5 == marksman rifles
    -- 6 == assault carbines
    -- 7 == shotguns
    -- 8 == secondaries only

    DUEL_PRIMARY = {}
    DUEL_PRIMARY[1] = {}
    DUEL_PRIMARY[2] = {}
    DUEL_PRIMARY[3] = {}
    DUEL_PRIMARY[4] = {}
    DUEL_PRIMARY[5] = {}
    DUEL_PRIMARY[6] = {}
    DUEL_PRIMARY[7] = {}
    DUEL_PRIMARY[8] = {}

    DUEL_SECONDARY = {}
    DUEL_SECONDARY[1] = {}

    for k, v in pairs(EFGMITEMS) do

        if v.displayType == "Assault Rifle" then

            DUEL_PRIMARY[1][k] = v

        end

        if v.displayType == "Submachine Gun" then

            DUEL_PRIMARY[2][k] = v

        end

        if v.displayType == "Light Machine Gun" then

            DUEL_PRIMARY[3][k] = v

        end

        if v.displayType == "Sniper Rifle" then

            DUEL_PRIMARY[4][k] = v

        end

        if v.displayType == "Marksman Rifle" then

            DUEL_PRIMARY[5][k] = v

        end

        if v.displayType == "Assault Carbine" then

            DUEL_PRIMARY[6][k] = v

        end

        if v.displayType == "Shotgun" and v.equipSlot != WEAPONSLOTS.HOLSTER.ID then

            DUEL_PRIMARY[7][k] = v

        end

        if v.equipSlot == WEAPONSLOTS.HOLSTER.ID and v.displayName != "Blicky" and v.displayName != "R1500" and v.displayName != "SP-81" then -- sorry guys no fucking blickies and rangefinders

            DUEL_SECONDARY[1][k] = v

        end

    end

end

function GenerateMarketLimits()

    MARKETLIMITS = {}

    for k, v in pairs(EFGMITEMS) do

        -- generic loot pools
        if v.canPurchase == false then continue end

        if v.marketResetLimit then

            MARKETLIMITS[k] = v.marketResetLimit

        end

    end

end

function SpawnAllLoot()

    if SERVER then

        for _, ent in ipairs(ents.FindByName("efgm_loot")) do

            ent:Fire("SpawnStartLoot", 0, 0)

        end

    end

end

function RespawnAllLoot()

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
            ["description"] = v.Description or "",
            ["weight"] = v.Weight or 0.1,
            ["value"] = v.Value or 10000,
            ["equipType"] = EQUIPTYPE.Attachment,
            ["appearInInventory"] = true,
            ["stackSize"] = 1,
            ["icon"] = v.EFGMIcon or v.Icon,

            ["sizeX"] = v.SizeX or 1,
            ["sizeY"] = v.SizeY or 1,

            ["levelReq"] = v.EFGMLvl or 1,
            ["lootWeight"] = v.EFGMLootWeight or 100

        }

        if v.EFGMCanPurchase == false then EFGMITEMS["arc9_att_" .. v.ShortName].canPurchase = false else EFGMITEMS["arc9_att_" .. v.ShortName].canPurchase = true end

    end

    GenerateLootTables()
    GenerateDuelLoadouts()
    GenerateMarketLimits()

end)

hook.Add("OnReloaded", "AttsItemDefReload", function()

    local arc9atts = ARC9.Attachments

    for k, v in pairs(arc9atts) do

        EFGMITEMS["arc9_att_" .. v.ShortName] = {

            ["fullName"] = v.PrintName,
            ["displayName"] = v.CompactName or v.PrintName,
            ["displayType"] = v.DisplayType or "Attachment",
            ["description"] = v.Description or "",
            ["weight"] = v.Weight or 0.1,
            ["value"] = v.Value or 10000,
            ["equipType"] = EQUIPTYPE.Attachment,
            ["appearInInventory"] = true,
            ["stackSize"] = 1,
            ["icon"] = v.EFGMIcon or v.Icon,

            ["sizeX"] = v.SizeX or 1,
            ["sizeY"] = v.SizeY or 1,

            ["levelReq"] = v.EFGMLvl or 1,
            ["lootWeight"] = v.EFGMLootWeight or 100

        }

        if v.EFGMCanPurchase == false then EFGMITEMS["arc9_att_" .. v.ShortName].canPurchase = false else EFGMITEMS["arc9_att_" .. v.ShortName].canPurchase = true end

    end

    GenerateLootTables()
    GenerateDuelLoadouts()
    GenerateMarketLimits()

end)