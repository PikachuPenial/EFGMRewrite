ENT.Type = "point"
ENT.Base = "base_point"

-- These are defined by the entity in hammer

ENT.ExtractTime = 10
ENT.ExtractName = ""
ENT.DisabledMessage = ""
ENT.ExtractGroup = ""
ENT.Accessibility = 0

ENT.IsDisabled = false
ENT.IsGuranteed = true
ENT.InstantExtract = false

function ENT:KeyValue(key, value)
	if key == "extractTime" then
		self.ExtractTime = tonumber(value)
	end

	if key == "extractName" then
		self.ExtractName = value
	end

	if key == "disabledMessage" then
		self.DisabledMessage = value
	end

	if key == "extractGroup" then
		self.ExtractGroup = value
	end

	if key == "accessibility" then
		self.Accessibility = tonumber(value)
	end


	if key == "OnPlayerExtract" then
		self:StoreOutput(key, value)
	end

	if key == "OnExtractEnabled" then
		self:StoreOutput(key, value)
	end

	if key == "OnExtractDisabled" then
		self:StoreOutput(key, value)
	end

end

function ENT:Initialize()
	-- bitwise operation for flags yipp fucking ee (will require some explanation)

	-- returns integer that is a representation of all the flags in binary
	-- (this is, by default 2, or 00000010, as the first digit (start disabled) starts false or 0, and the second digit (is guranteed) starts true or 1)
	local flags = tonumber( self:GetSpawnFlags() )

	-- print("self:GetSpawnFlags() = " .. flags)

	-- Bit.band is a "and" operation. For example, take 3 and 5, written in binary as 00000011 (2 + 1) and 00000101 (4 + 1) respectively.
	-- A bitwise "and" operation on 3 and 5 would return 1, as they both share the first digit, which is 1.

	-- In this case, I'm performing an "and" operation on flags (again, 00000010 by default) and 1 (00000001),
	-- which is the flag responsible for if the extract is disabled.
	-- If the outcome is one, then the "Start Disabled" flag is checked, meaning ENT.IsDisabled should be set to true.
	self.IsDisabled = bit.band(flags, 1) == 1

	-- Similarly, if flags and 2 share the same second digit, then the "Is Extract Guranteed" flag is checked.
	self.IsGuranteed = bit.band(flags, 2) == 2

	-- You can guess what's happening here. Do it, guess, pussy.
	self.InstantExtract = bit.band(flags, 4) == 4
end

function ENT:AcceptInput(name, ply, caller, data)
	if name == "EnableExtract" then
        self.IsDisabled = false
        self:TriggerOutput( "OnExtractEnabled", ply, data )
    end

	if name == "DisableExtract" then
        self.IsDisabled = true
        self:TriggerOutput( "OnExtractDisabled", ply, data )

        for k, v in ipairs( player.GetHumans() ) do
            self:Fire( "StopExtractingPlayer", nil, 0, ply, caller )
        end
    end

	if name == "ToggleExtract" then
        if self.IsDisabled then
            self:Fire( "EnableExtract", nil, 0, ply, caller )
            self:TriggerOutput( "OnExtractEnabled", ply, data )
        else
            self:Fire( "DisableExtract", nil, 0, ply, caller )
            self:TriggerOutput( "OnExtractDisabled", ply, data )
        end
    end

    if name == "StartExtractingPlayer" && ply:IsPlayer() then
        if ply:CompareStatus(0) or !ply:CompareSpawnGroup(self.ExtractGroup) then return end

        if self.IsDisabled then
            ply:PrintMessage( HUD_PRINTCENTER, self.DisabledMessage )
        else
            self:StartExtract(ply)
        end
    end

    if name == "StopExtractingPlayer" && !self.IsDisabled && ply:IsPlayer() then
        if !ply:CompareStatus( 0 ) && ply:CompareSpawnGroup( self.ExtractGroup ) then self:StopExtract( ply ) end
    end

end

function ENT:StartExtract(ply)
	if self.InstantExtract then self.Extract(ply) return end

	net.Start("SendExtractionStatus")
	net.WriteBool(true) -- true signals that the player entered the extraction points boundaries
	net.WriteInt(self.ExtractTime, 16)
	net.Send(ply)

	-- defines the timerName as for example "ExTimer_90071996842377216214"
	-- completely useless and fucking unreadable for normal (and maybe even autistic) people but nevertheless useful for consistently identifying timers
	local timerName = "ExTimer_" .. ply:SteamID64() .. self:EntIndex()

	-- if player's already extracting somehow
	if timer.Exists(timerName) then return end

	-- actual extract logic
	timer.Create(timerName, self.ExtractTime, 1, function()
		self:Extract(ply)
	end)
end

function ENT:StopExtract(ply)
	net.Start("SendExtractionStatus")
	net.WriteBool(false) -- false signals that the player left the extraction points boundaries
	net.Send(ply)

	-- read StartExtract you lazy ass
	local timerName = "ExTimer_" .. ply:SteamID64() .. self:EntIndex()

	-- if player somehow hasnt begun extracting yet (okay listen i watched a portal 2 speedrunning explained video and now im afraid people are going to purposefully push the limits of the source engine just to ratfuck my gamemode)
	if !timer.Exists(timerName) then return end

	-- actual stop extract logic
	timer.Remove(timerName)
end

function ENT:Extract(ply)
    self:TriggerOutput("OnPlayerExtract", ply)
    hook.Run("PlayerExtraction", ply, self.ExtractTime, self.IsGuranteed)
end