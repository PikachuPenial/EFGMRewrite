-- variables
respawnTime = 10

-- weapon arrays for gameplay testing purposes
debugPrimWep = {"arc9_eft_adar15", "arc9_eft_tx15", "arc9_eft_sag_ak545", "arc9_eft_sag_ak545short", "arc9_eft_svt", "arc9_eft_sks", "arc9_eft_vpo136", "arc9_eft_vpo209", "arc9_eft_ak101", "arc9_eft_ak102", "arc9_eft_ak103", "arc9_eft_ak104", "arc9_eft_ak105", "arc9_eft_ak12", "arc9_eft_ak74", "arc9_eft_ak74m", "arc9_eft_akm", "arc9_eft_akms", "arc9_eft_aks74", "arc9_eft_aks74u", "arc9_eft_asval", "arc9_eft_ash12", "arc9_eft_m4a1", "arc9_eft_sa58", "arc9_eft_scarh", "arc9_eft_scarl", "arc9_eft_hk416", "arc9_eft_rd704", "arc9_eft_mcx", "arc9_eft_spear", "arc9_eft_auga1", "arc9_eft_aug", "arc9_eft_avt", "arc9_eft_pkm", "arc9_eft_pkp", "arc9_eft_rpd", "arc9_eft_rpk16", "arc9_eft_m3super90", "arc9_eft_mr43", "arc9_eft_m870", "arc9_eft_saiga12k", "arc9_eft_ks23", "arc9_eft_toz106", "arc9_eft_ai_axmc", "arc9_eft_sr25", "arc9_eft_mosin_infantry", "arc9_eft_mosin_sniper", "arc9_eft_mp18", "arc9_eft_rsass", "arc9_eft_sv98", "arc9_eft_svds", "arc9_eft_vss", "arc9_eft_mp9", "arc9_eft_mp9n", "arc9_eft_fn_p90", "arc9_eft_mp7a1", "arc9_eft_mp7a2", "arc9_eft_ump", "arc9_eft_vector45", "arc9_eft_vector9", "arc9_eft_pp1901", "arc9_eft_kedr", "arc9_eft_ppsh41", "arc9_eft_saiga9", "arc9_eft_mpx", "arc9_eft_stm9", "arc9_eft_sr2m", "arc9_eft_fn40gl", "arc9_eft_vsk94", "arc9_eft_9a91", "arc9_eft_mk47_mutant", "arc9_eft_g36", "arc9_eft_g28", "arc9_eft_mk18_mjolnir", "arc9_eft_mp5", "arc9_eft_mp5k", "arc9_eft_m60e4", "arc9_eft_m60e6", "arc9_eft_m32a1", "arc9_eft_aa12", "arc9_eft_m1a", "arc9_eft_m590", "arc9_eft_mr133", "arc9_eft_mr153", "arc9_eft_mr155", "arc9_eft_t5000", "arc9_eft_m700", "arc9_eft_uzi", "arc9_eft_uzi_pro", "arc9_eft_sr3", "arc9_eft_velociraptor", "arc9_eft_scarx17", "arc9_eft_saiga12fa", "arc9_eft_rshg2", "arc9_eft_vpo101", "arc9_eft_mts255", "arc9_eft_dvl10", "arc9_eft_vpo215", "arc9_eft_mdr", "arc9_eft_mdr556", "arc9_eft_rfb", "arc9_eft_ak50"}
debugSecWep = {"arc9_eft_m9a3", "arc9_eft_pd20", "arc9_eft_deagle_l5", "arc9_eft_deagle_l6", "arc9_eft_deagle_xix", "arc9_eft_fn57", "arc9_eft_glock17", "arc9_eft_glock18c", "arc9_eft_glock19x", "arc9_eft_usp", "arc9_eft_pl15", "arc9_eft_pm", "arc9_eft_pb", "arc9_eft_rsh12", "arc9_eft_p226r", "arc9_eft_sr1mp", "arc9_eft_apb", "arc9_eft_aps", "arc9_eft_tt33", "arc9_eft_mr43_sawedoff", "arc9_eft_m1911", "arc9_eft_m45"}
debugShitSecWep = {"arc9_eft_glock17", "arc9_eft_pm", "arc9_eft_mp443", "arc9_eft_pb", "arc9_eft_tt33", "arc9_eft_mr43_sawedoff", "arc9_eft_kedr", "arc9_eft_mp18"}
debugNadeWep = {"arc9_eft_f1", "arc9_eft_m18", "arc9_eft_m18y", "arc9_eft_m67", "arc9_eft_m7290", "arc9_eft_rdg2b", "arc9_eft_rgd5", "arc9_eft_rgn", "arc9_eft_rgo", "arc9_eft_v40", "arc9_eft_vog17", "arc9_eft_vog25", "arc9_eft_zarya"}
debugMeleeWep = {"arc9_eft_melee_taran", "arc9_eft_melee_6x5", "arc9_eft_melee_akula", "arc9_eft_melee_wycc", "arc9_eft_melee_gladius", "arc9_eft_melee_a2607", "arc9_eft_melee_a2607d", "arc9_eft_melee_camper", "arc9_eft_melee_labris", "arc9_eft_melee_crash", "arc9_eft_melee_cultist", "arc9_eft_melee_fulcrum", "arc9_eft_melee_crowbar", "arc9_eft_melee_kiba", "arc9_eft_melee_kukri", "arc9_eft_melee_m2", "arc9_eft_melee_mpl50", "arc9_eft_melee_rebel", "arc9_eft_melee_voodoo", "arc9_eft_melee_sp8", "arc9_eft_melee_taiga"}

