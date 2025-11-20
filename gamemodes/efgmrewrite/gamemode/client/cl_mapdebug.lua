
-- To make the map image:


-- Take picture of map overhead:

-- Run "sv_cheats 1; cl_drawhud 0; r_drawviewmodel 0; hidepanel all; net_graph 0; r_skybox 0; fog_override 1; fog_enable 0; efgm_hud_enable 0"
-- and
-- "cl_leveloverview [size]"

-- Take screenshot, put image under materials/maps in the addon folder, and use its exact name [map name] through the rest of the process

-- Run "cl_leveloverview 0" or reload map


-- To generate the icons and align them to the map image:


-- Run "efgm_debug_mapreport [map name] true"

-- Now that all map icons and their info are gathered, align their world positions to the map
-- To do that, come up with two easily findable positions (called landmarks in the code) that are pretty far apart

-- Go to first position, run "efgm_debug_setlandmark1"
-- Then go to second position, and run "efgm_debug_setlandmark2"
-- The order you do that in doesn't matter, but copy the numbers from the last command

-- Then run "efgm_debug_drawmap [window width] [window height] [map name] [copied numbers]"

-- Using the sliders, line up the yellow circle to the first landmark, and the purple to the second

-- If everything looks accurate, click the generate button

-- Then run "efgm_debug_drawalignedmap [window width] [window height]" and enter the map name just to check everything got aligned and saved properly

-- Finally, go to garrysmod/data/[map name]_mapreport_final.json, and save that data into sh_map_information.lua to use with the proper map system

local wsLandmark1Xa = 0
local wsLandmark1Ya = 0

local wsLandmark2Xa = 0
local wsLandmark2Ya = 0


concommand.Add("efgm_debug_setlandmark1", function(ply, cmd, args)

    pos = ply:GetPos()
    wsLandmark1Xa = pos.x
    wsLandmark1Ya = pos.y

    print(wsLandmark1Xa .." ".. wsLandmark1Ya .." ".. wsLandmark2Xa .." ".. wsLandmark2Ya)

end)

concommand.Add("efgm_debug_setlandmark2", function(ply, cmd, args)

    pos = ply:GetPos()
    wsLandmark2Xa = pos.x
    wsLandmark2Ya = pos.y

    print(wsLandmark1Xa .." ".. wsLandmark1Ya .." ".. wsLandmark2Xa .." ".. wsLandmark2Ya)

end)


