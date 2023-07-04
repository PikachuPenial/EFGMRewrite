-- Define a function to draw the compass.
local function DrawCompass()

    -- Get a reference to the local player entity.
    local ply = LocalPlayer()

    -- Get the player's current eye angles, which will be used to determine the direction they are facing.
    local ang = ply:EyeAngles()
    local color = Color(255, 255, 255)
    --draw.SimpleText(tostring(math.Round(ang.y)), "Bender24", ScrW() / 2, 50, color, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)   i got rid of this because it looked like horseshit, maybe have a fade in the center of the compass and have the actual angle there, idk its 3am im not fucking with this
    surface.SetDrawColor(color)
    surface.DrawLine(ScrW() / 2, 0, ScrW() / 2, 6)

    local compassX, compassY = ScrW() * 0.5, ScrH() * 0
    local width, height = ScrW() * 0.5, 10

    spacing = (width * 1) / 360
    numOfLines = width / spacing
    fadeDistMultiplier = 75
    fadeDistance = (width / 2) / fadeDistMultiplier

    local adv_compass_tbl = {
        [0] = "N",
        [45] = "NE",
        [90] = "E",
        [135] = "SE",
        [180] = "S",
        [225] = "SW",
        [270] = "W",
        [315] = "NW",
        [360] = "N"
    }

    for i = math.Round(-ang.y) % 360, (math.Round(-ang.y) % 360) + numOfLines do

        local x = ((compassX - (width / 2)) + (((i + ang.y) % 360) * spacing))
        local value = math.abs(x - compassX)
        local calc = 1 - ((value + (value - fadeDistance)) / (width / 2))
        local calculation = 255 * math.Clamp(calc, 0.001, 1)

        local i_offset = -(math.Round(i - 0 - (numOfLines / 2))) % 360

        if i_offset % 45 == 0 and i_offset >= 0 then
            local a = i_offset
            local text = adv_compass_tbl[360 - (a % 360)] and adv_compass_tbl[360 - (a % 360)] or 360 - (a % 360)
            local font = "Bender24"

            draw.SimpleText(text, font, x, compassY + height * 0.6, Color(color.r, color.g, color.b, calculation), TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP)
        end

    end

end
hook.Add("HUDPaint", "DrawCompass", DrawCompass)

local function DebugRaidTime()

    surface.SetTextColor(Color(255, 255, 255))
    surface.SetFont("DermaLarge")
    surface.SetTextPos(20 * MenuAlias.widthRatio, 300 * MenuAlias.heightRatio)

    -- time logic

    local raidTime = GetGlobalInt("RaidTimeLeft", -1)
    local raidStatus = GetGlobalInt("RaidStatus", 0)

    local tempStatusTable = {
        [0] = "Raid Pending",
        [1] = "Raid Active",
        [2] = "Raid Over"
    }

    surface.DrawText( string.FormattedTime( raidTime, "%2i:%02i" ) .. "\n" .. tempStatusTable[raidStatus] )

end
hook.Add("HUDPaint", "DrawTimer", DebugRaidTime)

function HideHud(name)
    -- full: {"CHudHealth", "CHudBattery", "CHudAmmo", "CHudSecondaryAmmo", "CHudCrosshair"}
    for k, v in pairs({"CHudBattery", "CHudCrosshair"}) do
        if name == v then
            return false
        end
    end
end
hook.Add("HUDShouldDraw", "HideDefaultHud", HideHud)

-- local function DrawEditMenuPanel()

--     UI.MenuEditPanel = UI.InitializeFrame("Menu Edit Panel", 15, 315, 200, 450, true, true, true, true, false)

--     function UI.MenuEditPanel:OnClose()
--         UI.MenuEditPanel = nil
--     end

--     -- im gonna refactor all this shit once i actually figure out what the fuck im doing

