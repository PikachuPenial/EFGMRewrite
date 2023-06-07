
RAID = {}

RAID.VoteTime = 90
RAID.PlayersInRaid = {} -- [SteamID64] = Player

RAID.MapPool = {["efgm_concrete"] = 0, ["efgm_ravine_interior"] = 0} -- only two rn ["map"] = numberofvotes

SetGlobalInt("RaidTimeLeft", -1)
SetGlobalInt("RaidStatus", raidStatus.PENDING) -- uses sh_enums

-- Various useful raid functions

local function DecrementTimer()

    SetGlobalInt("RaidTimeLeft", GetGlobalInt("RaidTimeLeft") - 1)

    if GetGlobalInt("RaidTimeLeft") <= 0 && GetGlobalInt("RaidStatus") == raidStatus.ACTIVE then RAID:EndRaid() return end
    if GetGlobalInt("RaidTimeLeft") <= 0 && GetGlobalInt("RaidStatus") == raidStatus.ENDED then RAID:EndVote() return end

    hook.Run("RaidTimerTick", GetGlobalInt("RaidTimeLeft"))

end

function RAID:StartRaid(raidTime)

    if GetGlobalInt("RaidStatus") != raidStatus.PENDING then return end

    SetGlobalInt("RaidStatus", raidStatus.ACTIVE)
    SetGlobalInt("RaidTimeLeft", raidTime)

    -- a ton of shit else (actually not that much ig)

    timer.Create("RaidTimerDecrement", 1, 0, DecrementTimer)

    print("Raid Started!")

    hook.Run("StartedRaid")

end

function RAID:EndRaid()

    if GetGlobalInt("RaidStatus") != raidStatus.ACTIVE then return end

    SetGlobalInt("RaidStatus", raidStatus.ENDED)
    SetGlobalInt("RaidTimeLeft", self.VoteTime)

    -- kill players in raid, idk what else

    -- PrintTable(self.PlayersInRaid)
    for k, v in pairs(self.PlayersInRaid) do
        v:Kill()
    end

    print("Raid Ended!")

    hook.Run("EndedRaid")

    -- Thanks penal code
    if #player.GetHumans() == 0 then

        local tbl = {}

        for k, v in pairs(self.MapPool) do table.insert(tbl, k) end

        RunConsoleCommand("changelevel", tbl[math.random(#tbl)])

        return

    end

    timer.Adjust("RaidTimerDecrement", 1, self.VoteTime) -- fuck you timer.Adjust

    self:BroadcastOptions(self.MapPool)

    print("vote started")

end

function RAID:EndVote()

    local maxVote = 0
    local mapTable = {}

    for k, v in pairs(self.MapPool) do -- getting the max vote
        
        if v > maxVote then
            
            maxVote = v

        end

    end

    for k, v in pairs(self.MapPool) do -- getting every map with the max vote into a table
        
        if v == maxVote then
            
            table.insert(mapTable, k)

        end

    end

    RunConsoleCommand("changelevel", mapTable[math.random(#mapTable)]) -- will eventually carry over everybody's weapons and ammo and shit

end

function RAID:SubmitVote(ply, vote)
    
    if self.MapPool[vote] == nil then return end

    self.MapPool[vote] = self.MapPool[vote] + 1

    ply:SetNWBool("HasVoted", true)

    ply:PrintMessage(HUD_PRINTTALK, "Your vote of ".. vote .." has been counted!")

end
concommand.Add("efgm_vote", function(ply, cmd, args)

    if ply:GetNWBool("HasVoted", false) == true then return end
    if GetGlobalInt("RaidStatus") != raidStatus.ENDED then return end

    RAID:SubmitVote(ply, args[1])

end)

util.AddNetworkString("VoteableMaps")
function RAID:BroadcastOptions(maps)

    net.Start("VoteableMaps")
    net.WriteTable(maps)
    net.Broadcast()

end

-- Player Functions

function RAID:SpawnPlayer(ply, status)

    if GetGlobalInt("RaidStatus") != raidStatus.ACTIVE then print("raid isnt active") return end

    if !ply:IsPlayer() then print("What kind of player tries to enter the raid? No player, no player at all.") return end

    if ply:IsInRaid() then print("great ive fucking broke the gamemode again goddamn it") return end

    -- im afraid to touch this yet due to ptsd (but here we go yippee)

    print("spawning player")

    spawn = GetValidRaidSpawn(status) -- done: this

    ply:SetRaidStatus(status, spawn.SpawnGroup)
	ply:Teleport(spawn:GetPos(), spawn:GetAngles(), Vector(0, 0, 0))

    self:AddPlayer(ply)

end

function RAID:AddPlayer(ply)

    local steamID = ply:SteamID64()

    self.PlayersInRaid[steamID] = ply

end

function RAID:RemovePlayer(ply)

    local steamID = ply:SteamID64()
    self.PlayersInRaid[steamID] = nil

	ply:ResetRaidStatus()

end
