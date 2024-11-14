
local enabled = GetConVar("efgm_hud_enable")
cvars.AddChangeCallback("efgm_hud_enable", function(convar_name, value_old, value_new)
    enabled = tobool(value_new)
end)

local function RenderRaidTime(ply)

    -- time logic
    local raidTime = string.FormattedTime(GetGlobalInt("RaidTimeLeft", 0), "%2i:%02i")
    local raidStatus = GetGlobalInt("RaidStatus", 0)

    local raidStatusTbl = {
        [0] = Color(0, 75, 0, 128), -- raid pending
        [1] = Color(0, 0, 0, 128), -- raid active
        [2] = Color(75, 0, 0, 128)  -- raid ended
    }

    surface.SetDrawColor(raidStatusTbl[raidStatus])
    surface.DrawRect(ScrW() - EFGM.ScreenScale(120), EFGM.ScreenScale(20), EFGM.ScreenScale(100), EFGM.ScreenScale(36))
    draw.DrawText(raidTime, "BenderExfilList", ScrW() - EFGM.ScreenScale(70), EFGM.ScreenScale(19), Color(255, 255, 255), TEXT_ALIGN_CENTER)

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
    if ammo == -1 then magstatus = "∞" end

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

-- extracts
function RenderExtracts(ply)

    -- no need to create the compass panel if it already exists
    if IsValid(extracts) then return end

    local extractList
    net.Receive("SendExtractList", function(len, ply)

        extractList = net.ReadTable()

    end )

    net.Start("GrabExtractList")
    net.SendToServer()

    extracts = vgui.Create("DPanel")
    extracts:SetSize(ScrW(), ScrH())
    extracts:SetPos(0, 0)
    extracts:SetAlpha(0)
    extracts:MoveToFront()

    local exitStatusTbl = {
        [false] = Color(255, 255, 255, 255), -- extract open
        [true] = Color(255, 0, 0, 255) -- extract closed
    }

    extracts.Paint = function(self, w, h)

        if not ply:Alive() then return end
        if extractList == nil then return end

        surface.SetDrawColor(0, 0, 0, 128)
        surface.DrawRect(ScrW() - EFGM.ScreenScale(515), EFGM.ScreenScale(20), EFGM.ScreenScale(390), EFGM.ScreenScale(36))
        draw.SimpleTextOutlined("FIND AN EXTRACTION POINT", "BenderAmmoCount", ScrW() - EFGM.ScreenScale(320), EFGM.ScreenScale(21), Color(255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 1, Color(0, 100, 0, 128))

        for k, v in pairs(extractList) do

            surface.DrawRect(ScrW() - EFGM.ScreenScale(515), EFGM.ScreenScale(61) + ((k - 1) * 41), EFGM.ScreenScale(390), EFGM.ScreenScale(36))
            surface.DrawRect(ScrW() - EFGM.ScreenScale(120), EFGM.ScreenScale(61) + ((k - 1) * 41), EFGM.ScreenScale(100), EFGM.ScreenScale(36))

            draw.DrawText("EXFIL0" .. k, "BenderExfilList", ScrW() - EFGM.ScreenScale(505), EFGM.ScreenScale(60) + ((k - 1) * 41), exitStatusTbl[v.IsDisabled], TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
            draw.DrawText(v.ExtractName, "BenderExfilName", ScrW() - EFGM.ScreenScale(380), EFGM.ScreenScale(65) + ((k - 1) * 41), Color(255, 255, 255), TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)

        end

    end

    extracts:AlphaTo(255, 0.35, 0, function() end) -- why do i need to use a callback here???
    extracts:AlphaTo(0, 1, 4.65, function() extracts:Remove() end)

end

-- compass
function RenderCompass(ply)

    -- no need to create the compass panel if it already exists
    if IsValid(compass) then return end

    compass = vgui.Create("DPanel")
    compass:SetSize(ScrW(), ScrH())
    compass:SetPos(0, 0)
    compass:SetAlpha(0)
    compass:MoveToFront()

    local color = Color(255, 255, 255)
    local adv_compass_tbl = {
        [0] = "N",
        [45] = "NE",
        [90] = "E",
        [135] = "SE",
        [180] = "S",
        [225] = "SW",
        [270] = "W",
        [315] = "NW",
        [360] = "N"
    }

    compass.Paint = function(self, w, h)

        if not ply:Alive() then return end

        local ang = ply:EyeAngles()

        surface.SetDrawColor(color)
        surface.DrawLine(ScrW() / 2, 0, ScrW() / 2, EFGM.ScreenScale(6))

        local compassX, compassY = ScrW() * 0.5, ScrH() * 0
        local width, height = ScrW() * EFGM.ScreenScale(0.5), EFGM.ScreenScale(10)

        spacing = (width * 1) / EFGM.ScreenScale(360)
        numOfLines = width / spacing
        fadeDistMultiplier = 25
        fadeDistance = (ScrW() / 2) / fadeDistMultiplier

        for i = math.Round(-ang.y) % 360, (math.Round(-ang.y) % 360) + numOfLines do

            local x = ((compassX - (width / 2)) + (((i + ang.y) % 360) * spacing))
            local value = math.abs(x - compassX)
            local calc = 1 - ((value + (value - fadeDistance)) / (width / 2))
            local calculation = 255 * math.Clamp(calc, 0.001, 1)

            local i_offset = -(math.Round(i - 0 - (numOfLines / 2))) % 360

            if i_offset % 45 == 0 and i_offset >= 0 then
                local a = i_offset
                local text = adv_compass_tbl[360 - (a % 360)] and adv_compass_tbl[360 - (a % 360)] or 360 - (a % 360)

                draw.DrawText(text, "Bender24", x, compassY + height * EFGM.ScreenScale(0.6), Color(color.r, color.g, color.b, calculation), TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP)

            end

        end

    end

    compass:AlphaTo(255, 0.35, 0, function() end) -- why do i need to use a callback here???
    compass:AlphaTo(0, 1, 4.65, function() compass:Remove() end)

end

local function RenderPlayerOverlays(ply)

    -- i dont want to play with you anymore RenderPlayerOverlays()
    return

end

local function RenderDebugEquippedSlots(ply)

    if activeSlots == nil then return end

    surface.SetDrawColor(0, 0, 0, 128)

    local prim1 = activeSlots[KEY_1]
    if prim1 != nil then

        local prim1TextSize = surface.GetTextSize("1: "..prim1) + EFGM.ScreenScale(10)
        surface.DrawRect( EFGM.ScreenScale(20), EFGM.ScreenScale(20), EFGM.ScreenScale(12) + prim1TextSize, EFGM.ScreenScale(35) )
        draw.DrawText( "1: "..prim1, "BenderAmmoCount", EFGM.ScreenScale(22), EFGM.ScreenScale(20), Color(255, 255, 255), TEXT_ALIGN_LEFT )

    end

    local prim2 = activeSlots[KEY_2]
    if prim2 != nil then

        local prim2TextSize = surface.GetTextSize("2: "..prim2) + EFGM.ScreenScale(10)
        surface.DrawRect( EFGM.ScreenScale(20), EFGM.ScreenScale(70), EFGM.ScreenScale(12) + prim2TextSize, EFGM.ScreenScale(35) )
        draw.DrawText( "2: "..prim2, "BenderAmmoCount", EFGM.ScreenScale(22), EFGM.ScreenScale(70), Color(255, 255, 255), TEXT_ALIGN_LEFT )

    end

    local secondary = activeSlots[KEY_3]
    if secondary != nil then

        local secondaryTextSize = surface.GetTextSize("3: "..secondary) + EFGM.ScreenScale(10)
        surface.DrawRect( EFGM.ScreenScale(20), EFGM.ScreenScale(120), EFGM.ScreenScale(12) + secondaryTextSize, EFGM.ScreenScale(35) )
        draw.DrawText( "3: "..secondary, "BenderAmmoCount", EFGM.ScreenScale(22), EFGM.ScreenScale(120), Color(255, 255, 255), TEXT_ALIGN_LEFT )

    end

    local melee = activeSlots[KEY_4]
    if melee != nil then

        local meleeTextSize = surface.GetTextSize("4: "..melee) + EFGM.ScreenScale(10)
        surface.DrawRect( EFGM.ScreenScale(20), EFGM.ScreenScale(170), EFGM.ScreenScale(12) + meleeTextSize, EFGM.ScreenScale(35) )
        draw.DrawText( "4: "..melee, "BenderAmmoCount", EFGM.ScreenScale(22), EFGM.ScreenScale(170), Color(255, 255, 255), TEXT_ALIGN_LEFT )

    end

    local utility = activeSlots[KEY_G]
    if utility != nil then

        local utilityTextSize = surface.GetTextSize("G: "..utility) + EFGM.ScreenScale(10)
        surface.DrawRect( EFGM.ScreenScale(20), EFGM.ScreenScale(220), EFGM.ScreenScale(12) + utilityTextSize, EFGM.ScreenScale(35) )
        draw.DrawText( "G: "..utility, "BenderAmmoCount", EFGM.ScreenScale(22), EFGM.ScreenScale(220), Color(255, 255, 255), TEXT_ALIGN_LEFT )

    end

end

local function DrawHUD()
    ply = LocalPlayer()
    if not ply:Alive() then return end
    if not enabled then return end

    RenderRaidTime(ply)
    RenderPlayerWeapon(ply)
    RenderPlayerStance(ply)
    -- RenderPlayerOverlays(ply)

    if !isInventoryTesting then return end

    RenderDebugEquippedSlots(ply)
end
hook.Add("HUDPaint", "DrawHUD", DrawHUD)

net.Receive("PlayerEnterRaid", function()
    RaidTransition = vgui.Create("DPanel")
    RaidTransition:SetSize(ScrW(), ScrH())
    RaidTransition:SetPos(0, 0)
    RaidTransition:SetAlpha(0)
    RaidTransition:MoveToFront()

    RaidTransition.Paint = function(self, w, h)
        surface.SetDrawColor(0, 0, 0, 255)
        surface.DrawRect(0, 0, ScrW(), ScrH())
    end

    RaidTransition:AlphaTo(255, 0.5, 0, function() end) -- why do i need to use a callback here???
    RaidTransition:AlphaTo(0, 0.35, 1, function() RaidTransition:Remove() end)
end )

function DrawTarget()
    if !LocalPlayer():CompareStatus(0) then return false end
end
hook.Add("HUDDrawTargetID", "HidePlayerInfo", DrawTarget)

function DrawAmmoInfo()
    return false
end
hook.Add("HUDAmmoPickedUp", "AmmoPickedUp", DrawAmmoInfo)

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

-- disable scoreboard
hook.Add("ScoreboardShow", "DisableHL2Scoreboard", function()
    return true
end )

-- hide voice chat panels
hook.Add("PlayerStartVoice", "ImageOnVoice", function()
	return false
end)

net.Receive("VoteableMaps", function(len)

    local tbl = net.ReadTable()

    LocalPlayer():PrintMessage(HUD_PRINTTALK, "Go into the console and type 'efgm_vote ___' and vote for one of the maps!")
    PrintTable(tbl)

end)