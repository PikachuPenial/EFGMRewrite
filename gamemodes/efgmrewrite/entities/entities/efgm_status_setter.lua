ENT.Type = "point"
ENT.Base = "base_point"

function ENT:Initialize()

end

function ENT:AcceptInput(name, ply, caller, data)
	if name == "SetStatus" then
        if !ply:IsPlayer() or !IsValid(ply) then return end

        local status = math.Clamp(tonumber(data), 0, 1)
        
        ply:SetRaidStatus(status)
    end
end