-- get a copy of every attachment loaded by ARC9
debugRandAtts = table.Copy(ARC9.Attachments_Index)

-- swaps the keys with the values, so for flippedDebugPrimWep, ["arc9_eft_tx15"] would equal 2, useful for inventory slot filtering
flippedDebugPrimWep = table.Flip(debugPrimWep)
flippedDebugSecWep = table.Flip(debugSecWep)
flippedDebugNadeWep = table.Flip(debugNadeWep)
flippedDebugMeleeWep = table.Flip(debugMeleeWep)

-- server convars
if SERVER then
    -- modifiers
    local modif = "\\nRecoilKickMult\\t0.75\\nVisualRecoilPunchMult\\t1.5\\nVisualRecoilRollMult\\t1.5\\nVisualRecoilSideMult\\t1\\nVisualRecoilUpMult\\t1\\nVisualRecoilMult\\t3\\nRecoilRandomSideMult\\t1\\nSwayMultMidAir\\t3.33\\nRecoilAutoControlMultShooting\\t0.05\\nRecoilUpMult\\t0.5\\nRecoilAutoControlMult\\t0.66\\nFreeAimRadiusMult\\t1.33\\nSpreadMultSights\\t0.5\\nSwayMultMove\\t1.5 "
    RunConsoleCommand("arc9_modifiers", modif)
    RunConsoleCommand("arc9_mod_adstime", "0.75")
    RunConsoleCommand("arc9_mod_bodydamagecancel", "1")
    RunConsoleCommand("arc9_mod_damage", "1")
    RunConsoleCommand("arc9_mod_damagerand", "1")
    RunConsoleCommand("arc9_mod_headshotdamage", "1")
    RunConsoleCommand("arc9_mod_malfunction", "0.15")
    RunConsoleCommand("arc9_mod_muzzlevelocity", "1")
    RunConsoleCommand("arc9_mod_recoil", "0.75")
    RunConsoleCommand("arc9_mod_rpm", "1")
    RunConsoleCommand("arc9_mod_spread", "1")
    RunConsoleCommand("arc9_mod_dispersionspread", "1")
    RunConsoleCommand("arc9_mod_sprinttime", "1")
    RunConsoleCommand("arc9_mod_visualrecoil", "0.75")
    RunConsoleCommand("arc9_eft_mult_ergo", "1")

    -- damage falloff (in meters)
    RunConsoleCommand("arc9_eft_mindmgrange", "160")
    RunConsoleCommand("arc9_eft_mindmgrange_sg", "100")
    RunConsoleCommand("arc9_eft_mult_338", "0.55")
    RunConsoleCommand("arc9_eft_mult_bigrifle", "0.65")
    RunConsoleCommand("arc9_eft_mult_carabine", "0.4")
    RunConsoleCommand("arc9_eft_mult_massive", "0.45")
    RunConsoleCommand("arc9_eft_mult_melee", "1.5")
    RunConsoleCommand("arc9_eft_mult_pistol", "0.35")
    RunConsoleCommand("arc9_eft_mult_rifle", "0.4")
    RunConsoleCommand("arc9_eft_mult_shotgun", "0.4")
    RunConsoleCommand("arc9_eft_mult_explosive", "1")

    -- mechanics
    if GetConVar("efgm_derivesbox"):GetInt() == 1 then RunConsoleCommand("arc9_infinite_ammo", "0") else RunConsoleCommand("arc9_infinite_ammo", "0") end
    RunConsoleCommand("arc9_mult_defaultammo", "0")
    RunConsoleCommand("arc9_realrecoil", "1")
    RunConsoleCommand("arc9_mod_sway", "1")
    RunConsoleCommand("arc9_mod_freeaim", "1")
    RunConsoleCommand("arc9_breath_slowmo", "0")
    RunConsoleCommand("arc9_manualbolt", "0")
    RunConsoleCommand("arc9_never_ready", "0")
    RunConsoleCommand("arc9_eft_mult_flashbang", "0.4")
    RunConsoleCommand("arc9_eft_taran_jam", "0")
    RunConsoleCommand("arc9_mod_peek", "0")
    RunConsoleCommand("sv_vmanip_pickups", "1")
    RunConsoleCommand("arc9_eft_nontpik_mode", "1")
    RunConsoleCommand("arc9_eft_singleuse_behaviour", "1")

    -- physics
    RunConsoleCommand("arc9_bullet_physics", "1")
    RunConsoleCommand("arc9_bullet_physics_shotguns", "1")
    RunConsoleCommand("arc9_bullet_gravity", "1.6")
    RunConsoleCommand("arc9_bullet_drag", "1")
    RunConsoleCommand("arc9_ricochet", "0")
    RunConsoleCommand("arc9_mod_penetration", "1")
    RunConsoleCommand("arc9_bullet_lifetime", "5")
    RunConsoleCommand("arc9_bullet_imaginary", "0")

    -- true names
    RunConsoleCommand("arc9_truenames_enforced", "1")
    RunConsoleCommand("arc9_truenames_default", "1")

    -- hud
    RunConsoleCommand("arc9_hud_force_disable", "1")

    -- attachments
    RunConsoleCommand("arc9_atts_nocustomize", "0") -- why would anyone do this
    RunConsoleCommand("arc9_atts_generate_entities", "1")
    RunConsoleCommand("arc9_atts_max", "100")
    RunConsoleCommand("arc9_atts_lock", "0")
    RunConsoleCommand("arc9_atts_loseondie", "1")
    if GetConVar("efgm_derivesbox"):GetInt() == 1 then RunConsoleCommand("arc9_free_atts", "0") else RunConsoleCommand("arc9_free_atts", "0") end

    -- caching
    RunConsoleCommand("arc9_precache_sounds_onfirsttake", "0")
    RunConsoleCommand("arc9_precache_attsmodels_onfirsttake", "0")
    RunConsoleCommand("arc9_precache_wepmodels_onfirsttake", "0")
    RunConsoleCommand("arc9_precache_allsounds_onstartup", "1")
    RunConsoleCommand("arc9_precache_attsmodels_onstartup", "1")
    RunConsoleCommand("arc9_precache_wepmodels_onstartup", "1")
