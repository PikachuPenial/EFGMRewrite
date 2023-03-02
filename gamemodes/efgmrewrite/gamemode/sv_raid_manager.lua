
-- Define raid metatable
local Raid = {

    Status =        raidStatus.PENDING,

    StartingTime =  1200, -- placeholder, uses seconds
    CurrentTime =   1200

}

-- Initialization function ()

function Raid:Initialize(o)
    -- i don't pretend to know what's going on here despite chatgpt explaining it to me but it works so its probably fine
    o = o or {}
    setmetatable(o, self)
    self.__index = self
    return o
end

-- Various useful raid functions

local function DecrementTimer()

    if RAID.Status != raidStatus.ACTIVE then return end

    RAID.CurrentTime = RAID.CurrentTime - 1

    if RAID.CurrentTime <= 0 then RAID:EndRaid() return end

end

function Raid:StartRaid()

    if self.Status != raidStatus.PENDING then return end

    self.Status = raidStatus.ACTIVE

    -- a ton of shit else

    timer.Create("RaidTimerDecrement", 1, 0, DecrementTimer)

    print("Raid Started!")

end

function Raid:EndRaid()

    if self.Status != raidStatus.ACTIVE then return end

    self.Status = raidStatus.ENDED

    -- kill players in raid, idk what else

    if timer.Exists("RaidTimerDecrement") then timer.Remove("RaidTimerDecrement") end

    print("Raid Ended!")

end

function Raid:SpawnPlayer(player)

    -- im afraid to touch this yet due to ptsd

    print("spawning player")

end

-- Actually making the global RAID object

RAID = Raid:Initialize()
