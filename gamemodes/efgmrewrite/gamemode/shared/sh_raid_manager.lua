
RAID = RAID or {}

local plyMeta = FindMetaTable( "Player" )
if not plyMeta then Error("Could not find player table") return end

if SERVER then

    RAID.VoteTime = 90
    RAID.PlayersInRaid = {} -- [SteamID64] = Player

    RAID.MapPool = {["efgm_concrete"] = 0, ["efgm_ravine_interior"] = 0} -- only two rn ["map"] = numberofvotes

    SetGlobalInt("RaidTimeLeft", -1)
    SetGlobalInt("RaidStatus", raidStatus.PENDING) -- uses sh_enums

    --{ RAID FUNCTIONS

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

        function RAID.GetCurrentExtracts(ply)
                
            if ply:CompareStatus(0) then return nil end
    
            local extracts = {}
    
            for k, v in pairs( ents.FindByClass("efgm_extract") ) do
    
                print(v)
    
                if ply:CompareSpawnGroup(v.ExtractGroup) then
    
                    local tbl = {}
                    tbl.ExtractName = v.ExtractName
                    tbl.ExtractTime = v.ExtractTime
                    tbl.IsGuranteed = v.IsGuranteed
    
                    table.insert(extracts, tbl)
    
                end
    
            end
    
            return extracts
    
        end

    --}

    --{ PLAYER FUNCTIONS

        function RAID:SpawnPlayer(ply, status)

            if GetGlobalInt("RaidStatus") != raidStatus.ACTIVE then print("raid isnt active") return end

            if !ply:IsPlayer() then print("What kind of player tries to enter the raid? No player, no player at all.") return end

            if !ply:CompareStatus(0) then print("great ive fucking broke the gamemode again goddamn it") return end

            print("spawning player")

            spawn = GetValidRaidSpawn(status)

            ply:SetRaidStatus(status, spawn.SpawnGroup or "")
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
        
            ply:SetRaidStatus(0, "")
        
        end

    --}

    --{ CONSOLE COMMANDS

        local function ChangeStatus(ply, cmd, args)

            if args[1] == nil then return end

            local status = tonumber( args[1] )

            ply:SetRaidStatus(status)

        end
        concommand.Add("efgm_debug_changeraidstatus", ChangeStatus)

        local function GetStatus(ply, cmd, args)

            local status = ply:GetNWInt("PlayerRaidStatus", 0)
            local spawnGroup = ply:GetNWString("PlayerSpawnGroup", "")

            print( "Status: "..status.." Group: "..spawnGroup )

        end
        concommand.Add("efgm_debug_getraidstatus", GetStatus)

        local function GetRaidInfo(ply, cmd, args)

            print(GetGlobalInt("RaidStatus") .. " " .. GetGlobalInt("RaidTimeLeft"))

        end
        concommand.Add("efgm_debug_getraidinfo", GetRaidInfo)

        local function DebugStartRaid(ply, cmd, args)

            RAID:StartRaid()

            GetRaidInfo()

        end
        concommand.Add("efgm_debug_startraid", DebugStartRaid)

        local function DebugEndRaid(ply, cmd, args)

            -- what i said on GEFRST 999x

            RAID:EndRaid()

            GetRaidInfo()

        end
        concommand.Add("efgm_debug_endraid", DebugEndRaid)

    --}

    function plyMeta:SetRaidStatus(status, spawnGroup)

        self:SetNWInt( "PlayerRaidStatus", status or 0 )
        self:SetNWString("PlayerSpawnGroup", spawnGroup or self:GetNWString( "PlayerSpawnGroup", "" ) )

    end

    function plyMeta:Teleport(position, angles, velocity)

        -- shortening the extract and raid manager logic lol, not necessary but fun ig idfk

        self:SetPos(position)
        self:SetEyeAngles(angles)
        self:SetLocalVelocity(velocity)

    end

end

if CLIENT then

    concommand.Add("efgm_print_extracts", function(ply, cmd, args)
            
        local extracts = RAID.GetCurrentExtracts(ply)

        if extracts == nil then return end
        
        local extractNames = "Your available extract locations are:"

        for k, v in pairs( extracts ) do

            extractNames = extractNames .. "\n" .. v.ExtractName

            if v.IsGuranteed then
                extractNames = extractNames .. " (Status: Available)"
            else
                extractNames = extractNames .. " (Status: Unknown)"
            end
        end

        ply:PrintMessage(HUD_PRINTCENTER, extractNames)

    end)
    
end

function plyMeta:GetRaidStatus()

    local status = self:GetNWInt("PlayerRaidStatus", 0)
    local spawnGroup = self:GetNWString("PlayerSpawnGroup", "")

    return status, spawnGroup

end

function plyMeta:CompareSpawnGroup(group)

    -- fuck off with your "addons/efgmrewrite/gamemodes/efgmrewrite/entities/entities/efgm_extract.lua:114: unexpected symbol near ')'" bullshit there's fixing to be an unexpected hole in my goddamn monitor
    -- oh i forgot an end

    group = group or ""

    print("Extract SpawnGroup == "..group)
    print("Player SpawnGroup == "..self:GetNWString("PlayerSpawnGroup", ""))

    if group == "" then return true end

    return self:GetNWString("PlayerSpawnGroup", "") == group

end

function plyMeta:CompareStatus(status) -- if player is in raid then status of 0 will return false

    status = status or 0

    return self:GetNWInt("PlayerRaidStatus", 0) == status

end