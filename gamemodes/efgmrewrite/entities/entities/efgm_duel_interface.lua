
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

hook.Add("StartedDuel", "InterfaceDuelStart", function()

    ent:TriggerOutput("OnDuelStart")

end)

hook.Add("EndedDuel", "InterfaceDuelEnd", function()

    ent:TriggerOutput("OnDuelEnd")

end)

hook.Add("CancelledDuel", "InterfaceDuelCancel", function()

    ent:TriggerOutput("OnDuelEnd")

end)