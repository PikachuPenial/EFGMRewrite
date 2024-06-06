
if CLIENT then
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
    end)
end