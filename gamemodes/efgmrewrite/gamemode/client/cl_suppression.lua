local viewpunch_intensity = 0.66
local buildupspeed = 2.5
local bloom_intensity = 0.5

local effect_amount = 0

local function readVectorUncompressed()
	local tempVec = Vector(0,0,0)
	tempVec.x = net.ReadFloat()
	tempVec.y = net.ReadFloat()
	tempVec.z = net.ReadFloat()
	return tempVec
end

net.Receive("suppression_fire_event", function(len)
	local src = readVectorUncompressed()
	local dir = readVectorUncompressed()
	local entity = net.ReadEntity()
	if entity == LocalPlayer() then return end
	if LocalPlayer():CompareStatus(0) then return end

	local tr = util.TraceLine({
		start = src,
		endpos = src + dir * 100000,
		mask = CONTENTS_WINDOW + CONTENTS_SOLID + CONTENTS_AREAPORTAL + CONTENTS_MONSTERCLIP + CONTENTS_CURRENT_0
	})

	local distance_from_line, nearest_point, dist_along_the_line = util.DistanceToLine(tr.StartPos, tr.HitPos, LocalPlayer():GetPos())

	if LocalPlayer():Alive() and nearest_point:Distance(LocalPlayer():GetPos()) < 100 then
		effect_amount = math.Clamp(effect_amount + 0.08 * buildupspeed, 0, 1)
		sound.Play("bul_snap/supersonic_snap_" .. math.random(1,18) .. ".wav", nearest_point, 75, 100, 1)
		sound.Play("bul_flyby/subsonic_" .. math.random(1,27) .. ".wav", nearest_point, 75, 100, 1)

        local angle = Angle(math.Rand(-1.5, 1.5) * (effect_amount * (viewpunch_intensity)), math.Rand(-1.5, 1.5) * (effect_amount * (viewpunch_intensity)), math.Rand(-1.5, 1.5) * (effect_amount * (viewpunch_intensity)))
        Viewpunch(angle)
	end
end)

local started_effect = false
hook.Add("Think", "suppression_loop", function() 
	if effect_amount == 0 then
		if started_effect then
			started_effect = false
		end
	 	return
	end

	effect_amount = math.Clamp(effect_amount - 0.2 * FrameTime(), 0, 1)
	started_effect = true
end)

local sharpen_lerp = 0
local bloom_lerp = 0
hook.Add("RenderScreenspaceEffects", "suppression_ApplySuppression", function()
	if effect_amount == 0 then return end

	-- sharpen_lerp = Lerp(6 * FrameTime(), sharpen_lerp, effect_amount * suppression_sharpen_intensity)
	-- DrawSharpen(sharpen_lerp , 0.4)

	bloom_lerp = Lerp(6 * FrameTime(), bloom_lerp, effect_amount * bloom_intensity)
	DrawBloom(0.30, bloom_lerp , 0.33, 4.5, 1, 0, 1, 1, 1)
end)

local m = Material("vignette/vignette")
local alphanew = 0
hook.Add("RenderScreenspaceEffects", "suppression_vignette", function()
	if effect_amount == 0 then return end

	alphanew = Lerp(6 * FrameTime(), alphanew, effect_amount)

	render.SetMaterial(m)
	m:SetFloat("$alpha", alphanew)

	for i = 1, 4 do render.DrawScreenQuad() end
end)

hook.Add("PlayerInitialSpawn", "SetEffectOnSpawn", function(ply)
	effect_amount = 0
end)