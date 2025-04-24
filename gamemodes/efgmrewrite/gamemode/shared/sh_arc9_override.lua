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
        local pvrand = math.Rand(-pvar, pvar)

        local sstr = lsstr
        local sslr = lsslr
        local dsstr = ldsstr

        local silenced = self:GetProcessedValue("Silencer", true) and !self:GetUBGL()
        local indoor = self:GetIndoor()

        local indoormix = 1 - indoor
        local havedistant = self:GetProcessedValue(dsstr, true)

        if silenced and self:GetProcessedValue(sstrSilenced, true) then
            sstr = sstrSilenced
        end

        if silenced and self:GetProcessedValue(sslrSilenced, true) then
            sslr = sslrSilenced
        end

        if havedistant and silenced and self:GetProcessedValue(dsstrSilenced, true) then
            dsstr = dsstrSilenced
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

        local ss = self:RandomChoice(self:GetProcessedValue(sstr, true))
        local sl = self:RandomChoice(self:GetProcessedValue(sslr, true))
        local dss

        if havedistant then
            dss = self:RandomChoice(self:GetProcessedValue(dsstr, true))
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

        if indoormix > 0 then

            do
                soundtab1.sound = ss or ""
                soundtab1.level = svolume
                soundtab1.pitch = spitch
                soundtab1.volume = volumeMix
                soundtab1.channel = ARC9.CHAN_WEAPON
            end

            self:PlayTranslatedSound(soundtab1)

            do
                soundtab2.sound = sl or ""
                soundtab2.level = svolume
                soundtab2.pitch = spitch
                soundtab2.volume = volumeMix
                soundtab2.channel = ARC9.CHAN_LAYER + 4
            end

            self:PlayTranslatedSound(soundtab2)

            if havedistant then
                do
                    soundtab3.sound = dss or ""
                    soundtab3.level = dvolume
                    soundtab3.pitch = dpitch
                    soundtab3.volume = dvolume * indoormix
                    soundtab3.channel = ARC9.CHAN_DISTANT
                end

                self:PlayTranslatedSound(soundtab3)
            end
        end

        if indoor > 0 then
            local ssIN = self:RandomChoice(self:GetProcessedValue(sstr .. "Indoor", true))
            local slIN = self:RandomChoice(self:GetProcessedValue(sslr .. "Indoor", true))
            local dssIN = havedistant and self:RandomChoice(self:GetProcessedValue(dsstr .. "Indoor", true))
            local indoorVolumeMix = svolumeactual * indoor

            do
                soundtab4.sound = ssIN or ""
                soundtab4.level = svolume
                soundtab4.pitch = spitch
                soundtab4.volume = indoorVolumeMix
                soundtab4.channel = ARC9.CHAN_INDOOR
            end

            self:PlayTranslatedSound(soundtab4)

            do
                soundtab5.sound = slIN or ""
                soundtab5.level = svolume
                soundtab5.pitch = spitch
                soundtab5.volume = indoorVolumeMix
                soundtab5.channel = ARC9.CHAN_INDOOR + 7
            end

            self:PlayTranslatedSound(soundtab5)

            if havedistant then
                do
                    soundtab6.sound = dssIN or ""
                    soundtab6.level = dvolume
                    soundtab6.pitch = dpitch
                    soundtab6.volume = indoor
                    soundtab6.channel = ARC9.CHAN_INDOORDISTANT
                end

                self:PlayTranslatedSound(soundtab6)
            end
        end

        if SERVER then
            for k, v in pairs(player.GetAll()) do
                if shotCaliber[self:GetPrimaryAmmoType()] == nil then return end

                local attacker = self:GetOwner()
                local shootPos = attacker:GetPos()
                local plyDistance = attacker:GetPos():Distance(v:GetPos())
                local bulletPitch = shotCaliber[self:GetPrimaryAmmoType()][1] or 100
                local threshold = shotCaliber[self:GetPrimaryAmmoType()][2] or 6000
                local style = shotCaliber[self:GetPrimaryAmmoType()][3] == "bullet" -- returns true if bullet, false if explosive
                local volume = 1

                if silenced then
                    volume = 0.3
                    bulletPitch = math.Round(bulletPitch * 1.5)
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

        self:StartLoop()
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
end)
