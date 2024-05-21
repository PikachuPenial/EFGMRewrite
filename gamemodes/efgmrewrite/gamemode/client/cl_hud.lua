
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
    surface.SetTextPos(EFGM.ScreenScale(10), EFGM.ScreenScale(10))

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
hook.Add("HUDPaint", "DrawTimer", DebugRaidTime)

local movedarrow = 18
HPHUDAlpha = 255
HPConHUDAlpha = 255
hpinputed = 0
hpconinputed = 0
StandingStats = 0
Walkdetect = 0

local function RenderPlayerStance()

    local ply = LocalPlayer()
    local wep = ply:GetActiveWeapon()

    local sw = ScrW() / ScrW() + 54
    local sh = ScrH() - 242

    -- health
    local Health = ply:Health()
    local MaxHealth = ply:GetMaxHealth()
    local HealthshouldTrue = true
    local HealthconshouldTrue = true
    local ADS = true
    SliderAlpha = HPHUDAlpha
    SliderAlpha_red = 0
    Healthpercent = math.Clamp(Health / MaxHealth * 100, 0, 100)
    HPbarpercent = math.Clamp(Health / MaxHealth * 146, 0, 146)

    if Healthpercent <= 0 then
        Healthpercent = 0
    elseif Health <= MaxHealth / 10 then
        hpinputed = CurTime()
        SliderAlpha_red = HPHUDAlpha
        SliderAlpha = 0
    elseif Healthpercent >= 100 then
        Healthpercent = 100
    end

    surface.SetDrawColor(255, 255, 255, HPHUDAlpha)
    surface.SetMaterial(Material("stances/sprint_panel.png", "tarkovMaterial"))
    surface.DrawTexturedRect(EFGM.ScreenScale(20), ScrH() - EFGM.ScreenScale(29), EFGM.ScreenScale(156), EFGM.ScreenScale(13))
    surface.SetDrawColor(255, 255, 255, SliderAlpha)
    surface.SetMaterial(Material("stances/sprint_slider.png", "tarkovMaterial"))
    surface.DrawTexturedRect(EFGM.ScreenScale(25), ScrH() - EFGM.ScreenScale(25), EFGM.ScreenScale(HPbarpercent), EFGM.ScreenScale(3))
    surface.SetDrawColor(255, 255, 255, SliderAlpha_red)
    surface.SetMaterial(Material("stances/sprint_slider_exh.png", "tarkovMaterial"))
    surface.DrawTexturedRect(EFGM.ScreenScale(25), ScrH() - EFGM.ScreenScale(25), EFGM.ScreenScale(HPbarpercent), EFGM.ScreenScale(3))

    -- stance
    local Standing0Alpha = 0
    local Standing1Alpha = 0
    local Standing2Alpha = 0
    local Standing3Alpha = 0
    local Standing4Alpha = 0
    local Standing5Alpha = 0
    local CrouchingAlpha = 0
    local ProningAlpha = 0
    rarrow = 0
    darrow = 0

    -- stance animation

    if ply:Crouching() then
        rarrow = 18 * 6
        StandingStats = math.Approach(StandingStats, 6, 6 * FrameTime() / 0.15)
    else
        StandingStats = math.Approach(StandingStats, 0, 6 * FrameTime() / 0.15)
    end

    if StandingStats >= 7 then
        ProningAlpha = HPHUDAlpha
    elseif StandingStats >= 6 then
        CrouchingAlpha = HPHUDAlpha
    elseif StandingStats >= 5 then
        hpinputed = CurTime()
        Standing5Alpha = HPHUDAlpha
    elseif StandingStats >= 4 then
        Standing4Alpha = HPHUDAlpha
    elseif StandingStats >= 3 then
        Standing3Alpha = HPHUDAlpha
    elseif StandingStats >= 2 then
        Standing2Alpha = HPHUDAlpha
    elseif StandingStats >= 1 then
        hpinputed = CurTime()
        Standing1Alpha = HPHUDAlpha
    elseif StandingStats >= 0 then
        Standing0Alpha = HPHUDAlpha
    end

    if ConVarExists("finespeed_key") then
        FineSpeed.HoldTime = 0
        FineSpeed.SpeedIncrements = 18

        if ply:Crouching() then
            if FineSpeed.SpeedIncrementPos < 5 then
                noise03Alpha = HPHUDAlpha
            else
                noise02Alpha = HPHUDAlpha
            end
        else
            if FineSpeed.SpeedIncrementPos < 5 then
                noise03Alpha = HPHUDAlpha
            elseif FineSpeed.SpeedIncrementPos < 15 then
                noise02Alpha = HPHUDAlpha
            else
                noise01Alpha = HPHUDAlpha
            end
        end

        darrow = math.Clamp(FineSpeed.SpeedIncrementPos / 18 * 154 - 13.8, -5, 140)
    else
        if ply:Crouching() then
            noise02Alpha = HPHUDAlpha
        else
            noise01Alpha = HPHUDAlpha
        end

        darrow = 154-13.8
    end

    -- aiming down sights
    local DownAlpha = 0

    if wep.Base == "arc9_base" and wep:GetInSights() then
        ADS = false
    end

    if ADS == false then
        DownAlpha = HPHUDAlpha / 17

        if FineSpeed.SpeedIncrementPos > 8 then
            darrow = 55
            noise01Alpha = 0
            noise02Alpha = HPHUDAlpha
        end
    else
        DownAlpha = HPHUDAlpha
    end

    if darrow < movedarrow then
        hpinputed = CurTime()
    elseif darrow > movedarrow then
        hpinputed = CurTime()
    end

    movedarrow = darrow

    if ply:IsSprinting() or ply:KeyDown(IN_JUMP) then
        Walkdetect = math.Approach(Walkdetect, 4, 4 * FrameTime()/0.2)
    elseif ply:KeyDown(IN_FORWARD) or ply:KeyDown(IN_BACK) or ply:KeyDown(IN_MOVELEFT) or ply:KeyDown(IN_MOVERIGHT) then
        Walkdetect = math.Approach(Walkdetect, 2, 4 * FrameTime()/0.2)
    else
        Walkdetect = math.Approach(Walkdetect, 0, 4 * FrameTime()/0.2)
    end

    if Walkdetect > 2 and Walkdetect < 4 then
        hpinputed = CurTime()
    elseif Walkdetect > 0 and Walkdetect < 2 then
        hpinputed = CurTime()
    end

    surface.SetDrawColor(255, 255, 255, Standing0Alpha)
    surface.SetMaterial(Material("stances/stand0.png", "tarkovMaterial"))
    surface.DrawTexturedRect(sw-1, sh-3, 126, 166)
    surface.SetDrawColor(255, 255, 255, Standing1Alpha)
    surface.SetMaterial(Material("stances/stand1.png", "tarkovMaterial"))
    surface.DrawTexturedRect(sw-1, sh+2, 126, 160)
    surface.SetDrawColor(255, 255, 255, Standing2Alpha)
    surface.SetMaterial(Material("stances/stand2.png", "tarkovMaterial"))
    surface.DrawTexturedRect(sw-1, sh+6, 127, 154)
    surface.SetDrawColor(255, 255, 255, Standing3Alpha)
    surface.SetMaterial(Material("stances/stand3.png", "tarkovMaterial"))
    surface.DrawTexturedRect(sw-1, sh+13, 127, 148)
    surface.SetDrawColor(255, 255, 255, Standing4Alpha)
    surface.SetMaterial(Material("stances/stand4.png", "tarkovMaterial"))
    surface.DrawTexturedRect(sw-1, sh+18, 127, 143)
    surface.SetDrawColor(255, 255, 255, Standing5Alpha)
    surface.SetMaterial(Material("stances/stand5.png", "tarkovMaterial"))
    surface.DrawTexturedRect(sw-1, sh+23, 127, 138)
    surface.SetDrawColor(255, 255, 255, CrouchingAlpha)
    surface.SetMaterial(Material("stances/crouch.png", "tarkovMaterial"))
    surface.DrawTexturedRect(sw-1, sh+46, 127, 114)
    surface.SetDrawColor(255, 255, 255, ProningAlpha)
    surface.SetMaterial(Material("stances/settle.png", "tarkovMaterial"))
    surface.DrawTexturedRect(sw-5, sh+102, 199, 60)

    -- i dont even know
    local sw = sw - 26
    local sh = sh + 13

    -- refer to line 218
    local sw = sw + 22
    local sh = sh + 167

    surface.SetDrawColor(255, 255, 255, HPHUDAlpha)
    surface.SetMaterial(Material("stances/arrow_down_tiny.png", "tarkovMaterial"))
    surface.DrawTexturedRect(sw-1+darrow, sh-11, 6, 5)
    draw.RoundedBox(2, sw, sh, 7*20+1.75+5, 3, Color(255/5, 255/5, 255/5, HPHUDAlpha/2))
    draw.RoundedBox(2, sw, sh, 1.75, 3, Color(255,255,255,HPHUDAlpha))
    draw.RoundedBox(2, sw+7, sh, 1.75, 3, Color(255,255,255,HPHUDAlpha))
    draw.RoundedBox(2, sw+7*2+1, sh, 1.75, 3, Color(255,255,255,HPHUDAlpha))
    draw.RoundedBox(2, sw+7*3+1, sh, 1.75, 3, Color(255,255,255,HPHUDAlpha))
    draw.RoundedBox(2, sw+7*4+1, sh, 1.75, 3, Color(255,255,255,HPHUDAlpha))
    draw.RoundedBox(2, sw+7*5+1, sh, 1.75, 3, Color(255,255,255,HPHUDAlpha))
    draw.RoundedBox(2, sw+7*6+2, sh, 1.75, 3, Color(255,255,255,HPHUDAlpha))
    draw.RoundedBox(2, sw+7*7+2, sh, 1.75, 3, Color(255,255,255,HPHUDAlpha))
    draw.RoundedBox(2, sw+7*8+2, sh, 1.75, 3, Color(255,255,255,HPHUDAlpha))
    draw.RoundedBox(2, sw+7*9+2, sh, 1.75, 3, Color(255,255,255,DownAlpha))
    draw.RoundedBox(2, sw+7*10+3, sh, 1.75, 3, Color(255,255,255,DownAlpha))
    draw.RoundedBox(2, sw+7*11+3, sh, 1.75, 3, Color(255,255,255,DownAlpha))
    draw.RoundedBox(2, sw+7*12+3, sh, 1.75, 3, Color(255,255,255,DownAlpha))
    draw.RoundedBox(2, sw+7*13+3, sh, 1.75, 3, Color(255,255,255,DownAlpha))
    draw.RoundedBox(2, sw+7*14+4, sh, 1.75, 3, Color(255,255,255,DownAlpha))
    draw.RoundedBox(2, sw+7*15+4, sh, 1.75, 3, Color(255,255,255,DownAlpha))
    draw.RoundedBox(2, sw+7*16+4, sh, 1.75, 3, Color(255,255,255,DownAlpha))
    draw.RoundedBox(2, sw+7*17+4, sh, 1.75, 3, Color(255,255,255,DownAlpha))
    draw.RoundedBox(2, sw+7*18+5, sh, 1.75, 3, Color(255,255,255,DownAlpha))
    draw.RoundedBox(2, sw+7*19+5, sh, 1.75, 3, Color(255,255,255,DownAlpha))
    draw.RoundedBox(2, sw+7*20+5, sh, 1.75, 3, Color(255,255,255,DownAlpha))

    hpinputed = CurTime()
    hpconinputed = CurTime()

    -- health condition
    if hpconinputed + 3 < CurTime() then
        HealthconshouldTrue = false
    end

    if HealthconshouldTrue == true then
        HPConHUDAlpha = math.Approach(HPConHUDAlpha, 255, 255 * FrameTime() / 0.25)
    else
        HPConHUDAlpha = math.Approach(HPConHUDAlpha, 0, 255 * FrameTime() / 0.25)
    end

    -- stance (again)
    if hpinputed + 3 < CurTime() then
        HealthshouldTrue = false
    end

    if HealthshouldTrue == true then
        HPHUDAlpha = math.Approach(HPHUDAlpha, 255, 255 * FrameTime() / 0.25)
    else
        HPHUDAlpha = math.Approach(HPHUDAlpha, 0, 255 * FrameTime() / 0.25)
    end
end
hook.Add("HUDPaint", "DrawPlayerStance", RenderPlayerStance)

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
    -- full: {"CHudHealth", "CHudBattery", "CHudAmmo", "CHudSecondaryAmmo", "CHudCrosshair"}
    for k, v in pairs({"CHudHealth", "CHudBattery", "CHudAmmo", "CHudSecondaryAmmo", "CHudCrosshair"}) do
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