
local togglconvar = GetConVar("arc9_togglebreath")

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

    -- surely this is the last time right?
    function SWEP:HoldingBreath()
        if self:GetSightAmount() < 0.05 then self.IsHoldingBreath = false return end

        local ownerkeydownspeed = self:GetOwner():IsSprinting()

        if togglconvar:GetBool() then
            if ownerkeydownspeed and !lastpressed then
                self.IsHoldingBreath = !self.IsHoldingBreath
            end
        else
            self.IsHoldingBreath = ownerkeydownspeed
        end

        lastpressed = ownerkeydownspeed

        return self:CanHoldBreath() and self.IsHoldingBreath and (self:GetSightAmount() >= 1) and self:GetValue("HoldBreathTime") > 0
    end

    -- fix flashlight rendering for other players :steamcanny:
    function SWEP:DrawFlashlightsWM()
        local owner = self:GetOwner()
        local lp = LocalPlayer()

        if owner != lp then return end

        if !self.Flashlights then
            self:CreateFlashlights()
        end

        for i, k in ipairs(self.Flashlights) do
            local model = (k.slottbl or {}).WModel

            if !IsValid(model) then continue end

            local pos, ang

            if !model then
                pos = owner:EyePos()
                ang = owner:EyeAngles()
            else
                pos = model:GetPos()
                ang = model:GetAngles()
            end

            if k.qca then
                local a = model:GetAttachment(k.qca)
                if a then pos, ang = a.Pos, a.Ang end
            end

            self:DrawLightFlare(pos + Vector(0, 0, 0.001), ang, k.col, k.br * 20, i, nil, k.nodotter)

            if k.qca then ang:RotateAroundAxis(ang:Up(), 90) end

            local tr = util.TraceLine({
                start = pos,
                endpos = pos + ang:Forward() * 16,
                mask = MASK_OPAQUE,
                filter = lp,
            })
            if tr.Fraction < 1 then
                local tr2 = util.TraceLine({
                    start = pos,
                    endpos = pos - ang:Forward() * 16,
                    mask = MASK_OPAQUE,
                    filter = lp,
                })
                pos = pos + -ang:Forward() * 16 * math.min(1 - tr.Fraction, tr2.Fraction)
            else
                pos = tr.HitPos
            end

            k.light:SetPos(pos)
            k.light:SetAngles(ang)
            k.light:Update()
        end
    end
end)