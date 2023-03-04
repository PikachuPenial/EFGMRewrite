local playerMeta = FindMetaTable( "Player" )
if not playerMeta then Error("Could not find player table") return end

-- start defining basic meta functions woohoo

function playerMeta:GetRaidStatus()

    local status = self:GetNWInt("PlayerRaidStatus", 0)
    local spawnGroup = self:GetNWString("PlayerSpawnGroup", "")

    return status, spawnGroup

end


function playerMeta:SetRaidStatus(status, spawnGroup)

    self:SetNWInt("PlayerRaidStatus", status)
    self:SetNWString("PlayerSpawnGroup", spawnGroup)

end

function playerMeta:IsInRaid()

    return self:GetNWInt("PlayerRaidStatus", 0) != 0

end

function playerMeta:Teleport(position, angles, velocity)

    -- shortening the extract and raid manager logic lol, not necessary but fun ig idfk

    self:SetPos(position)

    if angles == nil then return end

	self:SetEyeAngles(angles)

    if velocity == nil then return end
    
	self:SetAbsVelocity(velocity)

end