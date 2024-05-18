-- eventually will be used to communicate with map entities about status of raid using hammer's I/O system
-- nvm im doing it now

ENT.Type = "point"
ENT.Base = "base_point"

ENT.RaidTime = 0

-- Arbys (We have the meats™)
function ENT:KeyValue(key, value)
    -- may add to this idk

	if key == "raid_time" then
		self.RaidTime = tonumber(value)
	end

	if key == "OnRaidStart" then
		self:StoreOutput(key, value)
	end

	if key == "OnRaidEnd" then
		self:StoreOutput(key, value)
	end
end

function ENT:AcceptInput(name, ply, caller, data)

    if name == "StartRaid" then

        RAID:StartRaid(self.RaidTime)

    end

    if name == "EndRaid" then
        
        RAID:EndRaid()

    end

    if name == "SetRaidTime" then

        if RAID.Status != raidStatus.ACTIVE then return end
        
        RAID.CurrentTime = tonumber(data)

    end

    if name == "RaidAddPlayer" then

        RAID:SpawnPlayer(ply, playerStatus.PMC)

    end


end