local plyMeta = FindMetaTable("Player")
if not plyMeta then Error("Could not find player table") return end

function plyMeta:SetCrouched(value)
    self.Crouched = value
end

function plyMeta:GetCrouched()
    return self.Crouched
end

function plyMeta:SetEnteringCrouch(value)
    self.EnteringCrouch = value
end

function plyMeta:GetEnteringCrouch()
    return self.EnteringCrouch
end

function plyMeta:SetExitingCrouch(value)
    self.ExitingCrouch = value
end

function plyMeta:GetExitingCrouch()
    return self.ExitingCrouch
end

-- disable crouch jumping because of animation abuse + dynamic crouch toggling
hook.Add("StartCommand", "AdjustPlayerMovement", function(ply, cmd)
    local mvtype = ply:GetMoveType()
    if mvtype == MOVETYPE_NOCLIP then return end

    if cmd:KeyDown(IN_BACK) or (cmd:KeyDown(IN_MOVELEFT) or cmd:KeyDown(IN_MOVERIGHT)) and !cmd:KeyDown(IN_FORWARD) or cmd:KeyDown(IN_ATTACK2) then
        cmd:RemoveKey(IN_SPEED)
    end

    if timer.Exists(ply:SteamID64() .. "jumpCD") then
        cmd:RemoveKey(IN_JUMP)
    end

    if !ply:IsOnGround() then
        cmd:RemoveKey(IN_SPEED)
        if ply:GetNW2Int("jump_count", 0) > 1 then cmd:RemoveKey(IN_DUCK) end
        if ply:Crouching() then
            cmd:AddKey(IN_DUCK)
            ply:SetCrouched(true)
        elseif !ply:Crouching() and ply:GetCrouched() then
            cmd:RemoveKey(IN_DUCK)
        end
    else
        ply:SetCrouched(false)
    end

    if !ply:OnGround() then
        cmd:RemoveKey(IN_ATTACK2)
    end

    -- disable jumping/slow walking while crouching
    if ply:Crouching() or ply:GetEnteringCrouch(false) then
        cmd:RemoveKey(IN_JUMP)
        cmd:RemoveKey(IN_WALK)
    end
end)

local jumpFatigueReset = 1.1
local jumpFatigueMult = 0.825

-- jump viewpunch and fatigue
hook.Add("OnPlayerJump", "PlayerJump", function(ply, inWater, onFloater, speed)

    local ct = CurTime()
    local jumpCount = ply:GetNW2Int("jump_count", 1)

    if ct - ply:GetNW2Float("last_jump", 0) < jumpFatigueReset then

        jumpCount = jumpCount + 1

    else

        jumpCount = 1

    end

    ply:SetJumpPower(math.max(85, 140 * (jumpFatigueMult / jumpCount)))
    ply:SetNW2Int("jump_count", jumpCount)
    ply:SetNW2Float("last_jump", ct)

    if jumpCount > 1 then timer.Create(ply:SteamID64() .. "jumpCD", 0.8, 1, function() end) end

    timer.Create(ply:SteamID() .. "jumpReset", jumpFatigueReset, 1, function()

        if !IsValid(ply) then return end
        ply:SetJumpPower(140)
        ply:SetNW2Int("jump_count", 1)

    end)

    ply:ViewPunch(Angle(-1, 0, 0))

end)

-- jump cooldown
hook.Add("OnPlayerHitGround", "PlayerLand", function(ply, inWater, onFloater, speed)
    if speed > 50 then
        local ang = Angle(math.floor(math.exp(speed / 256)))
        if ang:Unpack() > 45 then
            ply:ViewPunch(Angle(45, 0, 0))
        else
            ply:ViewPunch(ang)
        end
    end
end )

-- leaning
local distance = 16
local leanSpeed = 1.5
local interp = 2
local maxLossLean = 0.6

local hull_size_5 = Vector(6.3, 6.3, 6.3)
local hull_size_5_negative = Vector(-6.3, -6.3, -6.3)

