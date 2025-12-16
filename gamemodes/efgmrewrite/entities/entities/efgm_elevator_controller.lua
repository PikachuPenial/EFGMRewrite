-- could this be made entirely using hammer's I/O system? yeah
-- do I know how to do this entirely inside hammer's I/O system? uhh

ENT.Type = "point"
ENT.Base = "base_point"

local elevatorStatus = {}
-- Start and end don't include time where doors are moving
elevatorStatus.Start = 0
elevatorStatus.End = 1
elevatorStatus.MovingToStart = 2
elevatorStatus.MovingToEnd = 3

local curStatus = elevatorStatus.Start
local queuedOutput = nil

function ENT:KeyValue(key, value)

	if key == "MoveToStart" then
		self:StoreOutput(key, value)
	end

	if key == "MoveToEnd" then
		self:StoreOutput(key, value)
	end

end

function ENT:AcceptInput(name, ply, caller, data)

    if name == "AskGoToStart" then

        if curStatus == elevatorStatus.End then

            self:TriggerOutput( "MoveToStart", ply, data )

        elseif curStatus == elevatorStatus.MovingToEnd then

            queuedOutput = "MoveToStart"

        end

    end

    if name == "AskGoToEnd" then
        
        if curStatus == elevatorStatus.Start then

            self:TriggerOutput( "MoveToEnd", ply, data )

        elseif curStatus == elevatorStatus.MovingToStart then

            queuedOutput = "MoveToEnd"

        end

    end

    if name == "SetStatus" then
        
        curStatus = tonumber(data)

    end

end

function ENT:Think()

    if queuedOutput == "MoveToStart" && curStatus == elevatorStatus.End then

        self:TriggerOutput( "MoveToStart", ply, data )

        queuedOutput = nil
        
    end

    if queuedOutput == "MoveToEnd" && curStatus == elevatorStatus.Start then

        self:TriggerOutput( "MoveToEnd", ply, data )

        queuedOutput = nil
        
    end

end