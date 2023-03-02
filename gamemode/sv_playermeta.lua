local playerMeta = FindMetaTable( "Player" )
if not playerMeta then Error("Could not find player table") return end

-- start defining basic meta functions woohoo

function playerMeta:GetRaidStatus()

    local status = GetPlayerData( self:SteamID64(), "RaidStatus" ) or playerStatus.LOBBY

    return status

end


function playerMeta:SetRaidStatus(status)

    SetPlayerData(self:SteamID64(), "RaidStatus", status)

end