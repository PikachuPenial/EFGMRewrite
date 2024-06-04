-- spawns players because having a monolithic fucking raid system ALONG with smart spawns made me wanna blow my brains out
-- i mean genuinely who needs 600 lines for a fucking script jesus christ
-- yooo the fuckings on 1 and 2 lined up lets fucking goooooo

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

        return BetterRandom( pmcSpawns )

    end

    if status == 2 then

        local scavSpawns = {}

        for k, v in ipairs(spawns) do
            if v.SpawnType != 1 then
                table.insert(scavSpawns, v)
            end
        end

        return BetterRandom( scavSpawns )

    end
    
end