--     local nameEntry = vgui.Create("DTextEntry", UI.MenuEditPanel)
--     nameEntry:DockMargin(unpack( MenuAlias.margins ))
--     nameEntry:Dock(TOP)
--     nameEntry:SetSize(0, 20)
--     nameEntry:SetPlaceholderText("Name for new panel")

--     UI.MenuEditPanel.NameEntry = nameEntry

--     local xEntry = vgui.Create("DTextEntry", UI.MenuEditPanel)
--     xEntry:DockMargin(unpack( MenuAlias.margins ))
--     xEntry:Dock(TOP)
--     xEntry:SetSize(0, 20)
--     xEntry:SetPlaceholderText("X position for new panel")
--     xEntry:SetNumeric(true)

--     UI.MenuEditPanel.XEntry = xEntry

--     local yEntry = vgui.Create("DTextEntry", UI.MenuEditPanel)
--     yEntry:DockMargin(unpack( MenuAlias.margins ))
--     yEntry:Dock(TOP)
--     yEntry:SetSize(0, 20)
--     yEntry:SetPlaceholderText("Y position for new panel")
--     yEntry:SetNumeric(true)

--     UI.MenuEditPanel.YEntry = yEntry

--     local widthEntry = vgui.Create("DTextEntry", UI.MenuEditPanel)
--     widthEntry:DockMargin(unpack( MenuAlias.margins ))
--     widthEntry:Dock(TOP)
--     widthEntry:SetSize(0, 20)
--     widthEntry:SetPlaceholderText("Width of new panel")
--     widthEntry:SetNumeric(true)

--     UI.MenuEditPanel.WidthEntry = widthEntry

--     local heightEntry = vgui.Create("DTextEntry", UI.MenuEditPanel)
--     heightEntry:DockMargin(unpack( MenuAlias.margins ))
--     heightEntry:Dock(TOP)
--     heightEntry:SetSize(0, 20)
--     heightEntry:SetPlaceholderText("Height of new panel")
--     heightEntry:SetNumeric(true)

--     UI.MenuEditPanel.HeightEntry = heightEntry

--     function UI.MenuEditPanel:Think()

--         if UI.CreatedPanel == nil then return end
--         if vgui.GetKeyboardFocus() != UI.CreatedPanel then return end

--         -- values from the panel to enter into the entries
--         local x, y = UI.CreatedPanel:GetPos()
--         local w, h = UI.CreatedPanel:GetSize()

--         -- entering those into the entries

--         UI.MenuEditPanel.XEntry:SetValue(x)
--         UI.MenuEditPanel.YEntry:SetValue(y)
--         UI.MenuEditPanel.WidthEntry:SetValue(w)
--         UI.MenuEditPanel.HeightEntry:SetValue(h)

--     end

--     local createButton = vgui.Create("DButton", UI.MenuEditPanel)
--     createButton:DockMargin(unpack( MenuAlias.margins ))
--     createButton:Dock(BOTTOM)
--     createButton:SetSize(0, 20)
--     createButton:SetText("Create Panel")
    
--     UI.MenuEditPanel.CreateButton = createButton

--     function UI.MenuEditPanel.CreateButton:DoClick()

--         if UI.CreatedPanel != nil then
--             UI.CreatedPanel:Remove()
--             UI.CreatedPanel = nil
--         end

--         -- values from entries to make the panel
--         local name, x, y, w, h = UI.MenuEditPanel.NameEntry:GetText(), UI.MenuEditPanel.XEntry:GetInt(), UI.MenuEditPanel.YEntry:GetInt(), UI.MenuEditPanel.WidthEntry:GetInt(), UI.MenuEditPanel.HeightEntry:GetInt()

--         UI.CreatedPanel = UI.InitializeFrame(name, x, y, w, h, true, true, true, true, true)

--     end

--     local copyButton = vgui.Create("DButton", UI.MenuEditPanel)
--     copyButton:DockMargin(unpack( MenuAlias.margins ))
--     copyButton:Dock(BOTTOM)
--     copyButton:SetSize(0, 20)
--     copyButton:SetText("Copy UI.InitializePanel() Info")

