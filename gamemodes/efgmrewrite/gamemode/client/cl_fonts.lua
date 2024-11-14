
-- create/reload fonts when needed
local function CreateFonts()
    -- MENU (seriously, dont use this unless it is in the menu, it won't scale properly)

    -- use instead of 'DermaDefault' & just pick which will look better or smth
    surface.CreateFont("PuristaBold18", {font = "PuristaBold", size = EFGM.MenuScale(18), weight = 500, antialias = true, extended = true})
    surface.CreateFont("Purista18", {font = "Purista", size = EFGM.MenuScale(18), weight = 500, antialias = true, extended = true})

    -- use instead of 'DermaLarge' & refer to the second instruction on line 10
    surface.CreateFont("PuristaBold32", {font = "PuristaBold", size = EFGM.MenuScale(32), weight = 550, antialias = true, extended = true})
    surface.CreateFont("Purista32", {font = "Purista", size = EFGM.MenuScale(32), weight = 550, antialias = true, extended = true})

    surface.CreateFont("PuristaBold24", {font = "PuristaBold", size = EFGM.MenuScale(24), weight = 550, antialias = true, extended = true})
    surface.CreateFont("PuristaBold64", {font = "PuristaBold", size = EFGM.MenuScale(64), weight = 550, antialias = true, extended = true})

    -- HUD
    surface.CreateFont("Bender24", {font = "Bender", size = EFGM.ScreenScale(24), weight = 550, antialias = true, extended = true})
    surface.CreateFont("BenderAmmoCount", { font = "Bender", size = EFGM.ScreenScale(32), weight = 550, antialias = true, extended = true })
    surface.CreateFont("BenderExfilList", { font = "Bender Bold", size = EFGM.ScreenScale(40), weight = 500, antialias = true, extended = true })
    surface.CreateFont("BenderExfilName", {font = "Bender", size = EFGM.ScreenScale(28), weight = 550, antialias = true, extended = true})
    surface.CreateFont("BenderWeaponName", { font = "Bender", size = EFGM.ScreenScale(21), weight = 550, antialias = true, extended = true })
    surface.CreateFont("BenderDebug", { font = "Bender", size = EFGM.ScreenScale(14), weight = 550, antialias = true, extended = true })
end
CreateFonts()

-- reload fonts on resolution change
hook.Add("OnScreenSizeChanged", "ResolutionChange", function()
    CreateFonts()
end)

-- reload fonts on hud scale change
cvars.AddChangeCallback("efgm_hud_scale", function()
    CreateFonts()
end)