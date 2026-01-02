
if GetConVar("efgm_derivesbox"):GetInt() == 1 then

    concommand.Add("efgm_debug_mapreport", function(ply, cmd, args)

        local mapReport = {}
        mapReport.spawns = {}
        mapReport.extracts = {}
        mapReport.locations = {}
        mapReport.keys = {}

        for k, v in ipairs(ents.FindByClass("efgm_raid_spawn")) do

            mapReport.spawns[k] = {}
            mapReport.spawns[k].group = v.SpawnGroup
            mapReport.spawns[k].type = v.SpawnType
            local pos = v:GetPos()
            mapReport.spawns[k].pos = {x = pos.x, y = pos.y}

        end

        local hiddenExtracts = 0
        for k, v in ipairs(ents.FindByClass("efgm_extract")) do

            if v.ShowOnMap == false then hiddenExtracts = hiddenExtracts + 1 continue end
            mapReport.extracts[k - hiddenExtracts] = {}
            mapReport.extracts[k - hiddenExtracts].group = v.ExtractGroup
            mapReport.extracts[k - hiddenExtracts].name = v.ExtractName
            mapReport.extracts[k - hiddenExtracts].accessibility = v.Accessibility
            local pos = v:GetPos()
            mapReport.extracts[k - hiddenExtracts].pos = {x = pos.x, y = pos.y}

        end

        local hiddenKeys = 0
        for k, v in ipairs(ents.FindByClass("efgm_key_checker")) do

            if v.ShowOnMap == false then hiddenKeys = hiddenKeys + 1 continue end
            mapReport.keys[k - hiddenKeys] = {}
            mapReport.keys[k - hiddenKeys].name = EFGMITEMS[v.KeyName].fullName
            local pos = v:GetPos()
            mapReport.keys[k - hiddenKeys].pos = {x = pos.x, y = pos.y}

        end

        for k, v in ipairs(ents.FindByClass("efgm_location")) do

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

        for k, v in ipairs(ents.FindByClass("efgm_raid_spawn")) do

            mapReport.spawns[k] = {}
            mapReport.spawns[k].group = v.SpawnGroup
            mapReport.spawns[k].type = v.SpawnType
            local pos = v:GetPos()
            mapReport.spawns[k].pos = {x = (pos.x * factorX) + offsetX, y = (pos.y * factorY) + offsetY}

        end

        local hiddenExtracts = 0
        for k, v in ipairs(ents.FindByClass("efgm_extract")) do

            if v.ShowOnMap == false then hiddenExtracts = hiddenExtracts + 1 continue end
            mapReport.extracts[k - hiddenExtracts] = {}
            mapReport.extracts[k - hiddenExtracts].group = v.ExtractGroup
            mapReport.extracts[k - hiddenExtracts].name = v.ExtractName
            mapReport.extracts[k - hiddenExtracts].accessibility = v.Accessibility
            local pos = v:GetPos()
            mapReport.extracts[k - hiddenExtracts].pos = {x = (pos.x * factorX) + offsetX, y = (pos.y * factorY) + offsetY}

        end

        local hiddenKeys = 0
        for k, v in ipairs(ents.FindByClass("efgm_key_checker")) do

            if v.ShowOnMap == false then hiddenKeys = hiddenKeys + 1 continue end
            mapReport.keys[k - hiddenKeys] = {}
            mapReport.keys[k - hiddenKeys].name = EFGMITEMS[v.KeyName].fullName
            local pos = v:GetPos()
            mapReport.keys[k - hiddenKeys].pos = {x = (pos.x * factorX) + offsetX, y = (pos.y * factorY) + offsetY}

        end

        for k, v in ipairs(ents.FindByClass("efgm_location")) do

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