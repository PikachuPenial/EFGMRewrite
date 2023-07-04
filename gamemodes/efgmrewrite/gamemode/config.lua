-- free look
limV = 45
limH = 90
smooth = 1.00
blockads = true
blockshoot = true

-- weapon arrays for gameplay testing purposes
debugPrimWep = {"arc9_eft_adar15", "arc9_eft_tx15", "arc9_eft_sag_ak545", "arc9_eft_sag_ak545short", "arc9_eft_vpo136", "arc9_eft_vpo209", "arc9_eft_ak101", "arc9_eft_ak102", "arc9_eft_ak103", "arc9_eft_ak104", "arc9_eft_ak105", "arc9_eft_ak74", "arc9_eft_ak74m", "arc9_eft_akm", "arc9_eft_akms", "arc9_eft_aks74", "arc9_eft_aks74u", "arc9_eft_ash12", "arc9_eft_m4a1", "arc9_eft_hk416", "arc9_eft_rd704", "arc9_eft_rpk16", "arc9_eft_m3super90", "arc9_eft_mp18", "arc9_eft_saiga12k", "arc9_eft_toz106", "arc9_eft_ai_axmc", "arc9_eft_fn_p90", "arc9_eft_ump", "arc9_eft_pp1901", "arc9_eft_saiga9", "arc9_eft_sr2m"}
debugSecWep = {"arc9_eft_m9a3", "arc9_eft_fn57", "arc9_eft_glock17", "arc9_eft_glock18c", "arc9_eft_glock19x", "arc9_eft_usp", "arc9_eft_rsh12", "arc9_eft_sr1mp"}

-- server convars
if SERVER then
    -- modifiers
    local modif = "RecoilAutoControlMult\\t0\\nSpreadMultSights\\t0\\nVisualRecoilMult\\t0.4\\nRecoilMult\\t0.5 "
    RunConsoleCommand("arc9_modifiers", modif) -- gotta make this work before the game is even playable lol
    RunConsoleCommand("arc9_mod_adstime", "1")
    RunConsoleCommand("arc9_mod_bodydamagecancel", "1")
    RunConsoleCommand("arc9_mod_damage", "1")
    RunConsoleCommand("arc9_mod_damagerand", "1")
    RunConsoleCommand("arc9_mod_headshotdamage", "1")
    RunConsoleCommand("arc9_mod_malfunction", "0.2")
    RunConsoleCommand("arc9_mod_muzzlevelocity", "1")
    RunConsoleCommand("arc9_mod_recoil", "1")
    RunConsoleCommand("arc9_mod_rpm", "1")
    RunConsoleCommand("arc9_mod_spread", "1")
    RunConsoleCommand("arc9_mod_sprinttime", "1")
    RunConsoleCommand("arc9_mod_visualrecoil", "1")

    -- damage falloff (in meters)
    RunConsoleCommand("arc9_eft_mindmgrange", "1000")
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
    RunConsoleCommand("arc9_infinite_ammo", "1")
    RunConsoleCommand("arc9_realrecoil", "1")
    RunConsoleCommand("arc9_lean", "1")
    RunConsoleCommand("arc9_mod_sway", "1")
    RunConsoleCommand("arc9_mod_freeaim", "1")
    RunConsoleCommand("arc9_breath_slowmo", "0")
    RunConsoleCommand("arc9_manualbolt", "0")
    RunConsoleCommand("arc9_never_ready", "1")

    -- physics
    RunConsoleCommand("arc9_bullet_physics", "1")
    RunConsoleCommand("arc9_bullet_gravity", "1.0")
    RunConsoleCommand("arc9_bullet_drag", "1.0")
    RunConsoleCommand("arc9_ricochet", "0")
    RunConsoleCommand("arc9_mod_penetration", "1")
    RunConsoleCommand("arc9_bullet_lifetime", "5")
    RunConsoleCommand("arc9_bullet_imaginary", "1")

    -- true names
    RunConsoleCommand("arc9_truenames_enforced", "1")
    RunConsoleCommand("arc9_truenames_default", "1")

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
    RunConsoleCommand("arc9_togglelean", "1")
    RunConsoleCommand("arc9_togglepeek", "0")
    RunConsoleCommand("arc9_togglepeek_reset", "0")
    RunConsoleCommand("arc9_togglebreath", "1")

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
    RunConsoleCommand("arc9_killfeed_color", "1")
    RunConsoleCommand("arc9_breath_hud", "1")
    RunConsoleCommand("arc9_breath_pp", "1")
    RunConsoleCommand("arc9_breath_sfx", "1")

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
    RunConsoleCommand("arc9_tpik", "0")
    RunConsoleCommand("arc9_tpik_others", "0")
    RunConsoleCommand("arc9_tpik_framerate", "30")

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
    RunConsoleCommand("arc9_autosave", "1")

    -- caching
    RunConsoleCommand("arc9_precache_allsounds_onstartup", "1")
    RunConsoleCommand("arc9_precache_attsmodels_onstartup", "1")
    RunConsoleCommand("arc9_precache_wepmodels_onstartup", "1")
end