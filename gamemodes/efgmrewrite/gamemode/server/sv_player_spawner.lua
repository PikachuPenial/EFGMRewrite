-- spawns players because having a monolithic fucking raid system ALONG with smart spawns made me wanna blow my brains out
-- i mean genuinely who needs 600 lines for a fucking script jesus christ
-- yooo the fuckings on 1 and 2 lined up lets fucking goooooo

hook.Add("IsSpawnpointSuitable", "CheckSpawnPoint", function(ply, spawnpointent, bMakeSuitable)
	local pos = spawnpointent:GetPos()

	local entities = ents.FindInBox(pos + Vector(-2048, -2048, -1024), pos + Vector(2048, 2048, 1024))
	local entsBlocking = 0

	for _, v in ipairs(entities) do
		if (v:IsPlayer() and v:Alive()) then
			entsBlocking = entsBlocking + 1
		end
	end

	if (entsBlocking > 0) then return false end
	return true
end )

local spawns

function BetterRandom(haystack) -- this is literally never used ever
    return haystack[math.random(#haystack)]
end

function GetValidRaidSpawn(status) -- status: 0 = lobby, 1 = pmc, 2 = scav (assuming 1)
    if status == 0 then return nil end

    spawns = ents.FindByClass("efgm_raid_spawn")

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

            if (hook.Call("IsSpawnpointSuitable", GAMEMODE, ply, pmcSpawns[randomSpawn], i == size)) then
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

            if (hook.Call("IsSpawnpointSuitable", GAMEMODE, ply, scavSpawns[randomSpawn], i == size)) then
                return scavSpawns[randomSpawn]
            end
        end

        local randomSpawn = math.random(#scavSpawns)
        return scavSpawns[randomSpawn]
    end
end