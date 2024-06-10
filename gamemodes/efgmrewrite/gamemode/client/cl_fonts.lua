
-- create/reload fonts when needed
local function CreateFonts()
    -- use instead of 'DermaDefault' & just pick which will look better or smth
    surface.CreateFont("PuristaBold18", {font = "PuristaBold", size = EFGM.ScreenScale(18), weight = 500, antialias = true, extended = true})
    surface.CreateFont("Purista18", {font = "Purista", size = EFGM.ScreenScale(18), weight = 500, antialias = true, extended = true})

    -- use instead of 'DermaLarge' & refer to the second instruction on line 19
    surface.CreateFont("PuristaBold32", {font = "PuristaBold", size = EFGM.ScreenScale(32), weight = 550, antialias = true, extended = true})
    surface.CreateFont("Purista32", {font = "Purista", size = EFGM.ScreenScale(32), weight = 550, antialias = true, extended = true})

    surface.CreateFont("PuristaBold64", {font = "PuristaBold", size = EFGM.ScreenScale(64), weight = 550, antialias = true, extended = true})
    surface.CreateFont("Bender24", {font = "Bender", size = EFGM.ScreenScale(24), weight = 550, antialias = true, extended = true})
    surface.CreateFont("BenderAmmoCount", { font = "Bender", size = EFGM.ScreenScale(32), weight = 550, antialias = true, extended = true })
    surface.CreateFont("BenderWeaponName", { font = "Bender", size = EFGM.ScreenScale(21), weight = 550, antialias = true, extended = true })
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