hook.Add("SetupMove", "Leaning", function(ply, mv, cmd)
    local mvtype = ply:GetMoveType()
    if mvtype == MOVETYPE_NOCLIP then return end

    local eyepos = ply:EyePos() - ply:GetNW2Vector("leaning_best_head_offset")
    local angles = cmd:GetViewAngles()

    local fraction = ply:GetNW2Float("leaning_fraction", 0)

    local leaning_left = ply:GetNW2Bool("leaning_left")
    local leaning_right = ply:GetNW2Bool("leaning_right")

    local speed = leanSpeed * math.min(1, 1 - math.min(maxLossLean, math.Round(math.max(0, ply:GetNWFloat("InventoryWeight", 0.00) - underweightLimit) * 0.0109, 2)))

    if !ply:IsSprinting() then
        if leaning_left then fraction = Lerp(FrameTime() * 5 * speed + FrameTime(), fraction, -1) end
        if leaning_right then fraction = Lerp(FrameTime() * 5 * speed + FrameTime(), fraction, 1) end
        if !leaning_left and !leaning_right then fraction = Lerp(FrameTime() * 5 * speed + FrameTime(), fraction, 0) end
    else
        fraction = Lerp(FrameTime() * 5 * speed + FrameTime(), fraction, 0)
        ply:SetNW2Var("leaning_left", false)
        ply:SetNW2Var("leaning_right", false)
    end

    if math.abs(fraction) <= 0.0001 then fraction = 0 end

    ply:SetNW2Float("leaning_fraction", fraction)

    local fraction_smooth = ply:GetNW2Float("leaning_fraction_smooth", 0)
    fraction_smooth = Lerp(FrameTime() * 10 + FrameTime(), fraction_smooth, fraction)
    if math.abs(fraction_smooth) <= 0.0001 then fraction_smooth = 0 end
    ply:SetNW2Float("leaning_fraction_smooth", fraction_smooth)

    local amount = fraction_smooth * distance
    local offsetang = Angle(angles:Unpack())
    offsetang.x = 0
    offsetang:RotateAroundAxis(offsetang:Forward(), amount)

    local offset = Vector(0, -amount, 0)
    offset:Rotate(offsetang)

    if math.abs(fraction_smooth) >= 0.0001 then
        local tr = util.TraceHull({
            start = eyepos,
            endpos = eyepos + offset,
            maxs = hull_size_5,
            mins = hull_size_5_negative,
            mask = MASK_BLOCKLOS,
            filter = ply
        })

        local best_offset = tr.HitPos - eyepos

        ply:SetNW2Vector("leaning_best_head_offset_last", ply:GetNW2Vector("leaning_best_head_offset"))
        ply:SetNW2Vector("leaning_best_head_offset", best_offset)

        local delta = ply:GetNW2Vector("leaning_best_head_offset") - ply:GetNW2Vector("leaning_best_head_offset_last")

        ply:SetCurrentViewOffset(ply:GetCurrentViewOffset() + delta)
        ply:SetViewOffset(vector_up * ply:GetNW2Float("leaning_height") + best_offset)
        ply:SetViewOffsetDucked(vector_up * ply:GetNW2Float("leaning_height_ducked") + best_offset)
    else
        ply:SetNW2Float("leaning_height", ply:GetViewOffset().z)
        ply:SetNW2Float("leaning_height_ducked", ply:GetViewOffsetDucked().z)
    end
end)

local function AngleOffset(new, old)
    local _, ang = WorldToLocal(vector_origin, new, vector_origin, old)
    return ang
end

local function LeanBones(ply, roll)
    if CLIENT then ply:SetupBones() end

    for _, bone_name in ipairs({"ValveBiped.Bip01_Spine", "ValveBiped.Bip01_Spine1", "ValveBiped.Bip01_Head1"}) do
        local bone = ply:LookupBone(bone_name)

        if !bone then continue end

        local ang
        local old_ang

        local matrix = ply:GetBoneMatrix(bone)

        if IsValid(matrix) then
            ang = matrix:GetAngles()
            old_ang = matrix:GetAngles()
        else
            _, ang = ply:GetBonePosition(bone)
            _, old_ang = ply:GetBonePosition(bone)
        end

        if bone_name != "ValveBiped.Bip01_Head1" then
            local eyeangles = ply:EyeAngles()
            eyeangles.x = 0
            local forward = eyeangles:Forward()
            ang:RotateAroundAxis(forward, roll)
        else
            local eyeangles = ply:EyeAngles()
            local forward = eyeangles:Forward()
            ang:RotateAroundAxis(forward, -roll)
        end

        ang = AngleOffset(ang, old_ang)
        ply:ManipulateBoneAngles(bone, ang, false)
    end
