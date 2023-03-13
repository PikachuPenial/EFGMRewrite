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

-- idk what this does
function HideHud(name)
	for k, v in pairs({"CHudHealth", "CHudBattery", "CHudAmmo", "CHudSecondaryAmmo"}) do
		if name == v then
			return false
		end
	end
end
hook.Add("HUDShouldDraw", "HideDefaultHud", HideHud)

-- draw health panel

local function DrawEditMenuPanel()

    UI.MenuEditPanel = UI.InitializeFrame("Menu Edit Panel", 15, 315, 200, 450, true, true, true, true, false)

    function UI.MenuEditPanel:OnClose()
        UI.MenuEditPanel = nil
    end

    -- im gonna refactor all this shit once i actually figure out what the fuck im doing

    local nameEntry = vgui.Create("DTextEntry", UI.MenuEditPanel)
    nameEntry:DockMargin(5, 25, 5, 5)
    nameEntry:Dock(TOP)
    nameEntry:SetSize(0, 20)
    nameEntry:SetPlaceholderText("Name for new panel")

    UI.MenuEditPanel.NameEntry = nameEntry

    local xEntry = vgui.Create("DTextEntry", UI.MenuEditPanel)
    xEntry:DockMargin(5, 25, 5, 5)
    xEntry:Dock(TOP)
    xEntry:SetSize(0, 20)
    xEntry:SetPlaceholderText("X position for new panel")
    xEntry:SetNumeric(true)

    UI.MenuEditPanel.XEntry = xEntry

    local yEntry = vgui.Create("DTextEntry", UI.MenuEditPanel)
    yEntry:DockMargin(5, 25, 5, 5)
    yEntry:Dock(TOP)
    yEntry:SetSize(0, 20)
    yEntry:SetPlaceholderText("Y position for new panel")
    yEntry:SetNumeric(true)

    UI.MenuEditPanel.YEntry = yEntry

    local widthEntry = vgui.Create("DTextEntry", UI.MenuEditPanel)
    widthEntry:DockMargin(5, 25, 5, 5)
    widthEntry:Dock(TOP)
    widthEntry:SetSize(0, 20)
    widthEntry:SetPlaceholderText("Width of new panel")
    widthEntry:SetNumeric(true)

    UI.MenuEditPanel.WidthEntry = widthEntry

    local heightEntry = vgui.Create("DTextEntry", UI.MenuEditPanel)
    heightEntry:DockMargin(5, 25, 5, 5)
    heightEntry:Dock(TOP)
    heightEntry:SetSize(0, 20)
    heightEntry:SetPlaceholderText("Height of new panel")
    heightEntry:SetNumeric(true)

    UI.MenuEditPanel.HeightEntry = heightEntry

    function UI.MenuEditPanel:Think()

        if UI.CreatedPanel == nil then return end
        if vgui.GetKeyboardFocus() != UI.CreatedPanel then return end

        -- values from the panel to enter into the entries
        local x, y = UI.CreatedPanel:GetPos()
        local w, h = UI.CreatedPanel:GetSize()

        -- entering those into the entries

        UI.MenuEditPanel.XEntry:SetValue(x)
        UI.MenuEditPanel.YEntry:SetValue(y)
        UI.MenuEditPanel.WidthEntry:SetValue(w)
        UI.MenuEditPanel.HeightEntry:SetValue(h)

    end

    local createButton = vgui.Create("DButton", UI.MenuEditPanel)
    createButton:DockMargin(5, 5, 5, 5)
    createButton:Dock(BOTTOM)
    createButton:SetSize(0, 20)
    createButton:SetText("Create Panel")
    
    UI.MenuEditPanel.CreateButton = createButton

    function UI.MenuEditPanel.CreateButton:DoClick()

        if UI.CreatedPanel != nil then
            UI.CreatedPanel:Remove()
            UI.CreatedPanel = nil
        end

        -- values from entries to make the panel
        local name, x, y, w, h = UI.MenuEditPanel.NameEntry:GetText(), UI.MenuEditPanel.XEntry:GetInt(), UI.MenuEditPanel.YEntry:GetInt(), UI.MenuEditPanel.WidthEntry:GetInt(), UI.MenuEditPanel.HeightEntry:GetInt()

        UI.CreatedPanel = UI.InitializeFrame(name, x, y, w, h, true, true, true, true, true)

    end

    local copyButton = vgui.Create("DButton", UI.MenuEditPanel)
    copyButton:DockMargin(5, 5, 5, 5)
    copyButton:Dock(BOTTOM)
    copyButton:SetSize(0, 20)
    copyButton:SetText("Copy UI.InitializePanel() Info")

    UI.MenuEditPanel.CopyButton = copyButton

    function UI.MenuEditPanel.CopyButton:DoClick()

        if UI.CreatedPanel == nil then return end

        -- values from entries
        local name, x, y, w, h = UI.MenuEditPanel.NameEntry:GetText(), UI.MenuEditPanel.XEntry:GetInt(), UI.MenuEditPanel.YEntry:GetInt(), UI.MenuEditPanel.WidthEntry:GetInt(), UI.MenuEditPanel.HeightEntry:GetInt()

        local copy = string.Replace(name, " ", "") .. " = UI.InitializePanel("  .. name .. ", "  .. x .. ", "  .. y .. ", "  .. w .. ", "  .. h .. ", true, true, true, true, true)"

        SetClipboardText(copy)

    end

end

-- shitty showspare1 offbrand because i really don't want to start with the net library today
hook.Add("Think", "MySpare1Function", function()
    if input.IsKeyDown(KEY_F3) then

        --print("showing spare 1")
        
        if UI.MenuEditPanel != nil then return end

        DrawEditMenuPanel()

    end
end)

-- UI.HealthPanel = UI.InitializeFrame("none lmao", 15, 315, 500, 300, true, false, false, true, false)