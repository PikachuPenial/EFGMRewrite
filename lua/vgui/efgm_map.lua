local PANEL = {}

PANEL.IsDragging = false

PANEL.DragPos = {x = 0, y = 0}
PANEL.PanOffset = {x = 0, y = 0}

function PANEL:ClampPanOffset()

    local panelW, panelH = self.MapHolderX, self.MapHolderY
    local zoom = self.Zoom
    local pan = self.PanOffset

    local contentScreenW = self.MapSizeX * zoom
    local contentScreenH = self.MapSizeY * zoom

    local minPanX, maxPanX
    local minPanY, maxPanY

    if contentScreenW > panelW then

        minPanX = panelW - contentScreenW
        maxPanX = 0

    else

        minPanX = (panelW - contentScreenW) / 2
        maxPanX = minPanX

    end

    if contentScreenH > panelH then

        minPanY = panelH - contentScreenH
        maxPanY = 0

    else

        minPanY = (panelH - contentScreenH) / 2
        maxPanY = minPanY

    end

    self.PanOffset.x = math.Clamp(pan.x, minPanX, maxPanX)
    self.PanOffset.y = math.Clamp(pan.y, minPanY, maxPanY)

end

-- most of this was vibe coded, and im genuinely scared how well it works
-- lmao bro vibe codes
function PANEL:OnMouseWheeled(delta)

    local oldZoom = self.Zoom
    local zoomSpeed = 0.1
    self.Zoom = math.Clamp(self.Zoom + delta * zoomSpeed, self.MinZoom, self.MaxZoom)

    local newZoom = self.Zoom

    if newZoom == oldZoom then return true end

    local mouseX, mouseY = self:CursorPos()

    self.PanOffset.x = mouseX - ((mouseX - self.PanOffset.x) / oldZoom) * newZoom
    self.PanOffset.y = mouseY - ((mouseY - self.PanOffset.y) / oldZoom) * newZoom

    self:ClampPanOffset()

end

function PANEL:OnMousePressed(mouseCode)

    if mouseCode == MOUSE_LEFT then

        self.IsDragging = true
        self.DragPos.x, self.DragPos.y = gui.MousePos()
        self:MouseCapture(true)

    end

end

function PANEL:OnMouseReleased(mouseCode)

    if mouseCode == MOUSE_LEFT then

        self.IsDragging = false
        self:MouseCapture(false)

    end

end

function PANEL:Think()

    if self.IsDragging then

        local mx, my = gui.MousePos()
        local dx = mx - self.DragPos.x
        local dy = my - self.DragPos.y

        self.PanOffset.x = self.PanOffset.x + dx / self.Zoom
        self.PanOffset.y = self.PanOffset.y + dy / self.Zoom

        self:ClampPanOffset()

        self.DragPos.x, self.DragPos.y = mx, my

    end

end