end

if SERVER then
    hook.Add("Think", "LeaningBend", function()

        for k, ply in ipairs(player.GetHumans()) do

            local absolute = math.abs(ply:GetNW2Float("leaning_fraction_smooth"))

            if absolute > 0 then ply.stop_leaning_bones = false end
            if ply.stop_leaning_bones then continue end

            LeanBones(ply, ply:GetNW2Float("leaning_fraction_smooth") * distance)

            if absolute == 0 then ply.stop_leaning_bones = true end

        end
    end)
end

if CLIENT then
    hook.Add("PreRender", "LeaningBend", function()
        for k, ply in ipairs(player.GetHumans()) do
            ply.leaning_fraction_true_smooth = Lerp(FrameTime() / (engine.TickInterval() * interp), ply.leaning_fraction_true_smooth or 0, ply:GetNW2Float("leaning_fraction_smooth") * distance)
            local absolute = math.abs(ply.leaning_fraction_true_smooth)

            if absolute <= 0.00001 then ply.leaning_fraction_true_smooth = 0 end
            if absolute > 0 then ply.stop_leaning_bones = false end
            if ply.stop_leaning_bones then continue end

            LeanBones(ply, ply.leaning_fraction_true_smooth)

            if absolute == 0 then ply.stop_leaning_bones = true end
        end
    end)

    local lerped_fraction = 0

    local last_realtime = 0
    local realtime = 0

    hook.Add("CalcView", "LeaningRoll", function(ply, origin, angles, fov, znear, zfar)
    	last_realtime = realtime
        realtime = SysTime()

        if realtime - last_realtime <= 0.00001 then return end

        lerped_fraction = Lerp(FrameTime() / (engine.TickInterval() * interp), lerped_fraction, ply:GetNW2Float("leaning_fraction_smooth", 0) * distance * 0.5)
        angles.z = angles.z + lerped_fraction
    end)

    local vm_last_realtime = 0
    local vm_realtime = 0

    hook.Add("CalcViewModelView", "LeaningRollVM", function(wep, vm, oldpos, oldang, pos, ang)
        vm_last_realtime = vm_realtime
        vm_realtime = SysTime()

        if vm_realtime - vm_last_realtime <= 0.00001 then return end
        ang.z = ang.z + lerped_fraction
    end)
end

-- inertia and bobbing (original code my datae)
local function SetInertia(ply, value)
    ply:SetNW2Float("inertia", value)
end

local function GetInertia(ply)
    return ply:GetNW2Float("inertia", 0)
end

local SP = game.SinglePlayer()
local LastAng = Angle()
local LerpedSway_Y = 0
local LerpedSway_X = 0
local LerpedSway_Tilt = 0
local LerpedAngX = 0

local requestedmove = false
local punchstop = false
local VBPos, VBAng = Vector(), Angle()
local VBPosCalc, VBAngCalc = Vector(), Angle()
local VBPosPre, VBAngPre = Vector(), Angle()
local VBPos2 = Vector()
local LerpedInertia = 0
local calcpos = Vector()

local UCT = CurTime()
local VBPosWeight, VBAngWeight = 1, 1

VBSightChecks = {
	["arc9_base"] = function(wep) return wep.dt and wep.dt.InSights end,
	["arc9_eft_base"] = function(wep) return wep.dt and wep.dt.InSights end
}
local VBSightChecks = VBSightChecks

hook.Add("CreateMove", "Inertia", function(cmd)
    local ply = LocalPlayer()
	if SP then
		requestedmove = math.abs(cmd:GetForwardMove()) + math.abs(cmd:GetSideMove()) > 0
	end
    local inertia = GetInertia(ply)

    if (ply:WaterLevel() < 2 or ply:OnGround()) then
        cmd:SetForwardMove(cmd:GetForwardMove() * (inertia + 0.06) * 0.09)
        cmd:SetSideMove(cmd:GetSideMove() * (inertia + 0.06) * 0.09)

        if math.abs(cmd:GetSideMove()) > 0 and math.abs(cmd:GetForwardMove()) > 0 then
            cmd:SetSideMove(cmd:GetSideMove() * 0.707)
            cmd:SetForwardMove(cmd:GetForwardMove() * 0.707)
        end
    end
end)

