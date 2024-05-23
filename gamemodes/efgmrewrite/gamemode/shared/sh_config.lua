-- free look
limV = 35
limH = 70
smooth = 0.5
blockads = false
blockshoot = true

-- weapon arrays for gameplay testing purposes
debugPrimWep = {"arc9_eft_adar15", "arc9_eft_tx15", "arc9_eft_sag_ak545", "arc9_eft_sag_ak545short", "arc9_eft_svt", "arc9_eft_sks", "arc9_eft_vpo136", "arc9_eft_vpo209", "arc9_eft_ak101", "arc9_eft_ak102", "arc9_eft_ak103", "arc9_eft_ak104", "arc9_eft_ak105", "arc9_eft_ak12", "arc9_eft_ak74", "arc9_eft_ak74m", "arc9_eft_akm", "arc9_eft_akms", "arc9_eft_aks74", "arc9_eft_aks74u", "arc9_eft_asval", "arc9_eft_ash12", "arc9_eft_m4a1", "arc9_eft_sa58", "arc9_eft_scarh", "arc9_eft_scarl", "arc9_eft_hk416", "arc9_eft_rd704", "arc9_eft_mcx", "arc9_eft_spear", "arc9_eft_auga1", "arc9_eft_aug", "arc9_eft_avt", "arc9_eft_pkm", "arc9_eft_pkp", "arc9_eft_rpd", "arc9_eft_rpk16", "arc9_eft_m3super90", "arc9_eft_mr43", "arc9_eft_m870", "arc9_eft_saiga12k", "arc9_eft_ks23", "arc9_eft_toz106", "arc9_eft_ai_axmc", "arc9_eft_sr25", "arc9_eft_mosin_infantry", "arc9_eft_mosin_sniper", "arc9_eft_mp18", "arc9_eft_rsass", "arc9_eft_sv98", "arc9_eft_svds", "arc9_eft_vss", "arc9_eft_mp9", "arc9_eft_mp9n", "arc9_eft_fn_p90", "arc9_eft_mp7a1", "arc9_eft_mp7a2", "arc9_eft_ump", "arc9_eft_pp1901", "arc9_eft_kedr", "arc9_eft_ppsh41", "arc9_eft_saiga9", "arc9_eft_mpx", "arc9_eft_stm9", "arc9_eft_sr2m", "arc9_eft_fn40gl"}
debugSecWep = {"arc9_eft_m9a3", "arc9_eft_fn57", "arc9_eft_glock17", "arc9_eft_glock18c", "arc9_eft_glock19x", "arc9_eft_usp", "arc9_eft_pm", "arc9_eft_pb", "arc9_eft_rsh12", "arc9_eft_p226r", "arc9_eft_sr1mp", "arc9_eft_tt33", "arc9_eft_mr43_sawedoff"}
debugNadeWep = {"arc9_eft_f1", "arc9_eft_m18", "arc9_eft_m67", "arc9_eft_m7290", "arc9_eft_rdg2b", "arc9_eft_rgd5", "arc9_eft_rgn", "arc9_eft_rgo", "arc9_eft_vog17", "arc9_eft_vog25", "arc9_eft_zarya"}

