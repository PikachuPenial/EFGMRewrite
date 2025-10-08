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

            pos:Add(ang:Up() * (sprintoffset2 + 10) * 0.1 * lerrppp)
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
            self:SetClip1(0)
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
                        self:SetClip2(self:GetMaxClip2())
                        self.AlreadyGaveUBGLAmmo = true
                    end

                    if (self.LastUBGLAmmo) then
                        if (self.LastUBGLAmmo != self:GetValue("UBGLAmmo") or self.LastUBGLClipSize != self:GetValue("UBGLClipSize")) then
                            client:GiveAmmo(self:Clip2(), self.LastUBGLAmmo)
                            self:SetClip2(0)
                            self:SetRequestReload(true)
                        end
                    end

                    self.LastUBGLAmmo = self:GetValue("UBGLAmmo")
                    self.LastUBGLClipSize = self:GetValue("UBGLClipSize")

                    local capacity = self:GetCapacity(true)
                    if capacity > 0 and self:Clip2() > capacity then
                        client:GiveAmmo(self:Clip2() - capacity, self.LastUBGLAmmo)
                        self:SetClip2(capacity)
                    end
                end

                local capacity = self:GetCapacity(false)
                if capacity > 0 and self:Clip1() > capacity then
                    client:GiveAmmo(self:Clip1() - capacity, self.LastAmmo)
                    self:SetClip1(capacity)
                end

                if self:GetProcessedValue("BottomlessClip", true) then
                    self:RestoreClip()
                end
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

        if self:GetInfiniteAmmo() then
            return math.huge
        end

        return AmountInInventory(self:GetOwner(), self:GetValue("Ammo"))
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

            if !inf and IsValid(self:GetOwner()) then
                DeflowItemsFromInventory(self:GetOwner(), self.Secondary.Ammo, efgmdeduct)
                -- self:GetOwner():SetAmmo(reserve, self.Secondary.Ammo)
            end

            clip = self:Clip2()
        else
            lastclip = self:Clip1()
            local efgmdeduct = math.min(math.min(clip + amt, self:GetCapacity(false)), reserve) - lastclip

            self:SetClip1(math.min(math.min(clip + amt, self:GetCapacity(false)), reserve))

            reserve = reserve - self:Clip1()

            if !inf and IsValid(self:GetOwner()) then
                DeflowItemsFromInventory(self:GetOwner(), self.Primary.Ammo, efgmdeduct)
                -- self:GetOwner():SetAmmo(reserve, self.Primary.Ammo)
            end

            clip = self:Clip1()

            if !self.NoForceSetLoadedRoundsOnReload then -- sorry
                self:SetLoadedRounds(self:Clip1())
                self:SetLastLoadedRounds(self:Clip1())
            end
        end

        return clip - lastclip
    end

    function SWEP:Unload()
        if SERVER then
            local data = {}
            data.count = self:Clip1()
            FlowItemToInventory(self:GetOwner(), self.Ammo, EQUIPTYPE.Ammunition, data)
        end
        self:SetClip1(0)
        self:SetLoadedRounds(0)
    end

end)

hook.Add("ARC9_PlayerGetAtts", "ARC9GetAtts", function(ply, att, wep)

    return AmountInInventory(ply, "arc9_att_" .. att)

end)

hook.Add("ARC9_PlayerGiveAtt", "ARC9GiveAtt", function(ply, att, amt)

    local data = {}
    data.count = amt
    return FlowItemToInventory(ply, "arc9_att_" .. att, EQUIPTYPE.Attachment, data)

end)

hook.Add("ARC9_PlayerTakeAtt", "ARC9TakeAtt", function(ply, att, amt)

    return DeflowItemsFromInventory(ply, "arc9_att_" .. att, amt)

end)