local maxLossMove = 45
hook.Add("Move", "MovementWeight", function(ply, mv)

    if !ply:Alive() then return end

    local deduction = math.max(0, math.min(maxLossMove, math.Round(math.max(0, ply:GetNWFloat("InventoryWeight", 0.00) - underweightLimit) * 0.818, 2)))

    ply:SetRunSpeed(220 - deduction)
    ply:SetWalkSpeed(135 - deduction)
    ply:SetLadderClimbSpeed(120 - deduction)
    ply:SetSlowWalkSpeed(95 - deduction)

    if !ply:IsOnGround() or CLIENT then return end

    if ply:KeyPressed(IN_DUCK) and !ply:Crouching() then
        ply:EmitSound("char_crouch_0" .. math.random(1, 6), 60, math.random(100, 110), 0.15, CHAN_AUTO)
    end

    if ply:KeyReleased(IN_DUCK) and ply:IsFlagSet(FL_ANIMDUCKING) then
        ply:EmitSound("char_stand_0" .. math.random(1, 6), 60, math.random(100, 110), 0.15, CHAN_AUTO)
    end

end)

local maxLossInertiaMult = 0.75
hook.Add("SetupMove", "VBSetupMove", function(ply, mv, cmd)
    local mvtype = ply:GetMoveType()
    if mvtype == MOVETYPE_NOCLIP then return end

    local vel = mv:GetVelocity():GetNormalized():Dot(ply:GetNW2Vector("VBLastDir"), vector_origin)

    if ply:OnGround() and vel < ((mv:KeyDown(IN_SPEED) and 0.99) or 0.998) and vel > 0 then
        SetInertia(ply, 0.06)
    end

    local deductionMult = 1 - math.max(0, math.min(maxLossInertiaMult, math.Round(math.max(0, ply:GetNWFloat("InventoryWeight", 0.00) - underweightLimit) * 0.0136, 2)))

    if math.abs(cmd:GetForwardMove()) + math.abs(cmd:GetSideMove()) > 0 then
        local target = (cmd:KeyDown(IN_WALK) and 0.04) or math.min(1 - 0.15 + 0.25, 1)
        local target_speed = (cmd:KeyDown(IN_WALK) and 0.85) or 0.125
        local sprintmult = ((cmd:KeyDown(IN_SPEED) and ply:WaterLevel() < 1) and 3.5) or 1
        SetInertia(ply, math.Approach(GetInertia(ply), target, (FrameTime() * target_speed * sprintmult * 1.33) * deductionMult))
    else
        SetInertia(ply, math.Approach(GetInertia(ply), 0, FrameTime() * deductionMult))
    end

    requestedmove = math.abs(cmd:GetForwardMove()) + math.abs(cmd:GetSideMove()) > 0

    local stept = ply:GetNW2Float("VMTime", 0) % 0.64

    if !ply:GetNW2Bool("DoStep", false) and stept < ply:GetNW2Float("LastVMTime") and ply:OnGround() and ply:GetMoveType() == MOVETYPE_WALK and mv:GetVelocity():Length() > 10 then
        ply:SetNW2Bool("DoStep", true)
        return
    end

    if ply:GetNW2Bool("DoStep", false) then
        if SERVER then ply:PlayStepSound(0.25) end
        ply:SetNW2Bool("DoStep", false)
        ply:SetNW2Float("LastVMTime", 0)

        return
    end

    ply:SetNW2Float("LastVMTime", stept)

    if ply:OnGround() then
        ply:SetNW2Vector("VBLastDir", mv:GetVelocity():GetNormalized())
    end

    local FT = FrameTime()

    if ply:OnGround() and ply:GetMoveType() == MOVETYPE_WALK then
        if mv:KeyDown(IN_SPEED) then
            FT = FT * 0.9
        end

        local runspeed = ply:GetWalkSpeed()
        local VMTime = ply:GetNW2Float("VMTime", 0)
        local mod = (VMTime % 0.625)

        if mod > 0.3125 then
            mod = -mod
        end

        local target = ply:GetNW2Float("VMTime",0) - mod
        local increment = (FT * (math.min(mv:GetVelocity():Length(), 300) / (runspeed * 0.75))) * 1

        ply:SetNW2Float("VMTime", VMTime + increment)

        if increment == 0 and VMTime != target then
            ply:SetNW2Float("VMTime", math.Approach(VMTime, target, FT * 0.625))
        end

    end

    if math.abs(cmd:GetForwardMove()) + math.abs(cmd:GetSideMove()) == 0 and ply:OnGround() and ply:GetMoveType() == MOVETYPE_WALK then
        mv:SetVelocity(mv:GetVelocity() * 0.9)
    end

end)

