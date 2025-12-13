
ENT.Type = "point"
ENT.Base = "base_point"

function ENT:KeyValue(key, value)

    if key == "OnDuelStart" then
        self:StoreOutput(key, value)
    end

    if key == "OnDuelEnd" then
        self:StoreOutput(key, value)
    end

end

function ENT:Initialize()

    ent = self

end

hook.Add("StartedDuel", "InterfaceDuelStart", function()

    if !IsValid(ent) then return end
    ent:TriggerOutput("OnDuelStart")

end)

hook.Add("EndedDuel", "InterfaceDuelEnd", function()

    if !IsValid(ent) then return end
    ent:TriggerOutput("OnDuelEnd")

end)

hook.Add("CancelledDuel", "InterfaceDuelCancel", function()

    if !IsValid(ent) then return end
    ent:TriggerOutput("OnDuelEnd")

end)