
-- disable crouch jumping because of animation abuse + dynamic crouch toggling
hook.Add("StartCommand", "AdjustPlayerMovement", function(ply, cmd)

	if cmd:KeyDown(IN_BACK) or (cmd:KeyDown(IN_MOVELEFT) or cmd:KeyDown(IN_MOVERIGHT)) and !cmd:KeyDown(IN_FORWARD) then
		cmd:RemoveKey(IN_SPEED)
    end

end)

-- reduce velocity upon landing to prevent bunny hopping
hook.Add("OnPlayerHitGround", "VelocityLimiter", function(ply) 

	local vel = ply:GetVelocity()
	ply:SetVelocity(Vector(-vel.x / 2, -vel.y / 2, 0))

end )