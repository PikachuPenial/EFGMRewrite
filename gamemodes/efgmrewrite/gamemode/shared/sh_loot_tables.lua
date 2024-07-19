
-- TODO ASAP: SEPARATE LOOT FOR SPAWNING AND LOOT FOR PURCHASE

sellMultiplier = 1 -- placeholder basically

LOOT = {}

-- types:
-- 1 == weapon
-- 2 == ammo
-- 3 == entities

-- format: array[type][weapon] = {tier(0 to 3)} tier 0 = always, tier 1 = low, tier 2 = uncommon, tier 3 = rare

-- WEAPONS
LOOT[1] = {}

-- assault carbines
LOOT[1]["arc9_eft_adar15"]              = {1}
LOOT[1]["arc9_eft_vsk94"]              = {2}
LOOT[1]["arc9_eft_tx15"]                = {3}
LOOT[1]["arc9_eft_sag_ak545"]           = {2}
LOOT[1]["arc9_eft_sag_ak545short"]      = {2}
LOOT[1]["arc9_eft_svt"]                 = {2}
LOOT[1]["arc9_eft_sks"]                 = {1}
LOOT[1]["arc9_eft_vpo136"]              = {2}
LOOT[1]["arc9_eft_vpo209"]              = {2}

-- assault rifles
LOOT[1]["arc9_eft_ak101"]               = {2}
LOOT[1]["arc9_eft_ak102"]               = {2}
LOOT[1]["arc9_eft_ak103"]               = {2}
LOOT[1]["arc9_eft_ak104"]               = {2}
LOOT[1]["arc9_eft_ak105"]               = {2}
LOOT[1]["arc9_eft_ak12"]                = {3}
LOOT[1]["arc9_eft_ak74"]                = {2}
LOOT[1]["arc9_eft_ak74m"]               = {2}
LOOT[1]["arc9_eft_akm"]                 = {2}
LOOT[1]["arc9_eft_akms"]                = {2}
LOOT[1]["arc9_eft_aks74"]               = {2}
LOOT[1]["arc9_eft_aks74u"]              = {1}
LOOT[1]["arc9_eft_asval"]               = {3}
LOOT[1]["arc9_eft_ash12"]               = {3}
LOOT[1]["arc9_eft_m4a1"]                = {3}
LOOT[1]["arc9_eft_sa58"]                = {3}
LOOT[1]["arc9_eft_scarh"]               = {3}
LOOT[1]["arc9_eft_scarl"]               = {2}
LOOT[1]["arc9_eft_hk416"]               = {3}
LOOT[1]["arc9_eft_9a91"]                = {1}
LOOT[1]["arc9_eft_mk47_mutant"]         = {3}
LOOT[1]["arc9_eft_rd704"]               = {3}
LOOT[1]["arc9_eft_mcx"]                 = {3}
LOOT[1]["arc9_eft_spear"]               = {3}
LOOT[1]["arc9_eft_auga1"]               = {2}
LOOT[1]["arc9_eft_aug"]                 = {2}
LOOT[1]["arc9_eft_avt"]                 = {3}

-- light machine guns
LOOT[1]["arc9_eft_pkm"]                 = {3}
LOOT[1]["arc9_eft_pkp"]                 = {3}
LOOT[1]["arc9_eft_rpd"]                 = {3}
LOOT[1]["arc9_eft_rpk16"]               = {2}

-- pistols
LOOT[1]["arc9_eft_m9a3"]                = {1}
LOOT[1]["arc9_eft_fn57"]                = {2}
-- LOOT[1]["arc9_eft_glock17"]             = {1}
LOOT[1]["arc9_eft_glock18c"]            = {2}
LOOT[1]["arc9_eft_glock19x"]            = {1}
LOOT[1]["arc9_eft_usp"]                 = {1}
-- LOOT[1]["arc9_eft_pm"]                  = {1}
-- LOOT[1]["arc9_eft_pb"]                  = {1}
LOOT[1]["arc9_eft_rsh12"]               = {2}
LOOT[1]["arc9_eft_p226r"]               = {1}
LOOT[1]["arc9_eft_sr1mp"]               = {1}
-- LOOT[1]["arc9_eft_tt33"]                = {1}

