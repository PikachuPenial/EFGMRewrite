-- Handles events, such as stuff happening on the map. I'm just adding this to get the ball rolling for development,
-- because idk what else to start with really.

local function RemoteStartEvent(ply, eventName)

    
    local eventInterfaceEntity = ents.FindByClass( "efgm_event_interface" )
    if #eventInterfaceEntity != 1 then return end
    eventInterfaceEntity = eventInterfaceEntity[1]

    eventInterfaceEntity:TriggerOutput("OnEventStart", ply, eventName)

end
concommand.Add("efgm_start_event", function(ply, cmd, args) RemoteStartEvent(ply, args[1]) end)
