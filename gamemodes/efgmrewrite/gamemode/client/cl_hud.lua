hook.Add("InitPostEntity", "LocalPlayer", function() ply = LocalPlayer() end)

HUD = {}
HUD.InTransition = false
HUD.VotedMap = nil

local enabled = GetConVar("efgm_hud_enable"):GetBool()
cvars.AddChangeCallback("efgm_hud_enable", function(convar_name, value_old, value_new)
    enabled = tobool(value_new)
end)

local function RenderRaidTime()
    -- time logic
    local raidTime = string.FormattedTime(GetGlobalInt("RaidTimeLeft", 0), "%02i:%02i")
    local raidStatus = GetGlobalInt("RaidStatus", 0)

    local raidStatusTbl = {
        [0] = Colors.statusPending, -- raid pending
        [1] = Colors.statusActive, -- raid active
        [2] = Colors.statusEnded  -- raid ended
    }

    surface.SetDrawColor(raidStatusTbl[raidStatus])
    surface.DrawRect(ScrW() - EFGM.ScreenScale(120), EFGM.ScreenScale(20), EFGM.ScreenScale(100), EFGM.ScreenScale(36))
    draw.DrawText(raidTime, "BenderExfilList", ScrW() - EFGM.ScreenScale(70), EFGM.ScreenScale(19), Colors.whiteColor, TEXT_ALIGN_CENTER)
end

-- players current weapon and ammo
local function RenderPlayerWeapon()
    local wep = ply:GetActiveWeapon()
    if wep == NULL then return end

    local name = wep:GetPrintName()

    -- weapon name
    draw.DrawText(name, "BenderWeaponName", ScrW() - EFGM.ScreenScale(20), ScrH() - EFGM.ScreenScale(40), Colors.whiteColor, TEXT_ALIGN_RIGHT)

    local ammo = wep:Clip1()
    local ammoMax = wep:GetMaxClip1()
    local magstatus
    local status = nil

    -- calculate approx. ammo remaining
    if ammo >= ammoMax * 0.9 then magstatus = "Full"
    elseif ammo >= ammoMax * 0.8 then magstatus = "Nearly full"
    elseif ammo >= ammoMax * 0.4 then magstatus = "About half"
    elseif ammo >= ammoMax * 0.2 then magstatus = "Less than half"
    elseif ammo >= ammoMax * 0.01 then magstatus = "Almost empty"
    else magstatus = "Empty" end
    if ammo == -1 or ammoMax <= 0 then magstatus = "∞" end

    surface.SetFont("BenderAmmoCount")
    local ammoTextSize = surface.GetTextSize(magstatus) + EFGM.ScreenScale(10)

    -- ammo
    local wepColor = Colors.whiteColor
    if wep.Hook_RedPrintName then status = wep:RunHook("Hook_RedPrintName") end
    if status then wepColor = Colors.deadColor end
    surface.SetDrawColor(Colors.hudBackground)
    surface.DrawRect(ScrW() - EFGM.ScreenScale(37) - ammoTextSize, ScrH() - EFGM.ScreenScale(75), ammoTextSize + EFGM.ScreenScale(17), EFGM.ScreenScale(35))
    draw.DrawText(tostring(magstatus), "BenderAmmoCount", ScrW() - EFGM.ScreenScale(34), ScrH() - EFGM.ScreenScale(74), wepColor, TEXT_ALIGN_RIGHT)
end

-- assorted overlays

local blurAmount = 0
local maxBlur = 4
local blurSpeed = 2
local vignetteMaxAlpha = 255
local function RenderOverlays()

    if ply:Health() <= 0 then

        blurAmount = math.min(blurAmount + blurSpeed * FrameTime(), maxBlur)

    else

        blurAmount = math.max(blurAmount - (blurSpeed * 6) * FrameTime(), 0)

    end

    if blurAmount > 0 then

        surface.SetDrawColor(Colors.pureWhiteColor)
        surface.SetMaterial(Material("pp/blurscreen"))

        for i = 1, 3 do
            Material("pp/blurscreen"):SetInt("$blur", blurAmount * (i * 1))
            render.UpdateScreenEffectTexture()
            surface.DrawTexturedRect(0, 0, ScrW(), ScrH())
        end

        local vignetteAmount = math.Clamp((blurAmount / maxBlur) * vignetteMaxAlpha, 0, vignetteMaxAlpha)
        surface.SetDrawColor(0, 0, 0, vignetteAmount)
        surface.DrawRect(0, 0, ScrW(), ScrH())

    end

end

-- players current stance and health
local playerStance = 0
local healthMat = Material("stances/sprint_panel.png", "tarkovMaterial")
local healthSliderMat = Material("stances/sprint_slider.png", "tarkovMaterial")
local healthLowSliderMat = Material("stances/sprint_slider_exh.png", "tarkovMaterial")
local stand = Material("stances/stand0.png", "tarkovMaterial")
local stand1 = Material("stances/stand1.png", "tarkovMaterial")
local stand2 = Material("stances/stand2.png", "tarkovMaterial")
local stand3 = Material("stances/stand3.png", "tarkovMaterial")
local stand4 = Material("stances/stand4.png", "tarkovMaterial")
local stand5 = Material("stances/stand5.png", "tarkovMaterial")
local crouch = Material("stances/crouch.png", "tarkovMaterial")
local function RenderPlayerStance()
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
    if health <= maxHealth / 4 then
        lowHealthAlpha = 255
        healthAlpha = 0
    end

    -- draw health
    surface.SetDrawColor(Colors.pureWhiteColor)
    surface.SetMaterial(healthMat)
    surface.DrawTexturedRect(EFGM.ScreenScale(20), ScrH() - EFGM.ScreenScale(29), EFGM.ScreenScale(156), EFGM.ScreenScale(13))
    surface.SetDrawColor(255, 255, 255, healthAlpha)
    surface.SetMaterial(healthSliderMat)
    surface.DrawTexturedRect(EFGM.ScreenScale(25), ScrH() - EFGM.ScreenScale(25), EFGM.ScreenScale(hpBarPercent), EFGM.ScreenScale(3))
    surface.SetDrawColor(255, 255, 255, lowHealthAlpha)
    surface.SetMaterial(healthLowSliderMat)
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
    surface.SetMaterial(stand)
    surface.DrawTexturedRect(EFGM.ScreenScale(25), ScrH() - EFGM.ScreenScale(200), EFGM.ScreenScale(126), EFGM.ScreenScale(166))
    surface.SetDrawColor(255, 255, 255, Standing1Alpha)
    surface.SetMaterial(stand1)
    surface.DrawTexturedRect(EFGM.ScreenScale(25), ScrH() - EFGM.ScreenScale(195), EFGM.ScreenScale(126), EFGM.ScreenScale(160))
    surface.SetDrawColor(255, 255, 255, Standing2Alpha)
    surface.SetMaterial(stand2)
    surface.DrawTexturedRect(EFGM.ScreenScale(25), ScrH() - EFGM.ScreenScale(191), EFGM.ScreenScale(127), EFGM.ScreenScale(154))
    surface.SetDrawColor(255, 255, 255, Standing3Alpha)
    surface.SetMaterial(stand3)
    surface.DrawTexturedRect(EFGM.ScreenScale(25), ScrH() - EFGM.ScreenScale(184), EFGM.ScreenScale(127), EFGM.ScreenScale(148))
    surface.SetDrawColor(255, 255, 255, Standing4Alpha)
    surface.SetMaterial(stand4)
    surface.DrawTexturedRect(EFGM.ScreenScale(25), ScrH() - EFGM.ScreenScale(179), EFGM.ScreenScale(127), EFGM.ScreenScale(143))
    surface.SetDrawColor(255, 255, 255, Standing5Alpha)
    surface.SetMaterial(stand5)
    surface.DrawTexturedRect(EFGM.ScreenScale(25), ScrH() - EFGM.ScreenScale(174), EFGM.ScreenScale(127), EFGM.ScreenScale(138))
    surface.SetDrawColor(255, 255, 255, CrouchingAlpha)
    surface.SetMaterial(crouch)
    surface.DrawTexturedRect(EFGM.ScreenScale(25), ScrH() - EFGM.ScreenScale(151), EFGM.ScreenScale(127), EFGM.ScreenScale(114))
end

