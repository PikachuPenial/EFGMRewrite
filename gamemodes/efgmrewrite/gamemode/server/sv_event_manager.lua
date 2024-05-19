-- Handles events, such as stuff happening on the map. I'm just adding this to get the ball rolling for development,
-- because idk what else to start with really.

local function RemoteStartEvent(ply, eventName)

    local eventInterfaces = ents.FindByClass( "efgm_event_interface" )
    if #eventInterfaces == 0 then return end

    for k, v in ipairs(eventInterfaces) do
        
        if v.EventName == eventName then
            
            v:TriggerOutput("OnEventStart", ply)

        return end

        print("Event not found.")

    end

end
concommand.Add("efgm_start_event", function(ply, cmd, args) RemoteStartEvent(ply, args[1]) end)

local function ReturnEventList()

    local eventInterfaces = ents.FindByClass( "efgm_event_interface" )
    if #eventInterfaces == 0 then return {} end

    local events = {}

    for k, v in ipairs(eventInterfaces) do
        
        events[v.EventName] = v.EventDescription

    end

    return events

end
concommand.Add("efgm_print_events", function() PrintTable( ReturnEventList() ) end)