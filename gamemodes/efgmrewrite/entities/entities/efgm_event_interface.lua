
ENT.Type = "point"
ENT.Base = "base_point"

ENT.EventName = ""

function ENT:KeyValue(key, value)

    if key == "eventName" then
		self.EventName = tostring(value)
	end

    if key == "OnEventStart" then
		self:StoreOutput(key, value)
	end
    
end

function ENT:AcceptInput(name, ply, caller, data)

    if name == "StartEvent" then

        self:TriggerOutput("OnEventStart", ply)

    end

end