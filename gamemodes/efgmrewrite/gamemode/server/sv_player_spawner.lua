-- spawns players because having a monolithic fucking raid system ALONG with smart spawns made me wanna blow my brains out
-- i mean genuinely who needs 600 lines for a fucking script jesus christ
-- yooo the fuckings on 1 and 2 lined up lets fucking goooooo

hook.Add("IsSpawnpointSuitable", "CheckSpawnPoint", function(ply, spawnpointent, bMakeSuitable)

    local pos = spawnpointent:GetPos()
    local name = spawnpointent:GetName()

    if name == "efgm_duel_spawn" then return true end -- surely this doesn't happen

    local checkScale = 1280
    if name == "info_player_start" then checkScale = 64 end

    local entities = ents.FindInBox(pos + Vector(checkScale * -1, checkScale * -1, checkScale * -1), pos + Vector(checkScale, checkScale, checkScale))
    local entsBlocking = 0

    if name == "info_player_start" then
        for _, v in ipairs(entities) do
            if v:IsPlayer() and v:CompareStatus(0) then
                entsBlocking = entsBlocking + 1
            end
        end
    else
        for _, v in ipairs(entities) do
            if v:IsPlayer() and !v:CompareStatus(0) and !v:CompareStatus(3) then
                entsBlocking = entsBlocking + 1
            end
        end
    end

    if (entsBlocking > 0) then return false end
    return true

end )

function BetterRandom(haystack) -- this is literally never used ever

    return haystack[math.random(#haystack)]

end

-- raid
function GetValidRaidSpawn(ply, status) -- status: 0 = lobby, 1 = pmc, 2 = scav (assuming 1)

    if status == 0 then return nil end

    local spawns = ents.FindByClass("efgm_raid_spawn")

    if status == 1 then

        local pmcSpawns = {}

        for k, v in ipairs(spawns) do
            if v.SpawnType != 2 then
                table.insert(pmcSpawns, v)
            end
        end

        local size = table.Count(pmcSpawns)

        for i = 0, size do
            local randomSpawn = math.random(#pmcSpawns)

            if (hook.Call("IsSpawnpointSuitable", GAMEMODE, ply, pmcSpawns[randomSpawn], false)) then
                return pmcSpawns[randomSpawn]
            end
        end

        local randomSpawn = math.random(#pmcSpawns)
        return pmcSpawns[randomSpawn]

    end

    if status == 2 then

        local scavSpawns = {}

        for k, v in ipairs(spawns) do
            if v.SpawnType != 1 then
                table.insert(scavSpawns, v)
            end
        end

        local size = table.Count(scavSpawns)

        for i = 0, size do
            local randomSpawn = math.random(#scavSpawns)

            if (hook.Call("IsSpawnpointSuitable", GAMEMODE, ply, scavSpawns[randomSpawn], false)) then
                return scavSpawns[randomSpawn]
            end
        end

        local randomSpawn = math.random(#scavSpawns)
        return scavSpawns[randomSpawn]

    end

end

-- hideout
-- on a normal spawn
function GM:PlayerSelectSpawn(ply)

    local spawns = ents.FindByClass("info_player_start")
    local size = table.Count(spawns)

    for i = 0, size do
        local randomSpawn = math.random(#spawns)

        if (hook.Call("IsSpawnpointSuitable", GAMEMODE, ply, spawns[randomSpawn], false)) then
            return spawns[randomSpawn]
        end
    end

    local randomSpawn = math.random(#spawns)
    return spawns[randomSpawn]

end

-- on extract (literally just a duplicate of the function above lololol!!1!)
function GetValidHideoutSpawn(ply)

    local spawns = ents.FindByClass("info_player_start")
    local size = table.Count(spawns)

    for i = 0, size do
        local randomSpawn = math.random(#spawns)

        if (hook.Call("IsSpawnpointSuitable", GAMEMODE, ply, spawns[randomSpawn], false)) then
            return spawns[randomSpawn]
        end
    end

    local randomSpawn = math.random(#spawns)
    return spawns[randomSpawn]

end

-- duels
function RandomDuelSpawns()

    local spawns = ents.FindByClass("efgm_duel_spawn")
    table.Shuffle(spawns)
    return spawns

end