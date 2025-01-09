
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

        if (self:GetAnimLockTime() > CurTime()) and self:GetProcessedValue("NoSprintWhenLocked", true) then
            return false
        end

        if self:GetProcessedValue("ShootWhileSprint", true) and owner:KeyDown(IN_ATTACK) then
            return false
        end

        if self:GetGrenadePrimed() then
            return false
        end

        if owner:Crouching() then return false end

        return true

    end

    -- take a wild guess
    function SWEP:GetIsWalking()
        local owner = self:GetOwner()

        if !owner:IsValid() or owner:IsNPC() then
            return false
        end

        if owner:KeyDown(IN_SPEED) then return false end
        if owner:IsSprinting() then return false end
        if !owner:KeyDown(IN_FORWARD + IN_BACK + IN_MOVELEFT + IN_MOVERIGHT) then return false end

        local curspeed = owner:GetVelocity():LengthSqr()
        if curspeed <= 0 then return false end

        return true

    end

    -- i wanted to tweak the weapon bobbing

    local smoothsidemove = 0
    local smoothjumpmove = 0

    local function ArcticBreadDarsuBob(self, pos, ang)

        local step = 10
        local mag = 1
        local ts = 0
        if self:GetCustomize() then return pos, ang end

        local owner = self:GetOwner()
        local ft = FrameTime()

        local sharedmult = self:GetIsSprinting() and self:GetProcessedValue("BobSprintMult", true) or self:GetProcessedValue("BobWalkMult", true)
        local velocityangle = owner:GetVelocity()
        local v = velocityangle:Length()
        v = math.Clamp(v, 0, 350)
        self.ViewModelBobVelocity = math.Approach(self.ViewModelBobVelocity, v, ft * 10000)
        local d = math.Clamp(self.ViewModelBobVelocity / 350, 0, 1)

        if owner:OnGround() and owner:GetMoveType() != MOVETYPE_NOCLIP then

            self.ViewModelNotOnGround = math.Approach(self.ViewModelNotOnGround, 0, ft / 0.1)
        else

            self.ViewModelNotOnGround = math.Approach(self.ViewModelNotOnGround, 1, ft / 0.1)
        end

        local sightamount = self:GetSightAmount() - (self.Peeking and 0.78 or 0.16)

        d = d * Lerp(sightamount, 1,0.03) * Lerp(ts, 1, 1.5)
        mag = d * 2
        mag = mag * Lerp(ts, 1, 2)
        step = 9.25

        local sidemove = (owner:GetVelocity():Dot(owner:EyeAngles():Right()) / owner:GetMaxSpeed()) * 4 * (1.5-sightamount)
        smoothsidemove = Lerp(math.Clamp(ft * 8, 0, 1), smoothsidemove, sidemove)

        local crouchmult = 1
        if owner:Crouching() then

            crouchmult = 3.5 + sightamount * 3
            step = 6

        end

        local jumpmove = math.Clamp(math.ease.InExpo(math.Clamp(velocityangle.z, -150, 0) / -150) * 0.5 + math.ease.InExpo(math.Clamp(velocityangle.z, 0, 350)/350)*-50, -4, 2.5) * 0.5   -- crazy math for jump movement
        smoothjumpmove = Lerp(math.Clamp(ft * 8, 0, 1), smoothjumpmove, jumpmove)
        local smoothjumpmove2 = math.Clamp(smoothjumpmove, -0.3, 0.01) * (1.5 - sightamount) * 2

        if self:GetIsSprinting() then

            pos = pos - (ang:Up() * math.sin(self.BobCT * step) * 0.45 * ((math.sin(self.BobCT * 3.515) * 0.2) + 1) * mag * sharedmult)
            pos = pos + (ang:Forward() * math.sin(self.BobCT * step * 0.3) * 0.13 * ((math.sin(self.BobCT * 2) * ts * 1.25) + 2) * ((math.sin(self.BobCT * 0.615) * 0.2) + 2) * mag * sharedmult)
            pos = pos + (ang:Right() * (math.sin(self.BobCT * step * 0.5) + (math.cos(self.BobCT * step * 0.5))) * 0.55 * mag * sharedmult)
            ang:RotateAroundAxis(ang:Forward(), math.sin(self.BobCT * step * 0.5) * ((math.sin(self.BobCT * 6.151) * 0.2) + 1) * 9 * d * sharedmult + smoothsidemove * 1.5)
            ang:RotateAroundAxis(ang:Right(), math.sin(self.BobCT * step * 0.12) * ((math.sin(self.BobCT * 1.521) * 0.2) + 1) * 1 * d * sharedmult)
            ang:RotateAroundAxis(ang:Up(), math.sin(self.BobCT * step * 0.5) * ((math.sin(self.BobCT * 1.521) * 0.2) + 1) * 6 * d * sharedmult)
            ang:RotateAroundAxis(ang:Right(), smoothjumpmove2 * 5)

        else

            pos = pos - (ang:Up() * math.sin(self.BobCT * step) * 0.1 * ((math.sin(self.BobCT * 3.515) * 0.2) + 1.5) * mag * (crouchmult / 2) * sharedmult) - (ang:Up() * smoothsidemove * -0.05) - (ang:Up() * smoothjumpmove2 * 0.2)
            pos = pos + (ang:Forward() * math.sin(self.BobCT * step * 0.3) * 0.11 * ((math.sin(self.BobCT * 2) * ts * 1.25) + 1) * ((math.sin(self.BobCT * 0.615) * 0.2) + 1) * mag * sharedmult)
            pos = pos + (ang:Right() * (math.sin(self.BobCT * step * 0.5) + (math.cos(self.BobCT * step * 0.5))) * 0.2 * mag * sharedmult)
            ang:RotateAroundAxis(ang:Forward(), math.sin(self.BobCT * step * 0.5) * ((math.sin(self.BobCT * 6.151) * 0.2) + 1) * 5 * d * sharedmult + smoothsidemove)
            ang:RotateAroundAxis(ang:Right(), math.sin(self.BobCT * step * 0.12) * ((math.sin(self.BobCT * 1.521) * 0.2) + 1) * 0.1 * d * sharedmult)
            ang:RotateAroundAxis(ang:Right(), smoothjumpmove2 * 5)

        end

        local steprate = Lerp(d, 1, 2.75)
        steprate = Lerp(self.ViewModelNotOnGround, steprate, 0.75)

        if IsFirstTimePredicted() or game.SinglePlayer() then

            self.BobCT = self.BobCT + (ft * steprate)

        end

        return pos, ang

    end

    function SWEP:GetViewModelBob(pos, ang)

        self.SwayScale = 0
        self.BobScale = 0

        return ArcticBreadDarsuBob(self, pos, ang)

    end

    -- same w/ sway this time

    local lasteyeang = Angle()
    local smootheyeang = Angle()
    local smoothswayroll = 0

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

end)
