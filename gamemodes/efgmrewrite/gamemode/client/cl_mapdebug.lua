
concommand.Add("efgm_debug_drawmap", function(ply, cmd, args)

    local mapSizeX = tonumber( args[1] )
    local mapSizeY = tonumber( args[2] )

    local wsLandmark1X = tonumber( args[3] )
    local wsLandmark1Y = tonumber( args[4] )

    local wsLandmark2X = tonumber( args[5] )
    local wsLandmark2Y = tonumber( args[6] )

    local dbmapFrame = vgui.Create("DFrame")
    dbmapFrame:SetSize(mapSizeX, mapSizeY)
    dbmapFrame:Center()
    dbmapFrame:SetTitle("")
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

    local mapInfo = util.JSONToTable( file.Read("concrete_mapreport.json", "DATA") )

    local printInfoButtom = vgui.Create("DButton", dbmapFrame)
    printInfoButtom:Dock(TOP)
    printInfoButtom:SetText("Print Map Factor and Offset to Console")

    function printInfoButtom:DoClick()

        local factorX = ((landmark2X:GetValue() - landmark1X:GetValue()) / (wsLandmark2X - wsLandmark1X))
        local factorY = ((landmark2Y:GetValue() - landmark1Y:GetValue()) / (wsLandmark2Y - wsLandmark1Y))

        local offsetX = landmark1X:GetValue() - (factorX * wsLandmark1X)
        local offsetY = landmark1Y:GetValue() - (factorY * wsLandmark1Y)

        print(factorX / mapSizeX.." "..factorY / (mapSizeY - 240).." "..offsetX / mapSizeX.." "..offsetY / (mapSizeY - 240))
    end

    function mapPanel:Paint(w, h)

        surface.SetDrawColor(255, 255, 255, 255)
        surface.SetMaterial(Material("maps/concrete.png", "smooth"))
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
        
        surface.SetDrawColor(Color(179, 255, 0))
        surface.DrawCircle(landmark1X:GetValue(), landmark1Y:GetValue(), 4)
        surface.SetDrawColor(Color(255, 0, 179))
        surface.DrawCircle(landmark2X:GetValue(), landmark2Y:GetValue(), 4)

    end

end)


concommand.Add("efgm_drawalignedmap", function(ply, cmd, args)

    local mapSizeX = tonumber( args[1] )
    local mapSizeY = tonumber( args[2] )

    local mapFrame = vgui.Create("DFrame")
    mapFrame:SetSize(mapSizeX, mapSizeY)
    mapFrame:Center()
    mapFrame:SetTitle("")
    mapFrame:SetVisible(true)
    mapFrame:SetDeleteOnClose(true)
    mapFrame:MakePopup()

    local mapPanel = vgui.Create("DPanel", mapFrame)
    mapPanel:SetSize(mapSizeX, mapSizeY)
    mapPanel:Dock(TOP)

    local mapInfo = util.JSONToTable( file.Read("concrete_mapreport_final.json", "DATA") )

    function mapPanel:Paint(w, h)

        surface.SetDrawColor(255, 255, 255, 255)
        surface.SetMaterial(Material("maps/concrete.png", "smooth"))
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
        
    end

end)