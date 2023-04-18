-- free look
limV = 45
limH = 90
smooth = 1.00
blockads = true
blockshoot = true

-- weapon arrays for gameplay testing purposes
debugPrimWep = {"arc9_eft_sag_ak545", "arc9_eft_sag_ak545short", "arc9_eft_vpo136", "arc9_eft_vpo209", "arc9_eft_ak101", "arc9_eft_ak102", "arc9_eft_ak103", "arc9_eft_ak104", "arc9_eft_ak105", "arc9_eft_ak74", "arc9_eft_ak74m", "arc9_eft_akm", "arc9_eft_akms", "arc9_eft_aks74", "arc9_eft_aks74u", "arc9_eft_ash12", "arc9_eft_rd704", "arc9_eft_rpk16", "arc9_eft_mp18", "arc9_eft_saiga12k", "arc9_eft_toz106", "arc9_eft_ai_axmc", "arc9_eft_fn_p90", "arc9_eft_pp1901", "arc9_eft_saiga9"}
debugSecWep = {"arc9_eft_fn57", "arc9_eft_glock17", "arc9_eft_glock18c", "arc9_eft_glock19x", "arc9_eft_rsh12"}

if SERVER then
    RunConsoleCommand("arc9_truenames_enforced", "1")
end

-- client convars
if CLIENT then
    -- hud
    RunConsoleCommand("arc9_hud_arc9", "0")
    RunConsoleCommand("arc9_cross_enable", "0")

    -- tpik
    RunConsoleCommand("arc9_tpik", "1")
    RunConsoleCommand("arc9_tpik_others", "1")
    RunConsoleCommand("arc9_tpik_framerate", "30")
end