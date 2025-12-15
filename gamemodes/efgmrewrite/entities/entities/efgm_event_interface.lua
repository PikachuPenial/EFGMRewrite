ENT.Type = "point"
ENT.Base = "base_point"

ENT.EventName = ""
ENT.EventDescription = ""

function ENT:KeyValue(key, value)

    if key == "eventName" then
        self.EventName = tostring(value)
    end

    if key == "eventDescription" then
        self.EventDescription = tostring(value)
    end

    if key == "OnEventStart" then
        self:StoreOutput(key, value)
    end

end

function ENT:AcceptInput(name, ply, caller, data)

    if name == "StartEvent" then

        self:TriggerOutput("OnEventStart", ply)

        hook.Run("DoEventStart", self.EventName, self.EventDescription, ply)

    end

end