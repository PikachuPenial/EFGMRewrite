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

end

function ENT:Initialize()

	-- bitwise operation for flags yipp fucking ee (will require some explanation)

	-- returns integer that is a representation of all the flags in binary
	-- (by default 2, or 00000010, as the first digit (start disabled) starts false or 0, and the second digit (is guranteed) starts true or 1)
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

function ENT:AcceptInput(name, activator, caller, data)
	
	if name == "EnableExtract" then
		self.IsDisabled = false
	end

	if name == "DisableExtract" then
		self.IsDisabled = true
	end

	if name == "ToggleExtract" then
		self.IsDisabled = !self.IsDisabled
	end

	if !activator:IsPlayer() then print("A bot just tried to extract smh") return end

	if !activator:CompareStatus(0) && activator:CompareSpawnGroup(self.ExtractGroup) && !self.IsDisabled then

		if name == "StartExtractingPlayer" then
			print("Player's name is " .. activator:GetName())

			self:StartExtract(activator)
		end

		if name == "StopExtractingPlayer" then
			self:StopExtract(activator)
		end

	end

end

function ENT:StartExtract(ply)

	--print("Player's name is " .. ply:GetName())

	-- debug, will replace later once i make a fancy UI system
	ply:PrintMessage( HUD_PRINTCENTER, "Extracting using ".. self.ExtractName .." (".. self.ExtractTime .." Seconds)" )

	if self.InstantExtract then self.Extract(ply) return end

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

	ply:PrintMessage( HUD_PRINTCENTER, "Stopping extracting" )

	-- read StartExtract you lazy ass
	local timerName = "ExTimer_" .. ply:SteamID64() .. self:EntIndex()

	-- if player somehow hasnt begun extracting yet (okay listen i watched a portal 2 speedrunning explained video and now im afraid people are going to purposefully push the limits of the source engine just to ratfuck my gamemode)
	if !timer.Exists(timerName) then return end

	-- actual stop extract logic

	timer.Remove(timerName)

end

function ENT:Extract(ply)

	--print("Player's name is " .. ply:GetName())

	lobbySpawns = ents.FindByClass("efgm_lobby_spawn") -- gets a table of all the lobby spawns

	local possibleSpawns = {}

	local playerExtracted = false

	if !lobbySpawns and #lobbySpawns == 0 then error("no lobby spawns") return end

	-- all this is done so that players spawn in random spots bc yeah it was really that important
	for k, v in ipairs(lobbySpawns) do
		
		if v:CanSpawn(ply) then

			table.insert(possibleSpawns, v)

		end

	end

	if #possibleSpawns == 0 then return end

	local randomSpawn = BetterRandom(possibleSpawns)

	RAID:RemovePlayer(ply)
	ply:Teleport(randomSpawn:GetPos(), randomSpawn:GetAngles(), Vector(0, 0, 0))

    hook.Run("PlayerExtraction", ply, self.ExtractTime, self.IsGuranteed)

end