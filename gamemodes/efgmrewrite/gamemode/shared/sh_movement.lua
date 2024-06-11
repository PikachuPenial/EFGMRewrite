
-- disable crouch jumping because of animation abuse + dynamic crouch toggling
hook.Add("StartCommand", "AdjustPlayerMovement", function(ply, cmd)

	if cmd:KeyDown(IN_BACK) or (cmd:KeyDown(IN_MOVELEFT) or cmd:KeyDown(IN_MOVERIGHT)) and !cmd:KeyDown(IN_FORWARD) or cmd:KeyDown(IN_ATTACK2) then
		cmd:RemoveKey(IN_SPEED)
	end

	if timer.Exists(ply:SteamID64() .. "jumpCD") then
		cmd:RemoveKey(IN_JUMP)
	end

	if !ply:OnGround() then
		cmd:RemoveKey(IN_ATTACK2)
	end

end)

-- reduce velocity upon landing to prevent bunny hopping
hook.Add("OnPlayerHitGround", "VelocityLimiter", function(ply) 

	local vel = ply:GetVelocity()
	ply:SetVelocity(Vector(-vel.x / 2, -vel.y / 2, 0))
	timer.Create(ply:SteamID64() .. "jumpCD", 0.75, 1, function() end)

end )

-- leaning
local distance = 16
local speed = 2
local interp = 2

local hull_size_5 = Vector(5, 5, 5)
local hull_size_5_negative = Vector(-5, -5, -5)

local binds = {
	{"_cl_lean_right_key_hold", "Lean Right (Hold)", "leaning_right", "hold"},
	{"_cl_lean_left_key_hold", "Lean Left (Hold)", "leaning_left", "hold"},

	{"_cl_lean_right_key_toggle", "Lean Right (Toggle)", "leaning_right", "toggle"},
	{"_cl_lean_left_key_toggle", "Lean Left (Toggle)", "leaning_left", "toggle"},
}

hook.Add("PlayerButtonDown", "leaning_keys", function(ply, button)
    for i, data in ipairs(binds) do
        local info_name = data[1]
        local pretty_name = data[2]
        local network_name = data[3]
        local typee = data[4]

        local need_to_press = ply:GetInfoNum(info_name, -1)

        if button == need_to_press then
            if typee == "hold" then
                ply:SetNW2Var(network_name, true)
            end

            if typee == "toggle" then
                local state = not ply:GetNW2Var(network_name, false)
                ply:SetNW2Var(network_name, state)

                for j, j_data in ipairs(binds) do
                    if j_data[4] == "toggle" and network_name != j_data[3] then
                        ply:SetNW2Var(j_data[3], false)
                    end
                end
            end
        end
    end
end)

hook.Add("PlayerButtonUp", "leaning_keys", function(ply, button)
    for i, data in ipairs(binds) do
        local info_name = data[1]
        local pretty_name = data[2]
        local network_name = data[3]
        local typee = data[4]

        local need_to_press = ply:GetInfoNum(info_name, -1)

        if button == need_to_press then
            if typee == "hold" then ply:SetNW2Var(network_name, false) end
        end
    end
end)

hook.Add("SetupMove", "leaning_main", function(ply, mv, cmd)
    local eyepos = ply:EyePos() - ply:GetNW2Vector("leaning_best_head_offset")
    local angles = cmd:GetViewAngles()

    local fraction = ply:GetNW2Float("leaning_fraction", 0)

    local leaning_left = ply:GetNW2Bool("leaning_left")
    local leaning_right = ply:GetNW2Bool("leaning_right")

    if leaning_left then
        fraction = Lerp(FrameTime() * 5 * speed + FrameTime(), fraction, -1)
    end

    if leaning_right then
        fraction = Lerp(FrameTime() * 5 * speed + FrameTime(), fraction, 1)
    end

    if not leaning_left and not leaning_right then
        fraction = Lerp(FrameTime() * 5 * speed + FrameTime(), fraction, 0)
    end

    if math.abs(fraction) <= 0.0001 then
        fraction = 0
    end

    ply:SetNW2Float("leaning_fraction", fraction)

    local fraction_smooth = ply:GetNW2Float("leaning_fraction_smooth", 0)
    fraction_smooth = Lerp(FrameTime() * 10 + FrameTime(), fraction_smooth, fraction)
    if math.abs(fraction_smooth) <= 0.0001 then
        fraction_smooth = 0
    end
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

local function angle_offset(new, old)
    local _, ang = WorldToLocal(vector_origin, new, vector_origin, old)

    return ang
end

local function lean_bones(ply, roll)
    if CLIENT then ply:SetupBones() end

    for _, bone_name in ipairs({"ValveBiped.Bip01_Spine", "ValveBiped.Bip01_Spine1", "ValveBiped.Bip01_Head1"}) do
        local bone = ply:LookupBone(bone_name)

        if not bone then continue end

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

        ang = angle_offset(ang, old_ang)

        ply:ManipulateBoneAngles(bone, ang, false)
    end
end

if SERVER then
    hook.Add("Think", "leaning_bend", function()
        for k, ply in ipairs(player.GetAll()) do
            local absolute = math.abs(ply:GetNW2Float("leaning_fraction_smooth"))

            if absolute > 0 then
                ply.stop_leaning_bones = false
            end

            if ply.stop_leaning_bones then continue end

            lean_bones(ply, ply:GetNW2Float("leaning_fraction_smooth") * distance)

            if absolute == 0 then
                ply.stop_leaning_bones = true
            end
        end
    end)
end

if CLIENT then
    for i, data in ipairs(binds) do
        CreateConVar(data[1], -1, {FCVAR_USERINFO, FCVAR_ARCHIVE})
    end

    hook.Add("PreRender", "leaning_bend", function()
        for k, ply in ipairs(player.GetAll()) do
            ply.leaning_fraction_true_smooth = Lerp(FrameTime() / (engine.TickInterval() * interp), ply.leaning_fraction_true_smooth or 0, ply:GetNW2Float("leaning_fraction_smooth") * distance)
            local absolute = math.abs(ply.leaning_fraction_true_smooth)

            if absolute <= 0.00001 then ply.leaning_fraction_true_smooth = 0 end

            if absolute > 0 then
                ply.stop_leaning_bones = false
            end

            if ply.stop_leaning_bones then continue end

            lean_bones(ply, ply.leaning_fraction_true_smooth)

            if absolute == 0 then
                ply.stop_leaning_bones = true
            end
        end
    end)

    local lerped_fraction = 0

    local last_realtime = 0
    local realtime = 0

    hook.Add("CalcView", "leaning_roll", function(ply, origin, angles, fov, znear, zfar)
    	last_realtime = realtime
        realtime = SysTime()
        if realtime - last_realtime <= 0.00001 then
            return
        end

        lerped_fraction = Lerp(FrameTime() / (engine.TickInterval() * interp), lerped_fraction, ply:GetNW2Float("leaning_fraction_smooth", 0) * distance * 0.5)

        angles.z = angles.z + lerped_fraction
    end)

    local vm_last_realtime = 0
    local vm_realtime = 0

    hook.Add("CalcViewModelView", "leaning_roll", function(wep, vm, oldpos, oldang, pos, ang)
        if string.StartsWith(wep:GetClass(), "mg_") then return end

        vm_last_realtime = vm_realtime
        vm_realtime = SysTime()
        if vm_realtime - vm_last_realtime <= 0.00001 then
            return
        end

        ang.z = ang.z + lerped_fraction
    end)
end