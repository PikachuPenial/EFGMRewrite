
EFGM = {}

-- screen scale function, makes my life (penial) easier because i will most definently be doing most if not all of the user interface
-- all interfaces and fonts are developed on a 1920x1080 monitor

local efgm_hud_scale = GetConVar("efgm_hud_scale")
EFGM.ScreenScale = function(size)
    return size / 3 * (ScrW() / 640) * efgm_hud_scale:GetFloat()
end

local function DebugRaidTime()
    surface.SetTextColor(Color(255, 255, 255))
    surface.SetFont("Bender24")
    surface.SetTextPos(EFGM.ScreenScale(20), EFGM.ScreenScale(20))

    -- time logic

    local raidTime = GetGlobalInt("RaidTimeLeft", -1)
    local raidStatus = GetGlobalInt("RaidStatus", 0)

    local tempStatusTable = {
        [0] = "Raid Pending",
        [1] = "Raid Active",
        [2] = "Raid Over"
    }

    surface.DrawText( string.FormattedTime( raidTime, "%2i:%02i" ) .. "\n" .. tempStatusTable[raidStatus] )

end

-- players current weapon and ammo
local function RenderPlayerWeapon(ply)
    local wep = LocalPlayer():GetActiveWeapon()
    if wep == NULL then return end

    local name = wep:GetPrintName()
    local ammo = wep:Clip1()
    local ammoMax = wep:GetMaxClip1()
    local magstatus

    -- calculate approx. ammo remaining
    if ammo >= ammoMax * 0.9 then magstatus = "Full"
    elseif ammo >= ammoMax * 0.8 then magstatus = "Nearly full"
    elseif ammo >= ammoMax * 0.4 then magstatus = "About half"
    elseif ammo >= ammoMax * 0.2 then magstatus = "Less than half"
    elseif ammo >= ammoMax * 0.01 then magstatus = "Almost empty"
    else magstatus = "Empty" end

    surface.SetFont("BenderAmmoCount")
    local ammoTextSize = surface.GetTextSize(magstatus) + EFGM.ScreenScale(10)

    -- ammo
    surface.SetDrawColor(0, 0, 0, 128)
    surface.DrawRect(ScrW() - EFGM.ScreenScale(37) - ammoTextSize, ScrH() - EFGM.ScreenScale(75), ammoTextSize + EFGM.ScreenScale(17), EFGM.ScreenScale(35))
    draw.DrawText(tostring(magstatus), "BenderAmmoCount", ScrW() - EFGM.ScreenScale(34), ScrH() - EFGM.ScreenScale(74), Color(255, 255, 255), TEXT_ALIGN_RIGHT)

    -- weapon name
    draw.DrawText(name, "BenderWeaponName", ScrW() - EFGM.ScreenScale(20), ScrH() - EFGM.ScreenScale(40), Color(214, 214, 214), TEXT_ALIGN_RIGHT)
end

-- players current stance and health

