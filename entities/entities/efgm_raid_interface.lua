-- eventually will be used to communicate with map entities about status of raid using hammer's I/O system
-- nvm im doing it now

ENT.Type = "point"
ENT.Base = "base_point"

ENT.RaidTime = 0

-- Arbys
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

        if RAID.Status != raidStatus.PENDING then return end

        RAID:StartRaid()

    end

    if name == "EndRaid" then

        if RAID.Status != raidStatus.ACTIVE then return end
        
        RAID:EndRaid()

    end

    if name == "SetRaidTime" then

        if RAID.Status != raidStatus.ACTIVE then return end
        
        RAID.CurrentTime = tonumber(data)

    end

    if name == "RaidAddPlayer" then

        if RAID.Status != raidStatus.ACTIVE then print("raid isnt active") return end

        if !ply:IsPlayer() then print("what kind of player tries to enter the raid, no player, no player at all") return end

        RAID:SpawnPlayer(ply)

    end


end