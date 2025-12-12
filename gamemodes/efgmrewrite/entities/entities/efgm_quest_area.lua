ENT.Type = "point"
ENT.Base = "base_point"

-- These are defined by the entity in hammer

ENT.InternalName = ""

function ENT:KeyValue(key, value)

	if key == "targetname" then
		self.InternalName = value
	end

end

function ENT:AcceptInput(name, ply, caller, data)

	if name == "PlayerVisited" then

		if !IsValid(ply) then return end
		hook.Run("TaskAreaVisited", ply, self.InternalName)

	end

end
