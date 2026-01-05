-- spawns players because having a monolithic fucking raid system ALONG with smart spawns made me wanna blow my brains out
-- i mean genuinely who needs 600 lines for a fucking script jesus christ
-- yooo the fuckings on 1 and 2 lined up lets fucking goooooo

-- raid
function GetValidRaidSpawn(status) -- status: 0 = lobby, 1 = pmc, 2 = scav (assuming 1)

    if status == 0 then status = 1 end -- shouldn't be possible but i am going to play it safe

    local spawns = ents.FindByClass("efgm_raid_spawn")
    table.Shuffle(spawns)

    local radius = MAPS[game.GetMap()].spawnProt or 1000

    for _, spawn in ipairs(spawns) do

        if status == 1 and spawn.SpawnType == 2 then continue end
        if status == 2 and spawn.SpawnType == 1 then continue end

        local entities = ents.FindInSphere(spawn:GetPos(), radius)
        local blocked = false

        for _, e in ipairs(entities) do

            if e:IsPlayer() and e:Alive() and !e:CompareStatus(0) and !e:CompareStatus(3) then

                blocked = true
                break

            end

        end

        if !blocked then return spawn end

    end

    return BetterRandom(spawns) -- yes, this can spawn someone at another factions spawn, it should never happen anyways so i cant be bothered

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

            if e:IsPlayer() and e:Alive() and !e:CompareStatus(1) and !e:CompareStatus(2) then

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