local math = math

local meta = FindMetaTable("Player")
local metavec = FindMetaTable("Vector")

local SP = game.SinglePlayer()

local DAMPING = 5
local SPRING_CONSTANT = 80

local function lensqr(ang)
    return (ang[1] ^ 2) + (ang[2] ^ 2) + (ang[3] ^ 2)
end

function metavec:Approach(x, y, z, speed)
    if !isnumber(x) then

		local vec = x
		speed = y
		x, y, z = vec:Unpack()

	end

	self[1] = math.Approach(self[1], x, speed)
	self[2] = math.Approach(self[2], y, speed)
	self[3] = math.Approach(self[3], z, speed)
end

local function VBSpringThink()
	local self = LocalPlayer()

	if !self.VBSpringVelocity or !self.VBSpringAngle then
		self.VBSpringVelocity = Angle()
		self.VBSpringAngle = Angle()
	end

	local vpa = self.VBSpringAngle
	local vpv = self.VBSpringVelocity

	if !self.VBSpringDone and lensqr(vpa) + lensqr(vpv) > 0.000001 then
		local FT = FrameTime()

		vpa = vpa + (vpv * FT)
		local damping = 1 - (DAMPING * FT)
		if damping < 0 then
			damping = 0
		end
		vpv = vpv * damping

		local springforcemagnitude = SPRING_CONSTANT * FT
		springforcemagnitude = math.Clamp(springforcemagnitude, 0, 2)
		vpv = vpv - (vpa * springforcemagnitude)

		vpa[1] = math.Clamp(vpa[1], -89.9, 89.9)
		vpa[2] = math.Clamp(vpa[2], -179.9, 179.9)
		vpa[3] = math.Clamp(vpa[3], -89.9, 89.9)

		self.VBSpringAngle = vpa
		self.VBSpringVelocity = vpv
	else
		self.VBSpringDone = true
	end
end

if CLIENT then
	hook.Add("Think", "VBSpring", VBSpringThink)
end

function meta:VBSpring(angle)
	if !self.VBSpringVelocity then return end
	local intensity = 20
	self.VBSpringVelocity:Add(angle * intensity)
	if !self.VBSpringVelocity then self.VBSpringVelocity = Angle() end

	local ang = self.VBSpringVelocity
	ang[1] = math.Clamp(ang[1], -180, 180)
	ang[2] = math.Clamp(ang[2], -180, 180)
	ang[3] = math.Clamp(ang[3], -180, 180)

	self.VBSpringDone = false
end

function meta:GetVBSpringAngles()
	return self.VBSpringAngle
end

local function GetSighted(wep)
	local sightfunc = VBSightChecks[wep.Base]

	if !sightfunc and wep.BaseClass then
		sightfunc = VBSightChecks[wep.BaseClass.Base]
	end

	return sightfunc and sightfunc(wep)
end

local function Sighted_Process(wep, FT)
	if GetSighted(wep) then
		VBPosWeight = math.Approach(VBPosWeight, 0.15, FT * 2)
		VBAngWeight = math.Approach(VBAngWeight, 0.05, FT * 2)
	else
		VBPosWeight = math.Approach(VBPosWeight, 1, FT)
		VBAngWeight = math.Approach(VBAngWeight, 1, FT)
	end
end

local SpringStop = Angle(0.0025,0,0)
local SpringSway = Angle()
local SpringTilt = Angle()
local SpringMove1, SpringMove2 = Angle(), Angle()

