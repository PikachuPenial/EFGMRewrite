

concommand.Add("efgm_debug_mapreport", function(ply, cmd, args)
    
    local mapReport = {}
    mapReport.spawns = {}
    mapReport.extracts = {}
    mapReport.locations = {}

    for k, v in pairs(ents.FindByClass("efgm_raid_spawn")) do
        
        mapReport.spawns[k] = {}
        mapReport.spawns[k].group = v.SpawnGroup
        local pos = v:GetPos()
        mapReport.spawns[k].pos = {x = pos.x, y = pos.y}

    end

    for k, v in pairs(ents.FindByClass("efgm_extract")) do
        
        mapReport.extracts[k] = {}
        mapReport.extracts[k].group = v.ExtractGroup
        mapReport.extracts[k].name = v.ExtractName
        local pos = v:GetPos()
        mapReport.extracts[k].pos = {x = pos.x, y = pos.y}

    end

    for k, v in pairs(ents.FindByClass("efgm_location")) do

        mapReport.locations[k] = {}
        mapReport.locations[k].name = v.DisplayName
        mapReport.locations[k].loot = v.LootRating
        local pos = v:GetPos()
        mapReport.locations[k].pos = {x = pos.x, y = pos.y}
        mapReport.locations[k].keys = {}

        for l, b in pairs(ents.FindByName("*".. string.lower( v.Name ).."*")) do
            
            mapReport.locations[k].keys[l] = b.KeyName

        end
        
    end

    local json = util.TableToJSON(mapReport, tobool( args[2] ) or false)
    print("File ("..(args[1] or "map").."_mapreport.json"..") written to (garrysmod/data)!")
	file.Write((args[1] or "map").."_mapreport.json", json)

end)

concommand.Add("efgm_mapreport_final", function(ply, cmd, args)
    
    local mapReport = {}
    mapReport.spawns = {}
    mapReport.extracts = {}
    mapReport.locations = {}

    for k, v in pairs(ents.FindByClass("efgm_raid_spawn")) do
        
        mapReport.spawns[k] = {}
        mapReport.spawns[k].group = v.SpawnGroup
        local pos = v:GetPos()
        mapReport.spawns[k].pos = {x = (pos.x * args[3]) + args[5], y = (pos.y * args[4]) + args[6]}

    end

    for k, v in pairs(ents.FindByClass("efgm_extract")) do
        
        mapReport.extracts[k] = {}
        mapReport.extracts[k].group = v.ExtractGroup
        mapReport.extracts[k].name = v.ExtractName
        local pos = v:GetPos()
        mapReport.extracts[k].pos = {x = (pos.x * args[3]) + args[5], y = (pos.y * args[4]) + args[6]}

    end

    for k, v in pairs(ents.FindByClass("efgm_location")) do

        mapReport.locations[k] = {}
        mapReport.locations[k].name = v.DisplayName
        mapReport.locations[k].loot = v.LootRating
        local pos = v:GetPos()
        mapReport.locations[k].pos = {x = (pos.x * args[3]) + args[5], y = (pos.y * args[4]) + args[6]}
        mapReport.locations[k].keys = {}

        for l, b in pairs(ents.FindByName("*".. string.lower( v.Name ).."*")) do
            
            mapReport.locations[k].keys[l] = b.KeyName

        end
        
    end

    local json = util.TableToJSON(mapReport, tobool( args[2] ) or false)
    print("File ("..(args[1] or "map").."_mapreport_final.json"..") written to (garrysmod/data)!")
	file.Write((args[1] or "map").."_mapreport_final.json", json)

end)