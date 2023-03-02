-- spawns players because having a monolithic fucking raid system ALONG with smart spawns made me wanna blow my brains out
-- i mean genuinely who needs 600 lines for a fucking script jesus christ
-- yooo the fuckings on 1 and 2 lined up lets fucking goooooo

local spawns = {}
local pmcSpawns = {}
local scavSpawns = {}

spawns = ents.FindByClass( "efgm_raid_spawn" )

pmcSpawns = for k, v in pairs(spawns) do if v.SpawnType != 2 then table.insert(pmcSpawns, v) end
scavSpawns = for k, v in pairs(spawns) do if v.SpawnType != 1 then table.insert(pmcSpawns, v) end

function SetPlayerStatus(player, spawnGroup, status)
	
end