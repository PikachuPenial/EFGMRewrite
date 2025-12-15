ENT.Type = "point"
ENT.Base = "base_point"

-- These are defined by the entity in hammer

ENT.InternalName = ""
ENT.ExtractTime = 10
ENT.ExtractName = ""
ENT.DisabledMessage = ""
ENT.ExtractGroup = ""
ENT.Accessibility = 0

ENT.IsDisabled = false
ENT.IsGuranteed = true
ENT.InstantExtract = false
ENT.ShowOnMap = true

function ENT:KeyValue(key, value)

	if key == "targetname" then
		self.InternalName = value
	end
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

	local flags = tonumber(self:GetSpawnFlags())

	self.IsDisabled = bit.band(flags, 1) == 1
	self.IsGuranteed = bit.band(flags, 2) == 2
	self.InstantExtract = bit.band(flags, 4) == 4
	self.ShowOnMap = bit.band(flags, 8) == 8

	print(flags)

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
        if !IsValid(ply) or ply:CompareStatus(0) or !ply:CompareSpawnGroup(self.ExtractGroup) then return end

        if self.IsDisabled then
			net.Start("SendNotification", false)
            net.WriteString(self.DisabledMessage)
            net.WriteString("icons/extract_disabled_icon.png")
            net.WriteString("ui/squad_leave.wav")
            net.Send(ply)
        else
            self:StartExtract(ply)
        end
    end

    if name == "StopExtractingPlayer" && !self.IsDisabled && ply:IsPlayer() then
        if IsValid(ply) and !ply:CompareStatus(0) and ply:CompareSpawnGroup(self.ExtractGroup) then self:StopExtract(ply) end
    end

    if name == "InstantlyExtractPlayer" and !self.IsDisabled and ply:IsPlayer() then
        if !IsValid(ply) or ply:CompareStatus(0) or !ply:CompareSpawnGroup(self.ExtractGroup) then return end

        if self.IsDisabled then
			net.Start("SendNotification", false)
            net.WriteString(self.DisabledMessage)
            net.WriteString("icons/extract_disabled_icon.png")
            net.WriteString("ui/squad_leave.wav")
            net.Send(ply)
        else
            self:Extract(ply)
        end
    end

    if name == "InstantlyExtractPlayeIgnoreDisabled" and ply:IsPlayer() then
        if ply:CompareStatus(0) or !ply:CompareSpawnGroup(self.ExtractGroup) then return end

        self:Extract(ply)
    end

end

function ENT:StartExtract(ply)
	if !IsValid(ply) then return end
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
	if !IsValid(ply) then return end

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
	if !IsValid(ply) then return end
    self:TriggerOutput("OnPlayerExtract", ply)
    hook.Run("PlayerExtraction", ply, self.ExtractTime, self.IsGuranteed, self.InternalName)
end