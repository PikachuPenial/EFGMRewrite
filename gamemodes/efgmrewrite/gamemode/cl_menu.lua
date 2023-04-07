
-- establishes global menu object, this will have tabs and will handle shit like shop, player progression, in-raid shit, other stuff
-- this is not a panel, but a collection of panels and supporting functions
Menu = {}

Menu.IsInitialized  = false
Menu.IsOpen         = false

-- called non-globally to initialize the menu, that way it can only be initialized once by Menu:Open()
-- also openTab is the name of the tab it should open to
function Menu:Initialize( openTab )

    self.IsInitialized = true

    local menuFrame = vgui.Create("DFrame")
    menuFrame:SetSize( 1500, 800 ) 
    menuFrame:Center()
    menuFrame:SetTitle( "EFGM Main Menu" ) 
    menuFrame:SetVisible( true ) 
    menuFrame:SetDraggable( false ) 
    menuFrame:SetDeleteOnClose(false)
    menuFrame:ShowCloseButton( true ) 
    menuFrame:MakePopup()
    menuFrame:SetBackgroundBlur(true)

    function menuFrame:OnClose()
        Menu.IsOpen = false
    end

    self.MenuFrame = menuFrame

    local tabParentPanel = vgui.Create("DPanel", self.MenuFrame)
    tabParentPanel:Dock(TOP)
    tabParentPanel:SetSize(0, 20)

    function tabParentPanel:Paint(w, h)

        surface.SetDrawColor(0, 0, 0, 50)
        surface.DrawRect(0, 0, w, h)

    end

    self.MenuFrame.TabParentPanel = tabParentPanel

    local lowerPanel = vgui.Create("DPanel", self.MenuFrame)
    lowerPanel:Dock(FILL)
    lowerPanel:DockMargin(0, 5, 0, 0)

    function lowerPanel:Paint(w, h)

        surface.SetDrawColor(255, 255, 255)
        surface.DrawRect(0, 0, w, h)

    end

    self.MenuFrame.LowerPanel = lowerPanel

    local statsTab = vgui.Create("DButton", self.MenuFrame.TabParentPanel)
    statsTab:Dock(LEFT)
    statsTab:SetSize(180, 0)
    statsTab:SetText(LocalPlayer():Name())

    function statsTab:DoClick()

    end

    self.MenuFrame.TabParentPanel.StatsTab = statsTab

    local intelTab = vgui.Create("DButton", self.MenuFrame.TabParentPanel)
    intelTab:Dock(LEFT)
    intelTab:SetSize(60, 0)
    intelTab:SetText("Intel")

    function intelTab:DoClick()

    end

    self.MenuFrame.TabParentPanel.IntelTab = intelTab

    local shopTab = vgui.Create("DButton", self.MenuFrame.TabParentPanel)
    shopTab:Dock(LEFT)
    shopTab:SetSize(60, 0)
    shopTab:SetText("Shop")

    function shopTab:DoClick()

    end

    self.MenuFrame.TabParentPanel.ShopTab = shopTab

    local entryList = vgui.Create("DCategoryList", self.MenuFrame.LowerPanel)
    entryList:Dock(LEFT)
    entryList:SetSize(200, 0)

    local entryPanel = vgui.Create("DPanel", self.MenuFrame.LowerPanel)
    entryPanel:Dock(FILL)
    function entryPanel:Paint(w, h)
        surface.SetDrawColor(50, 50, 50)
        surface.DrawRect(0, 0, w, h)
    end

    local entryStats = vgui.Create("DPanel", entryPanel)
    entryStats:Dock(TOP)
    entryStats:SetSize(0, 40)
    entryStats.Paint = nil

    local entryTextDisplay = vgui.Create("DPanel", entryPanel)
    entryTextDisplay:Dock(FILL)
    entryTextDisplay.Paint = nil

    local function DrawEntry(entryColor, entryName, entryText, stats)

        print(#stats)
        entryStats:SetSize(0, #stats * 40)

        function entryStats:Paint(w, h)
            
            for k, v in ipairs(stats) do

                surface.SetDrawColor(180, 180, 180)
                if k % 2 == 1 then 
                    surface.SetDrawColor(210, 210, 210)
                end
                
                surface.DrawRect(0, (k - 1) * 40, w, 40)

                local text = markup.Parse( "<font=DermaLarge><color=0,0,0>\n\n" .. v .. "</color></font>", w - 40 )
                text:Draw(20, (k - 1) * 40 + 5)

            end

        end
    
        function entryTextDisplay:Paint(w, h)

            -- chatgpt hallucinated an entire fucking function to get this shit to wrap, apologised profusely when called out on its artificial bs, but then told me about markup thanks chatgpt

            local text = markup.Parse( "<font=DermaLarge><color=" .. tostring( entryColor ) .. ">" .. entryName .. "</color></font><font=DermaLarge><color=255,255,255>\n\n" .. entryText .. "</color></font>", w - 40 )
            text:Draw(20, 20)

        end

    end

    local starterCategory = vgui.Create("DCollapsibleCategory", entryList)
    starterCategory:Dock(FILL)
    starterCategory:SetLabel("Getting Started")
    function starterCategory:Paint(w, h) surface.SetDrawColor(190, 40, 40) surface.DrawRect(0, 0, w, h) end
    starterCategory:DoExpansion(false)

    local mapCategory = vgui.Create("DCollapsibleCategory", entryList)
    mapCategory:Dock(FILL)
    mapCategory:SetLabel("Maps")
    function mapCategory:Paint(w, h) surface.SetDrawColor(190, 40, 40) surface.DrawRect(0, 0, w, h) end
    mapCategory:DoExpansion(false)

    local mechanicsCategory = vgui.Create("DCollapsibleCategory", entryList)
    mechanicsCategory:Dock(FILL)
    mechanicsCategory:SetLabel("Advanced Mechanics")
    function mechanicsCategory:Paint(w, h) surface.SetDrawColor(190, 40, 40) surface.DrawRect(0, 0, w, h) end
    mechanicsCategory:DoExpansion(false)

    entryList:AddItem(starterCategory)
    entryList:AddItem(mapCategory)
    entryList:AddItem(mechanicsCategory)

    for k, v1 in pairs(Intel) do

        local mapTab = vgui.Create("DCollapsibleCategory", mapCategory)
        mapTab:SetLabel(v1.FancyMapName)
        mapTab:Dock(TOP)
        function mapTab:Paint(w, h)
            surface.SetDrawColor(v1.IntelColor)
            surface.DrawRect(0, 0, w, h)
        end
        mapTab:DoExpansion(false)

        local mapInfo = mapTab:Add("Info")
        mapInfo.DoClick = function()
            -- make shit show up
            print("clicked " .. v1.FancyMapName)

            local tbl = {}
            tbl[1] = "Raid Time | " .. v1.RaidTime .. " Minutes"
            tbl[2] = "Map Size | " .. v1.Size
            
            DrawEntry(v1.IntelColor, v1.FancyMapName, v1.Description .. "\n\n" .. v1.Features .. "\n\n" .. v1.ExfilsDescription, tbl)
        end
        mapInfo.Paint = nil

        local extractTab = vgui.Create("DCollapsibleCategory", mapTab)
        extractTab:SetLabel("Extracts")
        extractTab:Dock(TOP)
        extractTab.Paint = nil
        extractTab:DoExpansion(false)

        for k, v2 in pairs(v1.Extractions) do

            local exfil = extractTab:Add(v2.Name)
            exfil.DoClick = function()
                -- make shit show up
                print("clicked " .. v2.Name)

                local tbl = {}
                tbl[1] = "Extract Time | " .. v2.Time .. " Seconds"

                if v2.IsGuranteed then
                    tbl[2] = "Universal | True"
                else
                    tbl[2] = "Universal | False"
                end

                if v2.Conditions == "" then
                    tbl[3] = "Has Conditions | False"
                else
                    tbl[3] = "Has Conditions | True"
                end
                

                DrawEntry(v1.IntelColor, v2.Name, v2.Description .. "\n\n" .. v2.Conditions, tbl)
            end
            exfil.Paint = nil

        end

    end

    self.MenuFrame.LowerPanel.EntryList = entryList

end

-- called to either initialize or open the menu
function Menu:Open( openTab )

    if self.IsInitialized then
        
        -- if table's initialized (open it)

        if self.IsOpen then return end

        self.MenuFrame:Show()

    else

        -- if it aint

        self:Initialize( openTab )

    end

end

-- shitty showspare2 offbrand because i really don't want to use the net library yet
hook.Add("Think", "MySpare2Function", function()
    if input.IsKeyDown(KEY_F4) then

        --print("showing spare 1")
        
        Menu:Open("Intel")

    end
end)