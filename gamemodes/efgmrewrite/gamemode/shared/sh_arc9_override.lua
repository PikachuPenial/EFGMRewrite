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
                        self:SetClip2(self:GetMaxClip2())
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

                MatchWithEquippedAndUpdate(self:GetOwner(), self.ClassName, self.Attachments)

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

        return clip - lastclip
    end

    function SWEP:Unload()
        if SERVER then
            if self:GetOwner():GetNWBool("InRange", false) == false then
                local data = {}
                data.count = self:Clip1()
                FlowItemToInventory(self:GetOwner(), self.Ammo, EQUIPTYPE.Ammunition, data)
                -- self:GetOwner():GiveAmmo(self:Clip1(), self.Ammo, true)
            end
        end
        self:SetClip1(0)
        self:SetLoadedRounds(0)
    end

    function SWEP:ThinkGrenade()
        if !self:GetProcessedValue("Throwable", true) then return end
        local owner = self:GetOwner()

        owner.ARC9QuickthrowPls = nil
        local QuicknadeBind = owner:KeyDown(IN_GRENADE1)

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
                    owner:ConCommand("lastinv") -- switch to prev weapon
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

        if owner:GetNWBool("InRange", false) == false then

            ConsumeGrenade(self:GetOwner())
            timer.Simple(0.75, function() owner:ConCommand("lastinv") end)

        end

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
            if owner:GetNWBool("InRange", false) == false then owner:StripWeapon(self.ClassName) end
        end)

    end

end)

hook.Add("ARC9_PlayerGetAtts", "ARC9GetAtts", function(ply, att, wep)

    local inventory = {}
    if SERVER then inventory = ply.inventory end
    if CLIENT then inventory = playerInventory end

    return AmountInInventory(inventory, "arc9_att_" .. att)

end)

hook.Add("ARC9_PlayerGiveAtt", "ARC9GiveAtt", function(ply, att, amt)

    local data = {}
    data.count = amt
    if SERVER then return FlowItemToInventory(ply, "arc9_att_" .. att, EQUIPTYPE.Attachment, data) end

end)

hook.Add("ARC9_PlayerTakeAtt", "ARC9TakeAtt", function(ply, att, amt)

    return DeflowItemsFromInventory(ply, "arc9_att_" .. att, amt)

end)

ARC9.KeyPressed_Menu = false

local randsound = "arc9/newui/ui_part_randomize.ogg"

hook.Add("PlayerBindPress", "ARC9_Binds", function(ply, bind, pressed, code)
    local wpn = ply:GetActiveWeapon()

    if !wpn or !IsValid(wpn) or !wpn.ARC9 then return end

    if bind == "+menu_context" then
        if !wpn:GetInSights() and !LocalPlayer():KeyDown(IN_USE) then
            -- if wpn:GetCustomize() then
            --     surface.PlaySound("arc9/newui/ui_close.ogg")
            --     net.Start("ARC9_togglecustomize")
            --     net.WriteBool(false)
            --     net.SendToServer()
            --     -- wpn:DoIconCapture()
            -- else
            --     surface.PlaySound("arc9/newui/ui_open.ogg")
            --     net.Start("ARC9_togglecustomize")
            --     net.WriteBool(true)
            --     net.SendToServer()
            -- end

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
        if bind == "+showscores" then
            if ply:KeyDown(IN_USE) then
                wpn:CycleSelectedAtt(-1)
            else
                wpn:CycleSelectedAtt(1)
            end
            return true
        end

        if bind == "impulse 100" then
            if wpn.CustomizeLastHovered and wpn.CustomizeLastHovered:IsHovered() then
                local att = wpn.CustomizeLastHovered.att
                ARC9:ToggleFavorite(att)
                print(att)
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
                timer.Simple(0.1, function() Menu.ConfirmPurchase(efgmAtt, "inv") end)
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
end)

if CLIENT then

    local ARC9ScreenScale = ARC9.ScreenScale
    local hoversound = "arc9/newui/uimouse_hover.ogg"
    local clicksound = "arc9/newui/uimouse_click_forward.ogg"

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
        local efgmValue = nil

        if att != nil then

            efgmAtt = "arc9_att_" .. att
            efgmValue = EFGMITEMS[efgmAtt].value

        end

        local qty = ARC9:PlayerGetAtts(LocalPlayer(), att, self.Weapon)
        local free_or_lock = false

        if self:IsHovered() or self.OverrideHovered then
            textcolor = colorclicked
        end

        if self.HasPaint then
            matmarker = self.MatMarkerPaint
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

                local size = ARC9ScreenScale(14)
                surface.DrawTexturedRect(ARC9ScreenScale(21.5) - size/2, ARC9ScreenScale(21.5) - size/2, size, size )
            end

            if efgmValue != nil then

                local vtext = "₽" .. tostring(efgmValue)

                surface.SetFont("ARC9_6")
                local vtw = surface.GetTextSize(vtext)
                surface.SetTextColor(textcolor)

                surface.SetTextPos(w - vtw - ARC9ScreenScale(4), h - ARC9ScreenScale(22))
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