hook.Add("CalcViewModelView", "VBCalcViewModelView", function(wep, vm, oldpos, oldang, pos, ang)
	local ply = LocalPlayer()
	if !ply.VBSpringAngle then return end

    if type(wep.GetCustomize) == "function" and wep:GetCustomize() then return end

	local FT = (SP and FrameTime()) or RealFrameTime()

	pos:Set(oldpos)
	ang:Set(oldang)
	VBPosPre:Set(oldpos)
	VBAngPre:Set(oldang)

	VBPosCalc:Set(vector_origin)
	VBAngCalc:Set(angle_zero)

	local VMTime = ply:GetNW2Float("VMTime")

	if wep then
		Sighted_Process(wep, FT)
	end

	local runspeed = ply:GetWalkSpeed()
	local speedinertia = LocalPlayer():GetVelocity():Length()

	if speedinertia >= runspeed - 0.01 then
		punchstop = true
	elseif speedinertia <= 1 or GetSighted(wep) then
		punchstop = false
	end

	local walkmul = (ply:KeyDown(IN_WALK) and 2) or 1
	local walkmulintensity = (ply:KeyDown(IN_WALK) and 0.5) or 1
	local inertiamul = math.sin(((speedinertia / runspeed) * math.pi) * walkmul) * 0.04 * walkmulintensity

	if !requestedmove and punchstop then
		inertiamul = -(math.sin((speedinertia * math.pi / runspeed) * walkmul) * 0.0225 * walkmulintensity)
		ply:VBSpring(SpringStop)
	end

	LerpedInertia = Lerp(FT * 5, LerpedInertia, inertiamul)
	-- VBAngCalc.x = VBAngCalc.x + 10 * LerpedInertia
	VBAngCalc.z = VBAngCalc.z + 10 * LerpedInertia

    if !GetSighted(wep) then
	    VBPosCalc.z = VBPosCalc.z + 10 * LerpedInertia
    end

	local sway_y = math.Clamp(math.AngleDifference(LastAng.y, ang.y) * 0.5, -2.5, 2.5) * 0.5
	local sway_x = math.Clamp(math.AngleDifference(LastAng.x, ang.x), -2.5, 2.5) * 0.5

	local swayt_x = (sway_x == 0 and 6) or 4
	local swayt_y = (sway_y == 0 and 6) or 4

    LerpedSway_X = Lerp(FT * swayt_x, LerpedSway_X, sway_x)
    LerpedSway_Y = Lerp(FT * swayt_y, LerpedSway_Y, sway_y)
    SpringSway[1] = LerpedSway_X * -0.005
    SpringSway[2] = LerpedSway_Y * -0.01
    ply:VBSpring(SpringSway)

	local r = ang:Right()
	local up = ang:Up()
	local f = ang:Forward()

	local flipped = wep and wep.ViewModelFlip

	if flipped then
		r:Mul(-1)
		LerpedSway_X = 0
		LerpedSway_Y = 0
	end

	local sway_tilt = math.Clamp(r:Dot(LocalPlayer():GetVelocity() * 0.015), -10, 10)
	local swayt_tilt = (sway_tilt == 0 and 12) or 8

	if UCT != UnPredictedCurTime() then
		LerpedSway_Tilt = Lerp(FrameTime() * swayt_tilt, LerpedSway_Tilt, sway_tilt)
		SpringTilt[3] = LerpedSway_Tilt * 0.01
		ply:VBSpring(SpringTilt)
	end

	VBPosCalc:Add(up * math.sin(VMTime * 10) * 0.1)
	VBPosCalc:Add(r * math.sin(VMTime * 5) * 0.05)
	VBPosCalc:Sub(f * math.sin(VMTime * 5) * 0.15)

	VBAngCalc.z = VBAngCalc.z + math.sin(VMTime * 10) * 0.25
	-- VBAngCalc.x = VBAngCalc.x + math.abs(math.sin(VMTime * 5) * 0.425)

	VBAngCalc.y = (!flipped and VBAngCalc.y - LerpedSway_Y + math.abs(LerpedSway_X * 0.25)) or VBAngCalc.y + LerpedSway_Y - math.abs(LerpedSway_X * 0.25)

	VBAngCalc.z = VBAngCalc.z + LerpedSway_Tilt
	VBPosCalc.z = VBPosCalc.z + (LerpedSway_Tilt * 0.1)
	VBPosCalc:Sub(r * LerpedSway_Y * 0.5)
	VBPosCalc:Sub(up * LerpedSway_X * 0.5)

	if (!requestedmove and punchstop) or requestedmove and !GetSighted(wep) then
		local ang = VBAngCalc + ang
		SpringMove1[1] = (ang.x - oldang.x + LerpedSway_X) * -0.01
		SpringMove1[2] = (ang.y - oldang.y + LerpedSway_Y) * 0.1
		ply:VBSpring(SpringMove1)

		SpringMove2[2] = math.sin(VMTime * 5) * -0.005
		SpringMove2[3] = math.sin(VMTime * 5) * 0.0075 * (FT * 150)
		-- ply:VBSpring(SpringMove2)
	end

	VBPosCalc:Mul(VBPosWeight)
	VBAngCalc:Mul(VBAngWeight)

	pos:Add(VBPosCalc)
	ang:Add(VBAngCalc)

	VBPos:Set(pos)
	VBAng:Set(ang)

	VBPos2:Set(pos)
	VBPos2:Sub(up * math.min(LerpedAngX, 0) * 0.025)
	VBPos2:Sub(f * math.min(LerpedAngX, 45) * 0.025)

	ang:Add(ply.VBSpringAngle)

	LastAng:Set(oldang)

	ang.x = ang.x + (VBAng.x-VBAngPre.x) * 0.25

	pos:Sub(calcpos)

	UCT = UnPredictedCurTime()
end)

