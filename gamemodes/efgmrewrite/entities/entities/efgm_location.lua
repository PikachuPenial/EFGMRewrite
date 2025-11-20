ENT.Type = "point"
ENT.Base = "base_point"

-- These are defined by the entity in hammer

ENT.Name = ""
ENT.DisplayName = ""
ENT.LootRating = 1

function ENT:KeyValue(key, value)

	if key == "targetname" then
		self.Name = tostring(value)
	end

	if key == "displayName" then
		self.DisplayName = tostring(value)
	end

	if key == "lootRating" then
		self.LootRating = tonumber(value)
	end

end