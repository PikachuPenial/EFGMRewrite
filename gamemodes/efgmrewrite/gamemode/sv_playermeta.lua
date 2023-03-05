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

function playerMeta:ResetRaidStatus()

    self:SetNWInt("PlayerRaidStatus", 0)
    self:SetNWString("PlayerSpawnGroup", "")

end

function playerMeta:IsInRaid()

    return self:GetNWInt("PlayerRaidStatus", 0) != 0

end

function playerMeta:Teleport(position, angles, velocity)

    -- shortening the extract and raid manager logic lol, not necessary but fun ig idfk

    self:SetPos(position)
	self:SetEyeAngles(angles)
	self:SetLocalVelocity(velocity)

end

function playerMeta:CompareSpawnGroup(compareGroup)

    -- return true if player's spawn group matches, nah if nah
    -- will do later when everything else works somehow

    -- fuck off with your "addons/efgmrewrite/gamemodes/efgmrewrite/entities/entities/efgm_extract.lua:114: unexpected symbol near ')'" bullshit there's fixing to be an unexpected hole in my goddamn monitor
    -- oh i forgot an end

    local spawnGroup = self:GetNWString("PlayerSpawnGroup", "")

    -- print( spawnGroup .. " as opposed to " .. compareGroup )

    -- if extract is freer than idk im not good with comparisons
    if compareGroup == "" then return true end

    return spawnGroup == compareGroup

end