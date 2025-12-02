
-- TODO: Find better name for this file

local interval = 0.1

local raidPositions = {}
local killPositions = {}
local enterRaidTime = nil

InsideRaidLength = nil
RaidPositions = {}
DeathPosition = {}
KillPositions = {}

local function UpdateTrackedPosition(trackRegardless)

    if (LocalPlayer():GetNWInt("PlayerRaidStatus", 0) == 0) and !trackRegardless then return end

    table.insert(raidPositions, WorldToMapSpace(LocalPlayer():GetPos()))

end

hook.Add("efgm_raid_enter", "efgm_tracker_start", function()

    UpdateTrackedPosition(false)

    InsideRaidLength = nil
    RaidPositions = {}
    DeathPosition = {}
    KillPositions = {}

    enterRaidTime = SysTime()

    timer.Create("efgm_tracker", interval, 0, function() UpdateTrackedPosition(false) end)

end)

hook.Add("efgm_raid_exit", "efgm_tracker_stop", function(wasExtract)

    if enterRaidTime == nil then

        InsideRaidLength = nil
        RaidPositions = {}
        DeathPosition = {}
        KillPositions = {}
        enterRaidTime = nil
        return

    end

    if !wasExtract then

        UpdateTrackedPosition(true)

        DeathPosition = WorldToMapSpace(LocalPlayer():GetPos())

    end

    timer.Remove("efgm_tracker")

    RaidPositions = raidPositions
    KillPositions = killPositions
    InsideRaidLength = SysTime() - enterRaidTime

    killPositions = {}
    raidPositions = {}
    enterRaidTime = nil

end)

hook.Add("entity_killed", "efgm_tracker_kill", function(data) 

	local attacker = data.entindex_attacker

    if attacker != LocalPlayer():EntIndex() then return end

    local pos = WorldToMapSpace(LocalPlayer():GetPos())

    local killTable = {x = pos.x, y = pos.y, time = #raidPositions}

    table.insert(killPositions, killTable)

end )