-- extracts
function RenderExtracts()
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
        if !ply:Alive() then return end
        if extractList == nil then return end

        surface.SetDrawColor(Colors.hudBackground)
        surface.DrawRect(ScrW() - EFGM.ScreenScale(515), EFGM.ScreenScale(20), EFGM.ScreenScale(390), EFGM.ScreenScale(36))
        draw.SimpleTextOutlined("FIND AN EXTRACTION POINT", "BenderAmmoCount", ScrW() - EFGM.ScreenScale(320), EFGM.ScreenScale(21), Color(255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 1, Color(0, 100, 0, 128))

        for k, v in ipairs(extractList) do

            surface.DrawRect(ScrW() - EFGM.ScreenScale(515), EFGM.ScreenScale(61) + ((k - 1) * EFGM.ScreenScale(41)), EFGM.ScreenScale(390), EFGM.ScreenScale(36))
            surface.DrawRect(ScrW() - EFGM.ScreenScale(120), EFGM.ScreenScale(61) + ((k - 1) * EFGM.ScreenScale(41)), EFGM.ScreenScale(100), EFGM.ScreenScale(36))

            draw.DrawText("EXFIL0" .. k, "BenderExfilList", ScrW() - EFGM.ScreenScale(505), EFGM.ScreenScale(60) + ((k - 1) * EFGM.ScreenScale(41)), exitStatusTbl[v.IsDisabled], TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
            draw.DrawText(string.sub(v.ExtractName, 1, 18), "BenderExfilName", ScrW() - EFGM.ScreenScale(380), EFGM.ScreenScale(65) + ((k - 1) * EFGM.ScreenScale(41)), Color(255, 255, 255), TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)

        end
    end

    extracts:AlphaTo(255, 0.35, 0, nil)
    extracts:AlphaTo(0, 1, 4.65, function() extracts:Remove() end)
end

-- intro
function RenderRaidIntro()
    if IsValid(intro) then return end

    intro = vgui.Create("DPanel")
    intro:SetSize(ScrW(), ScrH())
    intro:SetPos(0, 0)
    intro:SetAlpha(0)
    intro:MoveToFront()

    intro.Paint = function(self, w, h)
        if !ply:Alive() then return end

        draw.DrawText("Raid #" .. ply:GetNWInt("RaidsPlayed", 0), "BenderAmmoCount", EFGM.ScreenScale(20), EFGM.ScreenScale(21), Color(255, 255, 255, 200), TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
        draw.DrawText(os.date("%H:%M:%S"), "BenderAmmoCount", EFGM.ScreenScale(20), EFGM.ScreenScale(50), Color(255, 255, 255, 200), TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
        draw.DrawText("Level " .. ply:GetNWInt("Level", 0) .. ", Operator " .. ply:GetName(), "BenderAmmoCount", EFGM.ScreenScale(20), EFGM.ScreenScale(80), Color(255, 255, 255, 200), TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
        draw.DrawText("Garkov, " .. MAPNAMES[game.GetMap()] or "", "BenderAmmoCount", EFGM.ScreenScale(20), EFGM.ScreenScale(110), Color(255, 255, 255, 200), TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
    end

    intro:AlphaTo(255, 0.35, 0, nil)
    intro:AlphaTo(0, 1, 5.65, function() intro:Remove() end)
end

-- compass
function RenderCompass()
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
        if !ply:Alive() then return end

        local ang = ply:EyeAngles()

        surface.SetDrawColor(color)
        surface.DrawLine(ScrW() / 2, 0, ScrW() / 2, EFGM.ScreenScale(6))

        local compassX, compassY = (ScrW() / 2), EFGM.ScreenScale(-5)
        local width, height = (EFGM.ScreenScale(ScrW()) / 2), EFGM.ScreenScale(10)

        spacing = width / 360
        numOfLines = width / spacing
        fadeDistMultiplier = EFGM.ScreenScale(25)
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

                draw.DrawText(text, "BenderExfilList", x, compassY + height * EFGM.ScreenScale(0.6), Color(color.r, color.g, color.b, calculation), TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP)
            end
        end
    end

    compass:AlphaTo(255, 0.35, 0, nil)
    compass:AlphaTo(0, 1, 4.65, function() compass:Remove() end)
end

function RenderPlayerInfo(ent)
    if !ent:IsPlayer() then return end
    if hook.Run("ShouldDrawTargetID", ent) == false then return end

    local inHideout = ent:CompareStatus(0)

    local name = string.upper(ent:Name())
    surface.SetFont("BenderExfilTimerMenu")
    local nameTextSize = surface.GetTextSize(name) + EFGM.ScreenScale(10)

    local squadBind = string.upper(input.GetKeyName(GetConVar("efgm_bind_teaminvite"):GetInt()) or "NONE")
    local duelBind = string.upper(input.GetKeyName(GetConVar("efgm_bind_duelinvite"):GetInt()) or "NONE")
    local profileBind = string.upper(input.GetKeyName(GetConVar("efgm_bind_viewprofile"):GetInt()) or "NONE")

    local inviteText = string.upper("[" .. squadBind .. "] INVITE TO SQUAD" .. "   " .. "[" .. duelBind .. "] INVITE TO DUEL" .. "   " .. "[" .. profileBind .. "] VIEW PROFILE")
    if (CurTime() - Invites.lastInviteSentTime < 10) or Invites.invitedBy != nil or Invites.invitedType != nil then inviteText = string.upper("[" .. profileBind .. "] VIEW PROFILE") end
    surface.SetFont("Bender24")
    local inviteTextSize = surface.GetTextSize(inviteText) + EFGM.ScreenScale(10)

    local infoSize = math.max(nameTextSize, inviteTextSize)
    local infoSizeY = EFGM.ScreenScale(90)
    if !inHideout then infoSize = nameTextSize infoSizeY = EFGM.ScreenScale(65) end

    surface.SetDrawColor(Colors.hudBackground)
    surface.DrawRect(ScrW() / 2 - (infoSize / 2), ScrH() - infoSizeY - EFGM.ScreenScale(20), infoSize, infoSizeY)

    surface.SetDrawColor(Colors.transparentWhiteColor)
    surface.DrawRect(ScrW() / 2 - (infoSize / 2), ScrH() - infoSizeY - EFGM.ScreenScale(20), infoSize, EFGM.ScreenScale(1))

    draw.DrawText(name, "BenderExfilTimer", ScrW() / 2, ScrH() - infoSizeY - EFGM.ScreenScale(20), Color(255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP)

    if !inHideout or !Invites.allow then return end
    draw.DrawText(inviteText, "Bender24", ScrW() / 2, ScrH() - infoSizeY + EFGM.ScreenScale(40), Color(255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP)
end

local function RenderVOIPIndicator()
    surface.SetDrawColor(175, 255, 0)
    surface.SetMaterial(Mats.voipIcon)
    surface.DrawTexturedRect(EFGM.ScreenScale(121), ScrH() - EFGM.ScreenScale(90), EFGM.ScreenScale(60), EFGM.ScreenScale(60))
end

-- invites
function RenderInvite()
    if IsValid(invite) then return end

    invite = vgui.Create("DPanel")
    invite:SetSize(ScrW(), ScrH())
    invite:SetPos(0, 0)
    invite:SetAlpha(0)
    invite:MoveToFront()

    surface.PlaySound("ui/invite_receive.wav")

    local time = CurTime() + 10
    local sentBy = Invites.invitedBy
    local inviteType = Invites.invitedType

    local text = ""
    if inviteType == "squad" then

        text = string.upper(sentBy:GetName() .. " invited you to join their squad!")

    elseif inviteType == "duel" then

        text = string.upper(sentBy:GetName() .. " wants to duel!")

    end

    surface.SetFont("BenderExfilTimer")
    local textSize = surface.GetTextSize(text) + EFGM.ScreenScale(10)

    local acceptBind = string.upper(input.GetKeyName(GetConVar("efgm_bind_invites_accept"):GetInt()) or "N/A")
    local declineBind = string.upper(input.GetKeyName(GetConVar("efgm_bind_invites_decline"):GetInt()) or "N/A")

    local bindsText = string.upper("[" .. acceptBind .. "] ACCEPT" .. "   " .. "[" .. declineBind .. "] IGNORE")
    surface.SetFont("Bender24")
    local bindsTextSize = surface.GetTextSize(bindsText) + EFGM.ScreenScale(10)

    invite.Paint = function(self, w, h)
        if !ply:Alive() then return end
        if !ply:CompareStatus(0) then return end
        if Invites.invitedBy == nil or Invites.invitedType == nil or !Invites.allow then invite:AlphaTo(0, 0.1, 9.9, function() invite:Remove() end) return end

        surface.SetDrawColor(Colors.hudBackground)
        surface.DrawRect(EFGM.ScreenScale(20), EFGM.ScreenScale(20), math.max(textSize, bindsTextSize), EFGM.ScreenScale(90))

        surface.SetDrawColor(Colors.hudBackground)
        surface.DrawRect(EFGM.ScreenScale(20), EFGM.ScreenScale(20), math.max(textSize, bindsTextSize), EFGM.ScreenScale(1))

        surface.SetDrawColor(Colors.transparentWhiteColor)
        surface.DrawRect(EFGM.ScreenScale(20), EFGM.ScreenScale(20), ((time - CurTime()) / 10) * math.max(textSize, bindsTextSize), EFGM.ScreenScale(1))

        draw.SimpleText(text, "BenderExfilTimer", EFGM.ScreenScale(25), EFGM.ScreenScale(21), Color(255, 255, 255), TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
        draw.SimpleText(bindsText, "Bender24", EFGM.ScreenScale(25), EFGM.ScreenScale(81), Color(255, 255, 255), TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
    end

    invite:AlphaTo(255, 0.1, 0, nil)
    invite:AlphaTo(0, 0.1, 10, function() invite:Remove() end)
end

function RenderDuelLoadout()

    if IsValid(DuelLoadout) then DuelLoadout:Remove() end

    DuelLoadout = vgui.Create("DPanel")
    DuelLoadout:SetSize(ScrW(), ScrH())
    DuelLoadout:SetPos(0, 0)
    DuelLoadout:SetAlpha(255)
    DuelLoadout:MoveToFront()

    local primary = playerWeaponSlots[1][1] or {}
    local holster = playerWeaponSlots[2][1] or {}

    local hasPrimary = !table.IsEmpty(primary)
    local hasHolster = !table.IsEmpty(holster)

    if !hasPrimary and !hasHolster then return end

    local primaryDef
    local primaryName
    local primaryNameSize = 0
    local primaryCal
    local primaryEnt
    local primaryMax = 0
    local primaryMode
    local primaryModeSize = 0
    local holsterDef
    local holsterName
    local holsterNameSize = 0
    local holsterCal
    local holsterEnt
    local holsterMax = 0
    local holsterMode
    local holsterModeSize = 0

    surface.SetFont("Bender24")

    if hasPrimary then
        primaryDef = EFGMITEMS[primary.name]

        primaryName = primaryDef.displayName
        primaryNameSize = surface.GetTextSize(primaryName) + EFGM.ScreenScale(140)
        primaryCal = primaryDef.caliber or ""

        primaryEnt = ply:GetWeapon(primary.name)
        primaryMax = tostring(primaryEnt:GetMaxClip1() or 0)
        primaryMode = string.upper(string.sub(primaryEnt:GetFiremodeName() or "", 1, 1))
        primaryModeSize = surface.GetTextSize(primaryMode) + EFGM.ScreenScale(5)
    end

    if hasHolster then
        holsterDef = EFGMITEMS[holster.name]

        holsterName = holsterDef.displayName
        holsterNameSize = surface.GetTextSize(holsterName) + EFGM.ScreenScale(140)

        holsterCal = holsterDef.caliber or ""

        holsterEnt = ply:GetWeapon(holster.name)
        holsterMax = tostring(holsterEnt:GetMaxClip1() or 0)
        holsterMode = string.upper(string.sub(holsterEnt:GetFiremodeName() or "", 1, 1))
        holsterModeSize = surface.GetTextSize(holsterMode) + EFGM.ScreenScale(5)
    end

    local loadoutSize = math.max(primaryNameSize, holsterNameSize)
    local loadoutSizeY = EFGM.ScreenScale(43)
    local holsterY = EFGM.ScreenScale(-18)
    if hasPrimary then loadoutSizeY = EFGM.ScreenScale(90) holsterY = EFGM.ScreenScale(25) end

    DuelLoadout.Paint = function(self, w, h)
        if !ply:Alive() then return end
        if !ply:CompareStatus(3) then return end

        surface.SetDrawColor(Colors.hudBackground)
        surface.DrawRect(ScrW() / 2 - (loadoutSize / 2), ScrH() - loadoutSizeY - EFGM.ScreenScale(20), loadoutSize, loadoutSizeY)

        surface.SetDrawColor(Colors.transparentWhiteColor)
        surface.DrawRect(ScrW() / 2 - (loadoutSize / 2), ScrH() - loadoutSizeY - EFGM.ScreenScale(20), loadoutSize, EFGM.ScreenScale(1))

        if hasPrimary then
            primaryMax = tostring(primaryEnt:GetMaxClip1() or 0)
            draw.DrawText(primaryName, "Bender24", ScrW() / 2 - (loadoutSize / 2) + EFGM.ScreenScale(5), ScrH() - loadoutSizeY - EFGM.ScreenScale(15), Color(255, 255, 255), TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
            draw.DrawText(primaryCal, "Bender18", ScrW() / 2 - (loadoutSize / 2) + EFGM.ScreenScale(5), ScrH() - loadoutSizeY + EFGM.ScreenScale(5), Color(255, 255, 255), TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)

            surface.SetMaterial(Mats.switchIcon)
            surface.SetDrawColor(Colors.pureWhiteColor)
            surface.DrawTexturedRect(ScrW() / 2 + (loadoutSize / 2) - EFGM.ScreenScale(31), ScrH() - loadoutSizeY - EFGM.ScreenScale(15), EFGM.ScreenScale(24), EFGM.ScreenScale(24))

            draw.DrawText(primaryMode, "Bender24", ScrW() / 2 + (loadoutSize / 2) - EFGM.ScreenScale(36), ScrH() - loadoutSizeY - EFGM.ScreenScale(15), Color(255, 255, 255), TEXT_ALIGN_RIGHT, TEXT_ALIGN_TOP)

            surface.SetMaterial(Mats.bulletsIcon)
            surface.SetDrawColor(Colors.pureWhiteColor)
            surface.DrawTexturedRect(ScrW() / 2 + (loadoutSize / 2) - EFGM.ScreenScale(65) - primaryModeSize, ScrH() - loadoutSizeY - EFGM.ScreenScale(15), EFGM.ScreenScale(24), EFGM.ScreenScale(24))

            draw.DrawText(primaryMax, "Bender24", ScrW() / 2 + (loadoutSize / 2) - EFGM.ScreenScale(70) - primaryModeSize, ScrH() - loadoutSizeY - EFGM.ScreenScale(15), Color(255, 255, 255), TEXT_ALIGN_RIGHT, TEXT_ALIGN_TOP)
        end

        if hasHolster then
            holsterMax = tostring(holsterEnt:GetMaxClip1() or 0)
            draw.DrawText(holsterName, "Bender24", ScrW() / 2 - (loadoutSize / 2) + EFGM.ScreenScale(5), ScrH() - loadoutSizeY + holsterY, Color(255, 255, 255), TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
            draw.DrawText(holsterCal, "Bender18", ScrW() / 2 - (loadoutSize / 2) + EFGM.ScreenScale(5), ScrH() - loadoutSizeY + holsterY + EFGM.ScreenScale(20), Color(255, 255, 255), TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)

            surface.SetMaterial(Mats.switchIcon)
            surface.SetDrawColor(Colors.pureWhiteColor)
            surface.DrawTexturedRect(ScrW() / 2 + (loadoutSize / 2) - EFGM.ScreenScale(31), ScrH() - loadoutSizeY + holsterY, EFGM.ScreenScale(24), EFGM.ScreenScale(24))

            draw.DrawText(holsterMode, "Bender24", ScrW() / 2 + (loadoutSize / 2) - EFGM.ScreenScale(36), ScrH() - loadoutSizeY + holsterY, Color(255, 255, 255), TEXT_ALIGN_RIGHT, TEXT_ALIGN_TOP)

            surface.SetMaterial(Mats.bulletsIcon)
            surface.SetDrawColor(Colors.pureWhiteColor)
            surface.DrawTexturedRect(ScrW() / 2 + (loadoutSize / 2) - EFGM.ScreenScale(65) - holsterModeSize, ScrH() - loadoutSizeY + holsterY, EFGM.ScreenScale(24), EFGM.ScreenScale(24))

            draw.DrawText(holsterMax, "Bender24", ScrW() / 2 + (loadoutSize / 2) - EFGM.ScreenScale(70) - holsterModeSize, ScrH() - loadoutSizeY + holsterY, Color(255, 255, 255), TEXT_ALIGN_RIGHT, TEXT_ALIGN_TOP)
        end
    end

    DuelLoadout:AlphaTo(255, 0.35, 0, nil)
    DuelLoadout:AlphaTo(0, 0.1, 2.35, function() DuelLoadout:Remove() end)
end

local function DrawHUD()
    ply = ply or LocalPlayer()
    if !ply:Alive() or Menu.IsOpen then RenderOverlays() return end
    if !enabled then return end

    RenderRaidTime()
    RenderPlayerWeapon()
    RenderPlayerStance()
    RenderOverlays()
end
hook.Add("HUDPaint", "DrawHUD", DrawHUD)

IsInIntro = false
IntroCameraEnt = nil

local function SetCameraToIntro(ply, pos, angles, fov)

    if IntroCameraEnt != nil && IsInIntro then
        
        local camera = IntroCameraEnt:GetAttachment(1)

        local view = {
            origin = camera.Pos,
            angles = camera.Ang,
            fov = 90,
            drawviewer = false
        }

        return view

    end

    local view = {
        origin = pos,
        angles = angles,
        fov = fov,
        drawviewer = false
    }

    return view

end
hook.Add("CalcView", "SetIntroView", SetCameraToIntro) -- bc i think hudpaint gets removed? sometimes? im not sure tbh

net.Receive("SendIntroCamera", function()

    IntroCameraEnt = net.ReadEntity()

end)

net.Receive("PlayerRaidTransition", function()

    local readIsInIntro = net.ReadBool()
    IsInIntro = IsInIntro or readIsInIntro
    
    if !readIsInIntro then
        timer.Simple(1, function()
            IsInIntro = false
        end)
    end

    if LocalPlayer():GetNWInt("PlayerRaidStatus", 0) == 0 then

        hook.Run("efgm_raid_enter")

        timer.Simple(1.5, function()
            RenderRaidIntro()
        end)

    end

    HUD.InTransition = true

    if IsValid(notif) then notif:Remove() end

    RaidTransition = vgui.Create("DPanel")
    RaidTransition:SetSize(ScrW(), ScrH())
    RaidTransition:SetPos(0, 0)
    RaidTransition:SetAlpha(0)
    RaidTransition:MoveToFront()

    RaidTransition.Paint = function(self, w, h)
        if !RaidTransition:IsValid() then return end
        BlurPanel(RaidTransition, EFGM.ScreenScale(13))
        BlurPanel(RaidTransition, EFGM.ScreenScale(13))

        surface.SetDrawColor(0, 0, 0, 255)
        surface.DrawRect(0, 0, ScrW(), ScrH())
    end

    RaidTransition:AlphaTo(255, 0.5, 0, nil)
    RaidTransition:AlphaTo(0, 0.35, 1, function() HUD.InTransition = false RaidTransition:Remove() end)

    timer.Simple(2.5, function()
        RenderExtracts()
    end)

    if Menu.MenuFrame == nil then return end
    if Menu.MenuFrame:IsActive() != true then return end

    Menu.Closing = true
    Menu.MenuFrame:SetKeyboardInputEnabled(false)
    Menu.MenuFrame:SetMouseInputEnabled(false)
    Menu.IsOpen = false

    Menu.MenuFrame:AlphaTo(0, 0.1, 0, function()
        Menu.MenuFrame:Close()
    end)

end )

net.Receive("PlayerDuelTransition", function()

    if LocalPlayer():GetNWInt("PlayerRaidStatus", 0) == 0 then

        hook.Run("efgm_duel_enter")

        timer.Simple(1, function()
            RenderDuelLoadout()
        end)

    end

    HUD.InTransition = true

    if IsValid(notif) then notif:Remove() end

    RaidTransition = vgui.Create("DPanel")
    RaidTransition:SetSize(ScrW(), ScrH())
    RaidTransition:SetPos(0, 0)
    RaidTransition:SetAlpha(0)
    RaidTransition:MoveToFront()

    RaidTransition.Paint = function(self, w, h)
        if !RaidTransition:IsValid() then return end
        BlurPanel(RaidTransition, EFGM.ScreenScale(13))
        BlurPanel(RaidTransition, EFGM.ScreenScale(13))

        surface.SetDrawColor(0, 0, 0, 255)
        surface.DrawRect(0, 0, ScrW(), ScrH())
    end

    RaidTransition:AlphaTo(255, 0.5, 0, nil)
    RaidTransition:AlphaTo(0, 0.35, 1, function() HUD.InTransition = false RaidTransition:Remove() end)

    if Menu.MenuFrame == nil then return end
    if Menu.MenuFrame:IsActive() != true then return end

    Menu.Closing = true
    Menu.MenuFrame:SetKeyboardInputEnabled(false)
    Menu.MenuFrame:SetMouseInputEnabled(false)
    Menu.IsOpen = false

    Menu.MenuFrame:AlphaTo(0, 0.1, 0, function()
        Menu.MenuFrame:Close()
    end)

end )

net.Receive("SendExtractionStatus", function()
    local status = net.ReadBool()

    if status then
        if IsValid(ExtractPopup) then return end

        local exitTime = net.ReadInt(16)
        local exitTimeLeft = exitTime
        timer.Create("TimeToExit", exitTime, 1, function()
            ExtractPopup:Remove()
            hook.Remove("Think", "TimeToExit")
        end)

        hook.Add("Think", "TimeToExitCalc", function()
            if timer.Exists("TimeToExit") then exitTimeLeft = math.Round(timer.TimeLeft("TimeToExit"), 1) end
        end)

        ExtractPopup = vgui.Create("DPanel")
        ExtractPopup:SetSize(ScrW(), ScrH())
        ExtractPopup:SetPos(0, 0)
        ExtractPopup:SetAlpha(0)
        ExtractPopup:MoveToFront()

        ExtractPopup.Paint = function(self, w, h)
            surface.SetDrawColor(120, 180, 40, 125)
            surface.DrawRect(w / 2 - EFGM.ScreenScale(125), h - EFGM.ScreenScale(300), EFGM.ScreenScale(250), EFGM.ScreenScale(80))

            draw.DrawText("EXTRACTION IN", "BenderExfilList", w / 2, h - EFGM.ScreenScale(300), Colors.blackColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP)
            draw.DrawText(string.format("%.1f", tostring(exitTimeLeft)), "BenderExfilTimer", w / 2, h - EFGM.ScreenScale(275), Colors.blackColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP)

            surface.SetDrawColor(Colors.hudBackground)
            surface.DrawRect(w / 2 - EFGM.ScreenScale(125), h - EFGM.ScreenScale(215), EFGM.ScreenScale(250), EFGM.ScreenScale(5))

            surface.SetDrawColor(120, 180, 40, 125)
            surface.DrawRect((w / 2) - EFGM.ScreenScale(250) * (exitTimeLeft / exitTime) / 2, h - EFGM.ScreenScale(215), EFGM.ScreenScale(250) * (exitTimeLeft / exitTime), EFGM.ScreenScale(5))
        end

        ExtractPopup:AlphaTo(255, 0.1, 0, nil)
    else
        if !IsValid(ExtractPopup) then return end

        ExtractPopup:AlphaTo(0, 0.1, 0, function() ExtractPopup:Remove() timer.Remove("TimeToExit") hook.Remove("Think", "TimeToExit") end)
    end
end)

net.Receive("CreateDeathInformation", function()

    hook.Run("efgm_raid_exit", false)

    local xpMult = net.ReadFloat()

    local respawnTime = net.ReadInt(8)
    local timeInRaid = net.ReadInt(16)

    local statsTbl = {
        ["DAMAGE DEALT:"] = math.Round(ply:GetNWInt("RaidDamageDealt", 0)),
        ["DAMAGE RECEIVED FROM OPERATORS:"] = math.Round(ply:GetNWInt("RaidDamageRecievedPlayers", 0)),
        ["DAMAGE RECEIVED FROM FALLING:"] = math.Round(ply:GetNWInt("RaidDamageRecievedFalling", 0)),
        ["DAMAGE RECEIVED:"] = math.Round(ply:GetNWInt("RaidDamageRecievedPlayers", 0) + ply:GetNWInt("RaidDamageRecievedFalling", 0)),
        ["HEALTH HEALED:"] = math.Round(ply:GetNWInt("RaidHealthHealed", 0)),
        ["ITEMS LOOTED:"] = ply:GetNWInt("RaidItemsLooted", 0),
        ["CONTAINERS OPENED:"] = ply:GetNWInt("RaidContainersLooted", 0),
        ["KEYS USED:"] = ply:GetNWInt("RaidKeysUsed", 0),
        ["OPERATORS KILLED:"] = ply:GetNWInt("RaidKills", 0),
        ["FARTHEST KILL:"] = ply:GetNWInt("RaidFarthestKill", 0),
        ["SHOTS FIRED:"] = ply:GetNWInt("RaidShotsFired", 0),
        ["SHOTS HIT:"] = ply:GetNWInt("RaidShotsHit", 0),
        ["GRENADES THROWN:"] = ply:GetNWInt("RaidGrenadesThrown", 0)
    }
    table.SortByKey(statsTbl)

    local xpTime = net.ReadInt(16)
    local xpCombat = net.ReadInt(16)
    local xpExploration = net.ReadInt(16)
    local xpLooting = net.ReadInt(16)
    local xpBonus = net.ReadInt(16)

    local killedBy = net.ReadEntity()
    local killedByHealth = net.ReadInt(8)
    local killedByWeapon = net.ReadString()
    local killedFrom = net.ReadInt(16)
    local hitGroup = net.ReadInt(5)

    local minutes = math.floor(timeInRaid / 60)
    local seconds = timeInRaid % 60

    local totalXPRaw = xpTime + xpCombat + xpExploration + xpLooting + xpBonus
    local totalXPReal = math.Round(totalXPRaw * xpMult, 0)

    local quote = QUOTES[math.random(1, #QUOTES)]

    if respawnTime > noRaidRespawnTime then surface.PlaySound("death_heartbeat.wav") end

    timer.Simple(respawnTime, function()

        if IsValid(DeathPopup) then return end

        local RewardsPanel = nil
        local AttackerPanel = nil
        local MapPanel = nil
        local respawnButton = nil

        DeathPopup = vgui.Create("DPanel")
        DeathPopup:SetSize(ScrW(), ScrH())
        DeathPopup:SetPos(0, 0)
        DeathPopup:SetAlpha(0)
        DeathPopup:MakePopup()
        DeathPopup:SetMouseInputEnabled(true)
        DeathPopup:SetKeyboardInputEnabled(true)

        DeathPopup.Paint = function(self, w, h)

            BlurPanel(DeathPopup, EFGM.MenuScale(5))

            draw.SimpleTextOutlined("KILLED IN ACTION", "PuristaBold64", w / 2, EFGM.MenuScale(35), Color(255, 0, 0, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 1, Colors.whiteColor)
            draw.SimpleTextOutlined(string.format("%02d:%02d", minutes, seconds) .. " TIME IN RAID", "PuristaBold22", w / 2, EFGM.MenuScale(90), Colors.whiteColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 1, Colors.blackColor)
            draw.SimpleTextOutlined(quote, "Purista18Italic", w / 2, EFGM.MenuScale(108), Colors.whiteColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 1, Colors.blackColor)

            DeathPopup.MouseX, DeathPopup.MouseY = DeathPopup:LocalCursorPos()

            if GetConVar("efgm_menu_parallax"):GetInt() == 1 then

                DeathPopup.ParallaxX = math.Clamp(((DeathPopup.MouseX / math.Round(EFGM.MenuScale(1920), 1)) - 0.5) * EFGM.MenuScale(20), -10, 10)
                DeathPopup.ParallaxY = math.Clamp(((DeathPopup.MouseY / math.Round(EFGM.MenuScale(1080), 1)) - 0.5) * EFGM.MenuScale(20), -10, 10)

                DeathPopup:SetPos(0 + DeathPopup.ParallaxX, 0 + DeathPopup.ParallaxY)

            else

                DeathPopup.ParallaxX = 0
                DeathPopup.ParallaxY = 0

                DeathPopup:SetPos(0, 0)

            end

            if AttackerPanel and MapPanel then

                if RewardsPanel then RewardsPanel:SetX(DeathPopup:GetWide() / 2 - EFGM.MenuScale(920)) end
                if MapPanel then MapPanel:SetX(DeathPopup:GetWide() / 2 - EFGM.MenuScale(400)) end
                if AttackerPanel then AttackerPanel:SetX(DeathPopup:GetWide() / 2 + EFGM.MenuScale(420)) end
                if respawnButton then respawnButton:SetWide(EFGM.MenuScale(1840)) end

            elseif AttackerPanel then

                if RewardsPanel then

                    RewardsPanel:SetX(DeathPopup:GetWide() / 2 - EFGM.MenuScale(510))

                    if AttackerPanel then AttackerPanel:SetX(DeathPopup:GetWide() / 2 + EFGM.MenuScale(10)) end
                    if respawnButton then respawnButton:SetWide(EFGM.MenuScale(1020)) end

                else

                    if AttackerPanel then AttackerPanel:SetX(DeathPopup:GetWide() / 2 - EFGM.MenuScale(250)) end
                    if respawnButton then respawnButton:SetWide(EFGM.MenuScale(500)) end

                end

            elseif MapPanel then

                if RewardsPanel then RewardsPanel:SetX(DeathPopup:GetWide() / 2 - EFGM.MenuScale(660)) end
                if MapPanel then MapPanel:SetX(DeathPopup:GetWide() / 2 - EFGM.MenuScale(140)) end
                if respawnButton then respawnButton:SetWide(EFGM.MenuScale(1320)) end

            else

                if RewardsPanel then RewardsPanel:SetX(DeathPopup:GetWide() / 2 - EFGM.MenuScale(250)) end
                if respawnButton then respawnButton:SetWide(EFGM.MenuScale(500)) end

            end

            if respawnButton then respawnButton:SetX(ScrW() / 2 - respawnButton:GetWide() / 2) end

        end

        DeathPopup:AlphaTo(255, 0.2, 0, nil)
        if respawnTime > noRaidRespawnTime then surface.PlaySound("extract_failed.wav") end

        respawnButton = vgui.Create("DButton", DeathPopup)
        respawnButton:SetSize(EFGM.MenuScale(1020), EFGM.MenuScale(50))
        respawnButton:SetPos(ScrW() / 2 - EFGM.MenuScale(510), DeathPopup:GetTall() - EFGM.MenuScale(100))
        respawnButton:SetText("")
        respawnButton.Paint = function(s, w, h)

            surface.SetDrawColor(Color(80, 80, 80, 10))
            surface.DrawRect(0, 0, w, h)

            surface.SetDrawColor(Colors.transparentWhiteColor)
            surface.DrawRect(0, 0, respawnButton:GetWide(), EFGM.MenuScale(2))

            draw.SimpleTextOutlined("RETURN TO HIDEOUT", "PuristaBold32", w / 2, EFGM.MenuScale(7), Colors.whiteColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 1, Colors.blackColor)

        end

        function respawnButton:DoClick()

            net.Start("PlayerRequestRespawn", false)
            net.SendToServer()

            surface.PlaySound("ui/element_select.wav")
            DeathPopup:AlphaTo(0, 0.1, 0, function() DeathPopup:Remove() end)

        end

        if respawnTime > noRaidRespawnTime then

            RewardsPanel = vgui.Create("DPanel", DeathPopup)
            RewardsPanel:SetSize(EFGM.MenuScale(500), EFGM.MenuScale(800))
            RewardsPanel:SetPos(DeathPopup:GetWide() / 2 - EFGM.MenuScale(510), EFGM.MenuScale(140))

            RewardsPanel.Paint = function(self, w, h)

                BlurPanel(RewardsPanel, EFGM.MenuScale(3))

                surface.SetDrawColor(Color(80, 80, 80, 10))
                surface.DrawRect(0, 0, w, h)

                surface.SetDrawColor(Color(255, 255, 255, 25))
                surface.DrawRect(0, 0, w, EFGM.MenuScale(1))
                surface.DrawRect(0, h - 1, w, EFGM.MenuScale(1))
                surface.DrawRect(0, 0, EFGM.MenuScale(1), h)
                surface.DrawRect(w - 1, 0, EFGM.MenuScale(1), h)

            end

            StatsPanel = vgui.Create("DPanel", RewardsPanel)
            StatsPanel:SetSize(0, EFGM.MenuScale(500))
            StatsPanel:Dock(TOP)
            StatsPanel:DockMargin(EFGM.MenuScale(5), EFGM.MenuScale(5), EFGM.MenuScale(5), EFGM.MenuScale(5))

            StatsPanel.Paint = function(self, w, h)

                surface.SetDrawColor(Color(80, 80, 80, 10))
                surface.DrawRect(0, 0, w, h)

                surface.SetDrawColor(Colors.transparentWhiteColor)
                surface.DrawRect(0, 0, w, EFGM.MenuScale(6))

                surface.SetDrawColor(Color(255, 255, 255, 10))
                surface.DrawRect(0, 0, w, EFGM.MenuScale(1))
                surface.DrawRect(0, h - 1, w, EFGM.MenuScale(1))
                surface.DrawRect(0, 0, EFGM.MenuScale(1), h)
                surface.DrawRect(w - 1, 0, EFGM.MenuScale(1), h)

            end

            local StatsText = vgui.Create("DPanel", StatsPanel)
            StatsText:Dock(TOP)
            StatsText:SetSize(0, EFGM.MenuScale(36))
            function StatsText:Paint(w, h)

                surface.SetDrawColor(Color(155, 155, 155, 10))
                surface.DrawRect(0, 0, w, h)

                draw.SimpleTextOutlined("STATS", "PuristaBold32", EFGM.MenuScale(5), EFGM.MenuScale(2), Colors.whiteColor, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP, 1, Colors.blackColor)

            end

            local StatsHolder = vgui.Create("DPanel", StatsPanel)
            StatsHolder:Dock(FILL)
            StatsHolder:DockMargin(EFGM.MenuScale(5), EFGM.MenuScale(5), EFGM.MenuScale(5), EFGM.MenuScale(5))
            StatsHolder:SetSize(0, 0)
            StatsHolder.Paint = function(s, w, h)

                surface.SetDrawColor(Color(0, 0, 0, 0))
                surface.DrawRect(0, 0, w, h)

                local num = 0

                for k, v in pairs(statsTbl) do

                    if v == 0 then continue end

                    draw.SimpleTextOutlined(k, "PuristaBold24", EFGM.MenuScale(3), EFGM.MenuScale(22) * num, Colors.whiteColor, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP, 1, Colors.blackColor)
                    draw.SimpleTextOutlined(v, "PuristaBold24", w - EFGM.MenuScale(3), EFGM.MenuScale(22) * num, Colors.whiteColor, TEXT_ALIGN_RIGHT, TEXT_ALIGN_TOP, 1, Colors.blackColor)

                    num = num + 1

                end

            end

            LevelingPanel = vgui.Create("DPanel", RewardsPanel)
            LevelingPanel:SetSize(0, EFGM.MenuScale(285))
            LevelingPanel:Dock(TOP)
            LevelingPanel:DockMargin(EFGM.MenuScale(5), 0, EFGM.MenuScale(5), EFGM.MenuScale(5))

            LevelingPanel.Paint = function(self, w, h)

                surface.SetDrawColor(Color(80, 80, 80, 10))
                surface.DrawRect(0, 0, w, h)

                surface.SetDrawColor(Colors.transparentWhiteColor)
                surface.DrawRect(0, 0, w, EFGM.MenuScale(6))

                surface.SetDrawColor(Color(255, 255, 255, 10))
                surface.DrawRect(0, 0, w, EFGM.MenuScale(1))
                surface.DrawRect(0, h - 1, w, EFGM.MenuScale(1))
                surface.DrawRect(0, 0, EFGM.MenuScale(1), h)
                surface.DrawRect(w - 1, 0, EFGM.MenuScale(1), h)

            end

            local LevelingText = vgui.Create("DPanel", LevelingPanel)
            LevelingText:Dock(TOP)
            LevelingText:SetSize(0, EFGM.MenuScale(36))
            function LevelingText:Paint(w, h)

                surface.SetDrawColor(Color(155, 155, 155, 10))
                surface.DrawRect(0, 0, w, h)

                draw.SimpleTextOutlined("LEVELING", "PuristaBold32", EFGM.MenuScale(5), EFGM.MenuScale(2), Colors.whiteColor, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP, 1, Colors.blackColor)

            end

            local LevelingHolder = vgui.Create("DPanel", LevelingPanel)
            LevelingHolder:Dock(FILL)
            LevelingHolder:DockMargin(EFGM.MenuScale(5), EFGM.MenuScale(5), EFGM.MenuScale(5), EFGM.MenuScale(5))
            LevelingHolder:SetSize(0, 0)
            LevelingHolder.Paint = function(s, w, h)

                surface.SetDrawColor(Color(0, 0, 0, 0))
                surface.DrawRect(0, 0, w, h)

                draw.SimpleTextOutlined("TIME: ", "PuristaBold24", EFGM.MenuScale(3), 0, Colors.whiteColor, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP, 1, Colors.blackColor)
                draw.SimpleTextOutlined(xpTime .. "XP", "PuristaBold24", w - EFGM.MenuScale(3), 0, Colors.whiteColor, TEXT_ALIGN_RIGHT, TEXT_ALIGN_TOP, 1, Colors.blackColor)

                draw.SimpleTextOutlined("COMBAT: ", "PuristaBold24", EFGM.MenuScale(3), EFGM.MenuScale(22), Colors.whiteColor, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP, 1, Colors.blackColor)
                draw.SimpleTextOutlined(xpCombat .. "XP", "PuristaBold24", w - EFGM.MenuScale(3), EFGM.MenuScale(22), Colors.whiteColor, TEXT_ALIGN_RIGHT, TEXT_ALIGN_TOP, 1, Colors.blackColor)

                draw.SimpleTextOutlined("EXPLORATION: ", "PuristaBold24", EFGM.MenuScale(3), EFGM.MenuScale(44), Colors.whiteColor, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP, 1, Colors.blackColor)
                draw.SimpleTextOutlined(xpExploration .. "XP", "PuristaBold24", w - EFGM.MenuScale(3), EFGM.MenuScale(44), Colors.whiteColor, TEXT_ALIGN_RIGHT, TEXT_ALIGN_TOP, 1, Colors.blackColor)

                draw.SimpleTextOutlined("LOOTING: ", "PuristaBold24", EFGM.MenuScale(3), EFGM.MenuScale(66), Colors.whiteColor, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP, 1, Colors.blackColor)
                draw.SimpleTextOutlined(xpLooting .. "XP", "PuristaBold24", w - EFGM.MenuScale(3), EFGM.MenuScale(66), Colors.whiteColor, TEXT_ALIGN_RIGHT, TEXT_ALIGN_TOP, 1, Colors.blackColor)

                draw.SimpleTextOutlined("BONUS: ", "PuristaBold24", EFGM.MenuScale(3), EFGM.MenuScale(88), Colors.whiteColor, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP, 1, Colors.blackColor)
                draw.SimpleTextOutlined(xpBonus .. "XP", "PuristaBold24", w - EFGM.MenuScale(3), EFGM.MenuScale(88), Colors.whiteColor, TEXT_ALIGN_RIGHT, TEXT_ALIGN_TOP, 1, Colors.blackColor)

                draw.SimpleTextOutlined("TOTAL: ", "PuristaBold24", EFGM.MenuScale(3), EFGM.MenuScale(120), Colors.whiteColor, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP, 1, Colors.blackColor)
                draw.SimpleTextOutlined(totalXPRaw .. "XP", "PuristaBold24", w - EFGM.MenuScale(3), EFGM.MenuScale(120), Colors.whiteColor, TEXT_ALIGN_RIGHT, TEXT_ALIGN_TOP, 1, Colors.blackColor)

                draw.SimpleTextOutlined("MULTIPLIER: ", "PuristaBold24", EFGM.MenuScale(3), EFGM.MenuScale(142), Colors.whiteColor, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP, 1, Colors.blackColor)
                draw.SimpleTextOutlined(xpMult .. "x", "PuristaBold24", w - EFGM.MenuScale(3), EFGM.MenuScale(142), Colors.whiteColor, TEXT_ALIGN_RIGHT, TEXT_ALIGN_TOP, 1, Colors.blackColor)

                draw.SimpleTextOutlined("FINAL XP: ", "PuristaBold24", EFGM.MenuScale(3), EFGM.MenuScale(174), Colors.whiteColor, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP, 1, Colors.blackColor)
                draw.SimpleTextOutlined("+" .. totalXPReal .. "XP", "PuristaBold24", w - EFGM.MenuScale(3), EFGM.MenuScale(174), Colors.whiteColor, TEXT_ALIGN_RIGHT, TEXT_ALIGN_TOP, 1, Colors.blackColor)

                draw.SimpleTextOutlined(ply:GetNWInt("Level", 1), "PuristaBold24", EFGM.MenuScale(5), h - EFGM.MenuScale(40), Colors.whiteColor, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP, 1, Colors.blackColor)
                draw.SimpleTextOutlined(ply:GetNWInt("Level", 1) + 1, "PuristaBold24", w - EFGM.MenuScale(5), h - EFGM.MenuScale(40), Colors.whiteColor, TEXT_ALIGN_RIGHT, TEXT_ALIGN_TOP, 1, Colors.blackColor)

                draw.SimpleTextOutlined(ply:GetNWInt("Experience", 0) .. "/" .. ply:GetNWInt("ExperienceToNextLevel", 500), "PuristaBold16", EFGM.MenuScale(30), h - EFGM.MenuScale(33), Colors.whiteColor, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP, 1, Colors.blackColor)

                surface.SetDrawColor(30, 30, 30, 125)
                surface.DrawRect(EFGM.MenuScale(5), h - EFGM.MenuScale(15), EFGM.MenuScale(470), EFGM.MenuScale(10))

                surface.SetDrawColor(255, 255, 255, 175)
                surface.DrawRect(EFGM.MenuScale(5), h - EFGM.MenuScale(15), (ply:GetNWInt("Experience", 0) / ply:GetNWInt("ExperienceToNextLevel", 500)) * EFGM.MenuScale(470), EFGM.MenuScale(10))

            end

        end

        if ply != killedBy and IsValid(killedBy) and killedBy:IsPlayer() then

            AttackerPanel = vgui.Create("DPanel", DeathPopup)
            AttackerPanel:SetSize(EFGM.MenuScale(500), EFGM.MenuScale(800))
            AttackerPanel:SetPos(DeathPopup:GetWide() / 2 + EFGM.MenuScale(10), EFGM.MenuScale(140))
            AttackerPanel:DockMargin(EFGM.MenuScale(5), EFGM.MenuScale(5), EFGM.MenuScale(5), EFGM.MenuScale(5))

            AttackerPanel.Paint = function(self, w, h)

                BlurPanel(AttackerPanel, EFGM.MenuScale(3))

                surface.SetDrawColor(Color(80, 80, 80, 10))
                surface.DrawRect(0, 0, w, h)

                surface.SetDrawColor(Color(255, 255, 255, 25))
                surface.DrawRect(0, 0, w, EFGM.MenuScale(1))
                surface.DrawRect(0, h - 1, w, EFGM.MenuScale(1))
                surface.DrawRect(0, 0, EFGM.MenuScale(1), h)
                surface.DrawRect(w - 1, 0, EFGM.MenuScale(1), h)

            end

            KillerPanel = vgui.Create("DPanel", AttackerPanel)
            KillerPanel:SetSize(0, 0)
            KillerPanel:Dock(FILL)
            KillerPanel:DockMargin(EFGM.MenuScale(5), EFGM.MenuScale(5), EFGM.MenuScale(5), EFGM.MenuScale(5))

            KillerPanel.Paint = function(self, w, h)

                surface.SetDrawColor(Color(80, 80, 80, 10))
                surface.DrawRect(0, 0, w, h)

                surface.SetDrawColor(Colors.transparentWhiteColor)
                surface.DrawRect(0, 0, w, EFGM.MenuScale(6))

                surface.SetDrawColor(Color(255, 255, 255, 10))
                surface.DrawRect(0, 0, w, EFGM.MenuScale(1))
                surface.DrawRect(0, h - 1, w, EFGM.MenuScale(1))
                surface.DrawRect(0, 0, EFGM.MenuScale(1), h)
                surface.DrawRect(w - 1, 0, EFGM.MenuScale(1), h)

            end

            local KillerText = vgui.Create("DPanel", KillerPanel)
            KillerText:Dock(TOP)
            KillerText:SetSize(0, EFGM.MenuScale(36))
            function KillerText:Paint(w, h)

                surface.SetDrawColor(Color(155, 155, 155, 10))
                surface.DrawRect(0, 0, w, h)

                draw.SimpleTextOutlined("KILLED BY", "PuristaBold32", EFGM.MenuScale(5), EFGM.MenuScale(2), Colors.whiteColor, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP, 1, Colors.blackColor)

            end

            local KillerHolder = vgui.Create("DPanel", KillerPanel)
            KillerHolder:Dock(FILL)
            KillerHolder:DockMargin(EFGM.MenuScale(5), EFGM.MenuScale(5), EFGM.MenuScale(5), EFGM.MenuScale(5))
            KillerHolder:SetSize(0, 0)
            KillerHolder.Paint = function(s, w, h)

                surface.SetDrawColor(Color(0, 0, 0, 0))
                surface.DrawRect(0, 0, w, h)

                draw.SimpleTextOutlined(killedBy:GetName(), "PuristaBold24", EFGM.MenuScale(90), 0, Colors.whiteColor, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP, 1, Colors.blackColor)

                if killedFrom != 0 then

                    draw.SimpleTextOutlined("from " .. killedFrom .. "m away", "PuristaBold16", EFGM.MenuScale(90), EFGM.MenuScale(18), Colors.whiteColor, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP, 1, Colors.blackColor)

                end

                if hitGroup != 0 and HITGROUPS[hitGroup] != nil then

                    if killedFrom != 0 then

                        draw.SimpleTextOutlined("in the " .. HITGROUPS[hitGroup], "PuristaBold16", EFGM.MenuScale(90), EFGM.MenuScale(30), Colors.whiteColor, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP, 1, Colors.blackColor)

                    else

                        draw.SimpleTextOutlined("in the " .. HITGROUPS[hitGroup], "PuristaBold16", EFGM.MenuScale(90), EFGM.MenuScale(18), Colors.whiteColor, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP, 1, Colors.blackColor)

                    end

                end

                surface.SetDrawColor(Colors.healthGreenColor)
                surface.SetMaterial(Mats.healthIcon)
                surface.DrawTexturedRect(0, EFGM.MenuScale(90), EFGM.MenuScale(32), EFGM.MenuScale(32))

                draw.SimpleTextOutlined(killedByHealth .. "HP", "PuristaBold24", EFGM.MenuScale(32), EFGM.MenuScale(93), Colors.healthGreenColor, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP, 1, Colors.blackColor)

            end

            local killerPFP = vgui.Create("AvatarImage", KillerHolder)
            killerPFP:SetPos(EFGM.MenuScale(5), EFGM.MenuScale(5))
            killerPFP:SetSize(EFGM.MenuScale(80), EFGM.MenuScale(80))
            killerPFP:SetPlayer(killedBy, 184)

            killerPFP.OnMousePressed = function()

                local dropdown = DermaMenu()

                local profile = dropdown:AddOption("Open Steam Profile", function() gui.OpenURL("http://steamcommunity.com/profiles/" .. killedBy:SteamID64()) end)
                profile:SetIcon("games/16/all.png")
                local gameProfile = dropdown:AddOption("Open Game Profile", function() CreateNotification("I do not work yet LOL!", Mats.dontEvenAsk, "ui/boo.wav") end)
                gameProfile:SetIcon("icon16/chart_bar.png")

                dropdown:AddSpacer()

                dropdown:AddOption("Copy Name", function() SetClipboardText(killedBy:GetName()) end):SetIcon("icon16/pencil_add.png")
                dropdown:AddOption("Copy SteamID64", function() SetClipboardText(killedBy:SteamID64()) end):SetIcon("icon16/pencil_add.png")

                if killedBy != ply then

                    local mute = dropdown:AddOption("Mute Player", function(self)

                        if killedBy:IsMuted() then

                            killedBy:SetMuted(false)

                        else

                            killedBy:SetMuted(true)

                        end

                    end)

                    if killedBy:IsMuted() then

                        mute:SetIcon("icon16/sound.png")
                        mute:SetText("Unmute Player")
                    else

                        mute:SetIcon("icon16/sound_mute.png")
                        mute:SetText("Mute Player")

                    end

                end

                dropdown:Open()

            end

            local playerModel = vgui.Create("DModelPanel", KillerHolder)
            playerModel:SetAlpha(0)
            playerModel:Dock(FILL)
            playerModel:SetMouseInputEnabled(false)
            playerModel:SetFOV(26)
            playerModel:SetCamPos(Vector(10, 0, 0))
            playerModel:SetLookAt(Vector(-100, 0, -24))
            playerModel:SetDirectionalLight(BOX_RIGHT, Color(255, 160, 80, 255))
            playerModel:SetDirectionalLight(BOX_LEFT, Color(80, 160, 255, 255))
            playerModel:SetAnimated(true)
            playerModel:SetModel(killedBy:GetModel())
            playerModel:AlphaTo(255, 0.1, 0, nil)

            local groups = GetEntityGroups(killedBy, override)

            if groups then

                if groups.Bodygroups then

                    for k, v in pairs(groups.Bodygroups) do

                        playerModel.Entity:SetBodygroup(k, v)

                    end

                end

                if groups.Skin then

                    playerModel.Entity:SetSkin(groups.Skin)

                end

            end

            playerModel.Entity:SetPos(Vector(-108, -1, -63))
            playerModel.Entity:SetAngles(Angle(0, 20, 0))

            function playerModel:LayoutEntity(Entity)

                if !IsValid(Entity) then return end
                playerModel:RunAnimation()

            end

            if killedByWeapon != nil and killedByWeapon != "" then

                local def = EFGMITEMS[killedByWeapon]
                if def == nil then return end

                local KilledWithButton = vgui.Create("DButton", KillerPanel)
                KilledWithButton:SetPos(EFGM.MenuScale(5), EFGM.MenuScale(569))
                KilledWithButton:SetSize(EFGM.MenuScale(198), EFGM.MenuScale(216))
                KilledWithButton:SetText("")
                function KilledWithButton:Paint(w, h)

                    BlurPanel(KilledWithButton, EFGM.MenuScale(3))

                    surface.SetDrawColor(Color(5, 5, 5, 20))
                    surface.DrawRect(0, 0, w, h)

                    surface.SetDrawColor(Color(255, 255, 255, 2))
                    surface.DrawRect(0, 0, w, EFGM.MenuScale(1))
                    surface.DrawRect(0, h - 1, w, EFGM.MenuScale(1))
                    surface.DrawRect(0, 0, EFGM.MenuScale(1), h)
                    surface.DrawRect(w - 1, 0, EFGM.MenuScale(1), h)

                    surface.SetDrawColor(255, 255, 255, 255)
                    surface.SetMaterial(def.icon)

                    local originalWidth, originalHeight = EFGM.MenuScale(57 * def.sizeX), EFGM.MenuScale(57 * def.sizeY)
                    local scaleFactor
                    local targetMaxDimension = EFGM.MenuScale(158)

                    if originalWidth > originalHeight then

                        scaleFactor = targetMaxDimension / originalWidth

                    else

                        scaleFactor = targetMaxDimension / originalHeight

                    end

                    newWidth = math.Round(originalWidth * scaleFactor)
                    newHeight = math.Round(originalHeight * scaleFactor)

                    local x = (EFGM.MenuScale(198) / 2) - (newWidth / 2)
                    local y = (EFGM.MenuScale(216) / 2) - (newHeight / 2)

                    surface.DrawTexturedRect(x, y - EFGM.MenuScale(20), newWidth, newHeight)

                end

                function KilledWithButton:PaintOver(w, h)

                    surface.SetDrawColor(Color(5, 5, 5, 100))
                    surface.DrawRect(EFGM.MenuScale(1), h - EFGM.MenuScale(31), w - EFGM.MenuScale(2), EFGM.MenuScale(30))

                    draw.SimpleTextOutlined(def.displayName, "PuristaBold22", w / 2, h - EFGM.MenuScale(29), Colors.whiteColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 1, Colors.blackColor)

                end

                function KilledWithButton:DoClick()

                    local data = {}
                    data.att = def.defAtts
                    HUDInspectItem(killedByWeapon, data, DeathPopup)
                    surface.PlaySound("ui/element_select.wav")

                end

            end

        end

        if InsideRaidLength != nil then

            MapPanel = vgui.Create("DPanel", DeathPopup)
            MapPanel:SetSize(EFGM.MenuScale(800), EFGM.MenuScale(800))
            MapPanel:SetPos(DeathPopup:GetWide() / 2 + EFGM.MenuScale(10), EFGM.MenuScale(140))

            MapPanel.Paint = nil

            local mapRawName = game.GetMap()
            local mapOverhead = Material("maps/" .. mapRawName .. ".png", "smooth")

            local mapSizeX = EFGM.MenuScale(800)
            local mapSizeY = EFGM.MenuScale(800)

            if mapOverhead then

                mapSizeX = EFGM.MenuScale(mapOverhead:Width())
                mapSizeY = EFGM.MenuScale(mapOverhead:Height())

            end

            MapHolder = vgui.Create("DPanel", MapPanel)
            MapHolder:SetSize(EFGM.MenuScale(800), EFGM.MenuScale(800))
            MapHolder:Dock(FILL)

            MapHolder.Paint = function(self, w, h)

                surface.SetDrawColor(Color(0, 0, 0, 0))
                surface.DrawRect(0, 0, w, h)

            end

            function MapHolder:PaintOver(w, h)

                surface.SetDrawColor(Color(255, 255, 255, 25))
                surface.DrawRect(0, 0, w, EFGM.MenuScale(1))
                surface.DrawRect(0, h - 1, w, EFGM.MenuScale(1))
                surface.DrawRect(0, 0, EFGM.MenuScale(1), h)
                surface.DrawRect(w - 1, 0, EFGM.MenuScale(1), h)

            end

            local xDiff = EFGM.MenuScale(800) / mapSizeX
            local yDiff = EFGM.MenuScale(800) / mapSizeY

            local minZoom = math.max(xDiff, yDiff)

            if yDiff > xDiff and mapSizeX > mapSizeY then minZoom = math.min(xDiff, yDiff) end

            local map = vgui.Create("EFGMMap", MapHolder)
            map:SetSize(mapSizeX, mapSizeY)
            map:SetMouseInputEnabled(true)
            map:SetCursor("crosshair")
            map.Zoom = minZoom
            map.MinZoom = minZoom
            map.MaxZoom = 2.5
            map.MapHolderX, map.MapHolderY = MapHolder:GetSize()

            map.DrawRaidInfo = true
            map.DrawFullInfo = false

            map.MapSizeX = mapSizeX
            map.MapSizeY = mapSizeY

            map.MapInfo = MAPINFO[mapRawName]
            map.OverheadImage = mapOverhead

            map:ClampPanOffset()

        end

    end)

end)

net.Receive("CreateExtractionInformation", function()

    hook.Run("efgm_raid_exit", true)

    local xpMult = net.ReadFloat()

    local timeInRaid = net.ReadInt(16)

    local statsTbl = {
        ["DAMAGE DEALT:"] = math.Round(ply:GetNWInt("RaidDamageDealt", 0)),
        ["DAMAGE RECEIVED FROM OPERATORS:"] = math.Round(ply:GetNWInt("RaidDamageRecievedPlayers", 0)),
        ["DAMAGE RECEIVED FROM FALLING:"] = math.Round(ply:GetNWInt("RaidDamageRecievedFalling", 0)),
        ["DAMAGE RECEIVED:"] = math.Round(ply:GetNWInt("RaidDamageRecievedPlayers", 0) + ply:GetNWInt("RaidDamageRecievedFalling", 0)),
        ["HEALTH HEALED:"] = math.Round(ply:GetNWInt("RaidHealthHealed", 0)),
        ["ITEMS LOOTED:"] = ply:GetNWInt("RaidItemsLooted", 0),
        ["CONTAINERS OPENED:"] = ply:GetNWInt("RaidContainersLooted", 0),
        ["OPERATORS KILLED:"] = ply:GetNWInt("RaidKills", 0),
        ["SHOTS FIRED:"] = ply:GetNWInt("RaidShotsFired", 0),
        ["SHOTS HIT:"] = ply:GetNWInt("RaidShotsHit", 0),
    }
    table.SortByKey(statsTbl)

    local xpTime = net.ReadInt(16)
    local xpCombat = net.ReadInt(16)
    local xpExploration = net.ReadInt(16)
    local xpLooting = net.ReadInt(16)
    local xpBonus = net.ReadInt(16)

    local minutes = math.floor(timeInRaid / 60)
    local seconds = timeInRaid % 60

    local totalXPRaw = xpTime + xpCombat + xpExploration + xpLooting + xpBonus
    local totalXPReal = math.Round(totalXPRaw * xpMult, 0)

    if IsValid(ExtractionPopup) then return end

    local RewardsPanel = nil
    local MapPanel = nil
    local respawnButton = nil

    ExtractionPopup = vgui.Create("DPanel")
    ExtractionPopup:SetSize(ScrW(), ScrH())
    ExtractionPopup:SetPos(0, 0)
    ExtractionPopup:SetAlpha(0)
    ExtractionPopup:MakePopup()
    ExtractionPopup:SetMouseInputEnabled(true)
    ExtractionPopup:SetKeyboardInputEnabled(true)

    ExtractionPopup.Paint = function(self, w, h)

        BlurPanel(ExtractionPopup, EFGM.MenuScale(5))

        surface.SetDrawColor(Color(10, 10, 10, 155))
        surface.DrawRect(0, 0, w, h)

        draw.SimpleTextOutlined("EXTRACTED", "PuristaBold64", w / 2, EFGM.MenuScale(35), Color(0, 255, 0, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 1, Colors.whiteColor)
        draw.SimpleTextOutlined(string.format("%02d:%02d", minutes, seconds) .. " TIME IN RAID", "PuristaBold22", w / 2, EFGM.MenuScale(90), Colors.whiteColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 1, Colors.blackColor)

        ExtractionPopup.MouseX, ExtractionPopup.MouseY = ExtractionPopup:LocalCursorPos()

        if GetConVar("efgm_menu_parallax"):GetInt() == 1 then

            ExtractionPopup.ParallaxX = math.Clamp(((ExtractionPopup.MouseX / math.Round(EFGM.MenuScale(1920), 1)) - 0.5) * EFGM.MenuScale(20), -10, 10)
            ExtractionPopup.ParallaxY = math.Clamp(((ExtractionPopup.MouseY / math.Round(EFGM.MenuScale(1080), 1)) - 0.5) * EFGM.MenuScale(20), -10, 10)

            ExtractionPopup:SetPos(0 + ExtractionPopup.ParallaxX, 0 + ExtractionPopup.ParallaxY)

        else

            ExtractionPopup.ParallaxX = 0
            ExtractionPopup.ParallaxY = 0

            ExtractionPopup:SetPos(0, 0)

        end

        if MapPanel then

            if RewardsPanel then RewardsPanel:SetX(ExtractionPopup:GetWide() / 2 - EFGM.MenuScale(660)) end
            if MapPanel then MapPanel:SetX(ExtractionPopup:GetWide() / 2 - EFGM.MenuScale(140)) end
            if respawnButton then respawnButton:SetWide(EFGM.MenuScale(1320)) end

        else

            if RewardsPanel then RewardsPanel:SetX(ExtractionPopup:GetWide() / 2 - EFGM.MenuScale(250)) end
            if respawnButton then respawnButton:SetWide(EFGM.MenuScale(500)) end

        end

        if respawnButton then respawnButton:SetX(ScrW() / 2 - respawnButton:GetWide() / 2) end

    end

    ExtractionPopup:AlphaTo(255, 0.2, 0, nil)
    surface.PlaySound("storytask_end.wav")

    respawnButton = vgui.Create("DButton", ExtractionPopup)
    respawnButton:SetSize(EFGM.MenuScale(1020), EFGM.MenuScale(50))
    respawnButton:SetPos(ScrW() / 2 - EFGM.MenuScale(510), ExtractionPopup:GetTall() - EFGM.MenuScale(100))
    respawnButton:SetText("")
    respawnButton.Paint = function(s, w, h)

        surface.SetDrawColor(Color(80, 80, 80, 10))
        surface.DrawRect(0, 0, w, h)

        surface.SetDrawColor(Colors.transparentWhiteColor)
        surface.DrawRect(0, 0, respawnButton:GetWide(), EFGM.MenuScale(2))

        draw.SimpleTextOutlined("CLOSE", "PuristaBold32", w / 2, EFGM.MenuScale(7), Colors.whiteColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 1, Colors.blackColor)

    end

    function respawnButton:DoClick()

        surface.PlaySound("ui/element_select.wav")
        ExtractionPopup:AlphaTo(0, 0.1, 0, function() ExtractionPopup:Remove() end)

    end

    RewardsPanel = vgui.Create("DPanel", ExtractionPopup)
    RewardsPanel:SetSize(EFGM.MenuScale(500), EFGM.MenuScale(800))
    RewardsPanel:SetPos(ExtractionPopup:GetWide() / 2 - EFGM.MenuScale(255), EFGM.MenuScale(140))

    RewardsPanel.Paint = function(self, w, h)

        BlurPanel(RewardsPanel, EFGM.MenuScale(3))

        surface.SetDrawColor(Color(80, 80, 80, 10))
        surface.DrawRect(0, 0, w, h)

        surface.SetDrawColor(Color(255, 255, 255, 25))
        surface.DrawRect(0, 0, w, EFGM.MenuScale(1))
        surface.DrawRect(0, h - 1, w, EFGM.MenuScale(1))
        surface.DrawRect(0, 0, EFGM.MenuScale(1), h)
        surface.DrawRect(w - 1, 0, EFGM.MenuScale(1), h)

    end

    StatsPanel = vgui.Create("DPanel", RewardsPanel)
    StatsPanel:SetSize(0, EFGM.MenuScale(500))
    StatsPanel:Dock(TOP)
    StatsPanel:DockMargin(EFGM.MenuScale(5), EFGM.MenuScale(5), EFGM.MenuScale(5), EFGM.MenuScale(5))

    StatsPanel.Paint = function(self, w, h)

        surface.SetDrawColor(Color(80, 80, 80, 10))
        surface.DrawRect(0, 0, w, h)

        surface.SetDrawColor(Colors.transparentWhiteColor)
        surface.DrawRect(0, 0, w, EFGM.MenuScale(6))

        surface.SetDrawColor(Color(255, 255, 255, 10))
        surface.DrawRect(0, 0, w, EFGM.MenuScale(1))
        surface.DrawRect(0, h - 1, w, EFGM.MenuScale(1))
        surface.DrawRect(0, 0, EFGM.MenuScale(1), h)
        surface.DrawRect(w - 1, 0, EFGM.MenuScale(1), h)

    end

    local StatsText = vgui.Create("DPanel", StatsPanel)
    StatsText:Dock(TOP)
    StatsText:SetSize(0, EFGM.MenuScale(36))
    function StatsText:Paint(w, h)

        surface.SetDrawColor(Color(155, 155, 155, 10))
        surface.DrawRect(0, 0, w, h)

        draw.SimpleTextOutlined("STATS", "PuristaBold32", EFGM.MenuScale(5), EFGM.MenuScale(2), Colors.whiteColor, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP, 1, Colors.blackColor)

    end

    local StatsHolder = vgui.Create("DPanel", StatsPanel)
    StatsHolder:Dock(FILL)
    StatsHolder:DockMargin(EFGM.MenuScale(5), EFGM.MenuScale(5), EFGM.MenuScale(5), EFGM.MenuScale(5))
    StatsHolder:SetSize(0, 0)
    StatsHolder.Paint = function(s, w, h)

        surface.SetDrawColor(Color(0, 0, 0, 0))
        surface.DrawRect(0, 0, w, h)

        local num = 0

        for k, v in pairs(statsTbl) do

            if v == 0 then continue end

            draw.SimpleTextOutlined(k, "PuristaBold24", EFGM.MenuScale(3), EFGM.MenuScale(22) * num, Colors.whiteColor, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP, 1, Colors.blackColor)
            draw.SimpleTextOutlined(v, "PuristaBold24", w - EFGM.MenuScale(3), EFGM.MenuScale(22) * num, Colors.whiteColor, TEXT_ALIGN_RIGHT, TEXT_ALIGN_TOP, 1, Colors.blackColor)

            num = num + 1

        end

    end

    LevelingPanel = vgui.Create("DPanel", RewardsPanel)
    LevelingPanel:SetSize(0, EFGM.MenuScale(285))
    LevelingPanel:Dock(TOP)
    LevelingPanel:DockMargin(EFGM.MenuScale(5), 0, EFGM.MenuScale(5), EFGM.MenuScale(5))

    LevelingPanel.Paint = function(self, w, h)

        surface.SetDrawColor(Color(80, 80, 80, 10))
        surface.DrawRect(0, 0, w, h)

        surface.SetDrawColor(Colors.transparentWhiteColor)
        surface.DrawRect(0, 0, w, EFGM.MenuScale(6))

        surface.SetDrawColor(Color(255, 255, 255, 10))
        surface.DrawRect(0, 0, w, EFGM.MenuScale(1))
        surface.DrawRect(0, h - 1, w, EFGM.MenuScale(1))
        surface.DrawRect(0, 0, EFGM.MenuScale(1), h)
        surface.DrawRect(w - 1, 0, EFGM.MenuScale(1), h)

    end

    local LevelingText = vgui.Create("DPanel", LevelingPanel)
    LevelingText:Dock(TOP)
    LevelingText:SetSize(0, EFGM.MenuScale(36))
    function LevelingText:Paint(w, h)

        surface.SetDrawColor(Color(155, 155, 155, 10))
        surface.DrawRect(0, 0, w, h)

        draw.SimpleTextOutlined("LEVELING", "PuristaBold32", EFGM.MenuScale(5), EFGM.MenuScale(2), Colors.whiteColor, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP, 1, Colors.blackColor)

    end

    local LevelingHolder = vgui.Create("DPanel", LevelingPanel)
    LevelingHolder:Dock(FILL)
    LevelingHolder:DockMargin(EFGM.MenuScale(5), EFGM.MenuScale(5), EFGM.MenuScale(5), EFGM.MenuScale(5))
    LevelingHolder:SetSize(0, 0)
    LevelingHolder.Paint = function(s, w, h)

        surface.SetDrawColor(Color(0, 0, 0, 0))
        surface.DrawRect(0, 0, w, h)

        draw.SimpleTextOutlined("TIME: ", "PuristaBold24", EFGM.MenuScale(3), 0, Colors.whiteColor, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP, 1, Colors.blackColor)
        draw.SimpleTextOutlined(xpTime .. "XP", "PuristaBold24", w - EFGM.MenuScale(3), 0, Colors.whiteColor, TEXT_ALIGN_RIGHT, TEXT_ALIGN_TOP, 1, Colors.blackColor)

        draw.SimpleTextOutlined("COMBAT: ", "PuristaBold24", EFGM.MenuScale(3), EFGM.MenuScale(22), Colors.whiteColor, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP, 1, Colors.blackColor)
        draw.SimpleTextOutlined(xpCombat .. "XP", "PuristaBold24", w - EFGM.MenuScale(3), EFGM.MenuScale(22), Colors.whiteColor, TEXT_ALIGN_RIGHT, TEXT_ALIGN_TOP, 1, Colors.blackColor)

        draw.SimpleTextOutlined("EXPLORATION: ", "PuristaBold24", EFGM.MenuScale(3), EFGM.MenuScale(44), Colors.whiteColor, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP, 1, Colors.blackColor)
        draw.SimpleTextOutlined(xpExploration .. "XP", "PuristaBold24", w - EFGM.MenuScale(3), EFGM.MenuScale(44), Colors.whiteColor, TEXT_ALIGN_RIGHT, TEXT_ALIGN_TOP, 1, Colors.blackColor)

        draw.SimpleTextOutlined("LOOTING: ", "PuristaBold24", EFGM.MenuScale(3), EFGM.MenuScale(66), Colors.whiteColor, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP, 1, Colors.blackColor)
        draw.SimpleTextOutlined(xpLooting .. "XP", "PuristaBold24", w - EFGM.MenuScale(3), EFGM.MenuScale(66), Colors.whiteColor, TEXT_ALIGN_RIGHT, TEXT_ALIGN_TOP, 1, Colors.blackColor)

        draw.SimpleTextOutlined("BONUS: ", "PuristaBold24", EFGM.MenuScale(3), EFGM.MenuScale(88), Colors.whiteColor, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP, 1, Colors.blackColor)
        draw.SimpleTextOutlined(xpBonus .. "XP", "PuristaBold24", w - EFGM.MenuScale(3), EFGM.MenuScale(88), Colors.whiteColor, TEXT_ALIGN_RIGHT, TEXT_ALIGN_TOP, 1, Colors.blackColor)

        draw.SimpleTextOutlined("TOTAL: ", "PuristaBold24", EFGM.MenuScale(3), EFGM.MenuScale(120), Colors.whiteColor, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP, 1, Colors.blackColor)
        draw.SimpleTextOutlined(totalXPRaw .. "XP", "PuristaBold24", w - EFGM.MenuScale(3), EFGM.MenuScale(120), Colors.whiteColor, TEXT_ALIGN_RIGHT, TEXT_ALIGN_TOP, 1, Colors.blackColor)

        draw.SimpleTextOutlined("MULTIPLIER: ", "PuristaBold24", EFGM.MenuScale(3), EFGM.MenuScale(142), Colors.whiteColor, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP, 1, Colors.blackColor)
        draw.SimpleTextOutlined(xpMult .. "x", "PuristaBold24", w - EFGM.MenuScale(3), EFGM.MenuScale(142), Colors.whiteColor, TEXT_ALIGN_RIGHT, TEXT_ALIGN_TOP, 1, Colors.blackColor)

        draw.SimpleTextOutlined("FINAL XP: ", "PuristaBold24", EFGM.MenuScale(3), EFGM.MenuScale(174), Colors.whiteColor, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP, 1, Colors.blackColor)
        draw.SimpleTextOutlined("+" .. totalXPReal .. "XP", "PuristaBold24", w - EFGM.MenuScale(3), EFGM.MenuScale(174), Colors.whiteColor, TEXT_ALIGN_RIGHT, TEXT_ALIGN_TOP, 1, Colors.blackColor)

        draw.SimpleTextOutlined(ply:GetNWInt("Level", 1), "PuristaBold24", EFGM.MenuScale(5), h - EFGM.MenuScale(40), Colors.whiteColor, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP, 1, Colors.blackColor)
        draw.SimpleTextOutlined(ply:GetNWInt("Level", 1) + 1, "PuristaBold24", w - EFGM.MenuScale(5), h - EFGM.MenuScale(40), Colors.whiteColor, TEXT_ALIGN_RIGHT, TEXT_ALIGN_TOP, 1, Colors.blackColor)

        draw.SimpleTextOutlined(ply:GetNWInt("Experience", 0) .. "/" .. ply:GetNWInt("ExperienceToNextLevel", 500), "PuristaBold16", EFGM.MenuScale(30), h - EFGM.MenuScale(33), Colors.whiteColor, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP, 1, Colors.blackColor)

        surface.SetDrawColor(30, 30, 30, 125)
        surface.DrawRect(EFGM.MenuScale(5), h - EFGM.MenuScale(15), EFGM.MenuScale(470), EFGM.MenuScale(10))

        surface.SetDrawColor(255, 255, 255, 175)
        surface.DrawRect(EFGM.MenuScale(5), h - EFGM.MenuScale(15), (ply:GetNWInt("Experience", 0) / ply:GetNWInt("ExperienceToNextLevel", 500)) * EFGM.MenuScale(470), EFGM.MenuScale(10))

    end

    if InsideRaidLength != nil then

        MapPanel = vgui.Create("DPanel", ExtractionPopup)
        MapPanel:SetSize(EFGM.MenuScale(800), EFGM.MenuScale(800))
        MapPanel:SetPos(ExtractionPopup:GetWide() / 2 + EFGM.MenuScale(10), EFGM.MenuScale(140))

        MapPanel.Paint = nil

        local mapRawName = game.GetMap()
        local mapOverhead = Mats.curMapOverhad

        local mapSizeX = EFGM.MenuScale(800)
        local mapSizeY = EFGM.MenuScale(800)

        if mapOverhead then

            mapSizeX = EFGM.MenuScale(mapOverhead:Width())
            mapSizeY = EFGM.MenuScale(mapOverhead:Height())

        end

        MapHolder = vgui.Create("DPanel", MapPanel)
        MapHolder:SetSize(EFGM.MenuScale(800), EFGM.MenuScale(800))
        MapHolder:Dock(FILL)

        MapHolder.Paint = function(self, w, h)

            surface.SetDrawColor(Color(0, 0, 0, 0))
            surface.DrawRect(0, 0, w, h)

        end

        function MapHolder:PaintOver(w, h)

            surface.SetDrawColor(Color(255, 255, 255, 25))
            surface.DrawRect(0, 0, w, EFGM.MenuScale(1))
            surface.DrawRect(0, h - 1, w, EFGM.MenuScale(1))
            surface.DrawRect(0, 0, EFGM.MenuScale(1), h)
            surface.DrawRect(w - 1, 0, EFGM.MenuScale(1), h)

        end

        local xDiff = EFGM.MenuScale(800) / mapSizeX
        local yDiff = EFGM.MenuScale(800) / mapSizeY

        local minZoom = math.max(xDiff, yDiff)

        if yDiff > xDiff and mapSizeX > mapSizeY then minZoom = math.min(xDiff, yDiff) end

        local map = vgui.Create("EFGMMap", MapHolder)
        map:SetSize(mapSizeX, mapSizeY)
        map:SetMouseInputEnabled(true)
        map:SetCursor("crosshair")
        map.Zoom = minZoom
        map.MinZoom = minZoom
        map.MaxZoom = 2.5
        map.MapHolderX, map.MapHolderY = MapHolder:GetSize()

        map.DrawRaidInfo = true
        map.DrawFullInfo = false

        map.MapSizeX = mapSizeX
        map.MapSizeY = mapSizeY

        map.MapInfo = MAPINFO[mapRawName]
        map.OverheadImage = mapOverhead

        map:ClampPanOffset()

    end

end)

-- notifications
function CreateNotification(text, icon, snd)
    if IsValid(notif) then notif:Remove() end

    local panel = GetHUDPanel()
    if Menu.MenuFrame != nil and Menu.MenuFrame:IsActive() == true then panel = Menu.MenuFrame end
    if ExtractPopup != nil and ExtractPopup:IsValid() then panel = ExtractPopup end
    if DeathPopup != nil and DeathPopup:IsValid() then panel = DeathPopup end

    surface.SetFont("BenderNotification")
    local tw = surface.GetTextSize(text) + EFGM.ScreenScale(45)

    notif = vgui.Create("DPanel", panel)
    notif:SetPos(ScrW() / 2 - (tw / 2), ScrH())
    notif:SetSize(tw, EFGM.ScreenScale(30))
    notif:SetAlpha(0)

    notif:MoveTo(ScrW() / 2 - (tw / 2), ScrH() - EFGM.ScreenScale(40), 0.25, 0.1, 1, nil)
    notif:AlphaTo(255, 0.3, 0.1, nil)

    notif:AlphaTo(0, 0.2, 4, function() notif:Remove() end)
    notif:MoveTo(ScrW() / 2 - (tw / 2), ScrH(), 0.25, 4, 1, nil)

    notif:MoveToFront()

    if snd then surface.PlaySound(snd) end

    notif.Paint = function(s, w, h)
        BlurPanel(s, EFGM.ScreenScale(3))
        surface.SetDrawColor(0, 0, 0, 200)
        surface.DrawRect(0, 0, w, h)
        surface.SetDrawColor(Colors.transparentWhiteColor)
        surface.DrawRect(0, 0, w, EFGM.ScreenScale(1))
        surface.SetDrawColor(255, 255, 255, 255)
        surface.SetMaterial(icon)
        surface.DrawTexturedRect(EFGM.ScreenScale(2), 0, h, h)
        surface.SetFont("BenderNotification")
        surface.SetTextPos(w - tw + EFGM.ScreenScale(36), EFGM.ScreenScale(0.5))
        surface.SetTextColor(255, 255, 255, 255)
        surface.DrawText(text)
    end
end

net.Receive("SendNotification", function()

    local text = net.ReadString()
    local mat = net.ReadString()
    local snd = net.ReadString()

    local material = Material(mat, "smooth")

    CreateNotification(text, material, snd)

end)

function HUDInspectItem(item, data, panel)

    if IsValid(inspectPanel) then inspectPanel:Remove() end

    local i = EFGMITEMS[item]
    if i == nil then inspectPanel:Remove() return end

    surface.SetFont("PuristaBold24")
    local itemNameText = string.upper(i.fullName)
    local itemNameSize = surface.GetTextSize(itemNameText)

    local value = i.value
    local weight = i.weight

    if data and data.att then

        local atts = GetPrefixedAttachmentListFromCode(data.att)
        if !atts then return end

        for _, a in ipairs(atts) do

            local att = EFGMITEMS[a]
            if att == nil then continue end

            value = value + att.value
            weight = weight + att.weight

        end

    end

    local ownerName = nil
    if data.owner then steamworks.RequestPlayerInfo(data.owner, function(steamName) ownerName = steamName end) end

    surface.SetFont("PuristaBold18")
    local itemDescText = string.upper(i.displayType) .. " / " .. string.upper(weight) .. "KG" .. " / ₽" .. string.upper(comma_value(value))
    if i.canPurchase == true or i.canPurchase == nil then itemDescText = itemDescText .. " / LEVEL " .. string.upper(i.levelReq) end
    local itemDescSize = surface.GetTextSize(itemDescText)

    local iconSizeX, iconSizeY = EFGM.MenuScale(114 * i.sizeX), EFGM.MenuScale(114 * i.sizeY)

    local panelWidth
    if iconSizeX >= itemNameSize then panelWidth = iconSizeX else panelWidth = itemNameSize end
    if itemDescSize + EFGM.MenuScale(8) >= panelWidth then panelWidth = itemDescSize + EFGM.MenuScale(8) end

    local originalWidth, originalHeight = EFGM.MenuScale(114 * i.sizeX), EFGM.MenuScale(114 * i.sizeY)
    local scaleFactor
    local targetMaxDimension = math.min(panelWidth, i.sizeX * 200)

    if originalWidth > originalHeight then

        scaleFactor = targetMaxDimension / originalWidth

    else

        scaleFactor = targetMaxDimension / originalHeight

    end

    local newPanelWidth = math.Round(originalWidth * scaleFactor)
    local newPanelHeight = math.Round(originalHeight * scaleFactor)

    inspectPanel = vgui.Create("DFrame", panel)
    inspectPanel:SetSize(panelWidth + EFGM.MenuScale(40), newPanelHeight + EFGM.MenuScale(100))
    inspectPanel:Center()
    inspectPanel:SetAlpha(0)
    inspectPanel:SetTitle("")
    inspectPanel:ShowCloseButton(false)
    inspectPanel:SetScreenLock(true)
    inspectPanel:AlphaTo(255, 0.1, 0, nil)

    inspectPanel.Paint = function(s, w, h)

        BlurPanel(s, EFGM.MenuScale(3))

        surface.SetDrawColor(Color(20, 20, 20, 205))
        surface.DrawRect(0, 0, w, h)

        surface.SetDrawColor(Colors.transparentWhiteColor)
        surface.DrawRect(0, 0, w, EFGM.MenuScale(6))

        surface.SetDrawColor(Color(255, 255, 255, 25))
        surface.DrawRect(0, 0, w, EFGM.MenuScale(1))
        surface.DrawRect(0, h - 1, w, EFGM.MenuScale(1))
        surface.DrawRect(0, 0, EFGM.MenuScale(1), h)
        surface.DrawRect(w - 1, 0, EFGM.MenuScale(1), h)

        draw.SimpleTextOutlined(itemNameText, "PuristaBold24", EFGM.MenuScale(5), EFGM.MenuScale(5), Colors.whiteColor, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP, 1, Colors.blackColor)
        draw.SimpleTextOutlined(itemDescText, "PuristaBold18", EFGM.MenuScale(5), EFGM.MenuScale(25), Colors.whiteColor, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP, 1, Colors.blackColor)

        if data.tag then

            draw.SimpleTextOutlined(data.tag, "PuristaBold14", EFGM.MenuScale(5), EFGM.MenuScale(40), Colors.whiteColor, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP, 1, Colors.blackColor)

        end

        surface.SetDrawColor(255, 255, 255, 255)
        surface.SetMaterial(i.icon)

        -- panel width = 198, panel height = 216
        local x = inspectPanel:GetWide() / 2 - (newPanelWidth / 2)
        local y = inspectPanel:GetTall() / 2 - (newPanelHeight / 2)

        surface.DrawTexturedRect(x, y, newPanelWidth, newPanelHeight)

    end

    if data.fir then

        local firIcon = vgui.Create("DButton", inspectPanel)
        firIcon:SetPos(itemDescSize + EFGM.MenuScale(7), EFGM.MenuScale(29))
        firIcon:SetSize(EFGM.MenuScale(12), EFGM.MenuScale(12))
        firIcon:SetText("")

        firIcon.Paint = function(s, w, h)

            surface.SetDrawColor(Colors.pureWhiteColor)
            surface.SetMaterial(Mats.firIcon)
            surface.DrawTexturedRect(0, 0, EFGM.MenuScale(12), EFGM.MenuScale(12))

        end

        firIcon.OnCursorEntered = function(s)

            local x, y = Menu.MouseX, Menu.MouseY
            local sideH, sideV

            surface.PlaySound("ui/element_hover_" .. math.random(1, 3) .. ".wav")

            if x <= (ScrW() / 2) then sideH = true else sideH = false end
            if y <= (ScrH() / 2) then sideV = true else sideV = false end

            local function UpdatePopOutPos()

                if sideH == true then

                    firPopOut:SetX(math.Clamp(x + EFGM.MenuScale(15), EFGM.MenuScale(10), ScrW() - firPopOut:GetWide() - EFGM.MenuScale(10)))

                else

                    firPopOut:SetX(math.Clamp(x - firPopOut:GetWide() - EFGM.MenuScale(15), EFGM.MenuScale(10), ScrW() - firPopOut:GetWide() - EFGM.MenuScale(10)))

                end

                if sideV == true then

                    firPopOut:SetY(math.Clamp(y + EFGM.MenuScale(15), EFGM.MenuScale(60), ScrH() - firPopOut:GetTall() - EFGM.MenuScale(20)))

                else

                    firPopOut:SetY(math.Clamp(y - firPopOut:GetTall() + EFGM.MenuScale(15), EFGM.MenuScale(60), ScrH() - firPopOut:GetTall() - EFGM.MenuScale(20)))

                end

            end

            if IsValid(firPopOut) then firPopOut:Remove() end
            firPopOut = vgui.Create("DPanel", Menu.MenuFrame)
            firPopOut:SetSize(EFGM.MenuScale(455), EFGM.MenuScale(50))
            UpdatePopOutPos()
            firPopOut:AlphaTo(255, 0.1, 0, nil)
            firPopOut:SetMouseInputEnabled(false)

            firPopOut.Paint = function(s, w, h)

                if !IsValid(s) then return end

                BlurPanel(s, EFGM.MenuScale(3))

                -- panel position follows mouse position
                x, y = Menu.MouseX, Menu.MouseY

                UpdatePopOutPos()

                surface.SetDrawColor(Color(0, 0, 0, 205))
                surface.DrawRect(0, 0, w, h)

                surface.SetDrawColor(Color(55, 55, 55, 45))
                surface.DrawRect(0, 0, w, h)

                surface.SetDrawColor(Color(55, 55, 55))
                surface.DrawRect(0, 0, w, EFGM.MenuScale(5))

                surface.SetDrawColor(Colors.transparentWhiteColor)
                surface.DrawRect(0, 0, w, EFGM.MenuScale(1))
                surface.DrawRect(0, h - 1, w, EFGM.MenuScale(1))
                surface.DrawRect(0, 0, EFGM.MenuScale(1), h)
                surface.DrawRect(w - 1, 0, EFGM.MenuScale(1), h)

                draw.SimpleTextOutlined("FOUND IN RAID", "PuristaBold24", EFGM.MenuScale(5), EFGM.MenuScale(5), Colors.whiteColor, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP, 1, Colors.blackColor)
                draw.SimpleTextOutlined("This item will lose its 'found in raid' status if brought into another raid.", "Purista18", EFGM.MenuScale(5), EFGM.MenuScale(25), Colors.whiteColor, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP, 1, Colors.blackColor)

            end

        end

        firIcon.OnCursorExited = function(s)

            if IsValid(firPopOut) then

                firPopOut:AlphaTo(0, 0.1, 0, function() firPopOut:Remove() end)

            end

        end

    end

    local itemPullOutPanel = vgui.Create("DPanel", inspectPanel)
    itemPullOutPanel:SetSize(inspectPanel:GetWide(), inspectPanel:GetTall() - EFGM.MenuScale(75))
    itemPullOutPanel:SetPos(0, inspectPanel:GetTall() - EFGM.MenuScale(1))
    itemPullOutPanel:Hide()
    itemPullOutPanel.Paint = function(s, w, h)

        BlurPanel(s, EFGM.MenuScale(1))

        surface.SetDrawColor(Color(20, 20, 20, 205))
        surface.DrawRect(0, 0, w, h)

        surface.SetDrawColor(Color(255, 255, 255, 25))
        surface.DrawRect(0, 0, w, EFGM.MenuScale(1))
        surface.DrawRect(0, h - 1, w, EFGM.MenuScale(1))
        surface.DrawRect(0, 0, EFGM.MenuScale(1), h)
        surface.DrawRect(w - 1, 0, EFGM.MenuScale(1), h)

    end

    surface.SetFont("PuristaBold24")
    local infoText = "INFO"
    local infoTextSize = surface.GetTextSize(infoText)

    local itemInfoButton = vgui.Create("DButton", inspectPanel)
    itemInfoButton:SetPos(EFGM.MenuScale(1), itemPullOutPanel:GetY() - EFGM.MenuScale(28))
    itemInfoButton:SetSize(infoTextSize + EFGM.MenuScale(10), EFGM.MenuScale(28))
    itemInfoButton:SetText("")
    itemInfoButton.Paint = function(s, w, h)

        BlurPanel(s, 0.5)

        s:SetY(itemPullOutPanel:GetY() - EFGM.MenuScale(28))

        surface.SetDrawColor(Color(80, 80, 80, 10))
        surface.DrawRect(0, 0, infoTextSize + EFGM.MenuScale(10), h)

        surface.SetDrawColor(Colors.transparentWhiteColor)
        if !s:IsHovered() then surface.DrawRect(0, 0, infoTextSize + EFGM.MenuScale(10), EFGM.MenuScale(2)) else surface.DrawRect(0, 0, infoTextSize + EFGM.MenuScale(10), EFGM.MenuScale(3)) end

        draw.SimpleTextOutlined(infoText, "PuristaBold24", EFGM.MenuScale(5), EFGM.MenuScale(2), Colors.whiteColor, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP, 1, Colors.blackColor)

    end

    surface.SetFont("PuristaBold24")
    local wikiText = "WIKI"
    local wikiTextSize = surface.GetTextSize(wikiText)

    local itemWikiButton = vgui.Create("DButton", inspectPanel)
    itemWikiButton:SetPos(itemInfoButton:GetWide() + EFGM.MenuScale(1), itemPullOutPanel:GetY() - EFGM.MenuScale(28))
    itemWikiButton:SetSize(wikiTextSize + EFGM.MenuScale(10), EFGM.MenuScale(28))
    itemWikiButton:SetText("")
    itemWikiButton.Paint = function(s, w, h)

        BlurPanel(s, 0.5)

        s:SetY(itemPullOutPanel:GetY() - EFGM.MenuScale(28))

        surface.SetDrawColor(Color(80, 80, 80, 10))
        surface.DrawRect(0, 0, wikiTextSize + EFGM.MenuScale(10), h)

        surface.SetDrawColor(Colors.transparentWhiteColor)
        if !s:IsHovered() then surface.DrawRect(0, 0, infoTextSize + EFGM.MenuScale(10), EFGM.MenuScale(2)) else surface.DrawRect(0, 0, infoTextSize + EFGM.MenuScale(10), EFGM.MenuScale(3)) end

        draw.SimpleTextOutlined(wikiText, "PuristaBold24", EFGM.MenuScale(5), EFGM.MenuScale(2), Colors.whiteColor, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP, 1, Colors.blackColor)

    end

    if !data or table.IsEmpty(data) then

        itemInfoButton:Remove()
        itemWikiButton:SetX(EFGM.MenuScale(1))

    end

    local pullOutContent = vgui.Create("DPanel", itemPullOutPanel)
    pullOutContent:Dock(FILL)
    pullOutContent:DockPadding(EFGM.MenuScale(10), EFGM.MenuScale(10), EFGM.MenuScale(10), EFGM.MenuScale(10))
    pullOutContent:SetAlpha(0)
    pullOutContent.Paint = nil

    itemPullOutPanel.content = pullOutContent

    local tab

    local function OpenPullOutInfoTab()

        tab = "Info"

        local infoContent = vgui.Create("DPanel", itemPullOutPanel)
        infoContent:Dock(FILL)
        infoContent:DockPadding(EFGM.MenuScale(5), EFGM.MenuScale(5), EFGM.MenuScale(5), EFGM.MenuScale(5))
        infoContent:SetAlpha(0)
        infoContent.Paint = nil

        local infoContentText = vgui.Create("RichText", infoContent)
        infoContentText:Dock(FILL)
        infoContentText:SetVerticalScrollbarEnabled(true)
        infoContentText:InsertColorChange(255, 255, 255, 255)

        if ownerName then

            infoContentText:AppendText("OWNER: " .. ownerName .. "\n")

        end

        if data.count != 0 and data.count != 1 and data.count != nil then

            infoContentText:AppendText("COUNT: " .. data.count .. "\n")

        end

        if data.durability then

            infoContentText:AppendText("DURABILITY: " .. data.durability .. "\n")

        end

        if data.tag and !data.tagLevel then

            infoContentText:AppendText("NAME TAG: " .. data.tag .. "\n")

        end

        if data.att then

            infoContentText:AppendText("ATTACHMENTS: \n" .. GetAttachmentListFromCode(data.att) .. "\n")

        end

        -- dog tag specific

        if data.tagLevel then

            infoContentText:AppendText("LEVEL: " .. data.tagLevel .. "\n")

        end

        if data.tagKiller then

            infoContentText:AppendText("KILLED BY: " .. data.tagKiller .. "\n")

        end

        if data.tagCauseOfDeath then

            local def = EFGMITEMS[data.tagCauseOfDeath]
            local cause = "Unknown"
            if data.tagCauseOfDeath == "Suicide" then cause = "Suicide" elseif def then cause = def.fullName .. " (" .. def.displayName .. ")" end
            infoContentText:AppendText("CAUSE OF DEATH: " .. cause .. "\n")

        end

        if data.tagWoundOrigin and data.tagWoundOrigin != 0 and HITGROUPS[data.tagWoundOrigin] != nil then

            infoContentText:AppendText("WOUND: " .. HITGROUPS[data.tagWoundOrigin] .. "\n")

        end

        function infoContentText:PerformLayout()

            infoContentText:SetFontInternal("PuristaBold18")

        end

        itemPullOutPanel.content = infoContent

    end

    local function OpenPullOutWikiTab()

        tab = "Wiki"

        local wikiContent = vgui.Create("DPanel", itemPullOutPanel)
        wikiContent:Dock(FILL)
        wikiContent:DockPadding(EFGM.MenuScale(5), EFGM.MenuScale(5), EFGM.MenuScale(5), EFGM.MenuScale(5))
        wikiContent:SetAlpha(0)
        wikiContent.Paint = nil

        local wikiContentText = vgui.Create("RichText", wikiContent)
        wikiContentText:Dock(FILL)
        wikiContentText:SetVerticalScrollbarEnabled(true)
        wikiContentText:InsertColorChange(255, 255, 255, 255)

        local wep = table.Copy(weapons.Get(item))

        if i.fullName and i.displayName then

            wikiContentText:AppendText("NAME: " .. i.fullName .. " (" .. i.displayName .. ")" .. "\n")

        end

        if i.description then

            wikiContentText:AppendText("DESCRIPTION: " .. i.description .. "\n")

        elseif wep != nil and wep["Description"] then

            wikiContentText:AppendText("DESCRIPTION: " .. wep["Description"] .. "\n")

        end

        if i.displayType then

            wikiContentText:AppendText("TYPE: " .. i.displayType .. "\n")

        end

        if i.weight then

            wikiContentText:AppendText("BASE WEIGHT: " .. i.weight .. "kg" .. "\n")

        end

        if i.value then

            wikiContentText:AppendText("BASE VALUE: ₽" .. comma_value(i.value) .. "\n")

        end

        if i.lootWeight then

            wikiContentText:AppendText("LOOT WEIGHT: " .. i.lootWeight .. "%" .. "\n")

        else

            wikiContentText:AppendText("LOOT WEIGHT: 100%" .. "\n")

        end

        if i.canPurchase == true or i.canPurchase == nil then

            if i.levelReq then

                wikiContentText:AppendText("CAN PURCHASE FROM MARKET: TRUE" .. "\n")
                wikiContentText:AppendText("UNLOCKS AT: LEVEL " .. i.levelReq .. "\n")

            end

        else

            wikiContentText:AppendText("CAN PURCHASE FROM MARKET: " .. string.upper(tostring(i.canPurchase)) .. "\n")

        end

        if i.sizeX and i.sizeY then

            wikiContentText:AppendText("SIZE: " .. i.sizeX .. "x" .. i.sizeY .. "\n")

        end

        if i.stackSize then

            wikiContentText:AppendText("STACK SIZE: " .. i.stackSize  .. "\n")

        end

        if i.equipType == EQUIPTYPE.Weapon and wep != nil then

            wikiContentText:AppendText("\n")

            local firemodes = wep["Firemodes"] or nil
            local damageMax = math.Round(wep["DamageMax"] or 0) or nil
            local damageMin = math.Round(wep["DamageMin"] or 0) or nil
            local rpm = math.Round(wep["RPM"] or 0) or nil
            local range = math.Round((wep["RangeMax"] or 0) * 0.0254) or nil
            local velocity = math.Round(((wep["PhysBulletMuzzleVelocity"] or 0) * 0.0254) * 1.2) or nil

            local recoilMult = math.Round(wep["Recoil"] or 1, 2) or 1
            local visualRecoilMult = math.Round(wep["VisualRecoil"] or 1, 2) or 1
            local recoilUp = math.Round((wep["RecoilUp"] or 0) * recoilMult, 2) or nil
            local recoilUpRand = math.Round((wep["RecoilRandomUp"] or 0) * recoilMult, 2) or nil
            local recoilSide = math.Round((wep["RecoilSide"] or 0) * recoilMult, 2) or nil
            local recoilSideRand = math.Round((wep["RecoilRandomSide"] or 0) * recoilMult, 2) or nil
            local visualRecoilUp = math.Round((wep["VisualRecoilUp"] or 0) * visualRecoilMult, 2) or nil
            local visualRecoilSide = math.Round((wep["VisualRecoilSide"] or 0) * visualRecoilMult, 2) or nil
            local visualRecoilDamping = math.Round(wep["VisualRecoilDampingConst"] or 0, 2) or nil
            local recoilRecovery = math.Round(wep["RecoilAutoControl"], 2) or nil
            local accuracy = math.Round((wep["Spread"] or 0) * 360 * 60 / 10, 2)
            local ergo = wep["EFTErgo"] or nil

            local manufacturer = ARC9:GetPhrase(wep["Trivia"]["eft_trivia_manuf1"]) or nil
            local country = ARC9:GetPhrase(wep["Trivia"]["eft_trivia_country4"]) or nil
            local year = wep["Trivia"]["eft_trivia_year5"] or nil

            if firemodes then

                local str = ""

                for k, v in pairs(firemodes) do
                    if v.PrintName then str = str .. v.PrintName .. ", "

                    else

                        if v.Mode then

                            if v.Mode == 0 then str = str .. "Safe" .. ", "
                            elseif v.Mode < 0 then str = str .. "Auto" .. ", "
                            elseif v.Mode == 1 then str = str .. "Single" .. ", "
                            elseif v.Mode > 1 then str = str .. tostring(v.Mode) .. "-" .. "Burst" .. ", " end

                        end

                    end

                end

                str = string.sub(str, 1, string.len(str) - 2)

                wikiContentText:AppendText("FIRING MODES: " ..  str .. "\n")

            end

            if damageMax and damageMin then

                wikiContentText:AppendText("DAMAGE: " ..  damageMax .. " → " .. damageMin .. "\n")

            end

            if rpm then

                wikiContentText:AppendText("RPM: " ..  rpm .. "\n")

            end

            if range then

                wikiContentText:AppendText("RANGE: " ..  range .. "m" .. "\n")

            end

            if velocity then

                wikiContentText:AppendText("MUZZLE VELOCITY: " ..  velocity .. "m/s" .. "\n")

            end

            if recoilUp and recoilUpRand then

                wikiContentText:AppendText("VERTICAL RECOIL: " .. recoilUp .. " + " .. recoilUpRand .. "°" .. "\n")

            end

            if recoilSide and recoilSideRand then

                wikiContentText:AppendText("HORIZONTAL RECOIL: " .. recoilSide .. " + " .. recoilSideRand .. "°" .. "\n")

            end

            if visualRecoilUp then

                wikiContentText:AppendText("VISUAL VERTICAL RECOIL: " .. visualRecoilUp .. "\n")

            end

            if visualRecoilSide then

                wikiContentText:AppendText("VISUAL HORIZONTAL RECOIL: " .. visualRecoilSide .. "\n")

            end

            if visualRecoilDamping then

                wikiContentText:AppendText("VISUAL RECOIL DAMPING: " .. visualRecoilDamping .. "\n")

            end

            if recoilRecovery then

                wikiContentText:AppendText("RECOIL RECOVERY: " .. recoilRecovery .. "\n")

            end

            if accuracy and accuracy != 0 then

                wikiContentText:AppendText("ACCURACY: " .. accuracy .. " MOA" .. "\n")

            end

            if ergo and ergo != 0 then

                wikiContentText:AppendText("ERGONOMICS: " .. ergo .. "\n")

            end

            wikiContentText:AppendText("\n")

            if manufacturer then

                wikiContentText:AppendText("MANUFACTURER: " ..  manufacturer .. "\n")

            end

            if country then

                wikiContentText:AppendText("COUNTRY: " ..  country .. "\n")

            end

            if year then

                wikiContentText:AppendText("YEAR: " ..  year)

            end

        end

        if i.equipType == EQUIPTYPE.Consumable and wep != nil then

            wikiContentText:AppendText("\n")

            local delay = wep["ConsumableDelay"] or nil
            local time = wep["ConsumableTime"] or nil
            local value = wep["ConsumableValue"] or nil
            local ticks = wep["ConsumableTicks"] or nil
            local range = wep["ConsumableRange"] or nil
            local dmgCancel = wep["DamageCancel"] or false

            if delay then

                wikiContentText:AppendText("DELAY: " ..  delay .. "\n")

            end

            if time then

                wikiContentText:AppendText("USE TIME: " ..  time .. "\n")

            end

            if value then

                wikiContentText:AppendText("USAGE PER USE: " ..  value .. "\n")

            end

            if ticks then

                wikiContentText:AppendText("TICKS PER USE: " ..  ticks .. "\n")

            end

            if range then

                wikiContentText:AppendText("APPLICATION RANGE ON OTHER PLAYERS: " ..  range .. "\n")

            end

            if dmgCancel != nil then

                wikiContentText:AppendText("CANCELLED ON DAMAGE TAKEN: " ..  string.upper(tostring(dmgCancel)) .. "\n")

            end

        end

        function wikiContentText:PerformLayout()

            wikiContentText:SetFontInternal("PuristaBold18")

        end

        itemPullOutPanel.content = wikiContent

    end

    itemInfoButton.OnCursorEntered = function(s)

        surface.PlaySound("ui/element_hover.wav")

    end

    itemInfoButton.DoClick = function(s)

        if tab == "Info" then return end

        surface.PlaySound("ui/element_select.wav")

        itemPullOutPanel:Show()
        itemPullOutPanel:MoveTo(0, EFGM.MenuScale(75), 0.1, 0, 0.3)

        itemPullOutPanel.content:AlphaTo(0, 0.05, 0, function()

            itemPullOutPanel.content:Remove()
            OpenPullOutInfoTab()
            itemPullOutPanel.content:AlphaTo(255, 0.05, 0, nil)

        end)

    end

    itemWikiButton.OnCursorEntered = function(s)

        surface.PlaySound("ui/element_hover.wav")

    end

    itemWikiButton.DoClick = function(s)

        if tab == "Wiki" then return end

        surface.PlaySound("ui/element_select.wav")

        itemPullOutPanel:Show()
        itemPullOutPanel:MoveTo(0, EFGM.MenuScale(75), 0.1, 0, 0.3)

        itemPullOutPanel.content:AlphaTo(0, 0.05, 0, function()

            itemPullOutPanel.content:Remove()
            OpenPullOutWikiTab()
            itemPullOutPanel.content:AlphaTo(255, 0.05, 0, nil)

        end)

    end

    inspectPanel.OnMousePressed = function(s)

        itemPullOutPanel:MoveTo(0, inspectPanel:GetTall() - 1, 0.1, 0, 0.3, function() itemPullOutPanel:Hide() end)

        tab = nil

        itemPullOutPanel.content:AlphaTo(0, 0.05, 0, nil)

        local screenX, screenY = s:LocalToScreen( 0, 0 )

        if ( s.m_bSizable && gui.MouseX() > ( screenX + s:GetWide() - 20 ) && gui.MouseY() > ( screenY + s:GetTall() - 20 ) ) then
            s.Sizing = { gui.MouseX() - s:GetWide(), gui.MouseY() - s:GetTall() }
            s:MouseCapture( true )
            return
        end

        if ( s:GetDraggable() && gui.MouseY() < ( screenY + 24 ) ) then
            s.Dragging = { gui.MouseX() - s.x, gui.MouseY() - s.y }
            s:MouseCapture( true )
            return
        end

    end

    local closeButton = vgui.Create("DButton", inspectPanel)
    closeButton:SetSize(EFGM.MenuScale(32), EFGM.MenuScale(32))
    closeButton:SetPos(inspectPanel:GetWide() - EFGM.MenuScale(32), EFGM.MenuScale(5))
    closeButton:SetText("")
    closeButton.Paint = function(s, w, h)

        surface.SetDrawColor(255, 255, 255, 255)
        surface.SetMaterial(Mats.closeButtonIcon)
        surface.DrawTexturedRect(0, 0, EFGM.MenuScale(32), EFGM.MenuScale(32))

    end

    closeButton.OnCursorEntered = function(s)

        surface.PlaySound("ui/element_hover.wav")

    end

    function closeButton:DoClick()

        inspectPanel:AlphaTo(0, 0.1, 0, function() inspectPanel:Remove() end)

    end

end

-- ads vignette
local adsProg
local sharpenIntensity = 5
local sharpenDistance = 1
hook.Add("RenderScreenspaceEffects", "Vignette", function()
    ply = ply or LocalPlayer()
    if !ply:Alive() then return end

    local weapon = ply:GetActiveWeapon()

    if type(weapon.GetSightAmount) == "function" then
        adsProg = weapon:GetSightAmount()
    else adsProg = 0 end

    local texture = surface.GetTextureID("overlays/vignette")
    local mult = 1 + (adsProg * (-0.66 * 1))

    surface.SetTexture(texture)
    surface.SetDrawColor(255, 255, 255, 255)

    surface.DrawTexturedRect(0 - (ScrW() * mult), 0 - (ScrH() * mult), ScrW() * (1 + 2 * mult), ScrH() * (1 + 2 * mult))

    local hp = ply:Health()
    local maxHP = ply:GetMaxHealth()

    if hp <= 0 or maxHP <= 0 then return end

    -- sharpening begins at 25hp
    local intensity = 1 - math.Clamp(hp / maxHP * 4, 0.66, 1)

    if intensity > 0 then

        local contrast = intensity * sharpenIntensity
        local distance = intensity * sharpenDistance

        DrawSharpen(contrast, distance)

    end

end)

local function default_trace()
	local eye_pos = EyePos()
	return util.TraceLine({
		start = eye_pos,
		endpos = eye_pos + EyeAngles():Forward() * 6000,
		filter = ply,
	})
end

function DrawTarget()
    if !ply:CompareStatus(0) then return false end

    local ent = (ply:Alive() and ply:GetEyeTrace() or default_trace()).Entity
	if !IsValid(ent) then return end

    RenderPlayerInfo(ent)
    return true
end
hook.Add("HUDDrawTargetID", "HidePlayerInfo", DrawTarget)

function DrawWeaponInfo()
    return false
end
hook.Add("HUDWeaponPickedUp", "WeaponPickedUp", DrawWeaponInfo)

function DrawAmmoInfo()
    return false
end
hook.Add("HUDAmmoPickedUp", "AmmoPickedUp", DrawAmmoInfo)

function DrawItemInfo()
    return false
end
hook.Add("HUDItemPickedUp", "ItemPickedUp", DrawItemInfo)

function HideHud(name)
    for k, v in pairs({"CHudHealth", "CHudBattery", "CHudAmmo", "CHudSecondaryAmmo", "CHudZoom", "CHudVoiceStatus", "CHudDamageIndicator", "CHUDQuickInfo", "CHudCrosshair", "CHudWeaponSelection"}) do
        if name == v then
            return false
        end
    end
end
hook.Add("HUDShouldDraw", "HideDefaultHud", HideHud)

-- disable scoreboard
hook.Add("ScoreboardShow", "DisableHL2Scoreboard", function() return true end )

-- hide voice chat panels
hook.Add("PlayerStartVoice", "ImageOnVoice", function(voipPly)
    if ply != voipPly then return true end
    hook.Add("HUDPaint", "VoiceIndicator", RenderVOIPIndicator)
    return true
end)

hook.Add("PlayerEndVoice", "ImageOnVoice", function()
    hook.Remove("HUDPaint", "VoiceIndicator")
end)

net.Receive("VoteableMaps", function(len)

    local maps = net.ReadTable(true)

    local map1 = maps[1]
    local map2 = maps[2]

    local map1Name = MAPNAMES[map1.name]
    local map2Name = MAPNAMES[map2.name]
    local map1Icon = Material("maps/icon_" .. map1.name .. "_" .. math.random(1, 5) .. ".png")
    local map2Icon = Material("maps/icon_" .. map2.name .. "_" .. math.random(1, 5) .. ".png")
    local map1Votes = 0
    local map2Votes = 0

    timer.Simple(40, function()

        if IsValid(mapVote) then mapVote:Remove() end

        mapVote = vgui.Create("DPanel")
        mapVote:SetSize(ScrW(), ScrH())
        mapVote:SetPos(0, 0)
        mapVote:SetAlpha(0)
        mapVote:MoveToFront()

        surface.PlaySound("ui/invite_receive.wav")

        local time = CurTime() + 20

        local text = "VOTE FOR THE NEXT MAP!"
        surface.SetFont("BenderExfilTimer")
        local textSize = surface.GetTextSize(text) + EFGM.ScreenScale(10)

        local acceptBind = string.upper(input.GetKeyName(GetConVar("efgm_bind_invites_accept"):GetInt()) or "N/A")
        local declineBind = string.upper(input.GetKeyName(GetConVar("efgm_bind_invites_decline"):GetInt()) or "N/A")

        mapVote.Paint = function(self, w, h)
            if GetGlobalInt("MapVotes_1", 0) != 0 or GetGlobalInt("MapVotes_2", 0) != 0 then
                map1Votes = math.Round(GetGlobalInt("MapVotes_1", 0) / (GetGlobalInt("MapVotes_1", 0) + GetGlobalInt("MapVotes_2", 0)) * 100)
                map2Votes = math.Round(GetGlobalInt("MapVotes_2", 0) / (GetGlobalInt("MapVotes_2", 0) + GetGlobalInt("MapVotes_1", 0)) * 100)
            end

            surface.SetDrawColor(Colors.hudBackground)
            surface.DrawRect(EFGM.ScreenScale(20), EFGM.ScreenScale(20), textSize, EFGM.ScreenScale(250))

            surface.SetDrawColor(Colors.hudBackground)
            surface.DrawRect(EFGM.ScreenScale(20), EFGM.ScreenScale(20), textSize, EFGM.ScreenScale(1))

            surface.SetDrawColor(Colors.transparentWhiteColor)
            surface.DrawRect(EFGM.ScreenScale(20), EFGM.ScreenScale(20), ((time - CurTime()) / 20) * textSize, EFGM.ScreenScale(1))

            draw.SimpleText(text, "BenderExfilTimer", EFGM.ScreenScale(25), EFGM.ScreenScale(21), Color(255, 255, 255), TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
            draw.SimpleText(string.upper("[" .. acceptBind .. "] " .. map1Name), "Bender24", EFGM.ScreenScale(25), EFGM.ScreenScale(241), Color(255, 255, 255), TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
            draw.SimpleText(string.upper("[" .. declineBind .. "] " .. map2Name), "Bender24", EFGM.ScreenScale(185), EFGM.ScreenScale(241), Color(255, 255, 255), TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)

            draw.SimpleText(map1Votes .. "%", "Bender18", EFGM.ScreenScale(25), EFGM.ScreenScale(225), Color(255, 255, 255), TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
            draw.SimpleText(map2Votes .. "%", "Bender18", EFGM.ScreenScale(185), EFGM.ScreenScale(225), Color(255, 255, 255), TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)

            surface.SetMaterial(map1Icon)
            surface.SetDrawColor(Colors.pureWhiteColor)
            surface.DrawTexturedRect(EFGM.ScreenScale(25), EFGM.ScreenScale(75), EFGM.ScreenScale(150), EFGM.ScreenScale(150))

            surface.SetMaterial(map2Icon)
            surface.SetDrawColor(Colors.pureWhiteColor)
            surface.DrawTexturedRect(EFGM.ScreenScale(185), EFGM.ScreenScale(75), EFGM.ScreenScale(150), EFGM.ScreenScale(150))
        end

        mapVote:AlphaTo(255, 0.1, 0, nil)

    end)

end)