if CLIENT then
    local bobbing = GetConVar("efgm_visuals_headbob"):GetBool()

    hook.Add("CalcView","VBCalcView", function(ply,pos,ang)
        if bobbing then
            calcpos:Set(ang:Up() * ((VBAng.x-VBAngPre.x) * 3 + LerpedSway_X - math.abs(LerpedSway_Y * 0.15)))
            ang.x = ang.x + (VBAng.x-VBAngPre.x) * 0.25
        end

        pos:Sub(calcpos)
    end)

    cvars.AddChangeCallback("efgm_visuals_headbob", function(convar_name, value_old, value_new) if value_new == "1" then bobbing = true else bobbing = false end end)
end

local VBAngN = Angle()
local function BoneVB(ply, vm, m)
	local VBPunchAng = (stumbleamt == 0 and ply.VBSpringAngle) or angle_zero
	local rot = -(VBPunchAng + VBAngN)
	m:Rotate(rot)
end

local VBMF = false
local routecount = 0

local function ChildBones(vm, ply, boneid)
	if !boneid then return end
	if routecount > 1 then return end

	local parentm = vm:GetBoneParent(boneid)
	parentm = vm:GetBoneMatrix(parentm)

	local m = vm:GetBoneMatrix(boneid)
	if !m then return end

	BoneVB(ply, vm, m)

	if !VBMF then
		local p = (EyePos() - VBPos)
		local eyeang = EyeAngles()
		p = WorldToLocal(vector_origin, angle_zero, p, eyeang)
		p:Mul(-0.05)
		p[1] = math.abs(p[1]) * 10
		p[3] = p[1] * 0.5
		m:Translate(p)
		VBAngN:Mul(-1.25)
		VBAngN[3] = VBAngN[3] * 0.25
		VBAngN[1] = VBAngN[1] * 4
		VBMF = true
	end

	vm:SetBoneMatrix(boneid,m)
	local c = vm:GetChildBones(boneid)
	routecount = routecount + 1
	ChildBones(vm, ply, c[1])
end

hook.Add("PostDrawViewModel", "VBPostDrawViewModel", function(vm,ply,wep)
    if type(wep.GetCustomize) == "function" and wep:GetCustomize() then return end

	if !ply.VBSpringAngle then return end

	local arm = vm:LookupBone("ValveBiped.Bip01_L_Forearm")
	local eyeang = ply:EyeAngles()

	routecount = 0
	VBMF = false
	VBAngN:Set(VBAng - eyeang + ply.VBSpringAngle)
	VBAngN.x = VBAngN.x * -0.25
	VBAngN.z = VBAngN.z * 2.5
	ChildBones(vm, ply, arm)
end)