function PANEL:Paint(w, h)

    if self.OverheadImage == nil then return end

    surface.SetDrawColor(Colors.pureWhiteColor)
    surface.SetMaterial(self.OverheadImage)
    surface.DrawTexturedRect(0 + self.PanOffset.x, 0 + self.PanOffset.y, w * self.Zoom, h * self.Zoom)

    if self.MapInfo == nil then return end

    if self.DrawFullInfo then

        surface.SetDrawColor(Colors.mapSpawn)
        for k, v in pairs(self.MapInfo.spawns) do

            local posX = (v.pos.x * self.MapSizeX * self.Zoom) + self.PanOffset.x
            local posY = (v.pos.y * self.MapSizeY * self.Zoom) + self.PanOffset.y

            surface.SetDrawColor(Colors.mapWhite)
            surface.SetMaterial(Mats.mapSpawn)
            surface.DrawTexturedRect(posX - 16, posY - 16, 32, 32)

        end

        surface.SetDrawColor(Colors.mapExtract)
        for k, v in pairs(self.MapInfo.extracts) do

            local posX = (v.pos.x * self.MapSizeX * self.Zoom) + self.PanOffset.x
            local posY = (v.pos.y * self.MapSizeY * self.Zoom) + self.PanOffset.y

            surface.SetDrawColor(Colors.mapWhite)
            surface.SetMaterial(Mats.mapExtract)
            surface.DrawTexturedRect(posX - 16, posY - 16, 32, 32)

            local text = v.name
            draw.DrawText(text, "PuristaBold16", posX, posY - 36, Colors.mapExtract, TEXT_ALIGN_CENTER)

        end

        surface.SetDrawColor(Colors.mapLocation)
        for k, v in pairs(self.MapInfo.locations) do

            local posX = (v.pos.x * self.MapSizeX * self.Zoom) + self.PanOffset.x
            local posY = (v.pos.y * self.MapSizeY * self.Zoom) + self.PanOffset.y

            surface.SetDrawColor(Colors.mapWhite)
            surface.SetMaterial(Mats.mapLocation)
            surface.DrawTexturedRect(posX - 32, posY - 32, 64, 64)

            draw.DrawText( v.name, "PuristaBold16", posX, posY - 48, Colors.mapLocation, TEXT_ALIGN_CENTER)
            draw.DrawText( "Loot: " .. v.loot .. "/5", "PuristaBold14", posX, posY + 32, Colors.mapLocation, TEXT_ALIGN_CENTER)

        end

        surface.SetDrawColor(Colors.mapKey)
        for k, v in pairs(self.MapInfo.keys) do

            local posX = (v.pos.x * self.MapSizeX * self.Zoom) + self.PanOffset.x
            local posY = (v.pos.y * self.MapSizeY * self.Zoom) + self.PanOffset.y

            surface.SetDrawColor(Colors.mapWhite)
            surface.SetMaterial(Mats.mapKey)
            surface.DrawTexturedRect(posX - 16, posY - 16, 32, 32)

            draw.DrawText( v.name, "PuristaBold16", posX, posY - 36, Colors.mapKey, TEXT_ALIGN_CENTER )

        end

    end

    if !self.DrawRaidInfo or InsideRaidLength == nil then return end

    local timeToDraw = math.min(InsideRaidLength / 4, 60)

    local progress = (SysTime() % timeToDraw) / timeToDraw

    local previousPos = {}
    local startPos = {}

    for k, v in pairs(RaidPositions) do

        local posX = (v.x * self.MapSizeX * self.Zoom) + self.PanOffset.x
        local posY = (v.y * self.MapSizeY * self.Zoom) + self.PanOffset.y

        if !table.IsEmpty(previousPos) then

            local distance = math.sqrt((posX - previousPos.x) ^ 2 + (posY - previousPos.y) ^ 2)

            -- this line thickness thing took me like an hour to figure out with a pencil and paper, but shatgpt can lick my balls
            local normal = {x = (posX - previousPos.x) / distance * 1.5, y = (posY - previousPos.y) / distance * 1.5}
            local perpNormal = {x = normal.y, y = -normal.x}

            local thickenedLine = {

                {x = posX + normal.x + perpNormal.x, y = posY + normal.y + perpNormal.y},
                {x = posX + normal.x - perpNormal.x, y = posY + normal.y - perpNormal.y},
                {x = previousPos.x - normal.x - perpNormal.x, y = previousPos.y - normal.y - perpNormal.y},
                {x = previousPos.x - normal.x + perpNormal.x, y = previousPos.y - normal.y + perpNormal.y}

            }
            if k / #RaidPositions <= progress then
                surface.SetDrawColor(Colors.mapOverviewLine)
            else
                surface.SetDrawColor(Colors.mapOverviewLoadedLine)
            end
            draw.NoTexture()
            surface.DrawPoly(thickenedLine)

        else

            startPos = {x = posX, y = posY}

        end

        previousPos = {x = posX, y = posY}

    end

    if !table.IsEmpty(DeathPosition) then

        local posX = (DeathPosition.x * self.MapSizeX * self.Zoom) + self.PanOffset.x
        local posY = (DeathPosition.y * self.MapSizeY * self.Zoom) + self.PanOffset.y

        surface.SetDrawColor(Colors.mapWhite)
        surface.SetMaterial(Mats.mapOverviewDeath)
        surface.DrawTexturedRect(posX - 16, posY - 16, 32, 32)

    else

        local posX = (RaidPositions[#RaidPositions].x * self.MapSizeX * self.Zoom) + self.PanOffset.x
        local posY = (RaidPositions[#RaidPositions].y * self.MapSizeY * self.Zoom) + self.PanOffset.y

        surface.SetDrawColor(Colors.mapWhite)
        surface.SetMaterial(Mats.mapOverviewExtract)
        surface.DrawTexturedRect(posX - 16, posY - 16, 32, 32)

    end


    surface.SetDrawColor(Colors.mapOverviewLine)
    for k, v in pairs(KillPositions) do

        local posX = (v.x * self.MapSizeX * self.Zoom) + self.PanOffset.x
        local posY = (v.y * self.MapSizeY * self.Zoom) + self.PanOffset.y

        if v.time / #RaidPositions <= progress then
            surface.SetDrawColor(Colors.mapWhite)
        else
            surface.SetDrawColor(Colors.mapOverviewUnloadedKill)
        end
        surface.SetMaterial(Mats.mapOverviewKill)
        surface.DrawTexturedRect(posX - 16, posY - 16, 32, 32)

    end

    surface.SetDrawColor(Colors.mapWhite)
    surface.SetMaterial(Mats.mapOverviewSpawn)
    surface.DrawTexturedRect(startPos.x - 16, startPos.y - 26, 32, 32)

end

vgui.Register("EFGMMap", PANEL, "DPanel")