local playerStance = 0
local function RenderPlayerStance(ply)

    -- variables
    local ply = LocalPlayer()
    local health = ply:Health()
    local maxHealth = ply:GetMaxHealth()

    local healthAlpha = 255
    local lowHealthAlpha = 0
    local hpBarPercent = math.Clamp(health / maxHealth * 146, 0, 146)

    local Standing0Alpha = 0
    local Standing1Alpha = 0
    local Standing2Alpha = 0
    local Standing3Alpha = 0
    local Standing4Alpha = 0
    local Standing5Alpha = 0
    local CrouchingAlpha = 0

    -- health check
    if health <= maxHealth / 10 then
        lowHealthAlpha = 255
        healthAlpha = 0
    end

    -- draw health
    surface.SetDrawColor(255, 255, 255, 255)
    surface.SetMaterial(Material("stances/sprint_panel.png", "tarkovMaterial"))
    surface.DrawTexturedRect(EFGM.ScreenScale(20), ScrH() - EFGM.ScreenScale(29), EFGM.ScreenScale(156), EFGM.ScreenScale(13))
    surface.SetDrawColor(255, 255, 255, healthAlpha)
    surface.SetMaterial(Material("stances/sprint_slider.png", "tarkovMaterial"))
    surface.DrawTexturedRect(EFGM.ScreenScale(25), ScrH() - EFGM.ScreenScale(25), EFGM.ScreenScale(hpBarPercent), EFGM.ScreenScale(3))
    surface.SetDrawColor(255, 255, 255, lowHealthAlpha)
    surface.SetMaterial(Material("stances/sprint_slider_exh.png", "tarkovMaterial"))
    surface.DrawTexturedRect(EFGM.ScreenScale(25), ScrH() - EFGM.ScreenScale(25), EFGM.ScreenScale(hpBarPercent), EFGM.ScreenScale(3))

    -- stance check
    if ply:Crouching() then
        playerStance = math.Approach(playerStance, 6, 6 * FrameTime() / 0.15)
    else
        playerStance = math.Approach(playerStance, 0, 6 * FrameTime() / 0.15)
    end

    if playerStance >= 6 then
        CrouchingAlpha = 255
    elseif playerStance >= 5 then
        Standing5Alpha = 255
    elseif playerStance >= 4 then
        Standing4Alpha = 255
    elseif playerStance >= 3 then
        Standing3Alpha = 255
    elseif playerStance >= 2 then
        Standing2Alpha = 255
    elseif playerStance >= 1 then
        Standing1Alpha = 255
    elseif playerStance >= 0 then
        Standing0Alpha = 255
    end

    -- draw stance
    surface.SetDrawColor(255, 255, 255, Standing0Alpha)
    surface.SetMaterial(Material("stances/stand0.png", "tarkovMaterial"))
    surface.DrawTexturedRect(EFGM.ScreenScale(25), ScrH() - EFGM.ScreenScale(200), EFGM.ScreenScale(126), EFGM.ScreenScale(166))
    surface.SetDrawColor(255, 255, 255, Standing1Alpha)
    surface.SetMaterial(Material("stances/stand1.png", "tarkovMaterial"))
    surface.DrawTexturedRect(EFGM.ScreenScale(25), ScrH() - EFGM.ScreenScale(195), EFGM.ScreenScale(126), EFGM.ScreenScale(160))
    surface.SetDrawColor(255, 255, 255, Standing2Alpha)
    surface.SetMaterial(Material("stances/stand2.png", "tarkovMaterial"))
    surface.DrawTexturedRect(EFGM.ScreenScale(25), ScrH() - EFGM.ScreenScale(191), EFGM.ScreenScale(127), EFGM.ScreenScale(154))
    surface.SetDrawColor(255, 255, 255, Standing3Alpha)
    surface.SetMaterial(Material("stances/stand3.png", "tarkovMaterial"))
    surface.DrawTexturedRect(EFGM.ScreenScale(25), ScrH() - EFGM.ScreenScale(184), EFGM.ScreenScale(127), EFGM.ScreenScale(148))
    surface.SetDrawColor(255, 255, 255, Standing4Alpha)
    surface.SetMaterial(Material("stances/stand4.png", "tarkovMaterial"))
    surface.DrawTexturedRect(EFGM.ScreenScale(25), ScrH() - EFGM.ScreenScale(179), EFGM.ScreenScale(127), EFGM.ScreenScale(143))
    surface.SetDrawColor(255, 255, 255, Standing5Alpha)
    surface.SetMaterial(Material("stances/stand5.png", "tarkovMaterial"))
    surface.DrawTexturedRect(EFGM.ScreenScale(25), ScrH() - EFGM.ScreenScale(174), EFGM.ScreenScale(127), EFGM.ScreenScale(138))
    surface.SetDrawColor(255, 255, 255, CrouchingAlpha)
    surface.SetMaterial(Material("stances/crouch.png", "tarkovMaterial"))
    surface.DrawTexturedRect(EFGM.ScreenScale(25), ScrH() - EFGM.ScreenScale(151), EFGM.ScreenScale(127), EFGM.ScreenScale(114))
end

local function RenderPlayerOverlays(ply)
    return
end

local function DrawHUD()
    ply = LocalPlayer()
    if not ply:Alive() then return end

    DebugRaidTime()
    RenderPlayerWeapon(ply)
    RenderPlayerStance(ply)
    RenderPlayerOverlays(ply)
end
hook.Add("HUDPaint", "DrawHUD", DrawHUD)

function DrawTarget()
    return false
end
hook.Add("HUDDrawTargetID", "HidePlayerInfo", DrawTarget)

function DrawAmmoInfo()
    return false
end
hook.Add("HUDAmmoPickedUp", "AmmoPickedUp", DrawAmmoInfo)

function DrawWeaponInfo()
    return false
end
hook.Add("HUDWeaponPickedUp", "WeaponPickedUp", DrawWeaponInfo)

function DrawItemInfo()
    return false
end
hook.Add("HUDItemPickedUp", "ItemPickedUp", DrawItemInfo)

function HideHud(name)
    for k, v in pairs({"CHudHealth", "CHudBattery", "CHudAmmo", "CHudSecondaryAmmo", "CHudZoom", "CHudVoiceStatus", "CHudDamageIndicator", "CHUDQuickInfo", "CHudCrosshair"}) do
        if name == v then
            return false
        end
    end
end
hook.Add("HUDShouldDraw", "HideDefaultHud", HideHud)

net.Receive("VoteableMaps", function(len)

    local tbl = net.ReadTable()

    LocalPlayer():PrintMessage(HUD_PRINTCENTER, "Look in the console and (efgm_vote mapname) for a map, im not good at UI so fuck you.")
    PrintTable(tbl)

end)