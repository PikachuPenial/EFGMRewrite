-- variables
respawnTime = 7
noRaidRespawnTime = 3
underweightLimit = 30

levelArray = {}
levelArray[1] = 350

for i = 2, 47 do

    levelArray[i] = math.Round((i * 350) * (1 + (i * 0.061)), 0)

end

levelArray[48] = "max"

-- server convars
if SERVER then
    -- modifiers
    local modif = "\\nRecoilKickMult\\t0.75\\nVisualRecoilPunchMult\\t1.5\\nVisualRecoilRollMult\\t1.5\\nVisualRecoilSideMult\\t1\\nVisualRecoilUpMult\\t1\\nVisualRecoilMult\\t3\\nRecoilRandomSideMult\\t1.5\\nRecoilAutoControlMultShooting\\t0.05\\nRecoilUpMult\\t0.5\\nRecoilAutoControlMult\\t0.66\\nFreeAimRadiusMult\\t1.33\\nSpreadMultSights\\t0.5\\nVisualRecoilPunchMultSights\\t3\\nPhysBulletGravityMult\\t0.25 "
    RunConsoleCommand("arc9_modifiers", modif)
    RunConsoleCommand("arc9_mod_adstime", "0.75")
    RunConsoleCommand("arc9_mod_bodydamagecancel", "1")
    RunConsoleCommand("arc9_mod_damage", "1")
    RunConsoleCommand("arc9_mod_damagerand", "1")
    RunConsoleCommand("arc9_mod_headshotdamage", "5")
    RunConsoleCommand("arc9_mod_malfunction", "0.15")
    RunConsoleCommand("arc9_mod_muzzlevelocity", "1.2")
    RunConsoleCommand("arc9_mod_recoil", "0.75")
    RunConsoleCommand("arc9_mod_rpm", "1")
    RunConsoleCommand("arc9_mod_spread", "1")
    RunConsoleCommand("arc9_mod_dispersionspread", "1")
    RunConsoleCommand("arc9_mod_sprinttime", "1")
    RunConsoleCommand("arc9_mod_visualrecoil", "0.75")
    RunConsoleCommand("arc9_eft_mult_ergo", "1")

    -- damage falloff (in meters)
    RunConsoleCommand("arc9_eft_mindmgrange", "160")
    RunConsoleCommand("arc9_eft_mindmgrange_sg", "40")
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
    RunConsoleCommand("arc9_infinite_ammo", "1")
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
    RunConsoleCommand("arc9_eft_singleuse_behaviour", "0")
    RunConsoleCommand("arc9_equipment_generate_ammo", "0")

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
    RunConsoleCommand("arc9_atts_generate_entities", "0")
    RunConsoleCommand("arc9_atts_max", "100")
    RunConsoleCommand("arc9_atts_lock", "0")
    RunConsoleCommand("arc9_atts_loseondie", "1")
    RunConsoleCommand("arc9_free_atts", "1")

    -- caching
    RunConsoleCommand("arc9_precache_sounds_onfirsttake", "0")
    RunConsoleCommand("arc9_precache_attsmodels_onfirsttake", "0")
    RunConsoleCommand("arc9_precache_wepmodels_onfirsttake", "0")

    if GetConVar("efgm_derivesbox"):GetInt() == 0 then

        RunConsoleCommand("arc9_precache_allsounds_onstartup", "1")
        RunConsoleCommand("arc9_precache_attsmodels_onstartup", "1")
        RunConsoleCommand("arc9_precache_wepmodels_onstartup", "1")

    else

        -- faster map reload times <3
        RunConsoleCommand("arc9_precache_allsounds_onstartup", "0")
        RunConsoleCommand("arc9_precache_attsmodels_onstartup", "0")
        RunConsoleCommand("arc9_precache_wepmodels_onstartup", "0")

    end
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
    RunConsoleCommand("arc9_vm_camrollstrength", "0.66")
    RunConsoleCommand("arc9_vm_camstrength", "0.66")

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