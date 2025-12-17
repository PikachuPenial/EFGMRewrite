ENT.Type = "point"
ENT.Base = "base_point"

function ENT:CanSpawn(ply)
    local pos = self:GetPos() -- Get the position of the PlayerSpawn entity
    local mins, maxs = ply:GetHull() * 3 -- Get the bounding box of the player's hull

    local trace = util.TraceHull({
        start = pos,
        endpos = pos,
        mins = mins,
        maxs = maxs
    })

    if trace.Hit then
        return false -- Player is clipping into something
    end

    return true -- Player can be teleported without clipping
end