concommand.Add("efgm_debug_drawmap", function(ply, cmd, args)

    local mapSizeX = tonumber( args[1] )
    local mapSizeY = tonumber( args[2] )

    local mapName = args[3]

    local wsLandmark1X = tonumber( args[4] )
    local wsLandmark1Y = tonumber( args[5] )

    local wsLandmark2X = tonumber( args[6] )
    local wsLandmark2Y = tonumber( args[7] )

    local dbmapFrame = vgui.Create("DFrame")
    dbmapFrame:SetSize(mapSizeX, mapSizeY)
    dbmapFrame:Center()
    dbmapFrame:SetTitle("[DEBUG] "..mapName.." Map")
    dbmapFrame:SetVisible(true)
    dbmapFrame:SetDeleteOnClose(true)
    dbmapFrame:MakePopup()

    local mapPanel = vgui.Create("DPanel", dbmapFrame)
    mapPanel:SetSize(mapSizeX, mapSizeY - 240)
    mapPanel:Dock(TOP)

    local mapLandmarkText = vgui.Create("DLabel", dbmapFrame)
    mapLandmarkText:Dock(TOP)
    mapLandmarkText:SetText("Map Space Landmarks")

    local landmark1X = vgui.Create("DNumSlider", dbmapFrame)
    landmark1X:Dock(TOP)
    landmark1X:SetText("Landmark 1 X Pos")
    landmark1X:SetMax(mapSizeX)
    landmark1X:SetMin(0)
    landmark1X:SetDecimals(2)

    local landmark1Y = vgui.Create("DNumSlider", dbmapFrame)
    landmark1Y:Dock(TOP)
    landmark1Y:SetText("Landmark 1 Y Pos")
    landmark1Y:SetMax(mapSizeY - 240)
    landmark1Y:SetMin(0)
    landmark1Y:SetDecimals(2)

    local landmark2X = vgui.Create("DNumSlider", dbmapFrame)
    landmark2X:Dock(TOP)
    landmark2X:SetText("Landmark 2 X Pos")
    landmark2X:SetMax(mapSizeX)
    landmark2X:SetMin(0)
    landmark2X:SetDecimals(2)
    
    local landmark2Y = vgui.Create("DNumSlider", dbmapFrame)
    landmark2Y:Dock(TOP)
    landmark2Y:SetText("Landmark 2 Y Pos")
    landmark2Y:SetMax(mapSizeY - 240)
    landmark2Y:SetMin(0)
    landmark2Y:SetDecimals(2)

    local mapInfo = util.JSONToTable( file.Read(mapName.."_mapreport.json", "DATA") )

    local generateInfo = vgui.Create("DButton", dbmapFrame)
    generateInfo:Dock(TOP)
    generateInfo:SetText("Generate Final "..mapName.." Map JSON")

    function generateInfo:DoClick()

        local factorX = ((landmark2X:GetValue() - landmark1X:GetValue()) / (wsLandmark2X - wsLandmark1X))
        local factorY = ((landmark2Y:GetValue() - landmark1Y:GetValue()) / (wsLandmark2Y - wsLandmark1Y))

        local offsetX = landmark1X:GetValue() - (factorX * wsLandmark1X)
        local offsetY = landmark1Y:GetValue() - (factorY * wsLandmark1Y)

        RunConsoleCommand("efgm_debug_mapreport_final", mapName, "false", tostring(factorX / mapSizeX), tostring(factorY / (mapSizeY - 240)), tostring(offsetX / mapSizeX), tostring(offsetY / (mapSizeY - 240)))

    end

    function mapPanel:Paint(w, h)

        surface.SetDrawColor(255, 255, 255, 255)
        surface.SetMaterial(Material("maps/"..mapName..".png", "smooth"))
        surface.DrawTexturedRect(0, 0, w, h)

        surface.SetDrawColor(52, 124, 218, 240)
        for k, v in pairs(mapInfo.spawns) do

            local factorX = (landmark2X:GetValue() - landmark1X:GetValue()) / (wsLandmark2X - wsLandmark1X)
            local offsetX = landmark1X:GetValue() - (factorX * wsLandmark1X)

            local factorY = (landmark2Y:GetValue() - landmark1Y:GetValue()) / (wsLandmark2Y - wsLandmark1Y)
            local offsetY = landmark1Y:GetValue() - (factorY * wsLandmark1Y)

            surface.DrawCircle( (v.pos.x * factorX) + offsetX, (v.pos.y * factorY) + offsetY, 5 )
            draw.DrawText( "PMC Spawn", "DermaDefault", (v.pos.x * factorX) + offsetX, (v.pos.y * factorY) + offsetY - 20, Color(52, 124, 218, 240), TEXT_ALIGN_CENTER )

        end

        surface.SetDrawColor(19, 196, 34, 240)
        for k, v in pairs(mapInfo.extracts) do

            local factorX = (landmark2X:GetValue() - landmark1X:GetValue()) / (wsLandmark2X - wsLandmark1X)
            local offsetX = landmark1X:GetValue() - (factorX * wsLandmark1X)

            local factorY = (landmark2Y:GetValue() - landmark1Y:GetValue()) / (wsLandmark2Y - wsLandmark1Y)
            local offsetY = landmark1Y:GetValue() - (factorY * wsLandmark1Y)

            surface.DrawCircle( (v.pos.x * factorX) + offsetX, (v.pos.y * factorY) + offsetY, 5 )
            surface.SetTextPos( (v.pos.x * factorX) + offsetX, (v.pos.y * factorY) + offsetY ) 
            draw.DrawText( v.name, "DermaDefault", (v.pos.x * factorX) + offsetX, (v.pos.y * factorY) + offsetY - 20, Color(19, 196, 34, 240), TEXT_ALIGN_CENTER )

        end

        surface.SetDrawColor(202, 20, 20, 240)
        for k, v in pairs(mapInfo.locations) do

            local factorX = (landmark2X:GetValue() - landmark1X:GetValue()) / (wsLandmark2X - wsLandmark1X)
            local offsetX = landmark1X:GetValue() - (factorX * wsLandmark1X)

            local factorY = (landmark2Y:GetValue() - landmark1Y:GetValue()) / (wsLandmark2Y - wsLandmark1Y)
            local offsetY = landmark1Y:GetValue() - (factorY * wsLandmark1Y)

            surface.DrawCircle( (v.pos.x * factorX) + offsetX, (v.pos.y * factorY) + offsetY, 5 )
            surface.SetTextPos( (v.pos.x * factorX) + offsetX, (v.pos.y * factorY) + offsetY ) 
            draw.DrawText( v.name, "DermaDefault", (v.pos.x * factorX) + offsetX, (v.pos.y * factorY) + offsetY - 20, Color(202, 20, 20, 240), TEXT_ALIGN_CENTER )

        end

        surface.SetDrawColor(252, 152, 2, 240)
        for k, v in pairs(mapInfo.keys) do

            local factorX = (landmark2X:GetValue() - landmark1X:GetValue()) / (wsLandmark2X - wsLandmark1X)
            local offsetX = landmark1X:GetValue() - (factorX * wsLandmark1X)

            local factorY = (landmark2Y:GetValue() - landmark1Y:GetValue()) / (wsLandmark2Y - wsLandmark1Y)
            local offsetY = landmark1Y:GetValue() - (factorY * wsLandmark1Y)

            surface.DrawCircle( (v.pos.x * factorX) + offsetX, (v.pos.y * factorY) + offsetY, 3 )
            surface.SetTextPos( (v.pos.x * factorX) + offsetX, (v.pos.y * factorY) + offsetY ) 
            draw.DrawText( v.name, "DermaDefault", (v.pos.x * factorX) + offsetX, (v.pos.y * factorY) + offsetY - 20, Color(252, 152, 2, 240), TEXT_ALIGN_CENTER )

        end
        
        surface.SetDrawColor(Color(251, 255, 0))
        surface.DrawCircle(landmark1X:GetValue(), landmark1Y:GetValue(), 15)
        surface.DrawCircle(landmark1X:GetValue(), landmark1Y:GetValue(), 2)
        surface.SetDrawColor(Color(153, 0, 255))
        surface.DrawCircle(landmark2X:GetValue(), landmark2Y:GetValue(), 15)
        surface.DrawCircle(landmark2X:GetValue(), landmark2Y:GetValue(), 2)

    end

end)


