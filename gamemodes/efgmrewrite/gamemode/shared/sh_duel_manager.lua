DUEL = {}

local plyMeta = FindMetaTable("Player")
if not plyMeta then Error("Could not find player table") return end

if SERVER then

    util.AddNetworkString("PlayerDeulTransition")

    SetGlobalInt("DuelStatus", deulStatus.PENDING)

    function DUEL:StartRaid(ply1, ply2)

        if GetGlobalInt("DuelStatus") != deulStatus.PENDING then return end

        SetGlobalInt("DuelStatus", deulStatus.ACTIVE)

        hook.Run("StartedDeul")

        local plys = {ply1, ply2}

        net.Start("PlayerDeulTransition")
        net.Send(plys)

        for k, v in ipairs(plys) do

            v:Freeze(true)

            timer.Create("Duel" .. v:SteamID64(), 1, 1, function()
                local spawn = GetValidRaidSpawn(status)
                local allSpawns = spawn.Spawns
                v:Teleport(allSpawns[k]:GetPos(), allSpawns[k]:GetAngles(), Vector(0, 0, 0))
                v:Freeze(false)

                timer.Simple(0.5, function()

                    v:SetRaidStatus(playerStatus.DUEL)
                    v:SetNWInt("DeulsPlayed", v:GetNWInt("DeulsPlayed") + 1)
                    ResetRaidStats(v) -- because im lazy and won't make a special death overview

                end)

            end)

        end

    end

    function DUEL:EndRaid(ply1, ply2)

        if GetGlobalInt("DuelStatus") != deulStatus.ACTIVE then return end

        SetGlobalInt("DuelStatus", deulStatus.PENDING)

        hook.Run("EndedDeul")

    end

    hook.Add("PlayerDisconnected", "DisconnectWhileInDeul", function(ply)

        if ply:CompareStatus(3) then



        end

    end)

end