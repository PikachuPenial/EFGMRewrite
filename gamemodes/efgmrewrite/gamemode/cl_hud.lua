-- Create a new font for the compass using the surface.CreateFont function.
-- This font will be used to draw the compass text.

-- Define a function to draw the compass.
local function DrawCompass()

    -- Get a reference to the local player entity.
    local ply = LocalPlayer()

    -- Get the player's current eye angles, which will be used to determine the direction they are facing.
    local ang = ply:EyeAngles()

    surface.SetFont("DermaDefaultBold")
    surface.SetTextPos(100, 100)
    draw.SimpleText(tostring(ang.y), "DermaLarge", 100, 100, Color(0, 0, 0))

    local compassX, compassY = ScrW() * 0.5, ScrH() * 0
    local width, height = ScrW() * 2, ScrH() * 0.05

    local color = Color(255, 255, 255)

    spacing = (width * 1) / 360
    numOfLines = width / spacing
    fadeDistMultiplier = 20
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

        if i_offset % 15 == 0 and i_offset >= 0 then
            local a = i_offset
            local text = adv_compass_tbl[360 - (a % 360)] and adv_compass_tbl[360 - (a % 360)] or 360 - (a % 360)
            local font = "DermaLarge"

            surface.SetDrawColor(Color(color.r, color.g, color.b, calculation))
            surface.DrawLine(x, compassY, x, compassY + height * 0.5)

            draw.SimpleText(text, font, x, compassY + height * 0.6, Color(color.r, color.g, color.b, calculation), TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP)
        end

    end

end
hook.Add("HUDPaint", "DrawCompass", DrawCompass)

local function DebugRaidTime()

    surface.SetTextColor(Color(255, 255, 255))
    surface.SetTextPos(20 * MenuAlias.widthRatio, 300 * MenuAlias.heightRatio)

    -- time logic

    local raidTime = GetGlobalInt("RaidTimeLeft", -1)

    local time = ""

    if raidTime == -1 then
        time = "Raid Pending!"
    elseif raidTime == -2 then
        time = "Raid Ended!"
    else 
        time = string.FormattedTime( raidTime, "%2i:%02i" ) -- thanks titanmod for raid time formatting
    end

    surface.DrawText(time)

end
hook.Add("HUDPaint", "DrawTimer", DebugRaidTime)

-- idk what this does
function HideHud(name)
	for k, v in pairs({"CHudHealth", "CHudBattery", "CHudAmmo", "CHudSecondaryAmmo"}) do
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

-- will be able to make custom panels and shit
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
    newDMenu:AddOption("Add Argument", function()
        
    end)

    local clickedNode = nil

    local function DockNewPanel(dockedPanel, dockEnum)
        if !dockedPanel then return end
        dockedPanel:Dock(dockEnum)
    end

    local dockOptionsSub, dockOptions = newDMenu:AddSubMenu("Docking Options:")

    local dockTop = dockOptionsSub:AddOption("Dock TOP", DockNewPanel(clickedNode, TOP))
    local dockBottom = dockOptionsSub:AddOption("Dock BOTTOM", DockNewPanel(clickedNode, BOTTOM))
    local dockFill = dockOptionsSub:AddOption("Dock FILL", DockNewPanel(clickedNode, FILL))

    local dockLeft = dockOptionsSub:AddOption("Dock LEFT", DockNewPanel(clickedNode, LEFT))
    local dockRight = dockOptionsSub:AddOption("Dock RIGHT", DockNewPanel(clickedNode, RIGHT))
    local dockNone = dockOptionsSub:AddOption("Dock NODOCK", DockNewPanel(clickedNode, NODOCK))

    tree.DoRightClick = function( s, newNode )
        newDMenu:Open()
        clickedNode = newNode
    end

    newDMenu:Hide()

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

-- shitty showspare1 offbrand because i really don't want to start with the net library today
hook.Add("Think", "MySpare1Function", function()
    if input.IsKeyDown(KEY_F3) then

        --print("showing spare 1")
        
        DrawEditMenuPanel()

    end
end)


local function DrawSellMenuPanel()

    -- placeholder shop menu, i want it to be like STALKER / Tarkov type menu where you can sell and buy at the same time
    -- coding with cookie clicker open in the background goes hard

end

-- shitty showspare2 offbrand because i really don't want to use the net library yet
hook.Add("Think", "MySpare2Function", function()
    if input.IsKeyDown(KEY_F4) then

        --print("showing spare 1")
        
        if UI.MenuEditPanel != nil then return end

        DrawEditMenuPanel()

    end
end)