--     UI.MenuEditPanel.CopyButton = copyButton

--     function UI.MenuEditPanel.CopyButton:DoClick()

--         if UI.CreatedPanel == nil then return end

--         -- values from entries
--         local name, x, y, w, h = UI.MenuEditPanel.NameEntry:GetText(), UI.MenuEditPanel.XEntry:GetInt(), UI.MenuEditPanel.YEntry:GetInt(), UI.MenuEditPanel.WidthEntry:GetInt(), UI.MenuEditPanel.HeightEntry:GetInt()

--         local copy = string.Replace(name, " ", "") .. " = UI.InitializeFrame(\""  .. name .. "\", "  .. x .. ", "  .. y .. ", "  .. w .. ", "  .. h .. ", true, true, true, true, true)"

--         SetClipboardText(copy)

--     end

-- end

-- will be able to make custom panels and shit (im giving up on this, im keeping it here because
-- one day i might grow a pair and work on it some more, but it seems like lua just does not
-- want to fucking work inside this function, how the fuck does a dmenu open automatically
-- and set itself to nil, i just do not fucking understand, chatgpt couldnt tell me how to
-- fix it, and when i told it i was gonna move to a cabin in alaska so i didnt have to
-- work on this fucking function anymore, it told me to reach out on the "community
-- forums", what fucking community forums, r/Glua has been restricted for a good year
-- because why the fuck not, im gonna go play ksp and try to forget this ever happened)
local function DrawEditMenuPanel()

    if MenuInfoPanel then return end

    MenuInfoPanel = vgui.Create("DFrame")
    MenuInfoPanel:SetPos( 15, 315 ) 
    MenuInfoPanel:SetSize( 500, 700 ) 
    MenuInfoPanel:SetTitle( "Menu Info" ) 
    MenuInfoPanel:SetVisible( true ) 
    MenuInfoPanel:SetDraggable( true ) 
    MenuInfoPanel:ShowCloseButton( true ) 
    MenuInfoPanel:MakePopup()

    function MenuInfoPanel:OnClose()
        MenuInfoPanel = nil
    end

    local tree = vgui.Create("DTree", MenuInfoPanel)
    tree:Dock(LEFT)
    tree:SetSize(200, 0)
    
    local newDMenu = DermaMenu()

    newDMenu:AddOption("Add Argument", DockNewPanel)

    local clickedNode = nil

    local function DockNewPanel(dockedPanel, dockEnum)
        print("im in hell") return
        dockedPanel:Dock(dockEnum)
    end

    local dockOptionsSub, dockOptions = newDMenu:AddSubMenu("Docking Options:")

    dockOptionsSub:AddOption("Dock TOP", DockNewPanel)
    dockOptionsSub:AddOption("Dock BOTTOM", DockNewPanel)
    dockOptionsSub:AddOption("Dock FILL", DockNewPanel)

    dockOptionsSub:AddOption("Dock LEFT", DockNewPanel)
    dockOptionsSub:AddOption("Dock RIGHT", DockNewPanel)
    dockOptionsSub:AddOption("Dock NODOCK", DockNewPanel)

    tree.DoRightClick = function( s, newNode )
        print(tostring(newDMenu))
        newDMenu:Open()
        clickedNode = newNode
    end

    local function Refresh()
        MenuInfoPanel:InvalidateLayout()
    end

    -- onto the buttons and shit

    local refreshButton = vgui.Create("DButton", MenuInfoPanel)
    refreshButton:Dock(TOP)
    refreshButton:SetText("Refresh...")

    local initializeFrameButton = vgui.Create("DButton", MenuInfoPanel)
    initializeFrameButton:Dock(TOP)
    initializeFrameButton:SetText("Create Frame")

    local function CreateNewPanel( panelType, parent, x, y, w, h)
 
        print("making panel and shit")

        local newPanel = vgui.Create(panelType, parent)
        newPanel:SetPos(x, y)
        newPanel:SetSize(w, h)
        newPanel:SetDraggable(false)

        return newPanel

    end

    initializeFrameButton.DoClick = function()

        -- I cannot describe with words how much I fucking (thats 21) hate this approach,
        -- but using vgui.Register() and defining this in PANEL:Init() gave me errors.
        -- I feel for the TF2 devs, I really do.

        local newPanelTable = {}

        local panelCreatorFrame = vgui.Create("DFrame")
        panelCreatorFrame:SetSize(300, 400)
        panelCreatorFrame:SetTitle("Create Panel")
        panelCreatorFrame:SetDraggable(true)
        panelCreatorFrame:Center()
        panelCreatorFrame:MakePopup()

        local container0 = vgui.Create("DPanel", panelCreatorFrame)
        container0:Dock(TOP)
        container0:SetSize(0, 20)
        container0.Paint = nil

        local panelTypeInput = vgui.Create("DTextEntry", container0)
        panelTypeInput:Dock(LEFT)
        panelTypeInput:SetWide(120)
        panelTypeInput:SetPlaceholderText("DPanel Type")

        local intNameInput = vgui.Create("DTextEntry", container0)
        intNameInput:Dock(RIGHT)
        intNameInput:SetWide(120)
        intNameInput:SetPlaceholderText("DPanel Internal Name")

        local container1 = vgui.Create("DPanel", panelCreatorFrame)
        container1:Dock(TOP)
        container1:SetSize(0, 20)
        container1.Paint = nil

        local xInput = vgui.Create("DTextEntry", container1)
        xInput:Dock(LEFT)
        xInput:SetWide(120)
        xInput:SetPlaceholderText("X Position")
        xInput:SetNumeric(true)

        local yInput = vgui.Create("DTextEntry", container1)
        yInput:Dock(RIGHT)
        yInput:SetWide(120)
        yInput:SetPlaceholderText("Y Position")
        yInput:SetNumeric(true)

        local container2 = vgui.Create("DPanel", panelCreatorFrame)
        container2:Dock(TOP)
        container2:SetSize(0, 20)
        container2.Paint = nil

        local wideInput = vgui.Create("DTextEntry", container2)
        wideInput:Dock(LEFT)
        wideInput:SetWide(120)
        wideInput:SetPlaceholderText("Width")
        wideInput:SetNumeric(true)

        local tallInput = vgui.Create("DTextEntry", container2)
        tallInput:Dock(RIGHT)
        tallInput:SetWide(120)
        tallInput:SetPlaceholderText("Height")
        tallInput:SetNumeric(true)

        local makePanelButton = vgui.Create("DButton", panelCreatorFrame)
        makePanelButton:Dock(BOTTOM)
        makePanelButton:SetText("Create Panel")

        makePanelButton.DoClick = function(self)

            local intName = intNameInput:GetText()
            local panelType = panelTypeInput:GetText()
            local x = xInput:GetInt()
            local y = yInput:GetInt()
            local w = wideInput:GetInt()
            local h = tallInput:GetInt()

            newPanelTable[intName] = CreateNewPanel(panelType, nil, x, y, w, h)
            newPanelTable[intName]:SetTitle("tempTitle")

            local node1 = tree:AddNode(intName)

        end

    end

end

local function DrawSellMenuPanel()

    -- placeholder shop menu, i want it to be like STALKER / Tarkov type menu where you can sell and buy at the same time
    -- coding with cookie clicker open in the background goes hard

end

net.Receive("VoteableMaps", function(len)

    local tbl = net.ReadTable()

    LocalPlayer():PrintMessage(HUD_PRINTCENTER, "Look in the console and (efgm_vote mapname) for a map, im not good at UI so fuck you.")
    PrintTable(tbl)

end)