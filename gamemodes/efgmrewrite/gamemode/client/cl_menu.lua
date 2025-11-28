
-- establishes global menu object, this will have tabs and will handle shit like shop, player progression, in-raid shit, other stuff
-- this is not a panel, but a collection of panels and supporting functions
Menu = {}

Menu.MusicList = {"sound/music/menu_01.mp4", "sound/music/menu_02.mp4", "sound/music/menu_03.mp4", "sound/music/menu_04.mp4"}
Menu.TabList = {"stats", "match", "inventory", "market", "tasks", "skills", "intel", "achievements", "settings"}
Menu.ActiveTab = ""
Menu.MouseX = 0
Menu.MouseY = 0
Menu.Player = LocalPlayer()

hook.Add("OnReloaded", "Reload", function()

    Menu.Player = LocalPlayer()

end)

local menuBind = GetConVar("efgm_bind_menu"):GetInt()
cvars.AddChangeCallback("efgm_bind_menu", function(convar_name, value_old, value_new)
    menuBind = tonumber(value_new)
end)

-- called non-globally to initialize the menu, that way it can only be initialized once by Menu:Open()
-- also openTab is the name of the tab it should open to
function Menu:Initialize(openTo, container)

    local menuFrame = vgui.Create("DFrame")
    menuFrame:SetSize(ScrW(), ScrH())
    menuFrame:Center()
    menuFrame:SetTitle("")
    menuFrame:SetVisible(true)
    menuFrame:SetDraggable(false)
    menuFrame:SetDeleteOnClose(false)
    menuFrame:ShowCloseButton(false)
    menuFrame:MakePopup()
    menuFrame:SetAlpha(0)
    -- menuFrame:SetBackgroundBlur(true)
    menuFrame:NoClipping(true)
    menuFrame:MouseCapture(false)

    menuFrame:AlphaTo(255, 0.2, 0, nil)

    self.StartTime = SysTime()
    self.Unblur = false
    self.Closing = false

    function menuFrame:Paint(w, h)

        surface.SetDrawColor(0, 0, 0, 240)
        surface.DrawRect(0, 0, ScrW(), ScrH())

        if self.Unblur then return end -- hide the blur when customizing certain settings and whatnot
        BlurPanel(menuFrame, 4)

    end

    -- close menu with the game menu keybind
    function menuFrame:OnKeyCodeReleased(key)
        if key == menuBind then
            self.Closing = true
            menuFrame:SetKeyboardInputEnabled(false)
            menuFrame:SetMouseInputEnabled(false)

            menuFrame:AlphaTo(0, 0.1, 0, function()
                menuFrame:Close()
            end)
        end
    end

    function menuFrame:Think()

        if (!gui.IsGameUIVisible() or !gui.IsConsoleVisible()) then

            menuFrame:Show()

        else

            if Menu.ActiveTab == "Match" then

                net.Start("RemovePlayerSquadRF")
                net.SendToServer()

            end

            menuFrame:Remove()

        end

    end

    function menuFrame:OnClose()

        if Menu.ActiveTab == "Match" then

            net.Start("RemovePlayerSquadRF")
            net.SendToServer()

        end

    end

    self.Player = LocalPlayer()
    self.MenuFrame = menuFrame

    local tabParentPanel = vgui.Create("DPanel", self.MenuFrame)
    tabParentPanel:SetPos(EFGM.MenuScale(10), EFGM.MenuScale(10))
    tabParentPanel:SetSize(ScrW(), EFGM.MenuScale(41))

    surface.SetFont("PuristaBold32")

    local roubles = comma_value(Menu.Player:GetNWInt("Money", 0))
    local roublesTextSize = surface.GetTextSize(roubles)

    local level = Menu.Player:GetNWInt("Level", 1)
    local levelTextSize = surface.GetTextSize(level)

    function tabParentPanel:Paint(w, h)

        surface.SetFont("PuristaBold32")

        roubles = comma_value(Menu.Player:GetNWInt("Money", 0))
        roublesTextSize = surface.GetTextSize(roubles)

        level = Menu.Player:GetNWInt("Level", 1)
        levelTextSize = surface.GetTextSize(level)

        surface.SetDrawColor(MenuAlias.transparent)
        surface.DrawRect(0, 0, w, h)

        draw.SimpleTextOutlined(roubles, "PuristaBold32", w - EFGM.MenuScale(26), EFGM.MenuScale(2), MenuAlias.whiteColor, TEXT_ALIGN_RIGHT, TEXT_ALIGN_TOP, 1, MenuAlias.blackColor)
        draw.SimpleTextOutlined(level, "PuristaBold32", w - roublesTextSize - EFGM.MenuScale(86), EFGM.MenuScale(2), MenuAlias.whiteColor, TEXT_ALIGN_RIGHT, TEXT_ALIGN_TOP, 1, MenuAlias.blackColor)

    end

    self.MenuFrame.TabParentPanel = tabParentPanel

    local roubleIcon = vgui.Create("DImageButton", self.MenuFrame.TabParentPanel)
    roubleIcon:SetPos(self.MenuFrame.TabParentPanel:GetWide() - EFGM.MenuScale(66) - roublesTextSize, EFGM.MenuScale(2))
    roubleIcon:SetSize(EFGM.MenuScale(36), EFGM.MenuScale(36))
    roubleIcon:SetImage("icons/rouble_icon.png")
    roubleIcon:SetDepressImage(false)

    local levelIcon = vgui.Create("DImageButton", self.MenuFrame.TabParentPanel)
    levelIcon:SetPos(self.MenuFrame.TabParentPanel:GetWide() - EFGM.MenuScale(127) - roublesTextSize - levelTextSize, EFGM.MenuScale(2))
    levelIcon:SetSize(EFGM.MenuScale(36), EFGM.MenuScale(36))
    levelIcon:SetImage("icons/level_icon.png")
    levelIcon:SetDepressImage(false)

    local x, y = 0, 0
    local sideH, sideV

    roubleIcon.Think = function()

        roubleIcon:SetX(self.MenuFrame.TabParentPanel:GetWide() - EFGM.MenuScale(66) - roublesTextSize)

    end

    levelIcon.Think = function()

        levelIcon:SetX(self.MenuFrame.TabParentPanel:GetWide() - EFGM.MenuScale(127) - roublesTextSize - levelTextSize)

    end

    roubleIcon.OnCursorEntered = function(s)

        x, y = Menu.MouseX, Menu.MouseY
        surface.PlaySound("ui/element_hover.wav")

        if x <= (ScrW() / 2) then sideH = true else sideH = false end
        if y <= (ScrH() / 2) then sideV = true else sideV = false end

        local function UpdatePopOutPos()

            if sideH == true then

                roublePopOut:SetX(math.Clamp(x + EFGM.MenuScale(15), EFGM.MenuScale(10), ScrW() - roublePopOut:GetWide() - EFGM.MenuScale(10)))

            else

                roublePopOut:SetX(math.Clamp(x - roublePopOut:GetWide() - EFGM.MenuScale(15), EFGM.MenuScale(10), ScrW() - roublePopOut:GetWide() - EFGM.MenuScale(10)))

            end

            if sideV == true then

                roublePopOut:SetY(math.Clamp(y + EFGM.MenuScale(15), EFGM.MenuScale(60), ScrH() - roublePopOut:GetTall() - EFGM.MenuScale(20)))

            else

                roublePopOut:SetY(math.Clamp(y - roublePopOut:GetTall() + EFGM.MenuScale(15), EFGM.MenuScale(60), ScrH() - roublePopOut:GetTall() - EFGM.MenuScale(20)))

            end

        end

        if IsValid(roublePopOut) then roublePopOut:Remove() end
        roublePopOut = vgui.Create("DPanel", Menu.MenuFrame)
        roublePopOut:SetSize(EFGM.MenuScale(625), EFGM.MenuScale(50))
        UpdatePopOutPos()
        roublePopOut:AlphaTo(255, 0.1, 0, nil)
        roublePopOut:SetMouseInputEnabled(false)

        roublePopOut.Paint = function(s, w, h)

            if !IsValid(s) then return end

            BlurPanel(s, EFGM.MenuScale(3))

            -- panel position follows mouse position
            x, y = Menu.MouseX, Menu.MouseY

            UpdatePopOutPos()

            surface.SetDrawColor(Color(0, 0, 0, 205))
            surface.DrawRect(0, 0, w, h)

            surface.SetDrawColor(Color(50, 100, 50, 45))
            surface.DrawRect(0, 0, w, h)

            surface.SetDrawColor(Color(50, 100, 50, 255))
            surface.DrawRect(0, 0, w, EFGM.MenuScale(5))

            surface.SetDrawColor(Color(255, 255, 255, 155))
            surface.DrawRect(0, 0, w, EFGM.MenuScale(1))
            surface.DrawRect(0, h - EFGM.MenuScale(1), w, EFGM.MenuScale(1))
            surface.DrawRect(0, 0, EFGM.MenuScale(1), h)
            surface.DrawRect(w - EFGM.MenuScale(1), 0, EFGM.MenuScale(1), h)

            draw.SimpleTextOutlined("ROUBLES", "PuristaBold24", EFGM.MenuScale(5), EFGM.MenuScale(5), MenuAlias.whiteColor, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP, 1, MenuAlias.blackColor)
            draw.SimpleTextOutlined("Your primary currency when purchasing goods, using services and trading with other operatives.", "Purista18", EFGM.MenuScale(5), EFGM.MenuScale(25), MenuAlias.whiteColor, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP, 1, MenuAlias.blackColor)

        end

    end

    roubleIcon.OnCursorExited = function(s)

        if IsValid(roublePopOut) then

            roublePopOut:AlphaTo(0, 0.1, 0, function() roublePopOut:Remove() end)

        end

    end

    levelIcon.OnCursorEntered = function(s)

        x, y = Menu.MouseX, Menu.MouseY
        surface.PlaySound("ui/element_hover.wav")

        if x <= (ScrW() / 2) then sideH = true else sideH = false end
        if y <= (ScrH() / 2) then sideV = true else sideV = false end

        local function UpdatePopOutPos()

            if sideH == true then

                levelPopOut:SetX(math.Clamp(x + EFGM.MenuScale(15), EFGM.MenuScale(10), ScrW() - levelPopOut:GetWide() - EFGM.MenuScale(10)))

            else

                levelPopOut:SetX(math.Clamp(x - levelPopOut:GetWide() - EFGM.MenuScale(15), EFGM.MenuScale(10), ScrW() - levelPopOut:GetWide() - EFGM.MenuScale(10)))

            end

            if sideV == true then

                levelPopOut:SetY(math.Clamp(y + EFGM.MenuScale(15), EFGM.MenuScale(60), ScrH() - levelPopOut:GetTall() - EFGM.MenuScale(20)))

            else

                levelPopOut:SetY(math.Clamp(y - levelPopOut:GetTall() + EFGM.MenuScale(15), EFGM.MenuScale(60), ScrH() - levelPopOut:GetTall() - EFGM.MenuScale(20)))

            end

        end

        if IsValid(levelPopOut) then levelPopOut:Remove() end
        levelPopOut = vgui.Create("DPanel", Menu.MenuFrame)
        levelPopOut:SetSize(EFGM.MenuScale(515), EFGM.MenuScale(90))
        UpdatePopOutPos()
        levelPopOut:AlphaTo(255, 0.1, 0, nil)
        levelPopOut:SetMouseInputEnabled(false)

        levelPopOut.Paint = function(s, w, h)

            if !IsValid(s) then return end

            BlurPanel(s, EFGM.MenuScale(3))

            -- panel position follows mouse position
            x, y = Menu.MouseX, Menu.MouseY

            UpdatePopOutPos()

            surface.SetDrawColor(Color(0, 0, 0, 205))
            surface.DrawRect(0, 0, w, h)

            surface.SetDrawColor(Color(100, 100, 50, 45))
            surface.DrawRect(0, 0, w, h)

            surface.SetDrawColor(Color(100, 100, 50))
            surface.DrawRect(0, 0, w, EFGM.MenuScale(5))

            surface.SetDrawColor(Color(255, 255, 255, 155))
            surface.DrawRect(0, 0, w, EFGM.MenuScale(1))
            surface.DrawRect(0, h - EFGM.MenuScale(1), w, EFGM.MenuScale(1))
            surface.DrawRect(0, 0, EFGM.MenuScale(1), h)
            surface.DrawRect(w - EFGM.MenuScale(1), 0, EFGM.MenuScale(1), h)

            draw.SimpleTextOutlined("LEVEL", "PuristaBold24", EFGM.MenuScale(5), EFGM.MenuScale(5), MenuAlias.whiteColor, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP, 1, MenuAlias.blackColor)
            draw.SimpleTextOutlined("Your characters level, what seperates you from better services and reputation.", "Purista18", EFGM.MenuScale(5), EFGM.MenuScale(25), MenuAlias.whiteColor, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP, 1, MenuAlias.blackColor)

            draw.SimpleTextOutlined(level, "PuristaBold24", EFGM.MenuScale(5), EFGM.MenuScale(50), MenuAlias.whiteColor, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP, 1, MenuAlias.blackColor)
            draw.SimpleTextOutlined(level + 1, "PuristaBold24", w - EFGM.MenuScale(5), EFGM.MenuScale(50), MenuAlias.whiteColor, TEXT_ALIGN_RIGHT, TEXT_ALIGN_TOP, 1, MenuAlias.blackColor)

            draw.SimpleTextOutlined(Menu.Player:GetNWInt("Experience", 0) .. "/" .. Menu.Player:GetNWInt("ExperienceToNextLevel", 500), "PuristaBold16", EFGM.MenuScale(30), EFGM.MenuScale(57), MenuAlias.whiteColor, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP, 1, MenuAlias.blackColor)

            surface.SetDrawColor(Color(255, 255, 255, 155))
            surface.DrawRect(EFGM.MenuScale(5), EFGM.MenuScale(75), EFGM.MenuScale(505), EFGM.MenuScale(1))
            surface.DrawRect(EFGM.MenuScale(5), EFGM.MenuScale(84), EFGM.MenuScale(505), EFGM.MenuScale(1))
            surface.DrawRect(EFGM.MenuScale(5), EFGM.MenuScale(75), EFGM.MenuScale(1), EFGM.MenuScale(10))
            surface.DrawRect(EFGM.MenuScale(509), EFGM.MenuScale(75), EFGM.MenuScale(1), EFGM.MenuScale(10))

            surface.SetDrawColor(30, 30, 30, 125)
            surface.DrawRect(EFGM.MenuScale(5), EFGM.MenuScale(75), EFGM.MenuScale(505), EFGM.MenuScale(10))

            surface.SetDrawColor(255, 255, 255, 175)
            surface.DrawRect(EFGM.MenuScale(5), EFGM.MenuScale(75), (Menu.Player:GetNWInt("Experience", 0) / Menu.Player:GetNWInt("ExperienceToNextLevel", 500)) * EFGM.MenuScale(505), EFGM.MenuScale(10))

        end

    end

    levelIcon.OnCursorExited = function(s)

        if IsValid(levelPopOut) then

            levelPopOut:AlphaTo(0, 0.1, 0, function() levelPopOut:Remove() end)

        end

    end

    local lowerPanel = vgui.Create("DPanel", self.MenuFrame)
    lowerPanel:SetSize(EFGM.MenuScale(1880), EFGM.MenuScale(980))
    lowerPanel:NoClipping(true)

    function lowerPanel:Paint(w, h)

        if !Menu.Player:Alive() then
            menuFrame:AlphaTo(0, 0.1, 0, function()
                menuFrame:Close()
            end)
            return
        end

        surface.SetDrawColor(MenuAlias.transparent)
        surface.DrawRect(0, 0, w, h)

        if IsValid(Menu.MenuFrame) and Menu.MenuFrame.Closing then return end

        Menu.MouseX, Menu.MouseY = menuFrame:LocalCursorPos()

        if GetConVar("efgm_menu_parallax"):GetInt() == 1 then

            Menu.ParallaxX = math.Clamp(((Menu.MouseX / math.Round(EFGM.MenuScale(1920), 1)) - 0.5) * EFGM.MenuScale(20), -10, 10)
            Menu.ParallaxY = math.Clamp(((Menu.MouseY / math.Round(EFGM.MenuScale(1080), 1)) - 0.5) * EFGM.MenuScale(20), -10, 10)

            if GetConVar("efgm_menu_scalingmethod"):GetInt() == 0 then

                lowerPanel:SetPos(ScrW() / 2 - (EFGM.MenuScale(1880) / 2) + Menu.ParallaxX, 1060 / 2 - (920 / 2) + Menu.ParallaxY)

            else

                lowerPanel:SetPos(ScrW() / 2 - (EFGM.MenuScale(1880) / 2) + Menu.ParallaxX, EFGM.MenuScale(1060) / 2 - (920 / 2) + Menu.ParallaxY)

            end

        else

            Menu.ParallaxX = 0
            Menu.ParallaxY = 0

            if GetConVar("efgm_menu_scalingmethod"):GetInt() == 0 then

                lowerPanel:SetPos(ScrW() / 2 - (EFGM.MenuScale(1880) / 2), 1060 / 2 - (920 / 2))

            else

                lowerPanel:SetPos(ScrW() / 2 - (EFGM.MenuScale(1880) / 2), EFGM.MenuScale(1060) / 2 - (920 / 2))

            end

        end

    end

    function lowerPanel:OnMouseWheeled(delta)

        if !IsValid(contextMenu) then return end
        contextMenu:AlphaTo(0, 0.1, 0, function() contextMenu:Remove() hook.Remove("Think", "CheckIfContextMenuStillFocused") end)

    end

    self.MenuFrame.LowerPanel = lowerPanel

    local contents = vgui.Create("DPanel", Menu.MenuFrame.LowerPanel)
    contents:Dock(FILL)
    contents:DockPadding(EFGM.MenuScale(10), EFGM.MenuScale(10), EFGM.MenuScale(10), EFGM.MenuScale(10))
    contents:SetAlpha(0)
    contents.Paint = function(s, w, h)

        surface.SetDrawColor(MenuAlias.transparent)
        surface.DrawRect(0, 0, w, h)

    end

    Menu.MenuFrame.LowerPanel.Contents = contents

    -- for text size calculations
    surface.SetFont("PuristaBold32")

    local statsTab = vgui.Create("DPanel", self.MenuFrame.TabParentPanel)
    statsTab:Dock(LEFT)
    statsTab:SetSize(EFGM.MenuScale(38), 0)

    local statsIcon = vgui.Create("DImageButton", statsTab)
    statsIcon:SetPos(EFGM.MenuScale(2), EFGM.MenuScale(2))
    statsIcon:SetSize(EFGM.MenuScale(36), EFGM.MenuScale(36))
    statsIcon:SetImage("icons/profile_icon.png")
    statsIcon:SetDepressImage(false)

    local statsBGColor = MenuAlias.transparent
    local statsText = string.upper(Menu.Player:GetName())
    local statsTextSize = surface.GetTextSize(statsText)

    statsTab.Paint = function(s, w, h)

        surface.SetDrawColor(statsBGColor)
        surface.DrawRect(0, 0, w, h)

        draw.SimpleTextOutlined(statsText, "PuristaBold32", EFGM.MenuScale(43), EFGM.MenuScale(2), MenuAlias.whiteColor, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP, 1, MenuAlias.blackColor)

        if Menu.ActiveTab == "Stats" then

            surface.SetDrawColor(MenuAlias.whiteColor)
            surface.DrawRect(EFGM.MenuScale(2), EFGM.MenuScale(39), w - EFGM.MenuScale(2), EFGM.MenuScale(2))

        end

    end

    statsIcon.OnCursorEntered = function(s)

        statsTab:SizeTo(EFGM.MenuScale(46) + statsTextSize, statsTab:GetTall(), 0.15, 0, 0.5)
        surface.PlaySound("ui/element_hover.wav")

    end

    statsIcon.OnCursorExited = function(s)

        statsTab:SizeTo(EFGM.MenuScale(38), statsTab:GetTall(), 0.15, 0, 0.5)

    end

    function statsIcon:DoClick()

        if Menu.ActiveTab == "Stats" then return end

        surface.PlaySound("ui/element_select.wav")

        if Menu.ActiveTab == "Match" then

            net.Start("RemovePlayerSquadRF")
            net.SendToServer()

        end

        Menu.MenuFrame.LowerPanel.Contents:AlphaTo(0, 0.05, 0, function()

            Menu.MenuFrame.LowerPanel.Contents:Remove()
            Menu.OpenTab.Stats()
            Menu.ActiveTab = "Stats"

            Menu.MenuFrame.LowerPanel.Contents:AlphaTo(255, 0.05, 0, nil)

        end)

    end

    local matchTab = vgui.Create("DPanel", self.MenuFrame.TabParentPanel)
    matchTab:Dock(LEFT)
    matchTab:SetSize(EFGM.MenuScale(38), 0)

    local matchIcon = vgui.Create("DImageButton", matchTab)
    matchIcon:SetPos(EFGM.MenuScale(2), EFGM.MenuScale(2))
    matchIcon:SetSize(EFGM.MenuScale(36), EFGM.MenuScale(36))
    matchIcon:SetImage("icons/match_icon.png")
    matchIcon:SetDepressImage(false)

    local matchBGColor = MenuAlias.transparent
    local matchText = "#menu.tab.match"
    local matchTextSize = surface.GetTextSize(matchText)

    matchTab.Paint = function(s, w, h)

        surface.SetDrawColor(matchBGColor)
        surface.DrawRect(0, 0, w, h)

        draw.SimpleTextOutlined(matchText, "PuristaBold32", EFGM.MenuScale(43), EFGM.MenuScale(2), MenuAlias.whiteColor, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP, 1, MenuAlias.blackColor)

        if Menu.ActiveTab == "Match" then

            surface.SetDrawColor(MenuAlias.whiteColor)
            surface.DrawRect(EFGM.MenuScale(2), EFGM.MenuScale(39), w - EFGM.MenuScale(2), EFGM.MenuScale(2))

        end

    end

    matchIcon.OnCursorEntered = function(s)

        matchTab:SizeTo(EFGM.MenuScale(46) + matchTextSize, matchTab:GetTall(), 0.15, 0, 0.5)
        surface.PlaySound("ui/element_hover.wav")

    end

    matchIcon.OnCursorExited = function(s)

        matchTab:SizeTo(EFGM.MenuScale(38), matchTab:GetTall(), 0.15, 0, 0.5)

    end

    function matchIcon:DoClick()

        if Menu.ActiveTab == "Match" then return end

        surface.PlaySound("ui/element_select.wav")

        Menu.MenuFrame.LowerPanel.Contents:AlphaTo(0, 0.05, 0, function()

            Menu.MenuFrame.LowerPanel.Contents:Remove()
            Menu.OpenTab.Match()
            Menu.ActiveTab = "Match"

            Menu.MenuFrame.LowerPanel.Contents:AlphaTo(255, 0.05, 0, nil)

        end)

        if Menu.Player:CompareStatus(0) then

            net.Start("AddPlayerSquadRF")
            net.SendToServer()

        end

    end

    local inventoryTab = vgui.Create("DPanel", self.MenuFrame.TabParentPanel)
    inventoryTab:Dock(LEFT)
    inventoryTab:SetSize(EFGM.MenuScale(38), 0)

    local inventoryIcon = vgui.Create("DImageButton", inventoryTab)
    inventoryIcon:SetPos(EFGM.MenuScale(2), EFGM.MenuScale(2))
    inventoryIcon:SetSize(EFGM.MenuScale(36), EFGM.MenuScale(36))
    inventoryIcon:SetImage("icons/inventory_icon.png")
    inventoryIcon:SetDepressImage(false)

    local inventoryBGColor = MenuAlias.transparent
    local inventoryText = "#menu.tab.inventory"
    local inventoryTextSize = surface.GetTextSize(inventoryText)

    inventoryTab.Paint = function(s, w, h)

        surface.SetDrawColor(inventoryBGColor)
        surface.DrawRect(0, 0, w, h)

        draw.SimpleTextOutlined(inventoryText, "PuristaBold32", EFGM.MenuScale(43), EFGM.MenuScale(2), MenuAlias.whiteColor, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP, 1, MenuAlias.blackColor)

        if Menu.ActiveTab == "Inventory" then

            surface.SetDrawColor(MenuAlias.whiteColor)
            surface.DrawRect(EFGM.MenuScale(2), EFGM.MenuScale(39), w - EFGM.MenuScale(2), EFGM.MenuScale(2))

        end

    end

    inventoryIcon.OnCursorEntered = function(s)

        inventoryTab:SizeTo(EFGM.MenuScale(46) + inventoryTextSize, inventoryTab:GetTall(), 0.15, 0, 0.5)
        surface.PlaySound("ui/element_hover.wav")

    end

    inventoryIcon.OnCursorExited = function(s)

        inventoryTab:SizeTo(EFGM.MenuScale(38), inventoryTab:GetTall(), 0.15, 0, 0.5)

    end

    function inventoryIcon:DoClick()

        if Menu.ActiveTab == "Inventory" then return end

        if Menu.ActiveTab == "Match" then

            net.Start("RemovePlayerSquadRF")
            net.SendToServer()

        end

        surface.PlaySound("ui/element_select.wav")

        Menu.MenuFrame.LowerPanel.Contents:AlphaTo(0, 0.05, 0, function()

            Menu.MenuFrame.LowerPanel.Contents:Remove()
            Menu.OpenTab.Inventory(container)
            Menu.ActiveTab = "Inventory"

            Menu.MenuFrame.LowerPanel.Contents:AlphaTo(255, 0.05, 0, nil)

        end)

    end

    local marketTab = vgui.Create("DPanel", self.MenuFrame.TabParentPanel)
    marketTab:Dock(LEFT)
    marketTab:SetSize(EFGM.MenuScale(38), 0)

    local marketIcon = vgui.Create("DImageButton", marketTab)
    marketIcon:SetPos(EFGM.MenuScale(2), EFGM.MenuScale(2))
    marketIcon:SetSize(EFGM.MenuScale(36), EFGM.MenuScale(36))
    marketIcon:SetImage("icons/market_icon.png")
    marketIcon:SetDepressImage(false)

    local marketBGColor = MenuAlias.transparent
    local marketText = "#menu.tab.market"
    local marketTextSize = surface.GetTextSize(marketText)

    marketTab.Paint = function(s, w, h)

        surface.SetDrawColor(marketBGColor)
        surface.DrawRect(0, 0, w, h)

        draw.SimpleTextOutlined(marketText, "PuristaBold32", EFGM.MenuScale(43), EFGM.MenuScale(2), MenuAlias.whiteColor, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP, 1, MenuAlias.blackColor)

        if Menu.ActiveTab == "Market" then

            surface.SetDrawColor(MenuAlias.whiteColor)
            surface.DrawRect(EFGM.MenuScale(2), EFGM.MenuScale(39), w - EFGM.MenuScale(2), EFGM.MenuScale(2))

        end

    end

    marketIcon.OnCursorEntered = function(s)

        marketTab:SizeTo(EFGM.MenuScale(46) + marketTextSize, marketTab:GetTall(), 0.15, 0, 0.5)
        surface.PlaySound("ui/element_hover.wav")

    end

    marketIcon.OnCursorExited = function(s)

        marketTab:SizeTo(EFGM.MenuScale(38), marketTab:GetTall(), 0.15, 0, 0.5)

    end

    function marketIcon:DoClick()

        if !Menu.Player:CompareStatus(0) then

            surface.PlaySound("common/wpn_denyselect.wav")
            return

        end

        if Menu.ActiveTab == "Market" then return end

        if Menu.ActiveTab == "Match" then

            net.Start("RemovePlayerSquadRF")
            net.SendToServer()

        end

        surface.PlaySound("ui/element_select.wav")

        Menu.MenuFrame.LowerPanel.Contents:AlphaTo(0, 0.05, 0, function()

            Menu.MenuFrame.LowerPanel.Contents:Remove()
            Menu.OpenTab.Market()
            Menu.ActiveTab = "Market"

            Menu.MenuFrame.LowerPanel.Contents:AlphaTo(255, 0.05, 0, nil)

        end)

    end

    local tasksTab = vgui.Create("DPanel", self.MenuFrame.TabParentPanel)
    tasksTab:Dock(LEFT)
    tasksTab:SetSize(EFGM.MenuScale(38), 0)

    local tasksIcon = vgui.Create("DImageButton", tasksTab)
    tasksIcon:SetPos(EFGM.MenuScale(2), EFGM.MenuScale(2))
    tasksIcon:SetSize(EFGM.MenuScale(36), EFGM.MenuScale(36))
    tasksIcon:SetImage("icons/tasks_icon.png")
    tasksIcon:SetDepressImage(false)

    local tasksBGColor = MenuAlias.transparent
    local tasksText = "#menu.tab.tasks"
    local tasksTextSize = surface.GetTextSize(tasksText)

    tasksTab.Paint = function(s, w, h)

        surface.SetDrawColor(tasksBGColor)
        surface.DrawRect(0, 0, w, h)

        draw.SimpleTextOutlined(tasksText, "PuristaBold32", EFGM.MenuScale(43), EFGM.MenuScale(2), MenuAlias.whiteColor, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP, 1, MenuAlias.blackColor)

        if Menu.ActiveTab == "Tasks" then

            surface.SetDrawColor(MenuAlias.whiteColor)
            surface.DrawRect(EFGM.MenuScale(2), EFGM.MenuScale(39), w - EFGM.MenuScale(2), EFGM.MenuScale(2))

        end

    end

    tasksIcon.OnCursorEntered = function(s)

        tasksTab:SizeTo(EFGM.MenuScale(46) + tasksTextSize, tasksTab:GetTall(), 0.15, 0, 0.5)
        surface.PlaySound("ui/element_hover.wav")

    end

    tasksIcon.OnCursorExited = function(s)

        tasksTab:SizeTo(EFGM.MenuScale(38), tasksTab:GetTall(), 0.15, 0, 0.5)

    end

    function tasksIcon:DoClick()

        if Menu.ActiveTab == "Tasks" then return end

        if Menu.ActiveTab == "Match" then

            net.Start("RemovePlayerSquadRF")
            net.SendToServer()

        end

        surface.PlaySound("common/wpn_denyselect.wav")
        return

    end

    local skillsTab = vgui.Create("DPanel", self.MenuFrame.TabParentPanel)
    skillsTab:Dock(LEFT)
    skillsTab:SetSize(EFGM.MenuScale(38), 0)

    local skillsIcon = vgui.Create("DImageButton", skillsTab)
    skillsIcon:SetPos(EFGM.MenuScale(2), EFGM.MenuScale(2))
    skillsIcon:SetSize(EFGM.MenuScale(36), EFGM.MenuScale(36))
    skillsIcon:SetImage("icons/skills_icon.png")
    skillsIcon:SetDepressImage(false)

    local skillsBGColor = MenuAlias.transparent
    local skillsText = "#menu.tab.skills"
    local skillsTextSize = surface.GetTextSize(skillsText)

    skillsTab.Paint = function(s, w, h)

        surface.SetDrawColor(skillsBGColor)
        surface.DrawRect(0, 0, w, h)

        draw.SimpleTextOutlined(skillsText, "PuristaBold32", EFGM.MenuScale(43), EFGM.MenuScale(2), MenuAlias.whiteColor, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP, 1, MenuAlias.blackColor)

        if Menu.ActiveTab == "Skills" then

            surface.SetDrawColor(MenuAlias.whiteColor)
            surface.DrawRect(EFGM.MenuScale(2), EFGM.MenuScale(39), w - EFGM.MenuScale(2), EFGM.MenuScale(2))

        end

    end

    skillsIcon.OnCursorEntered = function(s)

        skillsTab:SizeTo(EFGM.MenuScale(46) + skillsTextSize, skillsTab:GetTall(), 0.15, 0, 0.5)
        surface.PlaySound("ui/element_hover.wav")

    end

    skillsIcon.OnCursorExited = function(s)

        skillsTab:SizeTo(EFGM.MenuScale(38), skillsTab:GetTall(), 0.15, 0, 0.5)

    end

    function skillsIcon:DoClick()

        if Menu.ActiveTab == "Skills" then return end

        if Menu.ActiveTab == "Match" then

            net.Start("RemovePlayerSquadRF")
            net.SendToServer()

        end

        surface.PlaySound("ui/element_select.wav")

        Menu.MenuFrame.LowerPanel.Contents:AlphaTo(0, 0.05, 0, function()

            Menu.MenuFrame.LowerPanel.Contents:Remove()
            Menu.OpenTab.Skills()
            Menu.ActiveTab = "Skills"

            Menu.MenuFrame.LowerPanel.Contents:AlphaTo(255, 0.05, 0, nil)

        end)

    end

    local intelTab = vgui.Create("DPanel", self.MenuFrame.TabParentPanel)
    intelTab:Dock(LEFT)
    intelTab:SetSize(EFGM.MenuScale(38), 0)

    local intelIcon = vgui.Create("DImageButton", intelTab)
    intelIcon:SetPos(EFGM.MenuScale(2), EFGM.MenuScale(2))
    intelIcon:SetSize(EFGM.MenuScale(36), EFGM.MenuScale(36))
    intelIcon:SetImage("icons/intel_icon.png")
    intelIcon:SetDepressImage(false)

    local intelBGColor = MenuAlias.transparent
    local intelText = "#menu.tab.intel"
    local intelTextSize = surface.GetTextSize(intelText)

    intelTab.Paint = function(s, w, h)

        surface.SetDrawColor(intelBGColor)
        surface.DrawRect(0, 0, w, h)

        draw.SimpleTextOutlined(intelText, "PuristaBold32", EFGM.MenuScale(43), EFGM.MenuScale(2), MenuAlias.whiteColor, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP, 1, MenuAlias.blackColor)

        if Menu.ActiveTab == "Intel" then

            surface.SetDrawColor(MenuAlias.whiteColor)
            surface.DrawRect(EFGM.MenuScale(2), EFGM.MenuScale(39), w - EFGM.MenuScale(2), EFGM.MenuScale(2))

        end

    end

    intelIcon.OnCursorEntered = function(s)

        intelTab:SizeTo(EFGM.MenuScale(46) + intelTextSize, intelTab:GetTall(), 0.15, 0, 0.5)
        surface.PlaySound("ui/element_hover.wav")

    end

    intelIcon.OnCursorExited = function(s)

        intelTab:SizeTo(EFGM.MenuScale(38), intelTab:GetTall(), 0.15, 0, 0.5)

    end

    function intelIcon:DoClick()

        if Menu.ActiveTab == "Intel" then return end

        surface.PlaySound("ui/element_select.wav")

        if Menu.ActiveTab == "Match" then

            net.Start("RemovePlayerSquadRF")
            net.SendToServer()

        end

        Menu.MenuFrame.LowerPanel.Contents:AlphaTo(0, 0.05, 0, function()

            Menu.MenuFrame.LowerPanel.Contents:Remove()
            Menu.OpenTab.Intel()
            Menu.ActiveTab = "Intel"

            Menu.MenuFrame.LowerPanel.Contents:AlphaTo(255, 0.05, 0, nil)

        end)

    end

    local achievementsTab = vgui.Create("DPanel", self.MenuFrame.TabParentPanel)
    achievementsTab:Dock(LEFT)
    achievementsTab:SetSize(EFGM.MenuScale(38), 0)

    local achievementsIcon = vgui.Create("DImageButton", achievementsTab)
    achievementsIcon:SetPos(EFGM.MenuScale(2), EFGM.MenuScale(2))
    achievementsIcon:SetSize(EFGM.MenuScale(36), EFGM.MenuScale(36))
    achievementsIcon:SetImage("icons/achievement_icon.png")
    achievementsIcon:SetDepressImage(false)

    local achievementsBGColor = MenuAlias.transparent
    local achievementsText = "#menu.tab.achievements"
    local achievementsTextSize = surface.GetTextSize(achievementsText)

    achievementsTab.Paint = function(s, w, h)

        surface.SetDrawColor(achievementsBGColor)
        surface.DrawRect(0, 0, w, h)

        draw.SimpleTextOutlined(achievementsText, "PuristaBold32", EFGM.MenuScale(43), EFGM.MenuScale(2), MenuAlias.whiteColor, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP, 1, MenuAlias.blackColor)

        if Menu.ActiveTab == "Achievements" then

            surface.SetDrawColor(MenuAlias.whiteColor)
            surface.DrawRect(EFGM.MenuScale(2), EFGM.MenuScale(39), w - EFGM.MenuScale(2), EFGM.MenuScale(2))

        end

    end

    achievementsIcon.OnCursorEntered = function(s)

        achievementsTab:SizeTo(EFGM.MenuScale(46) + achievementsTextSize, achievementsTab:GetTall(), 0.15, 0, 0.5)
        surface.PlaySound("ui/element_hover.wav")

    end

    achievementsIcon.OnCursorExited = function(s)

        achievementsTab:SizeTo(EFGM.MenuScale(38), achievementsTab:GetTall(), 0.15, 0, 0.5)

    end

    function achievementsIcon:DoClick()

        if Menu.ActiveTab == "Achievements" then return end

        if Menu.ActiveTab == "Match" then

            net.Start("RemovePlayerSquadRF")
            net.SendToServer()

        end

        surface.PlaySound("common/wpn_denyselect.wav")
        return

    end

    -- local contractsTab = vgui.Create("DButton", self.MenuFrame.TabParentPanel)
    -- contractsTab:Dock(LEFT)
    -- contractsTab:SetSize(surface.GetTextSize("Contracts") + EFGM.MenuScale(50), 0)
    -- contractsTab:SetText("Contracts")

    -- local unlocksTab = vgui.Create("DButton", self.MenuFrame.TabParentPanel)
    -- unlocksTab:Dock(LEFT)
    -- unlocksTab:SetSize(surface.GetTextSize("Unlocks") + EFGM.MenuScale(50), 0)
    -- unlocksTab:SetText("Unlocks")

    local settingsTab = vgui.Create("DPanel", self.MenuFrame.TabParentPanel)
    settingsTab:Dock(LEFT)
    settingsTab:SetSize(EFGM.MenuScale(38), 0)

    local settingsIcon = vgui.Create("DImageButton", settingsTab)
    settingsIcon:SetPos(EFGM.MenuScale(2), EFGM.MenuScale(2))
    settingsIcon:SetSize(EFGM.MenuScale(36), EFGM.MenuScale(36))
    settingsIcon:SetImage("icons/settings_icon.png")
    settingsIcon:SetDepressImage(false)

    local settingsBGColor = MenuAlias.transparent
    local settingsText = "#menu.tab.settings"
    local settingsTextSize = surface.GetTextSize(settingsText)

    settingsTab.Paint = function(s, w, h)

        surface.SetDrawColor(settingsBGColor)
        surface.DrawRect(0, 0, w, h)

        draw.SimpleTextOutlined(settingsText, "PuristaBold32", EFGM.MenuScale(43), EFGM.MenuScale(2), MenuAlias.whiteColor, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP, 1, MenuAlias.blackColor)

        if Menu.ActiveTab == "Settings" then

            surface.SetDrawColor(MenuAlias.whiteColor)
            surface.DrawRect(EFGM.MenuScale(2), EFGM.MenuScale(39), w - EFGM.MenuScale(2), EFGM.MenuScale(2))

        end

    end

    settingsIcon.OnCursorEntered = function(s)

        settingsTab:SizeTo(EFGM.MenuScale(46) + settingsTextSize, settingsTab:GetTall(), 0.15, 0, 0.5)
        surface.PlaySound("ui/element_hover.wav")

    end

    settingsIcon.OnCursorExited = function(s)

        settingsTab:SizeTo(EFGM.MenuScale(38), settingsTab:GetTall(), 0.15, 0, 0.5)

    end

    function settingsIcon:DoClick()

        if Menu.ActiveTab == "Settings" then return end

        surface.PlaySound("ui/element_select.wav")

        if Menu.ActiveTab == "Match" then

            net.Start("RemovePlayerSquadRF")
            net.SendToServer()

        end

        Menu.MenuFrame.LowerPanel.Contents:AlphaTo(0, 0.05, 0, function()

            Menu.MenuFrame.LowerPanel.Contents:Remove()
            Menu.OpenTab.Settings()
            Menu.ActiveTab = "Settings"

            Menu.MenuFrame.LowerPanel.Contents:AlphaTo(255, 0.05, 0, nil)

        end)

    end

    -- if provided, open to the tab of the users choice
    if openTo != nil then

        -- i cant figure this out so enjoy the Inventory tab
        Menu.OpenTab.Inventory(container)
        Menu.MenuFrame.LowerPanel.Contents:AlphaTo(255, 0.05, 0, nil)
        Menu.ActiveTab = "Inventory"

    end

end

-- called to either initialize or open the menu
function Menu:Open(openTo, container)

    if container == nil then container = {} end

    if self.MenuFrame != nil then

        self.MenuFrame:Remove()

    end

    self:Initialize(openTo, container)

end

function Menu.InspectItem(item, data)

    if IsValid(inspectPanel) then inspectPanel:Remove() end

    local i = EFGMITEMS[item]
    if i == nil then inspectPanel:Remove() return end

    surface.SetFont("PuristaBold24")
    local itemNameText = string.upper(i.fullName)
    local itemNameSize = surface.GetTextSize(itemNameText)

    local value = i.value

    if data and data.att then

        local atts = GetPrefixedAttachmentListFromCode(data.att)
        if !atts then return end

        for _, a in ipairs(atts) do

            local att = EFGMITEMS[a]
            if att == nil then return end

            value = value + att.value

        end

    end

    surface.SetFont("PuristaBold18")
    local itemDescText = string.upper(i.displayType) .. " / " .. string.upper(i.weight) .. "KG" .. " / ₽" .. string.upper(comma_value(value))
    local itemDescSize = surface.GetTextSize(itemDescText)

    local iconSizeX, iconSizeY = EFGM.MenuScale(114 * i.sizeX), EFGM.MenuScale(114 * i.sizeY)

    local panelWidth
    if iconSizeX >= itemNameSize then panelWidth = iconSizeX else panelWidth = itemNameSize end
    if itemDescSize >= panelWidth then panelWidth = itemDescSize end

    local originalWidth, originalHeight = EFGM.MenuScale(114 * i.sizeX), EFGM.MenuScale(114 * i.sizeY)
    local scaleFactor
    local targetMaxDimension = math.min(panelWidth, i.sizeX * 200)

    if originalWidth > originalHeight then

        scaleFactor = targetMaxDimension / originalWidth

    else

        scaleFactor = targetMaxDimension / originalHeight

    end

    local newPanelWidth = math.Round(originalWidth * scaleFactor)
    local newPanelHeight = math.Round(originalHeight * scaleFactor)

    inspectPanel = vgui.Create("DFrame", Menu.MenuFrame)
    inspectPanel:SetSize(panelWidth + EFGM.MenuScale(40), newPanelHeight + EFGM.MenuScale(100))
    inspectPanel:Center()
    inspectPanel:SetAlpha(0)
    inspectPanel:SetTitle("")
    inspectPanel:ShowCloseButton(false)
    inspectPanel:SetScreenLock(true)
    inspectPanel:AlphaTo(255, 0.1, 0, nil)

    inspectPanel.Paint = function(s, w, h)

        BlurPanel(s, EFGM.MenuScale(3))

        surface.SetDrawColor(Color(20, 20, 20, 205))
        surface.DrawRect(0, 0, w, h)

        surface.SetDrawColor(Color(255, 255, 255, 155))
        surface.DrawRect(0, 0, w, EFGM.MenuScale(6))

        surface.SetDrawColor(Color(255, 255, 255, 25))
        surface.DrawRect(0, 0, w, EFGM.MenuScale(1))
        surface.DrawRect(0, h - EFGM.MenuScale(1), w, EFGM.MenuScale(1))
        surface.DrawRect(0, 0, EFGM.MenuScale(1), h)
        surface.DrawRect(w - EFGM.MenuScale(1), 0, EFGM.MenuScale(1), h)

        draw.SimpleTextOutlined(itemNameText, "PuristaBold24", EFGM.MenuScale(5), EFGM.MenuScale(5), MenuAlias.whiteColor, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP, 1, MenuAlias.blackColor)
        draw.SimpleTextOutlined(itemDescText, "PuristaBold18", EFGM.MenuScale(5), EFGM.MenuScale(25), MenuAlias.whiteColor, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP, 1, MenuAlias.blackColor)

        surface.SetDrawColor(255, 255, 255, 255)
        surface.SetMaterial(i.icon)

        -- panel width = 198, panel height = 216
        local x = inspectPanel:GetWide() / 2 - (newPanelWidth / 2)
        local y = inspectPanel:GetTall() / 2 - (newPanelHeight / 2)

        surface.DrawTexturedRect(x, y, newPanelWidth, newPanelHeight)

    end

    local itemPullOutPanel = vgui.Create("DPanel", inspectPanel)
    itemPullOutPanel:SetSize(inspectPanel:GetWide(), inspectPanel:GetTall() - EFGM.MenuScale(75))
    itemPullOutPanel:SetPos(0, inspectPanel:GetTall() - EFGM.MenuScale(1))
    itemPullOutPanel:SetAlpha(255)
    itemPullOutPanel.Paint = function(s, w, h)

        BlurPanel(s, EFGM.MenuScale(1))

        surface.SetDrawColor(Color(20, 20, 20, 205))
        surface.DrawRect(0, 0, w, h)

        surface.SetDrawColor(Color(255, 255, 255, 25))
        surface.DrawRect(0, 0, w, EFGM.MenuScale(1))
        surface.DrawRect(0, h - EFGM.MenuScale(1), w, EFGM.MenuScale(1))
        surface.DrawRect(0, 0, EFGM.MenuScale(1), h)
        surface.DrawRect(w - EFGM.MenuScale(1), 0, EFGM.MenuScale(1), h)

    end

    surface.SetFont("PuristaBold24")
    local infoText = "INFO"
    local infoTextSize = surface.GetTextSize(infoText)

    local itemInfoButton = vgui.Create("DButton", inspectPanel)
    itemInfoButton:SetPos(EFGM.MenuScale(1), itemPullOutPanel:GetY() - EFGM.MenuScale(28))
    itemInfoButton:SetSize(infoTextSize + EFGM.MenuScale(10), EFGM.MenuScale(28))
    itemInfoButton:SetText("")
    itemInfoButton.Paint = function(s, w, h)

        s:SetY(itemPullOutPanel:GetY() - EFGM.MenuScale(28))

        BlurPanel(s, EFGM.MenuScale(0))

        surface.SetDrawColor(Color(80, 80, 80, 10))
        surface.DrawRect(0, 0, infoTextSize + EFGM.MenuScale(10), h)

        surface.SetDrawColor(Color(255, 255, 255, 155))
        surface.DrawRect(0, 0, infoTextSize + EFGM.MenuScale(10), EFGM.MenuScale(2))

        draw.SimpleTextOutlined(infoText, "PuristaBold24", EFGM.MenuScale(5), EFGM.MenuScale(2), MenuAlias.whiteColor, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP, 1, MenuAlias.blackColor)

    end

    surface.SetFont("PuristaBold24")
    local wikiText = "WIKI"
    local wikiTextSize = surface.GetTextSize(wikiText)

    local itemWikiButton = vgui.Create("DButton", inspectPanel)
    itemWikiButton:SetPos(itemInfoButton:GetWide() + EFGM.MenuScale(1), itemPullOutPanel:GetY() - EFGM.MenuScale(28))
    itemWikiButton:SetSize(wikiTextSize + EFGM.MenuScale(10), EFGM.MenuScale(28))
    itemWikiButton:SetText("")
    itemWikiButton.Paint = function(s, w, h)

        s:SetY(itemPullOutPanel:GetY() - EFGM.MenuScale(28))

        BlurPanel(s, EFGM.MenuScale(0))

        surface.SetDrawColor(Color(80, 80, 80, 10))
        surface.DrawRect(0, 0, wikiTextSize + EFGM.MenuScale(10), h)

        surface.SetDrawColor(Color(255, 255, 255, 155))
        surface.DrawRect(0, 0, wikiTextSize + EFGM.MenuScale(10), EFGM.MenuScale(2))

        draw.SimpleTextOutlined(wikiText, "PuristaBold24", EFGM.MenuScale(5), EFGM.MenuScale(2), MenuAlias.whiteColor, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP, 1, MenuAlias.blackColor)

    end

    if !data or table.IsEmpty(data) then

        itemInfoButton:Remove()
        itemWikiButton:SetX(EFGM.MenuScale(1))

    end

    local pullOutContent = vgui.Create("DPanel", itemPullOutPanel)
    pullOutContent:Dock(FILL)
    pullOutContent:DockPadding(EFGM.MenuScale(10), EFGM.MenuScale(10), EFGM.MenuScale(10), EFGM.MenuScale(10))
    pullOutContent:SetAlpha(0)
    pullOutContent.Paint = function(s, w, h)

        surface.SetDrawColor(MenuAlias.transparent)
        surface.DrawRect(0, 0, w, h)

    end

    itemPullOutPanel.content = pullOutContent

    local tab

    local function OpenPullOutInfoTab()

        tab = "Info"

        local infoContent = vgui.Create("DPanel", itemPullOutPanel)
        infoContent:Dock(FILL)
        infoContent:DockPadding(EFGM.MenuScale(5), EFGM.MenuScale(5), EFGM.MenuScale(5), EFGM.MenuScale(5))
        infoContent:SetAlpha(0)
        infoContent.Paint = function(s, w, h)

            surface.SetDrawColor(MenuAlias.transparent)
            surface.DrawRect(0, 0, w, h)

        end

        local infoContentText = vgui.Create("RichText", infoContent)
        infoContentText:Dock(FILL)
        infoContentText:SetVerticalScrollbarEnabled(true)
        infoContentText:InsertColorChange(255, 255, 255, 255)

        if data.count != 0 and data.count != 1 and data.count != nil then

            infoContentText:AppendText("COUNT: " .. data.count .. "\n")

        end

        if data.att then

            infoContentText:AppendText("ATTACHMENTS: \n" .. GetAttachmentListFromCode(data.att) .. "\n")

        end

        function infoContentText:PerformLayout()

            infoContentText:SetFontInternal("PuristaBold18")

        end

        itemPullOutPanel.content = infoContent

    end

    local function OpenPullOutWikiTab()

        tab = "Wiki"

        local wikiContent = vgui.Create("DPanel", itemPullOutPanel)
        wikiContent:Dock(FILL)
        wikiContent:DockPadding(EFGM.MenuScale(5), EFGM.MenuScale(5), EFGM.MenuScale(5), EFGM.MenuScale(5))
        wikiContent:SetAlpha(0)
        wikiContent.Paint = function(s, w, h)

            surface.SetDrawColor(MenuAlias.transparent)
            surface.DrawRect(0, 0, w, h)

        end

        local wikiContentText = vgui.Create("RichText", wikiContent)
        wikiContentText:Dock(FILL)
        wikiContentText:SetVerticalScrollbarEnabled(true)
        wikiContentText:InsertColorChange(255, 255, 255, 255)

        local wep = table.Copy(weapons.Get(item))

        if i.fullName and i.displayName then

            wikiContentText:AppendText("NAME: " .. i.fullName .. " (" .. i.displayName .. ")" .. "\n")

        end

        if i.description then

            wikiContentText:AppendText("DESCRIPTION: " .. i.description .. "\n")

        elseif wep != nil and wep["Description"] then

            wikiContentText:AppendText("DESCRIPTION: " .. wep["Description"] .. "\n")

        end

        if i.displayType then

            wikiContentText:AppendText("TYPE: " .. i.displayType .. "\n")

        end

        if i.weight then

            wikiContentText:AppendText("WEIGHT: " .. i.weight .. "kg" .. "\n")

        end

        if i.value then

            wikiContentText:AppendText("EST. VALUE: ₽" .. comma_value(i.value) .. "\n")

        end

        if i.sizeX and i.sizeY then

            wikiContentText:AppendText("SIZE: " .. i.sizeX .. "x" .. i.sizeY .. "\n")

        end

        if i.stackSize then

            wikiContentText:AppendText("STACK SIZE: " .. i.stackSize  .. "\n")

        end

        if i.equipType == EQUIPTYPE.Weapon and wep != nil then

            wikiContentText:AppendText("\n")

            local caliber = ARC9:GetPhrase(wep["Trivia"]["eft_trivia_cal2"]) or nil
            local firemodes = wep["Firemodes"] or nil
            local damageMax = math.Round(wep["DamageMax"]) or nil
            local damageMin = math.Round(wep["DamageMin"]) or nil
            local rpm = math.Round(wep["RPM"]) or nil
            local range = math.Round(wep["RangeMax"] * 0.0254) or nil
            local velocity = math.Round(wep["PhysBulletMuzzleVelocity"] * 0.0254) or nil

            local recoilMult = math.Round(wep["Recoil"]) or 1
            local recoilUp = math.Round(wep["RecoilUp"] * recoilMult, 2) or nil
            local recoilUpRand = math.Round(wep["RecoilRandomUp"] * recoilMult, 2) or nil
            local recoilSide = math.Round(wep["RecoilSide"] * recoilMult, 2) or nil
            local recoilSideRand = math.Round(wep["RecoilRandomSide"] * recoilMult, 2) or nil
            local accuracy = math.Round(wep["Spread"] * 360 * 60 / 10, 2)
            local ergo = wep["EFTErgo"] or nil

            local manufacturer = ARC9:GetPhrase(wep["Trivia"]["eft_trivia_manuf1"]) or nil
            local country = ARC9:GetPhrase(wep["Trivia"]["eft_trivia_country4"]) or nil
            local year = wep["Trivia"]["eft_trivia_year5"] or nil

            if caliber then

                wikiContentText:AppendText("CALIBER: " ..  caliber .. "\n")

            end

            if firemodes then

                str = ""

                for k, v in pairs(firemodes) do
                    if v.PrintName then str = str .. v.PrintName .. ", "

                    else

                        if v.Mode then

                            if v.Mode == 0 then str = str .. "Safe" .. ", "
                            elseif v.Mode < 0 then str = str .. "Auto" .. ", "
                            elseif v.Mode == 1 then str = str .. "Single" .. ", "
                            elseif v.Mode > 1 then str = str .. tostring(v.Mode) .. "-" .. "Burst" .. ", " end

                        end

                    end

                end

                str = string.sub(str, 1, string.len(str) - 2)

                wikiContentText:AppendText("FIRING MODES: " ..  str .. "\n")

            end

            if damageMax and damageMin then

                wikiContentText:AppendText("DAMAGE: " ..  damageMax .. " → " .. damageMin .. "\n")

            end

            if rpm then

                wikiContentText:AppendText("RPM: " ..  rpm .. "\n")

            end

            if range then

                wikiContentText:AppendText("RANGE: " ..  range .. "m" .. "\n")

            end

            if velocity then

                wikiContentText:AppendText("MUZZLE VELOCITY: " ..  velocity .. "m/s" .. "\n")

            end

            if recoilUp and recoilUpRand then

                wikiContentText:AppendText("VERTICAL RECOIL: " .. recoilUp .. " + " .. recoilUpRand .. "°" .. "\n")

            end

            if recoilSide and recoilSideRand then

                wikiContentText:AppendText("HORIZONTAL RECOIL: " .. recoilSide .. " + " .. recoilSideRand .. "°" .. "\n")

            end

            if accuracy and accuracy != 0 then

                wikiContentText:AppendText("ACCURACY: " .. accuracy .. " MOA" .. "\n")

            end

            if ergo and ergo != 0 then

                wikiContentText:AppendText("ERGONOMICS: " .. ergo .. "\n")

            end

            wikiContentText:AppendText("\n")

            if manufacturer then

                wikiContentText:AppendText("MANUFACTURER: " ..  manufacturer .. "\n")

            end

            if country then

                wikiContentText:AppendText("COUNTRY: " ..  country .. "\n")

            end

            if year then

                wikiContentText:AppendText("YEAR: " ..  year)

            end

        end

        function wikiContentText:PerformLayout()

            wikiContentText:SetFontInternal("PuristaBold18")

        end

        itemPullOutPanel.content = wikiContent

    end

    itemInfoButton.OnCursorEntered = function(s)

        surface.PlaySound("ui/element_hover.wav")

    end

    itemInfoButton.DoClick = function(s)

        if tab == "Info" then return end

        surface.PlaySound("ui/element_select.wav")

        itemPullOutPanel:MoveTo(0, EFGM.MenuScale(75), 0.1, 0, 0.3)

        itemPullOutPanel.content:AlphaTo(0, 0.05, 0, function()

            itemPullOutPanel.content:Remove()
            OpenPullOutInfoTab()
            itemPullOutPanel.content:AlphaTo(255, 0.05, 0, nil)

        end)

    end

    itemWikiButton.OnCursorEntered = function(s)

        surface.PlaySound("ui/element_hover.wav")

    end

    itemWikiButton.DoClick = function(s)

        if tab == "Wiki" then return end

        surface.PlaySound("ui/element_select.wav")

        itemPullOutPanel:MoveTo(0, EFGM.MenuScale(75), 0.1, 0, 0.3)

        itemPullOutPanel.content:AlphaTo(0, 0.05, 0, function()

            itemPullOutPanel.content:Remove()
            OpenPullOutWikiTab()
            itemPullOutPanel.content:AlphaTo(255, 0.05, 0, nil)

        end)

    end

    inspectPanel.OnMousePressed = function(s)

        itemPullOutPanel:MoveTo(0, inspectPanel:GetTall() - EFGM.MenuScale(1), 0.1, 0, 0.3)

        tab = nil

        itemPullOutPanel.content:AlphaTo(0, 0.05, 0, function() end)

        local screenX, screenY = s:LocalToScreen( 0, 0 )

        if ( s.m_bSizable && gui.MouseX() > ( screenX + s:GetWide() - 20 ) && gui.MouseY() > ( screenY + s:GetTall() - 20 ) ) then
            s.Sizing = { gui.MouseX() - s:GetWide(), gui.MouseY() - s:GetTall() }
            s:MouseCapture( true )
            return
        end

        if ( s:GetDraggable() && gui.MouseY() < ( screenY + 24 ) ) then
            s.Dragging = { gui.MouseX() - s.x, gui.MouseY() - s.y }
            s:MouseCapture( true )
            return
        end

    end

    local closeButtonIcon = Material("icons/close_icon.png")
    local closeButton = vgui.Create("DButton", inspectPanel)
    closeButton:SetSize(EFGM.MenuScale(32), EFGM.MenuScale(32))
    closeButton:SetPos(inspectPanel:GetWide() - EFGM.MenuScale(32), EFGM.MenuScale(5))
    closeButton:SetText("")
    closeButton.Paint = function(s, w, h)

        surface.SetDrawColor(255, 255, 255, 255)
        surface.SetMaterial(closeButtonIcon)
        surface.DrawTexturedRect(EFGM.MenuScale(0), EFGM.MenuScale(0), EFGM.MenuScale(32), EFGM.MenuScale(32))

    end

    closeButton.OnCursorEntered = function(s)

        surface.PlaySound("ui/element_hover.wav")

    end

    function closeButton:DoClick()

        inspectPanel:AlphaTo(0, 0.1, 0, function() inspectPanel:Remove() end)

    end

end

function Menu.ConfirmPurchase(item)

    if IsValid(confirmPanel) then confirmPanel:Remove() end

    local i = EFGMITEMS[item]
    if i == nil then confirmPanel:Remove() return end

    local transactionCost = i.value
    local transactionCount = 1

    local plyMoney = Menu.Player:GetNWInt("Money", 0)
    local plyLevel = Menu.Player:GetNWInt("Level", 1)

    -- can't afford one of the item
    if plyMoney < i.value then surface.PlaySound("ui/element_deselect.wav") return end
    if plyLevel < (i.levelReq or 1) then surface.PlaySound("ui/element_deselect.wav") return end

    local maxTransactionCount = math.Clamp(math.floor(plyMoney / i.value), 1, i.stackSize)

    surface.SetFont("PuristaBold24")
    local confirmText = "Purchase " .. transactionCount .. "x " .. i.fullName .. " (" .. i.displayName .. ") for ₽" .. comma_value(transactionCost) .. "?"
    local confirmTextSize = math.max(EFGM.MenuScale(300), surface.GetTextSize(confirmText))

    local confirmPanelHeight = EFGM.MenuScale(70)

    if i.stackSize > 1 and maxTransactionCount > 1 then confirmPanelHeight = EFGM.MenuScale(100) end

    surface.PlaySound("ui/element_select.wav")

    confirmPanel = vgui.Create("DFrame", Menu.MenuFrame)
    confirmPanel:SetSize(confirmTextSize + EFGM.MenuScale(10), confirmPanelHeight)
    confirmPanel:Center()
    confirmPanel:SetAlpha(0)
    confirmPanel:SetTitle("")
    confirmPanel:ShowCloseButton(false)
    confirmPanel:SetScreenLock(true)
    confirmPanel:AlphaTo(255, 0.1, 0, nil)
    confirmPanel:RequestFocus()

    confirmPanel.Paint = function(s, w, h)

        confirmPanel:SetWide(confirmTextSize + EFGM.MenuScale(10))

        BlurPanel(s, EFGM.MenuScale(3))

        surface.SetDrawColor(Color(20, 20, 20, 205))
        surface.DrawRect(0, 0, w, h)

        surface.SetDrawColor(Color(255, 255, 255, 155))
        surface.DrawRect(0, 0, w, EFGM.MenuScale(6))

        surface.SetDrawColor(Color(255, 255, 255, 25))
        surface.DrawRect(0, 0, w, EFGM.MenuScale(1))
        surface.DrawRect(0, h - EFGM.MenuScale(1), w, EFGM.MenuScale(1))
        surface.DrawRect(0, 0, EFGM.MenuScale(1), h)
        surface.DrawRect(w - EFGM.MenuScale(1), 0, EFGM.MenuScale(1), h)

        draw.SimpleTextOutlined(confirmText, "PuristaBold24", w / 2, EFGM.MenuScale(5), MenuAlias.whiteColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 1, MenuAlias.blackColor)

    end

    confirmPanel.Think = function()

        if (input.IsMouseDown(MOUSE_LEFT) or input.IsMouseDown(MOUSE_RIGHT) or input.IsMouseDown(MOUSE_MIDDLE) or input.IsMouseDown(MOUSE_WHEEL_DOWN) or input.IsMouseDown(MOUSE_WHEEL_UP)) and !confirmPanel:IsChildHovered() and !confirmPanel:IsHovered() then confirmPanel:AlphaTo(0, 0.1, 0, function() confirmPanel:Remove() end) end

    end

    surface.SetFont("PuristaBold24")
    local yesText = "YES"
    local yesTextSize = surface.GetTextSize(yesText)
    local yesButtonSize = yesTextSize + EFGM.MenuScale(10)

    local yesButton = vgui.Create("DButton", confirmPanel)
    yesButton:SetPos(confirmPanel:GetWide() / 2 - (yesButtonSize / 2) - EFGM.MenuScale(25), confirmPanelHeight - EFGM.MenuScale(35))
    yesButton:SetSize(yesButtonSize, EFGM.MenuScale(28))
    yesButton:SetText("")
    yesButton.Paint = function(s, w, h)

        yesButton:SetX(confirmPanel:GetWide() / 2 - (yesButtonSize / 2) - EFGM.MenuScale(25))

        BlurPanel(s, EFGM.MenuScale(0))

        surface.SetDrawColor(Color(80, 80, 80, 10))
        surface.DrawRect(0, 0, yesTextSize + EFGM.MenuScale(10), h)

        surface.SetDrawColor(Color(255, 255, 255, 155))
        surface.DrawRect(0, 0, yesTextSize + EFGM.MenuScale(10), EFGM.MenuScale(2))

        draw.SimpleTextOutlined(yesText, "PuristaBold24", w / 2, EFGM.MenuScale(2), MenuAlias.whiteColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 1, MenuAlias.blackColor)

    end

    surface.SetFont("PuristaBold24")
    local noText = "NO"
    local noTextSize = surface.GetTextSize(noText)
    local noButtonSize = noTextSize + EFGM.MenuScale(10)

    local noButton = vgui.Create("DButton", confirmPanel)
    noButton:SetPos(confirmPanel:GetWide() / 2 - (noButtonSize / 2) + EFGM.MenuScale(25), confirmPanelHeight - EFGM.MenuScale(35))
    noButton:SetSize(noButtonSize, EFGM.MenuScale(28))
    noButton:SetText("")
    noButton.Paint = function(s, w, h)

        noButton:SetX(confirmPanel:GetWide() / 2 - (noButtonSize / 2) + EFGM.MenuScale(25))

        BlurPanel(s, EFGM.MenuScale(0))

        surface.SetDrawColor(Color(80, 80, 80, 10))
        surface.DrawRect(0, 0, noButtonSize + EFGM.MenuScale(10), h)

        surface.SetDrawColor(Color(255, 255, 255, 155))
        surface.DrawRect(0, 0, noButtonSize + EFGM.MenuScale(10), EFGM.MenuScale(2))

        draw.SimpleTextOutlined(noText, "PuristaBold24", w / 2, EFGM.MenuScale(2), MenuAlias.whiteColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 1, MenuAlias.blackColor)

    end

    if i.stackSize > 1 and maxTransactionCount > 1 then

        local amountSlider = vgui.Create("DNumSlider", confirmPanel)
        amountSlider:SetPos(confirmPanel:GetWide() / 2 - EFGM.MenuScale(160), EFGM.MenuScale(35))
        amountSlider:SetSize(EFGM.MenuScale(240), EFGM.MenuScale(15))
        amountSlider:SetMin(1)
        amountSlider:SetMax(maxTransactionCount)
        amountSlider:SetValue(1)
        amountSlider:SetDefaultValue(1)
        amountSlider:SetDecimals(0)

        local num = 1
        amountSlider.OnValueChanged = function(self, val)

            if val == num then return end

            num = math.Round(val)

            transactionCost = i.value * num
            transactionCount = num

            surface.SetFont("PuristaBold24")
            confirmText = "Purchase " .. transactionCount .. "x " .. i.fullName .. " (" .. i.displayName .. ") for ₽" .. comma_value(transactionCost) .. "?"
            confirmTextSize = math.max(EFGM.MenuScale(300), surface.GetTextSize(confirmText))

        end

        amountSlider.Think = function()

            -- amountSlider:SetX(confirmPanel:GetWide() / 2 - EFGM.MenuScale(160))

        end

    end

    yesButton.OnCursorEntered = function(s)

        surface.PlaySound("ui/element_hover.wav")

    end

    function yesButton:DoClick()

        surface.PlaySound("ui/success.wav")
        confirmPanel:AlphaTo(0, 0.1, 0, function() confirmPanel:Remove() end)
        PurchaseItem(item, transactionCount)

    end

    noButton.OnCursorEntered = function(s)

        surface.PlaySound("ui/element_hover.wav")

    end

    function noButton:DoClick()

        surface.PlaySound("ui/element_deselect.wav")
        confirmPanel:AlphaTo(0, 0.1, 0, function() confirmPanel:Remove() end)

    end

end

function Menu.ConfirmSell(item, data, key)

    if IsValid(confirmPanel) then confirmPanel:Remove() end

    local i = EFGMITEMS[item]
    if i == nil then confirmPanel:Remove() return end

    local transactionCost = math.floor(i.value * sellMultiplier)
    local transactionCount = 1

    if data.att then

        local atts = GetPrefixedAttachmentListFromCode(data.att)
        if !atts then return end

        for _, a in ipairs(atts) do

            local att = EFGMITEMS[a]
            if att == nil then return end

            transactionCost = transactionCost + math.floor(att.value * sellMultiplier)

        end

    end

    local maxTransactionCount = math.Clamp(data.count or 1, 1, i.stackSize)

    surface.SetFont("PuristaBold24")
    local confirmText = "Sell " .. transactionCount .. "x " .. i.fullName .. " (" .. i.displayName .. ") for ₽" .. comma_value(transactionCost) .. "?"
    local confirmTextSize = math.max(EFGM.MenuScale(300), surface.GetTextSize(confirmText))

    local confirmPanelHeight = EFGM.MenuScale(70)

    if i.stackSize > 1 and maxTransactionCount > 1 then confirmPanelHeight = EFGM.MenuScale(100) end

    surface.PlaySound("ui/element_select.wav")

    confirmPanel = vgui.Create("DFrame", Menu.MenuFrame)
    confirmPanel:SetSize(confirmTextSize + EFGM.MenuScale(10), confirmPanelHeight)
    confirmPanel:Center()
    confirmPanel:SetAlpha(0)
    confirmPanel:SetTitle("")
    confirmPanel:ShowCloseButton(false)
    confirmPanel:SetScreenLock(true)
    confirmPanel:AlphaTo(255, 0.1, 0, nil)
    confirmPanel:RequestFocus()

    confirmPanel.Paint = function(s, w, h)

        confirmPanel:SetWide(confirmTextSize + EFGM.MenuScale(10))

        BlurPanel(s, EFGM.MenuScale(3))

        surface.SetDrawColor(Color(20, 20, 20, 205))
        surface.DrawRect(0, 0, w, h)

        surface.SetDrawColor(Color(255, 255, 255, 155))
        surface.DrawRect(0, 0, w, EFGM.MenuScale(6))

        surface.SetDrawColor(Color(255, 255, 255, 25))
        surface.DrawRect(0, 0, w, EFGM.MenuScale(1))
        surface.DrawRect(0, h - EFGM.MenuScale(1), w, EFGM.MenuScale(1))
        surface.DrawRect(0, 0, EFGM.MenuScale(1), h)
        surface.DrawRect(w - EFGM.MenuScale(1), 0, EFGM.MenuScale(1), h)

        draw.SimpleTextOutlined(confirmText, "PuristaBold24", w / 2, EFGM.MenuScale(5), MenuAlias.whiteColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 1, MenuAlias.blackColor)

    end

    confirmPanel.Think = function()

        if (input.IsMouseDown(MOUSE_LEFT) or input.IsMouseDown(MOUSE_RIGHT) or input.IsMouseDown(MOUSE_MIDDLE) or input.IsMouseDown(MOUSE_WHEEL_DOWN) or input.IsMouseDown(MOUSE_WHEEL_UP)) and !confirmPanel:IsChildHovered() and !confirmPanel:IsHovered() then confirmPanel:AlphaTo(0, 0.1, 0, function() confirmPanel:Remove() end) end

    end

    surface.SetFont("PuristaBold24")
    local yesText = "YES"
    local yesTextSize = surface.GetTextSize(yesText)
    local yesButtonSize = yesTextSize + EFGM.MenuScale(10)

    local yesButton = vgui.Create("DButton", confirmPanel)
    yesButton:SetPos(confirmPanel:GetWide() / 2 - (yesButtonSize / 2) - EFGM.MenuScale(25), confirmPanelHeight - EFGM.MenuScale(35))
    yesButton:SetSize(yesButtonSize, EFGM.MenuScale(28))
    yesButton:SetText("")
    yesButton.Paint = function(s, w, h)

        yesButton:SetX(confirmPanel:GetWide() / 2 - (yesButtonSize / 2) - EFGM.MenuScale(25))

        BlurPanel(s, EFGM.MenuScale(0))

        surface.SetDrawColor(Color(80, 80, 80, 10))
        surface.DrawRect(0, 0, yesTextSize + EFGM.MenuScale(10), h)

        surface.SetDrawColor(Color(255, 255, 255, 155))
        surface.DrawRect(0, 0, yesTextSize + EFGM.MenuScale(10), EFGM.MenuScale(2))

        draw.SimpleTextOutlined(yesText, "PuristaBold24", w / 2, EFGM.MenuScale(2), MenuAlias.whiteColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 1, MenuAlias.blackColor)

    end

    surface.SetFont("PuristaBold24")
    local noText = "NO"
    local noTextSize = surface.GetTextSize(noText)
    local noButtonSize = noTextSize + EFGM.MenuScale(10)

    local noButton = vgui.Create("DButton", confirmPanel)
    noButton:SetPos(confirmPanel:GetWide() / 2 - (noButtonSize / 2) + EFGM.MenuScale(25), confirmPanelHeight - EFGM.MenuScale(35))
    noButton:SetSize(noButtonSize, EFGM.MenuScale(28))
    noButton:SetText("")
    noButton.Paint = function(s, w, h)

        noButton:SetX(confirmPanel:GetWide() / 2 - (noButtonSize / 2) + EFGM.MenuScale(25))

        BlurPanel(s, EFGM.MenuScale(0))

        surface.SetDrawColor(Color(80, 80, 80, 10))
        surface.DrawRect(0, 0, noButtonSize + EFGM.MenuScale(10), h)

        surface.SetDrawColor(Color(255, 255, 255, 155))
        surface.DrawRect(0, 0, noButtonSize + EFGM.MenuScale(10), EFGM.MenuScale(2))

        draw.SimpleTextOutlined(noText, "PuristaBold24", w / 2, EFGM.MenuScale(2), MenuAlias.whiteColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 1, MenuAlias.blackColor)

    end

    if i.stackSize > 1 and maxTransactionCount > 1 then

        local amountSlider = vgui.Create("DNumSlider", confirmPanel)
        amountSlider:SetPos(confirmPanel:GetWide() / 2 - EFGM.MenuScale(160), EFGM.MenuScale(35))
        amountSlider:SetSize(EFGM.MenuScale(240), EFGM.MenuScale(15))
        amountSlider:SetMin(1)
        amountSlider:SetMax(maxTransactionCount)
        amountSlider:SetValue(1)
        amountSlider:SetDefaultValue(1)
        amountSlider:SetDecimals(0)

        local num = 1
        amountSlider.OnValueChanged = function(self, val)

            if val == num then return end

            num = math.Round(val)

            transactionCost = math.floor(i.value * sellMultiplier) * num
            transactionCount = num

            if data.att then

                local atts = GetPrefixedAttachmentListFromCode(data.att)
                if !atts then return end

                for _, a in ipairs(atts) do

                    local att = EFGMITEMS[a]
                    if att == nil then return end

                    transactionCost = transactionCost + math.floor(att.value * sellMultiplier)

                end

            end

            surface.SetFont("PuristaBold24")
            confirmText = "Sell " .. transactionCount .. "x " .. i.fullName .. " (" .. i.displayName .. ") for ₽" .. comma_value(transactionCost) .. "?"
            confirmTextSize = math.max(EFGM.MenuScale(300), surface.GetTextSize(confirmText))

        end

        amountSlider.Think = function()

            -- amountSlider:SetX(confirmPanel:GetWide() / 2 - EFGM.MenuScale(160))

        end

    end

    yesButton.OnCursorEntered = function(s)

        surface.PlaySound("ui/element_hover.wav")

    end

    function yesButton:DoClick()

        surface.PlaySound("ui/success.wav")
        confirmPanel:AlphaTo(0, 0.1, 0, function() confirmPanel:Remove() end)
        SellItem(item, transactionCount, key)

    end

    noButton.OnCursorEntered = function(s)

        surface.PlaySound("ui/element_hover.wav")

    end

    function noButton:DoClick()

        surface.PlaySound("ui/element_deselect.wav")
        confirmPanel:AlphaTo(0, 0.1, 0, function() confirmPanel:Remove() end)

    end

end

function Menu.ConfirmSplit(item, data, key, inv)

    if IsValid(confirmPanel) then confirmPanel:Remove() end

    local i = EFGMITEMS[item]
    if i == nil then confirmPanel:Remove() return end

    surface.SetFont("PuristaBold24")
    local confirmText = "Split " .. i.fullName .. " (" .. i.displayName .. ")?"
    local confirmTextSize = math.max(EFGM.MenuScale(300), surface.GetTextSize(confirmText))

    local maxSplitCount = data.count - 1

    local confirmPanelHeight = EFGM.MenuScale(100)

    surface.PlaySound("ui/element_select.wav")

    confirmPanel = vgui.Create("DFrame", Menu.MenuFrame)
    confirmPanel:SetSize(confirmTextSize + EFGM.MenuScale(10), confirmPanelHeight)
    confirmPanel:Center()
    confirmPanel:SetAlpha(0)
    confirmPanel:SetTitle("")
    confirmPanel:ShowCloseButton(false)
    confirmPanel:SetScreenLock(true)
    confirmPanel:AlphaTo(255, 0.1, 0, nil)
    confirmPanel:RequestFocus()

    confirmPanel.Paint = function(s, w, h)

        confirmPanel:SetWide(confirmTextSize + EFGM.MenuScale(10))

        BlurPanel(s, EFGM.MenuScale(3))

        surface.SetDrawColor(Color(20, 20, 20, 205))
        surface.DrawRect(0, 0, w, h)

        surface.SetDrawColor(Color(255, 255, 255, 155))
        surface.DrawRect(0, 0, w, EFGM.MenuScale(6))

        surface.SetDrawColor(Color(255, 255, 255, 25))
        surface.DrawRect(0, 0, w, EFGM.MenuScale(1))
        surface.DrawRect(0, h - EFGM.MenuScale(1), w, EFGM.MenuScale(1))
        surface.DrawRect(0, 0, EFGM.MenuScale(1), h)
        surface.DrawRect(w - EFGM.MenuScale(1), 0, EFGM.MenuScale(1), h)

        draw.SimpleTextOutlined(confirmText, "PuristaBold24", w / 2, EFGM.MenuScale(5), MenuAlias.whiteColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 1, MenuAlias.blackColor)

    end

    confirmPanel.Think = function()

        if (input.IsMouseDown(MOUSE_LEFT) or input.IsMouseDown(MOUSE_RIGHT) or input.IsMouseDown(MOUSE_MIDDLE) or input.IsMouseDown(MOUSE_WHEEL_DOWN) or input.IsMouseDown(MOUSE_WHEEL_UP)) and !confirmPanel:IsChildHovered() and !confirmPanel:IsHovered() then confirmPanel:AlphaTo(0, 0.1, 0, function() confirmPanel:Remove() end) end

    end

    surface.SetFont("PuristaBold24")
    local yesText = "YES"
    local yesTextSize = surface.GetTextSize(yesText)
    local yesButtonSize = yesTextSize + EFGM.MenuScale(10)

    local yesButton = vgui.Create("DButton", confirmPanel)
    yesButton:SetPos(confirmPanel:GetWide() / 2 - (yesButtonSize / 2) - EFGM.MenuScale(25), confirmPanelHeight - EFGM.MenuScale(35))
    yesButton:SetSize(yesButtonSize, EFGM.MenuScale(28))
    yesButton:SetText("")
    yesButton.Paint = function(s, w, h)

        yesButton:SetX(confirmPanel:GetWide() / 2 - (yesButtonSize / 2) - EFGM.MenuScale(25))

        BlurPanel(s, EFGM.MenuScale(0))

        surface.SetDrawColor(Color(80, 80, 80, 10))
        surface.DrawRect(0, 0, yesTextSize + EFGM.MenuScale(10), h)

        surface.SetDrawColor(Color(255, 255, 255, 155))
        surface.DrawRect(0, 0, yesTextSize + EFGM.MenuScale(10), EFGM.MenuScale(2))

        draw.SimpleTextOutlined(yesText, "PuristaBold24", w / 2, EFGM.MenuScale(2), MenuAlias.whiteColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 1, MenuAlias.blackColor)

    end

    surface.SetFont("PuristaBold24")
    local noText = "NO"
    local noTextSize = surface.GetTextSize(noText)
    local noButtonSize = noTextSize + EFGM.MenuScale(10)

    local noButton = vgui.Create("DButton", confirmPanel)
    noButton:SetPos(confirmPanel:GetWide() / 2 - (noButtonSize / 2) + EFGM.MenuScale(25), confirmPanelHeight - EFGM.MenuScale(35))
    noButton:SetSize(noButtonSize, EFGM.MenuScale(28))
    noButton:SetText("")
    noButton.Paint = function(s, w, h)

        noButton:SetX(confirmPanel:GetWide() / 2 - (noButtonSize / 2) + EFGM.MenuScale(25))

        BlurPanel(s, EFGM.MenuScale(0))

        surface.SetDrawColor(Color(80, 80, 80, 10))
        surface.DrawRect(0, 0, noButtonSize + EFGM.MenuScale(10), h)

        surface.SetDrawColor(Color(255, 255, 255, 155))
        surface.DrawRect(0, 0, noButtonSize + EFGM.MenuScale(10), EFGM.MenuScale(2))

        draw.SimpleTextOutlined(noText, "PuristaBold24", w / 2, EFGM.MenuScale(2), MenuAlias.whiteColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 1, MenuAlias.blackColor)

    end

    local amountSlider = vgui.Create("DNumSlider", confirmPanel)
    amountSlider:SetPos(confirmPanel:GetWide() / 2 - EFGM.MenuScale(160), EFGM.MenuScale(35))
    amountSlider:SetSize(EFGM.MenuScale(240), EFGM.MenuScale(15))
    amountSlider:SetMin(1)
    amountSlider:SetMax(maxSplitCount)
    amountSlider:SetValue(1)
    amountSlider:SetDefaultValue(1)
    amountSlider:SetDecimals(0)

    local num = 1
    amountSlider.OnValueChanged = function(self, val)

        if val == num then return end

        num = math.Round(val)
        splitCount = num

    end

    amountSlider.Think = function()

        -- amountSlider:SetX(confirmPanel:GetWide() / 2 - EFGM.MenuScale(160))

    end

    yesButton.OnCursorEntered = function(s)

        surface.PlaySound("ui/element_hover.wav")

    end

    function yesButton:DoClick()

        surface.PlaySound("ui/element_select.wav")
        confirmPanel:AlphaTo(0, 0.1, 0, function() confirmPanel:Remove() end)
        SplitFromInventory(inv, item, splitCount, key)

    end

    noButton.OnCursorEntered = function(s)

        surface.PlaySound("ui/element_hover.wav")

    end

    function noButton:DoClick()

        surface.PlaySound("ui/element_deselect.wav")
        confirmPanel:AlphaTo(0, 0.1, 0, function() confirmPanel:Remove() end)

    end

end

Menu.OpenTab = {}

function Menu.OpenTab.Inventory(container)

    local contents = vgui.Create("DPanel", Menu.MenuFrame.LowerPanel)
    contents:Dock(FILL)
    contents:DockPadding(EFGM.MenuScale(10), EFGM.MenuScale(10), EFGM.MenuScale(10), EFGM.MenuScale(10))
    contents:SetAlpha(0)
    contents.Paint = function(s, w, h)

        surface.SetDrawColor(MenuAlias.transparent)
        surface.DrawRect(0, 0, w, h)

    end

    Menu.MenuFrame.LowerPanel.Contents = contents

    local playerPanel = vgui.Create("DPanel", contents)
    playerPanel:Dock(LEFT)
    playerPanel:SetSize(EFGM.MenuScale(613), 0)
    playerPanel.Paint = function(s, w, h)

        BlurPanel(s, EFGM.MenuScale(10))

        surface.SetDrawColor(Color(80, 80, 80, 10))
        surface.DrawRect(0, 0, w, h)

        surface.SetDrawColor(Color(255, 255, 255, 155))
        surface.DrawRect(0, 0, w, EFGM.MenuScale(6))

    end

    local playerText = vgui.Create("DPanel", playerPanel)
    playerText:Dock(TOP)
    playerText:SetSize(0, EFGM.MenuScale(36))
    function playerText:Paint(w, h)

        surface.SetDrawColor(Color(155, 155, 155, 10))
        surface.DrawRect(0, 0, w, h)

        draw.SimpleTextOutlined(string.upper(Menu.Player:GetName()), "PuristaBold32", EFGM.MenuScale(5), EFGM.MenuScale(2), MenuAlias.whiteColor, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP, 1, MenuAlias.blackColor)

    end

    local playerModel = vgui.Create("DModelPanel", playerPanel)
    playerModel:SetAlpha(0)
    playerModel:Dock(FILL)
    playerModel:SetMouseInputEnabled(false)
    playerModel:SetFOV(26)
    playerModel:SetCamPos(Vector(10, 0, 0))
    playerModel:SetLookAt(Vector(-100, 0, -24))
    playerModel:SetDirectionalLight(BOX_RIGHT, Color(255, 160, 80, 255))
    playerModel:SetDirectionalLight(BOX_LEFT, Color(80, 160, 255, 255))
    playerModel:SetAnimated(true)
    playerModel:SetModel(Menu.Player:GetModel())
    playerModel:AlphaTo(255, 0.1, 0, nil)

    local groups = GetEntityGroups(Menu.Player, override)

    if groups then

        if groups.Bodygroups then

			for k, v in pairs(groups.Bodygroups) do

				playerModel.Entity:SetBodygroup(k, v)

			end

		end

		if groups.Skin then

			playerModel.Entity:SetSkin(groups.Skin)

		end

	end

    playerModel.Entity:SetPos(Vector(-108, -1, -63))
    playerModel.Entity:SetAngles(Angle(0, 20, 0))

    function playerModel:LayoutEntity(Entity)

        if !IsValid(Entity) then return end
        playerModel:RunAnimation()

    end

    local equipmentHolder = vgui.Create("DPanel", playerPanel)
    equipmentHolder:SetPos(EFGM.MenuScale(153), EFGM.MenuScale(100))
    equipmentHolder:SetSize(EFGM.MenuScale(450), EFGM.MenuScale(850))
    function equipmentHolder:Paint(w, h)

        surface.SetDrawColor(Color(0, 0, 0, 0))
        surface.DrawRect(0, 0, w, h)

    end

    -- secondary slot
    local secondaryWeaponHolder = vgui.Create("DPanel", equipmentHolder)
    secondaryWeaponHolder:SetSize(EFGM.MenuScale(285), EFGM.MenuScale(114))
    secondaryWeaponHolder:SetPos(equipmentHolder:GetWide() - secondaryWeaponHolder:GetWide(), equipmentHolder:GetTall() - secondaryWeaponHolder:GetTall())

    function secondaryWeaponHolder:Paint(w, h)

        BlurPanel(secondaryWeaponHolder, EFGM.MenuScale(3))

        surface.SetDrawColor(Color(80, 80, 80, 10))
        surface.DrawRect(0, 0, w, h)

        surface.SetDrawColor(Color(255, 255, 255, 25))
        surface.DrawRect(0, 0, w, EFGM.MenuScale(1))
        surface.DrawRect(0, h - EFGM.MenuScale(1), w, EFGM.MenuScale(1))
        surface.DrawRect(0, 0, EFGM.MenuScale(1), h)
        surface.DrawRect(w - EFGM.MenuScale(1), 0, EFGM.MenuScale(1), h)

    end

    local secondaryWeaponText = vgui.Create("DPanel", equipmentHolder)
    secondaryWeaponText:SetSize(EFGM.MenuScale(120), EFGM.MenuScale(30))
    secondaryWeaponText:SetPos(equipmentHolder:GetWide() - secondaryWeaponText:GetWide(), secondaryWeaponHolder:GetY() - EFGM.MenuScale(30))
    secondaryWeaponText.Paint = function(s, w, h)

        surface.SetDrawColor(Color(80, 80, 80, 10))
        surface.DrawRect(0, 0, w, h)

        surface.SetDrawColor(Color(255, 255, 255, 155))
        surface.DrawRect(0, 0, EFGM.MenuScale(220), EFGM.MenuScale(2))

        draw.SimpleTextOutlined("SECONDARY", "PuristaBold24", w / 2, EFGM.MenuScale(2), MenuAlias.whiteColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 1, MenuAlias.blackColor)

    end

    local secondaryWeaponIcon = vgui.Create("DImage", secondaryWeaponHolder)
    secondaryWeaponIcon:SetPos(EFGM.MenuScale(25), EFGM.MenuScale(15))
    secondaryWeaponIcon:SetSize(EFGM.MenuScale(250), EFGM.MenuScale(80))
    secondaryWeaponIcon:SetImage("icons/inventory_primary_icon.png")
    secondaryWeaponIcon:SetImageColor(Color(255, 255, 255, 10))

    -- primary slot
    local primaryWeaponHolder = vgui.Create("DPanel", equipmentHolder)
    primaryWeaponHolder:SetSize(EFGM.MenuScale(285), EFGM.MenuScale(114))
    primaryWeaponHolder:SetPos(equipmentHolder:GetWide() - primaryWeaponHolder:GetWide(), secondaryWeaponHolder:GetY() - primaryWeaponHolder:GetTall() - EFGM.MenuScale(40))

    function primaryWeaponHolder:Paint(w, h)

        BlurPanel(primaryWeaponHolder, EFGM.MenuScale(3))

        surface.SetDrawColor(Color(80, 80, 80, 10))
        surface.DrawRect(0, 0, w, h)

        surface.SetDrawColor(Color(255, 255, 255, 25))
        surface.DrawRect(0, 0, w, EFGM.MenuScale(1))
        surface.DrawRect(0, h - EFGM.MenuScale(1), w, EFGM.MenuScale(1))
        surface.DrawRect(0, 0, EFGM.MenuScale(1), h)
        surface.DrawRect(w - EFGM.MenuScale(1), 0, EFGM.MenuScale(1), h)

    end

    local primaryWeaponText = vgui.Create("DPanel", equipmentHolder)
    primaryWeaponText:SetSize(EFGM.MenuScale(90), EFGM.MenuScale(30))
    primaryWeaponText:SetPos(equipmentHolder:GetWide() - primaryWeaponText:GetWide(), primaryWeaponHolder:GetY() - EFGM.MenuScale(30))
    primaryWeaponText.Paint = function(s, w, h)

        surface.SetDrawColor(Color(80, 80, 80, 10))
        surface.DrawRect(0, 0, w, h)

        surface.SetDrawColor(Color(255, 255, 255, 155))
        surface.DrawRect(0, 0, EFGM.MenuScale(220), EFGM.MenuScale(2))

        draw.SimpleTextOutlined("PRIMARY", "PuristaBold24", w / 2, EFGM.MenuScale(2), MenuAlias.whiteColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 1, MenuAlias.blackColor)

    end

    local primaryWeaponIcon = vgui.Create("DImage", primaryWeaponHolder)
    primaryWeaponIcon:SetPos(EFGM.MenuScale(25), EFGM.MenuScale(15))
    primaryWeaponIcon:SetSize(EFGM.MenuScale(250), EFGM.MenuScale(80))
    primaryWeaponIcon:SetImage("icons/inventory_primary_icon.png")
    primaryWeaponIcon:SetImageColor(Color(255, 255, 255, 10))

    -- holster slot
    local holsterWeaponHolder = vgui.Create("DPanel", equipmentHolder)
    holsterWeaponHolder:SetSize(EFGM.MenuScale(114), EFGM.MenuScale(57))
    holsterWeaponHolder:SetPos(equipmentHolder:GetWide() - holsterWeaponHolder:GetWide(), primaryWeaponHolder:GetY() - holsterWeaponHolder:GetTall() - EFGM.MenuScale(40))

    function holsterWeaponHolder:Paint(w, h)

        BlurPanel(holsterWeaponHolder, EFGM.MenuScale(3))

        surface.SetDrawColor(Color(80, 80, 80, 10))
        surface.DrawRect(0, 0, w, h)

        surface.SetDrawColor(Color(255, 255, 255, 25))
        surface.DrawRect(0, 0, w, EFGM.MenuScale(1))
        surface.DrawRect(0, h - EFGM.MenuScale(1), w, EFGM.MenuScale(1))
        surface.DrawRect(0, 0, EFGM.MenuScale(1), h)
        surface.DrawRect(w - EFGM.MenuScale(1), 0, EFGM.MenuScale(1), h)

    end

    local holsterWeaponText = vgui.Create("DPanel", equipmentHolder)
    holsterWeaponText:SetSize(EFGM.MenuScale(90), EFGM.MenuScale(30))
    holsterWeaponText:SetPos(equipmentHolder:GetWide() - holsterWeaponText:GetWide(), holsterWeaponHolder:GetY() - EFGM.MenuScale(30))
    holsterWeaponText.Paint = function(s, w, h)

        surface.SetDrawColor(Color(80, 80, 80, 10))
        surface.DrawRect(0, 0, w, h)

        surface.SetDrawColor(Color(255, 255, 255, 155))
        surface.DrawRect(0, 0, EFGM.MenuScale(220), EFGM.MenuScale(2))

        draw.SimpleTextOutlined("HOLSTER", "PuristaBold24", w / 2, EFGM.MenuScale(2), MenuAlias.whiteColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 1, MenuAlias.blackColor)

    end

    local holsterWeaponIcon = vgui.Create("DImage", holsterWeaponHolder)
    holsterWeaponIcon:SetPos(EFGM.MenuScale(27), EFGM.MenuScale(8))
    holsterWeaponIcon:SetSize(EFGM.MenuScale(60), EFGM.MenuScale(40))
    holsterWeaponIcon:SetImage("icons/inventory_holster_icon.png")
    holsterWeaponIcon:SetImageColor(Color(255, 255, 255, 10))

    -- melee slot
    local meleeWeaponHolder = vgui.Create("DPanel", equipmentHolder)
    meleeWeaponHolder:SetSize(EFGM.MenuScale(114), EFGM.MenuScale(57))
    meleeWeaponHolder:SetPos(equipmentHolder:GetWide() - meleeWeaponHolder:GetWide(), holsterWeaponHolder:GetY() - meleeWeaponHolder:GetTall() - EFGM.MenuScale(40))

    function meleeWeaponHolder:Paint(w, h)

        BlurPanel(meleeWeaponHolder, EFGM.MenuScale(3))

        surface.SetDrawColor(Color(80, 80, 80, 10))
        surface.DrawRect(0, 0, w, h)

        surface.SetDrawColor(Color(255, 255, 255, 25))
        surface.DrawRect(0, 0, w, EFGM.MenuScale(1))
        surface.DrawRect(0, h - EFGM.MenuScale(1), w, EFGM.MenuScale(1))
        surface.DrawRect(0, 0, EFGM.MenuScale(1), h)
        surface.DrawRect(w - EFGM.MenuScale(1), 0, EFGM.MenuScale(1), h)

    end

    local meleeWeaponText = vgui.Create("DPanel", equipmentHolder)
    meleeWeaponText:SetSize(EFGM.MenuScale(65), EFGM.MenuScale(30))
    meleeWeaponText:SetPos(equipmentHolder:GetWide() - meleeWeaponText:GetWide(), meleeWeaponHolder:GetY() - EFGM.MenuScale(30))
    meleeWeaponText.Paint = function(s, w, h)

        surface.SetDrawColor(Color(80, 80, 80, 10))
        surface.DrawRect(0, 0, w, h)

        surface.SetDrawColor(Color(255, 255, 255, 155))
        surface.DrawRect(0, 0, EFGM.MenuScale(220), EFGM.MenuScale(2))

        draw.SimpleTextOutlined("MELEE", "PuristaBold24", w / 2, EFGM.MenuScale(2), MenuAlias.whiteColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 1, MenuAlias.blackColor)

    end

    local meleeWeaponIcon = vgui.Create("DImage", meleeWeaponHolder)
    meleeWeaponIcon:SetPos(EFGM.MenuScale(25), EFGM.MenuScale(8))
    meleeWeaponIcon:SetSize(EFGM.MenuScale(60), EFGM.MenuScale(40))
    meleeWeaponIcon:SetImage("icons/inventory_melee_icon.png")
    meleeWeaponIcon:SetImageColor(Color(255, 255, 255, 10))

    function ReloadSlots()

        if !IsValid(primaryItem) then return end

        if !table.IsEmpty(playerWeaponSlots[1][1]) then

            -- PRIMARY

            local i = EFGMITEMS[playerWeaponSlots[1][1].name]

            if IsValid(primaryItem) then primaryItem:Remove() end
            primaryItem = vgui.Create("DButton", primaryWeaponHolder)
            primaryItem:Dock(FILL)
            primaryItem:SetText("")
            primaryItem:Droppable("items")
            primaryItem:Droppable("slot_primary")
            primaryItem.SLOTID = 1
            primaryItem.SLOT = 1
            primaryItem.ORIGIN = "equipped"

            primaryWeaponHolder:SetSize(EFGM.MenuScale(57 * i.sizeX), EFGM.MenuScale(57 * i.sizeY))
            primaryWeaponIcon:Hide()

            function primaryItem:Paint(w, h)

                surface.SetDrawColor(Color(255, 255, 255, 2))
                surface.DrawRect(0, 0, w, EFGM.MenuScale(1))
                surface.DrawRect(0, h - EFGM.MenuScale(1), w, EFGM.MenuScale(1))
                surface.DrawRect(0, 0, EFGM.MenuScale(1), h)
                surface.DrawRect(w - EFGM.MenuScale(1), 0, EFGM.MenuScale(1), h)

                surface.SetDrawColor(i.iconColor or Color(5, 5, 5, 20))
                surface.DrawRect(0, 0, w, h)

                surface.SetDrawColor(255, 255, 255, 255)
                surface.SetMaterial(i.icon)
                surface.DrawTexturedRect(0, 0, w, h)

            end

            surface.SetFont("Purista18")

            local nameSize = surface.GetTextSize(i.displayName)
            local nameFont

            if nameSize <= (EFGM.MenuScale(49 * i.sizeX)) then nameFont = "PuristaBold18"
            else nameFont = "PuristaBold14" end

            function primaryItem:PaintOver(w, h)

                draw.SimpleTextOutlined(i.displayName, nameFont, w - EFGM.MenuScale(3), EFGM.MenuScale(-1), MenuAlias.whiteColor, TEXT_ALIGN_RIGHT, TEXT_ALIGN_TOP, 1, MenuAlias.blackColor)

            end

            function primaryItem:DoClick()

                if input.IsKeyDown(KEY_LSHIFT) then

                    surface.PlaySound("ui/element_select.wav")
                    UnEquipItemFromInventory(primaryItem.SLOTID, primaryItem.SLOT)

                end

            end

            function primaryItem:DoDoubleClick()

                Menu.InspectItem(playerWeaponSlots[1][1].name)
                surface.PlaySound("ui/element_select.wav")

            end

            function primaryItem:DoRightClick()

                local x, y = equipmentHolder:LocalCursorPos()
                surface.PlaySound("ui/element_hover.wav")

                if x <= (equipmentHolder:GetWide() / 2) then sideH = true else sideH = false end
                if y <= (equipmentHolder:GetTall() / 2) then sideV = true else sideV = false end

                if IsValid(contextMenu) then contextMenu:Remove() end
                contextMenu = vgui.Create("DPanel", equipmentHolder)
                contextMenu:SetSize(EFGM.MenuScale(100), EFGM.MenuScale(85))
                contextMenu:DockPadding(EFGM.MenuScale(5), EFGM.MenuScale(5), EFGM.MenuScale(5), EFGM.MenuScale(5))
                contextMenu:SetAlpha(0)
                contextMenu:AlphaTo(255, 0.1, 0, nil)
                contextMenu:RequestFocus()

                if sideH == true then

                    contextMenu:SetX(math.Clamp(x + EFGM.MenuScale(5), EFGM.MenuScale(5), equipmentHolder:GetWide() - contextMenu:GetWide() - EFGM.MenuScale(5)))

                else

                    contextMenu:SetX(math.Clamp(x - contextMenu:GetWide() - EFGM.MenuScale(5), EFGM.MenuScale(5), equipmentHolder:GetWide() - contextMenu:GetWide() - EFGM.MenuScale(5)))

                end

                if sideV == true then

                    contextMenu:SetY(math.Clamp(y + EFGM.MenuScale(5), EFGM.MenuScale(5), equipmentHolder:GetTall() - contextMenu:GetTall() - EFGM.MenuScale(5)))

                else

                    contextMenu:SetY(math.Clamp(y - contextMenu:GetTall() + EFGM.MenuScale(5), EFGM.MenuScale(5), equipmentHolder:GetTall() - contextMenu:GetTall() - EFGM.MenuScale(5)))

                end

                contextMenu.Paint = function(s, w, h)

                    if !IsValid(s) then return end

                    BlurPanel(s, EFGM.MenuScale(5))

                    surface.SetDrawColor(Color(5, 5, 5, 50))
                    surface.DrawRect(0, 0, w, h)

                    surface.SetDrawColor(Color(255, 255, 255, 30))
                    surface.DrawRect(0, 0, w, EFGM.MenuScale(1))
                    surface.DrawRect(0, h - EFGM.MenuScale(1), w, EFGM.MenuScale(1))
                    surface.DrawRect(0, 0, EFGM.MenuScale(1), h)
                    surface.DrawRect(w - EFGM.MenuScale(1), 0, EFGM.MenuScale(1), h)

                    contextMenu:SizeToChildren(true, true)

                end

                hook.Add("Think", "CheckIfContextMenuStillFocused", function()

                    if !IsValid(contextMenu) then hook.Remove("Think", "CheckIfContextMenuStillFocused") return end
                    if (input.IsMouseDown(MOUSE_LEFT) or input.IsMouseDown(MOUSE_RIGHT) or input.IsMouseDown(MOUSE_MIDDLE) or input.IsMouseDown(MOUSE_WHEEL_DOWN) or input.IsMouseDown(MOUSE_WHEEL_UP)) and !contextMenu:IsChildHovered() then contextMenu:KillFocus() hook.Remove("Think", "CheckIfContextMenuStillFocused") end

                end)

                function contextMenu:OnFocusChanged(focus)

                    if !focus then contextMenu:AlphaTo(0, 0.1, 0, function() contextMenu:Remove() hook.Remove("Think", "CheckIfContextMenuStillFocused") end) end

                end

                local itemInspectButton = vgui.Create("DButton", contextMenu)
                itemInspectButton:Dock(TOP)
                itemInspectButton:SetSize(0, EFGM.MenuScale(25))
                itemInspectButton:SetText("INSPECT")

                itemInspectButton.OnCursorEntered = function(s)

                    surface.PlaySound("ui/element_hover.wav")

                end

                function itemInspectButton:DoClick()

                    Menu.InspectItem(playerWeaponSlots[1][1].name, playerWeaponSlots[1][1].data)
                    surface.PlaySound("ui/element_select.wav")
                    contextMenu:KillFocus()

                end

                if Menu.Player:CompareStatus(0) and table.IsEmpty(container) then

                    contextMenu:SetTall(contextMenu:GetTall() + EFGM.MenuScale(25))

                    local itemStashButton = vgui.Create("DButton", contextMenu)
                    itemStashButton:Dock(TOP)
                    itemStashButton:SetSize(0, EFGM.MenuScale(25))
                    itemStashButton:SetText("STASH")

                    itemStashButton.OnCursorEntered = function(s)

                        surface.PlaySound("ui/element_hover.wav")

                    end

                    function itemStashButton:DoClick()

                        surface.PlaySound("ui/element_select.wav")
                        contextMenu:Remove()

                        StashItemFromEquipped(primaryItem.SLOTID, primaryItem.SLOT)

                        ReloadStash()

                    end

                end

                local itemUnequipButton = vgui.Create("DButton", contextMenu)
                itemUnequipButton:Dock(TOP)
                itemUnequipButton:SetSize(0, EFGM.MenuScale(25))
                itemUnequipButton:SetText("UNEQUIP")

                itemUnequipButton.OnCursorEntered = function(s)

                    surface.PlaySound("ui/element_hover.wav")

                end

                function itemUnequipButton:DoClick()

                    UnEquipItemFromInventory(primaryItem.SLOTID, primaryItem.SLOT)

                    surface.PlaySound("ui/element_select.wav")
                    contextMenu:KillFocus()

                end

                local itemDropButton = vgui.Create("DButton", contextMenu)
                itemDropButton:Dock(TOP)
                itemDropButton:SetSize(0, EFGM.MenuScale(25))
                itemDropButton:SetText("DROP")

                itemDropButton.OnCursorEntered = function(s)

                    surface.PlaySound("ui/element_hover.wav")

                end

                function itemDropButton:DoClick()

                    DropEquippedItem(primaryItem.SLOTID, primaryItem.SLOT)

                    surface.PlaySound("ui/element_select.wav")
                    contextMenu:KillFocus()

                end

            end

        else

            primaryWeaponHolder:SetSize(EFGM.MenuScale(285), EFGM.MenuScale(114))
            primaryWeaponIcon:Show()
            if IsValid(primaryItem) then primaryItem:Remove() end

        end

        if !table.IsEmpty(playerWeaponSlots[1][2]) then

            -- SECONDARY
            local i = EFGMITEMS[playerWeaponSlots[1][2].name]

            if IsValid(secondaryItem) then secondaryItem:Remove() end
            secondaryItem = vgui.Create("DButton", secondaryWeaponHolder)
            secondaryItem:Dock(FILL)
            secondaryItem:SetText("")
            secondaryItem:Droppable("items")
            secondaryItem:Droppable("slot_primary")
            secondaryItem.SLOTID = 1
            secondaryItem.SLOT = 2
            secondaryItem.ORIGIN = "equipped"

            secondaryWeaponHolder:SetSize(EFGM.MenuScale(57 * i.sizeX), EFGM.MenuScale(57 * i.sizeY))
            secondaryWeaponIcon:Hide()

            function secondaryItem:Paint(w, h)

                surface.SetDrawColor(Color(255, 255, 255, 2))
                surface.DrawRect(0, 0, w, EFGM.MenuScale(1))
                surface.DrawRect(0, h - EFGM.MenuScale(1), w, EFGM.MenuScale(1))
                surface.DrawRect(0, 0, EFGM.MenuScale(1), h)
                surface.DrawRect(w - EFGM.MenuScale(1), 0, EFGM.MenuScale(1), h)

                surface.SetDrawColor(i.iconColor or Color(5, 5, 5, 20))
                surface.DrawRect(0, 0, w, h)

                surface.SetDrawColor(255, 255, 255, 255)
                surface.SetMaterial(i.icon)
                surface.DrawTexturedRect(0, 0, w, h)

            end

            surface.SetFont("Purista18")

            local nameSize = surface.GetTextSize(i.displayName)
            local nameFont

            if nameSize <= (EFGM.MenuScale(49 * i.sizeX)) then nameFont = "PuristaBold18"
            else nameFont = "PuristaBold14" end

            function secondaryItem:PaintOver(w, h)

                draw.SimpleTextOutlined(i.displayName, nameFont, w - EFGM.MenuScale(3), EFGM.MenuScale(-1), MenuAlias.whiteColor, TEXT_ALIGN_RIGHT, TEXT_ALIGN_TOP, 1, MenuAlias.blackColor)

            end

            function secondaryItem:DoDoubleClick()

                Menu.InspectItem(playerWeaponSlots[1][2].name)
                surface.PlaySound("ui/element_select.wav")

            end

            function secondaryItem:DoClick()

                if input.IsKeyDown(KEY_LSHIFT) then

                    surface.PlaySound("ui/element_select.wav")
                    UnEquipItemFromInventory(secondaryItem.SLOTID, secondaryItem.SLOT)

                end

            end

            function secondaryItem:DoRightClick()

                local x, y = equipmentHolder:LocalCursorPos()
                surface.PlaySound("ui/element_hover.wav")

                if x <= (equipmentHolder:GetWide() / 2) then sideH = true else sideH = false end
                if y <= (equipmentHolder:GetTall() / 2) then sideV = true else sideV = false end

                if IsValid(contextMenu) then contextMenu:Remove() end
                contextMenu = vgui.Create("DPanel", equipmentHolder)
                contextMenu:SetSize(EFGM.MenuScale(100), EFGM.MenuScale(85))
                contextMenu:DockPadding(EFGM.MenuScale(5), EFGM.MenuScale(5), EFGM.MenuScale(5), EFGM.MenuScale(5))
                contextMenu:SetAlpha(0)
                contextMenu:AlphaTo(255, 0.1, 0, nil)
                contextMenu:RequestFocus()

                if sideH == true then

                    contextMenu:SetX(math.Clamp(x + EFGM.MenuScale(5), EFGM.MenuScale(5), equipmentHolder:GetWide() - contextMenu:GetWide() - EFGM.MenuScale(5)))

                else

                    contextMenu:SetX(math.Clamp(x - contextMenu:GetWide(), EFGM.MenuScale(5), equipmentHolder:GetWide() - contextMenu:GetWide() - EFGM.MenuScale(5)))

                end

                if sideV == true then

                    contextMenu:SetY(math.Clamp(y + EFGM.MenuScale(5), EFGM.MenuScale(5), equipmentHolder:GetTall() - contextMenu:GetTall() - EFGM.MenuScale(5)))

                else

                    contextMenu:SetY(math.Clamp(y - contextMenu:GetTall() + EFGM.MenuScale(5), EFGM.MenuScale(5), equipmentHolder:GetTall() - contextMenu:GetTall() - EFGM.MenuScale(5)))

                end

                contextMenu.Paint = function(s, w, h)

                    if !IsValid(s) then return end

                    BlurPanel(s, EFGM.MenuScale(5))

                    surface.SetDrawColor(Color(5, 5, 5, 50))
                    surface.DrawRect(0, 0, w, h)

                    surface.SetDrawColor(Color(255, 255, 255, 30))
                    surface.DrawRect(0, 0, w, EFGM.MenuScale(1))
                    surface.DrawRect(0, h - EFGM.MenuScale(1), w, EFGM.MenuScale(1))
                    surface.DrawRect(0, 0, EFGM.MenuScale(1), h)
                    surface.DrawRect(w - EFGM.MenuScale(1), 0, EFGM.MenuScale(1), h)

                    contextMenu:SizeToChildren(true, true)

                end

                hook.Add("Think", "CheckIfContextMenuStillFocused", function()

                    if !IsValid(contextMenu) then hook.Remove("Think", "CheckIfContextMenuStillFocused") return end
                    if (input.IsMouseDown(MOUSE_LEFT) or input.IsMouseDown(MOUSE_RIGHT) or input.IsMouseDown(MOUSE_MIDDLE) or input.IsMouseDown(MOUSE_WHEEL_DOWN) or input.IsMouseDown(MOUSE_WHEEL_UP)) and !contextMenu:IsChildHovered() then contextMenu:KillFocus() hook.Remove("Think", "CheckIfContextMenuStillFocused") end

                end)

                function contextMenu:OnFocusChanged(focus)

                    if !focus then contextMenu:AlphaTo(0, 0.1, 0, function() contextMenu:Remove() hook.Remove("Think", "CheckIfContextMenuStillFocused") end) end

                end

                local itemInspectButton = vgui.Create("DButton", contextMenu)
                itemInspectButton:Dock(TOP)
                itemInspectButton:SetSize(0, EFGM.MenuScale(25))
                itemInspectButton:SetText("INSPECT")

                itemInspectButton.OnCursorEntered = function(s)

                    surface.PlaySound("ui/element_hover.wav")

                end

                function itemInspectButton:DoClick()

                    Menu.InspectItem(playerWeaponSlots[1][2].name, playerWeaponSlots[1][2].data)
                    surface.PlaySound("ui/element_select.wav")
                    contextMenu:KillFocus()

                end

                if Menu.Player:CompareStatus(0) and table.IsEmpty(container) then

                    contextMenu:SetTall(contextMenu:GetTall() + EFGM.MenuScale(25))

                    local itemStashButton = vgui.Create("DButton", contextMenu)
                    itemStashButton:Dock(TOP)
                    itemStashButton:SetSize(0, EFGM.MenuScale(25))
                    itemStashButton:SetText("STASH")

                    itemStashButton.OnCursorEntered = function(s)

                        surface.PlaySound("ui/element_hover.wav")

                    end

                    function itemStashButton:DoClick()

                        surface.PlaySound("ui/element_select.wav")
                        contextMenu:Remove()

                        StashItemFromEquipped(secondaryItem.SLOTID, secondaryItem.SLOT)

                        ReloadStash()

                    end

                end

                local itemUnequipButton = vgui.Create("DButton", contextMenu)
                itemUnequipButton:Dock(TOP)
                itemUnequipButton:SetSize(0, EFGM.MenuScale(25))
                itemUnequipButton:SetText("UNEQUIP")

                itemUnequipButton.OnCursorEntered = function(s)

                    surface.PlaySound("ui/element_hover.wav")

                end

                function itemUnequipButton:DoClick()

                    UnEquipItemFromInventory(secondaryItem.SLOTID, secondaryItem.SLOT)

                    surface.PlaySound("ui/element_select.wav")
                    contextMenu:KillFocus()

                end

                local itemDropButton = vgui.Create("DButton", contextMenu)
                itemDropButton:Dock(TOP)
                itemDropButton:SetSize(0, EFGM.MenuScale(25))
                itemDropButton:SetText("DROP")

                itemDropButton.OnCursorEntered = function(s)

                    surface.PlaySound("ui/element_hover.wav")

                end

                function itemDropButton:DoClick()

                    DropEquippedItem(secondaryItem.SLOTID, secondaryItem.SLOT)

                    surface.PlaySound("ui/element_select.wav")
                    contextMenu:KillFocus()

                end

            end

        else

            secondaryWeaponHolder:SetSize(EFGM.MenuScale(285), EFGM.MenuScale(114))
            secondaryWeaponIcon:Show()
            if IsValid(secondaryItem) then secondaryItem:Remove() end

        end

        if !table.IsEmpty(playerWeaponSlots[2][1]) then

            -- HOLSTER

            local i = EFGMITEMS[playerWeaponSlots[2][1].name]

            if IsValid(holsterItem) then holsterItem:Remove() end
            holsterItem = vgui.Create("DButton", holsterWeaponHolder)
            holsterItem:Dock(FILL)
            holsterItem:SetText("")
            holsterItem:Droppable("items")
            holsterItem:Droppable("slot_holster")
            holsterItem.SLOTID = 2
            holsterItem.SLOT = 1
            holsterItem.ORIGIN = "equipped"

            holsterWeaponHolder:SetSize(EFGM.MenuScale(57 * i.sizeX), EFGM.MenuScale(57 * i.sizeY))
            holsterWeaponIcon:Hide()

            function holsterItem:Paint(w, h)

                surface.SetDrawColor(Color(255, 255, 255, 2))
                surface.DrawRect(0, 0, w, EFGM.MenuScale(1))
                surface.DrawRect(0, h - EFGM.MenuScale(1), w, EFGM.MenuScale(1))
                surface.DrawRect(0, 0, EFGM.MenuScale(1), h)
                surface.DrawRect(w - EFGM.MenuScale(1), 0, EFGM.MenuScale(1), h)

                surface.SetDrawColor(i.iconColor or Color(5, 5, 5, 20))
                surface.DrawRect(0, 0, w, h)

                surface.SetDrawColor(255, 255, 255, 255)
                surface.SetMaterial(i.icon)
                surface.DrawTexturedRect(0, 0, w, h)

            end

            surface.SetFont("Purista18")

            local nameSize = surface.GetTextSize(i.displayName)
            local nameFont

            if nameSize <= (EFGM.MenuScale(49 * i.sizeX)) then nameFont = "PuristaBold18"
            else nameFont = "PuristaBold14" end

            function holsterItem:PaintOver(w, h)

                draw.SimpleTextOutlined(i.displayName, nameFont, w - EFGM.MenuScale(3), EFGM.MenuScale(-1), MenuAlias.whiteColor, TEXT_ALIGN_RIGHT, TEXT_ALIGN_TOP, 1, MenuAlias.blackColor)

            end

            function holsterItem:DoClick()

                if input.IsKeyDown(KEY_LSHIFT) then

                    surface.PlaySound("ui/element_select.wav")
                    UnEquipItemFromInventory(holsterItem.SLOTID, holsterItem.SLOT)

                end

            end

            function holsterItem:DoDoubleClick()

                Menu.InspectItem(playerWeaponSlots[2][1].name)
                surface.PlaySound("ui/element_select.wav")

            end

            function holsterItem:DoRightClick()

                local x, y = equipmentHolder:LocalCursorPos()
                surface.PlaySound("ui/element_hover.wav")

                if x <= (equipmentHolder:GetWide() / 2) then sideH = true else sideH = false end
                if y <= (equipmentHolder:GetTall() / 2) then sideV = true else sideV = false end

                if IsValid(contextMenu) then contextMenu:Remove() end
                contextMenu = vgui.Create("DPanel", equipmentHolder)
                contextMenu:SetSize(EFGM.MenuScale(100), EFGM.MenuScale(85))
                contextMenu:DockPadding(EFGM.MenuScale(5), EFGM.MenuScale(5), EFGM.MenuScale(5), EFGM.MenuScale(5))
                contextMenu:SetAlpha(0)
                contextMenu:AlphaTo(255, 0.1, 0, nil)
                contextMenu:RequestFocus()

                if sideH == true then

                    contextMenu:SetX(math.Clamp(x + EFGM.MenuScale(5), EFGM.MenuScale(5), equipmentHolder:GetWide() - contextMenu:GetWide() - EFGM.MenuScale(5)))

                else

                    contextMenu:SetX(math.Clamp(x - contextMenu:GetWide() - EFGM.MenuScale(5), EFGM.MenuScale(5), equipmentHolder:GetWide() - contextMenu:GetWide() - EFGM.MenuScale(5)))

                end

                if sideV == true then

                    contextMenu:SetY(math.Clamp(y + EFGM.MenuScale(5), EFGM.MenuScale(5), equipmentHolder:GetTall() - contextMenu:GetTall() - EFGM.MenuScale(5)))

                else

                    contextMenu:SetY(math.Clamp(y - contextMenu:GetTall() + EFGM.MenuScale(5), EFGM.MenuScale(5), equipmentHolder:GetTall() - contextMenu:GetTall() - EFGM.MenuScale(5)))

                end

                contextMenu.Paint = function(s, w, h)

                    if !IsValid(s) then return end

                    BlurPanel(s, EFGM.MenuScale(5))

                    surface.SetDrawColor(Color(5, 5, 5, 50))
                    surface.DrawRect(0, 0, w, h)

                    surface.SetDrawColor(Color(255, 255, 255, 30))
                    surface.DrawRect(0, 0, w, EFGM.MenuScale(1))
                    surface.DrawRect(0, h - EFGM.MenuScale(1), w, EFGM.MenuScale(1))
                    surface.DrawRect(0, 0, EFGM.MenuScale(1), h)
                    surface.DrawRect(w - EFGM.MenuScale(1), 0, EFGM.MenuScale(1), h)

                    contextMenu:SizeToChildren(true, true)

                end

                hook.Add("Think", "CheckIfContextMenuStillFocused", function()

                    if !IsValid(contextMenu) then hook.Remove("Think", "CheckIfContextMenuStillFocused") return end
                    if (input.IsMouseDown(MOUSE_LEFT) or input.IsMouseDown(MOUSE_RIGHT) or input.IsMouseDown(MOUSE_MIDDLE) or input.IsMouseDown(MOUSE_WHEEL_DOWN) or input.IsMouseDown(MOUSE_WHEEL_UP)) and !contextMenu:IsChildHovered() then contextMenu:KillFocus() hook.Remove("Think", "CheckIfContextMenuStillFocused") end

                end)

                function contextMenu:OnFocusChanged(focus)

                    if !focus then contextMenu:AlphaTo(0, 0.1, 0, function() contextMenu:Remove() hook.Remove("Think", "CheckIfContextMenuStillFocused") end) end

                end

                local itemInspectButton = vgui.Create("DButton", contextMenu)
                itemInspectButton:Dock(TOP)
                itemInspectButton:SetSize(0, EFGM.MenuScale(25))
                itemInspectButton:SetText("INSPECT")

                itemInspectButton.OnCursorEntered = function(s)

                    surface.PlaySound("ui/element_hover.wav")

                end

                function itemInspectButton:DoClick()

                    Menu.InspectItem(playerWeaponSlots[2][1].name, playerWeaponSlots[2][1].data)
                    surface.PlaySound("ui/element_select.wav")
                    contextMenu:KillFocus()

                end

                if Menu.Player:CompareStatus(0) and table.IsEmpty(container) then

                    contextMenu:SetTall(contextMenu:GetTall() + EFGM.MenuScale(25))

                    local itemStashButton = vgui.Create("DButton", contextMenu)
                    itemStashButton:Dock(TOP)
                    itemStashButton:SetSize(0, EFGM.MenuScale(25))
                    itemStashButton:SetText("STASH")

                    itemStashButton.OnCursorEntered = function(s)

                        surface.PlaySound("ui/element_hover.wav")

                    end

                    function itemStashButton:DoClick()

                        surface.PlaySound("ui/element_select.wav")
                        contextMenu:Remove()

                        StashItemFromEquipped(holsterItem.SLOTID, holsterItem.SLOT)

                        ReloadStash()

                    end

                end

                local itemUnequipButton = vgui.Create("DButton", contextMenu)
                itemUnequipButton:Dock(TOP)
                itemUnequipButton:SetSize(0, EFGM.MenuScale(25))
                itemUnequipButton:SetText("UNEQUIP")

                itemUnequipButton.OnCursorEntered = function(s)

                    surface.PlaySound("ui/element_hover.wav")

                end

                function itemUnequipButton:DoClick()

                    UnEquipItemFromInventory(holsterItem.SLOTID, holsterItem.SLOT)

                    surface.PlaySound("ui/element_select.wav")
                    contextMenu:KillFocus()

                end

                local itemDropButton = vgui.Create("DButton", contextMenu)
                itemDropButton:Dock(TOP)
                itemDropButton:SetSize(0, EFGM.MenuScale(25))
                itemDropButton:SetText("DROP")

                itemDropButton.OnCursorEntered = function(s)

                    surface.PlaySound("ui/element_hover.wav")

                end

                function itemDropButton:DoClick()

                    DropEquippedItem(holsterItem.SLOTID, holsterItem.SLOT)

                    surface.PlaySound("ui/element_select.wav")
                    contextMenu:KillFocus()

                end

            end

        else

            holsterWeaponHolder:SetSize(EFGM.MenuScale(114), EFGM.MenuScale(57))
            holsterWeaponIcon:Show()
            if IsValid(holsterItem) then holsterItem:Remove() end

        end

        if !table.IsEmpty(playerWeaponSlots[3][1]) then

            -- MELEE

            local i = EFGMITEMS[playerWeaponSlots[3][1].name]

            if IsValid(meleeItem) then meleeItem:Remove() end
            meleeItem = vgui.Create("DButton", meleeWeaponHolder)
            meleeItem:Dock(FILL)
            meleeItem:SetText("")
            meleeItem:Droppable("items")
            meleeItem:Droppable("slot_melee")
            meleeItem.SLOTID = 3
            meleeItem.SLOT = 1
            meleeItem.ORIGIN = "equipped"

            meleeWeaponHolder:SetSize(EFGM.MenuScale(57 * i.sizeX), EFGM.MenuScale(57 * i.sizeY))
            meleeWeaponIcon:Hide()

            function meleeItem:Paint(w, h)

                surface.SetDrawColor(Color(255, 255, 255, 2))
                surface.DrawRect(0, 0, w, EFGM.MenuScale(1))
                surface.DrawRect(0, h - EFGM.MenuScale(1), w, EFGM.MenuScale(1))
                surface.DrawRect(0, 0, EFGM.MenuScale(1), h)
                surface.DrawRect(w - EFGM.MenuScale(1), 0, EFGM.MenuScale(1), h)

                surface.SetDrawColor(i.iconColor or Color(5, 5, 5, 20))
                surface.DrawRect(0, 0, w, h)

                surface.SetDrawColor(255, 255, 255, 255)
                surface.SetMaterial(i.icon)
                surface.DrawTexturedRect(0, 0, w, h)

            end

            surface.SetFont("Purista18")

            local nameSize = surface.GetTextSize(i.displayName)
            local nameFont

            if nameSize <= (EFGM.MenuScale(49 * i.sizeX)) then nameFont = "PuristaBold18"
            else nameFont = "PuristaBold14" end

            function meleeItem:PaintOver(w, h)

                draw.SimpleTextOutlined(i.displayName, nameFont, w - EFGM.MenuScale(3), EFGM.MenuScale(-1), MenuAlias.whiteColor, TEXT_ALIGN_RIGHT, TEXT_ALIGN_TOP, 1, MenuAlias.blackColor)

            end

            function meleeItem:DoClick()

                if input.IsKeyDown(KEY_LSHIFT) then

                    surface.PlaySound("ui/element_select.wav")
                    UnEquipItemFromInventory(meleeItem.SLOTID, meleeItem.SLOT)

                end

            end

            function meleeItem:DoDoubleClick()

                Menu.InspectItem(playerWeaponSlots[3][1].name)
                surface.PlaySound("ui/element_select.wav")

            end

            function meleeItem:DoRightClick()

                local x, y = equipmentHolder:LocalCursorPos()
                surface.PlaySound("ui/element_hover.wav")

                if x <= (equipmentHolder:GetWide() / 2) then sideH = true else sideH = false end
                if y <= (equipmentHolder:GetTall() / 2) then sideV = true else sideV = false end

                if IsValid(contextMenu) then contextMenu:Remove() end
                contextMenu = vgui.Create("DPanel", equipmentHolder)
                contextMenu:SetSize(EFGM.MenuScale(100), EFGM.MenuScale(85))
                contextMenu:DockPadding(EFGM.MenuScale(5), EFGM.MenuScale(5), EFGM.MenuScale(5), EFGM.MenuScale(5))
                contextMenu:SetAlpha(0)
                contextMenu:AlphaTo(255, 0.1, 0, nil)
                contextMenu:RequestFocus()

                if sideH == true then

                    contextMenu:SetX(math.Clamp(x + EFGM.MenuScale(5), EFGM.MenuScale(5), equipmentHolder:GetWide() - contextMenu:GetWide() - EFGM.MenuScale(5)))

                else

                    contextMenu:SetX(math.Clamp(x - contextMenu:GetWide() - EFGM.MenuScale(5), EFGM.MenuScale(5), equipmentHolder:GetWide() - contextMenu:GetWide() - EFGM.MenuScale(5)))

                end

                if sideV == true then

                    contextMenu:SetY(math.Clamp(y + EFGM.MenuScale(5), EFGM.MenuScale(5), equipmentHolder:GetTall() - contextMenu:GetTall() - EFGM.MenuScale(5)))

                else

                    contextMenu:SetY(math.Clamp(y - contextMenu:GetTall() + EFGM.MenuScale(5), EFGM.MenuScale(5), equipmentHolder:GetTall() - contextMenu:GetTall() - EFGM.MenuScale(5)))

                end

                contextMenu.Paint = function(s, w, h)

                    if !IsValid(s) then return end

                    BlurPanel(s, EFGM.MenuScale(5))

                    surface.SetDrawColor(Color(5, 5, 5, 50))
                    surface.DrawRect(0, 0, w, h)

                    surface.SetDrawColor(Color(255, 255, 255, 30))
                    surface.DrawRect(0, 0, w, EFGM.MenuScale(1))
                    surface.DrawRect(0, h - EFGM.MenuScale(1), w, EFGM.MenuScale(1))
                    surface.DrawRect(0, 0, EFGM.MenuScale(1), h)
                    surface.DrawRect(w - EFGM.MenuScale(1), 0, EFGM.MenuScale(1), h)

                    contextMenu:SizeToChildren(true, true)

                end

                hook.Add("Think", "CheckIfContextMenuStillFocused", function()

                    if !IsValid(contextMenu) then hook.Remove("Think", "CheckIfContextMenuStillFocused") return end
                    if (input.IsMouseDown(MOUSE_LEFT) or input.IsMouseDown(MOUSE_RIGHT) or input.IsMouseDown(MOUSE_MIDDLE) or input.IsMouseDown(MOUSE_WHEEL_DOWN) or input.IsMouseDown(MOUSE_WHEEL_UP)) and !contextMenu:IsChildHovered() then contextMenu:KillFocus() hook.Remove("Think", "CheckIfContextMenuStillFocused") end

                end)

                function contextMenu:OnFocusChanged(focus)

                    if !focus then contextMenu:AlphaTo(0, 0.1, 0, function() contextMenu:Remove() hook.Remove("Think", "CheckIfContextMenuStillFocused") end) end

                end

                local itemInspectButton = vgui.Create("DButton", contextMenu)
                itemInspectButton:Dock(TOP)
                itemInspectButton:SetSize(0, EFGM.MenuScale(25))
                itemInspectButton:SetText("INSPECT")

                itemInspectButton.OnCursorEntered = function(s)

                    surface.PlaySound("ui/element_hover.wav")

                end

                function itemInspectButton:DoClick()

                    Menu.InspectItem(playerWeaponSlots[3][1].name, playerWeaponSlots[3][1].data)
                    surface.PlaySound("ui/element_select.wav")
                    contextMenu:KillFocus()

                end

                if Menu.Player:CompareStatus(0) and table.IsEmpty(container) then

                    contextMenu:SetTall(contextMenu:GetTall() + EFGM.MenuScale(25))

                    local itemStashButton = vgui.Create("DButton", contextMenu)
                    itemStashButton:Dock(TOP)
                    itemStashButton:SetSize(0, EFGM.MenuScale(25))
                    itemStashButton:SetText("STASH")

                    itemStashButton.OnCursorEntered = function(s)

                        surface.PlaySound("ui/element_hover.wav")

                    end

                    function itemStashButton:DoClick()

                        surface.PlaySound("ui/element_select.wav")
                        contextMenu:Remove()

                        StashItemFromEquipped(meleeItem.SLOTID, meleeItem.SLOT)

                        ReloadStash()

                    end

                end

                local itemUnequipButton = vgui.Create("DButton", contextMenu)
                itemUnequipButton:Dock(TOP)
                itemUnequipButton:SetSize(0, EFGM.MenuScale(25))
                itemUnequipButton:SetText("UNEQUIP")

                itemUnequipButton.OnCursorEntered = function(s)

                    surface.PlaySound("ui/element_hover.wav")

                end

                function itemUnequipButton:DoClick()

                    UnEquipItemFromInventory(meleeItem.SLOTID, meleeItem.SLOT)

                    surface.PlaySound("ui/element_select.wav")
                    contextMenu:KillFocus()

                end

                local itemDropButton = vgui.Create("DButton", contextMenu)
                itemDropButton:Dock(TOP)
                itemDropButton:SetSize(0, EFGM.MenuScale(25))
                itemDropButton:SetText("DROP")

                itemDropButton.OnCursorEntered = function(s)

                    surface.PlaySound("ui/element_hover.wav")

                end

                function itemDropButton:DoClick()

                    DropEquippedItem(meleeItem.SLOTID, meleeItem.SLOT)

                    surface.PlaySound("ui/element_select.wav")
                    contextMenu:KillFocus()

                end

            end

        else

            meleeWeaponIcon:Show()
            meleeWeaponHolder:SetSize(EFGM.MenuScale(114), EFGM.MenuScale(57))
            if IsValid(meleeItem) then meleeItem:Remove() end

        end

        secondaryWeaponHolder:SetPos(equipmentHolder:GetWide() - secondaryWeaponHolder:GetWide(), equipmentHolder:GetTall() - secondaryWeaponHolder:GetTall())
        secondaryWeaponText:SetPos(equipmentHolder:GetWide() - secondaryWeaponText:GetWide(), secondaryWeaponHolder:GetY() - EFGM.MenuScale(30))
        primaryWeaponHolder:SetPos(equipmentHolder:GetWide() - primaryWeaponHolder:GetWide(), secondaryWeaponHolder:GetY() - primaryWeaponHolder:GetTall() - EFGM.MenuScale(40))
        primaryWeaponText:SetPos(equipmentHolder:GetWide() - primaryWeaponText:GetWide(), primaryWeaponHolder:GetY() - EFGM.MenuScale(30))
        holsterWeaponHolder:SetPos(equipmentHolder:GetWide() - holsterWeaponHolder:GetWide(), primaryWeaponHolder:GetY() - holsterWeaponHolder:GetTall() - EFGM.MenuScale(40))
        holsterWeaponText:SetPos(equipmentHolder:GetWide() - holsterWeaponText:GetWide(), holsterWeaponHolder:GetY() - EFGM.MenuScale(30))
        meleeWeaponHolder:SetPos(equipmentHolder:GetWide() - meleeWeaponHolder:GetWide(), holsterWeaponHolder:GetY() - meleeWeaponHolder:GetTall() - EFGM.MenuScale(40))
        meleeWeaponText:SetPos(equipmentHolder:GetWide() - meleeWeaponText:GetWide(), meleeWeaponHolder:GetY() - EFGM.MenuScale(30))

    end

    ReloadSlots()

    secondaryWeaponHolder:Receiver("slot_primary", function(self, panels, dropped, _, x, y)

        if !dropped then return end
        if !table.IsEmpty(playerWeaponSlots[1][2]) then return end

        if panels[1].ORIGIN == "inventory" then

            surface.PlaySound("ui/element_select.wav")
            EquipItemFromInventory(panels[1].ID, panels[1].SLOT, 2)
            ReloadSlots()

        end

        if panels[1].ORIGIN == "stash" then

            surface.PlaySound("ui/element_select.wav")
            EquipItemFromStash(panels[1].ID, panels[1].SLOT, 2)
            ReloadSlots()

        end

    end)

    primaryWeaponHolder:Receiver("slot_primary", function(self, panels, dropped, _, x, y)

        if !dropped then return end
        if !table.IsEmpty(playerWeaponSlots[1][1]) then return end

        if panels[1].ORIGIN == "inventory" then

            surface.PlaySound("ui/element_select.wav")
            EquipItemFromInventory(panels[1].ID, panels[1].SLOT, 1)
            ReloadSlots()

        end

        if panels[1].ORIGIN == "stash" then

            surface.PlaySound("ui/element_select.wav")
            EquipItemFromStash(panels[1].ID, panels[1].SLOT, 1)
            ReloadSlots()

        end

    end)

    holsterWeaponHolder:Receiver("slot_holster", function(self, panels, dropped, _, x, y)

        if !dropped then return end
        if !table.IsEmpty(playerWeaponSlots[2][1]) then return end

        if panels[1].ORIGIN == "inventory" then

            surface.PlaySound("ui/element_select.wav")
            EquipItemFromInventory(panels[1].ID, panels[1].SLOT)
            ReloadSlots()

        end

        if panels[1].ORIGIN == "stash" then

            surface.PlaySound("ui/element_select.wav")
            EquipItemFromStash(panels[1].ID, panels[1].SLOT)
            ReloadSlots()

        end

    end)

    meleeWeaponHolder:Receiver("slot_melee", function(self, panels, dropped, _, x, y)

        if !dropped then return end
        if !table.IsEmpty(playerWeaponSlots[3][1]) then return end

        if panels[1].ORIGIN == "inventory" then

            surface.PlaySound("ui/element_select.wav")
            EquipItemFromInventory(panels[1].ID, panels[1].SLOT)
            ReloadSlots()

        end

        if panels[1].ORIGIN == "stash" then

            surface.PlaySound("ui/element_select.wav")
            EquipItemFromStash(panels[1].ID, panels[1].SLOT)
            ReloadSlots()

        end

    end)

    local healthHolder = vgui.Create("DPanel", playerPanel)
    healthHolder:SetPos(EFGM.MenuScale(10), EFGM.MenuScale(895))
    healthHolder:SetSize(EFGM.MenuScale(125), EFGM.MenuScale(55))
    function healthHolder:Paint(w, h)

        surface.SetDrawColor(Color(255, 255, 255, 25))
        surface.DrawRect(0, 0, w, EFGM.MenuScale(1))

        draw.SimpleTextOutlined(Menu.Player:Health() or "0", "PuristaBold50", EFGM.MenuScale(60), EFGM.MenuScale(1), Color(25, 255, 25), TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP, 1, MenuAlias.blackColor)

    end

    local healthText = vgui.Create("DPanel", playerPanel)
    healthText:SetSize(EFGM.MenuScale(80), EFGM.MenuScale(30))
    healthText:SetPos(EFGM.MenuScale(10), EFGM.MenuScale(865))
    healthText.Paint = function(s, w, h)

        surface.SetDrawColor(Color(80, 80, 80, 10))
        surface.DrawRect(0, 0, w, h)

        surface.SetDrawColor(Color(255, 255, 255, 155))
        surface.DrawRect(0, 0, EFGM.MenuScale(220), EFGM.MenuScale(2))

        draw.SimpleTextOutlined("HEALTH", "PuristaBold24", w / 2, EFGM.MenuScale(2), MenuAlias.whiteColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 1, MenuAlias.blackColor)

    end

    local healthIcon = vgui.Create("DImage", healthHolder)
    healthIcon:SetPos(EFGM.MenuScale(1), EFGM.MenuScale(1))
    healthIcon:SetSize(EFGM.MenuScale(53), EFGM.MenuScale(53))
    healthIcon:SetImage("icons/health_icon.png")
    healthIcon:SetImageColor(Color(25, 255, 25))

    local factionIcon = vgui.Create("DImage", playerPanel)
    factionIcon:SetPos(EFGM.MenuScale(20), EFGM.MenuScale(50))
    factionIcon:SetSize(EFGM.MenuScale(115), EFGM.MenuScale(119))
    factionIcon:SetImageColor(Color(255, 255, 255, 2))
    if Menu.Player:GetModel() == "models/eft/pmcs/usec_extended_pm.mdl" then factionIcon:SetImage("icons/usec_icon.png") else factionIcon:SetImage("icons/bear_icon.png") end


    local inventoryPanel = vgui.Create("DPanel", contents)
    inventoryPanel:Dock(LEFT)
    inventoryPanel:DockMargin(EFGM.MenuScale(13), 0, 0, 0)
    inventoryPanel:SetSize(EFGM.MenuScale(613), 0)
    inventoryPanel.Paint = function(s, w, h)

        BlurPanel(s, EFGM.MenuScale(10))

        surface.SetDrawColor(Color(80, 80, 80, 10))
        surface.DrawRect(0, 0, w, h)

        surface.SetDrawColor(Color(255, 255, 255, 155))
        surface.DrawRect(0, 0, w, EFGM.MenuScale(6))

    end

    local inventoryText = vgui.Create("DPanel", inventoryPanel)
    inventoryText:Dock(TOP)
    inventoryText:SetSize(0, EFGM.MenuScale(36))
    function inventoryText:Paint(w, h)

        surface.SetDrawColor(Color(155, 155, 155, 10))
        surface.DrawRect(0, 0, w, h)

        draw.SimpleTextOutlined("INVENTORY", "PuristaBold32", EFGM.MenuScale(5), EFGM.MenuScale(2), MenuAlias.whiteColor, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP, 1, MenuAlias.blackColor)

    end

    local itemsHolder = vgui.Create("DPanel", inventoryPanel)
    itemsHolder:Dock(FILL)
    itemsHolder:DockMargin(EFGM.MenuScale(10), EFGM.MenuScale(10), EFGM.MenuScale(10), EFGM.MenuScale(9))
    itemsHolder:SetSize(0, 0)
    itemsHolder.Paint = function(s, w, h)

        surface.SetDrawColor(Color(0, 0, 0, 0))
        surface.DrawRect(0, 0, w, h)

    end

    local itemsText = vgui.Create("DPanel", itemsHolder)
    itemsText:Dock(TOP)
    itemsText:SetSize(0, EFGM.MenuScale(28))
    surface.SetFont("PuristaBold24")
    local usedWeight = string.format("%04.2f", Menu.Player:GetNWFloat("InventoryWeight", 0.00))
    local maxWeight = 70
    local weightText = usedWeight .. " / " .. maxWeight .. "KG"
    local weightTextSize = surface.GetTextSize(weightText)
    itemsText.Paint = function(s, w, h)

        surface.SetFont("PuristaBold24")
        usedWeight = string.format("%04.2f", Menu.Player:GetNWFloat("InventoryWeight", 0.00))
        maxWeight = 70
        weightText = usedWeight .. " / " .. maxWeight .. "KG"
        weightTextSize = surface.GetTextSize(weightText)

        BlurPanel(s, EFGM.MenuScale(3))

        surface.SetDrawColor(Color(80, 80, 80, 10))
        surface.DrawRect(0, 0, weightTextSize + EFGM.MenuScale(220), h)

        surface.SetDrawColor(Color(255, 255, 255, 155))
        surface.DrawRect(0, 0, weightTextSize + EFGM.MenuScale(220), EFGM.MenuScale(2))

        draw.SimpleTextOutlined(weightText, "PuristaBold24", EFGM.MenuScale(215), EFGM.MenuScale(2), MenuAlias.whiteColor, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP, 1, MenuAlias.blackColor)

        -- total weight capacity
        surface.SetDrawColor(Color(0, 0, 0, 100))
        surface.DrawRect(EFGM.MenuScale(30), EFGM.MenuScale(7), EFGM.MenuScale(180), EFGM.MenuScale(16))

        -- used weight capacity
        surface.SetDrawColor(Color(255, 255, 255, 225))
        surface.DrawRect(EFGM.MenuScale(30), EFGM.MenuScale(7), math.min(EFGM.MenuScale((usedWeight / maxWeight) * 180), 180), EFGM.MenuScale(16))

        surface.SetDrawColor(Color(255, 255, 255, 25))
        surface.DrawRect(EFGM.MenuScale(30), EFGM.MenuScale(7), EFGM.MenuScale(180), EFGM.MenuScale(1))
        surface.DrawRect(EFGM.MenuScale(30), EFGM.MenuScale(23), EFGM.MenuScale(180), EFGM.MenuScale(1))
        surface.DrawRect(EFGM.MenuScale(30), EFGM.MenuScale(7), EFGM.MenuScale(1), EFGM.MenuScale(16))
        surface.DrawRect(EFGM.MenuScale(210) - EFGM.MenuScale(1), EFGM.MenuScale(7), EFGM.MenuScale(1), EFGM.MenuScale(16))

    end

    local weightIcon = vgui.Create("DImage", itemsHolder)
    weightIcon:SetPos(EFGM.MenuScale(0), EFGM.MenuScale(1))
    weightIcon:SetSize(EFGM.MenuScale(28), EFGM.MenuScale(28))
    weightIcon:SetImage("icons/weight_icon.png")

    local searchButton = vgui.Create("DButton", itemsHolder)
    searchButton:SetPos(EFGM.MenuScale(225) + weightTextSize, EFGM.MenuScale(1))
    searchButton:SetSize(EFGM.MenuScale(27), EFGM.MenuScale(27))
    searchButton:SetText("")
    searchButton.Paint = function(s, w, h)

        searchButton:SetX(EFGM.MenuScale(225) + weightTextSize)

        BlurPanel(s, EFGM.MenuScale(3))

        surface.SetDrawColor(Color(80, 80, 80, 10))
        surface.DrawRect(0, 0, w, h)

        surface.SetDrawColor(Color(255, 255, 255, 25))
        surface.DrawRect(0, 0, w, EFGM.MenuScale(1))
        surface.DrawRect(0, h - EFGM.MenuScale(1), w, EFGM.MenuScale(1))
        surface.DrawRect(0, 0, EFGM.MenuScale(1), h)
        surface.DrawRect(w - EFGM.MenuScale(1), 0, EFGM.MenuScale(1), h)

    end

    local searchIcon = vgui.Create("DImage", searchButton)
    searchIcon:SetPos(EFGM.MenuScale(1), EFGM.MenuScale(1))
    searchIcon:SetSize(EFGM.MenuScale(25), EFGM.MenuScale(25))
    searchIcon:SetImage("icons/search_icon.png")

    searchButton.OnCursorEntered = function(s)

        surface.PlaySound("ui/element_hover.wav")

    end

    function searchButton:DoClick()

        surface.PlaySound("ui/element_select.wav")

    end

    local filterButton = vgui.Create("DButton", itemsHolder)
    filterButton:SetPos(EFGM.MenuScale(32) + searchButton:GetX(), EFGM.MenuScale(1))
    filterButton:SetSize(EFGM.MenuScale(27), EFGM.MenuScale(27))
    filterButton:SetText("")
    filterButton.Paint = function(s, w, h)

        filterButton:SetX(EFGM.MenuScale(32) + searchButton:GetX())

        BlurPanel(s, EFGM.MenuScale(3))

        surface.SetDrawColor(Color(80, 80, 80, 10))
        surface.DrawRect(0, 0, w, h)

        surface.SetDrawColor(Color(255, 255, 255, 25))
        surface.DrawRect(0, 0, w, EFGM.MenuScale(1))
        surface.DrawRect(0, h - EFGM.MenuScale(1), w, EFGM.MenuScale(1))
        surface.DrawRect(0, 0, EFGM.MenuScale(1), h)
        surface.DrawRect(w - EFGM.MenuScale(1), 0, EFGM.MenuScale(1), h)

    end

    local filterIcon = vgui.Create("DImage", filterButton)
    filterIcon:SetPos(EFGM.MenuScale(1), EFGM.MenuScale(1))
    filterIcon:SetSize(EFGM.MenuScale(26), EFGM.MenuScale(26))
    filterIcon:SetImage("icons/filter_icon.png")

    filterButton.OnCursorEntered = function(s)

        surface.PlaySound("ui/element_hover.wav")

    end

    function filterButton:DoClick()

        surface.PlaySound("ui/element_select.wav")

    end

    local playerItemsHolder = vgui.Create("DScrollPanel", itemsHolder)
    playerItemsHolder:SetPos(0, EFGM.MenuScale(32))
    playerItemsHolder:SetSize(EFGM.MenuScale(593), EFGM.MenuScale(872))
    function playerItemsHolder:Paint(w, h)

        BlurPanel(playerItemsHolder, EFGM.MenuScale(3))

        surface.SetDrawColor(Color(80, 80, 80, 10))
        surface.DrawRect(0, 0, w, h)

        surface.SetDrawColor(Color(255, 255, 255, 25))
        surface.DrawRect(0, 0, w, EFGM.MenuScale(1))
        surface.DrawRect(0, h - EFGM.MenuScale(1), w, EFGM.MenuScale(1))
        surface.DrawRect(0, 0, EFGM.MenuScale(1), h)
        surface.DrawRect(w - EFGM.MenuScale(1), 0, EFGM.MenuScale(1), h)

    end

    function playerItemsHolder:OnVScroll(offset)

        self.pnlCanvas:SetPos(0, offset)
        if !IsValid(contextMenu) then return end
        contextMenu:AlphaTo(0, 0.1, 0, function() contextMenu:Remove() hook.Remove("Think", "CheckIfContextMenuStillFocused") end)

    end

    playerItemsHolder:Receiver("items", function(self, panels, dropped, _, x, y)

        if !dropped then return end

        if panels[1].ORIGIN == "equipped" then

            surface.PlaySound("ui/element_select.wav")
            UnEquipItemFromInventory(panels[1].SLOTID, panels[1].SLOT)

        end

        if panels[1].ORIGIN == "stash" then

            surface.PlaySound("ui/element_select.wav")
            TakeFromStashToInventory(panels[1].ID)

        end

        if panels[1].ORIGIN == "container" then

            surface.PlaySound("ui/element_select.wav")
            table.remove(container.items, panels[1].ID)

            net.Start("PlayerInventoryLootItemFromContainer", false)
                net.WriteEntity(container.entity)
                net.WriteUInt(panels[1].ID, 16)
            net.SendToServer()

            ReloadContainer()
            ReloadInventory()

        end

    end)

    local playerItems = vgui.Create("DIconLayout", playerItemsHolder)
    playerItems:Dock(TOP)
    playerItems:SetSpaceY(0)
    playerItems:SetSpaceX(0)

    local playerItemsBar = playerItemsHolder:GetVBar()
    playerItemsBar:SetHideButtons(true)
    playerItemsBar:SetSize(EFGM.MenuScale(15), EFGM.MenuScale(15))
    function playerItemsBar:Paint(w, h)
        draw.RoundedBox(0, EFGM.MenuScale(5), EFGM.MenuScale(8), EFGM.MenuScale(5), h - EFGM.MenuScale(16), Color(0, 0, 0, 50))
    end
    function playerItemsBar.btnGrip:Paint(w, h)
        draw.RoundedBox(0, EFGM.MenuScale(5), EFGM.MenuScale(8), EFGM.MenuScale(5), h - EFGM.MenuScale(16), Color(255, 255, 255, 155))
    end

    local plyItems = {}

    function ReloadInventory()

        if !IsValid(playerItems) then return end

        playerItems:Clear()
        plyItems = {}

        for k, v in pairs(playerInventory) do

            plyItems[k] = {}
            plyItems[k].name = v.name
            plyItems[k].id = k
            plyItems[k].data = v.data
            plyItems[k].type = v.type

        end

        if table.IsEmpty(plyItems) then return end

        table.sort(plyItems, function(a, b) return (EFGMITEMS[a.name].sizeX * EFGMITEMS[a.name].sizeY) > (EFGMITEMS[b.name].sizeX * EFGMITEMS[b.name].sizeY) end)

        -- inventory item entry
        for k, v in pairs(plyItems) do

            local i = EFGMITEMS[v.name]
            if i == nil then return end

            local item = playerItems:Add("DButton")
            item:SetSize(EFGM.MenuScale(57 * i.sizeX), EFGM.MenuScale(57 * i.sizeY))
            item:SetText("")
            item:Droppable("items")
            item.ID = v.id
            item.SLOT = i.equipSlot
            item.ORIGIN = "inventory"

            if i.equipType == EQUIPTYPE.Weapon then

                if item.SLOT == WEAPONSLOTS.PRIMARY.ID then item:Droppable("slot_primary") end
                if item.SLOT == WEAPONSLOTS.HOLSTER.ID then item:Droppable("slot_holster") end
                if item.SLOT == WEAPONSLOTS.MELEE.ID then item:Droppable("slot_melee") end
                if item.SLOT == WEAPONSLOTS.GRENADE.ID then item:Droppable("slot_grenade") end

            end

            if Menu.Player:CompareStatus(0) and table.IsEmpty(container) then item:Droppable("stash") end

            function item:Paint(w, h)

                surface.SetDrawColor(Color(255, 255, 255, 2))
                surface.DrawRect(0, 0, w, EFGM.MenuScale(1))
                surface.DrawRect(0, h - EFGM.MenuScale(1), w, EFGM.MenuScale(1))
                surface.DrawRect(0, 0, EFGM.MenuScale(1), h)
                surface.DrawRect(w - EFGM.MenuScale(1), 0, EFGM.MenuScale(1), h)

                surface.SetDrawColor(i.iconColor or Color(5, 5, 5, 20))
                surface.DrawRect(0, 0, w, h)

                surface.SetDrawColor(255, 255, 255, 255)
                surface.SetMaterial(i.icon)
                surface.DrawTexturedRect(0, 0, w, h)

            end

            surface.SetFont("Purista18")

            local nameSize = surface.GetTextSize(i.displayName)
            local nameFont

            if nameSize <= (EFGM.MenuScale(49 * i.sizeX)) then nameFont = "PuristaBold18"
            else nameFont = "PuristaBold14" end

            local duraSize = nil
            local duraFont = nil

            if i.equipType == EQUIPTYPE.Consumable then
                duraSize = surface.GetTextSize(i.consumableValue .. "/" .. i.consumableValue)

                if duraSize <= (EFGM.MenuScale(49 * i.sizeX)) then duraFont = "PuristaBold18"
                else duraFont = "PuristaBold14" end
            end

            function item:PaintOver(w, h)

                draw.SimpleTextOutlined(i.displayName, nameFont, w - EFGM.MenuScale(3), EFGM.MenuScale(-1), MenuAlias.whiteColor, TEXT_ALIGN_RIGHT, TEXT_ALIGN_TOP, 1, MenuAlias.blackColor)

                if i.equipType == EQUIPTYPE.Ammunition then
                    draw.SimpleTextOutlined(v.data.count, "PuristaBold18", w - EFGM.MenuScale(3), h - EFGM.MenuScale(1), MenuAlias.whiteColor, TEXT_ALIGN_RIGHT, TEXT_ALIGN_BOTTOM, 1, MenuAlias.blackColor)
                elseif i.equipType == EQUIPTYPE.Consumable then
                    draw.SimpleTextOutlined(v.data.durability .. "/" .. i.consumableValue, duraFont, w - EFGM.MenuScale(3), h - EFGM.MenuScale(1), MenuAlias.whiteColor, TEXT_ALIGN_RIGHT, TEXT_ALIGN_BOTTOM, 1, MenuAlias.blackColor)
                end

            end

            function item:DoClick()

                if input.IsKeyDown(KEY_LSHIFT) and (Menu.Player:CompareStatus(0) and table.IsEmpty(container)) then

                    surface.PlaySound("ui/element_select.wav")
                    playerItems:InvalidateLayout()
                    StashItemFromInventory(v.id)
                    ReloadStash()

                end

                if input.IsKeyDown(KEY_LALT) and (i.equipType == EQUIPTYPE.Weapon) then

                    surface.PlaySound("ui/element_select.wav")
                    playerItems:InvalidateLayout()
                    EquipItemFromInventory(v.id, i.equipSlot)
                    ReloadSlots()

                end

            end

            function item:DoDoubleClick()

                Menu.InspectItem(v.name, v.data)
                surface.PlaySound("ui/element_select.wav")

            end

            function item:DoRightClick()

                local x, y = itemsHolder:LocalCursorPos()
                surface.PlaySound("ui/element_hover.wav")

                if x <= (itemsHolder:GetWide() / 2) then sideH = true else sideH = false end
                if y <= (itemsHolder:GetTall() / 2) then sideV = true else sideV = false end

                if IsValid(contextMenu) then contextMenu:Remove() end
                contextMenu = vgui.Create("DPanel", itemsHolder)
                contextMenu:SetSize(EFGM.MenuScale(100), EFGM.MenuScale(35))
                contextMenu:DockPadding(EFGM.MenuScale(5), EFGM.MenuScale(5), EFGM.MenuScale(5), EFGM.MenuScale(5))
                contextMenu:SetAlpha(0)
                contextMenu:AlphaTo(255, 0.1, 0, nil)
                contextMenu:RequestFocus()

                contextMenu.Paint = function(s, w, h)

                    if !IsValid(s) then return end

                    BlurPanel(s, EFGM.MenuScale(5))

                    surface.SetDrawColor(Color(5, 5, 5, 50))
                    surface.DrawRect(0, 0, w, h)

                    surface.SetDrawColor(Color(255, 255, 255, 30))
                    surface.DrawRect(0, 0, w, EFGM.MenuScale(1))
                    surface.DrawRect(0, h - EFGM.MenuScale(1), w, EFGM.MenuScale(1))
                    surface.DrawRect(0, 0, EFGM.MenuScale(1), h)
                    surface.DrawRect(w - EFGM.MenuScale(1), 0, EFGM.MenuScale(1), h)

                    contextMenu:SizeToChildren(true, true)

                end

                hook.Add("Think", "CheckIfContextMenuStillFocused", function()

                    if !IsValid(contextMenu) then hook.Remove("Think", "CheckIfContextMenuStillFocused") return end
                    if (input.IsMouseDown(MOUSE_LEFT) or input.IsMouseDown(MOUSE_RIGHT) or input.IsMouseDown(MOUSE_MIDDLE)) and !contextMenu:IsChildHovered() then contextMenu:KillFocus() hook.Remove("Think", "CheckIfContextMenuStillFocused") end

                end)

                function contextMenu:OnFocusChanged(focus)

                    if !focus then contextMenu:AlphaTo(0, 0.1, 0, function() contextMenu:Remove() hook.Remove("Think", "CheckIfContextMenuStillFocused") end) end

                end

                local itemInspectButton = vgui.Create("DButton", contextMenu)
                itemInspectButton:Dock(TOP)
                itemInspectButton:SetSize(0, EFGM.MenuScale(25))
                itemInspectButton:SetText("INSPECT")

                itemInspectButton.OnCursorEntered = function(s)

                    surface.PlaySound("ui/element_hover.wav")

                end

                function itemInspectButton:DoClick()

                    Menu.InspectItem(v.name, v.data)
                    surface.PlaySound("ui/element_select.wav")
                    contextMenu:KillFocus()

                end

                -- actions that can be performed on this specific item
                -- default
                local actions = {
                    droppable = true,
                    equipable = false,
                    consumable = false,
                    splittable = false,
                    stashable = false
                }

                actions.stashable = Menu.Player:CompareStatus(0) and table.IsEmpty(container)
                actions.equipable = i.equipType == EQUIPTYPE.Weapon
                actions.splittable = i.stackSize > 1 and v.data.count > 1
                actions.consumable = i.equipType == EQUIPTYPE.Consumable

                if actions.stashable then

                    contextMenu:SetTall(contextMenu:GetTall() + EFGM.MenuScale(25))

                    local itemStashButton = vgui.Create("DButton", contextMenu)
                    itemStashButton:Dock(TOP)
                    itemStashButton:SetSize(0, EFGM.MenuScale(25))
                    itemStashButton:SetText("STASH")

                    itemStashButton.OnCursorEntered = function(s)

                        surface.PlaySound("ui/element_hover.wav")

                    end

                    function itemStashButton:DoClick()

                        surface.PlaySound("ui/element_select.wav")
                        contextMenu:Remove()
                        playerItems:InvalidateLayout()

                        StashItemFromInventory(v.id)

                        ReloadStash()

                    end

                end

                if actions.equipable then

                    contextMenu:SetTall(contextMenu:GetTall() + EFGM.MenuScale(25))

                    local itemEquipButton = vgui.Create("DButton", contextMenu)
                    itemEquipButton:Dock(TOP)
                    itemEquipButton:SetSize(0, EFGM.MenuScale(25))
                    itemEquipButton:SetText("EQUIP")

                    itemEquipButton.OnCursorEntered = function(s)

                        surface.PlaySound("ui/element_hover.wav")

                    end

                    function itemEquipButton:DoClick()

                        surface.PlaySound("ui/element_select.wav")
                        contextMenu:Remove()
                        playerItems:InvalidateLayout()

                        EquipItemFromInventory(v.id, i.equipSlot)

                        ReloadSlots()

                    end

                end

                if actions.consumable then

                    contextMenu:SetTall(contextMenu:GetTall() + EFGM.MenuScale(25))

                    local itemConsumeButton = vgui.Create("DButton", contextMenu)
                    itemConsumeButton:Dock(TOP)
                    itemConsumeButton:SetSize(0, EFGM.MenuScale(25))
                    itemConsumeButton:SetText("USE")

                    itemConsumeButton.OnCursorEntered = function(s)

                        surface.PlaySound("ui/element_hover.wav")

                    end

                    function itemConsumeButton:DoClick()

                        surface.PlaySound("ui/element_select.wav")
                        ConsumeItemFromInventory(v.id)
                        contextMenu:Remove()
                        playerItems:InvalidateLayout()

                    end

                end

                if actions.splittable then

                    contextMenu:SetTall(contextMenu:GetTall() + EFGM.MenuScale(25))

                    local itemSplitButton = vgui.Create("DButton", contextMenu)
                    itemSplitButton:Dock(TOP)
                    itemSplitButton:SetSize(0, EFGM.MenuScale(25))
                    itemSplitButton:SetText("SPLIT")

                    itemSplitButton.OnCursorEntered = function(s)

                        surface.PlaySound("ui/element_hover.wav")

                    end

                    function itemSplitButton:DoClick()

                        Menu.ConfirmSplit(v.name, v.data, v.id, "inv")
                        contextMenu:KillFocus()
                        playerItems:InvalidateLayout()

                    end

                end

                if actions.droppable then

                    contextMenu:SetTall(contextMenu:GetTall() + EFGM.MenuScale(25))

                    local itemDropButton = vgui.Create("DButton", contextMenu)
                    itemDropButton:Dock(TOP)
                    itemDropButton:SetSize(0, EFGM.MenuScale(25))
                    itemDropButton:SetText("DROP")

                    itemDropButton.OnCursorEntered = function(s)

                        surface.PlaySound("ui/element_hover.wav")

                    end

                    function itemDropButton:DoClick()

                        surface.PlaySound("ui/element_select.wav")
                        DropItemFromInventory(v.id, v.data)
                        contextMenu:Remove()
                        playerItems:InvalidateLayout()

                    end

                end

                if sideH == true then

                    contextMenu:SetX(math.Clamp(x + EFGM.MenuScale(5), EFGM.MenuScale(5), itemsHolder:GetWide() - contextMenu:GetWide() - EFGM.MenuScale(5)))

                else

                    contextMenu:SetX(math.Clamp(x - contextMenu:GetWide() - EFGM.MenuScale(5), EFGM.MenuScale(5), itemsHolder:GetWide() - contextMenu:GetWide() - EFGM.MenuScale(5)))

                end

                if sideV == true then

                    contextMenu:SetY(math.Clamp(y + EFGM.MenuScale(5), EFGM.MenuScale(5), itemsHolder:GetTall() - contextMenu:GetTall() - EFGM.MenuScale(5)))

                else

                    contextMenu:SetY(math.Clamp(y - contextMenu:GetTall() + EFGM.MenuScale(5), EFGM.MenuScale(5), itemsHolder:GetTall() - contextMenu:GetTall() - EFGM.MenuScale(5)))

                end

            end

        end

        playerItems:InvalidateLayout()

    end

    ReloadInventory()

    if !table.IsEmpty(container) then

        local containerPanel = vgui.Create("DPanel", contents)
        containerPanel:Dock(LEFT)
        containerPanel:DockMargin(EFGM.MenuScale(13), 0, 0, 0)
        containerPanel:SetSize(EFGM.MenuScale(613), 0)
        containerPanel.Paint = function(s, w, h)

            BlurPanel(s, EFGM.MenuScale(10))

            surface.SetDrawColor(Color(80, 80, 80, 10))
            surface.DrawRect(0, 0, w, h)

            surface.SetDrawColor(Color(255, 255, 255, 155))
            surface.DrawRect(0, 0, w, EFGM.MenuScale(6))

        end

        local containerText = vgui.Create("DPanel", containerPanel)
        containerText:Dock(TOP)
        containerText:SetSize(0, EFGM.MenuScale(36))
        function containerText:Paint(w, h)

            surface.SetDrawColor(Color(155, 155, 155, 10))
            surface.DrawRect(0, 0, w, h)

            draw.SimpleTextOutlined(container.name, "PuristaBold32", EFGM.MenuScale(5), EFGM.MenuScale(2), MenuAlias.whiteColor, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP, 1, MenuAlias.blackColor)

        end

        local containerHolder = vgui.Create("DPanel", containerPanel)
        containerHolder:Dock(FILL)
        containerHolder:DockMargin(EFGM.MenuScale(10), EFGM.MenuScale(10), EFGM.MenuScale(10), EFGM.MenuScale(9))
        containerHolder:SetSize(0, 0)
        containerHolder.Paint = function(s, w, h)

            surface.SetDrawColor(Color(0, 0, 0, 0))
            surface.DrawRect(0, 0, w, h)

        end

        local containerItemsHolder = vgui.Create("DScrollPanel", containerHolder)
        containerItemsHolder:SetPos(0, EFGM.MenuScale(32))
        containerItemsHolder:SetSize(EFGM.MenuScale(593), EFGM.MenuScale(872))
        function containerItemsHolder:Paint(w, h)

            BlurPanel(containerItemsHolder, EFGM.MenuScale(3))

            surface.SetDrawColor(Color(80, 80, 80, 10))
            surface.DrawRect(0, 0, w, h)

            surface.SetDrawColor(Color(255, 255, 255, 25))
            surface.DrawRect(0, 0, w, EFGM.MenuScale(1))
            surface.DrawRect(0, h - EFGM.MenuScale(1), w, EFGM.MenuScale(1))
            surface.DrawRect(0, 0, EFGM.MenuScale(1), h)
            surface.DrawRect(w - EFGM.MenuScale(1), 0, EFGM.MenuScale(1), h)

        end

        function containerItemsHolder:OnVScroll(offset)

            self.pnlCanvas:SetPos(0, offset)
            if !IsValid(contextMenu) then return end
            contextMenu:AlphaTo(0, 0.1, 0, function() contextMenu:Remove() hook.Remove("Think", "CheckIfContextMenuStillFocused") end)

        end

        local containerItems = vgui.Create("DIconLayout", containerItemsHolder)
        containerItems:Dock(TOP)
        containerItems:SetSpaceY(0)
        containerItems:SetSpaceX(0)

        local containerItemsBar = containerItemsHolder:GetVBar()
        containerItemsBar:SetHideButtons(true)
        containerItemsBar:SetSize(EFGM.MenuScale(15), EFGM.MenuScale(15))
        function containerItemsBar:Paint(w, h)
            draw.RoundedBox(0, EFGM.MenuScale(5), EFGM.MenuScale(8), EFGM.MenuScale(5), h - EFGM.MenuScale(16), Color(0, 0, 0, 50))
        end
        function containerItemsBar.btnGrip:Paint(w, h)
            draw.RoundedBox(0, EFGM.MenuScale(5), EFGM.MenuScale(8), EFGM.MenuScale(5), h - EFGM.MenuScale(16), Color(255, 255, 255, 155))
        end

        function ReloadContainer()

            containerItems:Clear()
            conItems = {}
            for k, v in ipairs(container.items) do

                conItems[k] = {}
                conItems[k].name = v.name
                conItems[k].id = k
                conItems[k].data = v.data
                conItems[k].type = v.type

            end

            if table.IsEmpty(conItems) then return end

            table.sort(conItems, function(a, b) return (EFGMITEMS[a.name].sizeX * EFGMITEMS[a.name].sizeY) > (EFGMITEMS[b.name].sizeX * EFGMITEMS[b.name].sizeY) end)

            for k, v in pairs(conItems) do

                local i = EFGMITEMS[v.name]
                if i == nil then return end

                local item = containerItems:Add("DButton")
                item:SetSize(EFGM.MenuScale(57 * i.sizeX), EFGM.MenuScale(57 * i.sizeY))
                item:SetText("")
                item:Droppable("items")
                item.ID = v.id
                item.ORIGIN = "container"

                if i.equipType == EQUIPTYPE.Weapon then

                    if item.SLOT == WEAPONSLOTS.PRIMARY.ID then item:Droppable("slot_primary") end
                    if item.SLOT == WEAPONSLOTS.HOLSTER.ID then item:Droppable("slot_holster") end
                    if item.SLOT == WEAPONSLOTS.MELEE.ID then item:Droppable("slot_melee") end
                    if item.SLOT == WEAPONSLOTS.GRENADE.ID then item:Droppable("slot_grenade") end

                end

                function item:Paint(w, h)

                    surface.SetDrawColor(Color(255, 255, 255, 2))
                    surface.DrawRect(0, 0, w, EFGM.MenuScale(1))
                    surface.DrawRect(0, h - EFGM.MenuScale(1), w, EFGM.MenuScale(1))
                    surface.DrawRect(0, 0, EFGM.MenuScale(1), h)
                    surface.DrawRect(w - EFGM.MenuScale(1), 0, EFGM.MenuScale(1), h)

                    surface.SetDrawColor(i.iconColor or Color(5, 5, 5, 20))
                    surface.DrawRect(0, 0, w, h)

                    surface.SetDrawColor(255, 255, 255, 255)
                    surface.SetMaterial(i.icon)
                    surface.DrawTexturedRect(0, 0, w, h)

                end

                surface.SetFont("Purista18")

                local nameSize = surface.GetTextSize(i.displayName)
                local nameFont

                if nameSize <= (EFGM.MenuScale(49 * i.sizeX)) then nameFont = "PuristaBold18"
                else nameFont = "PuristaBold14" end

                local duraSize = nil
                local duraFont = nil

                if i.equipType == EQUIPTYPE.Consumable then
                    duraSize = surface.GetTextSize(i.consumableValue .. "/" .. i.consumableValue)

                    if duraSize <= (EFGM.MenuScale(49 * i.sizeX)) then duraFont = "PuristaBold18"
                    else duraFont = "PuristaBold14" end
                end

                function item:PaintOver(w, h)

                    draw.SimpleTextOutlined(i.displayName, nameFont, w - EFGM.MenuScale(3), EFGM.MenuScale(-1), MenuAlias.whiteColor, TEXT_ALIGN_RIGHT, TEXT_ALIGN_TOP, 1, MenuAlias.blackColor)

                    if i.equipType == EQUIPTYPE.Ammunition then
                        draw.SimpleTextOutlined(v.data.count, "PuristaBold18", w - EFGM.MenuScale(3), h - EFGM.MenuScale(1), MenuAlias.whiteColor, TEXT_ALIGN_RIGHT, TEXT_ALIGN_BOTTOM, 1, MenuAlias.blackColor)
                    elseif i.equipType == EQUIPTYPE.Consumable then
                        draw.SimpleTextOutlined(v.data.durability .. "/" .. i.consumableValue, duraFont, w - EFGM.MenuScale(3), h - EFGM.MenuScale(1), MenuAlias.whiteColor, TEXT_ALIGN_RIGHT, TEXT_ALIGN_BOTTOM, 1, MenuAlias.blackColor)
                    end

                end

                function item:DoClick()

                    if input.IsKeyDown(KEY_LSHIFT) then

                        surface.PlaySound("ui/element_select.wav")

                        table.remove(container.items, v.id)

                        net.Start("PlayerInventoryLootItemFromContainer", false)
                            net.WriteEntity(container.entity)
                            net.WriteUInt(v.id, 16)
                        net.SendToServer()

                        ReloadContainer()
                        ReloadInventory()

                    end

                end

                function item:DoDoubleClick()

                    Menu.InspectItem(v.name, v.data)
                    surface.PlaySound("ui/element_select.wav")

                end

                function item:DoRightClick()

                    local x, y = containerHolder:LocalCursorPos()
                    surface.PlaySound("ui/element_hover.wav")

                    if x <= (containerHolder:GetWide() / 2) then sideH = true else sideH = false end
                    if y <= (containerHolder:GetTall() / 2) then sideV = true else sideV = false end

                    if IsValid(contextMenu) then contextMenu:Remove() end
                    contextMenu = vgui.Create("DPanel", containerHolder)
                    contextMenu:SetSize(EFGM.MenuScale(100), EFGM.MenuScale(35))
                    contextMenu:DockPadding(EFGM.MenuScale(5), EFGM.MenuScale(5), EFGM.MenuScale(5), EFGM.MenuScale(5))
                    contextMenu:SetAlpha(0)
                    contextMenu:AlphaTo(255, 0.1, 0, nil)
                    contextMenu:RequestFocus()

                    contextMenu.Paint = function(s, w, h)

                        if !IsValid(s) then return end

                        BlurPanel(s, EFGM.MenuScale(5))

                        surface.SetDrawColor(Color(5, 5, 5, 50))
                        surface.DrawRect(0, 0, w, h)

                        surface.SetDrawColor(Color(255, 255, 255, 30))
                        surface.DrawRect(0, 0, w, EFGM.MenuScale(1))
                        surface.DrawRect(0, h - EFGM.MenuScale(1), w, EFGM.MenuScale(1))
                        surface.DrawRect(0, 0, EFGM.MenuScale(1), h)
                        surface.DrawRect(w - EFGM.MenuScale(1), 0, EFGM.MenuScale(1), h)

                        contextMenu:SizeToChildren(true, true)

                    end

                    hook.Add("Think", "CheckIfContextMenuStillFocused", function()

                        if !IsValid(contextMenu) then hook.Remove("Think", "CheckIfContextMenuStillFocused") return end
                        if (input.IsMouseDown(MOUSE_LEFT) or input.IsMouseDown(MOUSE_RIGHT) or input.IsMouseDown(MOUSE_MIDDLE) or input.IsMouseDown(MOUSE_WHEEL_DOWN) or input.IsMouseDown(MOUSE_WHEEL_UP)) and !contextMenu:IsChildHovered() then contextMenu:KillFocus() hook.Remove("Think", "CheckIfContextMenuStillFocused") end

                    end)

                    function contextMenu:OnFocusChanged(focus)

                        if !focus then contextMenu:AlphaTo(0, 0.1, 0, function() contextMenu:Remove() hook.Remove("Think", "CheckIfContextMenuStillFocused") end) end

                    end

                    local itemInspectButton = vgui.Create("DButton", contextMenu)
                    itemInspectButton:Dock(TOP)
                    itemInspectButton:SetSize(0, EFGM.MenuScale(25))
                    itemInspectButton:SetText("INSPECT")

                    itemInspectButton.OnCursorEntered = function(s)

                        surface.PlaySound("ui/element_hover.wav")

                    end

                    function itemInspectButton:DoClick()

                        Menu.InspectItem(v.name, v.data)
                        surface.PlaySound("ui/element_select.wav")
                        contextMenu:KillFocus()

                    end

                    -- actions that can be performed on this specific item
                    -- default
                    local actions = {
                        lootable = true
                    }

                    if actions.lootable then

                        contextMenu:SetTall(contextMenu:GetTall() + EFGM.MenuScale(25))

                        local itemLootButton = vgui.Create("DButton", contextMenu)
                        itemLootButton:Dock(TOP)
                        itemLootButton:SetSize(0, EFGM.MenuScale(25))
                        itemLootButton:SetText("LOOT")

                        itemLootButton.OnCursorEntered = function(s)

                            surface.PlaySound("ui/element_hover.wav")

                        end

                        function itemLootButton:DoClick()

                            surface.PlaySound("ui/element_select.wav")
                            contextMenu:Remove()

                            table.remove(container.items, v.id)

                            net.Start("PlayerInventoryLootItemFromContainer", false)
                                net.WriteEntity(container.entity)
                                net.WriteUInt(v.id, 16)
                            net.SendToServer()

                            ReloadContainer()
                            ReloadInventory()


                        end

                    end

                    if sideH == true then

                        contextMenu:SetX(math.Clamp(x + EFGM.MenuScale(5), EFGM.MenuScale(5), itemsHolder:GetWide() - contextMenu:GetWide() - EFGM.MenuScale(5)))

                    else

                        contextMenu:SetX(math.Clamp(x - contextMenu:GetWide() - EFGM.MenuScale(5), EFGM.MenuScale(5), itemsHolder:GetWide() - contextMenu:GetWide() - EFGM.MenuScale(5)))

                    end

                    if sideV == true then

                        contextMenu:SetY(math.Clamp(y + EFGM.MenuScale(5), EFGM.MenuScale(5), itemsHolder:GetTall() - contextMenu:GetTall() - EFGM.MenuScale(5)))

                    else

                        contextMenu:SetY(math.Clamp(y - contextMenu:GetTall() + EFGM.MenuScale(5), EFGM.MenuScale(5), itemsHolder:GetTall() - contextMenu:GetTall() - EFGM.MenuScale(5)))

                    end

                end

            end

        end

        ReloadContainer()

        return

    end

    -- dont show stash when player is in a raid
    if !Menu.Player:CompareStatus(0) and table.IsEmpty(container) then return end
    local stashPanel = vgui.Create("DPanel", contents)
    stashPanel:Dock(LEFT)
    stashPanel:DockMargin(EFGM.MenuScale(13), 0, 0, 0)
    stashPanel:SetSize(EFGM.MenuScale(613), 0)
    stashPanel.Paint = function(s, w, h)

        BlurPanel(s, EFGM.MenuScale(10))

        surface.SetDrawColor(Color(80, 80, 80, 10))
        surface.DrawRect(0, 0, w, h)

        surface.SetDrawColor(Color(255, 255, 255, 155))
        surface.DrawRect(0, 0, w, EFGM.MenuScale(6))

    end

    local maxStash = 150
    local stashText = vgui.Create("DPanel", stashPanel)
    stashText:Dock(TOP)
    stashText:SetSize(0, EFGM.MenuScale(36))
    function stashText:Paint(w, h)

        surface.SetDrawColor(Color(155, 155, 155, 10))
        surface.DrawRect(0, 0, w, h)

        draw.SimpleTextOutlined("STASH", "PuristaBold32", EFGM.MenuScale(5), EFGM.MenuScale(2), MenuAlias.whiteColor, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP, 1, MenuAlias.blackColor)
        draw.SimpleTextOutlined(Menu.Player:GetNWInt("StashCount", 0) .. "/" .. maxStash, "PuristaBold18", EFGM.MenuScale(95), EFGM.MenuScale(13), MenuAlias.whiteColor, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP, 1, MenuAlias.blackColor)

    end

    local stashHolder = vgui.Create("DPanel", stashPanel)
    stashHolder:Dock(FILL)
    stashHolder:DockMargin(EFGM.MenuScale(10), EFGM.MenuScale(10), EFGM.MenuScale(10), EFGM.MenuScale(9))
    stashHolder:SetSize(0, 0)
    stashHolder.Paint = function(s, w, h)

        surface.SetDrawColor(Color(0, 0, 0, 0))
        surface.DrawRect(0, 0, w, h)

    end

    local stashInfoText = vgui.Create("DPanel", stashHolder)
    stashInfoText:Dock(TOP)
    stashInfoText:SetSize(0, EFGM.MenuScale(28))
    surface.SetFont("PuristaBold24")
    local stashValue = 0
    local valueText = "EST. VALUE: ₽" .. comma_value(stashValue)
    local valueTextSize = surface.GetTextSize(valueText)
    stashInfoText.Paint = function(s, w, h)

        surface.SetFont("PuristaBold24")
        valueText = "EST. VALUE: ₽" .. comma_value(stashValue)
        valueTextSize = surface.GetTextSize(valueText)

        BlurPanel(s, EFGM.MenuScale(3))

        surface.SetDrawColor(Color(80, 80, 80, 10))
        surface.DrawRect(0, 0, valueTextSize + EFGM.MenuScale(10), h)

        surface.SetDrawColor(Color(255, 255, 255, 155))
        surface.DrawRect(0, 0, valueTextSize + EFGM.MenuScale(10), EFGM.MenuScale(2))

        draw.SimpleTextOutlined(valueText, "PuristaBold24", EFGM.MenuScale(5), EFGM.MenuScale(2), MenuAlias.whiteColor, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP, 1, MenuAlias.blackColor)

    end

    local stashSearchButton = vgui.Create("DButton", stashHolder)
    stashSearchButton:SetPos(EFGM.MenuScale(15) + valueTextSize, EFGM.MenuScale(1))
    stashSearchButton:SetSize(EFGM.MenuScale(27), EFGM.MenuScale(27))
    stashSearchButton:SetText("")
    stashSearchButton.Paint = function(s, w, h)

        stashSearchButton:SetX(EFGM.MenuScale(15) + valueTextSize)

        BlurPanel(s, EFGM.MenuScale(3))

        surface.SetDrawColor(Color(80, 80, 80, 10))
        surface.DrawRect(0, 0, w, h)

        surface.SetDrawColor(Color(255, 255, 255, 25))
        surface.DrawRect(0, 0, w, EFGM.MenuScale(1))
        surface.DrawRect(0, h - EFGM.MenuScale(1), w, EFGM.MenuScale(1))
        surface.DrawRect(0, 0, EFGM.MenuScale(1), h)
        surface.DrawRect(w - EFGM.MenuScale(1), 0, EFGM.MenuScale(1), h)

    end

    local stashSearchIcon = vgui.Create("DImage", stashSearchButton)
    stashSearchIcon:SetPos(EFGM.MenuScale(1), EFGM.MenuScale(1))
    stashSearchIcon:SetSize(EFGM.MenuScale(25), EFGM.MenuScale(25))
    stashSearchIcon:SetImage("icons/search_icon.png")

    stashSearchButton.OnCursorEntered = function(s)

        surface.PlaySound("ui/element_hover.wav")

    end

    function stashSearchButton:DoClick()

        surface.PlaySound("ui/element_select.wav")

    end

    local stashFilterButton = vgui.Create("DButton", stashHolder)
    stashFilterButton:SetPos(EFGM.MenuScale(32) + stashSearchButton:GetX(), EFGM.MenuScale(1))
    stashFilterButton:SetSize(EFGM.MenuScale(27), EFGM.MenuScale(27))
    stashFilterButton:SetText("")
    stashFilterButton.Paint = function(s, w, h)

        stashFilterButton:SetX(EFGM.MenuScale(32) + stashSearchButton:GetX())

        BlurPanel(s, EFGM.MenuScale(3))

        surface.SetDrawColor(Color(80, 80, 80, 10))
        surface.DrawRect(0, 0, w, h)

        surface.SetDrawColor(Color(255, 255, 255, 25))
        surface.DrawRect(0, 0, w, EFGM.MenuScale(1))
        surface.DrawRect(0, h - EFGM.MenuScale(1), w, EFGM.MenuScale(1))
        surface.DrawRect(0, 0, EFGM.MenuScale(1), h)
        surface.DrawRect(w - EFGM.MenuScale(1), 0, EFGM.MenuScale(1), h)

    end

    local stashFilterIcon = vgui.Create("DImage", stashFilterButton)
    stashFilterIcon:SetPos(EFGM.MenuScale(1), EFGM.MenuScale(1))
    stashFilterIcon:SetSize(EFGM.MenuScale(26), EFGM.MenuScale(26))
    stashFilterIcon:SetImage("icons/filter_icon.png")

    stashFilterButton.OnCursorEntered = function(s)

        surface.PlaySound("ui/element_hover.wav")

    end

    function stashFilterButton:DoClick()

        surface.PlaySound("ui/element_select.wav")

    end

    local stashItemsHolder = vgui.Create("DScrollPanel", stashHolder)
    stashItemsHolder:SetPos(0, EFGM.MenuScale(32))
    stashItemsHolder:SetSize(EFGM.MenuScale(593), EFGM.MenuScale(872))
    function stashItemsHolder:Paint(w, h)

        BlurPanel(stashItemsHolder, EFGM.MenuScale(3))

        surface.SetDrawColor(Color(80, 80, 80, 10))
        surface.DrawRect(0, 0, w, h)

        surface.SetDrawColor(Color(255, 255, 255, 25))
        surface.DrawRect(0, 0, w, EFGM.MenuScale(1))
        surface.DrawRect(0, h - EFGM.MenuScale(1), w, EFGM.MenuScale(1))
        surface.DrawRect(0, 0, EFGM.MenuScale(1), h)
        surface.DrawRect(w - EFGM.MenuScale(1), 0, EFGM.MenuScale(1), h)

    end

    function stashItemsHolder:OnVScroll(offset)

        self.pnlCanvas:SetPos(0, offset)
        if !IsValid(contextMenu) then return end
        contextMenu:AlphaTo(0, 0.1, 0, function() contextMenu:Remove() hook.Remove("Think", "CheckIfContextMenuStillFocused") end)

    end

    stashItemsHolder:Receiver("items", function(self, panels, dropped, _, x, y)

        if !dropped then return end

        if panels[1].ORIGIN == "inventory" then

            surface.PlaySound("ui/element_select.wav")

            StashItemFromInventory(panels[1].ID)

            ReloadInventory()
            ReloadStash()

        end

        if panels[1].ORIGIN == "equipped" then

            surface.PlaySound("ui/element_select.wav")

            StashItemFromEquipped(panels[1].SLOTID, panels[1].SLOT)

            ReloadSlots()
            ReloadStash()

        end

    end)

    local stashItems = vgui.Create("DIconLayout", stashItemsHolder)
    stashItems:Dock(TOP)
    stashItems:SetSpaceY(0)
    stashItems:SetSpaceX(0)

    local stashItemsBar = stashItemsHolder:GetVBar()
    stashItemsBar:SetHideButtons(true)
    stashItemsBar:SetSize(EFGM.MenuScale(15), EFGM.MenuScale(15))
    function stashItemsBar:Paint(w, h)
        draw.RoundedBox(0, EFGM.MenuScale(5), EFGM.MenuScale(8), EFGM.MenuScale(5), h - EFGM.MenuScale(16), Color(0, 0, 0, 50))
    end
    function stashItemsBar.btnGrip:Paint(w, h)
        draw.RoundedBox(0, EFGM.MenuScale(5), EFGM.MenuScale(8), EFGM.MenuScale(5), h - EFGM.MenuScale(16), Color(255, 255, 255, 155))
    end

    local plyStashItems = {}

    function ReloadStash()

        stashValue = 0
        stashItems:Clear()
        plyStashItems = {}

        for k, v in pairs(playerStash) do

            plyStashItems[k] = {}
            plyStashItems[k].name = v.name
            plyStashItems[k].id = k
            plyStashItems[k].data = v.data
            plyStashItems[k].type = v.type

        end

        if table.IsEmpty(plyStashItems) then return end

        table.sort(plyStashItems, function(a, b) return (EFGMITEMS[a.name].sizeX * EFGMITEMS[a.name].sizeY) > (EFGMITEMS[b.name].sizeX * EFGMITEMS[b.name].sizeY) end)

        -- stash item entry
        for k, v in pairs(plyStashItems) do

            local i = EFGMITEMS[v.name]
            if i == nil then return end

            stashValue = stashValue + (i.value * v.data.count)

            local item = stashItems:Add("DButton")
            item:SetSize(EFGM.MenuScale(57 * i.sizeX), EFGM.MenuScale(57 * i.sizeY))
            item:SetText("")
            item:Droppable("items")
            item.ID = v.id
            item.SLOT = i.equipSlot
            item.ORIGIN = "stash"

            if i.equipType == EQUIPTYPE.Weapon then

                if item.SLOT == WEAPONSLOTS.PRIMARY.ID then item:Droppable("slot_primary") end
                if item.SLOT == WEAPONSLOTS.HOLSTER.ID then item:Droppable("slot_holster") end
                if item.SLOT == WEAPONSLOTS.MELEE.ID then item:Droppable("slot_melee") end
                if item.SLOT == WEAPONSLOTS.GRENADE.ID then item:Droppable("slot_grenade") end

                if v.data.att then

                    local atts = GetPrefixedAttachmentListFromCode(v.data.att)
                    if !atts then return end

                    for _, a in ipairs(atts) do

                        local att = EFGMITEMS[a]
                        if att == nil then return end

                        stashValue = stashValue + att.value

                    end

                end

            end

            function item:Paint(w, h)

                surface.SetDrawColor(Color(255, 255, 255, 2))
                surface.DrawRect(0, 0, w, EFGM.MenuScale(1))
                surface.DrawRect(0, h - EFGM.MenuScale(1), w, EFGM.MenuScale(1))
                surface.DrawRect(0, 0, EFGM.MenuScale(1), h)
                surface.DrawRect(w - EFGM.MenuScale(1), 0, EFGM.MenuScale(1), h)

                surface.SetDrawColor(i.iconColor or Color(5, 5, 5, 20))
                surface.DrawRect(0, 0, w, h)

                surface.SetDrawColor(255, 255, 255, 255)
                surface.SetMaterial(i.icon)
                surface.DrawTexturedRect(0, 0, w, h)

            end

            surface.SetFont("Purista18")

            local nameSize = surface.GetTextSize(i.displayName)
            local nameFont

            if nameSize <= (EFGM.MenuScale(49 * i.sizeX)) then nameFont = "PuristaBold18"
            else nameFont = "PuristaBold14" end

            local duraSize = nil
            local duraFont = nil

            if i.equipType == EQUIPTYPE.Consumable then

                duraSize = surface.GetTextSize(i.consumableValue .. "/" .. i.consumableValue)

                if duraSize <= (EFGM.MenuScale(49 * i.sizeX)) then duraFont = "PuristaBold18"
                else duraFont = "PuristaBold14" end

            end

            function item:PaintOver(w, h)

                draw.SimpleTextOutlined(i.displayName, nameFont, w - EFGM.MenuScale(3), EFGM.MenuScale(-1), MenuAlias.whiteColor, TEXT_ALIGN_RIGHT, TEXT_ALIGN_TOP, 1, MenuAlias.blackColor)

                if i.equipType == EQUIPTYPE.Ammunition then
                    draw.SimpleTextOutlined(v.data.count, "PuristaBold18", w - EFGM.MenuScale(3), h - EFGM.MenuScale(1), MenuAlias.whiteColor, TEXT_ALIGN_RIGHT, TEXT_ALIGN_BOTTOM, 1, MenuAlias.blackColor)
                elseif i.equipType == EQUIPTYPE.Consumable then
                    draw.SimpleTextOutlined(v.data.durability .. "/" .. i.consumableValue, duraFont, w - EFGM.MenuScale(3), h - EFGM.MenuScale(1), MenuAlias.whiteColor, TEXT_ALIGN_RIGHT, TEXT_ALIGN_BOTTOM, 1, MenuAlias.blackColor)
                end

            end

            function item:DoClick()

                if input.IsKeyDown(KEY_LSHIFT) then

                    surface.PlaySound("ui/element_select.wav")
                    playerItems:InvalidateLayout()
                    TakeFromStashToInventory(v.id)

                end

                if input.IsKeyDown(KEY_LALT) and (i.equipType == EQUIPTYPE.Weapon) then

                    surface.PlaySound("ui/element_select.wav")
                    stashItems:InvalidateLayout()
                    EquipItemFromStash(v.id, i.equipSlot)

                end

            end

            function item:DoDoubleClick()

                Menu.InspectItem(v.name, v.data)
                surface.PlaySound("ui/element_select.wav")

            end

            function item:DoRightClick()

                local x, y = stashHolder:LocalCursorPos()
                surface.PlaySound("ui/element_hover.wav")

                if x <= (stashHolder:GetWide() / 2) then sideH = true else sideH = false end
                if y <= (stashHolder:GetTall() / 2) then sideV = true else sideV = false end

                if IsValid(contextMenu) then contextMenu:Remove() end
                contextMenu = vgui.Create("DPanel", stashHolder)
                contextMenu:SetSize(EFGM.MenuScale(100), EFGM.MenuScale(60))
                contextMenu:DockPadding(EFGM.MenuScale(5), EFGM.MenuScale(5), EFGM.MenuScale(5), EFGM.MenuScale(5))
                contextMenu:SetAlpha(0)
                contextMenu:AlphaTo(255, 0.1, 0, nil)
                contextMenu:RequestFocus()

                contextMenu.Paint = function(s, w, h)

                    if !IsValid(s) then return end

                    BlurPanel(s, EFGM.MenuScale(5))

                    surface.SetDrawColor(Color(5, 5, 5, 50))
                    surface.DrawRect(0, 0, w, h)

                    surface.SetDrawColor(Color(255, 255, 255, 30))
                    surface.DrawRect(0, 0, w, EFGM.MenuScale(1))
                    surface.DrawRect(0, h - EFGM.MenuScale(1), w, EFGM.MenuScale(1))
                    surface.DrawRect(0, 0, EFGM.MenuScale(1), h)
                    surface.DrawRect(w - EFGM.MenuScale(1), 0, EFGM.MenuScale(1), h)

                    contextMenu:SizeToChildren(true, true)

                end

                hook.Add("Think", "CheckIfContextMenuStillFocused", function()

                    if !IsValid(contextMenu) then hook.Remove("Think", "CheckIfContextMenuStillFocused") return end
                    if (input.IsMouseDown(MOUSE_LEFT) or input.IsMouseDown(MOUSE_RIGHT) or input.IsMouseDown(MOUSE_MIDDLE)) and !contextMenu:IsChildHovered() then contextMenu:KillFocus() hook.Remove("Think", "CheckIfContextMenuStillFocused") end

                end)

                function contextMenu:OnFocusChanged(focus)

                    if !focus then contextMenu:AlphaTo(0, 0.1, 0, function() contextMenu:Remove() hook.Remove("Think", "CheckIfContextMenuStillFocused") end) end

                end

                local itemInspectButton = vgui.Create("DButton", contextMenu)
                itemInspectButton:Dock(TOP)
                itemInspectButton:SetSize(0, EFGM.MenuScale(25))
                itemInspectButton:SetText("INSPECT")

                itemInspectButton.OnCursorEntered = function(s)

                    surface.PlaySound("ui/element_hover.wav")

                end

                function itemInspectButton:DoClick()

                    Menu.InspectItem(v.name, v.data)
                    surface.PlaySound("ui/element_select.wav")
                    contextMenu:KillFocus()

                end

                local itemTakeButton = vgui.Create("DButton", contextMenu)
                itemTakeButton:Dock(TOP)
                itemTakeButton:SetSize(0, EFGM.MenuScale(25))
                itemTakeButton:SetText("TAKE")

                itemTakeButton.OnCursorEntered = function(s)

                    surface.PlaySound("ui/element_hover.wav")

                end

                function itemTakeButton:DoClick()

                    surface.PlaySound("ui/element_select.wav")
                    TakeFromStashToInventory(v.id)
                    contextMenu:Remove()
                    stashItems:InvalidateLayout()

                end

                -- actions that can be performed on this specific item
                -- default
                local actions = {
                    equipable = false,
                    consumable = false,
                    splittable = false
                }

                actions.equipable = i.equipType == EQUIPTYPE.Weapon
                actions.splittable = i.stackSize > 1 and v.data.count > 1
                actions.consumable = i.equipType == EQUIPTYPE.Consumable

                if actions.equipable then

                    contextMenu:SetTall(contextMenu:GetTall() + EFGM.MenuScale(25))

                    local itemEquipButton = vgui.Create("DButton", contextMenu)
                    itemEquipButton:Dock(TOP)
                    itemEquipButton:SetSize(0, EFGM.MenuScale(25))
                    itemEquipButton:SetText("EQUIP")

                    itemEquipButton.OnCursorEntered = function(s)

                        surface.PlaySound("ui/element_hover.wav")

                    end

                    function itemEquipButton:DoClick()

                        surface.PlaySound("ui/element_select.wav")
                        EquipItemFromStash(v.id, i.equipSlot)
                        contextMenu:Remove()
                        stashItems:InvalidateLayout()

                    end

                end

                if actions.consumable then

                    contextMenu:SetTall(contextMenu:GetTall() + EFGM.MenuScale(25))

                    local itemConsumeButton = vgui.Create("DButton", contextMenu)
                    itemConsumeButton:Dock(TOP)
                    itemConsumeButton:SetSize(0, EFGM.MenuScale(25))
                    itemConsumeButton:SetText("USE")

                    itemConsumeButton.OnCursorEntered = function(s)

                        surface.PlaySound("ui/element_hover.wav")

                    end

                    function itemConsumeButton:DoClick()

                        surface.PlaySound("ui/element_select.wav")
                        -- ConsumeItemFromInventory(v.id)
                        contextMenu:Remove()
                        stashItems:InvalidateLayout()

                    end

                end

                if actions.splittable then

                    contextMenu:SetTall(contextMenu:GetTall() + EFGM.MenuScale(25))

                    local itemSplitButton = vgui.Create("DButton", contextMenu)
                    itemSplitButton:Dock(TOP)
                    itemSplitButton:SetSize(0, EFGM.MenuScale(25))
                    itemSplitButton:SetText("SPLIT")

                    itemSplitButton.OnCursorEntered = function(s)

                        surface.PlaySound("ui/element_hover.wav")

                    end

                    function itemSplitButton:DoClick()

                        Menu.ConfirmSplit(v.name, v.data, v.id, "stash")
                        contextMenu:Remove()
                        stashItems:InvalidateLayout()

                    end

                end

                if sideH == true then

                    contextMenu:SetX(math.Clamp(x + EFGM.MenuScale(5), EFGM.MenuScale(5), stashHolder:GetWide() - contextMenu:GetWide() - EFGM.MenuScale(5)))

                else

                    contextMenu:SetX(math.Clamp(x - contextMenu:GetWide() - EFGM.MenuScale(5), EFGM.MenuScale(5), stashHolder:GetWide() - contextMenu:GetWide() - EFGM.MenuScale(5)))

                end

                if sideV == true then

                    contextMenu:SetY(math.Clamp(y + EFGM.MenuScale(5), EFGM.MenuScale(5), stashHolder:GetTall() - contextMenu:GetTall() - EFGM.MenuScale(5)))

                else

                    contextMenu:SetY(math.Clamp(y - contextMenu:GetTall() + EFGM.MenuScale(5), EFGM.MenuScale(5), stashHolder:GetTall() - contextMenu:GetTall() - EFGM.MenuScale(5)))

                end

            end

        end

        stashItems:InvalidateLayout()

    end

    ReloadStash()

end

function Menu.OpenTab.Market()

    local contents = vgui.Create("DPanel", Menu.MenuFrame.LowerPanel)
    contents:Dock(FILL)
    contents:DockPadding(EFGM.MenuScale(10), EFGM.MenuScale(10), EFGM.MenuScale(10), EFGM.MenuScale(10))
    contents:SetAlpha(0)
    contents.Paint = function(s, w, h)

        surface.SetDrawColor(MenuAlias.transparent)
        surface.DrawRect(0, 0, w, h)

    end

    Menu.MenuFrame.LowerPanel.Contents = contents

    local stashPanel = vgui.Create("DPanel", contents)
    stashPanel:Dock(LEFT)
    stashPanel:DockMargin(EFGM.MenuScale(13), 0, 0, 0)
    stashPanel:SetSize(EFGM.MenuScale(613), 0)
    stashPanel.Paint = function(s, w, h)

        BlurPanel(s, EFGM.MenuScale(10))

        surface.SetDrawColor(Color(80, 80, 80, 10))
        surface.DrawRect(0, 0, w, h)

        surface.SetDrawColor(Color(255, 255, 255, 155))
        surface.DrawRect(0, 0, w, EFGM.MenuScale(6))

    end

    local maxStash = 150
    local stashText = vgui.Create("DPanel", stashPanel)
    stashText:Dock(TOP)
    stashText:SetSize(0, EFGM.MenuScale(36))
    function stashText:Paint(w, h)

        surface.SetDrawColor(Color(155, 155, 155, 10))
        surface.DrawRect(0, 0, w, h)

        draw.SimpleTextOutlined("STASH", "PuristaBold32", EFGM.MenuScale(5), EFGM.MenuScale(2), MenuAlias.whiteColor, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP, 1, MenuAlias.blackColor)
        draw.SimpleTextOutlined(Menu.Player:GetNWInt("StashCount", 0) .. "/" .. maxStash, "PuristaBold18", EFGM.MenuScale(95), EFGM.MenuScale(13), MenuAlias.whiteColor, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP, 1, MenuAlias.blackColor)

    end

    local stashHolder = vgui.Create("DPanel", stashPanel)
    stashHolder:Dock(FILL)
    stashHolder:DockMargin(EFGM.MenuScale(10), EFGM.MenuScale(10), EFGM.MenuScale(10), EFGM.MenuScale(9))
    stashHolder:SetSize(0, 0)
    stashHolder.Paint = function(s, w, h)

        surface.SetDrawColor(Color(0, 0, 0, 0))
        surface.DrawRect(0, 0, w, h)

    end

    local stashInfoText = vgui.Create("DPanel", stashHolder)
    stashInfoText:Dock(TOP)
    stashInfoText:SetSize(0, EFGM.MenuScale(28))
    surface.SetFont("PuristaBold24")
    local stashValue = 0
    local valueText = "EST. VALUE: ₽" .. comma_value(stashValue)
    local valueTextSize = surface.GetTextSize(valueText)
    stashInfoText.Paint = function(s, w, h)

        surface.SetFont("PuristaBold24")
        valueText = "EST. VALUE: ₽" .. comma_value(stashValue)
        valueTextSize = surface.GetTextSize(valueText)

        BlurPanel(s, EFGM.MenuScale(3))

        surface.SetDrawColor(Color(80, 80, 80, 10))
        surface.DrawRect(0, 0, valueTextSize + EFGM.MenuScale(10), h)

        surface.SetDrawColor(Color(255, 255, 255, 155))
        surface.DrawRect(0, 0, valueTextSize + EFGM.MenuScale(10), EFGM.MenuScale(2))

        draw.SimpleTextOutlined(valueText, "PuristaBold24", EFGM.MenuScale(5), EFGM.MenuScale(2), MenuAlias.whiteColor, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP, 1, MenuAlias.blackColor)

    end

    local stashSearchButton = vgui.Create("DButton", stashHolder)
    stashSearchButton:SetPos(EFGM.MenuScale(15) + valueTextSize, EFGM.MenuScale(1))
    stashSearchButton:SetSize(EFGM.MenuScale(27), EFGM.MenuScale(27))
    stashSearchButton:SetText("")
    stashSearchButton.Paint = function(s, w, h)

        stashSearchButton:SetX(EFGM.MenuScale(15) + valueTextSize)

        BlurPanel(s, EFGM.MenuScale(3))

        surface.SetDrawColor(Color(80, 80, 80, 10))
        surface.DrawRect(0, 0, w, h)

        surface.SetDrawColor(Color(255, 255, 255, 25))
        surface.DrawRect(0, 0, w, EFGM.MenuScale(1))
        surface.DrawRect(0, h - EFGM.MenuScale(1), w, EFGM.MenuScale(1))
        surface.DrawRect(0, 0, EFGM.MenuScale(1), h)
        surface.DrawRect(w - EFGM.MenuScale(1), 0, EFGM.MenuScale(1), h)

    end

    local stashSearchIcon = vgui.Create("DImage", stashSearchButton)
    stashSearchIcon:SetPos(EFGM.MenuScale(1), EFGM.MenuScale(1))
    stashSearchIcon:SetSize(EFGM.MenuScale(25), EFGM.MenuScale(25))
    stashSearchIcon:SetImage("icons/search_icon.png")

    stashSearchButton.OnCursorEntered = function(s)

        surface.PlaySound("ui/element_hover.wav")

    end

    function stashSearchButton:DoClick()

        surface.PlaySound("ui/element_select.wav")

    end

    local stashFilterButton = vgui.Create("DButton", stashHolder)
    stashFilterButton:SetPos(EFGM.MenuScale(32) + stashSearchButton:GetX(), EFGM.MenuScale(1))
    stashFilterButton:SetSize(EFGM.MenuScale(27), EFGM.MenuScale(27))
    stashFilterButton:SetText("")
    stashFilterButton.Paint = function(s, w, h)

        stashFilterButton:SetX(EFGM.MenuScale(32) + stashSearchButton:GetX())

        BlurPanel(s, EFGM.MenuScale(3))

        surface.SetDrawColor(Color(80, 80, 80, 10))
        surface.DrawRect(0, 0, w, h)

        surface.SetDrawColor(Color(255, 255, 255, 25))
        surface.DrawRect(0, 0, w, EFGM.MenuScale(1))
        surface.DrawRect(0, h - EFGM.MenuScale(1), w, EFGM.MenuScale(1))
        surface.DrawRect(0, 0, EFGM.MenuScale(1), h)
        surface.DrawRect(w - EFGM.MenuScale(1), 0, EFGM.MenuScale(1), h)

    end

    local stashFilterIcon = vgui.Create("DImage", stashFilterButton)
    stashFilterIcon:SetPos(EFGM.MenuScale(1), EFGM.MenuScale(1))
    stashFilterIcon:SetSize(EFGM.MenuScale(26), EFGM.MenuScale(26))
    stashFilterIcon:SetImage("icons/filter_icon.png")

    stashFilterButton.OnCursorEntered = function(s)

        surface.PlaySound("ui/element_hover.wav")

    end

    function stashFilterButton:DoClick()

        surface.PlaySound("ui/element_select.wav")

    end

    local stashItemsHolder = vgui.Create("DScrollPanel", stashHolder)
    stashItemsHolder:SetPos(0, EFGM.MenuScale(32))
    stashItemsHolder:SetSize(EFGM.MenuScale(593), EFGM.MenuScale(872))
    function stashItemsHolder:Paint(w, h)

        BlurPanel(stashItemsHolder, EFGM.MenuScale(3))

        surface.SetDrawColor(Color(80, 80, 80, 10))
        surface.DrawRect(0, 0, w, h)

        surface.SetDrawColor(Color(255, 255, 255, 25))
        surface.DrawRect(0, 0, w, EFGM.MenuScale(1))
        surface.DrawRect(0, h - EFGM.MenuScale(1), w, EFGM.MenuScale(1))
        surface.DrawRect(0, 0, EFGM.MenuScale(1), h)
        surface.DrawRect(w - EFGM.MenuScale(1), 0, EFGM.MenuScale(1), h)

    end

    function stashItemsHolder:OnVScroll(offset)

        self.pnlCanvas:SetPos(0, offset)
        if !IsValid(contextMenu) then return end
        contextMenu:AlphaTo(0, 0.1, 0, function() contextMenu:Remove() hook.Remove("Think", "CheckIfContextMenuStillFocused") end)

    end

    local stashItems = vgui.Create("DIconLayout", stashItemsHolder)
    stashItems:Dock(TOP)
    stashItems:SetSpaceY(0)
    stashItems:SetSpaceX(0)

    local stashItemsBar = stashItemsHolder:GetVBar()
    stashItemsBar:SetHideButtons(true)
    stashItemsBar:SetSize(EFGM.MenuScale(15), EFGM.MenuScale(15))
    function stashItemsBar:Paint(w, h)
        draw.RoundedBox(0, EFGM.MenuScale(5), EFGM.MenuScale(8), EFGM.MenuScale(5), h - EFGM.MenuScale(16), Color(0, 0, 0, 50))
    end
    function stashItemsBar.btnGrip:Paint(w, h)
        draw.RoundedBox(0, EFGM.MenuScale(5), EFGM.MenuScale(8), EFGM.MenuScale(5), h - EFGM.MenuScale(16), Color(255, 255, 255, 155))
    end

    local plyStashItems = {}

    function ReloadStash()

        if !IsValid(stashItems) then return end

        stashValue = 0
        stashItems:Clear()
        plyStashItems = {}

        for k, v in pairs(playerStash) do

            plyStashItems[k] = {}
            plyStashItems[k].name = v.name
            plyStashItems[k].id = k
            plyStashItems[k].data = v.data
            plyStashItems[k].type = v.type

        end

        if table.IsEmpty(plyStashItems) then return end

        table.sort(plyStashItems, function(a, b) return (EFGMITEMS[a.name].sizeX * EFGMITEMS[a.name].sizeY) > (EFGMITEMS[b.name].sizeX * EFGMITEMS[b.name].sizeY) end)

        -- stash item entry
        for k, v in pairs(plyStashItems) do

            local i = EFGMITEMS[v.name]
            if i == nil then return end

            stashValue = stashValue + i.value * v.data.count
            local itemValue = math.floor(i.value * sellMultiplier) * v.data.count

            local item = stashItems:Add("DButton")
            item:SetSize(EFGM.MenuScale(57 * i.sizeX), EFGM.MenuScale(57 * i.sizeY))
            item:SetText("")
            item:Droppable("items")
            item.ID = v.id
            item.SLOT = i.equipSlot
            item.ORIGIN = "stash"

            if i.equipType == EQUIPTYPE.Weapon then

                if item.SLOT == WEAPONSLOTS.PRIMARY.ID then item:Droppable("slot_primary") end
                if item.SLOT == WEAPONSLOTS.HOLSTER.ID then item:Droppable("slot_holster") end
                if item.SLOT == WEAPONSLOTS.MELEE.ID then item:Droppable("slot_melee") end
                if item.SLOT == WEAPONSLOTS.GRENADE.ID then item:Droppable("slot_grenade") end

                if v.data.att then

                    local atts = GetPrefixedAttachmentListFromCode(v.data.att)
                    if !atts then return end

                    for _, a in ipairs(atts) do

                        local att = EFGMITEMS[a]
                        if att == nil then return end

                        stashValue = stashValue + att.value
                        itemValue = itemValue + math.floor(att.value * sellMultiplier)

                    end

                end

            end

            function item:Paint(w, h)

                surface.SetDrawColor(Color(255, 255, 255, 2))
                surface.DrawRect(0, 0, w, EFGM.MenuScale(1))
                surface.DrawRect(0, h - EFGM.MenuScale(1), w, EFGM.MenuScale(1))
                surface.DrawRect(0, 0, EFGM.MenuScale(1), h)
                surface.DrawRect(w - EFGM.MenuScale(1), 0, EFGM.MenuScale(1), h)

                surface.SetDrawColor(i.iconColor or Color(5, 5, 5, 20))
                surface.DrawRect(0, 0, w, h)

                surface.SetDrawColor(255, 255, 255, 255)
                surface.SetMaterial(i.icon)
                surface.DrawTexturedRect(0, 0, w, h)

            end

            surface.SetFont("Purista18")

            local nameSize = surface.GetTextSize(i.displayName)
            local nameFont

            if nameSize <= (EFGM.MenuScale(49 * i.sizeX)) then nameFont = "PuristaBold18"
            else nameFont = "PuristaBold14" end

            local duraSize = nil
            local duraFont = nil

            if i.equipType == EQUIPTYPE.Consumable then

                duraSize = surface.GetTextSize(i.consumableValue .. "/" .. i.consumableValue)

                if duraSize <= (EFGM.MenuScale(49 * i.sizeX)) then duraFont = "PuristaBold18"
                else duraFont = "PuristaBold14" end

            end

            function item:PaintOver(w, h)

                draw.SimpleTextOutlined(i.displayName, nameFont, w - EFGM.MenuScale(3), EFGM.MenuScale(-1), MenuAlias.whiteColor, TEXT_ALIGN_RIGHT, TEXT_ALIGN_TOP, 1, MenuAlias.blackColor)

                if i.equipType == EQUIPTYPE.Ammunition then
                    draw.SimpleTextOutlined(v.data.count, "PuristaBold18", w - EFGM.MenuScale(3), h - EFGM.MenuScale(1), MenuAlias.whiteColor, TEXT_ALIGN_RIGHT, TEXT_ALIGN_BOTTOM, 1, MenuAlias.blackColor)
                elseif i.equipType == EQUIPTYPE.Consumable then
                    draw.SimpleTextOutlined(v.data.durability .. "/" .. i.consumableValue, duraFont, w - EFGM.MenuScale(3), h - EFGM.MenuScale(1), MenuAlias.whiteColor, TEXT_ALIGN_RIGHT, TEXT_ALIGN_BOTTOM, 1, MenuAlias.blackColor)
                end

                if i.sizeX > 1 then draw.SimpleTextOutlined("₽" .. itemValue, "PuristaBold18", w / 2, h / 2, MenuAlias.whiteColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1, MenuAlias.blackColor)
                else draw.SimpleTextOutlined("₽" .. itemValue, "PuristaBold14", w / 2, h / 2, MenuAlias.whiteColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1, MenuAlias.blackColor) end

            end

            function item:DoClick()

                Menu.ConfirmSell(v.name, v.data, v.id)

            end

            function item:DoRightClick()

                local x, y = stashHolder:LocalCursorPos()
                surface.PlaySound("ui/element_hover.wav")

                if x <= (stashHolder:GetWide() / 2) then sideH = true else sideH = false end
                if y <= (stashHolder:GetTall() / 2) then sideV = true else sideV = false end

                if IsValid(contextMenu) then contextMenu:Remove() end
                contextMenu = vgui.Create("DPanel", stashHolder)
                contextMenu:SetSize(EFGM.MenuScale(100), EFGM.MenuScale(60))
                contextMenu:DockPadding(EFGM.MenuScale(5), EFGM.MenuScale(5), EFGM.MenuScale(5), EFGM.MenuScale(5))
                contextMenu:SetAlpha(0)
                contextMenu:AlphaTo(255, 0.1, 0, nil)
                contextMenu:RequestFocus()

                contextMenu.Paint = function(s, w, h)

                    if !IsValid(s) then return end

                    BlurPanel(s, EFGM.MenuScale(5))

                    surface.SetDrawColor(Color(5, 5, 5, 50))
                    surface.DrawRect(0, 0, w, h)

                    surface.SetDrawColor(Color(255, 255, 255, 30))
                    surface.DrawRect(0, 0, w, EFGM.MenuScale(1))
                    surface.DrawRect(0, h - EFGM.MenuScale(1), w, EFGM.MenuScale(1))
                    surface.DrawRect(0, 0, EFGM.MenuScale(1), h)
                    surface.DrawRect(w - EFGM.MenuScale(1), 0, EFGM.MenuScale(1), h)

                    contextMenu:SizeToChildren(true, true)

                end

                hook.Add("Think", "CheckIfContextMenuStillFocused", function()

                    if !IsValid(contextMenu) then hook.Remove("Think", "CheckIfContextMenuStillFocused") return end
                    if (input.IsMouseDown(MOUSE_LEFT) or input.IsMouseDown(MOUSE_RIGHT) or input.IsMouseDown(MOUSE_MIDDLE)) and !contextMenu:IsChildHovered() then contextMenu:KillFocus() hook.Remove("Think", "CheckIfContextMenuStillFocused") end

                end)

                function contextMenu:OnFocusChanged(focus)

                    if !focus then contextMenu:AlphaTo(0, 0.1, 0, function() contextMenu:Remove() hook.Remove("Think", "CheckIfContextMenuStillFocused") end) end

                end

                local itemInspectButton = vgui.Create("DButton", contextMenu)
                itemInspectButton:Dock(TOP)
                itemInspectButton:SetSize(0, EFGM.MenuScale(25))
                itemInspectButton:SetText("INSPECT")

                itemInspectButton.OnCursorEntered = function(s)

                    surface.PlaySound("ui/element_hover.wav")

                end

                function itemInspectButton:DoClick()

                    Menu.InspectItem(v.name, v.data)
                    surface.PlaySound("ui/element_select.wav")
                    contextMenu:KillFocus()

                end

                local itemSellButton = vgui.Create("DButton", contextMenu)
                itemSellButton:Dock(TOP)
                itemSellButton:SetSize(0, EFGM.MenuScale(25))
                itemSellButton:SetText("SELL")

                itemSellButton.OnCursorEntered = function(s)

                    surface.PlaySound("ui/element_hover.wav")

                end

                function itemSellButton:DoClick()

                    Menu.ConfirmSell(v.name, v.data, v.id)
                    contextMenu:KillFocus()

                end

                if sideH == true then

                    contextMenu:SetX(math.Clamp(x + EFGM.MenuScale(5), EFGM.MenuScale(5), stashHolder:GetWide() - contextMenu:GetWide() - EFGM.MenuScale(5)))

                else

                    contextMenu:SetX(math.Clamp(x - contextMenu:GetWide() - EFGM.MenuScale(5), EFGM.MenuScale(5), stashHolder:GetWide() - contextMenu:GetWide() - EFGM.MenuScale(5)))

                end

                if sideV == true then

                    contextMenu:SetY(math.Clamp(y + EFGM.MenuScale(5), EFGM.MenuScale(5), stashHolder:GetTall() - contextMenu:GetTall() - EFGM.MenuScale(5)))

                else

                    contextMenu:SetY(math.Clamp(y - contextMenu:GetTall() + EFGM.MenuScale(5), EFGM.MenuScale(5), stashHolder:GetTall() - contextMenu:GetTall() - EFGM.MenuScale(5)))

                end

            end

        end

        stashItems:InvalidateLayout()

    end

    ReloadStash()

    local marketPanel = vgui.Create("DPanel", contents)
    marketPanel:Dock(LEFT)
    marketPanel:DockMargin(EFGM.MenuScale(13), 0, 0, 0)
    marketPanel:SetSize(EFGM.MenuScale(1239), 0)
    marketPanel.Paint = function(s, w, h)

        BlurPanel(s, EFGM.MenuScale(10))

        surface.SetDrawColor(Color(80, 80, 80, 10))
        surface.DrawRect(0, 0, w, h)

        surface.SetDrawColor(Color(255, 255, 255, 155))
        surface.DrawRect(0, 0, w, EFGM.MenuScale(6))

    end

    local marketText = vgui.Create("DPanel", marketPanel)
    marketText:Dock(TOP)
    marketText:SetSize(0, EFGM.MenuScale(36))
    function marketText:Paint(w, h)

        surface.SetDrawColor(Color(155, 155, 155, 10))
        surface.DrawRect(0, 0, w, h)

        draw.SimpleTextOutlined("MARKET", "PuristaBold32", EFGM.MenuScale(5), EFGM.MenuScale(2), MenuAlias.whiteColor, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP, 1, MenuAlias.blackColor)

    end

    local marketHolder = vgui.Create("DPanel", marketPanel)
    marketHolder:Dock(FILL)
    marketHolder:DockMargin(EFGM.MenuScale(10), EFGM.MenuScale(10), EFGM.MenuScale(10), EFGM.MenuScale(9))
    marketHolder:SetSize(0, 0)
    marketHolder.Paint = function(s, w, h)

        surface.SetDrawColor(Color(0, 0, 0, 0))
        surface.DrawRect(0, 0, w, h)

    end

    local marketPageText = vgui.Create("DPanel", marketHolder)
    marketPageText:Dock(TOP)
    marketPageText:SetSize(0, EFGM.MenuScale(28))
    local currentPage = 1
    local totalPages = 1
    local pageTextSize = 0
    marketPageText.Paint = function(s, w, h)

        surface.SetFont("PuristaBold24")
        local pageText = "PAGE " .. currentPage .. "/" .. totalPages
        pageTextSize = surface.GetTextSize(pageText)

        BlurPanel(s, EFGM.MenuScale(3))

        surface.SetDrawColor(Color(80, 80, 80, 10))
        surface.DrawRect(0, 0, pageTextSize + EFGM.MenuScale(54), h)

        surface.SetDrawColor(Color(255, 255, 255, 155))
        surface.DrawRect(0, 0, pageTextSize + EFGM.MenuScale(54), EFGM.MenuScale(2))

        draw.SimpleTextOutlined(pageText, "PuristaBold24", EFGM.MenuScale(26), EFGM.MenuScale(2), MenuAlias.whiteColor, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP, 1, MenuAlias.blackColor)

    end

    local lastPageIcon = Material("icons/arrow_back_icon.png")
    local lastPageButton = vgui.Create("DButton", marketPageText)
    lastPageButton:SetPos(EFGM.MenuScale(0), EFGM.MenuScale(2))
    lastPageButton:SetSize(EFGM.MenuScale(26), EFGM.MenuScale(26))
    lastPageButton:SetText("")
    lastPageButton.Paint = function(s, w, h)

        surface.SetDrawColor(255, 255, 255, 255)
        surface.SetMaterial(lastPageIcon)
        surface.DrawTexturedRect(EFGM.MenuScale(3), EFGM.MenuScale(3), EFGM.MenuScale(20), EFGM.MenuScale(20))

    end

    lastPageButton.OnCursorEntered = function(s)

        surface.PlaySound("ui/element_hover.wav")

    end

    local nextPageIcon = Material("icons/arrow_forward_icon.png")
    local nextPageButton = vgui.Create("DButton", marketPageText)
    nextPageButton:SetPos(pageTextSize + EFGM.MenuScale(29), EFGM.MenuScale(2))
    nextPageButton:SetSize(EFGM.MenuScale(26), EFGM.MenuScale(26))
    nextPageButton:SetText("")
    nextPageButton.Paint = function(s, w, h)

        s:SetX(pageTextSize + EFGM.MenuScale(29))
        surface.SetDrawColor(255, 255, 255, 255)
        surface.SetMaterial(nextPageIcon)
        surface.DrawTexturedRect(EFGM.MenuScale(3), EFGM.MenuScale(3), EFGM.MenuScale(20), EFGM.MenuScale(20))

    end

    nextPageButton.OnCursorEntered = function(s)

        surface.PlaySound("ui/element_hover.wav")

    end

    local marketEntryHolder = vgui.Create("DPanel", marketHolder)
    marketEntryHolder:SetPos(0, EFGM.MenuScale(32))
    marketEntryHolder:SetSize(EFGM.MenuScale(1219), EFGM.MenuScale(872))
    function marketEntryHolder:Paint(w, h)

        BlurPanel(marketEntryHolder, EFGM.MenuScale(3))

        surface.SetDrawColor(Color(80, 80, 80, 10))
        surface.DrawRect(0, 0, w, h)

        surface.SetDrawColor(Color(255, 255, 255, 25))
        surface.DrawRect(0, 0, w, EFGM.MenuScale(1))
        surface.DrawRect(0, h - EFGM.MenuScale(1), w, EFGM.MenuScale(1))
        surface.DrawRect(0, 0, EFGM.MenuScale(1), h)
        surface.DrawRect(w - EFGM.MenuScale(1), 0, EFGM.MenuScale(1), h)

    end

    local marketTab = "Weapons"
    local marketSearchText = ""

    local marketCategoryHolder = vgui.Create("DPanel", marketEntryHolder)
    marketCategoryHolder:SetPos(0, 0)
    marketCategoryHolder:SetSize(EFGM.MenuScale(216), EFGM.MenuScale(872))
    marketCategoryHolder:DockPadding(EFGM.MenuScale(5), EFGM.MenuScale(5), EFGM.MenuScale(5), EFGM.MenuScale(5))

    function marketCategoryHolder:Paint(w, h)

        surface.SetDrawColor(Color(80, 80, 80, 10))
        surface.DrawRect(0, 0, w, h)

        surface.SetDrawColor(Color(255, 255, 255, 25))
        surface.DrawRect(w - EFGM.MenuScale(1), 0, EFGM.MenuScale(1), h)

    end

    local marketSearchBox = vgui.Create("DTextEntry", marketCategoryHolder)
    marketSearchBox:Dock(TOP)
    marketSearchBox:DockMargin(0, 0, 0, EFGM.MenuScale(5))
    marketSearchBox:SetPlaceholderText("search for items...")
    marketSearchBox:SetUpdateOnType(true)
    marketSearchBox:SetTextColor(MenuAlias.whiteColor)
    marketSearchBox:SetCursorColor(MenuAlias.whiteColor)

    local sortBy = "name"
    local marketSortByButton = vgui.Create("DButton", marketCategoryHolder)
    marketSortByButton:Dock(TOP)
    marketSortByButton:SetSize(0, EFGM.MenuScale(20))
    marketSortByButton:DockMargin(0, 0, 0, EFGM.MenuScale(5))
    marketSortByButton:SetText("SORT BY NAME")

    marketSortByButton.OnCursorEntered = function(s)

        surface.PlaySound("ui/element_hover.wav")

    end

    local sortWith = "ascending"
    local marketSortWithButton = vgui.Create("DButton", marketCategoryHolder)
    marketSortWithButton:Dock(TOP)
    marketSortWithButton:SetSize(0, EFGM.MenuScale(20))
    marketSortWithButton:DockMargin(0, 0, 0, EFGM.MenuScale(5))
    marketSortWithButton:SetText("ASCENDING ORDER")

    marketSortWithButton.OnCursorEntered = function(s)

        surface.PlaySound("ui/element_hover.wav")

    end

    local showBasedOnLevel = "all"
    local marketShowUnlockButton = vgui.Create("DButton", marketCategoryHolder)
    marketShowUnlockButton:Dock(TOP)
    marketShowUnlockButton:SetSize(0, EFGM.MenuScale(20))
    marketShowUnlockButton:DockMargin(0, 0, 0, EFGM.MenuScale(5))
    marketShowUnlockButton:SetText("SHOW EVERYTHING")

    marketShowUnlockButton.OnCursorEntered = function(s)

        surface.PlaySound("ui/element_hover.wav")

    end

    local marketCategoryEntryList = vgui.Create("DCategoryList", marketCategoryHolder)
    marketCategoryEntryList:Dock(FILL)
    marketCategoryEntryList:SetBackgroundColor(Color(0, 0, 0, 0))
    marketCategoryEntryList:GetVBar():SetSize(0, 0)

    local categoryBar = marketCategoryEntryList:GetVBar()
    categoryBar:SetHideButtons(true)
    categoryBar:SetSize(EFGM.MenuScale(15), EFGM.MenuScale(15))
    function categoryBar:Paint(w, h)
        draw.RoundedBox(0, EFGM.MenuScale(5), EFGM.MenuScale(8), EFGM.MenuScale(5), h - EFGM.MenuScale(16), Color(0, 0, 0, 50))
    end
    function categoryBar.btnGrip:Paint(w, h)
        draw.RoundedBox(0, EFGM.MenuScale(5), EFGM.MenuScale(8), EFGM.MenuScale(5), h - EFGM.MenuScale(16), Color(255, 255, 255, 155))
    end

    -- market categories
    -- will load items based on the items "displayType" in it's item def.
    MarketCat = {}

    MarketCat.ALLITEMS = {

        name = "All Items",
        items = {"Assault Carbine", "Assault Rifle", "Light Machine Gun", "Pistol", "Shotgun", "Sniper Rifle", "Marksman Rifle", "Submachine Gun", "Launcher", "Melee", "Grenade", "Special", "Ammunition", "Accessory", "Barrel", "Cover", "Foregrip", "Gas Block", "Handguard", "Magazine", "Mount", "Muzzle", "Optic", "Pistol Grip", "Receiver", "Sight", "Stock", "Tactical", "Medical", "Belmont Key", "Concrete Key", "Customs Key", "Factory Key", "Barter", "Building", "Electronic", "Energy", "Flammable", "Household", "Information", "Medicine", "Other", "Tool", "Valuable"},

        children = {}

    }

    MarketCat.WEAPONS = {

        name = "Weapons",
        items = {"Assault Carbine", "Assault Rifle", "Light Machine Gun", "Pistol", "Shotgun", "Sniper Rifle", "Marksman Rifle", "Submachine Gun", "Launcher", "Melee", "Grenade", "Special"},

        children = {

            ["Assault Carbines"] = "Assault Carbine",
            ["Assault Rifles"] = "Assault Rifle",
            ["Light Machine Guns"] = "Light Machine Gun",
            ["Pistols"] = "Pistol",
            ["Shotguns"] = "Shotgun",
            ["Sniper Rifles"] = "Sniper Rifle",
            ["Marksman Rifles"] = "Marksman Rifle",
            ["Submachine Guns"] = "Submachine Gun",
            ["Launchers"] = "Launcher",
            ["Melee"] = "Melee",
            ["Grenades"] = "Grenade",
            ["Specials"] = "Special"

        }

    }

    MarketCat.AMMUNITION = {

        name = "Ammunition",
        items = {"Ammunition"},

        children = {}

    }

    MarketCat.ATTACHMENTS = {

        name = "Attachments",
        items = {"Accessory", "Barrel", "Cover", "Foregrip", "Gas Block", "Handguard", "Magazine", "Mount", "Muzzle", "Optic", "Pistol Grip", "Receiver", "Sight", "Stock", "Tactical"},

        children = {

            ["Accessories"] = "Accessory",
            ["Barrels"] = "Barrel",
            ["Dust Covers"] = "Cover",
            ["Foregrips"] = "Foregrip",
            ["Gas Blocks"] = "Gas Block",
            ["Handguards"] = "Handguard",
            ["Magazines"] = "Magazine",
            ["Mounts"] = "Mount",
            ["Muzzles"] = "Muzzle",
            ["Optics"] = "Optic",
            ["Pistol Grips"] = "Pistol Grip",
            ["Receivers"] = "Receiver",
            ["Sights"] = "Sight",
            ["Stocks"] = "Stock",
            ["Tacticals"] = "Tactical"

        }

    }

    MarketCat.MEDICAL = {

        name = "Medical",
        items = {"Medical"},

        children = {}

    }

    MarketCat.KEYS = {

        name = "Keys",
        items = {"Belmont Key", "Concrete Key", "Customs Key", "Factory Key"},

        children = {

            ["Belmont"] = "Belmont Key",
            ["Concrete"] = "Concrete Key",
            ["Customs"] = "Customs Key",
            ["Factory"] = "Factory Key",

        }

    }

    MarketCat.BARTER = {

        name = "Barter",
        items = {"Barter", "Building", "Electronic", "Energy", "Flammable", "Household", "Information", "Medicine", "Other", "Tool", "Valuable"},

        children = {

            ["Building"] = "Building",
            ["Electronics"] = "Electronic",
            ["Energy"] = "Energy",
            ["Flammables"] = "Flammable",
            ["Household"] = "Household",
            ["Information"] = "Information",
            ["Medicine"] = "Medicine",
            ["Others"] = "Other",
            ["Tools"] = "Tool",
            ["Valuables"] = "Valuable"

        }

    }

    MarketCat.MISCELLANEOUS = {

        name = "Miscellaneous",
        items = {},

        children = {}

    }

    local marketTbl = {}

    local marketItemHolder = vgui.Create("DPanel", marketEntryHolder)
    marketItemHolder:SetPos(EFGM.MenuScale(216), 0)
    marketItemHolder:SetSize(EFGM.MenuScale(1003), EFGM.MenuScale(872))
    marketItemHolder:DockPadding(EFGM.MenuScale(5), EFGM.MenuScale(5), EFGM.MenuScale(5), EFGM.MenuScale(5))
    function marketItemHolder:Paint(w, h)

        surface.SetDrawColor(Color(0, 0, 0, 0))
        surface.DrawRect(0, 0, w, h)

    end

    local marketItems = vgui.Create("DIconLayout", marketItemHolder)
    marketItems:Dock(FILL)
    marketItems:SetSpaceY(0)
    marketItems:SetSpaceX(0)

    local function ReloadMarket()

        marketItems:Clear()

        for k, v in pairs(marketTbl) do

            if k >= ((currentPage * 20) - 19) and k <= (currentPage * 20) then

                local item = marketItems:Add("DButton")
                item:SetText("")
                item:SetSize(EFGM.MenuScale(198), EFGM.MenuScale(216))

                function item:Paint(w, h)

                    surface.SetDrawColor(Color(5, 5, 5, 20))
                    surface.DrawRect(0, 0, w, h)

                    surface.SetDrawColor(Color(255, 255, 255, 2))
                    surface.DrawRect(0, 0, w, EFGM.MenuScale(1))
                    surface.DrawRect(0, h - EFGM.MenuScale(1), w, EFGM.MenuScale(1))
                    surface.DrawRect(0, 0, EFGM.MenuScale(1), h)
                    surface.DrawRect(w - EFGM.MenuScale(1), 0, EFGM.MenuScale(1), h)

                    surface.SetDrawColor(255, 255, 255, 255)
                    surface.SetMaterial(v.icon)

                    local originalWidth, originalHeight = EFGM.MenuScale(57 * v.sizeX), EFGM.MenuScale(57 * v.sizeY)
                    local scaleFactor
                    local targetMaxDimension = EFGM.MenuScale(158)

                    if originalWidth > originalHeight then

                        scaleFactor = targetMaxDimension / originalWidth

                    else

                        scaleFactor = targetMaxDimension / originalHeight

                    end

                    newWidth = math.Round(originalWidth * scaleFactor)
                    newHeight = math.Round(originalHeight * scaleFactor)

                    local x = (EFGM.MenuScale(198) / 2) - (newWidth / 2)
                    local y = (EFGM.MenuScale(216) / 2) - (newHeight / 2)

                    surface.DrawTexturedRect(x, y - EFGM.MenuScale(20), newWidth, newHeight)

                end

                local countText
                surface.SetFont("PuristaBold18")

                if v.durability then countText = v.durability .. "/" .. v.durability else countText = v.stack .. "x" end
                local countTextSize = surface.GetTextSize(countText)

                local levelText = "LEVEL " .. v.level
                local levelTextSize = surface.GetTextSize(levelText)

                local value = v.value

                surface.SetFont("PuristaBold22")
                local itemValueText = comma_value(value)
                local itemValueTextSize = surface.GetTextSize(itemValueText)

                local roubleIcon = Material("icons/rouble_icon.png")
                local sellIcon = Material("icons/sell_icon.png")
                local lockIcon = Material("icons/lock_icon.png")

                local plyLevel = Menu.Player:GetNWInt("Level", 1)

                function item:PaintOver(w, h)

                    surface.SetDrawColor(Color(5, 5, 5, 100))
                    surface.DrawRect(EFGM.MenuScale(1), h - EFGM.MenuScale(31), w - EFGM.MenuScale(2), EFGM.MenuScale(30))

                    if v.canPurchase then

                        surface.SetDrawColor(Color(80, 80, 80, 50))
                        surface.DrawRect(EFGM.MenuScale(1), h - EFGM.MenuScale(46), countTextSize + EFGM.MenuScale(10), EFGM.MenuScale(15))
                        surface.DrawRect(EFGM.MenuScale(1), EFGM.MenuScale(17), levelTextSize + EFGM.MenuScale(8), EFGM.MenuScale(15))

                        draw.SimpleTextOutlined(countText, "PuristaBold18", EFGM.MenuScale(5), h - EFGM.MenuScale(31), MenuAlias.whiteColor, TEXT_ALIGN_LEFT, TEXT_ALIGN_BOTTOM, 1, MenuAlias.blackColor)
                        draw.SimpleTextOutlined(levelText, "PuristaBold18", EFGM.MenuScale(5), EFGM.MenuScale(14), MenuAlias.whiteColor, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP, 1, MenuAlias.blackColor)

                    end

                    draw.SimpleTextOutlined(v.name, "PuristaBold18", EFGM.MenuScale(5), EFGM.MenuScale(0), MenuAlias.whiteColor, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP, 1, MenuAlias.blackColor)
                    draw.SimpleTextOutlined(itemValueText, "PuristaBold22", (w / 2) + EFGM.MenuScale(12), h - EFGM.MenuScale(18), MenuAlias.whiteColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1, MenuAlias.blackColor)

                    surface.SetDrawColor(255, 255, 255, 255)

                    if !v.canPurchase then surface.SetMaterial(sellIcon) else

                        if plyLevel < v.level then surface.SetMaterial(lockIcon) else surface.SetMaterial(roubleIcon) end

                    end

                    surface.DrawTexturedRect((w / 2) - EFGM.MenuScale(12) - (itemValueTextSize / 2), h - EFGM.MenuScale(27), EFGM.MenuScale(20), EFGM.MenuScale(20))

                end

                function item:DoClick()

                    if !v.canPurchase then return end
                    Menu.ConfirmPurchase(v.id)

                end

                function item:DoRightClick()

                    local x, y = marketItemHolder:LocalCursorPos()
                    surface.PlaySound("ui/element_hover.wav")

                    if x <= (marketItemHolder:GetWide() / 2) then sideH = true else sideH = false end
                    if y <= (marketItemHolder:GetTall() / 2) then sideV = true else sideV = false end

                    if IsValid(contextMenu) then contextMenu:Remove() end
                    contextMenu = vgui.Create("DPanel", marketItemHolder)
                    contextMenu:SetSize(EFGM.MenuScale(100), EFGM.MenuScale(35))
                    contextMenu:DockPadding(EFGM.MenuScale(5), EFGM.MenuScale(5), EFGM.MenuScale(5), EFGM.MenuScale(5))
                    contextMenu:SetAlpha(0)
                    contextMenu:AlphaTo(255, 0.1, 0, nil)
                    contextMenu:RequestFocus()

                    contextMenu.Paint = function(s, w, h)

                        if !IsValid(s) then return end

                        BlurPanel(s, EFGM.MenuScale(5))

                        surface.SetDrawColor(Color(5, 5, 5, 50))
                        surface.DrawRect(0, 0, w, h)

                        surface.SetDrawColor(Color(255, 255, 255, 30))
                        surface.DrawRect(0, 0, w, EFGM.MenuScale(1))
                        surface.DrawRect(0, h - EFGM.MenuScale(1), w, EFGM.MenuScale(1))
                        surface.DrawRect(0, 0, EFGM.MenuScale(1), h)
                        surface.DrawRect(w - EFGM.MenuScale(1), 0, EFGM.MenuScale(1), h)

                        contextMenu:SizeToChildren(true, true)

                    end

                    hook.Add("Think", "CheckIfContextMenuStillFocused", function()

                        if !IsValid(contextMenu) then hook.Remove("Think", "CheckIfContextMenuStillFocused") return end
                        if (input.IsMouseDown(MOUSE_LEFT) or input.IsMouseDown(MOUSE_RIGHT) or input.IsMouseDown(MOUSE_MIDDLE) or input.IsMouseDown(MOUSE_WHEEL_DOWN) or input.IsMouseDown(MOUSE_WHEEL_UP)) and !contextMenu:IsChildHovered() then contextMenu:KillFocus() hook.Remove("Think", "CheckIfContextMenuStillFocused") end

                    end)

                    function contextMenu:OnFocusChanged(focus)

                        if !focus then contextMenu:AlphaTo(0, 0.1, 0, function() contextMenu:Remove() hook.Remove("Think", "CheckIfContextMenuStillFocused") end) end

                    end

                    local itemInspectButton = vgui.Create("DButton", contextMenu)
                    itemInspectButton:Dock(TOP)
                    itemInspectButton:SetSize(0, EFGM.MenuScale(25))
                    itemInspectButton:SetText("INSPECT")

                    itemInspectButton.OnCursorEntered = function(s)

                        surface.PlaySound("ui/element_hover.wav")

                    end

                    function itemInspectButton:DoClick()

                        local data = {}
                        data.att = v.defAtts
                        Menu.InspectItem(v.id, data)
                        surface.PlaySound("ui/element_select.wav")
                        contextMenu:KillFocus()

                    end

                    if v.canPurchase and plyLevel >= v.level then

                        contextMenu:SetTall(contextMenu:GetTall() + EFGM.MenuScale(25))

                        local itemBuyButton = vgui.Create("DButton", contextMenu)
                        itemBuyButton:Dock(TOP)
                        itemBuyButton:SetSize(0, EFGM.MenuScale(25))
                        itemBuyButton:SetText("BUY")

                        itemBuyButton.OnCursorEntered = function(s)

                            surface.PlaySound("ui/element_hover.wav")

                        end

                        function itemBuyButton:DoClick()

                            Menu.ConfirmPurchase(v.id)
                            contextMenu:KillFocus()

                        end

                    end

                    if sideH == true then

                        contextMenu:SetX(math.Clamp(x + EFGM.MenuScale(5), EFGM.MenuScale(5), marketItemHolder:GetWide() - contextMenu:GetWide() - EFGM.MenuScale(5)))

                    else

                        contextMenu:SetX(math.Clamp(x - contextMenu:GetWide(), EFGM.MenuScale(5), marketItemHolder:GetWide() - contextMenu:GetWide() - EFGM.MenuScale(5)))

                    end

                    if sideV == true then

                        contextMenu:SetY(math.Clamp(y + EFGM.MenuScale(5), EFGM.MenuScale(5), marketItemHolder:GetTall() - contextMenu:GetTall() - EFGM.MenuScale(5)))

                    else

                        contextMenu:SetY(math.Clamp(y - contextMenu:GetTall() + EFGM.MenuScale(5), EFGM.MenuScale(5), marketItemHolder:GetTall() - contextMenu:GetTall() - EFGM.MenuScale(5)))

                    end

                end

            end

        end

    end

    local curItems = MarketCat.WEAPONS.items
    local function UpdateMarketList(items)

        if items == nil then items = curItems end

        local plyLevel = Menu.Player:GetNWInt("Level", 1)

        marketTbl = {}
        local numOfItems = 0
        currentPage = 1
        totalPages = 0
        curItems = items

        for k1, v1 in pairs(items) do

            for k2, v2 in pairs(EFGMITEMS) do

                if marketSearchText != "" and !(string.find((v2.fullName and v2.fullName or v2.displayName):lower(), marketSearchText) or string.find((k2):lower(), marketSearchText)) then continue end
                if showBasedOnLevel == "unlocked" and plyLevel < (v2.levelReq or 1) then continue end
                if showBasedOnLevel == "unlocked" and !(v2.canPurchase or v2.canPurchase == nil) then continue end

                if v2.displayType == v1 then

                    numOfItems = numOfItems + 1

                    local purchasable
                    if v2.canPurchase or v2.canPurchase == nil then purchasable = true else purchasable = false end

                    local entry = {}
                    entry.name = v2.displayName
                    entry.id = k2
                    entry.icon = v2.icon
                    entry.value = v2.value or 1000
                    entry.level = v2.levelReq or 1
                    entry.equipType = v2.equipType
                    if entry.equipType == EQUIPTYPE.Consumable then entry.durability = v2.durability end
                    entry.stack = v2.stackSize
                    entry.sizeX = v2.sizeX or 1
                    entry.sizeY = v2.sizeY or 1
                    entry.defAtts = v2.defAtts
                    entry.canPurchase = purchasable

                    if entry.equipType == EQUIPTYPE.Weapon and entry.defAtts then

                        local atts = GetPrefixedAttachmentListFromCode(entry.defAtts)
                        if !atts then return end

                        for _, a in ipairs(atts) do

                            local att = EFGMITEMS[a]
                            if att == nil then return end

                            entry.value = entry.value + att.value

                        end

                    end


                    table.insert(marketTbl, entry)

                end

            end

        end

        if sortBy == "name" then

            if sortWith == "ascending" then

                table.SortByMember(marketTbl, "name", true)

            else

                table.SortByMember(marketTbl, "name", false)

            end

        elseif sortBy == "value" then

            if sortWith == "ascending" then

                table.SortByMember(marketTbl, "value", true)

            else

                table.SortByMember(marketTbl, "value", false)

            end

        end

        totalPages = math.ceil(numOfItems / 20)
        ReloadMarket()

    end

    function nextPageButton:DoClick()

        if currentPage >= totalPages then surface.PlaySound("ui/element_deselect.wav") return end

        surface.PlaySound("ui/element_select.wav")

        currentPage = currentPage + 1

        ReloadMarket()

    end

    function lastPageButton:DoClick()

        if currentPage <= 1 then surface.PlaySound("ui/element_deselect.wav") return end

        surface.PlaySound("ui/element_select.wav")

        currentPage = currentPage - 1

        ReloadMarket()

    end

    marketSearchBox.OnChange = function(self)

        marketSearchText = self:GetValue():lower()

        UpdateMarketList()

    end

    function marketSortByButton:DoClick()

        surface.PlaySound("ui/element_select.wav")

        if sortBy == "name" then

            sortBy = "value"
            marketSortByButton:SetText("SORT BY VALUE")

        else

            sortBy = "name"
            marketSortByButton:SetText("SORT BY NAME")

        end

        UpdateMarketList()

    end

    function marketSortWithButton:DoClick()

        surface.PlaySound("ui/element_select.wav")

        if sortWith == "ascending" then

            sortWith = "descending"
            marketSortWithButton:SetText("DESCENDING ORDER")

        else

            sortWith = "ascending"
            marketSortWithButton:SetText("ASCENDING ORDER")

        end

        UpdateMarketList()

    end

    function marketShowUnlockButton:DoClick()

        surface.PlaySound("ui/element_select.wav")

        if showBasedOnLevel == "all" then

            showBasedOnLevel = "unlocked"
            marketShowUnlockButton:SetText("SHOW UNLOCKED")

        else

            showBasedOnLevel = "all"
            marketShowUnlockButton:SetText("SHOW EVERYTHING")

        end

        UpdateMarketList()

    end

    -- default to the weapons tab
    UpdateMarketList(MarketCat.WEAPONS.items)

    for k1, v1 in SortedPairs(MarketCat) do

        local category = marketCategoryEntryList:Add(string.upper(v1.name))
        category:SetExpanded(true)
        category:SetHeaderHeight(EFGM.MenuScale(30))

        if v1.name == "Weapons" then category:SetExpanded(true) end

        function category:OnCursorEntered()

            surface.PlaySound("ui/element_hover.wav")

        end

        function category:Toggle()

            surface.PlaySound("ui/element_select.wav")

            marketCategoryEntryList:UnselectAll()

            if marketTab == v1.name then return end

            marketTab = v1.name
            marketSearchText = ""
            marketSearchBox:SetValue("")
            UpdateMarketList(v1.items)

        end

        for k2, v2 in SortedPairsByValue(v1.children) do

            local entry = category:Add(string.upper(k2))

            function entry:DoClick()

                surface.PlaySound("ui/element_select.wav")

                if marketTab == k2 then return end

                marketTab = k2
                local items = {}
                table.insert(items, v2)
                marketSearchText = ""
                marketSearchBox:SetValue("")
                UpdateMarketList(items)

            end

        end

    end

end

function Menu.OpenTab.Intel()

    local contents = vgui.Create("DPanel", Menu.MenuFrame.LowerPanel)
    contents:Dock(FILL)
    contents:DockPadding(EFGM.MenuScale(10), EFGM.MenuScale(10), EFGM.MenuScale(10), EFGM.MenuScale(10))
    contents:SetAlpha(0)
    contents.Paint = function(s, w, h)

        surface.SetDrawColor(MenuAlias.transparent)
        surface.DrawRect(0, 0, w, h)

    end

    Menu.MenuFrame.LowerPanel.Contents = contents

    local mainEntryList = vgui.Create("DCategoryList", contents)
    mainEntryList:Dock(LEFT)
    mainEntryList:SetSize(EFGM.MenuScale(180), 0)
    mainEntryList:SetBackgroundColor(Color(0, 0, 0, 0))
    mainEntryList:GetVBar():SetSize(0, 0)

    local entryBar = mainEntryList:GetVBar()
    entryBar:SetHideButtons(true)
    entryBar:SetSize(EFGM.MenuScale(15), EFGM.MenuScale(15))
    function entryBar:Paint(w, h)
        draw.RoundedBox(0, EFGM.MenuScale(5), EFGM.MenuScale(8), EFGM.MenuScale(5), h - EFGM.MenuScale(16), Color(0, 0, 0, 50))
    end
    function entryBar.btnGrip:Paint(w, h)
        draw.RoundedBox(0, EFGM.MenuScale(5), EFGM.MenuScale(8), EFGM.MenuScale(5), h - EFGM.MenuScale(16), Color(255, 255, 255, 155))
    end

    local subEntryPanel = vgui.Create("DPanel", contents)
    subEntryPanel:Dock(LEFT)
    subEntryPanel:SetSize(EFGM.MenuScale(180), 0)
    subEntryPanel:SetBackgroundColor(Color(0, 0, 0, 0))

    local subEntryList = vgui.Create("DIconLayout", subEntryPanel)
    subEntryList:Dock(LEFT)
    subEntryList:SetSize(EFGM.MenuScale(180), 0)
    subEntryList:SetSpaceY(EFGM.MenuScale(2))

    local entryPanel = vgui.Create("DPanel", contents)
    entryPanel:Dock(FILL)
    function entryPanel:Paint(w, h)
        surface.SetDrawColor(0, 0, 0, 0)
        surface.DrawRect(0, 0, w, h)
    end

    local entryStats = vgui.Create("DPanel", entryPanel)
    entryStats:Dock(TOP)
    entryStats:SetSize(0, EFGM.MenuScale(40))
    entryStats.Paint = nil

    local entryTextDisplay = vgui.Create("DPanel", entryPanel)
    entryTextDisplay:Dock(FILL)
    entryTextDisplay.Paint = nil

    local function DrawEntry(entryName, entryText, stats)

        if stats != nil then

            entryStats:SetSize(0, #stats * EFGM.MenuScale(40))

            function entryStats:Paint(w, h)

                for k, v in ipairs(stats) do

                    surface.SetDrawColor(25, 25, 25, 50)
                    if k % 2 == 1 then
                        surface.SetDrawColor(35, 35, 35, 70)
                    end

                    surface.DrawRect(0, (k - 1) * EFGM.MenuScale(30), w, EFGM.MenuScale(30))

                    local text = markup.Parse( "<font=PuristaBold32><color=255,255,255>\n\n" .. v .. "</color></font>", w - EFGM.MenuScale(40) )
                    text:Draw(EFGM.MenuScale(20), (k - 1) * EFGM.MenuScale(30) - EFGM.MenuScale(4))

                end

            end

        else

            entryStats:SetSize(0, 0)
            entryStats.Paint = nil

        end

        function entryTextDisplay:Paint(w, h)

            -- chatgpt hallucinated an entire fucking function to get this shit to wrap, apologised profusely when called out on its artificial bs, but then told me about markup thanks chatgpt

            local text = markup.Parse( "<font=PuristaBold64><color=50,212,50>" .. string.upper(entryName) .. "</color></font><font=Purista32><color=255,255,255>\n" .. entryText .. "</color></font>", w - EFGM.MenuScale(40) )
            text:Draw(EFGM.MenuScale(20), EFGM.MenuScale(-15))

        end

    end

    -- Entries

    for k1, v1 in pairs(Intel) do

        local category = mainEntryList:Add(k1)
        category:DoExpansion(true)

        for k2, v2 in pairs(v1) do

            local entry = category:Add(string.upper(v2.Name))

            function entry:DoClick()

                surface.PlaySound("ui/element_select.wav")

                subEntryList:Clear()
                DrawEntry(v2.Name, v2.Description, v2.Stats)

                -- support for entries that don't need sub-categories
                if v2.Children != nil then

                    subEntryPanel:SetSize(EFGM.MenuScale(180), 0) 
                

                else

                    subEntryPanel:SetSize(0, 0)

                    return

                end

                for k3, v3 in ipairs(v2.Children) do -- jesus christ

                    local subEntry = subEntryList:Add("DButton")
                    subEntry:SetSize(EFGM.MenuScale(180), EFGM.MenuScale(24))
                    subEntry:SetText(string.upper(v3.Name))

                    function subEntry:OnCursorEntered()

                        surface.PlaySound("ui/element_hover.wav")

                    end

                    function subEntry:DoClick()

                        surface.PlaySound("ui/element_select.wav")

                        DrawEntry(v3.Name, v3.Description, v3.Stats)

                    end

                end

            end

        end

    end

end

function Menu.OpenTab.Match()

    local contents = vgui.Create("DPanel", Menu.MenuFrame.LowerPanel)
    contents:Dock(FILL)
    contents:DockPadding(EFGM.MenuScale(10), EFGM.MenuScale(10), EFGM.MenuScale(10), EFGM.MenuScale(10))
    contents:SetAlpha(0)
    contents.Paint = function(s, w, h)

        surface.SetDrawColor(MenuAlias.transparent)
        surface.DrawRect(0, 0, w, h)

    end

    Menu.MenuFrame.LowerPanel.Contents = contents

    local pmcPanel = vgui.Create("DScrollPanel", contents)
    pmcPanel:Dock(LEFT)
    pmcPanel:SetSize(EFGM.MenuScale(320), 0)
    pmcPanel.Paint = function(s, w, h)

        surface.SetDrawColor(MenuAlias.transparent)
        surface.DrawRect(0, 0, w, h)

    end

    if Menu.Player:CompareStatus(0) then

        local pmcTitle = vgui.Create("DPanel", pmcPanel)
        pmcTitle:Dock(TOP)
        pmcTitle:SetSize(0, EFGM.MenuScale(32))
        function pmcTitle:Paint(w, h)

            surface.SetDrawColor(MenuAlias.transparent)
            surface.DrawRect(0, 0, w, h)

            draw.SimpleTextOutlined("OPERATORS", "PuristaBold32", w / 2, 0, MenuAlias.whiteColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 1, MenuAlias.blackColor)

        end

        local pmcPanelBar = pmcPanel:GetVBar()
        pmcPanelBar:SetHideButtons(true)
        pmcPanelBar:SetSize(EFGM.MenuScale(15), EFGM.MenuScale(15))
        function pmcPanelBar:Paint(w, h)
            draw.RoundedBox(0, EFGM.MenuScale(5), EFGM.MenuScale(8), EFGM.MenuScale(5), h - EFGM.MenuScale(16), Color(0, 0, 0, 50))
        end
        function pmcPanelBar.btnGrip:Paint(w, h)
            draw.RoundedBox(0, EFGM.MenuScale(5), EFGM.MenuScale(8), EFGM.MenuScale(5), h - EFGM.MenuScale(16), Color(255, 255, 255, 155))
        end

        pmcList = vgui.Create("DListLayout", pmcPanel)
        pmcList:Dock(TOP)
        pmcList:SetSize(EFGM.MenuScale(320), 0)

        local onlinePlayers = player.GetAll()

        for k, v in pairs(onlinePlayers) do

            local name = v:GetName()
            local ping = v:Ping()
            local kills = v:Frags()
            local deaths = v:Deaths()

            local pmcEntry = vgui.Create("DPanel", pmcList)
            pmcEntry:SetSize(pmcList:GetWide(), EFGM.MenuScale(50))
            pmcEntry:SetPos(0, 0)
            pmcEntry.Paint = function(w, h)
                if !IsValid(v) then return end
                draw.SimpleTextOutlined(name .. "         " .. ping  .. "ms", "Purista18", EFGM.MenuScale(50), EFGM.MenuScale(5), MenuAlias.whiteColor, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP, 1, MenuAlias.blackColor)
                draw.SimpleTextOutlined(kills, "Purista18", EFGM.MenuScale(50), EFGM.MenuScale(25), Color(0, 255, 0), TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP, 1, MenuAlias.blackColor)
                draw.SimpleTextOutlined(deaths, "Purista18", EFGM.MenuScale(85), EFGM.MenuScale(25), Color(255, 0, 0), TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP, 1, MenuAlias.blackColor)
            end

            local pmcPFP = vgui.Create("AvatarImage", pmcEntry)
            pmcPFP:SetPos(EFGM.MenuScale(5), EFGM.MenuScale(5))
            pmcPFP:SetSize(EFGM.MenuScale(40), EFGM.MenuScale(40))
            pmcPFP:SetPlayer(v, 184)

            pmcPFP.OnMousePressed = function()
                local dropdown = DermaMenu()

                local profile = dropdown:AddOption("Open Steam Profile", function() gui.OpenURL("http://steamcommunity.com/profiles/" .. v:SteamID64()) end)
                profile:SetIcon("icon16/page_find.png")

                dropdown:AddSpacer()

                local copy = dropdown:AddSubMenu("Copy...")
                copy:AddOption("Copy Name", function() SetClipboardText(v:GetName()) end):SetIcon("icon16/cut.png")
                copy:AddOption("Copy SteamID64", function() SetClipboardText(v:SteamID64()) end):SetIcon("icon16/cut.png")

                if v != Menu.Player then

                    local mute = dropdown:AddOption("Mute Player", function(self)

                        if v:IsMuted() then

                            v:SetMuted(false)

                        else

                            v:SetMuted(true)

                        end

                    end)

                    if v:IsMuted() then

                        mute:SetIcon("icon16/sound.png")
                        mute:SetText("Unmute Player")
                    else

                        mute:SetIcon("icon16/sound_mute.png")
                        mute:SetText("Mute Player")

                    end

                end

                dropdown:Open()

            end

        end

    end

    local mapPanel = vgui.Create("DPanel", contents)
    mapPanel:Dock(LEFT)
    mapPanel:SetSize(EFGM.MenuScale(1230), 0)
    mapPanel.Paint = function(s, w, h)

        surface.SetDrawColor(MenuAlias.transparent)
        surface.DrawRect(0, 0, w, h)

    end

    local mapTitle = vgui.Create("DPanel", mapPanel)
    mapTitle:Dock(TOP)
    mapTitle:SetSize(0, EFGM.MenuScale(40))
    function mapTitle:Paint(w, h)

        surface.SetDrawColor(MenuAlias.transparent)
        surface.DrawRect(0, 0, w, h)

        draw.SimpleTextOutlined("MAP", "PuristaBold32", w / 2, 0, MenuAlias.whiteColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 1, MenuAlias.blackColor)

    end

    local mapRawName = game.GetMap()
    local mapInfo = MAPINFO[mapRawName]
    local mapOverhead = Material("maps/" .. mapRawName .. ".png", "smooth")

    local mapSizeX = EFGM.MenuScale(1210)
    local mapSizeY = EFGM.MenuScale(1210)

    if mapOverhead then

        mapSizeX = EFGM.MenuScale(mapOverhead:Width())
        mapSizeY = EFGM.MenuScale(mapOverhead:Height())

    end

    local mapHolder = vgui.Create("DPanel", mapPanel)
    mapHolder:SetPos(EFGM.MenuScale(10), EFGM.MenuScale(40))
    mapHolder:SetSize(EFGM.MenuScale(1210), EFGM.MenuScale(920))
    function mapHolder:Paint(w, h)

        surface.SetDrawColor(Color(80, 80, 80, 10))
        surface.DrawRect(0, 0, w, h)

    end

    function mapHolder:PaintOver(w, h)

        surface.SetDrawColor(Color(255, 255, 255, 255))
        surface.DrawRect(0, 0, w, EFGM.MenuScale(1))
        surface.DrawRect(0, h - EFGM.MenuScale(1), w, EFGM.MenuScale(1))
        surface.DrawRect(0, 0, EFGM.MenuScale(1), h)
        surface.DrawRect(w - EFGM.MenuScale(1), 0, EFGM.MenuScale(1), h)

    end

    local maxZoom = 2.5
    local minZoom = 1

    local xDiff = EFGM.MenuScale(1210) / mapSizeX
    local yDiff = EFGM.MenuScale(1210) / mapSizeY

    minZoom = math.max(xDiff, yDiff)

    if yDiff > xDiff and mapSizeX > mapSizeY then minZoom = math.min(xDiff, yDiff) end

    local map = vgui.Create("DPanel", mapHolder)
    map:SetSize(mapSizeX, mapSizeY)
    map:SetMouseInputEnabled(true)
    map:SetCursor("crosshair")
    map.Dragging = false
    map.Zoom = minZoom
    map.DragPos = {x = 0, y = 0}
    map.PanOffset = {x = 0, y = 0}

    function map:ClampPanOffset()

        local panelW, panelH = mapHolder:GetSize()
        local zoom = self.Zoom
        local pan = self.PanOffset

        local contentScreenW = mapSizeX * zoom
        local contentScreenH = mapSizeY * zoom

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

    map:ClampPanOffset()

    -- most of this was vibe coded, and im genuinely scared how well it works
    -- lmao bro vibe codes
    function map:OnMouseWheeled(delta)

        local oldZoom = self.Zoom
        local zoomSpeed = 0.1
        self.Zoom = math.Clamp(self.Zoom + delta * zoomSpeed, minZoom, maxZoom)

        local newZoom = self.Zoom

        if newZoom == oldZoom then return true end

        local mouseX, mouseY = self:CursorPos()

        self.PanOffset.x = mouseX - ((mouseX - self.PanOffset.x) / oldZoom) * newZoom
        self.PanOffset.y = mouseY - ((mouseY - self.PanOffset.y) / oldZoom) * newZoom

        self:ClampPanOffset()

    end

    function map:OnMousePressed(mousecode)

        if mousecode == MOUSE_LEFT then

            self.Dragging = true
            self.DragPos.x, self.DragPos.y = gui.MousePos()
            self:MouseCapture(true)

        end

    end

    function map:OnMouseReleased(mousecode)

        if mousecode == MOUSE_LEFT then

            self.Dragging = false
            self:MouseCapture(false)

        end

    end

    function map:Think()

        if self.Dragging then

            local mx, my = gui.MousePos()
            local dx = mx - self.DragPos.x
            local dy = my - self.DragPos.y

            self.PanOffset.x = self.PanOffset.x + dx / self.Zoom
            self.PanOffset.y = self.PanOffset.y + dy / self.Zoom

            self:ClampPanOffset()

            self.DragPos.x, self.DragPos.y = mx, my

        end

    end

    function map:Paint(w, h)

        if mapInfo == nil then return end

        surface.SetDrawColor(255, 255, 255, 255)
        surface.SetMaterial(mapOverhead)
        surface.DrawTexturedRect(0 + self.PanOffset.x, 0 + self.PanOffset.y, w * self.Zoom, h * self.Zoom)

        surface.SetDrawColor(52, 124, 218, 240)
        for k, v in pairs(mapInfo.spawns) do

            local posX = (v.pos.x * mapSizeX * self.Zoom) + self.PanOffset.x
            local posY = (v.pos.y * mapSizeY * self.Zoom) + self.PanOffset.y

            -- surface.DrawCircle(posX, posY, (5 * mapSizeX * self.Zoom) / 720 )
            surface.SetDrawColor(255, 255, 255, 240)
            surface.SetMaterial(Material("icons/map/pmc_spawn_alt.png", "mips"))
            surface.DrawTexturedRect(posX - 16, posY - 16, 32, 32)

            -- local text = "Spawn"

            -- draw.DrawText( text, "PuristaBold16", posX, posY - 20 * (self.Zoom * 1.6), Color(52, 124, 218, 240), TEXT_ALIGN_CENTER )

        end

        surface.SetDrawColor(19, 196, 34, 240)
        for k, v in pairs(mapInfo.extracts) do

            local posX = (v.pos.x * mapSizeX * self.Zoom) + self.PanOffset.x
            local posY = (v.pos.y * mapSizeY * self.Zoom) + self.PanOffset.y

            surface.SetDrawColor(255, 255, 255, 240)
            surface.SetMaterial(Material("icons/map/extract_full.png", "mips"))
            surface.DrawTexturedRect(posX - 16, posY - 16, 32, 32)

            local text = v.name
            --  * (self.Zoom * 2.2)
            draw.DrawText( text, "PuristaBold16", posX, posY - 36, Color(19, 196, 34, 240), TEXT_ALIGN_CENTER )

        end

        surface.SetDrawColor(202, 20, 20, 240)
        for k, v in pairs(mapInfo.locations) do

            local posX = (v.pos.x * mapSizeX * self.Zoom) + self.PanOffset.x
            local posY = (v.pos.y * mapSizeY * self.Zoom) + self.PanOffset.y

            surface.SetDrawColor(255, 255, 255, 240)
            surface.SetMaterial(Material("icons/map/location_alt.png", "mips"))
            surface.DrawTexturedRect(posX - 32, posY - 32, 64, 64)

            draw.DrawText( v.name, "PuristaBold16", posX, posY - 48, Color(202, 20, 20, 240), TEXT_ALIGN_CENTER )
            draw.DrawText( "Loot:" .. v.loot .. "/5", "PuristaBold16", posX, posY + 32, Color(202, 20, 20, 240), TEXT_ALIGN_CENTER )

        end

        surface.SetDrawColor(252, 152, 2, 240)
        for k, v in pairs(mapInfo.keys) do

            local posX = (v.pos.x * mapSizeX * self.Zoom) + self.PanOffset.x
            local posY = (v.pos.y * mapSizeY * self.Zoom) + self.PanOffset.y

            surface.SetDrawColor(255, 255, 255, 240)
            surface.SetMaterial(Material("icons/map/key.png", "mips"))
            surface.DrawTexturedRect(posX - 16, posY - 16, 32, 32)
            
            --  * (self.Zoom * 2.4)
            draw.DrawText( v.name, "PuristaBold16", posX, posY - 36, Color(252, 152, 2, 240), TEXT_ALIGN_CENTER )

        end

    end

    local mapName = MAPNAMES[mapRawName]
    surface.SetFont("PuristaBold50")
    local mapNameText = string.upper(mapName or "")
    local mapNameTextSize = surface.GetTextSize(mapNameText)

    local mapLegend = vgui.Create("DPanel", mapHolder)
    mapLegend:SetPos(mapHolder:GetWide() - math.max(mapNameTextSize + EFGM.MenuScale(30), EFGM.MenuScale(110)), EFGM.MenuScale(10))
    mapLegend:SetSize(math.max(mapNameTextSize + EFGM.MenuScale(20), EFGM.MenuScale(100)), EFGM.MenuScale(145))
    mapLegend.Paint = function(s, w, h)

        BlurPanel(s, EFGM.MenuScale(4))

        surface.SetDrawColor(Color(20, 20, 20, 155))
        surface.DrawRect(0, 0, w, h)

        surface.SetDrawColor(Color(255, 255, 255, 25))
        surface.DrawRect(0, 0, w, EFGM.MenuScale(1))
        surface.DrawRect(0, h - EFGM.MenuScale(1), w, EFGM.MenuScale(1))
        surface.DrawRect(0, 0, EFGM.MenuScale(1), h)
        surface.DrawRect(w - EFGM.MenuScale(1), 0, EFGM.MenuScale(1), h)

        draw.SimpleTextOutlined(mapNameText, "PuristaBold50", w / 2, 0, MenuAlias.whiteColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 1, MenuAlias.blackColor)

        draw.SimpleTextOutlined("LEGEND", "PuristaBold24", w - EFGM.MenuScale(10), EFGM.MenuScale(50), MenuAlias.whiteColor, TEXT_ALIGN_RIGHT, TEXT_ALIGN_TOP, 1, MenuAlias.blackColor)
        draw.SimpleTextOutlined("SPAWNS ■", "PuristaBold18", w - EFGM.MenuScale(10), EFGM.MenuScale(75), Color(52, 124, 218, 240), TEXT_ALIGN_RIGHT, TEXT_ALIGN_TOP, 1, MenuAlias.blackColor)
        draw.SimpleTextOutlined("EXTRACTS ■", "PuristaBold18", w - EFGM.MenuScale(10), EFGM.MenuScale(90), Color(19, 196, 34, 240), TEXT_ALIGN_RIGHT, TEXT_ALIGN_TOP, 1, MenuAlias.blackColor)
        draw.SimpleTextOutlined("POIs ■", "PuristaBold18", w - EFGM.MenuScale(10), EFGM.MenuScale(105), Color(202, 20, 20, 240), TEXT_ALIGN_RIGHT, TEXT_ALIGN_TOP, 1, MenuAlias.blackColor)
        draw.SimpleTextOutlined("KEYS ■", "PuristaBold18", w - EFGM.MenuScale(10), EFGM.MenuScale(120), Color(252, 152, 2, 240), TEXT_ALIGN_RIGHT, TEXT_ALIGN_TOP, 1, MenuAlias.blackColor)

    end

    if Menu.Player:CompareStatus(0) then

        local squad = Menu.Player:GetNW2String("PlayerInSquad", nil)

        local squadPanel = vgui.Create("DPanel", contents)
        squadPanel:Dock(LEFT)
        squadPanel:SetSize(EFGM.MenuScale(320), 0)
        squadPanel.Paint = function(s, w, h)

            surface.SetDrawColor(MenuAlias.transparent)
            surface.DrawRect(0, 0, w, h)

        end

        local CreateSquadPlayerLimit
        local CreateSquadColor = {RED = 255, GREEN = 255, BLUE = 255}

        local createSquadTitle = vgui.Create("DPanel", squadPanel)
        createSquadTitle:Dock(TOP)
        createSquadTitle:SetSize(0, EFGM.MenuScale(32))
        function createSquadTitle:Paint(w, h)

            surface.SetDrawColor(MenuAlias.transparent)
            surface.DrawRect(0, 0, w, h)

            draw.SimpleTextOutlined("CREATE SQUAD", "PuristaBold32", w / 2, 0, MenuAlias.whiteColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 1, MenuAlias.blackColor)

        end

        squadNamePanel = vgui.Create("DPanel", squadPanel)
        squadNamePanel:Dock(TOP)
        squadNamePanel:SetSize(0, EFGM.MenuScale(55))
        squadNamePanel.Paint = function(s, w, h)

            surface.SetDrawColor(MenuAlias.transparent)
            surface.DrawRect(0, 0, w, h)

            draw.SimpleTextOutlined("Squad Name", "Purista18", w / 2, EFGM.MenuScale(5), MenuAlias.whiteColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 1, MenuAlias.blackColor)

        end

        squadNameBG = vgui.Create("DPanel", squadNamePanel)
        squadNameBG:SetPos(EFGM.MenuScale(85), EFGM.MenuScale(30))
        squadNameBG:SetSize(EFGM.MenuScale(150), EFGM.MenuScale(20))
        squadNameBG:SetBackgroundColor(MenuAlias.transparent)

        local squadName = vgui.Create("DTextEntry", squadNameBG)
        squadName:Dock(FILL)
        squadName:SetPlaceholderText(" ")
        squadName:SetUpdateOnType(true)
        squadName:SetTextColor(MenuAlias.whiteColor)
        squadName:SetCursorColor(MenuAlias.whiteColor)

        squadName.OnValueChange = function(self, value)

            CreateSquadName = self:GetValue()

        end

        squadPasswordPanel = vgui.Create("DPanel", squadPanel)
        squadPasswordPanel:Dock(TOP)
        squadPasswordPanel:SetSize(0, EFGM.MenuScale(55))
        squadPasswordPanel.Paint = function(s, w, h)

            surface.SetDrawColor(MenuAlias.transparent)
            surface.DrawRect(0, 0, w, h)

            draw.SimpleTextOutlined("Squad Password (optional)", "Purista18", w / 2, EFGM.MenuScale(5), MenuAlias.whiteColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 1, MenuAlias.blackColor)

        end

        squadPasswordBG = vgui.Create("DPanel", squadPasswordPanel)
        squadPasswordBG:SetPos(EFGM.MenuScale(85), EFGM.MenuScale(30))
        squadPasswordBG:SetSize(EFGM.MenuScale(150), EFGM.MenuScale(20))
        squadPasswordBG:SetBackgroundColor(MenuAlias.transparent)

        local squadPassword = vgui.Create("DTextEntry", squadPasswordBG)
        squadPassword:Dock(FILL)
        squadPassword:SetPlaceholderText(" ")
        squadPassword:SetUpdateOnType(true)
        squadPassword:SetTextColor(MenuAlias.whiteColor)
        squadPassword:SetCursorColor(MenuAlias.whiteColor)

        squadPassword.OnValueChange = function(self, value)

            CreateSquadPassword = self:GetValue()

        end

        local squadMemberLimitPanel = vgui.Create("DPanel", squadPanel)
        squadMemberLimitPanel:Dock(TOP)
        squadMemberLimitPanel:SetSize(0, EFGM.MenuScale(55))
        function squadMemberLimitPanel:Paint(w, h)

            draw.SimpleTextOutlined("Squad Member Limit (1 to 4)", "Purista18", w / 2, EFGM.MenuScale(5), MenuAlias.whiteColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 1, MenuAlias.blackColor)

        end

        local squadMemberLimit = vgui.Create("DNumberWang", squadMemberLimitPanel)
        squadMemberLimit:SetPos(EFGM.MenuScale(135), EFGM.MenuScale(30))
        squadMemberLimit:SetSize(EFGM.MenuScale(50), EFGM.MenuScale(20))
        squadMemberLimit:SetMin(1)
        squadMemberLimit:SetMax(4)

        squadMemberLimit.OnValueChanged = function(self)

            val = math.Clamp(self:GetValue(), self:GetMin(), self:GetMax())
            CreateSquadPlayerLimit = val

        end
        squadMemberLimit:SetValue(4) -- have to put this down here or else it won't work thanks glua

        local squadColorPanel = vgui.Create("DPanel", squadPanel)
        squadColorPanel:Dock(TOP)
        squadColorPanel:SetSize(0, EFGM.MenuScale(110 + 20))
        function squadColorPanel:Paint(w, h)

            draw.SimpleTextOutlined("Squad Color", "Purista18", w / 2, EFGM.MenuScale(5), MenuAlias.whiteColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 1, MenuAlias.blackColor)
            surface.SetDrawColor(Color(CreateSquadColor.RED, CreateSquadColor.GREEN, CreateSquadColor.BLUE, 255))
            surface.DrawRect(EFGM.MenuScale(85), EFGM.MenuScale(55), EFGM.MenuScale(145), EFGM.MenuScale(5))

        end

        local squadColorR = vgui.Create("DNumberWang", squadColorPanel)
        squadColorR:SetPos(EFGM.MenuScale(85), EFGM.MenuScale(30))
        squadColorR:SetSize(EFGM.MenuScale(45), EFGM.MenuScale(20))
        squadColorR:SetMin(0)
        squadColorR:SetMax(255)

        squadColorR.OnValueChanged = function(self)

            val = math.Clamp(self:GetValue(), self:GetMin(), self:GetMax())
            CreateSquadColor.RED = val

        end
        squadColorR:SetValue(255) -- refer to the DNumberWang above

        local squadColorG = vgui.Create("DNumberWang", squadColorPanel)
        squadColorG:SetPos(EFGM.MenuScale(135), EFGM.MenuScale(30))
        squadColorG:SetSize(EFGM.MenuScale(45), EFGM.MenuScale(20))
        squadColorG:SetMin(0)
        squadColorG:SetMax(255)

        squadColorG.OnValueChanged = function(self)

            val = math.Clamp(self:GetValue(), self:GetMin(), self:GetMax())
            CreateSquadColor.GREEN = val

        end
        squadColorG:SetValue(255) -- this is quite annoying

        local squadColorB = vgui.Create("DNumberWang", squadColorPanel)
        squadColorB:SetPos(EFGM.MenuScale(185), EFGM.MenuScale(30))
        squadColorB:SetSize(EFGM.MenuScale(45), EFGM.MenuScale(20))
        squadColorB:SetMin(0)
        squadColorB:SetMax(255)

        squadColorB.OnValueChanged = function(self)

            val = math.Clamp(self:GetValue(), self:GetMin(), self:GetMax())
            CreateSquadColor.BLUE = val

        end
        squadColorB:SetValue(255) -- so, how has your day been?

        local squadCreateButton = vgui.Create("DButton", squadColorPanel)
        squadCreateButton:SetPos(EFGM.MenuScale(85), EFGM.MenuScale(75))
        squadCreateButton:SetSize(EFGM.MenuScale(150), EFGM.MenuScale(20))
        squadCreateButton:SetText("CREATE SQUAD")

        squadCreateButton.OnCursorEntered = function(s)

            surface.PlaySound("ui/element_hover.wav")

        end

        function squadCreateButton:DoClick()

            surface.PlaySound("ui/element_select.wav")

            RunConsoleCommand("efgm_squad_create", squadName:GetValue(), squadPassword:GetValue(), CreateSquadPlayerLimit, CreateSquadColor.RED, CreateSquadColor.GREEN, CreateSquadColor.BLUE)

        end

        local joinSquadTitle = vgui.Create("DPanel", squadPanel)
        joinSquadTitle:Dock(TOP)
        joinSquadTitle:SetSize(0, EFGM.MenuScale(32 + 10))
        function joinSquadTitle:Paint(w, h)

            surface.SetDrawColor(MenuAlias.transparent)
            surface.DrawRect(0, 0, w, h)

            draw.SimpleTextOutlined("JOIN SQUAD", "PuristaBold32", w / 2, 0, MenuAlias.whiteColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 1, MenuAlias.blackColor)

        end

        local availableSquadsPanel = vgui.Create("DScrollPanel", squadPanel)
        availableSquadsPanel:Dock(TOP)
        availableSquadsPanel:SetSize(0, EFGM.MenuScale(220))
        availableSquadsPanel.Paint = function(s, w, h)

            surface.SetDrawColor(MenuAlias.transparent)
            surface.DrawRect(0, 0, w, h)

        end

        local availableSquadsPanelBar = availableSquadsPanel:GetVBar()
        availableSquadsPanelBar:SetHideButtons(true)
        availableSquadsPanelBar:SetSize(EFGM.MenuScale(15), EFGM.MenuScale(15))
        function availableSquadsPanelBar:Paint(w, h)
            draw.RoundedBox(0, EFGM.MenuScale(5), EFGM.MenuScale(8), EFGM.MenuScale(5), h - EFGM.MenuScale(16), Color(0, 0, 0, 50))
        end
        function availableSquadsPanelBar.btnGrip:Paint(w, h)
            draw.RoundedBox(0, EFGM.MenuScale(5), EFGM.MenuScale(8), EFGM.MenuScale(5), h - EFGM.MenuScale(16), Color(255, 255, 255, 155))
        end

        local availableSquadsList = vgui.Create("DListLayout", availableSquadsPanel)
        availableSquadsList:Dock(TOP)
        availableSquadsList:SetSize(EFGM.MenuScale(300), EFGM.MenuScale(330))

        function GenerateJoinableSquads(array)

            for k, v in SortedPairs(array) do

                local name = k
                local color = v.COLOR
                local owner = v.OWNER
                local status
                local password = v.PASSWORD
                local limit = v.LIMIT
                local members = v.MEMBERS
                local memberCount = table.Count(members)
                local open = limit != memberCount
                local protected = string.len(password) != 0

                if !protected then status = "PUBLIC" else status = "PRIVATE" end

                local squadEntry = vgui.Create("DButton", availableSquadsList)
                squadEntry:SetText("")
                squadEntry:SetSize(0, EFGM.MenuScale(55))
                squadEntry.Paint = function(s, w, h)

                    if open then
                        surface.SetDrawColor(Color(0, 0, 0, 100))
                    else
                        surface.SetDrawColor(Color(50, 0, 0, 100))
                    end
                    surface.DrawRect(0, 0, w, h)

                    draw.SimpleTextOutlined(name, "PuristaBold24", w / 2, EFGM.MenuScale(5), Color(color.RED, color.GREEN, color.BLUE), TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 1, MenuAlias.blackColor)
                    draw.SimpleTextOutlined(table.Count(members) .. " / " .. limit .. "   |   " .. status, "PuristaBold18", w / 2, EFGM.MenuScale(30), MenuAlias.whiteColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 1, MenuAlias.blackColor)

                end

                squadEntry.DoClick = function(s, w, h)

                    if open and !protected then

                        surface.PlaySound("ui/element_select.wav")

                        RunConsoleCommand("efgm_squad_join", name, password)

                    end

                end

                local x, y = 0, 0
                local sideH, sideV

                squadEntry.OnCursorEntered = function(s)

                    x, y = Menu.MouseX, Menu.MouseY
                    surface.PlaySound("ui/element_hover.wav")

                    if x <= (ScrW() / 2) then sideH = true else sideH = false end
                    if y <= (ScrH() / 2) then sideV = true else sideV = false end

                    local function UpdatePopOutPos()

                        if sideH == true then

                            squadPopOut:SetX(math.Clamp(x + EFGM.MenuScale(15), EFGM.MenuScale(10), ScrW() - squadPopOut:GetWide() - EFGM.MenuScale(10)))

                        else

                            squadPopOut:SetX(math.Clamp(x - squadPopOut:GetWide() - EFGM.MenuScale(15), EFGM.MenuScale(10), ScrW() - squadPopOut:GetWide() - EFGM.MenuScale(10)))

                        end

                        if sideV == true then

                            squadPopOut:SetY(math.Clamp(y + EFGM.MenuScale(15), EFGM.MenuScale(60), ScrH() - squadPopOut:GetTall() - EFGM.MenuScale(20)))

                        else

                            squadPopOut:SetY(math.Clamp(y - squadPopOut:GetTall() + EFGM.MenuScale(15), EFGM.MenuScale(60), ScrH() - squadPopOut:GetTall() - EFGM.MenuScale(20)))

                        end

                    end

                    if IsValid(squadPopOut) then squadPopOut:Remove() end
                    squadPopOut = vgui.Create("DPanel", Menu.MenuFrame)
                    squadPopOut:SetSize(EFGM.MenuScale(200), EFGM.MenuScale(60) + (memberCount * EFGM.MenuScale(19)))
                    UpdatePopOutPos()
                    squadPopOut:SetAlpha(0)
                    squadPopOut:AlphaTo(255, 0.1, 0, nil)
                    squadPopOut:SetMouseInputEnabled(false)

                    -- panel needs to be slightly taller for password entry
                    if protected and open and squad == "nil" then

                        squadPopOut:SetSize(EFGM.MenuScale(200), EFGM.MenuScale(90) + (memberCount * EFGM.MenuScale(19)))

                    end

                    -- panel needs to be slightly shorter if the player is already in a squad
                    if squad != "nil" then

                        squadPopOut:SetSize(EFGM.MenuScale(200), EFGM.MenuScale(40) + (memberCount * EFGM.MenuScale(19)))

                    end

                    squadPopOut.Paint = function(s, w, h)

                        if !IsValid(s) then return end

                        BlurPanel(s, EFGM.MenuScale(3))

                        -- panel position follows mouse position
                        x, y = Menu.MouseX, Menu.MouseY

                        UpdatePopOutPos()

                        surface.SetDrawColor(Color(0, 0, 0, 205))
                        surface.DrawRect(0, 0, w, h)

                        surface.SetDrawColor(Color(color.RED, color.GREEN, color.BLUE, 45))
                        surface.DrawRect(0, 0, w, h)

                        surface.SetDrawColor(Color(color.RED, color.GREEN, color.BLUE, 255))
                        surface.DrawRect(0, 0, w, EFGM.MenuScale(5))

                        surface.SetDrawColor(Color(255, 255, 255, 155))
                        surface.DrawRect(0, 0, w, EFGM.MenuScale(1))
                        surface.DrawRect(0, h - EFGM.MenuScale(1), w, EFGM.MenuScale(1))
                        surface.DrawRect(0, 0, EFGM.MenuScale(1), h)
                        surface.DrawRect(w - EFGM.MenuScale(1), 0, EFGM.MenuScale(1), h)

                        draw.SimpleTextOutlined("MEMBERS", "PuristaBold24", EFGM.MenuScale(5), EFGM.MenuScale(5), MenuAlias.whiteColor, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP, 1, MenuAlias.blackColor)

                        -- draw name for each member
                        for k, v in SortedPairs(members) do

                            if v == owner then

                                draw.SimpleTextOutlined(v:GetName() .. "*", "PuristaBold18", EFGM.MenuScale(27), (k * EFGM.MenuScale(20)) + EFGM.MenuScale(10), MenuAlias.whiteColor, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP, 1, MenuAlias.blackColor)
                            else

                                draw.SimpleTextOutlined(v:GetName(), "PuristaBold18", EFGM.MenuScale(27), (k * EFGM.MenuScale(20)) + EFGM.MenuScale(10), MenuAlias.whiteColor, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP, 1, MenuAlias.blackColor)

                            end

                        end

                        -- don't show join text if client is already in a squad
                        if squad != "nil" then return end

                        if !open then

                            draw.SimpleTextOutlined("SQUAD FULL!", "PuristaBold18", EFGM.MenuScale(5), h - EFGM.MenuScale(23), MenuAlias.whiteColor, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP, 1, Color(255, 0, 0, 255))
                            return

                        end

                        if !protected then

                            draw.SimpleTextOutlined("CLICK TO JOIN!", "PuristaBold18", EFGM.MenuScale(5), h - EFGM.MenuScale(23), MenuAlias.whiteColor, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP, 1, MenuAlias.blackColor)

                        else

                            draw.SimpleTextOutlined("ENTER PASSWORD TO JOIN!", "PuristaBold18", EFGM.MenuScale(5), h - EFGM.MenuScale(23), MenuAlias.whiteColor, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP, 1, MenuAlias.blackColor)

                        end

                    end

                    -- draw profile picture for each member
                    for k, v in SortedPairs(members) do

                        local memberPFP = vgui.Create("AvatarImage", squadPopOut)
                        memberPFP:SetPos(EFGM.MenuScale(5), (k * EFGM.MenuScale(20)) + EFGM.MenuScale(12))
                        memberPFP:SetSize(EFGM.MenuScale(18), EFGM.MenuScale(18))
                        memberPFP:SetPlayer(v, 184)

                    end

                    -- create password entry if squad is password protected and not full
                    if protected and open and squad == "nil" then

                        squadPasswordEntryBG = vgui.Create("DPanel", squadPopOut)
                        squadPasswordEntryBG:SetPos(EFGM.MenuScale(5), squadPopOut:GetTall() - EFGM.MenuScale(43))
                        squadPasswordEntryBG:SetSize(EFGM.MenuScale(181), EFGM.MenuScale(20))
                        squadPasswordEntryBG:SetBackgroundColor(Color(25, 25, 25, 155))

                        local squadPasswordEntry = vgui.Create("DTextEntry", squadPasswordEntryBG)
                        squadPasswordEntry:Dock(FILL)
                        squadPasswordEntry:SetPlaceholderText(" ")
                        squadPasswordEntry:SetPaintBackground(false)
                        squadPasswordEntry:SetTextColor(MenuAlias.whiteColor)
                        squadPasswordEntry:SetCursorColor(MenuAlias.whiteColor)
                        squadPasswordEntry:RequestFocus()

                        squadPasswordEntry.Think = function(self) squadPasswordEntry:RequestFocus() end

                        squadPasswordEntry.OnEnter = function(self)

                            RunConsoleCommand("efgm_squad_join", name, self:GetValue())

                        end

                    end

                end

                squadEntry.OnCursorExited = function(s)

                    if IsValid(squadPopOut) then

                        squadPopOut:AlphaTo(0, 0.1, 0, function() squadPopOut:Remove() end)

                    end

                end

            end

        end

        local currentSquadPanel = vgui.Create("DPanel", squadPanel)
        currentSquadPanel:Dock(TOP)
        currentSquadPanel:SetSize(EFGM.MenuScale(320), EFGM.MenuScale(320))
        currentSquadPanel:DockMargin(0, EFGM.MenuScale(50), 0, 0)
        currentSquadPanel.Paint = function(s, w, h)

            surface.SetDrawColor(MenuAlias.transparent)
            surface.DrawRect(0, 0, w, h)

        end

        local function RenderCurrentSquad(array)

            if squad == "nil" then return end

            local name = squad
            local color = array[squad].COLOR
            local owner = array[squad].OWNER
            local status
            local password = array[squad].PASSWORD
            local limit = array[squad].LIMIT
            local members = array[squad].MEMBERS
            local memberCount = table.Count(array[squad].MEMBERS)
            local protected = string.len(password) != 0

            if !protected then status = "PUBLIC" else status = "PRIVATE" end

            local currentSquadName = vgui.Create("DPanel", currentSquadPanel)
            currentSquadName:Dock(TOP)
            currentSquadName:SetSize(0, EFGM.MenuScale(60))
            function currentSquadName:Paint(w, h)

                surface.SetDrawColor(Color(0, 0, 0, 155))
                surface.DrawRect(0, 0, w, h)

                surface.SetDrawColor(Color(color.RED, color.GREEN, color.BLUE, 45))
                surface.DrawRect(0, 0, w, h)

                surface.SetDrawColor(Color(color.RED, color.GREEN, color.BLUE, 255))
                surface.DrawRect(0, 0, w, EFGM.MenuScale(5))

                surface.SetDrawColor(Color(255, 255, 255, 155))
                surface.DrawRect(0, 0, w, EFGM.MenuScale(1))
                surface.DrawRect(0, 0, EFGM.MenuScale(1), h)
                surface.DrawRect(w - EFGM.MenuScale(1), 0, EFGM.MenuScale(1), h)

                draw.SimpleTextOutlined(squad, "PuristaBold32", w / 2, EFGM.MenuScale(5), MenuAlias.whiteColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 1, MenuAlias.blackColor)
                draw.SimpleTextOutlined(status, "PuristaBold18", w / 2, EFGM.MenuScale(37), MenuAlias.whiteColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 1, MenuAlias.blackColor)

            end

            -- allows squad owners to copy the squad password if the squad is private
            if status == "PRIVATE" and Menu.Player == owner then

                currentSquadName:SetSize(0, EFGM.MenuScale(77))

                local currentSquadPasswordButton = vgui.Create("DButton", currentSquadName)
                currentSquadPasswordButton:SetPos(EFGM.MenuScale(100), EFGM.MenuScale(57))
                currentSquadPasswordButton:SetSize(EFGM.MenuScale(120), EFGM.MenuScale(18))
                currentSquadPasswordButton:SetText("")
                currentSquadPasswordButton.Paint = function(s, w, h)

                    surface.SetDrawColor(Color(25, 25, 25, 155))
                    surface.DrawRect(0, 0, w, h)

                    draw.SimpleTextOutlined("Copy Password", "PuristaBold18", w / 2, EFGM.MenuScale(-2), MenuAlias.whiteColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 1, MenuAlias.blackColor)

                end

                function currentSquadPasswordButton:OnCursorEntered()

                    surface.PlaySound("ui/element_hover.wav")

                end

                function currentSquadPasswordButton:DoClick()

                    surface.PlaySound("ui/element_select.wav")

                    SetClipboardText(password)

                end

            end

            local currentSquadMembers = vgui.Create("DPanel", currentSquadPanel)
            currentSquadMembers:Dock(TOP)
            currentSquadMembers:SetSize(0, EFGM.MenuScale(30) + (memberCount * EFGM.MenuScale(35)))
            function currentSquadMembers:Paint(w, h)

                surface.SetDrawColor(Color(color.RED, color.GREEN, color.BLUE, 10))
                surface.DrawRect(0, 0, w, h)

                surface.SetDrawColor(Color(255, 255, 255, 155))
                surface.DrawRect(0, 0, EFGM.MenuScale(1), h)
                surface.DrawRect(w - EFGM.MenuScale(1), 0, EFGM.MenuScale(1), h)

                draw.SimpleTextOutlined("MEMBERS", "PuristaBold24", EFGM.MenuScale(5), EFGM.MenuScale(0), MenuAlias.whiteColor, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP, 1, MenuAlias.blackColor)

                for k, v in SortedPairs(members) do

                    if v == owner then

                        draw.SimpleTextOutlined(v:GetName() .. "*", "PuristaBold24", EFGM.MenuScale(40), (k * EFGM.MenuScale(35)) - EFGM.MenuScale(3), MenuAlias.whiteColor, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP, 1, MenuAlias.blackColor)
                    else

                        draw.SimpleTextOutlined(v:GetName(), "PuristaBold24", EFGM.MenuScale(40), (k * EFGM.MenuScale(35)) - EFGM.MenuScale(3), MenuAlias.whiteColor, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP, 1, MenuAlias.blackColor)

                    end

                end

            end

            -- draw profile pictures and create kick/transfer buttons for each member
            for k, v in SortedPairs(members) do

                local memberPFP = vgui.Create("AvatarImage", currentSquadMembers)
                memberPFP:SetPos(EFGM.MenuScale(5), (k * EFGM.MenuScale(35)) - EFGM.MenuScale(5))
                memberPFP:SetSize(EFGM.MenuScale(30), EFGM.MenuScale(30))
                memberPFP:SetPlayer(v, 184)

                memberPFP.OnMousePressed = function()
                    local dropdown = DermaMenu()

                    local profile = dropdown:AddOption("Open Steam Profile", function() gui.OpenURL("http://steamcommunity.com/profiles/" .. v:SteamID64()) end)
                    profile:SetIcon("icon16/page_find.png")

                    dropdown:AddSpacer()

                    local copy = dropdown:AddSubMenu("Copy...")
                    copy:AddOption("Copy Name", function() SetClipboardText(v:GetName()) end):SetIcon("icon16/cut.png")
                    copy:AddOption("Copy SteamID64", function() SetClipboardText(v:SteamID64()) end):SetIcon("icon16/cut.png")

                    if v != Menu.Player then

                        local mute = dropdown:AddOption("Mute Player", function(self)

                            if v:IsMuted() then

                                v:SetMuted(false)

                            else

                                v:SetMuted(true)

                            end

                        end)

                        if v:IsMuted() then

                            mute:SetIcon("icon16/sound.png")
                            mute:SetText("Unmute Player")
                        else

                            mute:SetIcon("icon16/sound_mute.png")
                            mute:SetText("Mute Player")

                        end

                    end

                    dropdown:Open()
                end

                if Menu.Player == owner and Menu.Player != v then

                    local transferToMember = vgui.Create("DImageButton", currentSquadMembers)
                    transferToMember:SetPos(EFGM.MenuScale(262), (k * EFGM.MenuScale(35)) - EFGM.MenuScale(2))
                    transferToMember:SetSize(EFGM.MenuScale(24), EFGM.MenuScale(24))
                    transferToMember:SetImage("icons/squad_transfer_icon.png")
                    transferToMember:SetDepressImage(false)

                    local x, y = 0, 0
                    local sideH, sideV

                    transferToMember.OnCursorEntered = function(s)

                        x, y = Menu.MouseX, Menu.MouseY
                        surface.PlaySound("ui/element_hover.wav")

                        if x <= (ScrW() / 2) then sideH = true else sideH = false end
                        if y <= (ScrH() / 2) then sideV = true else sideV = false end

                        surface.SetFont("Purista18")
                        local text = "Transfer ownership to " .. v:GetName()
                        local textSize = surface.GetTextSize(text)

                        local function UpdatePopOutPos()

                            if sideH == true then

                                transferPopOut:SetX(math.Clamp(x + EFGM.MenuScale(15), EFGM.MenuScale(10), ScrW() - transferPopOut:GetWide() - EFGM.MenuScale(10)))

                            else

                                transferPopOut:SetX(math.Clamp(x - transferPopOut:GetWide() - EFGM.MenuScale(15), EFGM.MenuScale(10), ScrW() - transferPopOut:GetWide() - EFGM.MenuScale(10)))

                            end

                            if sideV == true then

                                transferPopOut:SetY(math.Clamp(y + EFGM.MenuScale(15), EFGM.MenuScale(60), ScrH() - transferPopOut:GetTall() - EFGM.MenuScale(20)))

                            else

                                transferPopOut:SetY(math.Clamp(y - transferPopOut:GetTall() + EFGM.MenuScale(15), EFGM.MenuScale(60), ScrH() - transferPopOut:GetTall() - EFGM.MenuScale(20)))

                            end

                        end

                        if IsValid(transferPopOut) then transferPopOut:Remove() end
                        transferPopOut = vgui.Create("DPanel", Menu.MenuFrame)
                        transferPopOut:SetSize(EFGM.MenuScale(10) + textSize, EFGM.MenuScale(24))
                        UpdatePopOutPos()
                        transferPopOut:AlphaTo(255, 0.1, 0, nil)
                        transferPopOut:SetMouseInputEnabled(false)

                        transferPopOut.Paint = function(s, w, h)

                            if !IsValid(s) then return end

                            BlurPanel(s, EFGM.MenuScale(3))

                            -- panel position follows mouse position
                            x, y = Menu.MouseX, Menu.MouseY

                            UpdatePopOutPos()

                            surface.SetDrawColor(Color(25, 25, 25, 155))
                            surface.DrawRect(0, 0, w, h)

                            surface.SetDrawColor(Color(255, 255, 255, 155))
                            surface.DrawRect(0, 0, w, EFGM.MenuScale(1))
                            surface.DrawRect(0, h - EFGM.MenuScale(1), w, EFGM.MenuScale(1))
                            surface.DrawRect(0, 0, EFGM.MenuScale(1), h)
                            surface.DrawRect(w - EFGM.MenuScale(1), 0, EFGM.MenuScale(1), h)

                            draw.SimpleTextOutlined(text, "Purista18", EFGM.MenuScale(5), EFGM.MenuScale(2), MenuAlias.whiteColor, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP, 1, MenuAlias.blackColor)

                        end

                    end

                    transferToMember.OnCursorExited = function(s)

                        if IsValid(transferPopOut) then

                            transferPopOut:AlphaTo(0, 0.1, 0, function() transferPopOut:Remove() end)

                        end

                    end

                    function transferToMember:DoClick()

                        surface.PlaySound("ui/element_select.wav")

                        RunConsoleCommand("efgm_squad_transfer", v:GetName())

                    end

                    local kickMember = vgui.Create("DImageButton", currentSquadMembers)
                    kickMember:SetPos(EFGM.MenuScale(291), (k * EFGM.MenuScale(35)) - EFGM.MenuScale(2))
                    kickMember:SetSize(EFGM.MenuScale(24), EFGM.MenuScale(24))
                    kickMember:SetImage("icons/squad_kick_icon.png")
                    kickMember:SetDepressImage(false)

                    kickMember.OnCursorEntered = function(s)

                        x, y = Menu.MouseX, Menu.MouseY
                        surface.PlaySound("ui/element_hover.wav")

                        if x <= (ScrW() / 2) then sideH = true else sideH = false end
                        if y <= (ScrH() / 2) then sideV = true else sideV = false end

                        surface.SetFont("Purista18")
                        local text = "Kick " .. v:GetName()
                        local textSize = surface.GetTextSize(text)

                        local function UpdatePopOutPos()

                            if sideH == true then

                                kickPopOut:SetX(math.Clamp(x + EFGM.MenuScale(15), EFGM.MenuScale(10), ScrW() - kickPopOut:GetWide() - EFGM.MenuScale(10)))

                            else

                                kickPopOut:SetX(math.Clamp(x - kickPopOut:GetWide() - EFGM.MenuScale(15), EFGM.MenuScale(10), ScrW() - kickPopOut:GetWide() - EFGM.MenuScale(10)))

                            end

                            if sideV == true then

                                kickPopOut:SetY(math.Clamp(y + EFGM.MenuScale(15), EFGM.MenuScale(60), ScrH() - kickPopOut:GetTall() - EFGM.MenuScale(20)))

                            else

                                kickPopOut:SetY(math.Clamp(y - kickPopOut:GetTall() + EFGM.MenuScale(15), EFGM.MenuScale(60), ScrH() - kickPopOut:GetTall() - EFGM.MenuScale(20)))

                            end

                        end

                        if IsValid(kickPopOut) then kickPopOut:Remove() end
                        kickPopOut = vgui.Create("DPanel", Menu.MenuFrame)
                        kickPopOut:SetSize(EFGM.MenuScale(10) + textSize, EFGM.MenuScale(24))
                        UpdatePopOutPos()
                        kickPopOut:AlphaTo(255, 0.1, 0, nil)
                        kickPopOut:SetMouseInputEnabled(false)

                        kickPopOut.Paint = function(s, w, h)

                            if !IsValid(s) then return end

                            BlurPanel(s, EFGM.MenuScale(3))

                            -- panel position follows mouse position
                            x, y = Menu.MouseX, Menu.MouseY

                            UpdatePopOutPos()

                            surface.SetDrawColor(Color(25, 25, 25, 155))
                            surface.DrawRect(0, 0, w, h)

                            surface.SetDrawColor(Color(255, 255, 255, 155))
                            surface.DrawRect(0, 0, w, EFGM.MenuScale(1))
                            surface.DrawRect(0, h - EFGM.MenuScale(1), w, EFGM.MenuScale(1))
                            surface.DrawRect(0, 0, EFGM.MenuScale(1), h)
                            surface.DrawRect(w - EFGM.MenuScale(1), 0, EFGM.MenuScale(1), h)

                            draw.SimpleTextOutlined(text, "Purista18", EFGM.MenuScale(5), EFGM.MenuScale(2), MenuAlias.whiteColor, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP, 1, MenuAlias.blackColor)

                        end

                    end

                    kickMember.OnCursorExited = function(s)

                        if IsValid(kickPopOut) then

                            kickPopOut:AlphaTo(0, 0.1, 0, function() kickPopOut:Remove() end)

                        end

                    end

                    function kickMember:DoClick()

                        surface.PlaySound("ui/element_select.wav")

                        RunConsoleCommand("efgm_squad_kick", v:GetName())

                    end

                end

            end

            local currentSquadLeavePanel = vgui.Create("DPanel", currentSquadPanel)
            currentSquadLeavePanel:Dock(TOP)
            currentSquadLeavePanel:SetSize(0, EFGM.MenuScale(35))
            function currentSquadLeavePanel:Paint(w, h)

                surface.SetDrawColor(Color(color.RED, color.GREEN, color.BLUE, 10))
                surface.DrawRect(0, 0, w, h)

                surface.SetDrawColor(Color(255, 255, 255, 155))
                surface.DrawRect(0, h - EFGM.MenuScale(1), w, EFGM.MenuScale(1))
                surface.DrawRect(0, 0, EFGM.MenuScale(1), h)
                surface.DrawRect(w - EFGM.MenuScale(1), 0, EFGM.MenuScale(1), h)

            end

            local currentSquadLeaveButton = vgui.Create("DButton", currentSquadLeavePanel)
            currentSquadLeaveButton:SetPos(EFGM.MenuScale(85), EFGM.MenuScale(5))
            currentSquadLeaveButton:SetSize(EFGM.MenuScale(150), EFGM.MenuScale(25))
            currentSquadLeaveButton:SetText("")
            currentSquadLeaveButton.Paint = function(s, w, h)

                surface.SetDrawColor(Color(25, 25, 25, 155))
                surface.DrawRect(0, 0, w, h)

                if owner != Menu.Player then

                    draw.SimpleTextOutlined("Leave Squad", "PuristaBold24", w / 2, EFGM.MenuScale(-2), MenuAlias.whiteColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 1, MenuAlias.blackColor)

                else

                    draw.SimpleTextOutlined("Disband Squad", "PuristaBold24", w / 2, EFGM.MenuScale(-2), MenuAlias.whiteColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 1, MenuAlias.blackColor)

                end

            end

            function currentSquadLeaveButton:OnCursorEntered()

                surface.PlaySound("ui/element_hover.wav")

            end

            function currentSquadLeaveButton:DoClick()

                surface.PlaySound("ui/element_deselect.wav")

                if owner != Menu.Player then

                    RunConsoleCommand("efgm_squad_leave")

                else

                    RunConsoleCommand("efgm_squad_disband")

                end

            end

        end

        net.Receive("SendSquadData", function(len, ply)

            squad = Menu.Player:GetNW2String("PlayerInSquad", nil)

            availableSquadsList:Clear()
            currentSquadPanel:Clear()

            if squad == "nil" then

                -- enable squad create button if client is not/no longer in a squad
                squadCreateButton:Show()

            else

                -- disable squad create button if client is a member of a squad
                squadCreateButton:Hide()

            end

            if IsValid(squadPopOut) then squadPopOut:Remove() end

            squadArray = table.Copy(net.ReadTable())
            GenerateJoinableSquads(squadArray)
            RenderCurrentSquad(squadArray)

        end )

        net.Start("GrabSquadData")
        net.SendToServer()

    end

end

function Menu.OpenTab.Stats()

    local contents = vgui.Create("DPanel", Menu.MenuFrame.LowerPanel)
    contents:Dock(FILL)
    contents:DockPadding(EFGM.MenuScale(10), EFGM.MenuScale(10), EFGM.MenuScale(10), EFGM.MenuScale(10))
    contents:SetAlpha(0)
    contents.Paint = function(s, w, h)

        surface.SetDrawColor(MenuAlias.transparent)
        surface.DrawRect(0, 0, w, h)

    end

    Menu.MenuFrame.LowerPanel.Contents = contents

    local stats = vgui.Create("DScrollPanel", contents)
    stats:Dock(LEFT)
    stats:SetSize(EFGM.MenuScale(320), 0)
    stats.Paint = function(s, w, h)

        surface.SetDrawColor(MenuAlias.transparent)
        surface.DrawRect(0, 0, w, h)

    end

    local statsTitle = vgui.Create("DPanel", stats)
    statsTitle:Dock(TOP)
    statsTitle:SetSize(0, EFGM.MenuScale(32))
    function statsTitle:Paint(w, h)

        surface.SetDrawColor(MenuAlias.transparent)
        surface.DrawRect(0, 0, w, h)

        draw.SimpleTextOutlined("STATISTICS", "PuristaBold32", w / 2, 0, MenuAlias.whiteColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 1, MenuAlias.blackColor)

    end

    local statsBar = stats:GetVBar()
    statsBar:SetHideButtons(true)
    statsBar:SetSize(EFGM.MenuScale(15), EFGM.MenuScale(15))
    function statsBar:Paint(w, h)
        draw.RoundedBox(0, EFGM.MenuScale(5), EFGM.MenuScale(8), EFGM.MenuScale(5), h - EFGM.MenuScale(16), Color(0, 0, 0, 50))
    end
    function statsBar.btnGrip:Paint(w, h)
        draw.RoundedBox(0, EFGM.MenuScale(5), EFGM.MenuScale(8), EFGM.MenuScale(5), h - EFGM.MenuScale(16), Color(255, 255, 255, 155))
    end

    local importantStats = vgui.Create("DPanel", stats)
    importantStats:Dock(TOP)
    importantStats:SetSize(0, EFGM.MenuScale(500))
    importantStats.Paint = function(s, w, h)

        surface.SetDrawColor(MenuAlias.transparent)
        surface.DrawRect(0, 0, w, h)

    end

    local playerInfo = vgui.Create("DPanel", contents)
    playerInfo:Dock(TOP)
    playerInfo:SetSize(0, EFGM.MenuScale(300))
    playerInfo.Paint = function(s, w, h)

        surface.SetDrawColor(MenuAlias.transparent)
        surface.DrawRect(0, 0, w, h)

    end

    -- only temporary, I gotta find a way to automate this shit

    local stats = {}

    stats.Level = Menu.Player:GetNWInt("Level")
    stats.Experience = Menu.Player:GetNWInt("Experience")
    stats.MoneyEarned = Menu.Player:GetNWInt("MoneyEarned")
    stats.MoneySpent = Menu.Player:GetNWInt("MoneySpent")
    stats.Time = Menu.Player:GetNWInt("Time")
    stats.StashValue = Menu.Player:GetNWInt("StashValue")

    stats.Kills = Menu.Player:GetNWInt("Kills")
    stats.Deaths = Menu.Player:GetNWInt("Deaths")
    stats.Suicides = Menu.Player:GetNWInt("Suicides")
    stats.DamageDealt = Menu.Player:GetNWInt("DamageDealt")
    stats.DamageRecieved = Menu.Player:GetNWInt("DamageRecieved")
    stats.DamageHealed = Menu.Player:GetNWInt("DamageHealed")
    stats.Headshots = Menu.Player:GetNWInt("Headshots")
    stats.FarthestKill = Menu.Player:GetNWInt("FarthestKill")
    stats.Extractions = Menu.Player:GetNWInt("Extractions")
    stats.Quits = Menu.Player:GetNWInt("Quits")
    stats.RaidsPlayed = Menu.Player:GetNWInt("RaidsPlayed")

    stats.CurrentKillStreak = Menu.Player:GetNWInt("CurrentKillStreak") 
    stats.BestKillStreak = Menu.Player:GetNWInt("BestKillStreak")
    stats.CurrentExtractionStreak = Menu.Player:GetNWInt("CurrentExtractionStreak")
    stats.BestExtractionStreak = Menu.Player:GetNWInt("BestExtractionStreak")

    for k, v in SortedPairs(stats) do

        local statEntry = vgui.Create("DPanel", importantStats)
        statEntry:Dock(TOP)
        statEntry:SetSize(0, EFGM.MenuScale(20))
        function statEntry:Paint(w, h)

            surface.SetDrawColor(MenuAlias.transparent)
            surface.DrawRect(0, 0, w, h)

            draw.SimpleTextOutlined(k .. "", "Purista18", 0, 0, MenuAlias.whiteColor, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP, 1, MenuAlias.blackColor)
            draw.SimpleTextOutlined(math.Round(v), "Purista18", w, 0, MenuAlias.whiteColor, TEXT_ALIGN_RIGHT, TEXT_ALIGN_TOP, 1, MenuAlias.blackColor)

        end

    end

end

function Menu.OpenTab.Skills()

    local contents = vgui.Create("DPanel", Menu.MenuFrame.LowerPanel)
    contents:Dock(FILL)
    contents:DockPadding(EFGM.MenuScale(10), EFGM.MenuScale(10), EFGM.MenuScale(10), EFGM.MenuScale(10))
    contents:SetAlpha(0)
    contents.Paint = function(s, w, h)

        surface.SetDrawColor(MenuAlias.transparent)
        surface.DrawRect(0, 0, w, h)

    end

    Menu.MenuFrame.LowerPanel.Contents = contents

    local skills = vgui.Create("DScrollPanel", contents)
    skills:Dock(FILL)
    skills.Paint = function(s, w, h)

        surface.SetDrawColor(MenuAlias.transparent)
        surface.DrawRect(0, 0, w, h)

    end

    local skillsTitle = vgui.Create("DPanel", skills)
    skillsTitle:Dock(TOP)
    skillsTitle:SetSize(0, EFGM.MenuScale(32))
    function skillsTitle:Paint(w, h)

        surface.SetDrawColor(MenuAlias.transparent)
        surface.DrawRect(0, 0, w, h)

        draw.SimpleTextOutlined("SKILLS", "PuristaBold32", 265, 0, MenuAlias.whiteColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 1, MenuAlias.blackColor)

    end

    local skillsBar = skills:GetVBar()
    skillsBar:SetHideButtons(true)
    skillsBar:SetSize(EFGM.MenuScale(15), EFGM.MenuScale(15))
    function skillsBar:Paint(w, h)
        draw.RoundedBox(0, EFGM.MenuScale(5), EFGM.MenuScale(8), EFGM.MenuScale(5), h - EFGM.MenuScale(16), Color(0, 0, 0, 50))
    end
    function skillsBar.btnGrip:Paint(w, h)
        draw.RoundedBox(0, EFGM.MenuScale(5), EFGM.MenuScale(8), EFGM.MenuScale(5), h - EFGM.MenuScale(16), Color(255, 255, 255, 155))
    end

    local skillsList = vgui.Create("DIconLayout", skills)
    skillsList:Dock(LEFT)
    skillsList:SetSize(EFGM.MenuScale(530), 0)
    skillsList:SetSpaceY(EFGM.MenuScale(20))
    skillsList:SetSpaceX(EFGM.MenuScale(20))
    skillsList.Paint = function(s, w, h)

        surface.SetDrawColor(MenuAlias.transparent)
        surface.DrawRect(0, 0, w, h)

    end

    local skillTypeTbl = {
        ["Combat"] = Color(155, 75, 75), -- combat
        ["Mental"] = Color(0, 155, 0, 128), -- mental
        ["Physical"] = Color(45, 165, 165, 128),  -- physical
        ["Practical"] = Color(155, 155, 0, 128)  -- practical
    }

    for k1, v1 in pairs(Skills) do

        local skillItem = skillsList:Add("DButton")
        skillItem:SetSize(EFGM.MenuScale(90), EFGM.MenuScale(90))
        skillItem.Paint = function(s, w, h)

            surface.SetDrawColor(MenuAlias.whiteColor)
            surface.DrawRect(0, 0, w, h)

        end

        local skillIcon = vgui.Create("DImage", skillItem)
        skillIcon:SetPos(EFGM.MenuScale(3), EFGM.MenuScale(3))
        skillIcon:SetSize(EFGM.MenuScale(84), EFGM.MenuScale(84))
        skillIcon:SetImage(v1.Icon)

        local skillText = vgui.Create("DPanel", skillIcon)
        skillText:Dock(FILL)
        skillText.Paint = function(s, w, h)

            draw.SimpleTextOutlined("1", "PuristaBold32", EFGM.MenuScale(4), EFGM.MenuScale(52), MenuAlias.whiteColor, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP, 1, MenuAlias.blackColor)
            draw.SimpleTextOutlined("0/10", "Purista18", w - EFGM.MenuScale(4), EFGM.MenuScale(64), MenuAlias.whiteColor, TEXT_ALIGN_RIGHT, TEXT_ALIGN_TOP, 1, MenuAlias.blackColor)

        end

        local x, y = 0, 0
        local sideH, sideV

        skillItem.OnCursorEntered = function(s)

            x, y = Menu.MouseX, Menu.MouseY
            surface.PlaySound("ui/element_hover.wav")

            if x <= (ScrW() / 2) then sideH = true else sideH = false end
            if y <= (ScrH() / 2) then sideV = true else sideV = false end

            surface.SetFont("Purista18")
            local skillDescTextSize = surface.GetTextSize(v1.Description)

            local function UpdatePopOutPos()

                if sideH == true then

                    skillPopOut:SetX(math.Clamp(x + EFGM.MenuScale(15), EFGM.MenuScale(10), ScrW() - skillPopOut:GetWide() - EFGM.MenuScale(10)))

                else

                    skillPopOut:SetX(math.Clamp(x - skillPopOut:GetWide() - EFGM.MenuScale(15), EFGM.MenuScale(10), ScrW() - skillPopOut:GetWide() - EFGM.MenuScale(10)))

                end

                if sideV == true then

                    skillPopOut:SetY(math.Clamp(y + EFGM.MenuScale(15), EFGM.MenuScale(60), ScrH() - skillPopOut:GetTall() - EFGM.MenuScale(20)))

                else

                    skillPopOut:SetY(math.Clamp(y - skillPopOut:GetTall() + EFGM.MenuScale(15), EFGM.MenuScale(60), ScrH() - skillPopOut:GetTall() - EFGM.MenuScale(20)))

                end

            end

            if IsValid(skillPopOut) then skillPopOut:Remove() end
            skillPopOut = vgui.Create("DPanel", Menu.MenuFrame)
            skillPopOut:SetSize(EFGM.MenuScale(10) + skillDescTextSize, EFGM.MenuScale(80))
            UpdatePopOutPos()
            skillPopOut:AlphaTo(255, 0.1, 0, nil)
            skillPopOut:SetMouseInputEnabled(false)

            skillPopOut.Paint = function(s, w, h)

                if !IsValid(s) then return end

                BlurPanel(s, EFGM.MenuScale(3))

                -- panel position follows mouse position
                x, y = Menu.MouseX, Menu.MouseY

                UpdatePopOutPos()

                surface.SetDrawColor(Color(0, 0, 0, 205))
                surface.DrawRect(0, 0, w, h)

                skillTypeTbl[v1.Category].a = 45
                surface.SetDrawColor(skillTypeTbl[v1.Category])
                surface.DrawRect(0, 0, w, h)

                skillTypeTbl[v1.Category].a = 255
                surface.SetDrawColor(skillTypeTbl[v1.Category])
                surface.DrawRect(0, 0, w, EFGM.MenuScale(5))

                surface.SetDrawColor(Color(255, 255, 255, 155))
                surface.DrawRect(0, 0, w, EFGM.MenuScale(1))
                surface.DrawRect(0, h - EFGM.MenuScale(1), w, EFGM.MenuScale(1))
                surface.DrawRect(0, 0, EFGM.MenuScale(1), h)
                surface.DrawRect(w - EFGM.MenuScale(1), 0, EFGM.MenuScale(1), h)

                draw.SimpleTextOutlined(string.upper(v1.Name), "PuristaBold24", EFGM.MenuScale(5), EFGM.MenuScale(5), MenuAlias.whiteColor, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP, 1, MenuAlias.blackColor)
                draw.SimpleTextOutlined(string.upper(v1.Category), "Purista18Italic", EFGM.MenuScale(5), EFGM.MenuScale(25), MenuAlias.whiteColor, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP, 1, MenuAlias.blackColor)
                draw.SimpleTextOutlined(v1.Description, "Purista18", EFGM.MenuScale(5), EFGM.MenuScale(55), MenuAlias.whiteColor, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP, 1, MenuAlias.blackColor)
                draw.SimpleTextOutlined("1", "PuristaBold64", w - EFGM.MenuScale(5), EFGM.MenuScale(-10), MenuAlias.whiteColor, TEXT_ALIGN_RIGHT, TEXT_ALIGN_TOP, 1, MenuAlias.blackColor)

            end

        end

        skillItem.OnCursorExited = function(s)

            if IsValid(skillPopOut) then

                skillPopOut:AlphaTo(0, 0.1, 0, function() skillPopOut:Remove() end)

            end

        end

    end

end

function Menu.OpenTab.Settings()

    local contents = vgui.Create("DPanel", Menu.MenuFrame.LowerPanel)
    contents:Dock(FILL)
    contents:DockPadding(EFGM.MenuScale(10), EFGM.MenuScale(10), EFGM.MenuScale(10), EFGM.MenuScale(10))
    contents:SetAlpha(0)
    contents.Paint = function(s, w, h)

        surface.SetDrawColor(MenuAlias.transparent)
        surface.DrawRect(0, 0, w, h)

    end

    Menu.MenuFrame.LowerPanel.Contents = contents

    local gameplay = vgui.Create("DScrollPanel", contents)
    gameplay:Dock(LEFT)
    gameplay:SetSize(EFGM.MenuScale(320), 0)
    gameplay.Paint = function(s, w, h)

        surface.SetDrawColor(MenuAlias.transparent)
        surface.DrawRect(0, 0, w, h)

    end

    local gameplayTitle = vgui.Create("DPanel", gameplay)
    gameplayTitle:Dock(TOP)
    gameplayTitle:SetSize(0, EFGM.MenuScale(32))
    function gameplayTitle:Paint(w, h)

        surface.SetDrawColor(MenuAlias.transparent)
        surface.DrawRect(0, 0, w, h)

        draw.SimpleTextOutlined("GAMEPLAY", "PuristaBold32", w / 2, 0, MenuAlias.whiteColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 1, MenuAlias.blackColor)

    end

    local gameplayBar = gameplay:GetVBar()
    gameplayBar:SetHideButtons(true)
    gameplayBar:SetSize(EFGM.MenuScale(15), EFGM.MenuScale(15))
    function gameplayBar:Paint(w, h)
        draw.RoundedBox(0, EFGM.MenuScale(5), EFGM.MenuScale(8), EFGM.MenuScale(5), h - EFGM.MenuScale(16), Color(0, 0, 0, 50))
    end
    function gameplayBar.btnGrip:Paint(w, h)
        draw.RoundedBox(0, EFGM.MenuScale(5), EFGM.MenuScale(8), EFGM.MenuScale(5), h - EFGM.MenuScale(16), Color(255, 255, 255, 155))
    end

    local controls = vgui.Create("DScrollPanel", contents)
    controls:Dock(LEFT)
    controls:SetSize(EFGM.MenuScale(320), 0)
    controls.Paint = function(s, w, h)

        surface.SetDrawColor(MenuAlias.transparent)
        surface.DrawRect(0, 0, w, h)

    end

    local controlsTitle = vgui.Create("DPanel", controls)
    controlsTitle:Dock(TOP)
    controlsTitle:SetSize(0, EFGM.MenuScale(32))
    function controlsTitle:Paint(w, h)

        surface.SetDrawColor(MenuAlias.transparent)
        surface.DrawRect(0, 0, w, h)

        draw.SimpleTextOutlined("CONTROLS", "PuristaBold32", w / 2, 0, MenuAlias.whiteColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 1, MenuAlias.blackColor)

    end

    local controlsBar = controls:GetVBar()
    controlsBar:SetHideButtons(true)
    controlsBar:SetSize(EFGM.MenuScale(15), EFGM.MenuScale(15))
    function controlsBar:Paint(w, h)
        draw.RoundedBox(0, EFGM.MenuScale(5), EFGM.MenuScale(8), EFGM.MenuScale(5), h - EFGM.MenuScale(16), Color(0, 0, 0, 50))
    end
    function controlsBar.btnGrip:Paint(w, h)
        draw.RoundedBox(0, EFGM.MenuScale(5), EFGM.MenuScale(8), EFGM.MenuScale(5), h - EFGM.MenuScale(16), Color(255, 255, 255, 155))
    end

    local interface = vgui.Create("DScrollPanel", contents)
    interface:Dock(LEFT)
    interface:SetSize(EFGM.MenuScale(320), 0)
    interface.Paint = function(s, w, h)

        surface.SetDrawColor(MenuAlias.transparent)
        surface.DrawRect(0, 0, w, h)

    end

    local interfaceTitle = vgui.Create("DPanel", interface)
    interfaceTitle:Dock(TOP)
    interfaceTitle:SetSize(0, EFGM.MenuScale(32))
    function interfaceTitle:Paint(w, h)

        surface.SetDrawColor(MenuAlias.transparent)
        surface.DrawRect(0, 0, w, h)

        draw.SimpleTextOutlined("INTERFACE", "PuristaBold32", w / 2, 0, MenuAlias.whiteColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 1, MenuAlias.blackColor)

    end

    local interfaceBar = interface:GetVBar()
    interfaceBar:SetHideButtons(true)
    interfaceBar:SetSize(EFGM.MenuScale(15), EFGM.MenuScale(15))
    function interfaceBar:Paint(w, h)
        draw.RoundedBox(0, EFGM.MenuScale(5), EFGM.MenuScale(8), EFGM.MenuScale(5), h - EFGM.MenuScale(16), Color(0, 0, 0, 50))
    end
    function interfaceBar.btnGrip:Paint(w, h)
        draw.RoundedBox(0, EFGM.MenuScale(5), EFGM.MenuScale(8), EFGM.MenuScale(5), h - EFGM.MenuScale(16), Color(255, 255, 255, 155))
    end

    local visuals = vgui.Create("DScrollPanel", contents)
    visuals:Dock(LEFT)
    visuals:SetSize(EFGM.MenuScale(320), 0)
    visuals.Paint = function(s, w, h)

        surface.SetDrawColor(MenuAlias.transparent)
        surface.DrawRect(0, 0, w, h)

    end

    local visualsTitle = vgui.Create("DPanel", visuals)
    visualsTitle:Dock(TOP)
    visualsTitle:SetSize(0, EFGM.MenuScale(32))
    function visualsTitle:Paint(w, h)

        surface.SetDrawColor(MenuAlias.transparent)
        surface.DrawRect(0, 0, w, h)

        draw.SimpleTextOutlined("VISUALS", "PuristaBold32", w / 2, 0, MenuAlias.whiteColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 1, MenuAlias.blackColor)

    end

    local visualsBar = visuals:GetVBar()
    visualsBar:SetHideButtons(true)
    visualsBar:SetSize(EFGM.MenuScale(15), EFGM.MenuScale(15))
    function visualsBar:Paint(w, h)
        draw.RoundedBox(0, EFGM.MenuScale(5), EFGM.MenuScale(8), EFGM.MenuScale(5), h - EFGM.MenuScale(16), Color(0, 0, 0, 50))
    end
    function visualsBar.btnGrip:Paint(w, h)
        draw.RoundedBox(0, EFGM.MenuScale(5), EFGM.MenuScale(8), EFGM.MenuScale(5), h - EFGM.MenuScale(16), Color(255, 255, 255, 155))
    end

    local account = vgui.Create("DScrollPanel", contents)
    account:Dock(LEFT)
    account:SetSize(EFGM.MenuScale(320), 0)
    account.Paint = function(s, w, h)

        surface.SetDrawColor(MenuAlias.transparent)
        surface.DrawRect(0, 0, w, h)

    end

    local accountTitle = vgui.Create("DPanel", account)
    accountTitle:Dock(TOP)
    accountTitle:SetSize(0, EFGM.MenuScale(32))
    function accountTitle:Paint(w, h)

        surface.SetDrawColor(MenuAlias.transparent)
        surface.DrawRect(0, 0, w, h)

        draw.SimpleTextOutlined("ACCOUNT", "PuristaBold32", w / 2, 0, MenuAlias.whiteColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 1, MenuAlias.blackColor)

    end

    local accountBar = account:GetVBar()
    accountBar:SetHideButtons(true)
    accountBar:SetSize(EFGM.MenuScale(15), EFGM.MenuScale(15))
    function accountBar:Paint(w, h)
        draw.RoundedBox(0, EFGM.MenuScale(5), EFGM.MenuScale(8), EFGM.MenuScale(5), h - EFGM.MenuScale(16), Color(0, 0, 0, 50))
    end
    function accountBar.btnGrip:Paint(w, h)
        draw.RoundedBox(0, EFGM.MenuScale(5), EFGM.MenuScale(8), EFGM.MenuScale(5), h - EFGM.MenuScale(16), Color(255, 255, 255, 155))
    end

    local misc = vgui.Create("DScrollPanel", contents)
    misc:Dock(LEFT)
    misc:SetSize(EFGM.MenuScale(260), EFGM.MenuScale(353))
    misc.Paint = function(s, w, h)

        surface.SetDrawColor(MenuAlias.transparent)
        surface.DrawRect(0, 0, w, h)

    end

    local miscTitle = vgui.Create("DPanel", misc)
    miscTitle:Dock(TOP)
    miscTitle:SetSize(0, EFGM.MenuScale(32))
    function miscTitle:Paint(w, h)

        surface.SetDrawColor(MenuAlias.transparent)
        surface.DrawRect(0, 0, w, h)

        draw.SimpleTextOutlined("MISC.", "PuristaBold32", w / 2, 0, MenuAlias.whiteColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 1, MenuAlias.blackColor)

    end

    local miscBar = misc:GetVBar()
    miscBar:SetHideButtons(true)
    miscBar:SetSize(EFGM.MenuScale(15), EFGM.MenuScale(15))
    function miscBar:Paint(w, h)
        draw.RoundedBox(0, EFGM.MenuScale(5), EFGM.MenuScale(8), EFGM.MenuScale(5), h - EFGM.MenuScale(16), Color(0, 0, 0, 50))
    end
    function miscBar.btnGrip:Paint(w, h)
        draw.RoundedBox(0, EFGM.MenuScale(5), EFGM.MenuScale(8), EFGM.MenuScale(5), h - EFGM.MenuScale(16), Color(255, 255, 255, 155))
    end

    -- settings go below

    -- gameplay

    local toggleADSPanel = vgui.Create("DPanel", gameplay)
    toggleADSPanel:Dock(TOP)
    toggleADSPanel:SetSize(0, EFGM.MenuScale(50))
    function toggleADSPanel:Paint(w, h)

        draw.SimpleTextOutlined("Toggle Aim Down Sights", "Purista18", w / 2, EFGM.MenuScale(5), MenuAlias.whiteColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 1, MenuAlias.blackColor)

    end

    local toggleADS = vgui.Create("DCheckBox", toggleADSPanel)
    toggleADS:SetPos(EFGM.MenuScale(152), EFGM.MenuScale(30))
    toggleADS:SetConVar("arc9_toggleads")
    toggleADS:SetSize(EFGM.MenuScale(15), EFGM.MenuScale(15))


    local toggleLeanPanel = vgui.Create("DPanel", gameplay)
    toggleLeanPanel:Dock(TOP)
    toggleLeanPanel:SetSize(0, EFGM.MenuScale(50))
    function toggleLeanPanel:Paint(w, h)

        draw.SimpleTextOutlined("Toggle Leaning", "Purista18", w / 2, EFGM.MenuScale(5), MenuAlias.whiteColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 1, MenuAlias.blackColor)

    end

    local toggleLean = vgui.Create("DCheckBox", toggleLeanPanel)
    toggleLean:SetPos(EFGM.MenuScale(152), EFGM.MenuScale(30))
    toggleLean:SetConVar("efgm_controls_togglelean")
    toggleLean:SetSize(EFGM.MenuScale(15), EFGM.MenuScale(15))

    local musicPanel = vgui.Create("DPanel", gameplay)
    musicPanel:Dock(TOP)
    musicPanel:SetSize(0, EFGM.MenuScale(50))
    function musicPanel:Paint(w, h)

        draw.SimpleTextOutlined("Music", "Purista18", w / 2, EFGM.MenuScale(5), MenuAlias.whiteColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 1, MenuAlias.blackColor)

    end

    local music = vgui.Create("DCheckBox", musicPanel)
    music:SetPos(EFGM.MenuScale(152), EFGM.MenuScale(30))
    music:SetConVar("efgm_music")
    music:SetSize(EFGM.MenuScale(15), EFGM.MenuScale(15))

    local musicVolumePanel = vgui.Create("DPanel", gameplay)
    musicVolumePanel:Dock(TOP)
    musicVolumePanel:SetSize(0, EFGM.MenuScale(50))
    function musicVolumePanel:Paint(w, h)

        draw.SimpleTextOutlined("Music Volume", "Purista18", w / 2, EFGM.MenuScale(5), MenuAlias.whiteColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 1, MenuAlias.blackColor)

    end

    local musicVolume = vgui.Create("DNumSlider", musicVolumePanel)
    musicVolume:SetPos(EFGM.MenuScale(35), EFGM.MenuScale(30))
    musicVolume:SetSize(EFGM.MenuScale(200), EFGM.MenuScale(15))
    musicVolume:SetConVar("efgm_musicvolume")
    musicVolume:SetMin(0)
    musicVolume:SetMax(2)
    musicVolume:SetDecimals(2)

    -- controls

    local adsSensPanel = vgui.Create("DPanel", controls)
    adsSensPanel:Dock(TOP)
    adsSensPanel:SetSize(0, EFGM.MenuScale(50))
    function adsSensPanel:Paint(w, h)

        draw.SimpleTextOutlined("Aim Down Sights Sensitivity", "Purista18", w / 2, EFGM.MenuScale(5), MenuAlias.whiteColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 1, MenuAlias.blackColor)

    end

    local adsSens = vgui.Create("DNumSlider", adsSensPanel)
    adsSens:SetPos(EFGM.MenuScale(33), EFGM.MenuScale(30))
    adsSens:SetSize(EFGM.MenuScale(200), EFGM.MenuScale(15))
    adsSens:SetConVar("arc9_mult_sens")
    adsSens:SetMin(0)
    adsSens:SetMax(2)
    adsSens:SetDecimals(2)

    local gradualADSPanel = vgui.Create("DPanel", controls)
    gradualADSPanel:Dock(TOP)
    gradualADSPanel:SetSize(0, EFGM.MenuScale(50))
    function gradualADSPanel:Paint(w, h)

        draw.SimpleTextOutlined("Gradual Aim Down Sights Sensitivity", "Purista18", w / 2, EFGM.MenuScale(5), MenuAlias.whiteColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 1, MenuAlias.blackColor)

    end

    local gradualADS = vgui.Create("DCheckBox", gradualADSPanel)
    gradualADS:SetPos(EFGM.MenuScale(152), EFGM.MenuScale(30))
    gradualADS:SetConVar("arc9_gradual_sens")
    gradualADS:SetSize(EFGM.MenuScale(15), EFGM.MenuScale(15))

    local magnificationCompensationPanel = vgui.Create("DPanel", controls)
    magnificationCompensationPanel:Dock(TOP)
    magnificationCompensationPanel:SetSize(0, EFGM.MenuScale(50))
    function magnificationCompensationPanel:Paint(w, h)

        draw.SimpleTextOutlined("Scale Sensitivity With Magnification", "Purista18", w / 2, EFGM.MenuScale(5), MenuAlias.whiteColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 1, MenuAlias.blackColor)

    end

    local magnificationCompensation = vgui.Create("DCheckBox", magnificationCompensationPanel)
    magnificationCompensation:SetPos(EFGM.MenuScale(152), EFGM.MenuScale(30))
    magnificationCompensation:SetConVar("arc9_compensate_sens")
    magnificationCompensation:SetSize(EFGM.MenuScale(15), EFGM.MenuScale(15))

    local gameMenuPanel = vgui.Create("DPanel", controls)
    gameMenuPanel:Dock(TOP)
    gameMenuPanel:SetSize(0, EFGM.MenuScale(55))
    function gameMenuPanel:Paint(w, h)

        draw.SimpleTextOutlined("Game Menu keybind", "Purista18", w / 2, EFGM.MenuScale(5), MenuAlias.whiteColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 1, MenuAlias.blackColor)

    end

    local gameMenu = vgui.Create("DBinder", gameMenuPanel)
    gameMenu:SetPos(EFGM.MenuScale(110), EFGM.MenuScale(30))
    gameMenu:SetSize(EFGM.MenuScale(100), EFGM.MenuScale(20))
    gameMenu:SetSelectedNumber(GetConVar("efgm_bind_menu"):GetInt())
    function gameMenu:OnChange(num)
        RunConsoleCommand("efgm_bind_menu", gameMenu:GetSelectedNumber())
    end

    local showCompassPanel = vgui.Create("DPanel", controls)
    showCompassPanel:Dock(TOP)
    showCompassPanel:SetSize(0, EFGM.MenuScale(55))
    function showCompassPanel:Paint(w, h)

        draw.SimpleTextOutlined("Show Compass keybind", "Purista18", w / 2, EFGM.MenuScale(5), MenuAlias.whiteColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 1, MenuAlias.blackColor)

    end

    local showCompass = vgui.Create("DBinder", showCompassPanel)
    showCompass:SetPos(EFGM.MenuScale(110), EFGM.MenuScale(30))
    showCompass:SetSize(EFGM.MenuScale(100), EFGM.MenuScale(20))
    showCompass:SetSelectedNumber(GetConVar("efgm_bind_showcompass"):GetInt())
    function showCompass:OnChange(num)

        RunConsoleCommand("efgm_bind_showcompass", showCompass:GetSelectedNumber())

    end

    local showRaidInfoPanel = vgui.Create("DPanel", controls)
    showRaidInfoPanel:Dock(TOP)
    showRaidInfoPanel:SetSize(0, EFGM.MenuScale(55))
    function showRaidInfoPanel:Paint(w, h)

        draw.SimpleTextOutlined("Show Extracts keybind", "Purista18", w / 2, EFGM.MenuScale(5), MenuAlias.whiteColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 1, MenuAlias.blackColor)

    end

    local showRaidInfo = vgui.Create("DBinder", showRaidInfoPanel)
    showRaidInfo:SetPos(EFGM.MenuScale(110), EFGM.MenuScale(30))
    showRaidInfo:SetSize(EFGM.MenuScale(100), EFGM.MenuScale(20))
    showRaidInfo:SetSelectedNumber(GetConVar("efgm_bind_raidinfo"):GetInt())
    function showRaidInfo:OnChange(num)

        RunConsoleCommand("efgm_bind_raidinfo", showRaidInfo:GetSelectedNumber())

    end

    local leanLeftPanel = vgui.Create("DPanel", controls)
    leanLeftPanel:Dock(TOP)
    leanLeftPanel:SetSize(0, EFGM.MenuScale(55))
    function leanLeftPanel:Paint(w, h)

        draw.SimpleTextOutlined("Lean Left keybind", "Purista18", w / 2, EFGM.MenuScale(5), MenuAlias.whiteColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 1, MenuAlias.blackColor)

    end

    local leanLeft = vgui.Create("DBinder", leanLeftPanel)
    leanLeft:SetPos(EFGM.MenuScale(110), EFGM.MenuScale(30))
    leanLeft:SetSize(EFGM.MenuScale(100), EFGM.MenuScale(20))
    leanLeft:SetSelectedNumber(GetConVar("efgm_bind_leanleft"):GetInt())
    function leanLeft:OnChange(num)

        RunConsoleCommand("efgm_bind_leanleft", leanLeft:GetSelectedNumber())

    end

    local leanRightPanel = vgui.Create("DPanel", controls)
    leanRightPanel:Dock(TOP)
    leanRightPanel:SetSize(0, EFGM.MenuScale(55))
    function leanRightPanel:Paint(w, h)

        draw.SimpleTextOutlined("Lean Right keybind", "Purista18", w / 2, EFGM.MenuScale(5), MenuAlias.whiteColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 1, MenuAlias.blackColor)

    end

    local leanRight = vgui.Create("DBinder", leanRightPanel)
    leanRight:SetPos(EFGM.MenuScale(110), EFGM.MenuScale(30))
    leanRight:SetSize(EFGM.MenuScale(100), EFGM.MenuScale(20))
    leanRight:SetSelectedNumber(GetConVar("efgm_bind_leanright"):GetInt())
    function leanRight:OnChange(num)

        RunConsoleCommand("efgm_bind_leanright", leanRight:GetSelectedNumber())

    end

    local freeLookPanel = vgui.Create("DPanel", controls)
    freeLookPanel:Dock(TOP)
    freeLookPanel:SetSize(0, EFGM.MenuScale(55))
    function freeLookPanel:Paint(w, h)

        draw.SimpleTextOutlined("Free Look keybind", "Purista18", w / 2, EFGM.MenuScale(5), MenuAlias.whiteColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 1, MenuAlias.blackColor)

    end

    local freeLook = vgui.Create("DBinder", freeLookPanel)
    freeLook:SetPos(EFGM.MenuScale(110), EFGM.MenuScale(30))
    freeLook:SetSize(EFGM.MenuScale(100), EFGM.MenuScale(20))
    freeLook:SetSelectedNumber(GetConVar("efgm_bind_freelook"):GetInt())
    function freeLook:OnChange(num)

        RunConsoleCommand("efgm_bind_freelook", freeLook:GetSelectedNumber())

    end

    local toggleFireModePanel = vgui.Create("DPanel", controls)
    toggleFireModePanel:Dock(TOP)
    toggleFireModePanel:SetSize(0, EFGM.MenuScale(55))
    function toggleFireModePanel:Paint(w, h)

        draw.SimpleTextOutlined("Toggle Fire Mode keybind", "Purista18", w / 2, EFGM.MenuScale(5), MenuAlias.whiteColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 1, MenuAlias.blackColor)

    end

    local toggleFireMode = vgui.Create("DBinder", toggleFireModePanel)
    toggleFireMode:SetPos(EFGM.MenuScale(110), EFGM.MenuScale(30))
    toggleFireMode:SetSize(EFGM.MenuScale(100), EFGM.MenuScale(20))
    toggleFireMode:SetSelectedNumber(GetConVar("efgm_bind_changefiremode"):GetInt())
    function toggleFireMode:OnChange(num)

        RunConsoleCommand("efgm_bind_changefiremode", toggleFireMode:GetSelectedNumber())

    end

    local changeSightPanel = vgui.Create("DPanel", controls)
    changeSightPanel:Dock(TOP)
    changeSightPanel:SetSize(0, EFGM.MenuScale(55))
    function changeSightPanel:Paint(w, h)

        draw.SimpleTextOutlined("Change Sight Zoom/Reticle keybind", "Purista18", w / 2, EFGM.MenuScale(5), MenuAlias.whiteColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 1, MenuAlias.blackColor)

    end

    local changeSight = vgui.Create("DBinder", changeSightPanel)
    changeSight:SetPos(EFGM.MenuScale(110), EFGM.MenuScale(30))
    changeSight:SetSize(EFGM.MenuScale(100), EFGM.MenuScale(20))
    changeSight:SetSelectedNumber(GetConVar("efgm_bind_changesight"):GetInt())
    function changeSight:OnChange(num)

        RunConsoleCommand("efgm_bind_changesight", changeSight:GetSelectedNumber())

    end

    local toggleUBGLPanel = vgui.Create("DPanel", controls)
    toggleUBGLPanel:Dock(TOP)
    toggleUBGLPanel:SetSize(0, EFGM.MenuScale(55))
    function toggleUBGLPanel:Paint(w, h)

        draw.SimpleTextOutlined("Toggle UBGL (Under Barrel Launcher) keybind", "Purista18", w / 2, EFGM.MenuScale(5), MenuAlias.whiteColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 1, MenuAlias.blackColor)

    end

    local toggleUBGL = vgui.Create("DBinder", toggleUBGLPanel)
    toggleUBGL:SetPos(EFGM.MenuScale(110), EFGM.MenuScale(30))
    toggleUBGL:SetSize(EFGM.MenuScale(100), EFGM.MenuScale(20))
    toggleUBGL:SetSelectedNumber(GetConVar("efgm_bind_toggleubgl"):GetInt())
    function toggleUBGL:OnChange(num)

        RunConsoleCommand("efgm_bind_toggleubgl", changeSight:GetSelectedNumber())

    end

    local inspectWeaponPanel = vgui.Create("DPanel", controls)
    inspectWeaponPanel:Dock(TOP)
    inspectWeaponPanel:SetSize(0, EFGM.MenuScale(55))
    function inspectWeaponPanel:Paint(w, h)

        draw.SimpleTextOutlined("Inspect Weapon keybind", "Purista18", w / 2, EFGM.MenuScale(5), MenuAlias.whiteColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 1, MenuAlias.blackColor)

    end

    local inspectWeapon = vgui.Create("DBinder", inspectWeaponPanel)
    inspectWeapon:SetPos(EFGM.MenuScale(110), EFGM.MenuScale(30))
    inspectWeapon:SetSize(EFGM.MenuScale(100), EFGM.MenuScale(20))
    inspectWeapon:SetSelectedNumber(GetConVar("efgm_bind_inspectweapon"):GetInt())
    function inspectWeapon:OnChange(num)

        RunConsoleCommand("efgm_bind_inspectweapon", inspectWeapon:GetSelectedNumber())

    end

    local teamInvitePanel = vgui.Create("DPanel", controls)
    teamInvitePanel:Dock(TOP)
    teamInvitePanel:SetSize(0, EFGM.MenuScale(55))
    function teamInvitePanel:Paint(w, h)

        draw.SimpleTextOutlined("Invite Player To Squad keybind", "Purista18", w / 2, EFGM.MenuScale(5), MenuAlias.whiteColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 1, MenuAlias.blackColor)

    end

    local teamInvite = vgui.Create("DBinder", teamInvitePanel)
    teamInvite:SetPos(EFGM.MenuScale(110), EFGM.MenuScale(30))
    teamInvite:SetSize(EFGM.MenuScale(100), EFGM.MenuScale(20))
    teamInvite:SetSelectedNumber(GetConVar("efgm_bind_teaminvite"):GetInt())
    function teamInvite:OnChange(num)

        RunConsoleCommand("efgm_bind_teaminvite", teamInvite:GetSelectedNumber())

    end

    local primaryWeaponPanel = vgui.Create("DPanel", controls)
    primaryWeaponPanel:Dock(TOP)
    primaryWeaponPanel:SetSize(0, EFGM.MenuScale(55))
    function primaryWeaponPanel:Paint(w, h)

        draw.SimpleTextOutlined("Primary Weapon keybind", "Purista18", w / 2, EFGM.MenuScale(5), MenuAlias.whiteColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 1, MenuAlias.blackColor)

    end

    local primaryWeapon = vgui.Create("DBinder", primaryWeaponPanel)
    primaryWeapon:SetPos(EFGM.MenuScale(110), EFGM.MenuScale(30))
    primaryWeapon:SetSize(EFGM.MenuScale(100), EFGM.MenuScale(20))
    primaryWeapon:SetSelectedNumber(GetConVar("efgm_bind_equip_primary1"):GetInt())
    function primaryWeapon:OnChange(num)

        RunConsoleCommand("efgm_bind_equip_primary1", primaryWeapon:GetSelectedNumber())

    end

    local primaryWeaponTwoPanel = vgui.Create("DPanel", controls)
    primaryWeaponTwoPanel:Dock(TOP)
    primaryWeaponTwoPanel:SetSize(0, EFGM.MenuScale(55))
    function primaryWeaponTwoPanel:Paint(w, h)

        draw.SimpleTextOutlined("Primary Weapon #2 keybind", "Purista18", w / 2, EFGM.MenuScale(5), MenuAlias.whiteColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 1, MenuAlias.blackColor)

    end

    local primaryWeaponTwo = vgui.Create("DBinder", primaryWeaponTwoPanel)
    primaryWeaponTwo:SetPos(EFGM.MenuScale(110), EFGM.MenuScale(30))
    primaryWeaponTwo:SetSize(EFGM.MenuScale(100), EFGM.MenuScale(20))
    primaryWeaponTwo:SetSelectedNumber(GetConVar("efgm_bind_equip_primary2"):GetInt())
    function primaryWeaponTwo:OnChange(num)

        RunConsoleCommand("efgm_bind_equip_primary2", primaryWeaponTwo:GetSelectedNumber())

    end

    local secondaryWeaponPanel = vgui.Create("DPanel", controls)
    secondaryWeaponPanel:Dock(TOP)
    secondaryWeaponPanel:SetSize(0, EFGM.MenuScale(55))
    function secondaryWeaponPanel:Paint(w, h)

        draw.SimpleTextOutlined("Secondary Weapon keybind", "Purista18", w / 2, EFGM.MenuScale(5), MenuAlias.whiteColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 1, MenuAlias.blackColor)

    end

    local secondaryWeapon = vgui.Create("DBinder", secondaryWeaponPanel)
    secondaryWeapon:SetPos(EFGM.MenuScale(110), EFGM.MenuScale(30))
    secondaryWeapon:SetSize(EFGM.MenuScale(100), EFGM.MenuScale(20))
    secondaryWeapon:SetSelectedNumber(GetConVar("efgm_bind_equip_secondary"):GetInt())
    function secondaryWeapon:OnChange(num)

        RunConsoleCommand("efgm_bind_equip_secondary", secondaryWeapon:GetSelectedNumber())

    end

    local meleeWeaponPanel = vgui.Create("DPanel", controls)
    meleeWeaponPanel:Dock(TOP)
    meleeWeaponPanel:SetSize(0, EFGM.MenuScale(55))
    function meleeWeaponPanel:Paint(w, h)

        draw.SimpleTextOutlined("Melee Weapon keybind", "Purista18", w / 2, EFGM.MenuScale(5), MenuAlias.whiteColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 1, MenuAlias.blackColor)

    end

    local meleeWeapon = vgui.Create("DBinder", meleeWeaponPanel)
    meleeWeapon:SetPos(EFGM.MenuScale(110), EFGM.MenuScale(30))
    meleeWeapon:SetSize(EFGM.MenuScale(100), EFGM.MenuScale(20))
    meleeWeapon:SetSelectedNumber(GetConVar("efgm_bind_equip_melee"):GetInt())
    function meleeWeapon:OnChange(num)

        RunConsoleCommand("efgm_bind_equip_melee", meleeWeapon:GetSelectedNumber())

    end

    local utilityThrowablePanel = vgui.Create("DPanel", controls)
    utilityThrowablePanel:Dock(TOP)
    utilityThrowablePanel:SetSize(0, EFGM.MenuScale(55))
    function utilityThrowablePanel:Paint(w, h)

        draw.SimpleTextOutlined("Utility/Throwable keybind", "Purista18", w / 2, EFGM.MenuScale(5), MenuAlias.whiteColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 1, MenuAlias.blackColor)

    end

    local utilityThrowable = vgui.Create("DBinder", utilityThrowablePanel)
    utilityThrowable:SetPos(EFGM.MenuScale(110), EFGM.MenuScale(30))
    utilityThrowable:SetSize(EFGM.MenuScale(100), EFGM.MenuScale(20))
    utilityThrowable:SetSelectedNumber(GetConVar("efgm_bind_equip_utility"):GetInt())
    function utilityThrowable:OnChange(num)

        RunConsoleCommand("efgm_bind_equip_utility", utilityThrowable:GetSelectedNumber())

    end

    -- interface

    local hudEnablePanel = vgui.Create("DPanel", interface)
    hudEnablePanel:Dock(TOP)
    hudEnablePanel:SetSize(0, EFGM.MenuScale(50))
    function hudEnablePanel:Paint(w, h)

        draw.SimpleTextOutlined("Enable HUD", "Purista18", w / 2, EFGM.MenuScale(5), MenuAlias.whiteColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 1, MenuAlias.blackColor)

    end

    local hudEnable = vgui.Create("DCheckBox", hudEnablePanel)
    hudEnable:SetPos(EFGM.MenuScale(152), EFGM.MenuScale(30))
    hudEnable:SetConVar("efgm_hud_enable")
    hudEnable:SetSize(EFGM.MenuScale(15), EFGM.MenuScale(15))

    local hudScalePanel = vgui.Create("DPanel", interface)
    hudScalePanel:Dock(TOP)
    hudScalePanel:SetSize(0, EFGM.MenuScale(50))
    function hudScalePanel:Paint(w, h)

        draw.SimpleTextOutlined("HUD Scale", "Purista18", w / 2, EFGM.MenuScale(5), MenuAlias.whiteColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 1, MenuAlias.blackColor)

    end

    local hudScale = vgui.Create("DNumSlider", hudScalePanel)
    hudScale:SetPos(EFGM.MenuScale(35), EFGM.MenuScale(30))
    hudScale:SetSize(EFGM.MenuScale(200), EFGM.MenuScale(15))
    hudScale:SetConVar("efgm_hud_scale")
    hudScale:SetMin(0.5)
    hudScale:SetMax(2)
    hudScale:SetDecimals(2)

    local menuParallaxPanel = vgui.Create("DPanel", interface)
    menuParallaxPanel:Dock(TOP)
    menuParallaxPanel:SetSize(0, EFGM.MenuScale(50))
    function menuParallaxPanel:Paint(w, h)

        draw.SimpleTextOutlined("Menu Parallax", "Purista18", w / 2, EFGM.MenuScale(5), MenuAlias.whiteColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 1, MenuAlias.blackColor)

    end

    local menuParallax = vgui.Create("DCheckBox", menuParallaxPanel)
    menuParallax:SetPos(EFGM.MenuScale(152), EFGM.MenuScale(30))
    menuParallax:SetConVar("efgm_menu_parallax")
    menuParallax:SetSize(EFGM.MenuScale(15), EFGM.MenuScale(15))

    local menuScalingMethodPanel = vgui.Create("DPanel", interface)
    menuScalingMethodPanel:Dock(TOP)
    menuScalingMethodPanel:SetSize(0, EFGM.MenuScale(55))
    function menuScalingMethodPanel:Paint(w, h)

        draw.SimpleTextOutlined("Menu Scaling Method", "Purista18", w / 2, EFGM.MenuScale(5), MenuAlias.whiteColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 1, MenuAlias.blackColor)

    end

    local menuScalingMethod = vgui.Create("DComboBox", menuScalingMethodPanel)
    menuScalingMethod:SetPos(EFGM.MenuScale(100), EFGM.MenuScale(30))
    menuScalingMethod:SetSize(EFGM.MenuScale(120), EFGM.MenuScale(20))

    if GetConVar("efgm_menu_scalingmethod"):GetInt() == 0 then
        menuScalingMethod:SetValue("Dock")
    elseif GetConVar("efgm_menu_scalingmethod"):GetInt() == 1 then
        menuScalingMethod:SetValue("Center")
    end

    menuScalingMethod:AddChoice("Dock")
    menuScalingMethod:AddChoice("Center")
    menuScalingMethod:SetSortItems(false)
    menuScalingMethod.OnSelect = function(self, value)
        RunConsoleCommand("efgm_menu_scalingmethod", value - 1)
    end

    -- visuals

    local vmFOVPanel = vgui.Create("DPanel", visuals)
    vmFOVPanel:Dock(TOP)
    vmFOVPanel:SetSize(0, EFGM.MenuScale(50))
    function vmFOVPanel:Paint(w, h)

        draw.SimpleTextOutlined("Viewmodel FOV Scale", "Purista18", w / 2, EFGM.MenuScale(5), MenuAlias.whiteColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 1, MenuAlias.blackColor)

    end

    local vmFOV = vgui.Create("DNumSlider", vmFOVPanel)
    vmFOV:SetPos(EFGM.MenuScale(35), EFGM.MenuScale(30))
    vmFOV:SetSize(EFGM.MenuScale(200), EFGM.MenuScale(15))
    vmFOV:SetConVar("arc9_fov")
    vmFOV:SetMin(-20)
    vmFOV:SetMax(20)
    vmFOV:SetDecimals(0)

    local vmXPanel = vgui.Create("DPanel", visuals)
    vmXPanel:Dock(TOP)
    vmXPanel:SetSize(0, EFGM.MenuScale(50))
    function vmXPanel:Paint(w, h)

        draw.SimpleTextOutlined("Viewmodel X Position", "Purista18", w / 2, EFGM.MenuScale(5), MenuAlias.whiteColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 1, MenuAlias.blackColor)

    end

    local vmX = vgui.Create("DNumSlider", vmXPanel)
    vmX:SetPos(EFGM.MenuScale(35), EFGM.MenuScale(30))
    vmX:SetSize(EFGM.MenuScale(200), EFGM.MenuScale(15))
    vmX:SetConVar("arc9_vm_addx")
    vmX:SetMin(-7)
    vmX:SetMax(7)
    vmX:SetDecimals(1)

    local vmYPanel = vgui.Create("DPanel", visuals)
    vmYPanel:Dock(TOP)
    vmYPanel:SetSize(0, EFGM.MenuScale(50))
    function vmYPanel:Paint(w, h)

        draw.SimpleTextOutlined("Viewmodel Y Position", "Purista18", w / 2, EFGM.MenuScale(5), MenuAlias.whiteColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 1, MenuAlias.blackColor)

    end

    local vmY = vgui.Create("DNumSlider", vmYPanel)
    vmY:SetPos(EFGM.MenuScale(35), EFGM.MenuScale(30))
    vmY:SetSize(EFGM.MenuScale(200), EFGM.MenuScale(15))
    vmY:SetConVar("arc9_vm_addy")
    vmY:SetMin(-7)
    vmY:SetMax(7)
    vmY:SetDecimals(1)

    local vmZPanel = vgui.Create("DPanel", visuals)
    vmZPanel:Dock(TOP)
    vmZPanel:SetSize(0, EFGM.MenuScale(50))
    function vmZPanel:Paint(w, h)

        draw.SimpleTextOutlined("Viewmodel Z Position", "Purista18", w / 2, EFGM.MenuScale(5), MenuAlias.whiteColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 1, MenuAlias.blackColor)

    end

    local vmZ = vgui.Create("DNumSlider", vmZPanel)
    vmZ:SetPos(EFGM.MenuScale(35), EFGM.MenuScale(30))
    vmZ:SetSize(EFGM.MenuScale(200), EFGM.MenuScale(15))
    vmZ:SetConVar("arc9_vm_addz")
    vmZ:SetMin(-7)
    vmZ:SetMax(7)
    vmZ:SetDecimals(1)

    local headBobPanel = vgui.Create("DPanel", visuals)
    headBobPanel:Dock(TOP)
    headBobPanel:SetSize(0, EFGM.MenuScale(50))
    function headBobPanel:Paint(w, h)

        draw.SimpleTextOutlined("Head Bobbing", "Purista18", w / 2, EFGM.MenuScale(5), MenuAlias.whiteColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 1, MenuAlias.blackColor)

    end

    local headBob = vgui.Create("DCheckBox", headBobPanel)
    headBob:SetPos(EFGM.MenuScale(152), EFGM.MenuScale(30))
    headBob:SetConVar("efgm_visuals_headbob")
    headBob:SetSize(EFGM.MenuScale(15), EFGM.MenuScale(15))

    local lensFlarePanel = vgui.Create("DPanel", visuals)
    lensFlarePanel:Dock(TOP)
    lensFlarePanel:SetSize(0, EFGM.MenuScale(50))
    function lensFlarePanel:Paint(w, h)

        draw.SimpleTextOutlined("Lens Flare", "Purista18", w / 2, EFGM.MenuScale(5), MenuAlias.whiteColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 1, MenuAlias.blackColor)

    end

    local lensFlare = vgui.Create("DCheckBox", lensFlarePanel)
    lensFlare:SetPos(EFGM.MenuScale(152), EFGM.MenuScale(30))
    lensFlare:SetConVar("efgm_visuals_lensflare")
    lensFlare:SetSize(EFGM.MenuScale(15), EFGM.MenuScale(15))

    local impactFXPanel = vgui.Create("DPanel", visuals)
    impactFXPanel:Dock(TOP)
    impactFXPanel:SetSize(0, EFGM.MenuScale(50))
    function impactFXPanel:Paint(w, h)

        draw.SimpleTextOutlined("High Quality Bullet Impact FX", "Purista18", w / 2, EFGM.MenuScale(5), MenuAlias.whiteColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 1, MenuAlias.blackColor)

    end

    local impactFX = vgui.Create("DCheckBox", impactFXPanel)
    impactFX:SetPos(EFGM.MenuScale(152), EFGM.MenuScale(30))
    impactFX:SetConVar("efgm_visuals_highqualimpactfx")
    impactFX:SetSize(EFGM.MenuScale(15), EFGM.MenuScale(15))

    local tpikAllPanel = vgui.Create("DPanel", visuals)
    tpikAllPanel:Dock(TOP)
    tpikAllPanel:SetSize(0, EFGM.MenuScale(50))
    function tpikAllPanel:Paint(w, h)

        draw.SimpleTextOutlined("TPP Animations For Other Players", "Purista18", w / 2, EFGM.MenuScale(5), MenuAlias.whiteColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 1, MenuAlias.blackColor)

    end

    local tpikAll = vgui.Create("DCheckBox", tpikAllPanel)
    tpikAll:SetPos(EFGM.MenuScale(152), EFGM.MenuScale(30))
    tpikAll:SetConVar("arc9_tpik_others")
    tpikAll:SetSize(EFGM.MenuScale(15), EFGM.MenuScale(15))

    local lodDistancePanel = vgui.Create("DPanel", visuals)
    lodDistancePanel:Dock(TOP)
    lodDistancePanel:SetSize(0, EFGM.MenuScale(50))
    function lodDistancePanel:Paint(w, h)

        draw.SimpleTextOutlined("LOD (Level Of Detail) Distance Multiplier", "Purista18", w / 2, EFGM.MenuScale(5), MenuAlias.whiteColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 1, MenuAlias.blackColor)

    end

    local lodDistance = vgui.Create("DNumSlider", lodDistancePanel)
    lodDistance:SetPos(EFGM.MenuScale(35), EFGM.MenuScale(30))
    lodDistance:SetSize(EFGM.MenuScale(200), EFGM.MenuScale(15))
    lodDistance:SetConVar("arc9_lod_distance")
    lodDistance:SetMin(0.3)
    lodDistance:SetMax(3)
    lodDistance:SetDecimals(1)

    local soundQuality = vgui.Create("DPanel", visuals)
    soundQuality:Dock(TOP)
    soundQuality:SetSize(0, EFGM.MenuScale(50))
    function soundQuality:Paint(w, h)

        draw.SimpleTextOutlined("Sound Calculation Quality", "Purista18", w / 2, EFGM.MenuScale(5), MenuAlias.whiteColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 1, MenuAlias.blackColor)

    end

    local soundQualitySlider = vgui.Create("DNumSlider", soundQuality)
    soundQualitySlider:SetPos(EFGM.MenuScale(35), EFGM.MenuScale(30))
    soundQualitySlider:SetSize(EFGM.MenuScale(200), EFGM.MenuScale(15))
    soundQualitySlider:SetConVar("arc9_indoorsound")
    soundQualitySlider:SetMin(0)
    soundQualitySlider:SetMax(2)
    soundQualitySlider:SetDecimals(0)

    -- account

    local factionPreferencePanel = vgui.Create("DPanel", account)
    factionPreferencePanel:Dock(TOP)
    factionPreferencePanel:SetSize(0, EFGM.MenuScale(55))
    function factionPreferencePanel:Paint(w, h)

        draw.SimpleTextOutlined("Faction Preference", "Purista18", w / 2, EFGM.MenuScale(5), MenuAlias.whiteColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 1, MenuAlias.blackColor)

    end

    local factionPreference = vgui.Create("DComboBox", factionPreferencePanel)
    factionPreference:SetPos(EFGM.MenuScale(100), EFGM.MenuScale(30))
    factionPreference:SetSize(EFGM.MenuScale(120), EFGM.MenuScale(20))

    if GetConVar("efgm_faction_preference"):GetInt() == 0 then
        factionPreference:SetValue("None")
    elseif GetConVar("efgm_faction_preference"):GetInt() == 1 then
        factionPreference:SetValue("USEC")
    elseif GetConVar("efgm_faction_preference"):GetInt() == 2  then
        factionPreference:SetValue("BEAR")
    end

    factionPreference:AddChoice("None")
    factionPreference:AddChoice("USEC")
    factionPreference:AddChoice("BEAR")
    factionPreference:SetSortItems(false)
    factionPreference.OnSelect = function(self, value)
        RunConsoleCommand("efgm_faction_preference", value - 1)
    end

    local invitePrivacyPanel = vgui.Create("DPanel", account)
    invitePrivacyPanel:Dock(TOP)
    invitePrivacyPanel:SetSize(0, EFGM.MenuScale(55))
    function invitePrivacyPanel:Paint(w, h)

        draw.SimpleTextOutlined("Receive Squad Invites From", "Purista18", w / 2, EFGM.MenuScale(5), MenuAlias.whiteColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 1, MenuAlias.blackColor)

    end

    local invitePrivacy = vgui.Create("DComboBox", invitePrivacyPanel)
    invitePrivacy:SetPos(EFGM.MenuScale(100), EFGM.MenuScale(30))
    invitePrivacy:SetSize(EFGM.MenuScale(120), EFGM.MenuScale(20))

    if GetConVar("efgm_privacy_invites"):GetInt() == 0 then
        invitePrivacy:SetValue("None")
    elseif GetConVar("efgm_privacy_invites"):GetInt() == 1 then
        invitePrivacy:SetValue("Steam Friends")
    elseif GetConVar("efgm_privacy_invites"):GetInt() == 2  then
        invitePrivacy:SetValue("Everyone")
    end

    invitePrivacy:AddChoice("None")
    invitePrivacy:AddChoice("Steam Friends")
    invitePrivacy:AddChoice("Everyone")
    invitePrivacy:SetSortItems(false)
    invitePrivacy.OnSelect = function(self, value)
        RunConsoleCommand("efgm_privacy_invites", value - 1)
    end

end

concommand.Add("efgm_gamemenu", function(ply, cmd, args)

    local tab = args[1] -- tab currently does jack

    if !ply:Alive() then return end

    Menu:Open(tab)

end)

net.Receive("PlayerOpenContainer", function(len, ply)

    local tab = "Inventory"

    local container = {}
    container.entity = net.ReadEntity()
    container.name = net.ReadString()
    container.items = net.ReadTable(true)

    Menu:Open(tab, container)

end )