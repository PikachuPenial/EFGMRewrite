
RAID = {}

local plyMeta = FindMetaTable( "Player" )
if not plyMeta then Error("Could not find player table") return end

local function DecrementTimer()

    SetGlobalInt("RaidTimeLeft", GetGlobalInt("RaidTimeLeft") - 1)

    if GetGlobalInt("RaidTimeLeft") <= 0 && GetGlobalInt("RaidStatus") == raidStatus.ACTIVE then RAID:EndRaid() return end
    if GetGlobalInt("RaidTimeLeft") <= 0 && GetGlobalInt("RaidStatus") == raidStatus.ENDED then RAID:EndVote() return end

    hook.Run("RaidTimerTick", GetGlobalInt("RaidTimeLeft"))

end

if SERVER then

    util.AddNetworkString("VoteableMaps")
    util.AddNetworkString("SendVote")
    util.AddNetworkString("RequestExtracts")

    util.AddNetworkString("PlayerEnterRaid")

    RAID.VoteTime = 60

    RAID.MapPool = {["efgm_belmont_rw"] = 0, ["efgm_concrete_rw"] = 0, ["efgm_customs_rw"] = 0, ["efgm_factory_rw"] = 0} -- map, number of votes

    SetGlobalInt("RaidTimeLeft", -1)
    SetGlobalInt("RaidStatus", raidStatus.PENDING) -- uses sh_enums

    --{ RAID FUNCTIONS

        function RAID:StartRaid(raidTime)

            if GetGlobalInt("RaidStatus") != raidStatus.PENDING then return end

            SetGlobalInt("RaidStatus", raidStatus.ACTIVE)
            SetGlobalInt("RaidTimeLeft", raidTime)

            timer.Create("RaidTimerDecrement", 1, 0, DecrementTimer)

            hook.Run("StartedRaid")

        end

        function RAID:EndRaid()

            if GetGlobalInt("RaidStatus") != raidStatus.ACTIVE then return end

            SetGlobalInt("RaidStatus", raidStatus.ENDED)
            SetGlobalInt("RaidTimeLeft", self.VoteTime)

            -- kill players in raid, idk what else

            hook.Run("EndedRaid")

            -- Thanks penal code
            if #player.GetHumans() == 0 then

                local tbl = {}

                for k, v in pairs(self.MapPool) do table.insert(tbl, k) end

                RunConsoleCommand("changelevel", tbl[math.random(#tbl)])

                return

            end

            timer.Adjust("RaidTimerDecrement", 1, self.VoteTime) -- fuck you timer.Adjust

            net.Start("VoteableMaps")

                net.WriteTable(self.MapPool)

            net.Broadcast()

            for k, v in pairs(player.GetHumans()) do

                if not v:CompareStatus(0) then v:Kill() end

            end

        end

        function RAID:SpawnPlayers(plys, status, squad) -- todo: make this support a sequential table of players up to a specified team limit

            if GetGlobalInt("RaidStatus") != raidStatus.ACTIVE then print("raid isnt active") return end
            if #plys > 4 then print("too many fucking people in your team dumbass") return end

            local spawn = GetValidRaidSpawn(status)
            local allSpawns = spawn.Spawns

            table.removeKey(SQUADS, squad)
            NetworkSquadInfoToClients()

            for k, v in ipairs(plys) do

                if v:IsPlayer() then

                    if !v:CompareStatus(0) then

                        local status, spawnGroup = v:GetRaidStatus()

                        print("Player " .. v:GetName() .. " tried to enter the raid with status " .. status .. ", but they're probably fine to join anyway. If they aren't, tell the map maker to separate the lobby and the raid map, thanks.")

                    end

                    net.Start("PlayerEnterRaid")
                    net.Send(v)

                    v:Freeze(true)

                    timer.Create("Spawn" .. v:SteamID64(), 1, 1, function()

                        v:Teleport(allSpawns[k]:GetPos(), allSpawns[k]:GetAngles(), Vector(0, 0, 0))
                        v:Freeze(false)

                        timer.Simple(0.5, function() -- temporary invulnerability bc v:Lock() fucked shit

                            local curTime = math.Round(CurTime(), 0) -- once players spawn, we make their team chat channel more specific, this is so others can create squads of the same name and not conflict with anything

                            v:SetRaidStatus(status, spawn.SpawnGroup or "")
                            v:SetNW2String("PlayerInSquad", "nil")
                            v:SetNW2String("TeamChatChannel", squad .. "_" .. curTime)

                        end)

                    end)

                end

            end

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

            if ply:GetNWBool("HasVoted", false) then ply:PrintMessage(HUD_PRINTTALK, "You have already voted!") return end
            if GetGlobalInt("RaidStatus") != raidStatus.ENDED then ply:PrintMessage(HUD_PRINTTALK, "The raid is still ongoing, your vote has not been counted.") return end
            if self.MapPool[vote] == nil then return end

            self.MapPool[vote] = self.MapPool[vote] + 1

            ply:SetNWBool("HasVoted", true)
            ply:PrintMessage(HUD_PRINTTALK, "Your vote of ".. vote .." has been counted!")

        end

        function RAID.GetCurrentExtracts(ply)

            if ply:CompareStatus(0) then return nil end

            local extracts = {}

            for k, v in pairs( ents.FindByClass("efgm_extract") ) do

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

        function plyMeta:SetRaidStatus(status, spawnGroup)

            status = status or self:GetNWString( "PlayerRaidStatus", 0 )
            spawnGroup = spawnGroup or self:GetNWString( "PlayerSpawnGroup", "" )

            self:SetNWInt( "PlayerRaidStatus", status )
            self:SetNWString("PlayerSpawnGroup", spawnGroup )

        end

        function plyMeta:Teleport(position, angles, velocity)

            -- shortening the extract and raid manager logic lol, not necessary but fun ig idfk

            self:SetPos(position)
            self:SetEyeAngles(angles)
            self:SetLocalVelocity(velocity)

        end

        function plyMeta:GetRaidStatus()

            local status = self:GetNWInt("PlayerRaidStatus", 0)
            local spawnGroup = self:GetNWString("PlayerSpawnGroup", "")

            return status, spawnGroup

        end

    --}

    --{ CONSOLE COMMANDS

        concommand.Add( "efgm_startraid", function() RAID:StartRaid() end )
        concommand.Add("efgm_endraid", function() RAID:EndRaid() end)

        concommand.Add("efgm_setplayerstatus", function(ply, cmd, args)

            if args[1] == nil then return end

            local status = tonumber( args[1] )
            ply:SetRaidStatus(status)

        end)

        concommand.Add("efgm_getplayerstatus", function( ply )

            print( "Status: " .. ply:GetNWInt( "PlayerRaidStatus", 0 ) .. ", Group: " .. ply:GetNWString( "PlayerSpawnGroup", "" ) )

        end)

        concommand.Add("efgm_getraidstatus", function()

            print("Raid Status: " .. GetGlobalInt( "RaidStatus" ) .. ", Raid Time Left: " .. GetGlobalInt( "RaidTimeLeft") )

        end)

    --}

    --{ HOOKS

        hook.Add("PlayerExtraction", "RaidExtract", function(ply, extractTime, isExtractGuranteed)

            lobbySpawns = ents.FindByClass("efgm_lobby_spawn") or {} -- gets a table of all the lobby spawns

            local possibleSpawns = {}

            if table.IsEmpty(lobbySpawns) then error("no lobby spawns eat shit") return end

            -- all this is done so that players spawn in random spots bc yeah it was really that important
            for k, v in ipairs(lobbySpawns) do

                if v:CanSpawn(ply) then

                    table.insert(possibleSpawns, v)

                end

            end

            if #possibleSpawns == 0 then return end

            local randomSpawn = BetterRandom(possibleSpawns)

            ply:Teleport(randomSpawn:GetPos(), randomSpawn:GetAngles(), Vector(0, 0, 0))
            ply:SetHealth( ply:GetMaxHealth() ) -- heals the player to full so dumb shit like quitting and rejoining to get max hp doesn't happen
            ply:SendLua("RunConsoleCommand('r_cleardecals')") -- clear decals for that extra 2 fps

            ply:SetRaidStatus(0, "")
            ply:SetNWBool("RaidReady", false)

        end)

        hook.Add("CheckRaidAddPlayers", "MaybeAddPeople", function( ply )

            local plySquad = ply:GetNW2String("PlayerInSquad", "nil")

            if plySquad == "nil" then RAID:SpawnPlayers({ply}, playerStatus.PMC, "nil") return end

            if table.Count(SQUADS[plySquad].MEMBERS) <= 1 then RAID:SpawnPlayers({ply}, playerStatus.PMC, plySquad) return end

            local plys = {}
            local spawnBool = true

            for k, v in pairs(SQUADS[plySquad].MEMBERS) do

                table.insert(plys, v)

                if v:GetNWBool("RaidReady", false) == false then spawnBool = false end

            end

            if tobool( spawnBool ) == true then

                RAID:SpawnPlayers(plys, playerStatus.PMC, plySquad)

            end

        end)

    --}

    net.Receive("SendVote", function(len, ply)

        RAID:SubmitVote(ply, net.ReadString() )

    end)

end

if CLIENT then

    concommand.Add("efgm_vote", function(ply, cmd, args)

        net.Start("SendVote")
            net.WriteString( args[1] )
        net.SendToServer()

    end)

end

function plyMeta:CompareSpawnGroup(group)

    -- fuck off with your "addons/efgmrewrite/gamemodes/efgmrewrite/entities/entities/efgm_extract.lua:114: unexpected symbol near ')'" bullshit there's fixing to be an unexpected hole in my goddamn monitor
    -- oh i forgot an end

    group = group or ""

    if group == "" then return true end

    return self:GetNWString("PlayerSpawnGroup", "") == group

end

function plyMeta:CompareStatus(status) -- if player is in raid then status of 0 will return false

    return self:GetNWInt("PlayerRaidStatus", 0) == status

end