end

-- variables for ARC9 multipliers and range, used for modifications that I will make directly in SWEPS
dmgrange = GetConVar("arc9_eft_mindmgrange"):GetInt() / 1000
dmgrange_shotgun = GetConVar("arc9_eft_mindmgrange_sg"):GetInt() / 1000
mult_338 = GetConVar("arc9_eft_mult_338"):GetFloat()
mult_bigrifle = GetConVar("arc9_eft_mult_bigrifle"):GetFloat()
mult_carabine = GetConVar("arc9_eft_mult_carabine"):GetFloat()
mult_massive = GetConVar("arc9_eft_mult_massive"):GetFloat()
mult_melee = GetConVar("arc9_eft_mult_melee"):GetFloat()
mult_pistol = GetConVar("arc9_eft_mult_pistol"):GetFloat()
mult_rifle = GetConVar("arc9_eft_mult_rifle"):GetFloat()
mult_shotgun = GetConVar("arc9_eft_mult_shotgun"):GetFloat()

-- client convars
if CLIENT then
    -- controls
    RunConsoleCommand("arc9_autoreload", "0")
    RunConsoleCommand("arc9_togglepeek", "0")
    RunConsoleCommand("arc9_togglepeek_reset", "0")
    RunConsoleCommand("arc9_togglebreath", "0")

    -- hud
    RunConsoleCommand("arc9_hud_arc9", "0")
    RunConsoleCommand("arc9_cross_enable", "0")
    RunConsoleCommand("arc9_cust_hints", "1")
    RunConsoleCommand("arc9_cust_tips", "0")
    RunConsoleCommand("arc9_hud_color_r", "255")
    RunConsoleCommand("arc9_hud_color_g", "255")
    RunConsoleCommand("arc9_hud_color_b", "255")
    RunConsoleCommand("arc9_hud_lightmode", "0")
    RunConsoleCommand("arc9_hud_arc9", "0")
    RunConsoleCommand("arc9_killfeed_enable", "1")
    RunConsoleCommand("arc9_killfeed_dynamic", "1")
    RunConsoleCommand("arc9_killfeed_colour", "1")
    RunConsoleCommand("arc9_breath_hud", "0")
    RunConsoleCommand("arc9_breath_pp", "0")
    RunConsoleCommand("arc9_breath_sfx", "0")

    -- hints
    RunConsoleCommand("arc9_hud_hints", "0")
    RunConsoleCommand("arc9_center_reload_enable", "0")
    RunConsoleCommand("arc9_center_bipod", "1")
    RunConsoleCommand("arc9_center_jam", "1")
    RunConsoleCommand("arc9_center_firemode", "1")
    RunConsoleCommand("arc9_center_firemode_time", "1")
    RunConsoleCommand("arc9_center_overheat", "0")

    -- vm 
    RunConsoleCommand("arc9_vm_bobstyle", "-1")

    -- vb
    RunConsoleCommand("arc9_vm_cambob", "1")
    RunConsoleCommand("arc9_vm_cambobwalk", "1")
    RunConsoleCommand("arc9_vm_cambobintensity", "0.66")

    -- tpik
    RunConsoleCommand("arc9_tpik", "1")
    RunConsoleCommand("arc9_tpik_framerate", "30")

    -- true names
    RunConsoleCommand("arc9_truenames", "1")

    -- performance
    RunConsoleCommand("arc9_cheapscopes", "0")
    RunConsoleCommand("arc9_allflash", "0")

    -- fx
    RunConsoleCommand("arc9_cust_blur", "1")
    RunConsoleCommand("arc9_fx_reloadblur", "0")
    RunConsoleCommand("arc9_fx_animblur", "0")
    RunConsoleCommand("arc9_fx_rtblur", "0")
    RunConsoleCommand("arc9_fx_adsblur", "0")
    RunConsoleCommand("arc9_fx_rtvm", "1")
    RunConsoleCommand("arc9_eject_fx", "0")
    RunConsoleCommand("arc9_eject_time", "0")
    RunConsoleCommand("arc9_muzzle_light", "1")
    RunConsoleCommand("arc9_muzzle_others", "1")

    -- optics/crosshair
    RunConsoleCommand("arc9_compensate_sens", "1")
    RunConsoleCommand("arc9_reflex_r", "255")
    RunConsoleCommand("arc9_reflex_g", "0")
    RunConsoleCommand("arc9_reflex_b", "0")
    RunConsoleCommand("arc9_scope_r", "255")
    RunConsoleCommand("arc9_scope_g", "0")
    RunConsoleCommand("arc9_scope_b", "0")
    RunConsoleCommand("arc9_cross_enable", "0")
    RunConsoleCommand("arc9_cross_a", "0")
    RunConsoleCommand("arc9_cross_enable", "0")
    RunConsoleCommand("arc9_cross_size_mult", "0")

    -- attachments
    RunConsoleCommand("arc9_autosave", "0")

    -- font
    RunConsoleCommand("arc9_font", "Bender")

    -- visuals
    RunConsoleCommand("cl_new_impact_effects", GetConVar("efgm_visuals_highqualimpactfx"):GetString())

    cvars.AddChangeCallback("efgm_visuals_highqualimpactfx", function(convar_name, value_old, value_new)
        if value_new == "1" then
            RunConsoleCommand("cl_new_impact_effects", "1")
        else
            RunConsoleCommand("cl_new_impact_effects", "0")
        end
    end)
end