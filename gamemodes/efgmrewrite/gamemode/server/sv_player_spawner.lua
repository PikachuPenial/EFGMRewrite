-- spawns players because having a monolithic fucking raid system ALONG with smart spawns made me wanna blow my brains out
-- i mean genuinely who needs 600 lines for a fucking script jesus christ
-- yooo the fuckings on 1 and 2 lined up lets fucking goooooo

-- raid
function GetValidRaidSpawn(status)

    if status == 0 or status == 3 then status = 1 end -- shouldn't be possible but i am going to play it safe

    local spawns = ents.FindByClass("efgm_raid_spawn")
    table.Shuffle(spawns)

    local radius = tonumber(MAPS[game.GetMap()].spawnProt) or 1000

    for _, spawn in ipairs(spawns) do

        if status == 1 and spawn.SpawnType == 2 then continue end
        if status == 2 and spawn.SpawnType == 1 then continue end
        if spawn.Pending == true then continue end

        local spawnRad = (spawn.SpawnRadiusOverride > 0 and spawn.SpawnRadiusOverride) or radius

        local entities = ents.FindInSphere(spawn:GetPos(), spawnRad)
        local blocked = false

        for _, e in ipairs(entities) do

            -- player
            if e:IsPlayer() and e:Alive() and (e:CompareStatus(1) or e:CompareStatus(2)) and !e:GetNWBool("PlayerInIntro", false) then

                blocked = true
                break

            end

        end

        if !blocked then return spawn end

    end

    -- fallback if no spawn is suitable
    local plys = player.GetHumans()
    local safestSpawn = nil
    local maxMinDistance = -1

    table.Shuffle(spawns)

    for _, spawn in ipairs(spawns) do

        if status == 1 and spawn.SpawnType == 2 then continue end
        if status == 2 and spawn.SpawnType == 1 then continue end
        if spawn.Pending == true then continue end

        local minDistance = math.huge

        for _, ply in ipairs(plys) do

            if ply:Alive() and (ply:CompareStatus(1) or ply:CompareStatus(2)) and !ply:GetNWBool("PlayerInIntro", false) then

                local distance = spawn:GetPos():DistToSqr(ply:GetPos())
                minDistance = math.min(minDistance, distance)

            end

        end

        if minDistance > maxMinDistance then

            maxMinDistance = minDistance
            safestSpawn = spawn

        end

    end

    return safestSpawn

end

-- hideout
-- on extract
function GetValidHideoutSpawn(spawnType)

    -- 0: normal spawn
    -- 1: extracted from raid
    -- 2: won duel

    local spawns
    if spawnType == 1 then spawns = ents.FindByClass("efgm_lobby_spawn") elseif spawnType == 2 then spawns = (ents.FindByClass("efgm_duel_end_spawn") or ents.FindByClass("efgm_lobby_spawn")) else spawns = ents.FindByClass("info_player_start") end
    table.Shuffle(spawns)

    for _, spawn in ipairs(spawns) do

        local entities = ents.FindInSphere(spawn:GetPos(), 32)
        local blocked = false

        for _, e in ipairs(entities) do

            if !e:IsPlayer() then continue end
            if e:Alive() and (e:CompareStatus(0) or e:CompareStatus(3)) then

                blocked = true
                break

            end

        end

        if !blocked then return spawn end

    end

    return BetterRandom(spawns)

end

-- on a normal spawn
hook.Add("PlayerSelectSpawn", "HideoutSpawning", function(ply)

    return GetValidHideoutSpawn(0)

end)

-- duels
function RandomDuelSpawns()

    local spawns = ents.FindByClass("efgm_duel_spawn")
    table.Shuffle(spawns)
    return spawns

end

if GetConVar("efgm_derivesbox"):GetInt() == 1 then

    function PrintSpawnStatuses()

        local spawns = ents.FindByClass("efgm_raid_spawn")
        for _, spawn in ipairs(spawns) do

            print("[" .. string.upper(spawn.SpawnName) .. "]")
            print("pending: " .. tostring(spawn.Pending))
            print("type: " .. spawn.SpawnType)

        end

    end
    concommand.Add("efgm_debug_printspawns", function(ply, cmd, args) PrintSpawnStatuses() end)

end