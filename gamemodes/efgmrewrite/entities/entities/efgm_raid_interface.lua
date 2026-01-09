-- eventually will be used to communicate with map entities about status of raid using hammer's I/O system
-- nvm im doing it now

ENT.Type = "point"
ENT.Base = "base_point"

ENT.RaidTime = 0

local ent

-- Arbys (We have the meats™)
function ENT:KeyValue(key, value)

    -- may add to this idk

	if key == "raid_time" then
		self.RaidTime = tonumber(value)
	end

	if key == "OnRaidStart" then
		self:StoreOutput(key, value)
	end

	if key == "OnTenMinutesLeft" then
		self:StoreOutput(key, value)
	end

	if key == "OnFiveMinutesLeft" then
		self:StoreOutput(key, value)
	end

	if key == "OnOneMinuteLeft" then
		self:StoreOutput(key, value)
	end

	if key == "OnRaidEnd" then
		self:StoreOutput(key, value)
    end

end

function ENT:Initialize()

    ent = self

end

hook.Add("StartedRaid", "InterfaceRaidStart", function()

    ent:TriggerOutput( "OnRaidStart" )

end)

hook.Add("RaidTimerTick", "InterfaceRaidTimerTick", function(curRaidTime)

    if curRaidTime == 600 then
        ent:TriggerOutput( "OnTenMinutesLeft" )
    elseif curRaidTime == 300 then
        ent:TriggerOutput( "OnFiveMinutesLeft" )
    elseif curRaidTime == 60 then
        ent:TriggerOutput( "OnOneMinuteLeft" )
    end

end)

hook.Add("EndedRaid", "InterfaceRaidEnd", function()

    ent:TriggerOutput( "OnRaidEnd" )

end)

function ENT:AcceptInput(name, ply, caller, data)
    if name == "StartRaid" then
        RAID:StartRaid(self.RaidTime, ply)
    end

    if name == "EndRaid" then
        RAID:EndRaid()
    end

    if name == "SetRaidTime" then
        if RAID.Status != raidStatus.ACTIVE then return end

        RAID.CurrentTime = tonumber(data)
    end

    if name == "SetPlayerReadiness" then
        if !IsValid(ply) then return end

        local isReady = tobool(data)
        ply:SetNWBool("RaidReady", isReady)

        if isReady then
            hook.Run("CheckRaidAddPlayers", ply)
        end
    end

end