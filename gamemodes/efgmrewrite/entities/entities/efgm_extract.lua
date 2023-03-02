ENT.Type = "point"
ENT.Base = "base_point"

-- These are defined by the entity in hammer

ENT.ExtractTime = 10
ENT.ExtractName = ""
ENT.DisabledMessage = ""
ENT.ExtractGroup = "All"
ENT.Accessibility = 0

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

-- bitwise operation for flags yipp fucking ee (will require some explanation)

-- returns integer that is a representation of all the flags in binary
-- (by default 2, or 00000010, as the first digit (start disabled) starts false or 0, and the second digit (is guranteed) starts true or 1)
local flags = ENT:GetSpawnFlags()

-- Bit.band is a "and" operation. For example, take 3 and 5, written in binary as 00000011 (2 + 1) and 00000101 (4 + 1) respectively.
-- A bitwise "and" operation on 3 and 5 would return 1, as they both share the first digit, which is 1.

-- In this case, I'm performing an "and" operation on flags (again, 00000010 by default) and 1 (00000001),
-- which is the flag responsible for if the extract is disabled.
-- If the outcome is one, then the "Start Disabled" flag is checked, meaning ENT.IsDisabled should be set to true.
ENT.IsDisabled = bit.band(flags, 1) == 1

-- Similarly, if flags and 2 share the same second digit, then the "Is Extract Guranteed" flag is checked.
ENT.IsGuranteed = bit.band(flags, 2) == 2

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

	if name == "StartExtractingPlayer" && !self.IsDisabled then
		-- do shit here eventually
	end

	if name == "StopExtractingPlayer" then
		-- do shit here eventually also
	end

end
