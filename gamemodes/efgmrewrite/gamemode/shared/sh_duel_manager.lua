DUEL = {}

local plyMeta = FindMetaTable("Player")
if !plyMeta then Error("Could not find player table") return end

if SERVER then

    util.AddNetworkString("PlayerDuelTransition")

    SetGlobalInt("DuelStatus", duelStatus.PENDING)

    function DUEL:StartRaid(ply1, ply2)

        if GetGlobalInt("DuelStatus") != duelStatus.PENDING then return end

        local spawns = RandomDuelSpawns()
        if !spawns then return end -- no duel spawns available on the map

        SetGlobalInt("DuelStatus", duelStatus.ACTIVE)

        hook.Run("StartedDuel")

        local plys = {ply1, ply2}

        net.Start("PlayerDuelTransition")
        net.Send(plys)

        PrintTable(spawns)

        for k, v in ipairs(plys) do -- there is literally no reason for this to have more than 2 players, so i will asssume that it is 2 players

            v:Freeze(true)

            timer.Create("Duel" .. v:SteamID64(), 1, 1, function()

                v:Teleport(spawns[k]:GetPos(), spawns[k]:GetAngles(), Vector(0, 0, 0))
                v:Freeze(false)

                timer.Simple(0.1, function()

                    v:SetRaidStatus(playerStatus.DUEL, "")
                    v:SetNWInt("DuelsPlayed", v:GetNWInt("DuelsPlayed") + 1)
                    ResetRaidStats(v) -- because im lazy and won't make a special death overview

                end)

                timer.Simple(1, function()

                    v:GetNWInt("PlayerRaidStatus", 0)

                end)

            end)

        end

    end

    function DUEL:EndRaid(ply1, ply2)

        if GetGlobalInt("DuelStatus") != duelStatus.ACTIVE then return end

        SetGlobalInt("DuelStatus", duelStatus.PENDING)

        hook.Run("EndedDuel")

    end

    hook.Add("PlayerDisconnected", "DisconnectWhileInDuel", function(ply)

        if ply:CompareStatus(3) then



        end

    end)

end