-- server convars
if SERVER then

    local infAmmo = {} -- arena mode switches
    infAmmo[true] = "1"
    infAmmo[false] = "0"

    -- modifiers
    local modif = "RecoilAutoControlMult\\t0\\nRecoilKickMult\\t1.25\\nVisualRecoilPunchMult\\t1.5\\nVisualRecoilRollMult\\t1.5\\nVisualRecoilSideMult\\t0.25\\nVisualRecoilUpMult\\t0.25\\nVisualRecoilMult\\t1.66 "
    RunConsoleCommand("arc9_modifiers", modif)
    RunConsoleCommand("arc9_mod_adstime", "1")
    RunConsoleCommand("arc9_mod_bodydamagecancel", "1")
    RunConsoleCommand("arc9_mod_damage", "1")
    RunConsoleCommand("arc9_mod_damagerand", "1")
    RunConsoleCommand("arc9_mod_headshotdamage", "1")
    RunConsoleCommand("arc9_mod_malfunction", "0.2")
    RunConsoleCommand("arc9_mod_muzzlevelocity", "1")
    RunConsoleCommand("arc9_mod_recoil", "0.55")
    RunConsoleCommand("arc9_mod_rpm", "1")
    RunConsoleCommand("arc9_mod_spread", "1")
    RunConsoleCommand("arc9_mod_sprinttime", "1")
    RunConsoleCommand("arc9_mod_visualrecoil", "0.75")

    -- damage falloff (in meters)
    RunConsoleCommand("arc9_eft_mindmgrange", "200")
    RunConsoleCommand("arc9_eft_mindmgrange_sg", "100")
    RunConsoleCommand("arc9_eft_mult_338", "0.75")
    RunConsoleCommand("arc9_eft_mult_bigrifle", "0.75")
    RunConsoleCommand("arc9_eft_mult_carabine", "0.5")
    RunConsoleCommand("arc9_eft_mult_massive", "0.5")
    RunConsoleCommand("arc9_eft_mult_melee", "1")
    RunConsoleCommand("arc9_eft_mult_pistol", "0.5")
    RunConsoleCommand("arc9_eft_mult_rifle", "0.5")
    RunConsoleCommand("arc9_eft_mult_shotgun", "0.5")

    -- mechanics
    RunConsoleCommand("arc9_infinite_ammo", infAmmo[isArena])
    RunConsoleCommand("arc9_realrecoil", "1")
    RunConsoleCommand("arc9_lean", "1")
    RunConsoleCommand("arc9_mod_sway", "1")
    RunConsoleCommand("arc9_mod_freeaim", "1")
    RunConsoleCommand("arc9_breath_slowmo", "0")
    RunConsoleCommand("arc9_manualbolt", "0")
    RunConsoleCommand("arc9_never_ready", "1")
    RunConsoleCommand("arc9_eft_mult_flashbang", "0.4")

    -- physics
    RunConsoleCommand("arc9_bullet_physics", "1")
    RunConsoleCommand("arc9_bullet_gravity", "2")
    RunConsoleCommand("arc9_bullet_drag", "1.5")
    RunConsoleCommand("arc9_ricochet", "1")
    RunConsoleCommand("arc9_mod_penetration", "1")
    RunConsoleCommand("arc9_bullet_lifetime", "5")
    RunConsoleCommand("arc9_bullet_imaginary", "1")

    -- true names
    RunConsoleCommand("arc9_truenames_enforced", "1")
    RunConsoleCommand("arc9_truenames_default", "1")

    -- hud
    RunConsoleCommand("arc9_hud_force_disable", "1")

    -- attachments
    RunConsoleCommand("arc9_atts_nocustomize", "0") -- why would anyone do this
    RunConsoleCommand("arc9_atts_max", "100")
    RunConsoleCommand("arc9_free_atts", "1")
    RunConsoleCommand("arc9_atts_lock", "0")
    RunConsoleCommand("arc9_atts_loseondie", "1")
    RunConsoleCommand("arc9_atts_generateentities", "1")
end

-- client convars
if CLIENT then
    -- controls
    RunConsoleCommand("arc9_toggleads", "0")
    RunConsoleCommand("arc9_autolean", "0")
    RunConsoleCommand("arc9_autoreload", "0")
    RunConsoleCommand("arc9_togglelean", "0")
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
    RunConsoleCommand("arc9_hud_darkmode", "1")
    RunConsoleCommand("arc9_hud_arc9", "0")
    RunConsoleCommand("arc9_killfeed_enable", "1")
    RunConsoleCommand("arc9_killfeed_dynamic", "1")
    RunConsoleCommand("arc9_killfeed_colour", "1")
    RunConsoleCommand("arc9_breath_hud", "1")
    RunConsoleCommand("arc9_breath_pp", "1")
    RunConsoleCommand("arc9_breath_sfx", "1")

    -- hints
    RunConsoleCommand("arc9_hud_nohints", "1")
    RunConsoleCommand("arc9_center_reload_enable", "0")
    RunConsoleCommand("arc9_center_bipod", "1")
    RunConsoleCommand("arc9_center_jam", "1")
    RunConsoleCommand("arc9_center_firemode", "1")
    RunConsoleCommand("arc9_center_firemode_time", "1")
    RunConsoleCommand("arc9_center_overheat", "0")

    -- vm
    RunConsoleCommand("arc9_vm_bobstyle", "0")
    RunConsoleCommand("arc9_fov", "0")
    RunConsoleCommand("arc9_vm_addx", "0")
    RunConsoleCommand("arc9_vm_addy", "0")
    RunConsoleCommand("arc9_vm_addz", "0")

    -- vb
    RunConsoleCommand("arc9_vm_cambob", "1")
    RunConsoleCommand("arc9_vm_cambobwalk", "1")
    RunConsoleCommand("arc9_vm_cambobintensity", "0.66")

    -- tpik
    RunConsoleCommand("arc9_tpik", "1")
    RunConsoleCommand("arc9_tpik_others", "1")
    RunConsoleCommand("arc9_tpik_framerate", "10")

    -- true names
    RunConsoleCommand("arc9_truenames", "1")

    -- performance
    RunConsoleCommand("arc9_cheapscopes", "0")
    RunConsoleCommand("arc9_allflash", "1")

    -- fx
    RunConsoleCommand("arc9_cust_blur", "0")
    RunConsoleCommand("arc9_fx_reloadblur", "0")
    RunConsoleCommand("arc9_fx_animblur", "0")
    RunConsoleCommand("arc9_fx_rtblur", "0")
    RunConsoleCommand("arc9_fx_adsblur", "0")
    RunConsoleCommand("arc9_fx_rtvm", "1")
    RunConsoleCommand("arc9_eject_fx", "0")
    RunConsoleCommand("arc9_eject_time", "-1")
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
    RunConsoleCommand("arc9_autosave", "1")

    -- caching
    RunConsoleCommand("arc9_precache_allsounds_onstartup", "1")
    RunConsoleCommand("arc9_precache_attsmodels_onstartup", "0")
    RunConsoleCommand("arc9_precache_wepmodels_onstartup", "0")
end