concommand.Add("efgm_debug_drawalignedmap", function(ply, cmd, args)

    local mapSizeX = tonumber( args[1] )
    local mapSizeY = tonumber( args[2] )
    local mapName = tostring( args[3] )

    local mapFrame = vgui.Create("DFrame")
    mapFrame:SetSize(mapSizeX, mapSizeY)
    mapFrame:Center()
    mapFrame:SetTitle("[DEBUG] Aligned Map View")
    mapFrame:SetVisible(true)
    mapFrame:SetDeleteOnClose(true)
    mapFrame:MakePopup()

    local mapNameEntry = vgui.Create("DTextEntry", mapFrame)
    mapNameEntry:Dock(TOP)
    mapNameEntry:SetPlaceholderText("Map Name Here")

    local mapPanel = vgui.Create("DPanel", mapFrame)
    mapPanel:SetSize(mapSizeX, mapSizeY)
    mapPanel:Dock(TOP)

    local mapInfo = nil
    local mapName = ""

    function mapNameEntry:OnEnter()

        mapInfo = util.JSONToTable( file.Read(mapNameEntry:GetValue().."_mapreport_final.json", "DATA") )
        mapName = mapNameEntry:GetValue()

    end

    function mapPanel:Paint(w, h)

        if mapInfo == nil then return end

        surface.SetDrawColor(255, 255, 255, 255)
        surface.SetMaterial(Material("maps/"..mapName..".png", "smooth"))
        surface.DrawTexturedRect(0, 0, w, h)

        surface.SetDrawColor(52, 124, 218, 240)
        for k, v in pairs(mapInfo.spawns) do

            local posX = v.pos.x * mapSizeX
            local posY = v.pos.y * mapSizeY
            surface.DrawCircle(posX, posY, (5 * mapSizeX) / 720 )
            draw.DrawText( "PMC Spawn", "DermaDefault", posX, posY - 20, Color(52, 124, 218, 240), TEXT_ALIGN_CENTER )

        end

        surface.SetDrawColor(19, 196, 34, 240)
        for k, v in pairs(mapInfo.extracts) do

            local posX = v.pos.x * mapSizeX
            local posY = v.pos.y * mapSizeY
            surface.DrawCircle(posX, posY, (10 * mapSizeX) / 720 )
            draw.DrawText( v.name, "DermaDefault", posX, posY - 22, Color(19, 196, 34, 240), TEXT_ALIGN_CENTER )

        end

        surface.SetDrawColor(202, 20, 20, 240)
        for k, v in pairs(mapInfo.locations) do

            local posX = v.pos.x * mapSizeX
            local posY = v.pos.y * mapSizeY
            surface.DrawCircle(posX, posY, (25 * mapSizeX) / 720  )
            draw.DrawText( v.name, "DermaDefault", posX, posY - 32, Color(202, 20, 20, 240), TEXT_ALIGN_CENTER )

        end

        surface.SetDrawColor(252, 152, 2, 240)
        for k, v in pairs(mapInfo.keys) do

            local posX = v.pos.x * mapSizeX
            local posY = v.pos.y * mapSizeY
            surface.DrawCircle(posX, posY, (3 * mapSizeX) / 720  )
            draw.DrawText( v.name, "DermDefaultaDefault", posX, posY - 32, Color(252, 152, 2, 240), TEXT_ALIGN_CENTER )

        end
        
    end

end)
