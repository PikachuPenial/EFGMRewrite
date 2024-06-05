
-- disable crouch jumping because of animation abuse + dynamic crouch toggling
hook.Add("StartCommand", "AdjustPlayerMovement", function(ply, cmd)

	if cmd:KeyDown(IN_BACK) or (cmd:KeyDown(IN_MOVELEFT) or cmd:KeyDown(IN_MOVERIGHT)) and !cmd:KeyDown(IN_FORWARD) or !ply:OnGround() or cmd:KeyDown(IN_ATTACK2) then
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