
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

    -- revert commit that fixed (i think) fixed leaning mods but then proceeded to break EFGM leaning

    if CLIENT then

        local rtsize = math.min(1024, ScrW(), ScrH())

        local rtmat = GetRenderTarget("arc9_pipscope", rtsize, rtsize, false)
        local rtmat_spare = GetRenderTarget("arc9_rtmat_spare", ScrW(), ScrH(), false)

        function SWEP:ShouldDoScope()

            if self:GetSight().Disassociate then return false end
            return true

        end

        function SWEP:DoRT(fov, atttbl)

            if ARC9.OverDraw then return end

            local rtpos, rtang = self:GetShootPos()
            local sighttbl = self:GetSight()
            local rtvm = true

            local rt = {
                x = 0,
                y = 0,
                w = rtsize,
                h = rtsize,
                angles = rtang,
                origin = rtpos,
                drawviewmodel = rtvm or false,
                fov = fov,
                znear = 16,
                zfar = 30000
            }

            ARC9.RTScopeRenderFOV = fov

            render.PushRenderTarget(rtmat, 0, 0, rtsize, rtsize)

            if self:ShouldDoScope() then

                ARC9.OverDraw = true
                ARC9.RTScopeRender = rtvm
                render.RenderView(rt)
                ARC9.RTScopeRender = false
                ARC9.OverDraw = false

                cam.Start3D(rtpos, rtang, fov, 0, 0, rtsize, rtsize)

                    cam.IgnoreZ(true)
                    self:DrawLasers(false, true)
                    cam.IgnoreZ(false)

                cam.End3D()

            else

                render.Clear(0, 0, 0, 255, true, true)

            end

            if atttbl.RTScopeFLIR then

                cam.Start3D(rtpos, rtang, fov, 0, 0, rtsize, rtsize, 16, 30000)

                self:DoFLIR(atttbl)

                cam.End3D()

            end

            if atttbl.RTScopeNightVision then self:DoNightScopeEffects(atttbl) end

            cam.Start3D(rtpos, rtang, fov, 0, 0, rtsize, rtsize, 16, 30000)

                self:DrawLockOnHUD(true)

            cam.End3D()

            self:DoRTScopeEffects()

            render.PopRenderTarget()

            if sighttbl.InvertColors then

                render.PushRenderTarget(rtmat, 0, 0, rtsize, rtsize)

                    render.CopyTexture(rtmat, rtmat_spare)

                    render.Clear(255, 255, 255, 255, true, true)
                    render.OverrideBlend(true, BLEND_ONE, BLEND_ONE, BLENDFUNC_REVERSE_SUBTRACT)

                    render.DrawTextureToScreen(rtmat_spare)

                    render.OverrideBlend(false)

                    if atttbl.RTScopePostInvertFunc then atttbl.RTScopePostInvertFunc(self) end

                render.PopRenderTarget()

            end

        end

    end

end)
