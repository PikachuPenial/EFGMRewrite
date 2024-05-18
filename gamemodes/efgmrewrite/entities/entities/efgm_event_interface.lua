
ENT.Type = "point"
ENT.Base = "base_point"

function ENT:KeyValue(key, value)

    if key == "OnEventStart" then
		self:StoreOutput(key, value)
	end
    
end

function ENT:AcceptInput(name, ply, caller, data)

    if name == "StartEvent" then
        self:TriggerOutput("OnEventStart", self, tostring(data))
    end

end