-- shotguns
LOOT[1]["arc9_eft_m3super90"]           = {2}
-- LOOT[1]["arc9_eft_mr43_sawedoff"]       = {1}
LOOT[1]["arc9_eft_mr43"]                = {1}
LOOT[1]["arc9_eft_m870"]                = {2}
LOOT[1]["arc9_eft_saiga12k"]            = {2}
LOOT[1]["arc9_eft_ks23"]                = {2}
LOOT[1]["arc9_eft_toz106"]              = {1}

-- sniper/marksman rifles
LOOT[1]["arc9_eft_ai_axmc"]             = {3}
LOOT[1]["arc9_eft_sr25"]                = {3}
LOOT[1]["arc9_eft_mosin_infantry"]      = {1}
LOOT[1]["arc9_eft_mosin_sniper"]        = {2}
-- LOOT[1]["arc9_eft_mp18"]                = {1}
LOOT[1]["arc9_eft_rsass"]               = {3}
LOOT[1]["arc9_eft_sv98"]                = {2}
LOOT[1]["arc9_eft_svds"]                = {3}
LOOT[1]["arc9_eft_vss"]                 = {3}

-- submachine guns
LOOT[1]["arc9_eft_mp9"]                 = {2}
LOOT[1]["arc9_eft_mp9n"]                = {2}
LOOT[1]["arc9_eft_fn_p90"]              = {3}
LOOT[1]["arc9_eft_mp7a1"]               = {3}
LOOT[1]["arc9_eft_mp7a2"]               = {3}
LOOT[1]["arc9_eft_ump"]                 = {1}
LOOT[1]["arc9_eft_pp1901"]              = {2}
-- LOOT[1]["arc9_eft_kedr"]                = {1}
LOOT[1]["arc9_eft_ppsh41"]              = {1}
LOOT[1]["arc9_eft_saiga9"]              = {1}
LOOT[1]["arc9_eft_mpx"]                 = {2}
LOOT[1]["arc9_eft_stm9"]                = {2}
LOOT[1]["arc9_eft_sr2m"]                = {3}

-- grenades and grenade launcher
-- LOOT[1]["arc9_eft_f1"]                  = {1}
LOOT[1]["arc9_eft_fn40gl"]              = {3}
-- LOOT[1]["arc9_eft_m18"]                 = {1}
-- LOOT[1]["arc9_eft_m67"]                 = {1}
-- LOOT[1]["arc9_eft_m7290"]               = {1}
-- LOOT[1]["arc9_eft_rdg2b"]               = {1}
-- LOOT[1]["arc9_eft_rgd5"]                = {1}
-- LOOT[1]["arc9_eft_rgn"]                 = {2}
-- LOOT[1]["arc9_eft_rgo"]                 = {2}
-- LOOT[1]["arc9_eft_vog17"]               = {1}
-- LOOT[1]["arc9_eft_vog25"]               = {1}
-- LOOT[1]["arc9_eft_zarya"]               = {1}

-- melee
-- LOOT[1]["arc9_eft_melee_taran"]      = {2}
-- LOOT[1]["arc9_eft_melee_6x5"]        = {1}
-- LOOT[1]["arc9_eft_melee_wycc"]       = {2}
-- LOOT[1]["arc9_eft_melee_a2607"]      = {1}
-- LOOT[1]["arc9_eft_melee_a2607d"]     = {1}
-- LOOT[1]["arc9_eft_melee_camper"]     = {2}
-- LOOT[1]["arc9_eft_melee_crash"]      = {3}
-- LOOT[1]["arc9_eft_melee_cultist"]    = {3}
-- LOOT[1]["arc9_eft_melee_fulcrum"]    = {1}
-- LOOT[1]["arc9_eft_melee_crowbar"]    = {2}
-- LOOT[1]["arc9_eft_melee_kiba"]       = {2}
-- LOOT[1]["arc9_eft_melee_kukri"]      = {3}
-- LOOT[1]["arc9_eft_melee_m2"]         = {2}
-- LOOT[1]["arc9_eft_melee_mpl50"]      = {2}
-- LOOT[1]["arc9_eft_melee_rebel"]      = {3}
-- LOOT[1]["arc9_eft_melee_voodoo"]     = {3}
-- LOOT[1]["arc9_eft_melee_sp8"]        = {2}
-- LOOT[1]["arc9_eft_melee_hultafors"]  = {3}
-- LOOT[1]["arc9_eft_melee_taiga"]      = {2}

