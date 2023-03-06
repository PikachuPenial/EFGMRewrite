
-- Define raid metatable
local Raid = {}

Raid.Status = raidStatus.PENDING -- uses sh_enums enums, peep it neighbor
Raid.StartingTime = 1200 -- placeholder, uses seconds
Raid.CurrentTime = 1200 -- the fuck did i mean placeholder
Raid.PlayersInRaid = {} -- [SteamID64] = Player

-- Initialization function

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

    SetGlobalFloat("GlobalRaidTimer", self.CurrentTime)

end

function Raid:StartRaid()

    if self.Status != raidStatus.PENDING then return end

    self.Status = raidStatus.ACTIVE

    local raidInterface = ents.FindByClass( "efgm_raid_interface" )

    if raidInterface == nil then Error("Your map should probably have a efgm_raid_interface you dumbass.") return end

    self.CurrentTime = raidInterface.RaidTime

    SetGlobalFloat("GlobalRaidTimer", self.CurrentTime)

    -- a ton of shit else

    timer.Create("RaidTimerDecrement", 1, 0, DecrementTimer)

    print("Raid Started!")

end

function Raid:EndRaid()

    if self.Status != raidStatus.ACTIVE then return end

    self.Status = raidStatus.ENDED

    -- kill players in raid, idk what else

    PrintTable(self.PlayersInRaid)
    for k, v in pairs(self.PlayersInRaid) do
        v:Kill()
    end

    if timer.Exists("RaidTimerDecrement") then timer.Remove("RaidTimerDecrement") end

    print("Raid Ended!")

end

function Raid:SpawnPlayer(ply, status)

    if RAID.Status != raidStatus.ACTIVE then print("raid isnt active") return end

    if !ply:IsPlayer() then print("What kind of player tries to enter the raid? No player, no player at all.") return end

    if ply:IsInRaid() then print("great ive fucking broke the gamemode again goddamn it") return end

    -- im afraid to touch this yet due to ptsd (but here we go yippee)

    print("spawning player")

    spawn = GetValidRaidSpawn(status) -- done: this

    ply:SetRaidStatus(status, spawn.SpawnGroup)
	ply:Teleport(spawn:GetPos(), spawn:GetAngles(), Vector(0, 0, 0))

    self:AddPlayer(ply)

end

function Raid:AddPlayer(ply)

    local steamid = ply:SteamID64()

    self.PlayersInRaid[steamid] = ply

end

function Raid:RemovePlayer(ply)

    local steamid = ply:SteamID64()

    self.PlayersInRaid[steamid] = nil

end

-- Actually making the global RAID object (just finding out none of this initialization shit is necessary, still good to know though if i manage to get to making ui without putting a gun into my mouth first)

RAID = Raid:Initialize()
