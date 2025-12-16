hook.Add("PreRegisterSWEP", "ARC9Override", function(swep, class)
    -- arc9 determines a player as sprinting if they are holding IN_SPEED, not when they are actually sprinting, breaking animations with EFGM's sprinting system
    function SWEP:GetIsSprintingCheck()
        local owner = self:GetOwner()

        if !owner:IsValid() or owner:IsNPC() then
            return false
        end
        if self:GetInSights() then return false end
        if self:GetCustomize() then return false end
        if !owner:KeyDown(IN_SPEED) then return false end
        if !owner:IsSprinting() then return false end
        if !owner:OnGround() or owner:GetMoveType() == MOVETYPE_NOCLIP then return false end
        if !owner:KeyDown(IN_FORWARD + IN_BACK + IN_MOVELEFT + IN_MOVERIGHT) then return false end

        if (self:GetAnimLockTime() > CurTime()) and self:GetProcessedValue("NoSprintWhenLocked", true) then return false end
        if self:GetProcessedValue("ShootWhileSprint", true) and owner:KeyDown(IN_ATTACK) then return false end
        if self:GetGrenadePrimed() then return false end
        if owner:Crouching() then return false end

        return true
    end

    -- take a wild guess
    function SWEP:GetIsWalking()
        local owner = self:GetOwner()

        if !owner:IsValid() or owner:IsNPC() then return false end
        if owner:KeyDown(IN_SPEED) then return false end
        if owner:IsSprinting() then return false end
        if !owner:KeyDown(IN_FORWARD + IN_BACK + IN_MOVELEFT + IN_MOVERIGHT) then return false end

        local curspeed = owner:GetVelocity():LengthSqr()
        if curspeed <= 0 then return false end

        return true
    end

    -- sway
    local lasteyeang = Angle()
    local smootheyeang = Angle()
    local smoothswayroll = 0
    local Lerp = Lerp

    function SWEP:GetViewModelSway(pos, ang)
        local ft = FrameTime()
        local sightmult = 0.5 + math.Clamp(1 / ft / 100, 0, 5)
        sightmult = sightmult * Lerp(self:GetSightAmount(), 1, 0.25)

        smootheyeang = LerpAngle(math.Clamp(ft * 24, 0.075, 1), smootheyeang, EyeAngles() - lasteyeang)
        lasteyeang = EyeAngles()

        smoothswayroll = Lerp(math.Clamp(ft * 24, 0.075, 1), smoothswayroll, smootheyeang.y)

        if self.SprintVerticalOffset then
            local sprintoffset = math.Clamp(EyeAngles().p * 0.1, -9, 4.5)
            local sprintoffset2 = sprintoffset + 1.2
            local lerrppp = Lerp(self:GetSprintAmount(), 0, 1)
            sprintoffset, sprintoffset2 = sprintoffset * lerrppp, sprintoffset2 * lerrppp

            pos:Add(ang:Up() * (sprintoffset2 + 2) * 0.1 * lerrppp)
            pos:Add(ang:Right() * sprintoffset2 * 0.2)
            pos:Add(ang:Forward() *  (sprintoffset2 + 10) * 0.1 * lerrppp)
            ang.z = ang.z + math.min(0, sprintoffset * -6)
            ang.y = ang.y + math.min(0, sprintoffset * -2)
        end

        smootheyeang.p = math.Clamp(smootheyeang.p * 0.95, -10, 10)
        smootheyeang.y = math.Clamp(smootheyeang.y * 0.9, -4, 4)
        smootheyeang.r = math.Clamp(smoothswayroll * (0.5 + math.Clamp(ft * 64, 0, 4)), -2, 2)

        local inertiaanchor = Vector(self.CustomizeRotateAnchor)
        inertiaanchor.x = inertiaanchor.x * 0.75

        pos:Add(ang:Up() * smootheyeang.p * 0.075 * (sightmult / 3))
        pos:Add(ang:Right() * smootheyeang.y * -0.1 * (sightmult / 3))

        local rap_pos, rap_ang = self:RotateAroundPoint2(pos, ang, inertiaanchor, vector_origin, smootheyeang * 3 * (sightmult / 6) * -1)
        pos:Set(rap_pos)
        ang:Set(rap_ang)

        return pos, ang
    end

    function SWEP:Initialize()
        local owner = self:GetOwner()

        self.HoldTypeDefault = self.HoldType

        self:SetShouldHoldType()

        if owner:IsNPC() then
            self:PostModify()
            self:NPC_Initialize()
            return
        end


        self:SetLastMeleeTime(0)
        self:SetNthShot(0)

        self.SpawnTime = CurTime()
        self:SetSpawnEffect(false)

        self:InitTimers()

        self:ClientInitialize()

        self.DefaultAttachments = table.Copy(self.Attachments)

        self:BuildSubAttachments(self.DefaultAttachments)

        if !IsValid(owner) then
            self:PostModify()
            timer.Simple(0.1, function()
                if IsValid(self) and !IsValid(self:GetOwner()) then
                    self:NoOwner_Initialize()
                end
            end)
        end

        self.LastClipSize = self:GetProcessedValue("ClipSize")
        self.Primary.Ammo = self:GetProcessedValue("Ammo")
        self.LastAmmo = self.Primary.Ammo

        local clip = self.LastClipSize
        self.Primary.DefaultClip = self.ForceDefaultClip or (clip + (bottomless and 0 or 0))

        if self.Primary.DefaultClip == 1 then
            -- self:SetClip1(0)
            self.Primary.DefaultClip = 0
        end

        if self:GetValue("UBGL") then
            self.Secondary.Ammo = self:GetValue("UBGLAmmo")
            self.Secondary.DefaultClip = 0
        end

        self:SetClip1(0)
        self:SetClip2(0)

        self:SetLastLoadedRounds(self.LastClipSize)

        timer.Simple(0.4, function()
            if IsValid(self) then
                if self:LookupPoseParameter("sights") != -1 then self.HasSightsPoseparam = true end
                if self:LookupPoseParameter("firemode") != -1 then self.HasFiremodePoseparam = true end
                if SERVER then self:InitialDefaultClip() end
            end
        end)

        ARC9.CacheWepSounds(self, self:GetClass())
    end

    function SWEP:PostModify(toggleonly)
        self:InvalidateCache()

        if !toggleonly then
            self.ScrollLevels = {}
            self:CancelReload()
            self:SetNthReload(0)
        end

        local client = self:GetOwner()
        local validplayerowner = IsValid(client) and client:IsPlayer()

        local base = baseclass.Get(self:GetClass())

        if ARC9:UseTrueNames() then
            self.PrintName = base.TrueName
            self.PrintName = self:GetValue("TrueName")
        else
            self.PrintName = base.PrintName
            self.PrintName = self:GetValue("PrintName")
        end

        if !self.PrintName then
            self.PrintName = base.PrintName
            self.PrintName = self:GetValue("PrintName")
        end

        self.Description = base.Description

        self.PrintName = self:RunHook("HookP_NameChange", self.PrintName)
        self.Description = self:RunHook("HookP_DescriptionChange", self.Description)

        if CLIENT then
            self:SendWeapon()
            self:KillModel()
            self:SetupModel(true)
            self:SetupModel(false)
            if !toggleonly then
                self:SavePreset()
            end
            self:BuildMultiSight()
            self.InvalidateSelectIcon = true
        else
            if validplayerowner then
                if self:GetValue("ToggleOnF") and client:FlashlightIsOn() then
                    client:Flashlight(false)
                end

                timer.Simple(0, function()
                    if self.LastAmmo != self:GetValue("Ammo") or self.LastClipSize != self:GetValue("ClipSize") then
                        if self.AlreadyGaveAmmo then
                            self:Unload()
                            self:SetRequestReload(true)
                        else
                            -- self:SetClip1(self:GetProcessedValue("ClipSize"))
                            self.AlreadyGaveAmmo = true
                        end
                    end

                    self.LastAmmo = self:GetValue("Ammo")
                    self.LastClipSize = self:GetValue("ClipSize")
                end)


                if self:GetValue("UBGL") then
                    if !self.AlreadyGaveUBGLAmmo then
                        -- self:SetClip2(self:GetMaxClip2())
                        self.AlreadyGaveUBGLAmmo = true
                    end

                    if (self.LastUBGLAmmo) then
                        if (self.LastUBGLAmmo != self:GetValue("UBGLAmmo") or self.LastUBGLClipSize != self:GetValue("UBGLClipSize")) then
                            local data = {}
                            data.count = self:Clip2()
                            FlowItemToInventory(self:GetOwner(), self.LastUBGLAmmo, EQUIPTYPE.Ammunition, data)
                            -- client:GiveAmmo(self:Clip2(), self.LastUBGLAmmo)
                            self:SetClip2(0)
                            self:SetRequestReload(true)
                        end
                    end

                    self.LastUBGLAmmo = self:GetValue("UBGLAmmo")
                    self.LastUBGLClipSize = self:GetValue("UBGLClipSize")

                    local capacity = self:GetCapacity(true)
                    if capacity > 0 and self:Clip2() > capacity then
                        local data = {}
                        data.count = self:Clip2() - capacity
                        FlowItemToInventory(self:GetOwner(), self.LastUBGLAmmo, EQUIPTYPE.Ammunition, data)
                        -- client:GiveAmmo(self:Clip2() - capacity, self.LastUBGLAmmo)
                        self:SetClip2(capacity)
                    end
                end

                local capacity = self:GetCapacity(false)
                if capacity > 0 and self:Clip1() > capacity then
                    local data = {}
                    data.count = self:Clip1() - capacity
                    FlowItemToInventory(self:GetOwner(), self.LastAmmo, EQUIPTYPE.Ammunition, data)
                    -- client:GiveAmmo(self:Clip1() - capacity, self.LastAmmo)
                    self:SetClip1(capacity)
                end

                if self:GetProcessedValue("BottomlessClip", true) then
                    self:RestoreClip()
                end

                MatchWithEquippedAndUpdate(client, self.ClassName, self.Attachments)
                ReloadInventory(client)

            end
        end

        if self:GetUBGL() and !self:GetProcessedValue("UBGL") then
            self:ToggleUBGL(false)
        end

        if game.SinglePlayer() and validplayerowner then
            self:CallOnClient("RecalculateIKGunMotionOffset")
        end

        self:SetupAnimProxy()

        self:SetBaseSettings()

        if self:GetAnimLockTime() <= CurTime() then
            self:Idle()
        end
    end

    -- replace ammo amount with the amount of ammo in the players inventory
    function SWEP:Ammo1()
        if !IsValid(self:GetOwner()) then return math.huge end

        if self:GetInfiniteAmmo() or self:GetOwner():GetNWBool("InRange", false) == true then
            return math.huge
        end

        local inventory = {}
        if SERVER then inventory = self:GetOwner().inventory end
        if CLIENT then inventory = playerInventory end

        return AmountInInventory(inventory, self:GetValue("Ammo"))
    end

    function SWEP:Ammo2()
        if !IsValid(self:GetOwner()) then return math.huge end

        if self:GetInfiniteAmmo() or self:GetOwner():GetNWBool("InRange", false) == true then
            return math.huge
        end

        local inventory = {}
        if SERVER then inventory = self:GetOwner().inventory end
        if CLIENT then inventory = playerInventory end

        return AmountInInventory(inventory, self:GetValue("UBGLAmmo"))
    end

    function SWEP:ThinkUBGL()
        if self:GetValue("UBGL") and !self:GetProcessedValue("UBGLInsteadOfSights", true)  then
            local owner = self:GetOwner()
            local mag = self:Clip2()
            local magr = self:Ammo2()
            local infmag = owner:GetNWBool("InRange", false)

            if mag == 0 and (!infmag and magr == 0) then
                if self:GetUBGL() then self:ToggleUBGL(false) end
                return
            end

            if (owner:KeyDown(IN_USE) and owner:KeyPressed(IN_ATTACK2)) or owner:KeyPressed(ARC9.IN_UBGL) then
                if self.NextUBGLSwitch and self.NextUBGLSwitch > CurTime() then return end
                self.NextUBGLSwitch = CurTime() + (self.UBGLToggleTime or 1)

                if self:GetUBGL() then
                    self:ToggleUBGL(false)
                else
                    self:ToggleUBGL(true)
                end
            end

        end
    end

    function SWEP:RestoreClip(amt)
        if CLIENT then return end

        amt = amt or math.huge

        amt = math.Round(amt)

        local inf = self:GetInfiniteAmmo()
        local clip = self:Clip1()
        local ammo = self:Ammo1()

        if self:GetUBGL() then
            clip = self:Clip2()
            ammo = self:Ammo2()
        end

        -- amt = math.max(amt, -clip)

        -- clip can be -1 here if defaultclip is being set
        local reserve = inf and math.huge or (math.max(0, clip) + ammo)

        local lastclip

        if self:GetUBGL() then
            lastclip = self:Clip2()
            local efgmdeduct = math.min(math.min(clip + amt, self:GetCapacity(false)), reserve) - lastclip

            self:SetClip2(math.min(math.min(clip + amt, self:GetCapacity(true)), reserve))

            reserve = reserve - self:Clip2()

            if !inf and self:GetOwner():GetNWBool("InRange", false) == false and IsValid(self:GetOwner()) then
                DeflowItemsFromInventory(self:GetOwner(), self.Secondary.Ammo, efgmdeduct)
                -- self:GetOwner():SetAmmo(reserve, self.Secondary.Ammo)
            end

            clip = self:Clip2()
        else
            lastclip = self:Clip1()
            local efgmdeduct = math.min(math.min(clip + amt, self:GetCapacity(false)), reserve) - lastclip

            self:SetClip1(math.min(math.min(clip + amt, self:GetCapacity(false)), reserve))

            reserve = reserve - self:Clip1()

            if !inf and self:GetOwner():GetNWBool("InRange", false) == false and IsValid(self:GetOwner()) then
                DeflowItemsFromInventory(self:GetOwner(), self.Primary.Ammo, efgmdeduct)
                -- self:GetOwner():SetAmmo(reserve, self.Primary.Ammo)
            end

            clip = self:Clip1()

            if !self.NoForceSetLoadedRoundsOnReload then -- sorry
                self:SetLoadedRounds(self:Clip1())
                self:SetLastLoadedRounds(self:Clip1())
            end
        end

        ReloadInventory(self:GetOwner())

        return clip - lastclip
    end

    function SWEP:Unload()
        if SERVER then
            if self:GetOwner():GetNWBool("InRange", false) == false then
                local data = {}
                data.count = self:Clip1()
                FlowItemToInventory(self:GetOwner(), self.Ammo, EQUIPTYPE.Ammunition, data)
                ReloadInventory(self:GetOwner())
                -- self:GetOwner():GiveAmmo(self:Clip1(), self.Ammo, true)
            end
        end
        self:SetClip1(0)
        self:SetLoadedRounds(0)
    end

    function SWEP:PrimaryAttack()
        if self.NotAWeapon then return end

        local owner = self:GetOwner()

        if owner:IsNPC() then
            self:NPC_PrimaryAttack()
            return
        end

        if self:GetProcessedValue("Throwable", true) then
            return
        end

        if self:GetProcessedValue("PrimaryBash", true) then
            return
        end

        if self:GetProcessedValue("UBGLInsteadOfSights", true) then
            self:ToggleUBGL(false)
        end

        if self:GetSafe() then
            self:ToggleSafety(false)
            self:SetNeedTriggerPress(true)
            return
        end

        if self:GetNeedTriggerPress() then return end

        if self:GetNeedsCycle() then return end


        if self:GetCustomize() then return end

        if self:GetProcessedValue("Bash", true) and owner:KeyDown(IN_USE) and !self:GetInSights() then
            if self:GetIsSprinting() and !self.ShootWhileSprint then return end
            self:MeleeAttack()
            self:SetNeedTriggerPress(true)
            return
        end

        if self:SprintLock() then return end

        if self:GetOwner():GetNWBool("InRange", false) == false and self:GetOwner():CompareStatus(0) then return end

        local nthShot = self:GetNthShot()

        if self:HasAmmoInClip() then
            if self:GetProcessedValue("TriggerDelay") then
                local primedAttack = self:GetPrimedAttack()
                local time = CurTime()

                if self:GetBurstCount() == 0 and !primedAttack and !self:StillWaiting() then
                    self:SetTriggerDelay(time + self:GetProcessedValue("TriggerDelayTime"))
                    local isEmpty = self:Clip1() == self:GetProcessedValue( "AmmoPerShot")
                    local anim = "trigger"

                    if self:GetProcessedValue("Akimbo", true) then
                        if self:GetProcessedValue( "AkimboBoth", true) then
                            anim = "trigger_both"
                        elseif nthShot % 2 == 0 then
                            anim = "trigger_right"
                        else
                            anim = "trigger_left"
                        end
                    end

                    if self:GetProcessedValue("TriggerStartFireAnim", true) then
                            if self:GetProcessedValue("Akimbo", true) then
                                if self:GetProcessedValue( "AkimboBoth", true) then
                                    anim = "fire_both"
                                elseif nthShot % 2 == 0 then
                                    anim = "fire_right"
                                else
                                    anim = "fire_left"
                                end
                            else anim = "fire"
                        end
                    end
                    if self:HasAnimation(anim .. "_empty", true) and isEmpty then
                        anim = anim .. "_empty"
                    end
                    self:PlayAnimation(anim)
                    self:SetPrimedAttack(true)
                    return
                elseif primedAttack and (self:GetTriggerDelay() <= time and (!self:GetProcessedValue( "TriggerDelayReleaseToFire", true) or !owner:KeyDown(IN_ATTACK))) then
                    self:SetPrimedAttack(false)
                end
            end
        elseif !self:GetProcessedValue("TriggerDelay") or !self:GetProcessedValue( "TriggerDelayReleaseToFire", true) or !owner:KeyDown(IN_ATTACK) then
            self:SetPrimedAttack(false)
        end

        if self:GetReloading() then
            self:SetEndReload(true)
        end

        self:DoPrimaryAttack()

        if self.RecentMelee then
            self.RecentMelee = nil
        end

    end

    if CLIENT then

        local flaremat = Material("effects/arc9_lensflare", "mips smooth")
        local badcolor = Color(255, 255, 255)
        local arc9_allflash = GetConVar("arc9_allflash")

        function SWEP:CreateFlashlights()
            self:KillFlashlights()
            self.Flashlights = {}

            local total_lights = 0
            local lp = LocalPlayer()

            for _, k in ipairs(self:GetSubSlotList()) do
                if !k.Installed then continue end
                local atttbl = self:GetFinalAttTable(k)

                if atttbl.Flashlight then
                    local newlight = {
                        slottbl = k,
                        light = ProjectedTexture(),
                        col = atttbl.FlashlightColor or color_white,
                        br = atttbl.FlashlightBrightness or 3,
                        qca = atttbl.FlashlightAttachment,
                        nodotter = atttbl.Flashlight360
                    }

                    total_lights = total_lights + 1

                    local l = newlight.light
                    if !IsValid(l) then continue end

                    table.insert(self.Flashlights, newlight)

                    l:SetFOV(atttbl.FlashlightFOV or 50)


                    l:SetFarZ(atttbl.FlashlightDistance or 1024)
                    -- l:SetNearZ(4)
                    l:SetNearZ(0) -- setting to 4 when drawing to prevent flicker (position here is undefined)

                    l:SetQuadraticAttenuation(100)

                    l:SetColor(atttbl.FlashlightColor or color_white)
                    l:SetTexture(atttbl.FlashlightMaterial or "effects/flashlight001")
                    l:SetBrightness(atttbl.FlashlightBrightness or 3)

                    l:SetEnableShadows(false)
                    l:Update()

                    local g_light = {
                        Weapon = self,
                        ProjectedTexture = l
                    }

                    table.insert(ARC9.FlashlightPile, g_light)
                end
            end

            if total_lights > 1 or (arc9_allflash:GetBool() and self:GetOwner() != lp) then -- you are a madman
                for i, k in ipairs(self.Flashlights) do
                    if k.light:IsValid() then k.light:SetEnableShadows(false) end
                end
            end
        end

        function SWEP:DrawLightFlare(pos, ang, col, size, vm, nodotter, dir) -- mostly tacrp
            col = col or badcolor
            size = size * 4 or 4

            local lp, owner = LocalPlayer(), self:GetOwner()
            if !vm and owner == lp and !lp:ShouldDrawLocalPlayer() then return end

            dir = dir or ang:Forward()

            local dot = -dir:Dot(EyeAngles():Forward())
            local dot2 = dir:Dot((EyePos() - pos):GetNormalized())
            dot = (dot + dot2) / 2

            if nodotter then dot, dot2 = 1, 1 end

            if dot < 0 then return end

            local diff = EyePos() - pos

            dot = dot ^ 4
            local tr = util.QuickTrace(pos, diff, {owner, lp, lp:GetViewEntity()})
            local s = math.Clamp(1 - diff:Length() / 700, 0, 1) ^ 1 * dot * 500 * math.Rand(0.95, 1.05) * size

            local rtt = render.GetRenderTarget()
            if rtt and rtt:GetName() == "_rt_waterreflection" then tr.Fraction = 1 end -- mirror fix

            if vm or tr.Fraction == 1 then
                s = ScreenScale(s)
                local toscreen = pos:ToScreen()
                cam.Start2D()
                    surface.SetMaterial(flaremat)
                    surface.SetDrawColor(col, 128)
                    surface.DrawTexturedRect(toscreen.x - s / 2, toscreen.y - s / 2, s, s)
                cam.End2D()

                if !vm and size > 0.1 then
                    local rad = 128 * size * dot2
                    col.a = 50 + size * 205

                    pos = pos + ang:Forward() * 2
                    pos = pos + diff:GetNormalized() * (2 + 14 * size)

                    render.SetMaterial(flaremat)
                    render.DrawSprite(pos, rad, rad, col)
                end
            end
        end

        local arc9_atts_nocustomize = GetConVar("arc9_atts_nocustomize")
        local arc9_autosave = GetConVar("arc9_autosave")

        function SWEP:GetAttsFromPreset(filename)

            if arc9_atts_nocustomize:GetBool() then return end
            if LocalPlayer() != self:GetOwner() then return end

            filename = filename or "autosave"

            if filename == "autosave" then
                if !arc9_autosave:GetBool() then return end
            end

            filename = ARC9.PresetPath .. self:GetPresetBase() .. "/" .. filename .. ".txt"

            if !file.Exists(filename, "DATA") then return end

            local f = file.Open(filename, "r", "DATA")
            if !f then return end

            local str = f:Read()

            local atts = {}

            if str[1] == "{" then
                atts = util.JSONToTable(str)
            elseif string.sub(str, 1, 5) == "name=" then
                -- first line is name second line is data
                local strs = string.Split(str, "\n")
                atts = self:ImportPresetCode(strs[2])
            else
                atts = self:ImportPresetCode(str)
            end

            f:Close()

            return atts

        end

        local ARC9ScreenScale = ARC9.ScreenScale

        local clicksound = "arc9/newui/uimouse_click_return.ogg"
        local removesound = "arc9/newui/presets/preset_sound1-delete.ogg"
        local savesound = "arc9/newui/presets/preset_sound3-save.ogg"
        local applysound = "arc9/newui/presets/preset_sound2-apply.ogg"
        local randomizesound = "arc9/newui/presets/shuffle_sound2.ogg"

        local mat_default = Material("arc9/arc9_logo.png", "mips smooth")
        local mat_random = Material("arc9/ui/random.png", "mips smooth")
        local nextpreset = 0

        local deadzonex = GetConVar("arc9_hud_deadzonex")

        function SWEP:CreatePresetMenu(reload)
            if GetConVar("arc9_atts_nocustomize"):GetBool() then return end
            if reload and self.CustomizeHUD and self.CustomizeHUD.presetpanel then self.CustomizeHUD.presetpanel:Remove() end
            if !reload and self.CustomizeHUD and self.CustomizeHUD.presetpanel then self:ClosePresetMenu() return end

            -- self.CustomizeButtons[self.CustomizeTab + 1].func(self)
            if !self.CustomizeButtons[self.CustomizeTab + 1].inspect then
                self.CustomizeButtons[1].func(self)
                self.CustomizeTab = 0
            end

            local scrw, scrh = ScrW(), ScrH()
            local bg = self.CustomizeHUD

            local presetpanel = vgui.Create("DFrame", bg)
            self.CustomizeHUD.presetpanel = presetpanel
            presetpanel:SetPos(scrw - ARC9ScreenScale(130+19) - deadzonex:GetInt(), ARC9ScreenScale(45))
            presetpanel:SetSize(ARC9ScreenScale(130), scrh-ARC9ScreenScale(145))
            presetpanel:SetTitle("")
            -- presetpanel:SetDraggable(false)
            presetpanel:ShowCloseButton(false)
            presetpanel:SetAlpha(0)
            presetpanel:AlphaTo(255, 0.1, 0, nil)

            local cornercut = ARC9ScreenScale(3.5)
            presetpanel.Paint = function(self2, w, h) 
                draw.NoTexture()
                surface.SetDrawColor(ARC9.GetHUDColor("bg"))
                surface.DrawPoly({{x = cornercut, y = h},{x = 0, y = h-cornercut}, {x = 0, y = cornercut},{x = cornercut, y = 0}, {x = w-cornercut, y = 0},{x = w, y = cornercut}, {x = w, y = h-cornercut}, {x = w-cornercut, y = h}})
                -- thingy at bottom
                surface.SetDrawColor(ARC9.GetHUDColor("hi"))
                surface.DrawPoly({{x = cornercut, y = h}, {x = 0, y = h-cornercut}, {x = cornercut, y = h-cornercut*.5}})
                surface.DrawPoly({{x = w, y = h-cornercut}, {x = w-cornercut, y = h}, {x = w-cornercut, y = h-cornercut*.5}})
                surface.DrawPoly({{x = cornercut, y = h-cornercut*.5}, {x = w-cornercut, y = h-cornercut*.5}, {x = w-cornercut, y = h}, {x = cornercut, y = h}, })
                -- same thingy at top
                surface.DrawPoly({{x = 0, y = cornercut}, {x = cornercut, y = 0}, {x = cornercut, y = cornercut*.5}})
                surface.DrawPoly({{x = w-cornercut, y = 0}, {x = w, y = cornercut}, {x = w-cornercut, y = cornercut*.5}})
                surface.DrawPoly({{x = cornercut, y = 0}, {x = w-cornercut, y = 0}, {x = w-cornercut, y = cornercut*.5}, {x = cornercut, y = cornercut*.5}, })
            end

            local presetscroller = vgui.Create("ARC9ScrollPanel", presetpanel)
            presetscroller:SetSize(presetpanel:GetWide() - ARC9ScreenScale(4), presetpanel:GetTall()-ARC9ScreenScale(26))
            presetscroller:SetPos(ARC9ScreenScale(2), ARC9ScreenScale(4))
            -- presetscroller.Paint = function(self2, w, h) 
            --     surface.SetDrawColor(ARC9.GetHUDColor("bg"))
            --     surface.DrawRect(0, 0, w, h)
            -- end
            
            local savebtn = vgui.Create("ARC9TopButton", presetpanel)
            surface.SetFont("ARC9_12")
            local savetxt = ARC9:GetPhrase("customize.presets.save")
            local importtxt = ARC9:GetPhrase("customize.presets.import")
            local tw = surface.GetTextSize(savetxt)
            local tw2 = surface.GetTextSize(importtxt)
            local ih8l18n = (presetpanel:GetWide() - tw - tw2) > ARC9ScreenScale(70) and ARC9ScreenScale(10) or 0

            savebtn:SetPos(ARC9ScreenScale(5)+ih8l18n, presetpanel:GetTall() - ARC9ScreenScale(20))
            savebtn:SetSize(ARC9ScreenScale(22)+tw, ARC9ScreenScale(21*0.75))
            savebtn:SetButtonText(savetxt, "ARC9_12")
            savebtn:SetIcon(Material("arc9/ui/save.png", "mips smooth"))
            savebtn.DoClick = function(self2)
                surface.PlaySound(savesound)
                if nextpreset > CurTime() then return end
                nextpreset = CurTime() + 1

                self:CreatePresetName()
            end
            savebtn.Think = function(self2)
                if !IsValid(self) then return end
                if self2:IsHovered() then
                    self.CustomizeHints["customize.hint.select"] = "customize.hint.save"
                    self.CustomizeHints["customize.hint.deselect"] = "customize.hint.quicksave"
                end
            end
            savebtn.DoRightClick = function(self2)
                if nextpreset > CurTime() then return end
                nextpreset = CurTime() + 1

                -- local txt = os.date( "%I.%M%p", os.time() )
                -- if txt:Left(1) == "0" then txt = txt:Right( #txt-1 ) end
                local txt = "Preset "
                local num = 0

                for _, preset in ipairs(self:GetPresets()) do
                    local psname = self:GetPresetName(preset)
                    if string.StartWith(psname, txt) then
                        local qsnum = tonumber(string.sub(psname, string.len(txt) + 1))

                        -- print(string.sub(preset, string.len(txt) + 1))

                        if qsnum and qsnum > num then
                            num = qsnum
                        end
                    end
                end

                txt = txt .. tostring(num + 1)

                self:SavePreset( txt )
                surface.PlaySound("arc9/shutter.ogg")

                timer.Simple(0.5, function()
                    if IsValid(self) and IsValid(self:GetOwner()) then
                        self:GetOwner():ScreenFade(SCREENFADE.IN, Color(255, 255, 255, 127), 0.5, 0)
                        if self:GetCustomize() then
                            self:CreateHUD_Bottom()
                            self:CreatePresetMenu(true)
                        end
                    end
                end)
            end

            local importbtn = vgui.Create("ARC9TopButton", presetpanel)
            importbtn:SetPos(presetpanel:GetWide()-(ARC9ScreenScale(22)+tw2) - ARC9ScreenScale(5) - ih8l18n , presetpanel:GetTall() - ARC9ScreenScale(20))
            importbtn:SetSize(ARC9ScreenScale(22)+tw2, ARC9ScreenScale(21*0.75))
            importbtn:SetButtonText(importtxt, "ARC9_12")
            importbtn:SetIcon(Material("arc9/ui/import.png", "mips smooth"))
            importbtn.DoClick = function(self2)
                self:CreateImportPreset()
                surface.PlaySound(clicksound)
            end
            importbtn.Think = function(self2)
                if !IsValid(self) then return end
                if self2:IsHovered() then
                    self.CustomizeHints["customize.hint.select"] = "customize.hint.import"
                end
            end

            local function createpresetbtn(preset, undeletable)
                local filename = ARC9.PresetPath .. self:GetPresetBase() .. "/" .. preset .. "." .. ARC9.PresetIconFormat
                if preset != "random" and !file.Exists(filename, "DATA") then return end

                local presetName, presetCount = self:GetPresetData(preset)

                local presetAtts = self:GetAttsFromPreset(preset)
                local neededAtts = {}

                local oldcount = self:CountAttsInTree(self.Attachments)
                local newcount = self:CountAttsInTree(presetAtts)

                local efgmPresetCost = 0

                if !newcount then

                    for att, attc in pairs(newcount) do
                        local atttbl = ARC9.GetAttTable(att)

                        if !atttbl then continue end -- doesnt exist, bc some default EFT presets have things that we remove in efgm
                        if atttbl.Free then continue end
                        if !EFGMITEMS["arc9_att_" .. att] then return end -- the item doesnt exist in EFGM, no preset for you!
                        if AmountInInventory(playerInventory, "arc9_att_" .. att) > 0 then continue end -- we already have this in our inventory
                        if !EFGMITEMS["arc9_att_" .. att].canPurchase then return end

                        local has = oldcount[att] or 0
                        local need = attc

                        if has < need then
                            local diff = need - has
                            neededAtts["arc9_att_" .. att] = diff
                            efgmPresetCost = efgmPresetCost + (EFGMITEMS["arc9_att_" .. att].value * diff)
                        end
                    end

                end

                local presetbtn = vgui.Create("DButton", presetscroller)
                presetbtn:SetTall(ARC9ScreenScale(36))
                presetbtn:Dock(TOP)
                presetbtn:DockMargin(0, 0, 5, 5)
                presetbtn:SetText("")
                presetbtn.DoClick = function(self2)
                    if GetConVar("arc9_atts_nocustomize"):GetBool() then return end

                    presetName, presetCount = self:GetPresetData(preset)

                    presetAtts = self:GetAttsFromPreset(preset)
                    neededAtts = {}

                    oldcount = self:CountAttsInTree(self.Attachments)
                    newcount = self:CountAttsInTree(presetAtts)

                    efgmPresetCost = 0

                    for att, attc in pairs(newcount) do
                        local atttbl = ARC9.GetAttTable(att)

                        if !atttbl then continue end -- doesnt exist, bc some default EFT presets have things that we remove in efgm
                        if atttbl.Free then continue end
                        if !EFGMITEMS["arc9_att_" .. att] then return end -- the item doesnt exist in EFGM, no preset for you!
                        if AmountInInventory(playerInventory, "arc9_att_" .. att) > 0 then continue end -- we already have this in our inventory
                        if !EFGMITEMS["arc9_att_" .. att].canPurchase then return end

                        local has = oldcount[att] or 0
                        local need = attc

                        if has < need then
                            local diff = need - has
                            neededAtts["arc9_att_" .. att] = diff
                            efgmPresetCost = efgmPresetCost + (EFGMITEMS["arc9_att_" .. att].value * diff)
                        end
                    end

                    if table.IsEmpty(neededAtts) then self:LoadPreset(preset) surface.PlaySound(applysound) return end

                    if !self:GetOwner():CompareStatus(0) then return end

                    ply:ConCommand("efgm_gamemenu Market")
                    timer.Simple(0.1, function() Menu.ConfirmPreset(neededAtts, presetName, preset, true) end)

                    -- self:LoadPreset(preset)
                    -- surface.PlaySound(applysound)
                end

                if preset == "random" then 
                    presetbtn.name = ARC9:GetPhrase("customize.presets.random")
                    presetbtn.attcount = "?"
                    presetbtn.icon = mat_random
                    presetbtn.def = true
                    presetbtn.DoClick = function(self2)
                        if GetConVar("arc9_atts_nocustomize"):GetBool() then return end
                        -- self:NPC_Initialize()        
                        net.Start("arc9_randomizeatts")
                        net.SendToServer()

                        surface.PlaySound(randomizesound)

                        timer.Simple(0.1, function() if IsValid(self) then self:CreateHUD_Bottom() end end)
                    end
                else
                    presetbtn.preset = preset
                    presetbtn.name, presetbtn.attcount = self:GetPresetData(preset)
                end
                if presetbtn.name == "ignore" then presetbtn:Remove() return end

                if presetbtn.name == "default" then presetbtn.name = ARC9:GetPhrase("customize.presets.default") presetbtn.def = true end

                if file.Exists(filename, "DATA") then
                    presetbtn.icon = Material("data/" .. filename, "smooth")
                end

                -- if presetbtn.name == "Default" then
                --     presetbtn.icon = Material("materials/arc9/arc9_sus.png")
                -- end

                presetbtn.Paint = function(self2, w, h) 
                    surface.SetDrawColor(ARC9.GetHUDColor("bg"))
                    surface.DrawRect(0, 0, w, h)
                    if self2:IsHovered() then
                        if self2:IsDown() then 
                            surface.SetDrawColor(ARC9.GetHUDColor("hi", 100))
                        end
                        if !GetConVar("arc9_atts_nocustomize"):GetBool() then
                            self.CustomizeHints["customize.hint.select"] = "customize.hint.install"
                        end
                        surface.DrawRect(0, 0, w, h)
                    end
                    surface.SetDrawColor(20, 20, 20, 120)
                    surface.DrawRect(ARC9ScreenScale(1), ARC9ScreenScale(1), h*1.4, h - ARC9ScreenScale(2))

                    surface.SetDrawColor(ARC9.GetHUDColor("fg"))
                    surface.SetMaterial(presetbtn.icon or mat_default)
                    surface.DrawTexturedRect(0, -h*0.2, h*1.4, h*1.4)
                    -- surface.DrawTexturedRectUV(0, 0, h*1.4, h, 0, 0.2, 1, 0.8)

                    surface.SetFont("ARC9_12")
                    surface.SetTextColor(ARC9.GetHUDColor("fg"))
                    surface.SetTextPos(h*1.4 + ARC9ScreenScale(5), 0)
                    surface.DrawText(self2.name)
                    surface.SetFont("ARC9_8")
                    surface.SetTextPos(h*1.4 + ARC9ScreenScale(5), ARC9ScreenScale(12))
                    surface.DrawText(tostring(self2.attcount) .. ARC9:GetPhrase("customize.presets.atts"))

                    if self2.def or undeletable and !self2:IsHovered() and !(self2.delbutton and self2.delbutton:IsHovered()) then
                        surface.SetTextColor(ARC9.GetHUDColor("fg", 75))
                        surface.SetTextPos(h*1.4 + ARC9ScreenScale(5), ARC9ScreenScale(20))
                        surface.DrawText(ARC9:GetPhrase("customize.presets.default.long"))
                    end

                    if efgmPresetCost > 0 then

                        surface.SetTextColor(ARC9.GetHUDColor("fg", 75))
                        surface.SetTextPos(ARC9ScreenScale(2), ARC9ScreenScale(1))
                        surface.DrawText("₽" .. efgmPresetCost)

                    end
                end

                -- local preset_apply = vgui.Create("ARC9TopButton", presetbtn)
                -- surface.SetFont("ARC9_10")
                -- local tw3 = surface.GetTextSize("Install")
                -- preset_apply:SetPos(presetpanel:GetWide() - ARC9ScreenScale(22) - tw3 - ARC9ScreenScale(4), presetbtn:GetTall() - ARC9ScreenScale(15))
                -- preset_apply:SetSize(ARC9ScreenScale(17) + tw3, ARC9ScreenScale(21*0.625))
                -- preset_apply:SetButtonText("Install", "ARC9_10")
                -- preset_apply:SetIcon(Material("arc9/ui/apply.png", "mips smooth"))
                -- preset_apply.DoClick = function(self2)
                --     self:LoadPreset(preset)
                --     surface.PlaySound(clicksound)
                -- end
                -- preset_apply.Think = function(self2)
                --     if !IsValid(self) then return end
                --     if self2:IsHovered() then
                --         self.CustomizeHints["customize.hint.select"] = "Install"
                --     end
                -- end

                if !undeletable and !presetbtn.def  then
                    local preset_share = vgui.Create("ARC9TopButton", presetbtn)
                    preset_share:SetPos(ARC9ScreenScale(69), presetbtn:GetTall() - ARC9ScreenScale(15))
                    preset_share:SetSize(ARC9ScreenScale(21*0.625), ARC9ScreenScale(21*0.625))
                    preset_share:SetIcon(Material("arc9/ui/share.png", "mips smooth"))
                    preset_share.DoClick = function(self2)
                        surface.PlaySound(clicksound)

                        local f = file.Open(ARC9.PresetPath .. self:GetPresetBase() .. "/" .. preset .. ".txt", "r", "DATA")
                        if !f then return end
                        local str = f:Read()

                        local strs = string.Split(str, "\n")

                        self:CreateExportPreset("["..string.Split(strs[1], "=")[2].."]"..strs[2])
                        -- self:CreateExportPreset(self:GeneratePresetExportCode())
                    end
                    preset_share.Think = function(self2)
                        if !IsValid(self) then return end
                        if self2:IsHovered() then
                            self.CustomizeHints["customize.hint.select"] = "customize.hint.export"
                        end
                    end
                end
                
                if !undeletable and !presetbtn.def or undeletable and !presetbtn.def then
                    local preset_delete = vgui.Create("ARC9TopButton", presetbtn)
                    presetbtn.delbutton = preset_delete
                    preset_delete:SetPos(ARC9ScreenScale(54), presetbtn:GetTall() - ARC9ScreenScale(15))
                    preset_delete:SetSize(ARC9ScreenScale(21*0.625), ARC9ScreenScale(21*0.625))
                    preset_delete:SetIcon(Material("arc9/ui/delete.png", "mips smooth"))
                    preset_delete.DoClick = function(self2)
                        if undeletable then
                            self:CreateDeleteDefPreset(preset)
                        else
                            self:DeletePreset(preset)
                            presetbtn:Remove()
                            presetbtn = nil
                            -- self:CreatePresetMenu()
                            surface.PlaySound(removesound)
                        end
                    end
                    preset_delete.Think = function(self2)
                        if !IsValid(self) then return end
                        if self2:IsHovered() then
                            self.CustomizeHints["customize.hint.select"] = "customize.hint.delete"
                        end

                        if undeletable then
                            if presetbtn:IsHovered() or self2:IsHovered() then
                                self2:SetSize(ARC9ScreenScale(21*0.625), ARC9ScreenScale(21*0.625))
                            else
                                self2:SetSize(0, 0)
                            end
                        end
                    end
                end
            end

            createpresetbtn("default", true) -- i want not only one default preset
            local presetlist = self:GetPresets()

            for _, preset in ipairs(presetlist) do
                if preset == "autosave" or preset == "default" then continue end
                createpresetbtn(preset, !tonumber(preset)) -- if preset is a number then it's a user generated, if no - standard
            end

            if GetConVar("arc9_free_atts"):GetBool() then
                createpresetbtn("random", true)
            end
        end

        function SWEP:LoadPreset(filename)

            if arc9_atts_nocustomize:GetBool() then return end
            if LocalPlayer() != self:GetOwner() then return end

            filename = filename or "autosave"

            if filename == "autosave" then
                if !arc9_autosave:GetBool() then return end
            end

            filename = ARC9.PresetPath .. self:GetPresetBase() .. "/" .. filename .. ".txt"

            if !file.Exists(filename, "DATA") then return end

            local f = file.Open(filename, "r", "DATA")
            if !f then return end

            local str = f:Read()

            if str[1] == "{" then
                self:LoadPresetFromTable(util.JSONToTable(str))
            elseif string.sub(str, 1, 5) == "name=" then
                -- first line is name second line is data
                local strs = string.Split(str, "\n")
                self:LoadPresetFromTable(self:ImportPresetCode(strs[2]))
            else
                self:LoadPresetFromTable(self:ImportPresetCode(str))
            end

            if self.CustomizeHUD and self.CustomizeHUD.lowerpanel then
                timer.Simple(0, function()
                    if !IsValid(self) then return end
                    self:CreateHUD_Bottom()
                end)
            end

            f:Close()

        end

        function SWEP:LoadPresetFromTable(tbl)

            self.Attachments = baseclass.Get(self:GetClass()).Attachments

            for slot, slottbl in ipairs(self.Attachments) do
                slottbl.Installed = nil
                slottbl.SubAttachments = nil
            end

            self:PruneAttachments()

            self:BuildSubAttachments(tbl)
            self:PostModify()

        end

        function SWEP:ImportPresetCode(str)

            if !str then return end
            str = util.Base64Decode(str)
            str = util.Decompress(str)

            if !str then return end

            local tbl = util.JSONToTable(str)

            if tbl then

                for i, k in pairs(tbl) do

                    self:DecompressTableRecursive(k)

                end

            end

            return tbl

        end

        function SWEP:DecompressTableRecursive(tbl)

            for i, k in pairs(tbl) do
                if i == "i" then
                    tbl["i"] = nil
                    tbl["Installed"] = k
                elseif i == "s" then
                    tbl["s"] = nil
                    tbl["SubAttachments"] = k
                elseif i == "t" then
                    tbl["t"] = nil
                    tbl["ToggleNum"] = k
                end
            end

            if table.Count(tbl.SubAttachments or {}) > 0 then
                for i, k in pairs(tbl.SubAttachments) do
                    self:DecompressTableRecursive(k)
                end
            end

        end

        local modesicon = Material("arc9/ui/modes.png", "mips smooth")
        local camosicon = Material("arc9/ui/paint.png", "mips smooth")
        local favsound = "arc9/newui/ui_part_favourite1.ogg"

        function SWEP:CreateHUD_AttInfo()
            local lowerpanel = self.CustomizeHUD.lowerpanel
            -- if true then return end
            local atttbl = ARC9.GetAttTable(self.AttInfoBarAtt)

            self:ClearAttInfoBar()

            if !atttbl then return end

            local infopanel = vgui.Create("DPanel", lowerpanel)
            infopanel:SetSize(lowerpanel:GetWide(), ARC9ScreenScale(70))
            infopanel:SetPos(0, ARC9ScreenScale(75.5))
            infopanel.title = ARC9:GetPhraseForAtt(self.AttInfoBarAtt, "PrintName") or atttbl.PrintName
            infopanel.Paint = function(self2, w, h)
                if !IsValid(self) then return end
                -- surface.SetFont("ARC9_10")
                -- surface.SetTextPos(0, 0)
                -- surface.SetTextColor(ARC9.GetHUDColor("fg"))
                -- ARC9.DrawTextRot(self2, self2.title, 0, 0, ARC9ScreenScale(6), ARC9ScreenScale(3), w, true)

                markup.Parse("<font=ARC9_10>" .. self2.title):Draw(ARC9ScreenScale(6), ARC9ScreenScale(3), TEXT_ALIGN_LEFT, TEXT_ALIGN_LEFT)
            end

            self.AttInfoBar = infopanel

            local descscroller = vgui.Create("ARC9ScrollPanel", infopanel)
            descscroller:SetSize(lowerpanel:GetWide() / 2 - ARC9ScreenScale(5), infopanel:GetTall() - ARC9ScreenScale(16))
            descscroller:SetPos(ARC9ScreenScale(4), ARC9ScreenScale(14))

            local multiline = {}
            local desc = ARC9:GetPhraseForAtt(self.AttInfoBarAtt, "Description") or atttbl.Description

            if atttbl.AdvancedCamoSupport and !self.AdvancedCamoCache then
                desc = desc .. (ARC9:GetPhrase("customize.camoslot.nosupport") or "")
                if self.EFTErgo then desc = desc .. (ARC9:GetPhrase("customize.camoslot.eftextra") or "") end
            end

            multiline = ARC9MultiLineText(desc, descscroller:GetWide() - (ARC9ScreenScale(3.5)), "ARC9_9_Slim")

            for i, text in ipairs(multiline) do
                local desc_line = vgui.Create("DPanel", descscroller)
                desc_line:SetSize(descscroller:GetWide(), ARC9ScreenScale(9))
                desc_line:Dock(TOP)
                desc_line.Paint = function(self2, w, h)
                    -- surface.SetFont("ARC9_9_Slim")
                    -- surface.SetTextColor(ARC9.GetHUDColor("fg"))
                    -- surface.SetTextPos(ARC9ScreenScale(2), 0)
                    -- surface.DrawText(text)
                    markup.Parse("<font=ARC9_9_Slim>" .. text):Draw(ARC9ScreenScale(2), 0, TEXT_ALIGN_LEFT, TEXT_ALIGN_LEFT)
                end
            end

            local slot = self.AttInfoBarAttSlot

            local camotoggle = atttbl.AdvancedCamoSupport and self.AdvancedCamoCache

            if slot and ((atttbl.ToggleStats and !atttbl.AdvancedCamoSupport) or camotoggle) then
                local mode_toggle = vgui.Create("ARC9TopButton", infopanel)
                mode_toggle.addr = slot.Address
                surface.SetFont("ARC9_12")
                local curmode = "Togglable"
                local tw = surface.GetTextSize(curmode)
                mode_toggle:SetPos(descscroller:GetWide()/2-(ARC9ScreenScale(24)+tw)/2, ARC9ScreenScale(50))
                mode_toggle:SetSize(0, 0) -- ARC9ScreenScale(24)+tw, ARC9ScreenScale(21*0.75)
                mode_toggle:SetButtonText(curmode, "ARC9_12")
                mode_toggle:SetIcon(camotoggle and camosicon or modesicon)
                mode_toggle.DoClick = function(self2)
                    -- surface.PlaySound(clicksound)
                    -- self:PlayAnimation("toggle")
                    self:EmitSound(camotoggle and favsound or self:RandomChoice(self:GetProcessedValue("ToggleAttSound", true)), 75, 100, 1, CHAN_ITEM)
                    self:ToggleStat(self2.addr)
                    self:PostModify()
                end

                mode_toggle.DoRightClick = function(self2)
                    -- surface.PlaySound(clicksound)
                    -- self:PlayAnimation("toggle")
                    self:EmitSound(camotoggle and favsound or self:RandomChoice(self:GetProcessedValue("ToggleAttSound", true)), 75, 100, 1, CHAN_ITEM)
                    self:ToggleStat(self2.addr, -1)
                    self:PostModify()
                end

                mode_toggle.Think = function(self2)
                    if !IsValid(self) then return end
                    if self.AdvancedCamoCache == false then self2:Remove() return end

                    slot = self:LocateSlotFromAddress(self2.addr)

                    if !slot then return end

                    if slot.Installed == self.AttInfoBarAtt then
                        curmode = atttbl.ToggleStats[slot.ToggleNum] and ARC9:GetPhrase(atttbl.ToggleStats[slot.ToggleNum].PrintName) or atttbl.ToggleStats[slot.ToggleNum].PrintName or "Toggle"

                        surface.SetFont("ARC9_12")
                        tw = surface.GetTextSize(curmode)
                        mode_toggle:SetPos(descscroller:GetWide() / 2-(ARC9ScreenScale(24) + tw) / 2, ARC9ScreenScale(50))
                        mode_toggle:SetSize(ARC9ScreenScale(21) + tw, ARC9ScreenScale(21 * 0.75))
                        mode_toggle:SetButtonText(curmode, "ARC9_12")
                        if atttbl.ToggleStats[slot.ToggleNum].ToggleIcon then
                            mode_toggle:SetIcon(atttbl.ToggleStats[slot.ToggleNum].ToggleIcon)
                        end
                    else
                        mode_toggle:SetSize(0, 0)
                    end

                    if self2:IsHovered() then
                        self.CustomizeHints["customize.hint.select"] = "customize.hint.nextmode"
                        self.CustomizeHints["customize.hint.deselect"] = "customize.hint.lastmode"
                    end

                end
                descscroller:SetSize(lowerpanel:GetWide()/2 - ARC9ScreenScale(5), infopanel:GetTall() - ARC9ScreenScale(38)) -- making desc smaller
            end


            local prosscroller = vgui.Create("ARC9ScrollPanel", infopanel)
            prosscroller:SetSize(lowerpanel:GetWide()*0.25 - ARC9ScreenScale(3), infopanel:GetTall() - ARC9ScreenScale(4))
            prosscroller:SetPos(lowerpanel:GetWide()*0.5 + ARC9ScreenScale(3), ARC9ScreenScale(3))

            local consscroller = vgui.Create("ARC9ScrollPanel", infopanel)
            consscroller:SetSize(lowerpanel:GetWide()*0.25 - ARC9ScreenScale(3), infopanel:GetTall() - ARC9ScreenScale(4))
            consscroller:SetPos(lowerpanel:GetWide()*0.75 + ARC9ScreenScale(3), ARC9ScreenScale(3))

            local prosname, prosnum, consname, consnum = ARC9.GetProsAndCons(atttbl, self)

            if table.Count(prosname) > 0 then
                lowerpanel.HasPros = true
                for k, stat in ipairs(prosname) do
                    local pro_stat = vgui.Create("DPanel", prosscroller)
                    pro_stat:SetSize(prosscroller:GetWide(), ARC9ScreenScale(9))
                    pro_stat:Dock(TOP)
                    pro_stat.text = stat
                    pro_stat.Paint = function(self2, w, h)
                        if !IsValid(self) then return end
                        surface.SetFont("ARC9_9")
                        surface.SetTextColor(ARC9.GetHUDColor("fg"))
                        surface.SetTextPos(ARC9ScreenScale(2), 0)
                        local tw = surface.GetTextSize(self2.text)
                        ARC9.DrawTextRot(self2, self2.text, ARC9ScreenScale(2), 0, ARC9ScreenScale(2), 0, ARC9ScreenScale(110), false)

                        local tw = surface.GetTextSize(prosnum[k])
                        ARC9.DrawTextRot(self2, prosnum[k], 0, 0, prosscroller:GetWide()-tw-ARC9ScreenScale(6), 0, w, true)
                    end
                end
            else
                lowerpanel.HasPros = nil
            end

            if table.Count(consname) > 0 then
                lowerpanel.HasCons = true
                for k, stat in ipairs(consname) do
                    local con_stat = vgui.Create("DPanel", consscroller)
                    con_stat:SetSize(consscroller:GetWide(), ARC9ScreenScale(9))
                    con_stat:Dock(TOP)
                    con_stat.text = stat
                    con_stat.Paint = function(self2, w, h)
                        if !IsValid(self) then return end
                        surface.SetFont("ARC9_9")
                        surface.SetTextColor(ARC9.GetHUDColor("fg"))
                        surface.SetTextPos(ARC9ScreenScale(2), 0)
                        local tw = surface.GetTextSize(self2.text)
                        ARC9.DrawTextRot(self2, self2.text, ARC9ScreenScale(2), 0, ARC9ScreenScale(2), 0, ARC9ScreenScale(110), false)

                        local tw = surface.GetTextSize(consnum[k])
                        ARC9.DrawTextRot(self2, consnum[k], 0, 0, consscroller:GetWide()-tw-ARC9ScreenScale(6), 0, w, true)
                    end
                end
            else
                lowerpanel.HasCons = nil
            end
        end

    end

    local arc9_atts_nocustomize = GetConVar("arc9_atts_nocustomize")
    local arc9_atts_lock = GetConVar("arc9_atts_lock")

    function SWEP:ReceiveWeapon()
        if SERVER and arc9_atts_nocustomize:GetBool() then return end

        local tbl = {}

        for i, k in pairs(self.Attachments or {}) do
            tbl[i] = self:ReceiveAttachmentTree()
        end

        if SERVER then

            if !self:ValidateInventoryForNewTree(tbl) then
                self:SendWeapon()
                return
            end

            if !arc9_atts_lock:GetBool() then
                local oldcount = self:CountAttsInTree(self.Attachments)
                local newcount = self:CountAttsInTree(tbl)

                for att, attc in pairs(newcount) do
                    local atttbl = ARC9.GetAttTable(att)

                    if atttbl.Free then continue end

                    local has = oldcount[att] or 0
                    local need = attc

                    if has < need then
                        local diff = need - has

                        ARC9:PlayerTakeAtt(self:GetOwner(), att, diff)
                    end
                end

                for att, attc in pairs(oldcount) do
                    local atttbl = ARC9.GetAttTable(att)
                    if !atttbl then ErrorNoHaltWithStack("The attachment trying to be installed doesn't exist. '" .. att .. "'") continue end
                    if atttbl.Free then continue end
                    if self:GetOwner().givingPreset == true then continue end

                    local has = attc
                    local need = newcount[att] or 0

                    if has > need then
                        local diff = has - need

                        ARC9:PlayerGiveAtt(self:GetOwner(), att, diff)
                    end
                end
            end

            self:GetOwner().givingPreset = false

        end

        self:BuildSubAttachments(tbl)

        if CLIENT then
            self:InvalidateCache()
            self:PruneAttachments()
            self:KillModel()
            self:SetupModel(true)
            self:SetupModel(false)
            self:RefreshCustomizeMenu()

            if !self.HasSightsPoseparam then -- fuck you
                if self:LookupPoseParameter("sights") != -1 then self.HasSightsPoseparam = true end
                if self:LookupPoseParameter("firemode") != -1 then self.HasFiremodePoseparam = true end
            end
        else
            self:InvalidateCache()
            -- self:PruneAttachments()
            self:FillIntegralSlots()
            self:SendWeapon()
            self:PostModify()

            ARC9:PlayerSendAttInv(self:GetOwner())
        end

        -- self:SetBaseSettings()
    end

    function SWEP:ValidateInventoryForNewTree(tree)

        local count = self:CountAttsInTree(tree)

        local currcount = self:CountAttsInTree(self.Attachments)

        for att, attc in pairs(count) do
            local atttbl = ARC9.GetAttTable(att)

            if atttbl.Free then continue end

            local has = (currcount[att] or 0) + ARC9:PlayerGetAtts(self:GetOwner(), att, self)
            local need = attc

            if has >= need then
                continue
            end

            return false
        end

        return true
    end

    local cancelmults = ARC9.CancelMultipliers[engine.ActiveGamemode()] or ARC9.CancelMultipliers[1]

    function SWEP:DoPrimaryAttack()

        if self.FireInterruptInspect and self:GetInspecting() then self:CancelInspect() end
        if self:StillWaiting() then return end
        if self.NoFireDuringSighting and (self:GetInSights() and self:GetSightAmount() < 0.8 or false) then return end

        local currentFiremode = self:GetCurrentFiremode()
        local burstCount = self:GetBurstCount()

        if currentFiremode > 0 and burstCount >= currentFiremode then return end

        local clip = self:GetLoadedClip()

        if self:GetProcessedValue("BottomlessClip", true) then
            self:RestoreClip(math.huge)
        end

        if !self:HasAmmoInClip() then
            if self:GetUBGL() and !self:GetProcessedValue("UBGLInsteadOfSights", true) then
                if self:GetMaxClip2() < 2 then -- mytton doesn't like auto ubgl reload
                    if self:CanReload() then
                        self:Reload()
                    else
                        self:ToggleUBGL(false)
                        self:SetNeedTriggerPress(true)
                        self:ExitSights()
                    end
                end

                return
            else
                self:DryFire()
                return
            end
        end

        if !self:GetProcessedValue("CanFireUnderwater", true) then
            if bit.band(util.PointContents(self:GetShootPos()), CONTENTS_WATER) == CONTENTS_WATER then
                self:DryFire()
                return
            end
        end

        self:SetBaseSettings()

        if self:RunHook("HookP_BlockFire") then return end

        if self:GetJammed() or self:GetHeatLockout() then
            self:DryFire()
            return
        end

        self:RunHook("Hook_PrimaryAttack")

        self:SetEmptyReload(false)
        self:TakeAmmo()

        local owner = self:GetOwner()

        if SERVER and IsValid(owner) and owner:IsPlayer() and !owner:CompareStatus(0) and !owner:CompareStatus(3) then

            owner:SetNWInt("ShotsFired", owner:GetNWInt("ShotsFired") + 1)
            owner:SetNWInt("RaidShotsFired", owner:GetNWInt("RaidShotsFired") + 1)

        end

        local triggerStartFireAnim = self:GetProcessedValue("TriggerStartFireAnim", true)
        local nthShot = self:GetNthShot()

        if self:GetProcessedValue("DoFireAnimation", true) and !triggerStartFireAnim then
            local anim = "fire"

            if self:GetProcessedValue("Akimbo", true) then
                if self:GetProcessedValue( "AkimboBoth", true) then
                    anim = "fire_both"
                elseif nthShot % 2 == 0 then
                    anim = "fire_right"
                else
                    anim = "fire_left"
                end
            end

            local banim = anim

            if !self.SuppressCumulativeShoot then
                for i = 1, burstCount + 1 do
                    if self:HasAnimation(anim .. "_" .. i, true) then
                        banim = anim .. "_" .. i
                    end
                end
            end

            self:PlayAnimation(banim, 1, false, true)
        end

        local clip1 = self:Clip1()

        self:SetLoadedRounds(clip1)

        local manualaction = self:GetProcessedValue("ManualAction", true)

        if !self:GetProcessedValue("NoShellEject", true) and !(manualaction and !self:GetProcessedValue("ManualActionEjectAnyway", true)) then
            local ejectdelay = self:GetProcessedValue("EjectDelay", true)

            if ejectdelay == 0 then
                self:DoEject()
            else
                self:SetTimer(ejectdelay, function()
                    self:DoEject()
                end)
            end
        end

        self:SetAfterShot(true)

        self:DoShootSounds()

        self:DoPlayerAnimationEvent(self:GetProcessedValue("AnimShoot", true))

        local delay = 60 / self:GetProcessedValue( "RPM")
        local time = CurTime()

        local curatt = self:GetNextPrimaryFire()
        local diff = time - curatt

        if diff > engine.TickInterval() or diff < 0 then
            curatt = time
        end

        self:SetNextPrimaryFire(curatt + delay)

        self:SetNthShot(nthShot + 1)

        self:DoEffects()

        if self:HoldingBreath() then
            self:SetBreath(math.max(0, self:GetBreath() - math.max(10, self:GetProcessedValue(  "HoldBreathTime", true) / 20)))
        end

        -- ewww
        if self:GetProcessedValue( "AkimboBoth", true) then
            self:SetNthShot(nthShot + 2)
            self:DoEffects()
            if !self:GetProcessedValue("NoShellEject", true) and !(manualaction and !self:GetProcessedValue("ManualActionEjectAnyway", true)) then
                local ejectdelay = self:GetProcessedValue("EjectDelay", true)
                if ejectdelay == 0 then
                    self:DoEject()
                else
                    self:SetTimer(ejectdelay, function()
                        self:DoEject()
                    end)
                end
            end
            self:SetNthShot(nthShot + 1)
        end

        if sp then
            if SERVER then
                self:CallOnClient("SInputRumble")
            end
        else
            if CLIENT then
                self:SInputRumble()
            end
        end

        local spread = self:GetProcessedValue("Spread")

        spread = math.Max(spread, 0)

        local sp, sa = self:GetShootPos()

        if IsValid(self:GetLockOnTarget()) and self:GetLockedOn() and self:GetProcessedValue("LockOnAutoaim", true) then
            sa = (self:GetLockOnTarget():EyePos() - sp):Angle()
        end

        self:DoProjectileAttack(sp, sa, spread)

        self:ApplyRecoil()
        self:DoVisualRecoil()

        if burstCount == 0 and currentFiremode > 1 and self:GetProcessedValue("RunawayBurst", true) then
            if !self:GetProcessedValue("AutoBurst", true) then
                self:SetNeedTriggerPress(true)
            end
        end

        if manualaction then
            nthShot = nthShot + 1
            if clip1 > 0 or !self:GetProcessedValue("ManualActionNoLastCycle", true) then
                if nthShot % self:GetProcessedValue("ManualActionChamber", true) == 0 then
                    self:SetNeedsCycle(true)
                end
            end
        end
        -- print("shot = " .. nthShot)

        if currentFiremode == 1 or clip == 0 then
            self:SetNeedTriggerPress(true)
        end

        self:DoHeat()

        if !self:GetUBGL() then
            if !manualaction or manualaction and !self.MalfunctionCycle then
                self:RollJam()
            end
        end

        if clip1 == 0 then
            self:SetNthShot(0)
        end

        if self:GetProcessedValue("TriggerDelayRepeat", true) and self:GetOwner():KeyDown(IN_ATTACK) and currentFiremode != 1 then
            self:SetTriggerDelay(time + self:GetProcessedValue("TriggerDelayTime"))
            if triggerStartFireAnim then
                self:PlayAnimation("fire")
            else
                self:PlayAnimation("trigger")
            end
            self:SetPrimedAttack(true)
        end

        self:SetBurstCount(burstCount + 1)
    end

    local runHook = {}
    local bodyDamageCancel = GetConVar("arc9_mod_bodydamagecancel")
    local arc9_npc_equality = GetConVar("arc9_npc_equality")

    local soundTab2 = {
        name = "impact"
    }

    function SWEP:AfterShotFunction(tr, dmg, range, penleft, alreadypenned, secondary)
        if !IsFirstTimePredicted() and !sp then return end

        local lastsecondary = self:GetUBGL()

        self:SetUBGL(secondary)

        dmg:SetDamageType(self:GetProcessedValue( "DamageType", true) or DMG_BULLET)

        local dmgv = self:GetDamageAtRange(range)
        local dmgvoriginal = dmgv

        runHook.tr = tr
        runHook.dmg = dmg
        runHook.range = range
        runHook.penleft = penleft
        runHook.alreadypenned = alreadypenned
        runHook.dmgv = dmgv

        self:RunHook("Hook_BulletImpact", runHook)

        -- Penetration
        local pen = self:GetProcessedValue( "Penetration", true)
        local pendeltaval = self:GetProcessedValue( "PenetrationDelta", true)
        if pen > 0 then
            local pendelta = penleft / pen
            pendelta = Lerp(pendelta, pendeltaval, 1) -- it arleady clamps inside
            dmgv = dmgv * pendelta
        end

        -- NPC damage nerf
        local owner = self:GetOwner()
        if owner:IsNPC() and !arc9_npc_equality:GetBool() then
            dmgv = dmgv * 0.25
        end

        -- Limb multipliers
        local traceEntity = tr.Entity
        local hitGroup = tr.HitGroup

        if SERVER and IsValid(owner) and owner:IsPlayer() and traceEntity:IsPlayer() and !owner:CompareStatus(0) and !owner:CompareStatus(3) then

            owner:SetNWInt("ShotsHit", owner:GetNWInt("ShotsHit") + 1)
            owner:SetNWInt("RaidShotsHit", owner:GetNWInt("RaidShotsHit") + 1)

        end

        if !ARC9.NoBodyPartsDamageMults then
            local bodydamage = self:GetProcessedValue( "BodyDamageMults", true)

            if bodydamage[hitGroup] then
                dmgv = dmgv * bodydamage[hitGroup]
            end
            if hitGroup == HITGROUP_HEAD then
                dmgv = dmgv * self:GetProcessedValue( "HeadshotDamage", true)
            elseif hitGroup == HITGROUP_CHEST then
                dmgv = dmgv * self:GetProcessedValue( "ChestDamage", true)
            elseif hitGroup == HITGROUP_STOMACH then
                dmgv = dmgv * self:GetProcessedValue( "StomachDamage", true)
            elseif hitGroup == HITGROUP_LEFTARM or hitGroup == HITGROUP_RIGHTARM then
                dmgv = dmgv * self:GetProcessedValue( "ArmDamage", true)
            elseif hitGroup == HITGROUP_LEFTLEG or hitGroup == HITGROUP_RIGHTLEG then
                dmgv = dmgv * self:GetProcessedValue( "LegDamage", true)
            end
        end

        -- Armor piercing (done after weapon's limb multipliers but BEFORE body damage cancel)
        local ap = math.Clamp(self:GetProcessedValue( "ArmorPiercing", true), 0, 1)
        if ap > 0 and !alreadypenned[traceEntity] then
            if traceEntity:GetClass() == "npc_helicopter" then
                local apdmg = DamageInfo()
                apdmg:SetDamage(dmgv * ap)
                apdmg:SetDamageType(DMG_AIRBOAT)
                apdmg:SetInflictor(dmg:GetInflictor())
                apdmg:SetAttacker(dmg:GetAttacker())

                if traceEntity.TakeDamageInfo then traceEntity:TakeDamageInfo(apdmg) end
            elseif traceEntity:GetClass() == "npc_gunship" or traceEntity:GetClass() == "npc_strider" then
                local apdmg = DamageInfo()
                apdmg:SetDamage(dmgv * ap)
                apdmg:SetDamageType(DMG_BLAST)
                apdmg:SetInflictor(dmg:GetInflictor())
                apdmg:SetAttacker(dmg:GetAttacker())

                if traceEntity.TakeDamageInfo then traceEntity:TakeDamageInfo(apdmg) end
            elseif traceEntity:IsPlayer() then
                if !ARC9.NoArmorPiercing then -- dumbass
                    local apdmg = math.ceil(dmgv * ap)
                    -- Delay health removal so that we can confirm the damage actually applied before removing health
                    dmg:SetDamageCustom(ARC9.DMG_CUST_AP)
                    traceEntity.ARC9APDamage = apdmg
                    -- traceEntity:SetHealth(traceEntity:Health() - apdmg)
                    dmgv = math.max(1, dmgv - apdmg)
                else
                    ARC9.LastArmorPiercedPlayer = traceEntity
                    ARC9.LastArmorPierceValue = ap
                    ARC9.LastArmorPiercedTime = CurTime()

                    traceEntity.ARC9APPower = pen
                    traceEntity.ARC9APDelta = pendeltaval
                    traceEntity.ARC9APRangeMult = dmgvoriginal / self:GetProcessedValue( "DamageMax", true)
                end
            end
        end

        -- Cancel out sandbox/ttt limb damage multipliers. Done last since AP damage does not go through this
        -- Lambda Players call ScalePlayerDamage and cancel out hitgroup damage... except on the head
        if bodyDamageCancel:GetBool() and cancelmults[hitGroup] and (!traceEntity.IsLambdaPlayer or hitgroup == HITGROUP_HEAD) then
            dmgv = dmgv / cancelmults[hitGroup]
        end

        dmg:SetDamage(dmgv)

        local hitPos = tr.HitPos
        local hitNormal = tr.HitNormal

        if self:GetProcessedValue( "ImpactDecal", true) then
            util.Decal(self:GetProcessedValue( "ImpactDecal", true), tr.StartPos, hitPos - (hitNormal * 2), owner)
        end

        if self:GetProcessedValue( "ImpactEffect", true) then
            local fx = EffectData()
            fx:SetOrigin(hitPos)
            fx:SetNormal(hitNormal)
            util.Effect(self:GetProcessedValue( "ImpactEffect", true), fx, true)
        end

        if self:GetProcessedValue( "ImpactSound", true) then
            soundTab2.sound = self:GetProcessedValue( "ImpactSound", true)

            soundTab2 = self:RunHook("HookP_TranslateSound", soundTab2) or soundTab2

            sound.Play(soundTab2.sound, hitPos, soundTab2.level, soundTab2.pitch, soundTab2.volume)
        end

        if self:GetProcessedValue( "ExplosionDamage") > 0 then
            util.BlastDamage(self, IsValid(owner) and owner or self, hitPos, self:GetProcessedValue( "ExplosionRadius", true), self:GetProcessedValue( "ExplosionDamage"))
        end

        if self:GetProcessedValue( "ExplosionEffect", true) then
            local fx = EffectData()
            fx:SetOrigin(hitPos)
            fx:SetNormal(hitNormal)
            fx:SetAngles(tr.HitNormal:Angle())

            if bit.band(util.PointContents(hitPos), CONTENTS_WATER) == CONTENTS_WATER then
                util.Effect("WaterSurfaceExplosion", fx, true)
            else
                util.Effect(self:GetProcessedValue( "ExplosionEffect", true), fx, true)
            end
        end

        if traceEntity and alreadypenned[traceEntity] then
            dmg:SetDamage(0)
        elseif traceEntity then
            alreadypenned[traceEntity] = true
        end

        self:Penetrate(table.Copy(tr), range, penleft, alreadypenned)

        self:SetUBGL(lastsecondary)
    end

    local ENTITY = FindMetaTable("Entity")
    local entityEmitSound = ENTITY.EmitSound

    function SWEP:PlayTranslatedSound(soundtab)
        soundtab = self:RunHook("HookP_TranslateSound", soundtab) or soundtab

        if soundtab and soundtab.sound then
            local pitch = soundtab.pitch

            if istable(pitch) then
                pitch = math.random(pitch[1], pitch[2])
            end

            local cfilter = nil
            local owner = self:GetOwner()
            if SERVER and !sp and IsValid(owner) and owner:IsPlayer() then

                if owner:CompareStatus(0) or owner:CompareStatus(3) then -- in the hideout/dueling

                    cfilter = CRF[1]

                elseif owner:CompareStatus(1) or owner:CompareStatus(2) then -- in a raid

                    cfilter = CRF[2]

                end

            end

            entityEmitSound(self,
                soundtab.sound,
                soundtab.level,
                pitch,
                soundtab.volume,
                soundtab.channel,
                soundtab.flags,
                soundtab.dsp,
                cfilter
            )
        end
    end

    -- weapon sounds
    local lsstr = "ShootSound"
    local lsslr = "LayerSound"
    local ldsstr = "DistantShootSound"

    local sstrSilenced = "ShootSoundSilenced"
    local sslrSilenced = "LayerSoundSilenced"
    local dsstrSilenced = "DistantShootSoundSilenced"

    local soundtab1 = {name = "shootsound"}
    local soundtab2 = {name = "shootlayer"}
    local soundtab3 = {name = "shootdistant"}
    local soundtab4 = {name = "shootsoundindoor"}
    local soundtab5 = {name = "shootlayerindoor"}
    local soundtab6 = {name = "shootdistantindoor"}

    function SWEP:DoShootSounds()
        local pvar = self:GetProcessedValue("ShootPitchVariation", true)
        local pvrand = math.Rand(-pvar, pvar) -- util.SharedRandom("ARC9_sshoot", -pvar, pvar) -- who gives a shit??? plus it broke af
        local randomChoice = self.RandomChoice

        local sstr = lsstr
        local sslr = lsslr
        local dsstr = ldsstr

        local silenced = self:GetProcessedValue("Silencer", true) and !self:GetUBGL()
        local indoor = self:GetIndoor()

        local indoormix = 1 - indoor
        local havedistant = self:GetProcessedValue(dsstr, true)

        if self:GetProcessedValue("Silencer", true) and !self:GetUBGL() then
            if self:GetProcessedValue(sstrSilenced, true) then
                sstr = sstrSilenced
            end
            if self:GetProcessedValue(sslrSilenced, true) then
                sslr = sslrSilenced
            end
            if havedistant and self:GetProcessedValue(dsstrSilenced, true) then
                dsstr = dsstrSilenced
            end
        end

        do
            local burstCountZero = self:GetBurstCount() == 0
            local sstrFirst = "First" .. sstr
            local dsstrFirst = "First" .. dsstr

            if burstCountZero and self:GetProcessedValue(sstrFirst, true) then
                sstr = sstrFirst
            end

            if havedistant and burstCountZero and self:GetProcessedValue(dsstrFirst, true) then
                dsstr = dsstrFirst
            end
        end

        local ss = randomChoice(self, self:GetProcessedValue(sstr, true))
        local sl = randomChoice(self, self:GetProcessedValue(sslr, true))
        local dss

        if havedistant then
            dss = randomChoice(self, self:GetProcessedValue(dsstr, true))
        end

        local svolume, spitch, svolumeactual = self:GetProcessedValue("ShootVolume", true), self:GetProcessedValue("ShootPitch", true) + pvrand, self:GetProcessedValue("ShootVolumeActual", true) or 1
        local dvolume, dpitch, dvolumeactual

        if havedistant then
            dvolume, dpitch, dvolumeactual = math.min(149, (self:GetProcessedValue("DistantShootVolume", true) or svolume) * 2), (self:GetProcessedValue("DistantShootPitch", true) or spitch) + pvrand, self:GetProcessedValue("DistantShootVolumeActual", true) or svolumeactual or 1
        end

        local volumeMix = svolumeactual * indoormix

        local hardcutoff = self.IndoorSoundHardCutoff and self.IndoorSoundHardCutoffRatio < indoor

        if hardcutoff then
            indoormix = 0
            indoor = 1
        elseif self.IndoorSoundHardCutoff then
            indoormix = 1
            indoor = 0
        end

        local playTranslatedSound = self.PlayTranslatedSound
        if indoormix > 0 then

            -- doing this cuz it uses only 1 cached table and it works way faster
            do
                soundtab1.sound = ss or ""
                soundtab1.level = svolume
                soundtab1.pitch = spitch
                soundtab1.volume = self.ShootSoundIndoor and volumeMix or 1
                soundtab1.channel = ARC9.CHAN_WEAPON
                -- soundtab1.networktoeveryone = true
            end

            playTranslatedSound(self, soundtab1)

            do
                soundtab2.sound = sl or ""
                soundtab2.level = svolume
                soundtab2.pitch = spitch
                soundtab2.volume = self.LayerSoundIndoor and volumeMix or 1
                soundtab2.channel = ARC9.CHAN_LAYER + 4
                -- soundtab2.networktoeveryone = true
            end

            playTranslatedSound(self, soundtab2)

            if havedistant then
                do
                    soundtab3.sound = dss or ""
                    soundtab3.level = dvolume
                    soundtab3.pitch = dpitch
                    soundtab3.volume = dvolume * indoormix
                    soundtab3.channel = ARC9.CHAN_DISTANT
                    soundtab3.networktoeveryone = true
                end

                playTranslatedSound(self, soundtab3)
            end
        end

        if indoor > 0 then
            local ssIN = randomChoice(self, self:GetProcessedValue(sstr .. "Indoor", true))
            local slIN = randomChoice(self, self:GetProcessedValue(sslr .. "Indoor", true))
            local dssIN = havedistant and randomChoice(self, self:GetProcessedValue(dsstr .. "Indoor", true))
            local indoorVolumeMix = svolumeactual * indoor


            do
                soundtab4.sound = ssIN or ""
                soundtab4.level = svolume
                soundtab4.pitch = spitch
                soundtab4.volume = indoorVolumeMix
                soundtab4.channel = ARC9.CHAN_INDOOR
                -- soundtab4.networktoeveryone = true
            end

            playTranslatedSound(self, soundtab4)

            do
                soundtab5.sound = slIN or ""
                soundtab5.level = svolume
                soundtab5.pitch = spitch
                soundtab5.volume = indoorVolumeMix
                soundtab5.channel = ARC9.CHAN_INDOOR + 7
                -- soundtab5.networktoeveryone = true
            end

            playTranslatedSound(self, soundtab5)

            if havedistant then
                do
                    soundtab6.sound = dssIN or ""
                    soundtab6.level = dvolume
                    soundtab6.pitch = dpitch
                    soundtab6.volume = dvolume * indoor
                    soundtab6.channel = ARC9.CHAN_INDOORDISTANT
                    soundtab6.networktoeveryone = true
                end

                playTranslatedSound(self, soundtab6)
            end
        end

        local ammo = self.Primary.Ammo

        if self:GetUBGL() then
            ammo = self.Secondary.Ammo
        end

        if SERVER then
            self:StartLoop()

            local attacker = self:GetOwner()
            if attacker:CompareStatus(0) or attacker:CompareStatus(3) then return end

            for k, v in pairs(player.GetHumans()) do
                if v:CompareStatus(0) or v:CompareStatus(3) then return end
                if shotCaliber[ammo] == nil then return end

                local shootPos = attacker:GetPos()
                local plyDistance = attacker:GetPos():Distance(v:GetPos())
                local bulletPitch = shotCaliber[ammo][1] or 100
                local threshold = shotCaliber[ammo][2] or 6000
                local style = shotCaliber[ammo][3] == "bullet" -- returns true if bullet, false if explosive
                local volume = 1

                if silenced then
                    volume = 0.3
                    bulletPitch = math.Clamp(math.Round(bulletPitch * 1.5), 0, 254)
                end

                if indoor > 0 then

                    volume = volume * 0.4

                end

                for i = 1, self.Num do
                    if plyDistance >= 2500 and v != attacker then
                        net.Start("DistantGunAudio")
                        net.WriteVector(shootPos)
                        net.WriteFloat(plyDistance)
                        net.WriteInt(bulletPitch, 9)
                        net.WriteInt(threshold, 16)
                        net.WriteFloat(volume)
                        net.WriteBool(style)
                        net.Send(v)
                    end
                end
            end
        end
    end

    if class != "arc9_eft_rshg2" then

        function SWEP:ThinkGrenade()
            if !self:GetProcessedValue("Throwable", true) then return end
            local owner = self:GetOwner()

            owner.ARC9QuickthrowPls = nil
            local QuicknadeBind = owner:KeyDown(IN_GRENADE1)

            if owner:CompareStatus(0) then return end

            if self:GetSafe() and owner:KeyPressed(IN_ATTACK) then self:ToggleSafety(false) return end

            if IsValid(self:GetDetonatorEntity()) then
                if owner:KeyPressed(IN_ATTACK) then
                    self:TouchOff()
                    return
                end
            end

            local fuse = self:GetProcessedValue("FuseTimer")

            if fuse >= 0 and self:GetGrenadePrimed() then
                local time = CurTime() - self:GetGrenadePrimedTime()

                if time >= fuse then
                    self:ThrowGrenade(ARC9.NADETHROWTYPE_EXPLODEINHANDS, 0)

                    if self:HasAnimation("explodeinhands") then
                        self:PlayAnimation("explodeinhands", 1, true)
                    else
                        self:PlayAnimation("throw", 1, true)
                    end
                end
            end

            local tossable = self:GetProcessedValue("Tossable", true) and self:HasAnimation("toss")

            if !self:GetGrenadePrimed() then
                if self:GetAnimLockTime() > CurTime() then return end

                local throwanimspeed = self:GetProcessedValue("ThrowAnimSpeed", true)
                if self:GetGrenadeRecovering() then
                    if self:GetProcessedValue("Disposable", true) and !IsValid(self:GetDetonatorEntity()) and SERVER and owner:GetNWBool("InRange", false) == false then
                        self:Remove()
                        -- owner:ConCommand("lastinv") -- switch to prev weapon
                    elseif self.WasThrownByBind then
                        self.WasThrownByBind = nil
                        self:Holster(owner:GetPreviousWeapon())
                        -- owner:ConCommand("lastinv") -- switch to prev weapon man we dont need dis shid!!
                    else
                        self:PlayAnimation("draw", throwanimspeed, true)
                        self:SetGrenadeRecovering(false)
                    end
                elseif ((tossable and owner:KeyDown(IN_ATTACK2)) or
                owner:KeyDown(IN_ATTACK)) and
                    (!owner:KeyDown(IN_USE) or !self:GetProcessedValue("PrimaryBash", true)) and
                    !IsValid(self:GetDetonatorEntity()) and !self:RunHook("HookP_BlockFire") 
                    then
                    self:SetGrenadePrimed(true)
                    self:SetGrenadePrimedTime(CurTime())

                    if owner:KeyDown(IN_ATTACK2) and self:HasAnimation("pullpin_toss") then
                        self:PlayAnimation("pullpin_toss", throwanimspeed, true)
                    else
                        self:PlayAnimation("pullpin", throwanimspeed, true)
                    end
                    self:SetGrenadeTossing(owner:KeyDown(IN_ATTACK2))
                end
            else
                if self:GetAnimLockTime() > CurTime() then return end

                if self:GetGrenadeTossing() and (!owner:KeyDown(IN_ATTACK2) or self:GetProcessedValue("ThrowInstantly", true)) then
                    local t = self:PlayAnimation("toss", throwanimspeed, true)
                    local mp = self:GetAnimationEntry("toss").MinProgress or 0
                    self:ThrowGrenade(ARC9.NADETHROWTYPE_TOSS, t * mp)
                elseif !self:GetGrenadeTossing() and (!(owner:KeyDown(IN_ATTACK) or QuicknadeBind) or self:GetProcessedValue("ThrowInstantly", true)) then
                    local t = self:PlayAnimation("throw", throwanimspeed, true)
                    local mp = self:GetAnimationEntry("throw").MinProgress or 0
                    self:ThrowGrenade(ARC9.NADETHROWTYPE_NORMAL, t * mp)
                end

                self:SetGrenadeRecovering(true)
            end
        end
    end

    if class != "arc9_eft_rshg2" then

        function SWEP:ThrowGrenade(nttype, delaytime)
            delaytime = delaytime or 0
            self:SetGrenadePrimed(false)

            self:TakeAmmo()

            self:DoPlayerAnimationEvent(self:GetProcessedValue("AnimShoot", true))

            if CLIENT then return end

            local time = math.huge
            local fusetimer = self:GetProcessedValue("FuseTimer")
            local forcemax = self:GetProcessedValue("ThrowForceMax")
            local forcemin = self:GetProcessedValue("ThrowForceMin")
            local forcetime = self:GetProcessedValue("ThrowChargeTime")

            time = CurTime() - self:GetGrenadePrimedTime()

            local force = forcemax

            if forcetime > 0 then
                force = forcemin + (forcemax - forcemin) * math.Clamp(time / forcetime, 0, 1)
            end

            local num = self:GetProcessedValue("Num")
            local ent = self:GetProcessedValue("ShootEnt")

            local owner = self:GetOwner()

            if owner:IsNPC() then
                -- ang = self:GetOwner():GetAimVector():Angle()
                spread = self:GetNPCBulletSpread()
            else
                spread = self:GetProcessedValue("Spread")
            end

            spread = math.Max(spread, 0)

            local override = {
                force = force,
                delay = delaytime,
            }
            self:RunHook("Hook_GrenadeThrown", override)

            force = override.force or force
            delaytime = override.delay or delaytime

            self:SetTimer(delaytime, function()

                local src, dir
                if self:GetProcessedValue("ThrowOnGround", true) then
                    src = owner:EyePos()
                    dir = Angle(0, owner:GetAngles().y, 0)

                    local shootposoffset = self:GetProcessedValue("ShootPosOffset", true)

                    local angRight = dir:Right()
                    local angForward = dir:Forward()
                    local angUp = dir:Up()

                    angRight:Mul(shootposoffset[1])
                    angForward:Mul(shootposoffset[2])
                    angUp:Mul(shootposoffset[3])

                    src:Add(angRight)
                    src:Add(angForward)
                    src:Add(angUp)

                    src, dir = self:GetRecoilOffset(src, dir)

                    local tr = util.TraceLine({
                        start = src,
                        endpos = src - Vector(0, 0, 64),
                        mask = MASK_SOLID,
                    })
                    src = tr.HitPos
                else
                    src, dir = self:GetShootPos()
                end

                local nades = {}
                for i = 1, num do
                    local nade = ents.Create(ent)

                    if !IsValid(nade) then return end
                    local dispersion = Angle(math.Rand(-1, 1), math.Rand(-1, 1), 0)

                    dispersion = dispersion * spread * 36

                    nade:SetPos(src)
                    nade:SetAngles(dir)
                    nade:SetOwner(owner)
                    nade:Spawn()

                    if fusetimer >= 0 then
                        nade.LifeTime = fusetimer - time
                    end

                    if nttype  == ARC9.NADETHROWTYPE_TOSS then
                        force = self:GetProcessedValue("TossForce", true)
                    elseif nttype == ARC9.NADETHROWTYPE_EXPLODEINHANDS then
                        force = 0
                        time = 0
                        nade:Detonate()
                    end

                    if self:GetProcessedValue("Detonator", true) then
                        self:SetDetonatorEntity(nade)
                    end

                    nade:SetPhysicsAttacker(self:GetOwner(), 600)

                    local phys = nade:GetPhysicsObject()

                    if IsValid(phys) then
                        if self:GetProcessedValue("ThrowTumble", true) then
                            nade:SetAngles(Angle(math.random(-180, 180), math.random(-180, 180), math.random(-180, 180)))
                            phys:AddAngleVelocity(Vector(math.random(-180, 180), math.random(-180, 180), math.random(-180, 180)))
                        end

                        if self:GetProcessedValue("ShootEntInheritPlayerVelocity") then
                            local vel = owner:GetVelocity()
                            local limit = self:GetProcessedValue("ShootEntInheritPlayerVelocityLimit")
                            if isnumber(limit) and limit > 0 and vel:Length() > limit then
                                vel = vel:GetNormalized() * limit
                            end
                            phys:SetVelocity(vel)
                        end

                        phys:AddVelocity((dir + dispersion):Forward() * force)
                    end

                    table.insert(nades, nade)
                end

                self:RunHook("Hook_GrenadeCreated", nades)
                ConsumeGrenade(owner)
                owner:SetNWInt("RaidGrenadesThrown", owner:GetNWInt("RaidGrenadesThrown") + 1)
                if owner:GetNWBool("InRange", false) == false then owner:StripWeapon(self.ClassName) end
            end)

        end

    end

end)

hook.Add("ARC9_PlayerGetAtts", "ARC9GetAtts", function(ply, att, wep)

    local inventory = {}

    if SERVER then

        inventory = ply.inventory
        if ply.givingPreset == true then return 999 end

    end

    if CLIENT then inventory = playerInventory end

    return AmountInInventory(inventory, "arc9_att_" .. att)

end)

hook.Add("ARC9_PlayerGiveAtt", "ARC9GiveAtt", function(ply, att, amt)

    local data = {}
    data.count = amt
    if SERVER then FlowItemToInventory(ply, "arc9_att_" .. att, EQUIPTYPE.Attachment, data) ReloadInventory(ply) return end

end)

hook.Add("ARC9_PlayerTakeAtt", "ARC9TakeAtt", function(ply, att, amt)

    local i = DeflowItemsFromInventory(ply, "arc9_att_" .. att, amt)
    ReloadInventory(ply)
    return i

end)

ARC9.KeyPressed_Menu = false

hook.Add("PlayerBindPress", "ARC9_Binds", function(ply, bind, pressed, code)
    local wpn = ply:GetActiveWeapon()

    if !wpn or !IsValid(wpn) or !wpn.ARC9 then return end

    if bind == "+menu_context" then
        if LocalPlayer():CompareStatus(3) then return end
        if !wpn:GetInSights() and !LocalPlayer():KeyDown(IN_USE) then

            ARC9.KeyPressed_Menu = pressed

            return true
        elseif wpn:GetInSights() and !LocalPlayer():KeyDown(IN_USE) then
            return true
        end
    end

    if !pressed then return end

    local plususe = ((ARC9.ControllerMode() and bind == "+zoom" and !LocalPlayer():KeyDown(IN_ZOOM)) -- Gamepad
                    or (!ARC9.ControllerMode() and bind == "+use" and !LocalPlayer():KeyDown(IN_USE)))


    if wpn:GetCustomize() then

        if bind == "impulse 100" then
            if wpn.CustomizeLastHovered and wpn.CustomizeLastHovered:IsHovered() then
                local att = wpn.CustomizeLastHovered.att
                ARC9:ToggleFavorite(att)
                if ARC9.Favorites[att] and wpn.BottomBarFolders["!favorites"] then
                    wpn.BottomBarFolders["!favorites"][att] = true
                elseif wpn.BottomBarFolders["!favorites"] then
                    wpn.BottomBarFolders["!favorites"][att] = nil
                end
            end
            return true
        end

        if bind == "+reload" then

            if !ply:CompareStatus(0) then return end

            if wpn.CustomizeLastHovered and wpn.CustomizeLastHovered:IsHovered() then
                local att = wpn.CustomizeLastHovered.att

                local efgmAtt = "arc9_att_" .. att
                local efgmItem = EFGMITEMS[efgmAtt]

                if efgmItem == nil then return end

                ply:ConCommand("efgm_gamemenu Market")
                timer.Simple(0.1, function() Menu.ConfirmPurchase(efgmAtt, "inv", true) end)
            end

            return true
        end

        if plususe then
            local attpnl = wpn.CustomizeLastHovered
            local addr

            local slotpnl2 = wpn.CustomizeLastHoveredSlot2

            if attpnl and attpnl:IsHovered() then
                addr = attpnl.address
            end

            if slotpnl2 and slotpnl2.fuckinghovered then
                addr = slotpnl2.Address
            end

            if addr then
                local atttbl = wpn:GetFinalAttTable(wpn:GetFilledMergeSlot(addr))

                if ((atttbl.ToggleStats and !atttbl.AdvancedCamoSupport) or (atttbl.AdvancedCamoSupport and wpn.AdvancedCamoCache)) then
                    wpn:EmitSound(wpn:RandomChoice(wpn:GetProcessedValue("ToggleAttSound", true)), 75, 100, 1, CHAN_ITEM)
                    wpn:ToggleStat(addr, input.IsKeyDown(KEY_LSHIFT) and -1 or 1)
                    wpn:PostModify()
                end
            end

            return true
        end
    else
        if plususe then
            return ARC9.AttemptGiveNPCWeapon()
        end

        if wpn:GetInSights() then
            if bind == "invnext" then
                wpn:Scroll(1)
                wpn.Peeking = false

                return true
            elseif bind == "invprev" then
                wpn:Scroll(-1)
                wpn.Peeking = false

                return true
            end
        end
    end

end)

if CLIENT then

    local ARC9ScreenScale = ARC9.ScreenScale
    local hoversound = "arc9/newui/uimouse_hover.ogg"

    local ARC9AttButton = {}
    ARC9AttButton.Color = ARC9.GetHUDColor("fg")
    ARC9AttButton.ColorBlock = ARC9.GetHUDColor("con")
    ARC9AttButton.Icon = Material("arc9/ui/settings.png", "mips")
    ARC9AttButton.MatIdle = Material("arc9/ui/att.png", "mips")
    ARC9AttButton.MatFolderBack = Material("arc9/ui/folder_back.png", "mips smooth")
    ARC9AttButton.MatFolderFront = Material("arc9/ui/folder_front.png", "mips smooth")
    ARC9AttButton.MatFolderFrontFav = Material("arc9/ui/folder_front_fav.png", "mips smooth")
    ARC9AttButton.MatFolderHeart = Material("arc9/ui/folder_heart.png", "mips smooth")
    ARC9AttButton.MatEmpty = Material("arc9/ui/att_empty.png", "mips")
    -- ARC9AttButton.MatHover = Material("arc9/ui/att_hover.png", "mips")
    ARC9AttButton.MatBlock = Material("arc9/ui/att_block.png", "mips")
    ARC9AttButton.MatMarkerInstalled = Material("arc9/ui/mark_installed.png", "mips smooth")
    ARC9AttButton.MatMarkerLock = Material("arc9/ui/mark_lock.png", "mips smooth")
    ARC9AttButton.MatMarkerLinked = Material("arc9/ui/mark_linked.png", "mips smooth")
    ARC9AttButton.MatMarkerModes = Material("arc9/ui/mark_modes.png", "mips smooth")
    ARC9AttButton.MatMarkerPaint = Material("arc9/ui/paint.png", "mips smooth")
    ARC9AttButton.MatMarkerSlots = Material("arc9/ui/mark_slots.png", "mips smooth")
    ARC9AttButton.MatMarkerFavorite = Material("arc9/ui/mark_favorite.png", "mips smooth")

    local ARC9TopButton = {}
    ARC9TopButton.Color = ARC9.GetHUDColor("fg")
    ARC9TopButton.ColorClicked = ARC9.GetHUDColor("hi")
    ARC9TopButton.ColorNotif = Color(255, 50, 50)
    ARC9TopButton.Icon = Material("arc9/ui/settings.png", "mips")
    ARC9TopButton.MatIdle = Material("arc9/ui/topbutton.png", "mips")
    ARC9TopButton.MatHovered = Material("arc9/ui/topbutton_hover.png", "mips")
    ARC9TopButton.MatIdleL = Material("arc9/ui/topbutton_l.png", "mips")
    ARC9TopButton.MatHoveredL = Material("arc9/ui/topbutton_hover_l.png", "mips")
    ARC9TopButton.MatIdleM = Material("arc9/ui/topbutton_m.png", "mips")
    ARC9TopButton.MatHoveredM = Material("arc9/ui/topbutton_hover_m.png", "mips")
    ARC9TopButton.MatIdleR = Material("arc9/ui/topbutton_r.png", "mips")
    ARC9TopButton.MatHoveredR = Material("arc9/ui/topbutton_hover_r.png", "mips")
    ARC9TopButton.MatNotif = Material("arc9/ui/info.png", "mips")

    function ARC9AttButton:Init()
        self:SetText("")
        self:SetSize(ARC9ScreenScale(42.7), ARC9ScreenScale(42.7 + 14.6))
    end

    function ARC9AttButton:Paint(w, h)
        local color = self.Color
        local iconcolor = self.Color
        local textcolor = self.Color
        local markercolor = self.Color
        local icon = self.Icon or ARC9TopButton.MatIdle
        local text = self.ButtonText
        local colorclicked = ARC9.GetHUDColor("hi")
        local colorgrey = ARC9.GetHUDColor("unowned")
        local mat = self.MatIdle
        local matmarker = nil
        local favmarker = nil
        local att = self.att
        local efgmAtt
        local efgmCanBuy = nil
        local efgmValue = nil
        local efgmLvl = nil
        local efgmWeight = nil

        if att != nil then

            efgmAtt = "arc9_att_" .. att
            efgmCanBuy = EFGMITEMS[efgmAtt].canPurchase or false
            efgmValue = EFGMITEMS[efgmAtt].value
            efgmLvl = EFGMITEMS[efgmAtt].levelReq or 1
            efgmWeight = EFGMITEMS[efgmAtt].weight

        end

        local qty = ARC9:PlayerGetAtts(LocalPlayer(), att, self.Weapon)
        local free_or_lock = false

        if self:IsHovered() or self.OverrideHovered then
            textcolor = colorclicked
        end

        if self.HasPaint then
            -- matmarker = self.MatMarkerPaint
        elseif self.HasModes then
            matmarker = self.MatMarkerModes
        elseif self.HasSlots then
            matmarker = self.MatMarkerSlots
        end

        if self.Empty then
            mat = self.MatEmpty
            if self.EmptyGreyOut then
                color = colorgrey
                iconcolor = colorgrey
            end
        elseif not self.CanAttach and not self.Installed then
            if self.MissingDependents then
                matmarker = self.MatMarkerLinked
            else
                matmarker = self.MatMarkerLock
            end
            mat = self.MatBlock
            textcolor = self.ColorBlock
            iconcolor = self.ColorBlock
            markercolor = self.ColorBlock
        elseif self:IsDown() or self.Installed then
            -- mat = self.MatHover
            color = colorclicked
            matmarker = self.MatMarkerInstalled
            markercolor = colorclicked
        elseif qty == 0 and not self.Installed and not self.SlotDisplay then
            color = (self:IsHovered() or self.OverrideHovered) and self.Color or colorgrey
            textcolor = color
            iconcolor = colorgrey
        end

        if ARC9.Favorites[att] then
            favmarker = self.MatMarkerFavorite
        end

        surface.SetDrawColor(color)
        surface.SetMaterial(mat)
        surface.DrawTexturedRect(0, 0, w, w)
        -- icon
        render.SuppressEngineLighting(true)
        surface.SetDrawColor(iconcolor)
        surface.SetMaterial(icon)
        render.SetAmbientLight(255, 255, 255)

        if not self.FullColorIcon then
            surface.DrawTexturedRect(ARC9ScreenScale(2), ARC9ScreenScale(2), w - ARC9ScreenScale(4), w - ARC9ScreenScale(4))
        else
            surface.DrawTexturedRect(ARC9ScreenScale(4), ARC9ScreenScale(4), w - ARC9ScreenScale(8), w - ARC9ScreenScale(8))
        end

        render.SuppressEngineLighting(false)
        render.SetLightingMode(0)

        if matmarker then
            surface.SetDrawColor(markercolor)
            surface.SetMaterial(matmarker)
            surface.DrawTexturedRect(ARC9ScreenScale(3), w - ARC9ScreenScale(11), ARC9ScreenScale(8), ARC9ScreenScale(8))
            -- surface.DrawTexturedRect(0, 0, w, w)
        end

        if favmarker then
            surface.SetDrawColor(markercolor)
            surface.SetMaterial(favmarker)
            surface.DrawTexturedRect(w - ARC9ScreenScale(11), ARC9ScreenScale(3), ARC9ScreenScale(8), ARC9ScreenScale(8))
        end

        if self.FolderContain then -- is folder
            surface.SetFont("ARC9_12")
            local tww = surface.GetTextSize(self.FolderContain)
            surface.SetTextColor(iconcolor)
            surface.SetTextPos((w - tww) / 2, h - ARC9ScreenScale(28))
            surface.DrawText(self.FolderContain)


            if self.FolderIcon1 and !self.FolderIcon2 then -- single icon
                surface.SetMaterial(self.FolderIcon1)
                surface.SetDrawColor(iconcolor) -- icon
                -- draw shadow here, idk how
                surface.DrawTexturedRectRotated(w/2, w/3.3, w/2*1.05, w/2*1.05, 0)
                surface.DrawTexturedRectRotated(w/2, w/3.3, w/2, w/2, 0)
            else
                if self.FolderIcon1 then
                    surface.SetMaterial(self.FolderIcon1)
                    surface.SetDrawColor(iconcolor) -- icon
                    -- draw shadow here, idk how
                    surface.DrawTexturedRectRotated(w/3.05, w/3.3, w/2.625*1.07, w/2.625*1.07, 20.4) -- 512/168, 512/155, 512/195
                    surface.DrawTexturedRectRotated(w/3.05, w/3.3, w/2.625, w/2.625, 20.4) -- 512/168, 512/155, 512/195
                end

                if self.FolderIcon2 then
                    surface.SetMaterial(self.FolderIcon2)
                    surface.SetDrawColor(iconcolor)
                    surface.DrawTexturedRectRotated(w/1.45, w/3.0, w/2.625*1.07, w/2.625*1.07, -18) -- 512/358, 512/155, 512/195
                    surface.DrawTexturedRectRotated(w/1.45, w/3.0, w/2.625, w/2.625, -18) -- 512/358, 512/155, 512/195
                end
            end

            surface.SetDrawColor(color)
            surface.SetMaterial(self.FolderFav and self.MatFolderFrontFav or self.MatFolderFront)
            surface.DrawTexturedRect(0, 0, w, w)

            if self.FolderFav then
                surface.SetDrawColor(colorclicked)
                surface.SetMaterial(self.MatFolderHeart)
                surface.DrawTexturedRect(0, 0, w, w)
            end
        end

        -- text
        surface.SetFont("ARC9_9")
        local tw = surface.GetTextSize(text)
        surface.SetTextColor(textcolor)

        -- print(textcolor)

        if tw > w then
            ARC9.DrawTextRot(self, text, 0, h - ARC9ScreenScale(13.5), 0, h - ARC9ScreenScale(13.5), w, false)
        else
            surface.SetTextPos((w - tw) / 2, h - ARC9ScreenScale(13.5))
            surface.DrawText(text)
            -- markup.Parse("<font=ARC9_9>" .. text):Draw((w - tw) / 2, h - ARC9ScreenScale(13.5), TEXT_ALIGN_LEFT, TEXT_ALIGN_LEFT)
        end

        if att then
            local atttbl = ARC9.GetAttTable(att)

            if atttbl.Free or GetConVar("arc9_free_atts"):GetBool() then
                free_or_lock = true
            end

            if GetConVar("arc9_atts_lock"):GetBool() then
                free_or_lock = true
            end

            if not free_or_lock and (qty > 0 or self.Installed) then

                local qtext = "x" .. tostring(qty)

                surface.SetFont("ARC9_9")
                local qtw = surface.GetTextSize(qtext)
                surface.SetTextColor(textcolor)

                surface.SetTextPos(w - qtw - ARC9ScreenScale(4), ARC9ScreenScale(1))
                surface.DrawText(qtext)
            end

            if self.Installed or qty > 0 then
            else
                surface.SetMaterial( ARC9AttButton.MatMarkerLock )
                surface.SetDrawColor( 255, 255, 255, 32 )

                local size = ARC9ScreenScale(12)
                surface.DrawTexturedRect(ARC9ScreenScale(8) - size/2, ARC9ScreenScale(8) - size/2, size, size )
            end

            if efgmCanBuy == false then return end

            if efgmValue != nil then

                local vtext = "₽" .. tostring(efgmValue)

                surface.SetFont("ARC9_6")
                local vtw = surface.GetTextSize(vtext)
                surface.SetTextColor(textcolor)

                surface.SetTextPos(w - vtw - ARC9ScreenScale(4), h - ARC9ScreenScale(22))
                surface.DrawText(vtext)

            end

            if efgmLvl != nil then

                local vtext = "Lvl " .. tostring(efgmLvl)

                surface.SetFont("ARC9_6")
                local vtw = surface.GetTextSize(vtext)
                surface.SetTextColor(textcolor)

                surface.SetTextPos(w - vtw - ARC9ScreenScale(4), h - ARC9ScreenScale(28))
                surface.DrawText(vtext)

            end

            if efgmWeight != nil then

                local vtext = efgmWeight .. "kg"

                surface.SetFont("ARC9_6")
                local vtw = surface.GetTextSize(vtext)
                surface.SetTextColor(textcolor)

                surface.SetTextPos(w - vtw - ARC9ScreenScale(4), h - ARC9ScreenScale(34))
                surface.DrawText(vtext)

            end
        end
    end

    function ARC9AttButton:OnCursorEntered()
        surface.PlaySound(hoversound)
    end

    function ARC9AttButton:SetIcon(mat)
        self.Icon = mat
    end

    function ARC9AttButton:SetButtonText(text)
        self.ButtonText = text
    end

    function ARC9AttButton:SetEmpty(bool)
        self.Empty = bool
    end

    function ARC9AttButton:SetEmptyGreyOut(bool)
        self.EmptyGreyOut = bool
    end

    function ARC9AttButton:SetOverrideHovered(bool)
        self.OverrideHovered = bool
    end

    function ARC9AttButton:SetInstalled(bool)
        self.Installed = bool
    end

    function ARC9AttButton:SetCanAttach(bool)
        self.CanAttach = bool
    end

    function ARC9AttButton:SetMissingDependents(bool)
        self.MissingDependents = bool
    end


    function ARC9AttButton:SetSlotDisplay(bool)
        self.SlotDisplay = bool
    end


    function ARC9AttButton:SetFolderContain(num)
        self.FolderContain = num
    end

    function ARC9AttButton:SetHasModes(bool)
        self.HasModes = bool
    end

    function ARC9AttButton:SetHasPaint(bool)
        self.HasPaint = bool
    end

    function ARC9AttButton:SetHasSlots(bool)
        self.HasSlots = bool
    end

    function ARC9AttButton:SetFullColorIcon(bool)
        self.FullColorIcon = bool
    end

    function ARC9AttButton:SetFolderIcon(id, mat, isfav)
        self.Icon = ARC9AttButton.MatFolderBack
        if id == 1 then self.FolderIcon1 = mat
        elseif id == 2 then self.FolderIcon2 = mat end

        if isfav then self.FolderFav = true end
    end

    vgui.Register("ARC9AttButton", ARC9AttButton, "DCheckBox") -- DButton

end