-- ATTACHMENST
LOOT[3] = {}

-- guess what
LOOT[3]["efgm_attach_pack"]             = {0}

-- VALUABLES (they dont exist yet so we will just spawn weapons instead lmao)
LOOT[5] = {}

-- assault carbines
LOOT[5]["arc9_eft_adar15"]              = {1}
LOOT[5]["arc9_eft_vsk94"]              = {2}
LOOT[5]["arc9_eft_tx15"]                = {3}
LOOT[5]["arc9_eft_sag_ak545"]           = {2}
LOOT[5]["arc9_eft_sag_ak545short"]      = {2}
LOOT[5]["arc9_eft_svt"]                 = {2}
LOOT[5]["arc9_eft_sks"]                 = {1}
LOOT[5]["arc9_eft_vpo136"]              = {2}
LOOT[5]["arc9_eft_vpo209"]              = {2}

-- assault rifles
LOOT[5]["arc9_eft_ak101"]               = {2}
LOOT[5]["arc9_eft_ak102"]               = {2}
LOOT[5]["arc9_eft_ak103"]               = {2}
LOOT[5]["arc9_eft_ak104"]               = {2}
LOOT[5]["arc9_eft_ak105"]               = {2}
LOOT[5]["arc9_eft_ak12"]                = {3}
LOOT[5]["arc9_eft_ak74"]                = {2}
LOOT[5]["arc9_eft_ak74m"]               = {2}
LOOT[5]["arc9_eft_akm"]                 = {2}
LOOT[5]["arc9_eft_akms"]                = {2}
LOOT[5]["arc9_eft_aks74"]               = {2}
LOOT[5]["arc9_eft_aks74u"]              = {1}
LOOT[5]["arc9_eft_asval"]               = {3}
LOOT[5]["arc9_eft_ash12"]               = {3}
LOOT[5]["arc9_eft_m4a1"]                = {3}
LOOT[5]["arc9_eft_sa58"]                = {3}
LOOT[5]["arc9_eft_scarh"]               = {3}
LOOT[5]["arc9_eft_scarl"]               = {2}
LOOT[5]["arc9_eft_hk416"]               = {3}
LOOT[5]["arc9_eft_9a91"]                = {1}
LOOT[5]["arc9_eft_mk47_mutant"]         = {3}
LOOT[5]["arc9_eft_rd704"]               = {3}
LOOT[5]["arc9_eft_mcx"]                 = {3}
LOOT[5]["arc9_eft_spear"]               = {3}
LOOT[5]["arc9_eft_auga1"]               = {2}
LOOT[5]["arc9_eft_aug"]                 = {2}
LOOT[5]["arc9_eft_avt"]                 = {3}

-- light machine guns
LOOT[5]["arc9_eft_pkm"]                 = {3}
LOOT[5]["arc9_eft_pkp"]                 = {3}
LOOT[5]["arc9_eft_rpd"]                 = {3}
LOOT[5]["arc9_eft_rpk16"]               = {2}

-- pistols
LOOT[5]["arc9_eft_m9a3"]                = {1}
LOOT[5]["arc9_eft_fn57"]                = {2}
-- LOOT[5]["arc9_eft_glock17"]             = {1}
LOOT[5]["arc9_eft_glock18c"]            = {2}
LOOT[5]["arc9_eft_glock19x"]            = {1}
LOOT[5]["arc9_eft_usp"]                 = {1}
-- LOOT[5]["arc9_eft_pm"]                  = {1}
-- LOOT[5]["arc9_eft_pb"]                  = {1}
LOOT[5]["arc9_eft_rsh12"]               = {2}
LOOT[5]["arc9_eft_p226r"]               = {1}
LOOT[5]["arc9_eft_sr1mp"]               = {1}
-- LOOT[5]["arc9_eft_tt33"]                = {1}

