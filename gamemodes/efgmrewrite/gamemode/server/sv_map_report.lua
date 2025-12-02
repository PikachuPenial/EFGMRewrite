
if GetConVar("efgm_derivesbox"):GetInt() == 1 then

    concommand.Add("efgm_debug_mapreport", function(ply, cmd, args)
        
        local mapReport = {}
        mapReport.spawns = {}
        mapReport.extracts = {}
        mapReport.locations = {}
        mapReport.keys = {}

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

        for k, v in pairs(ents.FindByClass("efgm_key_checker")) do
            
            mapReport.keys[k] = {}
            mapReport.keys[k].name = EFGMITEMS[v.KeyName].fullName
            local pos = v:GetPos()
            mapReport.keys[k].pos = {x = pos.x, y = pos.y}

        end

        for k, v in pairs(ents.FindByClass("efgm_location")) do

            mapReport.locations[k] = {}
            mapReport.locations[k].name = v.DisplayName
            mapReport.locations[k].loot = v.LootRating
            local pos = v:GetPos()
            mapReport.locations[k].pos = {x = pos.x, y = pos.y}
            
        end

        local json = util.TableToJSON(mapReport, tobool( args[2] ) or false)
        print("File ("..(args[1] or "map").."_mapreport.json"..") written to (garrysmod/data)!")
        file.Write((args[1] or "map").."_mapreport.json", json)

    end)

    concommand.Add("efgm_debug_mapreport_final", function(ply, cmd, args)

        local factorX = tonumber( args[3] )
        local factorY = tonumber( args[4] )
        
        local offsetX = tonumber( args[5] )
        local offsetY = tonumber( args[6] )

        local mapReport = {}
        mapReport.spawns = {}
        mapReport.extracts = {}
        mapReport.locations = {}
        mapReport.keys = {}
        mapReport.factor = {x = factorX, y = factorY}
        mapReport.offset = {x = offsetX, y = offsetY}

        for k, v in pairs(ents.FindByClass("efgm_raid_spawn")) do
            
            mapReport.spawns[k] = {}
            mapReport.spawns[k].group = v.SpawnGroup
            local pos = v:GetPos()
            mapReport.spawns[k].pos = {x = (pos.x * factorX) + offsetX, y = (pos.y * factorY) + offsetY}

        end

        for k, v in pairs(ents.FindByClass("efgm_extract")) do
            
            mapReport.extracts[k] = {}
            mapReport.extracts[k].group = v.ExtractGroup
            mapReport.extracts[k].name = v.ExtractName
            local pos = v:GetPos()
            mapReport.extracts[k].pos = {x = (pos.x * factorX) + offsetX, y = (pos.y * factorY) + offsetY}

        end

        for k, v in pairs(ents.FindByClass("efgm_key_checker")) do
            
            mapReport.keys[k] = {}
            mapReport.keys[k].name = EFGMITEMS[v.KeyName].fullName
            local pos = v:GetPos()
            mapReport.keys[k].pos = {x = (pos.x * factorX) + offsetX, y = (pos.y * factorY) + offsetY}

        end

        for k, v in pairs(ents.FindByClass("efgm_location")) do

            mapReport.locations[k] = {}
            mapReport.locations[k].name = v.DisplayName
            mapReport.locations[k].loot = v.LootRating
            local pos = v:GetPos()
            mapReport.locations[k].pos = {x = (pos.x * factorX) + offsetX, y = (pos.y * factorY) + offsetY}
            
        end

        local json = util.TableToJSON(mapReport, tobool( args[2] ) or false)
        print("File ("..(args[1] or "map").."_mapreport_final.json"..") written to (garrysmod/data)!")
        print(json)
        file.Write((args[1] or "map").."_mapreport_final.json", json)

    end)

end