-- shotguns
LOOT[5]["arc9_eft_m3super90"]           = {2}
-- LOOT[5]["arc9_eft_mr43_sawedoff"]       = {1}
LOOT[5]["arc9_eft_mr43"]                = {1}
LOOT[5]["arc9_eft_m870"]                = {2}
LOOT[5]["arc9_eft_saiga12k"]            = {2}
LOOT[5]["arc9_eft_ks23"]                = {2}
LOOT[5]["arc9_eft_toz106"]              = {1}

-- sniper/marksman rifles
LOOT[5]["arc9_eft_ai_axmc"]             = {3}
LOOT[5]["arc9_eft_sr25"]                = {3}
LOOT[5]["arc9_eft_mosin_infantry"]      = {1}
LOOT[5]["arc9_eft_mosin_sniper"]        = {2}
-- LOOT[5]["arc9_eft_mp18"]                = {1}
LOOT[5]["arc9_eft_rsass"]               = {3}
LOOT[5]["arc9_eft_sv98"]                = {2}
LOOT[5]["arc9_eft_svds"]                = {3}
LOOT[5]["arc9_eft_vss"]                 = {3}

-- submachine guns
LOOT[5]["arc9_eft_mp9"]                 = {2}
LOOT[5]["arc9_eft_mp9n"]                = {2}
LOOT[5]["arc9_eft_fn_p90"]              = {3}
LOOT[5]["arc9_eft_mp7a1"]               = {3}
LOOT[5]["arc9_eft_mp7a2"]               = {3}
LOOT[5]["arc9_eft_ump"]                 = {1}
LOOT[5]["arc9_eft_pp1901"]              = {2}
-- LOOT[5]["arc9_eft_kedr"]                = {1}
LOOT[5]["arc9_eft_ppsh41"]              = {1}
LOOT[5]["arc9_eft_saiga9"]              = {1}
LOOT[5]["arc9_eft_mpx"]                 = {2}
LOOT[5]["arc9_eft_stm9"]                = {2}
LOOT[5]["arc9_eft_sr2m"]                = {3}

-- grenades and grenade launcher
-- LOOT[5]["arc9_eft_f1"]                  = {1}
LOOT[5]["arc9_eft_fn40gl"]              = {3}
-- LOOT[5]["arc9_eft_m18"]                 = {1}
-- LOOT[5]["arc9_eft_m67"]                 = {1}
-- LOOT[5]["arc9_eft_m7290"]               = {1}
-- LOOT[5]["arc9_eft_rdg2b"]               = {1}
-- LOOT[5]["arc9_eft_rgd5"]                = {1}
-- LOOT[5]["arc9_eft_rgn"]                 = {2}
-- LOOT[5]["arc9_eft_rgo"]                 = {2}
-- LOOT[5]["arc9_eft_vog17"]               = {1}
-- LOOT[5]["arc9_eft_vog25"]               = {1}
-- LOOT[5]["arc9_eft_zarya"]               = {1}

-- melee
-- LOOT[5]["arc9_eft_melee_taran"]      = {2}
-- LOOT[5]["arc9_eft_melee_6x5"]        = {1}
-- LOOT[5]["arc9_eft_melee_wycc"]       = {2}
-- LOOT[5]["arc9_eft_melee_a2607"]      = {1}
-- LOOT[5]["arc9_eft_melee_a2607d"]     = {1}
-- LOOT[5]["arc9_eft_melee_camper"]     = {2}
-- LOOT[5]["arc9_eft_melee_crash"]      = {3}
-- LOOT[5]["arc9_eft_melee_cultist"]    = {3}
-- LOOT[5]["arc9_eft_melee_fulcrum"]    = {1}
-- LOOT[5]["arc9_eft_melee_crowbar"]    = {2}
-- LOOT[5]["arc9_eft_melee_kiba"]       = {2}
-- LOOT[5]["arc9_eft_melee_kukri"]      = {3}
-- LOOT[5]["arc9_eft_melee_m2"]         = {2}
-- LOOT[5]["arc9_eft_melee_mpl50"]      = {2}
-- LOOT[5]["arc9_eft_melee_rebel"]      = {3}
-- LOOT[5]["arc9_eft_melee_voodoo"]     = {3}
-- LOOT[5]["arc9_eft_melee_sp8"]        = {2}
-- LOOT[5]["arc9_eft_melee_hultafors"]  = {3}
-- LOOT[5]["arc9_eft_melee_taiga"]      = {2}