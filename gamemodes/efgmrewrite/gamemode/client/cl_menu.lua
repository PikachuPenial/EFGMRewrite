
-- establishes global menu object, this will have tabs and will handle shit like shop, player progression, in-raid shit, other stuff
-- this is not a panel, but a collection of panels and supporting functions
Menu = {}

Menu.MusicList = {"sound/music/menu_01.mp4", "sound/music/menu_02.mp4", "sound/music/menu_03.mp4", "sound/music/menu_04.mp4"}
Menu.TabList = {"stats", "match", "inventory", "market", "tasks", "skills", "intel", "achievements", "settings"}
Menu.ActiveTab = ""
Menu.MouseX = 0
Menu.MouseY = 0
Menu.Player = LocalPlayer()
Menu.IsOpen = false
Menu.PerferredShopDestination = nil

local holdtypes = {
    "idle_revolver",
    "idle_dual",
    "idle_rpg",
    "idle_passive",
    "idle_slam",
    "idle_camera",
    "idle_grenade",
    "idle_melee2",
    "idle_knife",
    "idle_magic",
    "pose_standing_01",
    "pose_standing_02",
    "pose_standing_03",
    "pose_standing_04"
}

local plyItems = {}
local plyStashItems = {}
local marketPlyStashItems = {}

hook.Add("OnReloaded", "Reload", function()

    Menu.Player = LocalPlayer()

end)

local menuBind = GetConVar("efgm_bind_menu"):GetInt()
cvars.AddChangeCallback("efgm_bind_menu", function(convar_name, value_old, value_new)
    menuBind = tonumber(value_new)
end)

hook.Add("PlayerBindPress", "BlockBindsWhileInMenu", function(ply, bind, pressed)

    if Menu.MenuFrame == nil then return end
    if Menu.MenuFrame:IsActive() != true then return end

    if bind == "+attack" or bind == "+attack2" or bind == "+jump" then

        return true

    end

end )

hook.Add("OnPauseMenuShow", "DisableMenu", function()

    if Menu.MenuFrame == nil then return true end
    if Menu.MenuFrame:IsActive() == true then

        Menu.Closing = true
        Menu.MenuFrame:SetKeyboardInputEnabled(false)
        Menu.MenuFrame:SetMouseInputEnabled(false)
        Menu.IsOpen = false

        Menu.MenuFrame:AlphaTo(0, 0.1, 0, function()

            Menu.MenuFrame:Close()

        end)

        return false

    end

end )

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

    menuFrame:AlphaTo(255, 0.2, 0, function() self.IsOpen = true end)

    self.Unblur = false
    self.Closing = false

    function menuFrame:Paint(w, h)
        if Menu.Unblur then return end -- hide the blur when customizing certain settings and whatnot

        surface.SetDrawColor(Colors.frameColor)
        surface.DrawRect(0, 0, ScrW(), ScrH())
        BlurPanel(menuFrame, 4)
    end

    -- close menu with the game menu keybind
    function menuFrame:OnKeyCodeReleased(key)
        if key == menuBind then
            self.Closing = true
            menuFrame:SetKeyboardInputEnabled(false)
            menuFrame:SetMouseInputEnabled(false)
            Menu.IsOpen = false

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

            menuFrame:Close()

        end

    end

    function menuFrame:OnClose()

        Menu.PerferredShopDestination = nil

        if Menu.ActiveTab == "Match" then

            net.Start("RemovePlayerSquadRF")
            net.SendToServer()

        end

    end

    self.Player = LocalPlayer()
    self.MenuFrame = menuFrame
    self.Container = container

    local tabParentPanel = vgui.Create("DPanel", self.MenuFrame)
    tabParentPanel:SetPos(EFGM.MenuScale(10), EFGM.MenuScale(10))
    tabParentPanel:SetSize(ScrW(), EFGM.MenuScale(41))

    surface.SetFont("PuristaBold32")

    local roubles = comma_value(Menu.Player:GetNWInt("Money", 0))
    local roublesTextSize = surface.GetTextSize(roubles)

    local level = Menu.Player:GetNWInt("Level", 1)
    local levelTextSize = surface.GetTextSize(level)

    local time = string.FormattedTime(GetGlobalInt("RaidTimeLeft", 0), "%02i:%02i")
    local timeTextSize = surface.GetTextSize(time)

    local plyCount = #player.GetHumans()
    local plyCountTextSize = surface.GetTextSize(plyCount)

    local raidStatus = GetGlobalInt("RaidStatus", 0)
    local raidStatusTbl = {
        [0] = Colors.menuStatusPending,
        [1] = Colors.whiteColor,
        [2] = Colors.menuStatusEnded
    }

    function tabParentPanel:Paint(w, h)

        surface.SetFont("PuristaBold32")

        roubles = comma_value(Menu.Player:GetNWInt("Money", 0))
        roublesTextSize = surface.GetTextSize(roubles)

        level = Menu.Player:GetNWInt("Level", 1)
        levelTextSize = surface.GetTextSize(level)

        time = string.FormattedTime(GetGlobalInt("RaidTimeLeft", 0), "%02i:%02i")
        timeTextSize = surface.GetTextSize(time)

        plyCount = #player.GetHumans()
        plyCountTextSize = surface.GetTextSize(plyCount)

        raidStatus = GetGlobalInt("RaidStatus", 0)

        draw.SimpleTextOutlined(roubles, "PuristaBold32", w - EFGM.MenuScale(26), EFGM.MenuScale(2), Colors.whiteColor, TEXT_ALIGN_RIGHT, TEXT_ALIGN_TOP, 1, Colors.blackColor)
        draw.SimpleTextOutlined(level, "PuristaBold32", w - roublesTextSize - EFGM.MenuScale(86), EFGM.MenuScale(2), Colors.whiteColor, TEXT_ALIGN_RIGHT, TEXT_ALIGN_TOP, 1, Colors.blackColor)
        draw.SimpleTextOutlined(time, "PuristaBold32", w - roublesTextSize - levelTextSize - EFGM.MenuScale(146), EFGM.MenuScale(2), raidStatusTbl[raidStatus], TEXT_ALIGN_RIGHT, TEXT_ALIGN_TOP, 1, Colors.blackColor)
        draw.SimpleTextOutlined(plyCount, "PuristaBold32", w - roublesTextSize - levelTextSize - timeTextSize - EFGM.MenuScale(206), EFGM.MenuScale(2), Colors.whiteColor, TEXT_ALIGN_RIGHT, TEXT_ALIGN_TOP, 1, Colors.blackColor)

        draw.DrawText("EFGM", "PuristaBold32", w / 2, EFGM.MenuScale(2), Colors.itemBackgroundColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP)

    end

    self.MenuFrame.TabParentPanel = tabParentPanel

    local roubleIcon = vgui.Create("DButton", self.MenuFrame.TabParentPanel)
    roubleIcon:SetPos(self.MenuFrame.TabParentPanel:GetWide() - EFGM.MenuScale(66) - roublesTextSize, EFGM.MenuScale(2))
    roubleIcon:SetSize(EFGM.MenuScale(36), EFGM.MenuScale(36))
    roubleIcon:SetText("")
    roubleIcon.Paint = function(s, w, h)

        s:SetX(self.MenuFrame.TabParentPanel:GetWide() - EFGM.MenuScale(66) - roublesTextSize)
        surface.SetDrawColor(Colors.pureWhiteColor)
        surface.SetMaterial(Mats.roubleIcon)
        surface.DrawTexturedRect(0, 0, EFGM.MenuScale(36), EFGM.MenuScale(36))

    end

    local levelIcon = vgui.Create("DButton", self.MenuFrame.TabParentPanel)
    levelIcon:SetPos(self.MenuFrame.TabParentPanel:GetWide() - EFGM.MenuScale(127) - roublesTextSize - levelTextSize, EFGM.MenuScale(2))
    levelIcon:SetSize(EFGM.MenuScale(36), EFGM.MenuScale(36))
    levelIcon:SetText("")
    levelIcon.Paint = function(s, w, h)

        s:SetX(self.MenuFrame.TabParentPanel:GetWide() - EFGM.MenuScale(127) - roublesTextSize - levelTextSize)
        surface.SetDrawColor(Colors.pureWhiteColor)
        surface.SetMaterial(Mats.levelIcon)
        surface.DrawTexturedRect(0, 0, EFGM.MenuScale(36), EFGM.MenuScale(36))

    end

    local timeIcon = vgui.Create("DPanel", self.MenuFrame.TabParentPanel)
    timeIcon:SetPos(self.MenuFrame.TabParentPanel:GetWide() - EFGM.MenuScale(188) - roublesTextSize - levelTextSize - timeTextSize, EFGM.MenuScale(2))
    timeIcon:SetSize(EFGM.MenuScale(36), EFGM.MenuScale(36))
    timeIcon.Paint = function(s, w, h)

        s:SetX(self.MenuFrame.TabParentPanel:GetWide() - EFGM.MenuScale(188) - roublesTextSize - levelTextSize - timeTextSize)
        surface.SetDrawColor(Colors.pureWhiteColor)
        surface.SetMaterial(Mats.timeIcon)
        surface.DrawTexturedRect(0, 0, EFGM.MenuScale(36), EFGM.MenuScale(36))

    end

    local plyCountIcon = vgui.Create("DPanel", self.MenuFrame.TabParentPanel)
    plyCountIcon:SetPos(self.MenuFrame.TabParentPanel:GetWide() - EFGM.MenuScale(249) - roublesTextSize - levelTextSize - timeTextSize - plyCountTextSize, EFGM.MenuScale(2))
    plyCountIcon:SetSize(EFGM.MenuScale(36), EFGM.MenuScale(36))
    plyCountIcon.Paint = function(s, w, h)

        s:SetX(self.MenuFrame.TabParentPanel:GetWide() - EFGM.MenuScale(249) - roublesTextSize - levelTextSize - timeTextSize - plyCountTextSize)
        surface.SetDrawColor(Colors.pureWhiteColor)
        surface.SetMaterial(Mats.populationIcon)
        surface.DrawTexturedRect(0, 0, EFGM.MenuScale(36), EFGM.MenuScale(36))

    end

    roubleIcon.OnCursorEntered = function(s)

        local x, y = Menu.MouseX, Menu.MouseY
        local sideH, sideV

        surface.PlaySound("ui/element_hover_" .. math.random(1, 3) .. ".wav")

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

            surface.SetDrawColor(Colors.transparentWhiteColor)
            surface.DrawRect(0, 0, w, EFGM.MenuScale(1))
            surface.DrawRect(0, h - 1, w, EFGM.MenuScale(1))
            surface.DrawRect(0, 0, EFGM.MenuScale(1), h)
            surface.DrawRect(w - 1, 0, EFGM.MenuScale(1), h)

            draw.SimpleTextOutlined("ROUBLES", "PuristaBold24", EFGM.MenuScale(5), EFGM.MenuScale(5), Colors.whiteColor, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP, 1, Colors.blackColor)
            draw.SimpleTextOutlined("Your primary currency when purchasing goods, using services and trading with other operatives.", "Purista18", EFGM.MenuScale(5), EFGM.MenuScale(25), Colors.whiteColor, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP, 1, Colors.blackColor)

        end

    end

    roubleIcon.OnCursorExited = function(s)

        if IsValid(roublePopOut) then

            roublePopOut:AlphaTo(0, 0.1, 0, function() roublePopOut:Remove() end)

        end

    end

    levelIcon.OnCursorEntered = function(s)

        local x, y = Menu.MouseX, Menu.MouseY
        local sideH, sideV

        surface.PlaySound("ui/element_hover_" .. math.random(1, 3) .. ".wav")

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

            surface.SetDrawColor(Colors.transparentWhiteColor)
            surface.DrawRect(0, 0, w, EFGM.MenuScale(1))
            surface.DrawRect(0, h - 1, w, EFGM.MenuScale(1))
            surface.DrawRect(0, 0, EFGM.MenuScale(1), h)
            surface.DrawRect(w - 1, 0, EFGM.MenuScale(1), h)

            draw.SimpleTextOutlined("LEVEL", "PuristaBold24", EFGM.MenuScale(5), EFGM.MenuScale(5), Colors.whiteColor, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP, 1, Colors.blackColor)
            draw.SimpleTextOutlined("Your characters level, what seperates you from better services and reputation.", "Purista18", EFGM.MenuScale(5), EFGM.MenuScale(25), Colors.whiteColor, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP, 1, Colors.blackColor)

            draw.SimpleTextOutlined(level, "PuristaBold24", EFGM.MenuScale(5), EFGM.MenuScale(50), Colors.whiteColor, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP, 1, Colors.blackColor)
            draw.SimpleTextOutlined(level + 1, "PuristaBold24", w - EFGM.MenuScale(5), EFGM.MenuScale(50), Colors.whiteColor, TEXT_ALIGN_RIGHT, TEXT_ALIGN_TOP, 1, Colors.blackColor)

            draw.SimpleTextOutlined(Menu.Player:GetNWInt("Experience", 0) .. "/" .. Menu.Player:GetNWInt("ExperienceToNextLevel", 500), "PuristaBold16", EFGM.MenuScale(30), EFGM.MenuScale(55.5), Colors.whiteColor, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP, 1, Colors.blackColor)

            surface.SetDrawColor(Colors.transparentWhiteColor)
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
            Menu.IsOpen = false
            menuFrame:AlphaTo(0, 0.1, 0, function()
                menuFrame:Close()
            end)
            return
        end

        if IsValid(Menu.MenuFrame) and Menu.MenuFrame.Closing then return end

        Menu.MouseX, Menu.MouseY = menuFrame:LocalCursorPos()

        if GetConVar("efgm_menu_parallax"):GetInt() == 1 then

            Menu.ParallaxX = math.Clamp(((Menu.MouseX / math.Round(EFGM.MenuScale(1920), 1)) - 0.5) * EFGM.MenuScale(20), EFGM.MenuScale(-10), EFGM.MenuScale(10))
            Menu.ParallaxY = math.Clamp(((Menu.MouseY / math.Round(EFGM.MenuScale(1080), 1)) - 0.5) * EFGM.MenuScale(20), EFGM.MenuScale(-10), EFGM.MenuScale(10))

        else

            Menu.ParallaxX = 0
            Menu.ParallaxY = 0

        end

        if GetConVar("efgm_menu_scalingmethod"):GetInt() == 0 then

            -- lowerPanel:SetPos(ScrW() / 2 - (EFGM.MenuScale(1880) / 2) + Menu.ParallaxX, 1060 / 2 - (920 / 2) + Menu.ParallaxY)
            lowerPanel:SetPos(ScrW() / 2 - (EFGM.MenuScale(1880) / 2) + Menu.ParallaxX, EFGM.MenuScale(70) + Menu.ParallaxY)

        else

            lowerPanel:SetPos(ScrW() / 2 - (EFGM.MenuScale(1880) / 2) + Menu.ParallaxX, EFGM.MenuScale(1060) / 2 - (920 / 2) + Menu.ParallaxY)

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
    contents.Paint = nil

    Menu.MenuFrame.LowerPanel.Contents = contents

    -- MENU TABS
        -- STATS

            -- for text size calculations
            surface.SetFont("PuristaBold32")

            local statsTab = vgui.Create("DPanel", self.MenuFrame.TabParentPanel)
            statsTab:Dock(LEFT)
            statsTab:SetSize(EFGM.MenuScale(38), 0)

            local statsIcon = vgui.Create("DButton", statsTab)
            statsIcon:SetPos(EFGM.MenuScale(2), EFGM.MenuScale(2))
            statsIcon:SetSize(EFGM.MenuScale(36), EFGM.MenuScale(36))
            statsIcon:SetText("")

            statsIcon.Paint = function(s, w, h)

                surface.SetDrawColor(Colors.pureWhiteColor)
                surface.SetMaterial(Mats.profileIcon)
                surface.DrawTexturedRect(0, 0, EFGM.MenuScale(36), EFGM.MenuScale(36))

            end

            local statsBGColor = Colors.transparent
            local statsText = string.upper(Menu.Player:GetName())
            local statsTextSize = surface.GetTextSize(statsText)

            statsTab.Paint = function(s, w, h)

                surface.SetDrawColor(statsBGColor)
                surface.DrawRect(0, 0, w, h)

                draw.SimpleTextOutlined(statsText, "PuristaBold32", EFGM.MenuScale(43), EFGM.MenuScale(2), Colors.whiteColor, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP, 1, Colors.blackColor)

                if Menu.ActiveTab == "Stats" then

                    surface.SetDrawColor(Colors.whiteColor)
                    surface.DrawRect(EFGM.MenuScale(2), EFGM.MenuScale(39), w - EFGM.MenuScale(2), EFGM.MenuScale(2))

                end

            end

            statsIcon.OnCursorEntered = function(s)

                statsTab:SizeTo(EFGM.MenuScale(46) + statsTextSize, statsTab:GetTall(), 0.15, 0, 0.5)
                surface.PlaySound("ui/element_hover_" .. math.random(1, 3) .. ".wav")

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

        -- MATCH

            local matchTab = vgui.Create("DPanel", self.MenuFrame.TabParentPanel)
            matchTab:Dock(LEFT)
            matchTab:SetSize(EFGM.MenuScale(38), 0)

            local matchIcon = vgui.Create("DButton", matchTab)
            matchIcon:SetPos(EFGM.MenuScale(2), EFGM.MenuScale(2))
            matchIcon:SetSize(EFGM.MenuScale(36), EFGM.MenuScale(36))
            matchIcon:SetText("")

            matchIcon.Paint = function(s, w, h)

                surface.SetDrawColor(Colors.pureWhiteColor)
                surface.SetMaterial(Mats.matchIcon)
                surface.DrawTexturedRect(0, 0, EFGM.MenuScale(36), EFGM.MenuScale(36))

            end

            local matchBGColor = Colors.transparent
            local matchText = "#menu.tab.match"
            local matchTextSize = surface.GetTextSize(matchText)

            matchTab.Paint = function(s, w, h)

                surface.SetDrawColor(matchBGColor)
                surface.DrawRect(0, 0, w, h)

                draw.SimpleTextOutlined(matchText, "PuristaBold32", EFGM.MenuScale(43), EFGM.MenuScale(2), Colors.whiteColor, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP, 1, Colors.blackColor)

                if Menu.ActiveTab == "Match" then

                    surface.SetDrawColor(Colors.whiteColor)
                    surface.DrawRect(EFGM.MenuScale(2), EFGM.MenuScale(39), w - EFGM.MenuScale(2), EFGM.MenuScale(2))

                end

            end

            matchIcon.OnCursorEntered = function(s)

                matchTab:SizeTo(EFGM.MenuScale(46) + matchTextSize, matchTab:GetTall(), 0.15, 0, 0.5)
                surface.PlaySound("ui/element_hover_" .. math.random(1, 3) .. ".wav")

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

        -- INVENTORY

            local inventoryTab = vgui.Create("DPanel", self.MenuFrame.TabParentPanel)
            inventoryTab:Dock(LEFT)
            inventoryTab:SetSize(EFGM.MenuScale(38), 0)

            local inventoryIcon = vgui.Create("DButton", inventoryTab)
            inventoryIcon:SetPos(EFGM.MenuScale(2), EFGM.MenuScale(2))
            inventoryIcon:SetSize(EFGM.MenuScale(36), EFGM.MenuScale(36))
            inventoryIcon:SetText("")

            inventoryIcon.Paint = function(s, w, h)

                surface.SetDrawColor(Colors.pureWhiteColor)
                surface.SetMaterial(Mats.inventoryIcon)
                surface.DrawTexturedRect(0, 0, EFGM.MenuScale(36), EFGM.MenuScale(36))

            end

            local inventoryBGColor = Colors.transparent
            local inventoryText = "#menu.tab.inventory"
            local inventoryTextSize = surface.GetTextSize(inventoryText)

            inventoryTab.Paint = function(s, w, h)

                surface.SetDrawColor(inventoryBGColor)
                surface.DrawRect(0, 0, w, h)

                draw.SimpleTextOutlined(inventoryText, "PuristaBold32", EFGM.MenuScale(43), EFGM.MenuScale(2), Colors.whiteColor, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP, 1, Colors.blackColor)

                if Menu.ActiveTab == "Inventory" then

                    surface.SetDrawColor(Colors.whiteColor)
                    surface.DrawRect(EFGM.MenuScale(2), EFGM.MenuScale(39), w - EFGM.MenuScale(2), EFGM.MenuScale(2))

                end

            end

            inventoryIcon.OnCursorEntered = function(s)

                inventoryTab:SizeTo(EFGM.MenuScale(46) + inventoryTextSize, inventoryTab:GetTall(), 0.15, 0, 0.5)
                surface.PlaySound("ui/element_hover_" .. math.random(1, 3) .. ".wav")

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
                    Menu.OpenTab.Inventory(Menu.Container)
                    Menu.ActiveTab = "Inventory"

                    Menu.MenuFrame.LowerPanel.Contents:AlphaTo(255, 0.05, 0, nil)

                end)

            end

        -- MARKET

            local marketTab = vgui.Create("DPanel", self.MenuFrame.TabParentPanel)
            marketTab:Dock(LEFT)
            marketTab:SetSize(EFGM.MenuScale(38), 0)

            if !Menu.Player:CompareStatus(0) then marketTab:Hide(true) end

            local marketIcon = vgui.Create("DButton", marketTab)
            marketIcon:SetPos(EFGM.MenuScale(2), EFGM.MenuScale(2))
            marketIcon:SetSize(EFGM.MenuScale(36), EFGM.MenuScale(36))
            marketIcon:SetText("")

            marketIcon.Paint = function(s, w, h)

                surface.SetDrawColor(Colors.pureWhiteColor)
                surface.SetMaterial(Mats.marketIcon)
                surface.DrawTexturedRect(0, 0, EFGM.MenuScale(36), EFGM.MenuScale(36))

            end

            local marketBGColor = Colors.transparent
            local marketText = "#menu.tab.market"
            local marketTextSize = surface.GetTextSize(marketText)

            marketTab.Paint = function(s, w, h)

                surface.SetDrawColor(marketBGColor)
                surface.DrawRect(0, 0, w, h)

                draw.SimpleTextOutlined(marketText, "PuristaBold32", EFGM.MenuScale(43), EFGM.MenuScale(2), Colors.whiteColor, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP, 1, Colors.blackColor)

                if Menu.ActiveTab == "Market" then

                    surface.SetDrawColor(Colors.whiteColor)
                    surface.DrawRect(EFGM.MenuScale(2), EFGM.MenuScale(39), w - EFGM.MenuScale(2), EFGM.MenuScale(2))

                end

            end

            marketIcon.OnCursorEntered = function(s)

                marketTab:SizeTo(EFGM.MenuScale(46) + marketTextSize, marketTab:GetTall(), 0.15, 0, 0.5)
                surface.PlaySound("ui/element_hover_" .. math.random(1, 3) .. ".wav")

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

        -- TASKS <3

            local tasksTab = vgui.Create("DPanel", self.MenuFrame.TabParentPanel)
            tasksTab:Dock(LEFT)
            tasksTab:SetSize(EFGM.MenuScale(38), 0)

            local tasksIcon = vgui.Create("DButton", tasksTab)
            tasksIcon:SetPos(EFGM.MenuScale(2), EFGM.MenuScale(2))
            tasksIcon:SetSize(EFGM.MenuScale(36), EFGM.MenuScale(36))
            tasksIcon:SetText("")

            tasksIcon.Paint = function(s, w, h)

                surface.SetDrawColor(Colors.pureWhiteColor)
                surface.SetMaterial(Mats.tasksIcon)
                surface.DrawTexturedRect(0, 0, EFGM.MenuScale(36), EFGM.MenuScale(36))

            end

            local tasksBGColor = Colors.transparent
            local tasksText = "#menu.tab.tasks"
            local tasksTextSize = surface.GetTextSize(tasksText)

            tasksTab.Paint = function(s, w, h)

                surface.SetDrawColor(tasksBGColor)
                surface.DrawRect(0, 0, w, h)

                draw.SimpleTextOutlined(tasksText, "PuristaBold32", EFGM.MenuScale(43), EFGM.MenuScale(2), Colors.whiteColor, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP, 1, Colors.blackColor)

                if Menu.ActiveTab == "Tasks" then

                    surface.SetDrawColor(Colors.whiteColor)
                    surface.DrawRect(EFGM.MenuScale(2), EFGM.MenuScale(39), w - EFGM.MenuScale(2), EFGM.MenuScale(2))

                end

            end

            tasksIcon.OnCursorEntered = function(s)

                tasksTab:SizeTo(EFGM.MenuScale(46) + tasksTextSize, tasksTab:GetTall(), 0.15, 0, 0.5)
                surface.PlaySound("ui/element_hover_" .. math.random(1, 3) .. ".wav")

            end

            tasksIcon.OnCursorExited = function(s)

                tasksTab:SizeTo(EFGM.MenuScale(38), tasksTab:GetTall(), 0.15, 0, 0.5)

            end

            function tasksIcon:DoClick()

                if Menu.ActiveTab == "Tasks" then return end

                RunConsoleCommand("efgm_task_requestall")

                if Menu.ActiveTab == "Match" then

                    net.Start("RemovePlayerSquadRF")
                    net.SendToServer()

                end

                surface.PlaySound("ui/element_select.wav")

                Menu.MenuFrame.LowerPanel.Contents:AlphaTo(0, 0.05, 0, function()

                    Menu.MenuFrame.LowerPanel.Contents:Remove()
                    Menu.OpenTab.Tasks()
                    Menu.ActiveTab = "Tasks"

                    Menu.MenuFrame.LowerPanel.Contents:AlphaTo(255, 0.05, 0, nil)

                end)

            end

        -- SKILLS

            local skillsTab = vgui.Create("DPanel", self.MenuFrame.TabParentPanel)
            skillsTab:Dock(LEFT)
            skillsTab:SetSize(EFGM.MenuScale(38), 0)
            skillsTab:Hide(true)

            local skillsIcon = vgui.Create("DButton", skillsTab)
            skillsIcon:SetPos(EFGM.MenuScale(2), EFGM.MenuScale(2))
            skillsIcon:SetSize(EFGM.MenuScale(36), EFGM.MenuScale(36))
            skillsIcon:SetText("")

            skillsIcon.Paint = function(s, w, h)

                surface.SetDrawColor(Colors.pureWhiteColor)
                surface.SetMaterial(Mats.skillsIcon)
                surface.DrawTexturedRect(0, 0, EFGM.MenuScale(36), EFGM.MenuScale(36))

            end

            local skillsBGColor = Colors.transparent
            local skillsText = "#menu.tab.skills"
            local skillsTextSize = surface.GetTextSize(skillsText)

            skillsTab.Paint = function(s, w, h)

                surface.SetDrawColor(skillsBGColor)
                surface.DrawRect(0, 0, w, h)

                draw.SimpleTextOutlined(skillsText, "PuristaBold32", EFGM.MenuScale(43), EFGM.MenuScale(2), Colors.whiteColor, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP, 1, Colors.blackColor)

                if Menu.ActiveTab == "Skills" then

                    surface.SetDrawColor(Colors.whiteColor)
                    surface.DrawRect(EFGM.MenuScale(2), EFGM.MenuScale(39), w - EFGM.MenuScale(2), EFGM.MenuScale(2))

                end

            end

            skillsIcon.OnCursorEntered = function(s)

                skillsTab:SizeTo(EFGM.MenuScale(46) + skillsTextSize, skillsTab:GetTall(), 0.15, 0, 0.5)
                surface.PlaySound("ui/element_hover_" .. math.random(1, 3) .. ".wav")

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

        -- INTEL

            local intelTab = vgui.Create("DPanel", self.MenuFrame.TabParentPanel)
            intelTab:Dock(LEFT)
            intelTab:SetSize(EFGM.MenuScale(38), 0)
            intelTab:Hide(true)

            local intelIcon = vgui.Create("DButton", intelTab)
            intelIcon:SetPos(EFGM.MenuScale(2), EFGM.MenuScale(2))
            intelIcon:SetSize(EFGM.MenuScale(36), EFGM.MenuScale(36))
            intelIcon:SetText("")

            intelIcon.Paint = function(s, w, h)

                surface.SetDrawColor(Colors.pureWhiteColor)
                surface.SetMaterial(Mats.intelIcon)
                surface.DrawTexturedRect(0, 0, EFGM.MenuScale(36), EFGM.MenuScale(36))

            end

            local intelBGColor = Colors.transparent
            local intelText = "#menu.tab.intel"
            local intelTextSize = surface.GetTextSize(intelText)

            intelTab.Paint = function(s, w, h)

                surface.SetDrawColor(intelBGColor)
                surface.DrawRect(0, 0, w, h)

                draw.SimpleTextOutlined(intelText, "PuristaBold32", EFGM.MenuScale(43), EFGM.MenuScale(2), Colors.whiteColor, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP, 1, Colors.blackColor)

                if Menu.ActiveTab == "Intel" then

                    surface.SetDrawColor(Colors.whiteColor)
                    surface.DrawRect(EFGM.MenuScale(2), EFGM.MenuScale(39), w - EFGM.MenuScale(2), EFGM.MenuScale(2))

                end

            end

            intelIcon.OnCursorEntered = function(s)

                intelTab:SizeTo(EFGM.MenuScale(46) + intelTextSize, intelTab:GetTall(), 0.15, 0, 0.5)
                surface.PlaySound("ui/element_hover_" .. math.random(1, 3) .. ".wav")

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

        -- ACHIEVEMENTS

            local achievementsTab = vgui.Create("DPanel", self.MenuFrame.TabParentPanel)
            achievementsTab:Dock(LEFT)
            achievementsTab:SetSize(EFGM.MenuScale(38), 0)
            achievementsTab:Hide(true)

            local achievementsIcon = vgui.Create("DButton", achievementsTab)
            achievementsIcon:SetPos(EFGM.MenuScale(2), EFGM.MenuScale(2))
            achievementsIcon:SetSize(EFGM.MenuScale(36), EFGM.MenuScale(36))
            achievementsIcon:SetText("")

            achievementsIcon.Paint = function(s, w, h)

                surface.SetDrawColor(Colors.pureWhiteColor)
                surface.SetMaterial(Mats.achievementIcon)
                surface.DrawTexturedRect(0, 0, EFGM.MenuScale(36), EFGM.MenuScale(36))

            end

            local achievementsBGColor = Colors.transparent
            local achievementsText = "#menu.tab.achievements"
            local achievementsTextSize = surface.GetTextSize(achievementsText)

            achievementsTab.Paint = function(s, w, h)

                surface.SetDrawColor(achievementsBGColor)
                surface.DrawRect(0, 0, w, h)

                draw.SimpleTextOutlined(achievementsText, "PuristaBold32", EFGM.MenuScale(43), EFGM.MenuScale(2), Colors.whiteColor, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP, 1, Colors.blackColor)

                if Menu.ActiveTab == "Achievements" then

                    surface.SetDrawColor(Colors.whiteColor)
                    surface.DrawRect(EFGM.MenuScale(2), EFGM.MenuScale(39), w - EFGM.MenuScale(2), EFGM.MenuScale(2))

                end

            end

            achievementsIcon.OnCursorEntered = function(s)

                achievementsTab:SizeTo(EFGM.MenuScale(46) + achievementsTextSize, achievementsTab:GetTall(), 0.15, 0, 0.5)
                surface.PlaySound("ui/element_hover_" .. math.random(1, 3) .. ".wav")

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

        -- SETTINGS

            local settingsTab = vgui.Create("DPanel", self.MenuFrame.TabParentPanel)
            settingsTab:Dock(LEFT)
            settingsTab:SetSize(EFGM.MenuScale(38), 0)

            local settingsIcon = vgui.Create("DButton", settingsTab)
            settingsIcon:SetPos(EFGM.MenuScale(2), EFGM.MenuScale(2))
            settingsIcon:SetSize(EFGM.MenuScale(36), EFGM.MenuScale(36))
            settingsIcon:SetText("")

            settingsIcon.Paint = function(s, w, h)

                surface.SetDrawColor(Colors.pureWhiteColor)
                surface.SetMaterial(Mats.settingsIcon)
                surface.DrawTexturedRect(0, 0, EFGM.MenuScale(36), EFGM.MenuScale(36))

            end

            local settingsBGColor = Colors.transparent
            local settingsText = "#menu.tab.settings"
            local settingsTextSize = surface.GetTextSize(settingsText)

            settingsTab.Paint = function(s, w, h)

                surface.SetDrawColor(settingsBGColor)
                surface.DrawRect(0, 0, w, h)

                draw.SimpleTextOutlined(settingsText, "PuristaBold32", EFGM.MenuScale(43), EFGM.MenuScale(2), Colors.whiteColor, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP, 1, Colors.blackColor)

                if Menu.ActiveTab == "Settings" then

                    surface.SetDrawColor(Colors.whiteColor)
                    surface.DrawRect(EFGM.MenuScale(2), EFGM.MenuScale(39), w - EFGM.MenuScale(2), EFGM.MenuScale(2))

                end

            end

            settingsIcon.OnCursorEntered = function(s)

                settingsTab:SizeTo(EFGM.MenuScale(46) + settingsTextSize, settingsTab:GetTall(), 0.15, 0, 0.5)
                surface.PlaySound("ui/element_hover_" .. math.random(1, 3) .. ".wav")

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

    -- TABS END

    -- if provided, open to the tab of the users choice
    if openTo != nil then

        -- i cant figure this out so enjoy the Inventory tab
        Menu.OpenTab.Inventory(Menu.Container)
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
    local weight = i.weight

    if data and data.att then

        local atts = GetPrefixedAttachmentListFromCode(data.att)
        if !atts then return end

        for _, a in ipairs(atts) do

            local att = EFGMITEMS[a]
            if att == nil then continue end

            value = value + att.value
            weight = weight + att.weight

        end

    end

    local ownerName = nil
    if data.owner then steamworks.RequestPlayerInfo(data.owner, function(steamName) ownerName = steamName end) end

    surface.SetFont("PuristaBold18")
    local itemDescText = string.upper(i.displayType) .. " / " .. string.upper(weight) .. "KG" .. " / ₽" .. string.upper(comma_value(value))
    if i.canPurchase == true or i.canPurchase == nil then itemDescText = itemDescText .. " / LEVEL " .. string.upper(i.levelReq) end
    local itemDescSize = surface.GetTextSize(itemDescText)

    local iconSizeX, iconSizeY = EFGM.MenuScale(114 * i.sizeX), EFGM.MenuScale(114 * i.sizeY)

    local panelWidth
    if iconSizeX >= itemNameSize then panelWidth = iconSizeX else panelWidth = itemNameSize end
    if itemDescSize + EFGM.MenuScale(8) >= panelWidth then panelWidth = itemDescSize + EFGM.MenuScale(8) end

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

        surface.SetDrawColor(Colors.transparentWhiteColor)
        surface.DrawRect(0, 0, w, EFGM.MenuScale(6))

        surface.SetDrawColor(Colors.whiteBorderColor)
        surface.DrawRect(0, 0, w, EFGM.MenuScale(1))
        surface.DrawRect(0, h - 1, w, EFGM.MenuScale(1))
        surface.DrawRect(0, 0, EFGM.MenuScale(1), h)
        surface.DrawRect(w - 1, 0, EFGM.MenuScale(1), h)

        draw.SimpleTextOutlined(itemNameText, "PuristaBold24", EFGM.MenuScale(5), EFGM.MenuScale(5), Colors.whiteColor, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP, 1, Colors.blackColor)
        draw.SimpleTextOutlined(itemDescText, "PuristaBold18", EFGM.MenuScale(5), EFGM.MenuScale(25), Colors.whiteColor, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP, 1, Colors.blackColor)

        if data.tag then

            draw.SimpleTextOutlined(data.tag, "PuristaBold14", EFGM.MenuScale(5), EFGM.MenuScale(40), Colors.whiteColor, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP, 1, Colors.blackColor)

        end

        surface.SetDrawColor(Colors.pureWhiteColor)
        surface.SetMaterial(i.icon)

        -- panel width = 198, panel height = 216
        local x = inspectPanel:GetWide() / 2 - (newPanelWidth / 2)
        local y = inspectPanel:GetTall() / 2 - (newPanelHeight / 2)

        surface.DrawTexturedRect(x, y, newPanelWidth, newPanelHeight)

    end

    if data.fir then

        local firIcon = vgui.Create("DButton", inspectPanel)
        firIcon:SetPos(itemDescSize + EFGM.MenuScale(7), EFGM.MenuScale(29))
        firIcon:SetSize(EFGM.MenuScale(12), EFGM.MenuScale(12))
        firIcon:SetText("")

        firIcon.Paint = function(s, w, h)

            surface.SetDrawColor(Colors.pureWhiteColor)
            surface.SetMaterial(Mats.firIcon)
            surface.DrawTexturedRect(0, 0, EFGM.MenuScale(12), EFGM.MenuScale(12))

        end

        firIcon.OnCursorEntered = function(s, w, h)

            local x, y = Menu.MouseX, Menu.MouseY
            local sideH, sideV

            surface.PlaySound("ui/element_hover_" .. math.random(1, 3) .. ".wav")

            if x <= (ScrW() / 2) then sideH = true else sideH = false end
            if y <= (ScrH() / 2) then sideV = true else sideV = false end

            local function UpdatePopOutPos()

                if sideH == true then

                    firPopOut:SetX(math.Clamp(x + EFGM.MenuScale(15), EFGM.MenuScale(10), ScrW() - firPopOut:GetWide() - EFGM.MenuScale(10)))

                else

                    firPopOut:SetX(math.Clamp(x - firPopOut:GetWide() - EFGM.MenuScale(15), EFGM.MenuScale(10), ScrW() - firPopOut:GetWide() - EFGM.MenuScale(10)))

                end

                if sideV == true then

                    firPopOut:SetY(math.Clamp(y + EFGM.MenuScale(15), EFGM.MenuScale(60), ScrH() - firPopOut:GetTall() - EFGM.MenuScale(20)))

                else

                    firPopOut:SetY(math.Clamp(y - firPopOut:GetTall() + EFGM.MenuScale(15), EFGM.MenuScale(60), ScrH() - firPopOut:GetTall() - EFGM.MenuScale(20)))

                end

            end

            if IsValid(firPopOut) then firPopOut:Remove() end
            firPopOut = vgui.Create("DPanel", Menu.MenuFrame)
            firPopOut:SetSize(EFGM.MenuScale(455), EFGM.MenuScale(50))
            UpdatePopOutPos()
            firPopOut:AlphaTo(255, 0.1, 0, nil)
            firPopOut:SetMouseInputEnabled(false)

            firPopOut.Paint = function(s, w, h)

                if !IsValid(s) then return end

                BlurPanel(s, EFGM.MenuScale(3))

                -- panel position follows mouse position
                x, y = Menu.MouseX, Menu.MouseY

                UpdatePopOutPos()

                surface.SetDrawColor(Color(0, 0, 0, 205))
                surface.DrawRect(0, 0, w, h)

                surface.SetDrawColor(Color(55, 55, 55, 45))
                surface.DrawRect(0, 0, w, h)

                surface.SetDrawColor(Color(55, 55, 55))
                surface.DrawRect(0, 0, w, EFGM.MenuScale(5))

                surface.SetDrawColor(Colors.transparentWhiteColor)
                surface.DrawRect(0, 0, w, EFGM.MenuScale(1))
                surface.DrawRect(0, h - 1, w, EFGM.MenuScale(1))
                surface.DrawRect(0, 0, EFGM.MenuScale(1), h)
                surface.DrawRect(w - 1, 0, EFGM.MenuScale(1), h)

                draw.SimpleTextOutlined("FOUND IN RAID", "PuristaBold24", EFGM.MenuScale(5), EFGM.MenuScale(5), Colors.whiteColor, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP, 1, Colors.blackColor)
                draw.SimpleTextOutlined("This item will lose its 'found in raid' status if brought into another raid.", "Purista18", EFGM.MenuScale(5), EFGM.MenuScale(25), Colors.whiteColor, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP, 1, Colors.blackColor)

            end

        end

        firIcon.OnCursorExited = function(s)

            if IsValid(firPopOut) then

                firPopOut:AlphaTo(0, 0.1, 0, function() firPopOut:Remove() end)

            end

        end

    end

    local itemPullOutPanel = vgui.Create("DPanel", inspectPanel)
    itemPullOutPanel:SetSize(inspectPanel:GetWide(), inspectPanel:GetTall() - EFGM.MenuScale(75))
    itemPullOutPanel:SetPos(0, inspectPanel:GetTall() - 1)
    itemPullOutPanel:SetAlpha(255)
    itemPullOutPanel.Paint = function(s, w, h)

        BlurPanel(s, EFGM.MenuScale(1))

        surface.SetDrawColor(Color(20, 20, 20, 205))
        surface.DrawRect(0, 0, w, h)

        surface.SetDrawColor(Colors.whiteBorderColor)
        surface.DrawRect(0, 0, w, EFGM.MenuScale(1))
        surface.DrawRect(0, h - 1, w, EFGM.MenuScale(1))
        surface.DrawRect(0, 0, EFGM.MenuScale(1), h)
        surface.DrawRect(w - 1, 0, EFGM.MenuScale(1), h)

    end

    surface.SetFont("PuristaBold24")
    local infoText = "INFO"
    local infoTextSize = surface.GetTextSize(infoText)

    local itemInfoButton = vgui.Create("DButton", inspectPanel)
    itemInfoButton:SetPos(EFGM.MenuScale(1), itemPullOutPanel:GetY() - EFGM.MenuScale(28) + 1)
    itemInfoButton:SetSize(infoTextSize + EFGM.MenuScale(10), EFGM.MenuScale(28))
    itemInfoButton:SetText("")
    itemInfoButton.Paint = function(s, w, h)

        BlurPanel(s, 0.5)

        s:SetY(itemPullOutPanel:GetY() - EFGM.MenuScale(28) + 1)

        surface.SetDrawColor(Colors.containerBackgroundColor)
        surface.DrawRect(0, 0, infoTextSize + EFGM.MenuScale(10), h)

        surface.SetDrawColor(Colors.transparentWhiteColor)
        if !s:IsHovered() then surface.DrawRect(0, 0, infoTextSize + EFGM.MenuScale(10), EFGM.MenuScale(2)) else surface.DrawRect(0, 0, infoTextSize + EFGM.MenuScale(10), EFGM.MenuScale(3)) end

        draw.SimpleTextOutlined(infoText, "PuristaBold24", EFGM.MenuScale(5), EFGM.MenuScale(2), Colors.whiteColor, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP, 1, Colors.blackColor)

    end

    surface.SetFont("PuristaBold24")
    local wikiText = "WIKI"
    local wikiTextSize = surface.GetTextSize(wikiText)

    local itemWikiButton = vgui.Create("DButton", inspectPanel)
    itemWikiButton:SetPos(itemInfoButton:GetWide() + EFGM.MenuScale(1), itemPullOutPanel:GetY() - EFGM.MenuScale(28) + 1)
    itemWikiButton:SetSize(wikiTextSize + EFGM.MenuScale(10), EFGM.MenuScale(28))
    itemWikiButton:SetText("")
    itemWikiButton.Paint = function(s, w, h)

        BlurPanel(s, 0.5)

        s:SetY(itemPullOutPanel:GetY() - EFGM.MenuScale(28) + 1)

        surface.SetDrawColor(Colors.containerBackgroundColor)
        surface.DrawRect(0, 0, wikiTextSize + EFGM.MenuScale(10), h)

        surface.SetDrawColor(Colors.transparentWhiteColor)
        if !s:IsHovered() then surface.DrawRect(0, 0, infoTextSize + EFGM.MenuScale(10), EFGM.MenuScale(2)) else surface.DrawRect(0, 0, infoTextSize + EFGM.MenuScale(10), EFGM.MenuScale(3)) end

        draw.SimpleTextOutlined(wikiText, "PuristaBold24", EFGM.MenuScale(5), EFGM.MenuScale(2), Colors.whiteColor, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP, 1, Colors.blackColor)

    end

    if !data or table.IsEmpty(data) then

        itemInfoButton:Remove()
        itemWikiButton:SetX(EFGM.MenuScale(1))

    end

    local pullOutContent = vgui.Create("DPanel", itemPullOutPanel)
    pullOutContent:Dock(FILL)
    pullOutContent:DockPadding(EFGM.MenuScale(10), EFGM.MenuScale(10), EFGM.MenuScale(10), EFGM.MenuScale(10))
    pullOutContent:SetAlpha(0)
    pullOutContent.Paint = nil

    itemPullOutPanel.content = pullOutContent

    local tab

    local function OpenPullOutInfoTab()

        tab = "Info"

        local infoContent = vgui.Create("DPanel", itemPullOutPanel)
        infoContent:Dock(FILL)
        infoContent:DockPadding(EFGM.MenuScale(5), EFGM.MenuScale(5), EFGM.MenuScale(5), EFGM.MenuScale(5))
        infoContent:SetAlpha(0)
        infoContent.Paint = nil

        local infoContentText = vgui.Create("RichText", infoContent)
        infoContentText:Dock(FILL)
        infoContentText:SetVerticalScrollbarEnabled(true)
        infoContentText:InsertColorChange(255, 255, 255, 255)

        if ownerName then

            infoContentText:AppendText("OWNER: " .. ownerName .. "\n")

        end

        if data.timestamp then

            infoContentText:AppendText("AQUIRED AT: " .. os.date("%x, %I:%M:%S %p", data.timestamp) .. "\n")

        end

        if data.count != 0 and data.count != 1 and data.count != nil then

            infoContentText:AppendText("COUNT: " .. data.count .. "\n")

        end

        if data.durability then

            infoContentText:AppendText("DURABILITY: " .. data.durability .. "\n")

        end

        if data.tag and !data.tagLevel then

            infoContentText:AppendText("NAME TAG: " .. data.tag .. "\n")

        end

        if data.att then

            infoContentText:AppendText("ATTACHMENTS: \n" .. GetAttachmentListFromCode(data.att) .. "\n")

        end

        -- dog tag specific

        if data.tagLevel then

            infoContentText:AppendText("LEVEL: " .. data.tagLevel .. "\n")

        end

        if data.tagKiller then

            infoContentText:AppendText("KILLED BY: " .. data.tagKiller .. "\n")

        end

        if data.tagCauseOfDeath then

            local def = EFGMITEMS[data.tagCauseOfDeath]
            local cause = "Unknown"
            if data.tagCauseOfDeath == "Suicide" then cause = "Suicide" elseif def then cause = def.fullName .. " (" .. def.displayName .. ")" end
            infoContentText:AppendText("CAUSE OF DEATH: " .. cause .. "\n")

        end

        if data.tagWoundOrigin and data.tagWoundOrigin != 0 and HITGROUPS[data.tagWoundOrigin] != nil then

            infoContentText:AppendText("WOUND: " .. HITGROUPS[data.tagWoundOrigin] .. "\n")

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
        wikiContent.Paint = nil

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

            wikiContentText:AppendText("BASE WEIGHT: " .. i.weight .. "kg" .. "\n")

        end

        if i.value then

            wikiContentText:AppendText("BASE VALUE: ₽" .. comma_value(i.value) .. "\n")

        end

        if i.lootWeight then

            wikiContentText:AppendText("LOOT WEIGHT: " .. i.lootWeight .. "%" .. "\n")

        else

            wikiContentText:AppendText("LOOT WEIGHT: 100%" .. "\n")

        end

        if i.canPurchase == true or i.canPurchase == nil then

            if i.levelReq then

                wikiContentText:AppendText("CAN PURCHASE FROM MARKET: TRUE" .. "\n")
                wikiContentText:AppendText("UNLOCKS AT: LEVEL " .. i.levelReq .. "\n")

            end

        else

            wikiContentText:AppendText("CAN PURCHASE FROM MARKET: " .. string.upper(tostring(i.canPurchase)) .. "\n")

        end

        if i.sizeX and i.sizeY then

            wikiContentText:AppendText("SIZE: " .. i.sizeX .. "x" .. i.sizeY .. "\n")

        end

        if i.stackSize then

            wikiContentText:AppendText("STACK SIZE: " .. i.stackSize  .. "\n")

        end

        if i.equipType == EQUIPTYPE.Weapon and wep != nil then

            wikiContentText:AppendText("\n")

            local firemodes = wep["Firemodes"] or nil
            local damageMax = math.Round(wep["DamageMax"] or 0) or nil
            local damageMin = math.Round(wep["DamageMin"] or 0) or nil
            local rpm = math.Round(wep["RPM"] or 0) or nil
            local range = math.Round((wep["RangeMax"] or 0) * 0.0254) or nil
            local velocity = math.Round(((wep["PhysBulletMuzzleVelocity"] or 0) * 0.0254) * 1.2) or nil

            local recoilMult = math.Round(wep["Recoil"] or 1, 2) or 1
            local visualRecoilMult = math.Round(wep["VisualRecoil"] or 1, 2) or 1
            local recoilUp = math.Round((wep["RecoilUp"] or 0) * recoilMult, 2) or nil
            local recoilUpRand = math.Round((wep["RecoilRandomUp"] or 0) * recoilMult, 2) or nil
            local recoilSide = math.Round((wep["RecoilSide"] or 0) * recoilMult, 2) or nil
            local recoilSideRand = math.Round((wep["RecoilRandomSide"] or 0) * recoilMult, 2) or nil
            local visualRecoilUp = math.Round((wep["VisualRecoilUp"] or 0) * visualRecoilMult, 2) or nil
            local visualRecoilSide = math.Round((wep["VisualRecoilSide"] or 0) * visualRecoilMult, 2) or nil
            local visualRecoilDamping = math.Round(wep["VisualRecoilDampingConst"] or 0, 2) or nil
            local recoilRecovery = math.Round(wep["RecoilAutoControl"], 2) or nil
            local accuracy = math.Round((wep["Spread"] or 0) * 360 * 60 / 10, 2)
            local ergo = wep["EFTErgo"] or nil

            local manufacturer = ARC9:GetPhrase(wep["Trivia"]["eft_trivia_manuf1"]) or nil
            local country = ARC9:GetPhrase(wep["Trivia"]["eft_trivia_country4"]) or nil
            local year = wep["Trivia"]["eft_trivia_year5"] or nil

            if firemodes then

                local str = ""

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

            if visualRecoilUp then

                wikiContentText:AppendText("VISUAL VERTICAL RECOIL: " .. visualRecoilUp .. "\n")

            end

            if visualRecoilSide then

                wikiContentText:AppendText("VISUAL HORIZONTAL RECOIL: " .. visualRecoilSide .. "\n")

            end

            if visualRecoilDamping then

                wikiContentText:AppendText("VISUAL RECOIL DAMPING: " .. visualRecoilDamping .. "\n")

            end

            if recoilRecovery then

                wikiContentText:AppendText("RECOIL RECOVERY: " .. recoilRecovery .. "\n")

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

        surface.PlaySound("ui/element_hover_" .. math.random(1, 3) .. ".wav")

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

        surface.PlaySound("ui/element_hover_" .. math.random(1, 3) .. ".wav")

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

        itemPullOutPanel:MoveTo(0, inspectPanel:GetTall() - 1, 0.1, 0, 0.3)

        tab = nil

        itemPullOutPanel.content:AlphaTo(0, 0.05, 0, function() end)

        local screenX, screenY = s:LocalToScreen(0, 0)

        if (s.m_bSizable and gui.MouseX() > (screenX + s:GetWide() - 20) and gui.MouseY() > (screenY + s:GetTall() - 20)) then
            s.Sizing = {gui.MouseX() - s:GetWide(), gui.MouseY() - s:GetTall()}
            s:MouseCapture(true)
            return
        end

        if (s:GetDraggable() and gui.MouseY() < (screenY + 24)) then
            s.Dragging = {gui.MouseX() - s.x, gui.MouseY() - s.y}
            s:MouseCapture(true)
            return
        end

    end

    local closeButton = vgui.Create("DButton", inspectPanel)
    closeButton:SetSize(EFGM.MenuScale(32), EFGM.MenuScale(32))
    closeButton:SetPos(inspectPanel:GetWide() - EFGM.MenuScale(32), EFGM.MenuScale(5))
    closeButton:SetText("")
    closeButton.Paint = function(s, w, h)

        surface.SetDrawColor(Colors.pureWhiteColor)
        surface.SetMaterial(Mats.closeButtonIcon)
        surface.DrawTexturedRect(0, 0, EFGM.MenuScale(32), EFGM.MenuScale(32))

    end

    closeButton.OnCursorEntered = function(s)

        surface.PlaySound("ui/element_hover_" .. math.random(1, 3) .. ".wav")

    end

    function closeButton:DoClick()

        inspectPanel:AlphaTo(0, 0.1, 0, function() inspectPanel:Remove() end)

    end

end

function Menu.ConfirmPurchase(item, sendTo, closeMenu)

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
    if marketLimits[item] == 0 then surface.PlaySound("ui/element_deselect.wav") return end

    local maxTransactionCountMult = math.min(10, Menu.Player:GetNWInt("StashMax", 150) - Menu.Player:GetNWInt("StashCount", 0))
    local maxTransactionCount = math.Clamp(math.floor(plyMoney / i.value), 1, marketLimits[item] or (i.stackSize * maxTransactionCountMult))

    if i.equipSlot == WEAPONSLOTS.PRIMARY.ID or i.equipSlot == WEAPONSLOTS.HOLSTER.ID or i.equipSlot == WEAPONSLOTS.MELEE.ID or i.equipType == EQUIPTYPE.Attachment then maxTransactionCount = 1 end

    surface.SetFont("PuristaBold24")
    local confirmText = "Purchase " .. transactionCount .. "x " .. i.fullName .. " (" .. i.displayName .. ") for ₽" .. comma_value(transactionCost) .. "?"
    local confirmTextSize = math.max(EFGM.MenuScale(300), surface.GetTextSize(confirmText))

    local confirmPanelHeight = EFGM.MenuScale(110)

    if maxTransactionCount > 1 and maxTransactionCount > 1 then confirmPanelHeight = EFGM.MenuScale(135) end

    surface.SetFont("PuristaBold16")
    local invText = "INVENTORY"
    local invTextSize = surface.GetTextSize(invText)

    local stashText = "STASH"
    local stashTextSize = surface.GetTextSize(stashText)

    local transactionDestination = (Menu.Player:CompareFaction(false) and "stash") or sendTo or Menu.PerferredShopDestination or "stash"
    Menu.PerferredShopDestination = transactionDestination

    surface.PlaySound("ui/market_select.wav")

    confirmPanel = vgui.Create("DFrame", Menu.MenuFrame)
    confirmPanel:SetSize(confirmTextSize + EFGM.MenuScale(10), confirmPanelHeight)
    confirmPanel:SetPos(Menu.MenuFrame:GetWide() / 2 - confirmPanel:GetWide() / 2, Menu.MenuFrame:GetTall() / 2 - confirmPanel:GetTall() / 2)
    confirmPanel:SetAlpha(0)
    confirmPanel:SetTitle("")
    confirmPanel:ShowCloseButton(false)
    confirmPanel:SetScreenLock(true)
    confirmPanel:AlphaTo(255, 0.1, 0, nil)
    confirmPanel:RequestFocus()

    confirmPanel.Paint = function(s, w, h)

        confirmPanel:SetWide(confirmTextSize + EFGM.MenuScale(10))
        confirmPanel:SetX(Menu.MenuFrame:GetWide() / 2 - confirmPanel:GetWide() / 2)

        BlurPanel(s, EFGM.MenuScale(3))

        surface.SetDrawColor(Color(20, 20, 20, 205))
        surface.DrawRect(0, 0, w, h)

        surface.SetDrawColor(Colors.transparentWhiteColor)
        surface.DrawRect(0, 0, w, EFGM.MenuScale(6))

        surface.SetDrawColor(Colors.whiteBorderColor)
        surface.DrawRect(0, 0, w, EFGM.MenuScale(1))
        surface.DrawRect(0, h - 1, w, EFGM.MenuScale(1))
        surface.DrawRect(0, 0, EFGM.MenuScale(1), h)
        surface.DrawRect(w - 1, 0, EFGM.MenuScale(1), h)

        draw.SimpleTextOutlined(confirmText, "PuristaBold24", w / 2, EFGM.MenuScale(5), Colors.whiteColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 1, Colors.blackColor)

        draw.SimpleTextOutlined("SEND TO", "PuristaBold16", w / 2, confirmPanelHeight - EFGM.MenuScale(80), Colors.whiteColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 1, Colors.blackColor)
        draw.SimpleTextOutlined(invText, "PuristaBold16", w / 2 - EFGM.MenuScale(55), confirmPanelHeight - EFGM.MenuScale(61), Colors.whiteColor, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP, 1, Colors.blackColor)
        draw.SimpleTextOutlined(stashText, "PuristaBold16", w / 2 + EFGM.MenuScale(35), confirmPanelHeight - EFGM.MenuScale(61), Colors.whiteColor, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP, 1, Colors.blackColor)

    end

    confirmPanel.Think = function()

        if (input.IsMouseDown(MOUSE_LEFT) or input.IsMouseDown(MOUSE_RIGHT) or input.IsMouseDown(MOUSE_MIDDLE) or input.IsMouseDown(MOUSE_WHEEL_DOWN) or input.IsMouseDown(MOUSE_WHEEL_UP)) and !confirmPanel:IsChildHovered() and !confirmPanel:IsHovered() then 
            
            confirmPanel:AlphaTo(0, 0.1, 0, function() confirmPanel:Remove() end)

            if closeMenu == true then

                Menu.MenuFrame.Closing = true
                Menu.MenuFrame:SetKeyboardInputEnabled(false)
                Menu.MenuFrame:SetMouseInputEnabled(false)
                Menu.IsOpen = false

                Menu.MenuFrame:AlphaTo(0, 0.1, 0, function()
                    Menu.MenuFrame:Close()
                end)

            end

        end

    end

    local sendToInventoryBox = vgui.Create("DCheckBox", confirmPanel)
    sendToInventoryBox:SetPos(confirmPanel:GetWide() / 2 - EFGM.MenuScale(75), confirmPanelHeight - EFGM.MenuScale(60))
    sendToInventoryBox:SetSize(EFGM.MenuScale(15), EFGM.MenuScale(15))

    sendToInventoryBox.Think = function(self)

        sendToInventoryBox:SetX(confirmPanel:GetWide() / 2 - EFGM.MenuScale(75))

    end

    if Menu.Player:CompareFaction(false) then sendToInventoryBox:SetEnabled(false) end

    local sendToStashBox = vgui.Create("DCheckBox", confirmPanel)
    sendToStashBox:SetPos(confirmPanel:GetWide() / 2 + EFGM.MenuScale(15), confirmPanelHeight - EFGM.MenuScale(60))
    sendToStashBox:SetSize(EFGM.MenuScale(15), EFGM.MenuScale(15))

    sendToStashBox.Think = function(self)

        sendToStashBox:SetX(confirmPanel:GetWide() / 2 + EFGM.MenuScale(15))

    end

    if transactionDestination == "inv" then

        sendToInventoryBox:SetValue(true)
        sendToStashBox:SetValue(false)

    else

        sendToInventoryBox:SetValue(false)
        sendToStashBox:SetValue(true)

    end

    function sendToInventoryBox:OnChange(bVal)

        if Menu.Player:CompareFaction(false) then return end

        if (bVal) then

            sendToStashBox:SetChecked(false)
            transactionDestination = "inv"
            Menu.PerferredShopDestination = "inv"

        else

            sendToStashBox:SetChecked(true)
            transactionDestination = "stash"
            Menu.PerferredShopDestination = "stash"

        end

    end

    function sendToStashBox:OnChange(bVal)

        if Menu.Player:CompareFaction(false) then

            sendToStashBox:SetChecked(true)
            transactionDestination = "stash"
            Menu.PerferredShopDestination = "stash"
            return

        end

        if (bVal) then

            sendToInventoryBox:SetChecked(false)
            transactionDestination = "stash"
            Menu.PerferredShopDestination = "stash"

        else

            sendToInventoryBox:SetChecked(true)
            transactionDestination = "inv"
            Menu.PerferredShopDestination = "inv"

        end

    end

    surface.SetFont("PuristaBold24")
    local yesText = "YES [SPACE]"
    local yesTextSize = surface.GetTextSize(yesText)
    local yesButtonSize = yesTextSize + EFGM.MenuScale(10)

    local yesButton = vgui.Create("DButton", confirmPanel)
    yesButton:SetPos(confirmPanel:GetWide() / 2 - EFGM.MenuScale(100), confirmPanelHeight - EFGM.MenuScale(35))
    yesButton:SetSize(yesButtonSize, EFGM.MenuScale(28))
    yesButton:SetText("")
    yesButton.Paint = function(s, w, h)

        yesButton:SetX(confirmPanel:GetWide() / 2 - (yesButtonSize / 2) - EFGM.MenuScale(25))

        surface.SetDrawColor(Colors.containerBackgroundColor)
        surface.DrawRect(0, 0, yesTextSize + EFGM.MenuScale(10), h)

        surface.SetDrawColor(Colors.transparentWhiteColor)
        surface.DrawRect(0, 0, yesTextSize + EFGM.MenuScale(10), EFGM.MenuScale(2))

        draw.SimpleTextOutlined(yesText, "PuristaBold24", w / 2, EFGM.MenuScale(2), Colors.whiteColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 1, Colors.blackColor)

    end

    surface.SetFont("PuristaBold24")
    local noText = "NO"
    local noTextSize = surface.GetTextSize(noText)
    local noButtonSize = noTextSize + EFGM.MenuScale(10)

    local noButton = vgui.Create("DButton", confirmPanel)
    noButton:SetPos(confirmPanel:GetWide() / 2 - (noButtonSize / 2) + yesButton:GetWide() / 2 + EFGM.MenuScale(5), confirmPanelHeight - EFGM.MenuScale(35))
    noButton:SetSize(noButtonSize, EFGM.MenuScale(28))
    noButton:SetText("")
    noButton.Paint = function(s, w, h)

        noButton:SetX(confirmPanel:GetWide() / 2 - (noButtonSize / 2) + yesButton:GetWide() / 2 + EFGM.MenuScale(5))

        surface.SetDrawColor(Colors.containerBackgroundColor)
        surface.DrawRect(0, 0, noButtonSize + EFGM.MenuScale(10), h)

        surface.SetDrawColor(Colors.transparentWhiteColor)
        surface.DrawRect(0, 0, noButtonSize + EFGM.MenuScale(10), EFGM.MenuScale(2))

        draw.SimpleTextOutlined(noText, "PuristaBold24", w / 2, EFGM.MenuScale(2), Colors.whiteColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 1, Colors.blackColor)

    end

    if maxTransactionCount > 1 then

        local amountInput = vgui.Create("DTextEntry", confirmPanel)
        amountInput:SetPos(confirmPanel:GetWide() / 2 - EFGM.MenuScale(80), EFGM.MenuScale(35))
        amountInput:SetSize(EFGM.MenuScale(160), EFGM.MenuScale(15))
        amountInput:SetPlaceholderText("1-" .. maxTransactionCount)
        amountInput:SetNumeric(true)
        amountInput:SetUpdateOnType(true)
        amountInput:RequestFocus()

        amountInput.Think = function(self)

            amountInput:SetX(confirmPanel:GetWide() / 2 - EFGM.MenuScale(80))

            local num = math.Clamp(amountInput:GetInt() or 1, 1, maxTransactionCount)

            transactionCount = num
            transactionCost = i.value * num

            surface.SetFont("PuristaBold24")
            confirmText = "Purchase " .. transactionCount .. "x " .. i.fullName .. " (" .. i.displayName .. ") for ₽" .. comma_value(transactionCost) .. "?"
            confirmTextSize = math.max(EFGM.MenuScale(300), surface.GetTextSize(confirmText))

        end

    end

    yesButton.OnCursorEntered = function(s)

        surface.PlaySound("ui/element_hover_" .. math.random(1, 3) .. ".wav")

    end

    function yesButton:DoClick()

        surface.PlaySound("ui/success.wav")
        confirmPanel:AlphaTo(0, 0.1, 0, function() confirmPanel:Remove() end)

        if transactionDestination == "stash" then PurchaseItem(item, transactionCount) elseif transactionDestination == "inv" then PurchaseItemToInv(item, transactionCount) end

        if closeMenu == true then

            Menu.MenuFrame.Closing = true
            Menu.MenuFrame:SetKeyboardInputEnabled(false)
            Menu.MenuFrame:SetMouseInputEnabled(false)
            Menu.IsOpen = false

            Menu.MenuFrame:AlphaTo(0, 0.1, 0, function()
                Menu.MenuFrame:Close()
            end)

        end

    end

    local cd = false

    function confirmPanel:OnKeyCodePressed(key)

        if (key == KEY_ENTER or key == KEY_SPACE) and cd == false then yesButton:DoClick() cd = true end

    end

    noButton.OnCursorEntered = function(s)

        surface.PlaySound("ui/element_hover_" .. math.random(1, 3) .. ".wav")

    end

    function noButton:DoClick()

        surface.PlaySound("ui/element_deselect.wav")
        confirmPanel:AlphaTo(0, 0.1, 0, function() confirmPanel:Remove() end)

        if closeMenu == true then

            Menu.MenuFrame.Closing = true
            Menu.MenuFrame:SetKeyboardInputEnabled(false)
            Menu.MenuFrame:SetMouseInputEnabled(false)
            Menu.IsOpen = false

            Menu.MenuFrame:AlphaTo(0, 0.1, 0, function()
                Menu.MenuFrame:Close()
            end)

        end

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
            if att == nil then continue end

            transactionCost = transactionCost + math.floor(att.value * sellMultiplier)

        end

    end

    local maxTransactionCount = math.Clamp(data.count or 1, 1, i.stackSize)

    if maxTransactionCount <= 1 and GetConVar("efgm_menu_sellprompt_single"):GetInt() == 0 then

        surface.PlaySound("ui/success.wav")
        SellItem(item, maxTransactionCount, key)
        return

    elseif maxTransactionCount > 1 and GetConVar("efgm_menu_sellprompt_stacked"):GetInt() == 0 then

        surface.PlaySound("ui/success.wav")
        SellItem(item, maxTransactionCount, key)
        return

    end

    surface.SetFont("PuristaBold24")
    local confirmText = "Sell " .. transactionCount .. "x " .. i.fullName .. " (" .. i.displayName .. ") for ₽" .. comma_value(transactionCost) .. "?"
    local confirmTextSize = math.max(EFGM.MenuScale(300), surface.GetTextSize(confirmText))

    local confirmPanelHeight = EFGM.MenuScale(70)

    if i.stackSize > 1 and maxTransactionCount > 1 then confirmPanelHeight = EFGM.MenuScale(100) end

    surface.PlaySound("ui/element_select.wav")

    confirmPanel = vgui.Create("DFrame", Menu.MenuFrame)
    confirmPanel:SetSize(confirmTextSize + EFGM.MenuScale(10), confirmPanelHeight)
    confirmPanel:SetPos(Menu.MenuFrame:GetWide() / 2 - confirmPanel:GetWide() / 2, Menu.MenuFrame:GetTall() / 2 - confirmPanel:GetTall() / 2)
    confirmPanel:SetAlpha(0)
    confirmPanel:SetTitle("")
    confirmPanel:ShowCloseButton(false)
    confirmPanel:SetScreenLock(true)
    confirmPanel:AlphaTo(255, 0.1, 0, nil)
    confirmPanel:RequestFocus()

    confirmPanel.Paint = function(s, w, h)

        confirmPanel:SetWide(confirmTextSize + EFGM.MenuScale(10))
        confirmPanel:SetX(Menu.MenuFrame:GetWide() / 2 - confirmPanel:GetWide() / 2)

        BlurPanel(s, EFGM.MenuScale(3))

        surface.SetDrawColor(Color(20, 20, 20, 205))
        surface.DrawRect(0, 0, w, h)

        surface.SetDrawColor(Colors.transparentWhiteColor)
        surface.DrawRect(0, 0, w, EFGM.MenuScale(6))

        surface.SetDrawColor(Colors.whiteBorderColor)
        surface.DrawRect(0, 0, w, EFGM.MenuScale(1))
        surface.DrawRect(0, h - 1, w, EFGM.MenuScale(1))
        surface.DrawRect(0, 0, EFGM.MenuScale(1), h)
        surface.DrawRect(w - 1, 0, EFGM.MenuScale(1), h)

        draw.SimpleTextOutlined(confirmText, "PuristaBold24", w / 2, EFGM.MenuScale(5), Colors.whiteColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 1, Colors.blackColor)

    end

    confirmPanel.Think = function()

        if (input.IsMouseDown(MOUSE_LEFT) or input.IsMouseDown(MOUSE_RIGHT) or input.IsMouseDown(MOUSE_MIDDLE) or input.IsMouseDown(MOUSE_WHEEL_DOWN) or input.IsMouseDown(MOUSE_WHEEL_UP)) and !confirmPanel:IsChildHovered() and !confirmPanel:IsHovered() then confirmPanel:AlphaTo(0, 0.1, 0, function() confirmPanel:Remove() end) end

    end

    surface.SetFont("PuristaBold24")
    local yesText = "YES [SPACE]"
    local yesTextSize = surface.GetTextSize(yesText)
    local yesButtonSize = yesTextSize + EFGM.MenuScale(10)

    local yesButton = vgui.Create("DButton", confirmPanel)
    yesButton:SetPos(confirmPanel:GetWide() / 2 - (yesButtonSize / 2) - EFGM.MenuScale(25), confirmPanelHeight - EFGM.MenuScale(35))
    yesButton:SetSize(yesButtonSize, EFGM.MenuScale(28))
    yesButton:SetText("")
    yesButton.Paint = function(s, w, h)

        yesButton:SetX(confirmPanel:GetWide() / 2 - (yesButtonSize / 2) - EFGM.MenuScale(25))

        surface.SetDrawColor(Colors.containerBackgroundColor)
        surface.DrawRect(0, 0, yesTextSize + EFGM.MenuScale(10), h)

        surface.SetDrawColor(Colors.transparentWhiteColor)
        surface.DrawRect(0, 0, yesTextSize + EFGM.MenuScale(10), EFGM.MenuScale(2))

        draw.SimpleTextOutlined(yesText, "PuristaBold24", w / 2, EFGM.MenuScale(2), Colors.whiteColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 1, Colors.blackColor)

    end

    surface.SetFont("PuristaBold24")
    local noText = "NO"
    local noTextSize = surface.GetTextSize(noText)
    local noButtonSize = noTextSize + EFGM.MenuScale(10)

    local noButton = vgui.Create("DButton", confirmPanel)
    noButton:SetPos(confirmPanel:GetWide() / 2 - (noButtonSize / 2) + yesButton:GetWide() / 2 + EFGM.MenuScale(5), confirmPanelHeight - EFGM.MenuScale(35))
    noButton:SetSize(noButtonSize, EFGM.MenuScale(28))
    noButton:SetText("")
    noButton.Paint = function(s, w, h)

        noButton:SetX(confirmPanel:GetWide() / 2 - (noButtonSize / 2) + yesButton:GetWide() / 2 + EFGM.MenuScale(5))

        surface.SetDrawColor(Colors.containerBackgroundColor)
        surface.DrawRect(0, 0, noButtonSize + EFGM.MenuScale(10), h)

        surface.SetDrawColor(Colors.transparentWhiteColor)
        surface.DrawRect(0, 0, noButtonSize + EFGM.MenuScale(10), EFGM.MenuScale(2))

        draw.SimpleTextOutlined(noText, "PuristaBold24", w / 2, EFGM.MenuScale(2), Colors.whiteColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 1, Colors.blackColor)

    end

    if i.stackSize > 1 and maxTransactionCount > 1 then

        local amountSlider = vgui.Create("DNumSlider", confirmPanel)
        amountSlider:SetPos(confirmPanel:GetWide() / 2 - EFGM.MenuScale(160), EFGM.MenuScale(35))
        amountSlider:SetSize(EFGM.MenuScale(240), EFGM.MenuScale(15))
        amountSlider:SetMin(1)
        amountSlider:SetMax(maxTransactionCount)
        amountSlider:SetValue(data.count)
        amountSlider:SetDefaultValue(data.count)
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
                    if att == nil then continue end

                    transactionCost = transactionCost + math.floor(att.value * sellMultiplier)

                end

            end

            surface.SetFont("PuristaBold24")
            confirmText = "Sell " .. transactionCount .. "x " .. i.fullName .. " (" .. i.displayName .. ") for ₽" .. comma_value(transactionCost) .. "?"
            confirmTextSize = math.max(EFGM.MenuScale(300), surface.GetTextSize(confirmText))

        end

        amountSlider:OnValueChanged(data.count)

        amountSlider.Think = function()

            -- amountSlider:SetX(confirmPanel:GetWide() / 2 - EFGM.MenuScale(160))

        end

    end

    yesButton.OnCursorEntered = function(s)

        surface.PlaySound("ui/element_hover_" .. math.random(1, 3) .. ".wav")

    end

    function yesButton:DoClick()

        surface.PlaySound("ui/success.wav")
        confirmPanel:AlphaTo(0, 0.1, 0, function() confirmPanel:Remove() end)
        SellItem(item, transactionCount, key)

    end

    local cd = false

    function confirmPanel:OnKeyCodePressed(key)

        if (key == KEY_ENTER or key == KEY_SPACE) and cd == false then yesButton:DoClick() cd = true end

    end

    noButton.OnCursorEntered = function(s)

        surface.PlaySound("ui/element_hover_" .. math.random(1, 3) .. ".wav")

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
    confirmPanel:SetPos(Menu.MenuFrame:GetWide() / 2 - confirmPanel:GetWide() / 2, Menu.MenuFrame:GetTall() / 2 - confirmPanel:GetTall() / 2)
    confirmPanel:SetAlpha(0)
    confirmPanel:SetTitle("")
    confirmPanel:ShowCloseButton(false)
    confirmPanel:SetScreenLock(true)
    confirmPanel:AlphaTo(255, 0.1, 0, nil)
    confirmPanel:RequestFocus()

    confirmPanel.Paint = function(s, w, h)

        confirmPanel:SetWide(confirmTextSize + EFGM.MenuScale(10))
        confirmPanel:SetX(Menu.MenuFrame:GetWide() / 2 - confirmPanel:GetWide() / 2)

        BlurPanel(s, EFGM.MenuScale(3))

        surface.SetDrawColor(Color(20, 20, 20, 205))
        surface.DrawRect(0, 0, w, h)

        surface.SetDrawColor(Colors.transparentWhiteColor)
        surface.DrawRect(0, 0, w, EFGM.MenuScale(6))

        surface.SetDrawColor(Colors.whiteBorderColor)
        surface.DrawRect(0, 0, w, EFGM.MenuScale(1))
        surface.DrawRect(0, h - 1, w, EFGM.MenuScale(1))
        surface.DrawRect(0, 0, EFGM.MenuScale(1), h)
        surface.DrawRect(w - 1, 0, EFGM.MenuScale(1), h)

        draw.SimpleTextOutlined(confirmText, "PuristaBold24", w / 2, EFGM.MenuScale(5), Colors.whiteColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 1, Colors.blackColor)

    end

    confirmPanel.Think = function()

        if (input.IsMouseDown(MOUSE_LEFT) or input.IsMouseDown(MOUSE_RIGHT) or input.IsMouseDown(MOUSE_MIDDLE) or input.IsMouseDown(MOUSE_WHEEL_DOWN) or input.IsMouseDown(MOUSE_WHEEL_UP)) and !confirmPanel:IsChildHovered() and !confirmPanel:IsHovered() then confirmPanel:AlphaTo(0, 0.1, 0, function() confirmPanel:Remove() end) end

    end

    surface.SetFont("PuristaBold24")
    local yesText = "YES [SPACE]"
    local yesTextSize = surface.GetTextSize(yesText)
    local yesButtonSize = yesTextSize + EFGM.MenuScale(10)

    local yesButton = vgui.Create("DButton", confirmPanel)
    yesButton:SetPos(confirmPanel:GetWide() / 2 - (yesButtonSize / 2) - EFGM.MenuScale(25), confirmPanelHeight - EFGM.MenuScale(35))
    yesButton:SetSize(yesButtonSize, EFGM.MenuScale(28))
    yesButton:SetText("")
    yesButton.Paint = function(s, w, h)

        yesButton:SetX(confirmPanel:GetWide() / 2 - (yesButtonSize / 2) - EFGM.MenuScale(25))

        surface.SetDrawColor(Colors.containerBackgroundColor)
        surface.DrawRect(0, 0, yesTextSize + EFGM.MenuScale(10), h)

        surface.SetDrawColor(Colors.transparentWhiteColor)
        surface.DrawRect(0, 0, yesTextSize + EFGM.MenuScale(10), EFGM.MenuScale(2))

        draw.SimpleTextOutlined(yesText, "PuristaBold24", w / 2, EFGM.MenuScale(2), Colors.whiteColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 1, Colors.blackColor)

    end

    surface.SetFont("PuristaBold24")
    local noText = "NO"
    local noTextSize = surface.GetTextSize(noText)
    local noButtonSize = noTextSize + EFGM.MenuScale(10)

    local noButton = vgui.Create("DButton", confirmPanel)
    noButton:SetPos(confirmPanel:GetWide() / 2 - (noButtonSize / 2) + yesButton:GetWide() / 2 + EFGM.MenuScale(5), confirmPanelHeight - EFGM.MenuScale(35))
    noButton:SetSize(noButtonSize, EFGM.MenuScale(28))
    noButton:SetText("")
    noButton.Paint = function(s, w, h)

        noButton:SetX(confirmPanel:GetWide() / 2 - (noButtonSize / 2) + yesButton:GetWide() / 2 + EFGM.MenuScale(5))

        surface.SetDrawColor(Colors.containerBackgroundColor)
        surface.DrawRect(0, 0, noButtonSize + EFGM.MenuScale(10), h)

        surface.SetDrawColor(Colors.transparentWhiteColor)
        surface.DrawRect(0, 0, noButtonSize + EFGM.MenuScale(10), EFGM.MenuScale(2))

        draw.SimpleTextOutlined(noText, "PuristaBold24", w / 2, EFGM.MenuScale(2), Colors.whiteColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 1, Colors.blackColor)

    end

    local amountSlider = vgui.Create("DNumSlider", confirmPanel)
    amountSlider:SetPos(confirmPanel:GetWide() / 2 - EFGM.MenuScale(160), EFGM.MenuScale(35))
    amountSlider:SetSize(EFGM.MenuScale(240), EFGM.MenuScale(15))
    amountSlider:SetMin(1)
    amountSlider:SetMax(maxSplitCount)
    amountSlider:SetValue(math.Round(data.count / 2))
    amountSlider:SetDefaultValue(math.Round(data.count / 2))
    amountSlider:SetDecimals(0)

    local num = 1
    amountSlider.OnValueChanged = function(self, val)

        if val == num then return end

        num = math.Round(val)
        splitCount = num

    end

    amountSlider:OnValueChanged(math.Round(data.count / 2))

    amountSlider.Think = function()

        -- amountSlider:SetX(confirmPanel:GetWide() / 2 - EFGM.MenuScale(160))

    end

    yesButton.OnCursorEntered = function(s)

        surface.PlaySound("ui/element_hover_" .. math.random(1, 3) .. ".wav")

    end

    function yesButton:DoClick()

        surface.PlaySound("ui/element_select.wav")
        confirmPanel:AlphaTo(0, 0.1, 0, function() confirmPanel:Remove() end)
        SplitFromInventory(inv, item, splitCount, key)

    end

    local cd = false

    function confirmPanel:OnKeyCodePressed(key)

        if (key == KEY_ENTER or key == KEY_SPACE) and cd == false then yesButton:DoClick() cd = true end

    end

    noButton.OnCursorEntered = function(s)

        surface.PlaySound("ui/element_hover_" .. math.random(1, 3) .. ".wav")

    end

    function noButton:DoClick()

        surface.PlaySound("ui/element_deselect.wav")
        confirmPanel:AlphaTo(0, 0.1, 0, function() confirmPanel:Remove() end)

    end

end

function Menu.ConfirmDelete(item, key, inv, eID, eSlot)

    if IsValid(confirmPanel) then confirmPanel:Remove() end

    local i = EFGMITEMS[item]
    if i == nil then confirmPanel:Remove() return end

    if GetConVar("efgm_menu_deleteprompt"):GetInt() == 0 then

        surface.PlaySound("ui/element_select.wav")
        DeleteFromInventory(inv, item, key, eID, eSlot)
        return

    end

    surface.SetFont("PuristaBold24")
    local confirmText = "Delete " .. i.fullName .. " (" .. i.displayName .. ")?"
    local confirmTextSize = math.max(EFGM.MenuScale(300), surface.GetTextSize(confirmText))

    local confirmPanelHeight = EFGM.MenuScale(70)

    surface.PlaySound("ui/element_select.wav")

    confirmPanel = vgui.Create("DFrame", Menu.MenuFrame)
    confirmPanel:SetSize(confirmTextSize + EFGM.MenuScale(10), confirmPanelHeight)
    confirmPanel:SetPos(Menu.MenuFrame:GetWide() / 2 - confirmPanel:GetWide() / 2, Menu.MenuFrame:GetTall() / 2 - confirmPanel:GetTall() / 2)
    confirmPanel:SetAlpha(0)
    confirmPanel:SetTitle("")
    confirmPanel:ShowCloseButton(false)
    confirmPanel:SetScreenLock(true)
    confirmPanel:AlphaTo(255, 0.1, 0, nil)
    confirmPanel:RequestFocus()

    confirmPanel.Paint = function(s, w, h)

        confirmPanel:SetWide(confirmTextSize + EFGM.MenuScale(10))
        confirmPanel:SetX(Menu.MenuFrame:GetWide() / 2 - confirmPanel:GetWide() / 2)

        BlurPanel(s, EFGM.MenuScale(3))

        surface.SetDrawColor(Color(20, 20, 20, 205))
        surface.DrawRect(0, 0, w, h)

        surface.SetDrawColor(Colors.transparentWhiteColor)
        surface.DrawRect(0, 0, w, EFGM.MenuScale(6))

        surface.SetDrawColor(Colors.whiteBorderColor)
        surface.DrawRect(0, 0, w, EFGM.MenuScale(1))
        surface.DrawRect(0, h - 1, w, EFGM.MenuScale(1))
        surface.DrawRect(0, 0, EFGM.MenuScale(1), h)
        surface.DrawRect(w - 1, 0, EFGM.MenuScale(1), h)

        draw.SimpleTextOutlined(confirmText, "PuristaBold24", w / 2, EFGM.MenuScale(5), Colors.whiteColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 1, Colors.blackColor)

    end

    confirmPanel.Think = function()

        if (input.IsMouseDown(MOUSE_LEFT) or input.IsMouseDown(MOUSE_RIGHT) or input.IsMouseDown(MOUSE_MIDDLE) or input.IsMouseDown(MOUSE_WHEEL_DOWN) or input.IsMouseDown(MOUSE_WHEEL_UP)) and !confirmPanel:IsChildHovered() and !confirmPanel:IsHovered() then confirmPanel:AlphaTo(0, 0.1, 0, function() confirmPanel:Remove() end) end

    end

    surface.SetFont("PuristaBold24")
    local yesText = "YES [SPACE]"
    local yesTextSize = surface.GetTextSize(yesText)
    local yesButtonSize = yesTextSize + EFGM.MenuScale(10)

    local yesButton = vgui.Create("DButton", confirmPanel)
    yesButton:SetPos(confirmPanel:GetWide() / 2 - (yesButtonSize / 2) - EFGM.MenuScale(25), confirmPanelHeight - EFGM.MenuScale(35))
    yesButton:SetSize(yesButtonSize, EFGM.MenuScale(28))
    yesButton:SetText("")
    yesButton.Paint = function(s, w, h)

        yesButton:SetX(confirmPanel:GetWide() / 2 - (yesButtonSize / 2) - EFGM.MenuScale(25))

        surface.SetDrawColor(Colors.containerBackgroundColor)
        surface.DrawRect(0, 0, yesTextSize + EFGM.MenuScale(10), h)

        surface.SetDrawColor(Colors.transparentWhiteColor)
        surface.DrawRect(0, 0, yesTextSize + EFGM.MenuScale(10), EFGM.MenuScale(2))

        draw.SimpleTextOutlined(yesText, "PuristaBold24", w / 2, EFGM.MenuScale(2), Colors.whiteColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 1, Colors.blackColor)

    end

    surface.SetFont("PuristaBold24")
    local noText = "NO"
    local noTextSize = surface.GetTextSize(noText)
    local noButtonSize = noTextSize + EFGM.MenuScale(10)

    local noButton = vgui.Create("DButton", confirmPanel)
    noButton:SetPos(confirmPanel:GetWide() / 2 - (noButtonSize / 2) + yesButton:GetWide() / 2 + EFGM.MenuScale(5), confirmPanelHeight - EFGM.MenuScale(35))
    noButton:SetSize(noButtonSize, EFGM.MenuScale(28))
    noButton:SetText("")
    noButton.Paint = function(s, w, h)

        noButton:SetX(confirmPanel:GetWide() / 2 - (noButtonSize / 2) + yesButton:GetWide() / 2 + EFGM.MenuScale(5))

        surface.SetDrawColor(Colors.containerBackgroundColor)
        surface.DrawRect(0, 0, noButtonSize + EFGM.MenuScale(10), h)

        surface.SetDrawColor(Colors.transparentWhiteColor)
        surface.DrawRect(0, 0, noButtonSize + EFGM.MenuScale(10), EFGM.MenuScale(2))

        draw.SimpleTextOutlined(noText, "PuristaBold24", w / 2, EFGM.MenuScale(2), Colors.whiteColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 1, Colors.blackColor)

    end

    yesButton.OnCursorEntered = function(s)

        surface.PlaySound("ui/element_hover_" .. math.random(1, 3) .. ".wav")

    end

    function yesButton:DoClick()

        surface.PlaySound("ui/element_select.wav")
        confirmPanel:AlphaTo(0, 0.1, 0, function() confirmPanel:Remove() end)
        DeleteFromInventory(inv, item, key, eID, eSlot)

    end

    local cd = false

    function confirmPanel:OnKeyCodePressed(key)

        if (key == KEY_ENTER or key == KEY_SPACE) and cd == false then yesButton:DoClick() cd = true end

    end

    noButton.OnCursorEntered = function(s)

        surface.PlaySound("ui/element_hover_" .. math.random(1, 3) .. ".wav")

    end

    function noButton:DoClick()

        surface.PlaySound("ui/element_deselect.wav")
        confirmPanel:AlphaTo(0, 0.1, 0, function() confirmPanel:Remove() end)

    end

end

function Menu.ConfirmTag(item, key, inv, eID, eSlot)

    if IsValid(confirmPanel) then confirmPanel:Remove() end

    local i = EFGMITEMS[item]
    if i == nil then confirmPanel:Remove() return end

    local tagString = ""

    surface.SetFont("PuristaBold24")
    local confirmText = "Set name tag for " .. i.fullName .. " (" .. i.displayName .. ")?"
    local confirmTextSize = math.max(EFGM.MenuScale(300), surface.GetTextSize(confirmText))

    local confirmPanelHeight = EFGM.MenuScale(110)

    confirmPanel = vgui.Create("DFrame", Menu.MenuFrame)
    confirmPanel:SetSize(confirmTextSize + EFGM.MenuScale(10), confirmPanelHeight)
    confirmPanel:SetPos(Menu.MenuFrame:GetWide() / 2 - confirmPanel:GetWide() / 2, Menu.MenuFrame:GetTall() / 2 - confirmPanel:GetTall() / 2)
    confirmPanel:SetAlpha(0)
    confirmPanel:SetTitle("")
    confirmPanel:ShowCloseButton(false)
    confirmPanel:SetScreenLock(true)
    confirmPanel:AlphaTo(255, 0.1, 0, nil)
    confirmPanel:RequestFocus()

    confirmPanel.Paint = function(s, w, h)

        confirmPanel:SetWide(confirmTextSize + EFGM.MenuScale(10))
        confirmPanel:SetX(Menu.MenuFrame:GetWide() / 2 - confirmPanel:GetWide() / 2)

        BlurPanel(s, EFGM.MenuScale(3))

        surface.SetDrawColor(Color(20, 20, 20, 205))
        surface.DrawRect(0, 0, w, h)

        surface.SetDrawColor(Colors.transparentWhiteColor)
        surface.DrawRect(0, 0, w, EFGM.MenuScale(6))

        surface.SetDrawColor(Colors.whiteBorderColor)
        surface.DrawRect(0, 0, w, EFGM.MenuScale(1))
        surface.DrawRect(0, h - 1, w, EFGM.MenuScale(1))
        surface.DrawRect(0, 0, EFGM.MenuScale(1), h)
        surface.DrawRect(w - 1, 0, EFGM.MenuScale(1), h)

        draw.SimpleTextOutlined(confirmText, "PuristaBold24", w / 2, EFGM.MenuScale(5), Colors.whiteColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 1, Colors.blackColor)

        draw.SimpleTextOutlined("CANNOT BE UNDONE", "PuristaBold16", w / 2, confirmPanelHeight - EFGM.MenuScale(55), Colors.whiteColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 1, Colors.blackColor)

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

        surface.SetDrawColor(Colors.containerBackgroundColor)
        surface.DrawRect(0, 0, yesTextSize + EFGM.MenuScale(10), h)

        surface.SetDrawColor(Colors.transparentWhiteColor)
        surface.DrawRect(0, 0, yesTextSize + EFGM.MenuScale(10), EFGM.MenuScale(2))

        draw.SimpleTextOutlined(yesText, "PuristaBold24", w / 2, EFGM.MenuScale(2), Colors.whiteColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 1, Colors.blackColor)

    end

    surface.SetFont("PuristaBold24")
    local noText = "NO"
    local noTextSize = surface.GetTextSize(noText)
    local noButtonSize = noTextSize + EFGM.MenuScale(10)

    local noButton = vgui.Create("DButton", confirmPanel)
    noButton:SetPos(confirmPanel:GetWide() / 2 - (noButtonSize / 2) + yesButton:GetWide() / 2 + EFGM.MenuScale(5), confirmPanelHeight - EFGM.MenuScale(35))
    noButton:SetSize(noButtonSize, EFGM.MenuScale(28))
    noButton:SetText("")
    noButton.Paint = function(s, w, h)

        noButton:SetX(confirmPanel:GetWide() / 2 - (noButtonSize / 2) + yesButton:GetWide() / 2 + EFGM.MenuScale(5))

        surface.SetDrawColor(Colors.containerBackgroundColor)
        surface.DrawRect(0, 0, noButtonSize + EFGM.MenuScale(10), h)

        surface.SetDrawColor(Colors.transparentWhiteColor)
        surface.DrawRect(0, 0, noButtonSize + EFGM.MenuScale(10), EFGM.MenuScale(2))

        draw.SimpleTextOutlined(noText, "PuristaBold24", w / 2, EFGM.MenuScale(2), Colors.whiteColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 1, Colors.blackColor)

    end

    local tagInput = vgui.Create("DTextEntry", confirmPanel)
    tagInput:SetPos(confirmPanel:GetWide() / 2 - EFGM.MenuScale(80), EFGM.MenuScale(35))
    tagInput:SetSize(EFGM.MenuScale(160), EFGM.MenuScale(15))
    tagInput:SetPlaceholderText("1-20 characters")
    tagInput:SetMaximumCharCount(20)
    tagInput:SetUpdateOnType(true)
    tagInput:RequestFocus()

    function tagInput:AllowInput(char)

        if char == "[" or char == "]" then return true end

    end

    tagInput.Think = function(self)

        tagInput:SetX(confirmPanel:GetWide() / 2 - EFGM.MenuScale(80))

        tagString = tagInput:GetValue()

    end

    yesButton.OnCursorEntered = function(s)

        surface.PlaySound("ui/element_hover_" .. math.random(1, 3) .. ".wav")

    end

    function yesButton:DoClick()

        if tagString == "" then return end

        surface.PlaySound("ui/element_tag.wav")
        confirmPanel:AlphaTo(0, 0.1, 0, function() confirmPanel:Remove() end)
        TagFromInventory(tagString, inv, item, key, eID, eSlot)

    end

    noButton.OnCursorEntered = function(s)

        surface.PlaySound("ui/element_hover_" .. math.random(1, 3) .. ".wav")

    end

    function noButton:DoClick()

        surface.PlaySound("ui/element_deselect.wav")
        confirmPanel:AlphaTo(0, 0.1, 0, function() confirmPanel:Remove() end)

    end

end

function Menu.ConfirmPreset(atts, presetName, presetID, closeMenu)

    if IsValid(confirmPanel) then confirmPanel:Remove() end

    local confirmPanelHeight = EFGM.MenuScale(75)
    local highestAttSize = 0

    local transactionCost = 0
    local highestLvlAtt = 0

    local plyMoney = Menu.Player:GetNWInt("Money", 0)
    local plyLevel = Menu.Player:GetNWInt("Level", 1)

    for att, count in pairs(atts) do

        local i = EFGMITEMS[att]
        if i == nil then confirmPanel:Remove() return end

        transactionCost = transactionCost + (i.value * count)
        if (i.levelReq or 1) > highestLvlAtt then highestLvlAtt = (i.levelReq or 1) end

        confirmPanelHeight = confirmPanelHeight + EFGM.MenuScale(15)

        surface.SetFont("PuristaBold16")
        local attText = count .. "x " .. i.fullName .. " (" .. i.displayName .. "):   ₽" .. i.value
        local attTextSize = surface.GetTextSize(attText)

        if attTextSize > highestAttSize then highestAttSize = attTextSize end

    end

    -- can't afford all of the attachments for the preset
    if plyMoney < transactionCost then

        surface.PlaySound("ui/element_deselect.wav")

        if closeMenu == true then

            Menu.MenuFrame.Closing = true
            Menu.MenuFrame:SetKeyboardInputEnabled(false)
            Menu.MenuFrame:SetMouseInputEnabled(false)
            Menu.IsOpen = false

            Menu.MenuFrame:AlphaTo(0, 0.1, 0, function()
                Menu.MenuFrame:Close()
            end)

        end

        return

    end

    if plyLevel < highestLvlAtt then

        surface.PlaySound("ui/element_deselect.wav")

        if closeMenu == true then

            Menu.MenuFrame.Closing = true
            Menu.MenuFrame:SetKeyboardInputEnabled(false)
            Menu.MenuFrame:SetMouseInputEnabled(false)
            Menu.IsOpen = false

            Menu.MenuFrame:AlphaTo(0, 0.1, 0, function()
                Menu.MenuFrame:Close()
            end)

        end

        return

    end

    surface.SetFont("PuristaBold24")
    local confirmText = "Buy attachments for the " .. string.upper(presetName) .. " preset for ₽" .. comma_value(transactionCost) .. "?"
    local confirmTextSize = math.max(EFGM.MenuScale(300), surface.GetTextSize(confirmText))

    local confirmPanelSize = confirmTextSize + EFGM.MenuScale(10)
    if highestAttSize + EFGM.MenuScale(15) > confirmPanelSize then confirmPanelSize = highestAttSize + EFGM.MenuScale(15) end

    surface.PlaySound("ui/element_select.wav")

    confirmPanel = vgui.Create("DFrame", Menu.MenuFrame)
    confirmPanel:SetSize(confirmPanelSize, confirmPanelHeight)
    confirmPanel:SetPos(Menu.MenuFrame:GetWide() / 2 - confirmPanel:GetWide() / 2, Menu.MenuFrame:GetTall() / 2 - confirmPanel:GetTall() / 2)
    confirmPanel:SetAlpha(0)
    confirmPanel:SetTitle("")
    confirmPanel:ShowCloseButton(false)
    confirmPanel:SetScreenLock(true)
    confirmPanel:AlphaTo(255, 0.1, 0, nil)
    confirmPanel:RequestFocus()

    confirmPanel.Paint = function(s, w, h)

        confirmPanel:SetX(Menu.MenuFrame:GetWide() / 2 - confirmPanel:GetWide() / 2)

        BlurPanel(s, EFGM.MenuScale(3))

        surface.SetDrawColor(Color(20, 20, 20, 205))
        surface.DrawRect(0, 0, w, h)

        surface.SetDrawColor(Colors.transparentWhiteColor)
        surface.DrawRect(0, 0, w, EFGM.MenuScale(6))

        surface.SetDrawColor(Colors.whiteBorderColor)
        surface.DrawRect(0, 0, w, EFGM.MenuScale(1))
        surface.DrawRect(0, h - 1, w, EFGM.MenuScale(1))
        surface.DrawRect(0, 0, EFGM.MenuScale(1), h)
        surface.DrawRect(w - 1, 0, EFGM.MenuScale(1), h)

        draw.SimpleTextOutlined(confirmText, "PuristaBold24", w / 2, EFGM.MenuScale(5), Colors.whiteColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 1, Colors.blackColor)

        local num = 0

        for k, v in pairs(atts) do

            local i = EFGMITEMS[k]

            draw.SimpleTextOutlined(v .. "x " .. i.fullName .. " (" .. i.displayName .. "):", "PuristaBold16", EFGM.MenuScale(5), EFGM.MenuScale(30) + (EFGM.MenuScale(15) * num), Colors.whiteColor, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP, 1, Colors.blackColor)
            draw.SimpleTextOutlined("₽" .. (i.value * v), "PuristaBold16", w - EFGM.MenuScale(5), EFGM.MenuScale(30) + (EFGM.MenuScale(15) * num), Colors.whiteColor, TEXT_ALIGN_RIGHT, TEXT_ALIGN_TOP, 1, Colors.blackColor)

            num = num + 1

        end

    end

    confirmPanel.Think = function()

        if (input.IsMouseDown(MOUSE_LEFT) or input.IsMouseDown(MOUSE_RIGHT) or input.IsMouseDown(MOUSE_MIDDLE) or input.IsMouseDown(MOUSE_WHEEL_DOWN) or input.IsMouseDown(MOUSE_WHEEL_UP)) and !confirmPanel:IsChildHovered() and !confirmPanel:IsHovered() then

            confirmPanel:AlphaTo(0, 0.1, 0, function() confirmPanel:Remove() end)

            if closeMenu == true then

                Menu.MenuFrame.Closing = true
                Menu.MenuFrame:SetKeyboardInputEnabled(false)
                Menu.MenuFrame:SetMouseInputEnabled(false)
                Menu.IsOpen = false

                Menu.MenuFrame:AlphaTo(0, 0.1, 0, function()
                    Menu.MenuFrame:Close()
                end)

            end

        end

    end

    surface.SetFont("PuristaBold24")
    local yesText = "YES [SPACE]"
    local yesTextSize = surface.GetTextSize(yesText)
    local yesButtonSize = yesTextSize + EFGM.MenuScale(10)

    local yesButton = vgui.Create("DButton", confirmPanel)
    yesButton:SetPos(confirmPanel:GetWide() / 2 - EFGM.MenuScale(100), confirmPanelHeight - EFGM.MenuScale(35))
    yesButton:SetSize(yesButtonSize, EFGM.MenuScale(28))
    yesButton:SetText("")
    yesButton.Paint = function(s, w, h)

        yesButton:SetX(confirmPanel:GetWide() / 2 - (yesButtonSize / 2) - EFGM.MenuScale(25))

        surface.SetDrawColor(Colors.containerBackgroundColor)
        surface.DrawRect(0, 0, yesTextSize + EFGM.MenuScale(10), h)

        surface.SetDrawColor(Colors.transparentWhiteColor)
        surface.DrawRect(0, 0, yesTextSize + EFGM.MenuScale(10), EFGM.MenuScale(2))

        draw.SimpleTextOutlined(yesText, "PuristaBold24", w / 2, EFGM.MenuScale(2), Colors.whiteColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 1, Colors.blackColor)

    end

    surface.SetFont("PuristaBold24")
    local noText = "NO"
    local noTextSize = surface.GetTextSize(noText)
    local noButtonSize = noTextSize + EFGM.MenuScale(10)

    local noButton = vgui.Create("DButton", confirmPanel)
    noButton:SetPos(confirmPanel:GetWide() / 2 - (noButtonSize / 2) + yesButton:GetWide() / 2 + EFGM.MenuScale(5), confirmPanelHeight - EFGM.MenuScale(35))
    noButton:SetSize(noButtonSize, EFGM.MenuScale(28))
    noButton:SetText("")
    noButton.Paint = function(s, w, h)

        noButton:SetX(confirmPanel:GetWide() / 2 - (noButtonSize / 2) + yesButton:GetWide() / 2 + EFGM.MenuScale(5))

        surface.SetDrawColor(Colors.containerBackgroundColor)
        surface.DrawRect(0, 0, noButtonSize + EFGM.MenuScale(10), h)

        surface.SetDrawColor(Colors.transparentWhiteColor)
        surface.DrawRect(0, 0, noButtonSize + EFGM.MenuScale(10), EFGM.MenuScale(2))

        draw.SimpleTextOutlined(noText, "PuristaBold24", w / 2, EFGM.MenuScale(2), Colors.whiteColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 1, Colors.blackColor)

    end

    yesButton.OnCursorEntered = function(s)

        surface.PlaySound("ui/element_hover_" .. math.random(1, 3) .. ".wav")

    end

    function yesButton:DoClick()

        surface.PlaySound("ui/success.wav")
        confirmPanel:AlphaTo(0, 0.1, 0, function() confirmPanel:Remove() end)

        PurchasePresetToInventory(atts)

        if closeMenu == true then

            Menu.MenuFrame.Closing = true
            Menu.MenuFrame:SetKeyboardInputEnabled(false)
            Menu.MenuFrame:SetMouseInputEnabled(false)
            Menu.IsOpen = false

            Menu.MenuFrame:AlphaTo(0, 0.1, 0, function()
                Menu.MenuFrame:Close()
                local wep = Menu.Player:GetActiveWeapon()
                if wep != NULL then wep:LoadPreset(presetID) end
            end)

        end

    end

    local cd = false

    function confirmPanel:OnKeyCodePressed(key)

        if (key == KEY_ENTER or key == KEY_SPACE) and cd == false then yesButton:DoClick() cd = true end

    end

    noButton.OnCursorEntered = function(s)

        surface.PlaySound("ui/element_hover_" .. math.random(1, 3) .. ".wav")

    end

    function noButton:DoClick()

        surface.PlaySound("ui/element_deselect.wav")
        confirmPanel:AlphaTo(0, 0.1, 0, function() confirmPanel:Remove() end)

        if closeMenu == true then

            Menu.MenuFrame.Closing = true
            Menu.MenuFrame:SetKeyboardInputEnabled(false)
            Menu.MenuFrame:SetMouseInputEnabled(false)
            Menu.IsOpen = false

            Menu.MenuFrame:AlphaTo(0, 0.1, 0, function()
                Menu.MenuFrame:Close()
            end)

        end

    end

end

Menu.OpenTab = {}

local itemSearchText = ""

function Menu.ReloadInventory()

    if !IsValid(playerItems) then return end

    playerItems:Clear()
    plyItems = {}

    for k, v in ipairs(playerInventory) do

        local def = EFGMITEMS[v.name]
        if def == nil then continue end

        local consumableType = def.consumableType
        local baseValue = def.value

        plyItems[k] = {
            name = v.name,
            id = k,
            data = v.data,
            value = (consumableType != "heal" and consumableType != "key") and (baseValue * math.min(math.max(v.data.count, 1), def.stackSize))
            or math.floor(baseValue * (v.data.durability / def.consumableValue)),
            def = def
        }

        if v.data.att then

            local atts = GetPrefixedAttachmentListFromCode(v.data.att)
            if !atts then return end

            for _, a in ipairs(atts) do

                local att = EFGMITEMS[a]
                if att == nil then continue end

                plyItems[k].value = plyItems[k].value + att.value

            end

        end

    end

    if plyItems[1] == nil then return end

    table.sort(plyItems, function(a, b)

        local a_def = a.def or EFGMITEMS[a.name]
        local b_def = b.def or EFGMITEMS[b.name]

        local a_size = a_def.sizeX * a_def.sizeY
        local b_size = b_def.sizeX * b_def.sizeY

        if a_size != b_size then
            return a_size > b_size
        end

        if a_def.equipType != b_def.equipType then
            return a_def.equipType < b_def.equipType
        end

        if a_def.displayName != b_def.displayName then
            return a_def.displayName < b_def.displayName
        end

        if a.data.tag != b.data.tag then
            if !a.data.tag then return false end
            if !b.data.tag then return true end
            return string.upper(a.data.tag) < string.upper(b.data.tag)
        end

        if a.data.durability and b.data.durability then
            return a.data.durability > b.data.durability
        end

        if a.data.count > 1 and b.data.count > 1 then
            return a.data.count > b.data.count
        end

        if a.value and b.value then
            return a.value > b.value
        end

    end)

    -- inventory item entry
    for k, v in ipairs(plyItems) do

        local i = v.def or EFGMITEMS[v.name]
        if i == nil then continue end

        local ownerName = nil
        if v.data.owner then
            ownerName = EFGM.SteamNameCache[v.data.owner]
            if !ownerName then
                steamworks.RequestPlayerInfo(v.data.owner, function(steamName) EFGM.SteamNameCache[v.data.owner] = steamName or "" end)
            end
        end

        if itemSearchText then itemSearch = itemSearchText end

        local searchFor = (itemSearch and itemSearch:lower()) or ""

        if searchFor != "" and
            !string.find((i.fullName):lower(), searchFor, 1, true) and
            !string.find((i.displayName):lower(), searchFor, 1, true) and
            !string.find((i.displayType):lower(), searchFor, 1, true) and
            !string.find((tostring(v.data.tag) or ""):lower(), searchFor, 1, true) and
            !string.find((ownerName or ""):lower(), searchFor, 1, true) then continue
        end

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

        if Menu.Player:CompareStatus(0) and (IsValid(Menu.Container) and table.IsEmpty(Menu.Container)) then item:Droppable("stash") end

        function item:Paint(w, h)

            if !self:IsHovered() then surface.SetDrawColor(Colors.itemBackgroundColor) else surface.SetDrawColor(Colors.itemBackgroundColorHovered) end
            surface.DrawRect(0, 0, w, EFGM.MenuScale(1))
            surface.DrawRect(0, h - 1, w, EFGM.MenuScale(1))
            surface.DrawRect(0, 0, EFGM.MenuScale(1), h)
            surface.DrawRect(w - 1, 0, EFGM.MenuScale(1), h)

            surface.SetDrawColor(i.iconColor or Colors.itemColor)
            surface.DrawRect(0, 0, w, h)

            surface.SetDrawColor(Colors.pureWhiteColor)
            surface.SetMaterial(i.icon)
            surface.DrawTexturedRect(0, 0, w, h)

        end

        surface.SetFont("Purista18")

        local nameSize = surface.GetTextSize(i.displayName)
        local nameFont
        local tagFont
        local tagH

        if nameSize <= (EFGM.MenuScale(46.5 * i.sizeX)) then nameFont = "PuristaBold18" tagFont = "PuristaBold14" tagH = EFGM.MenuScale(12)
        else nameFont = "PuristaBold14" tagFont = "PuristaBold10" tagH = EFGM.MenuScale(10) end

        local duraSize = nil
        local duraSizeY = nil
        local duraFont = nil

        if i.consumableType == "heal" or i.consumableType == "key" then
            duraSize = surface.GetTextSize(i.consumableValue .. "/" .. i.consumableValue)

            if duraSize <= (EFGM.MenuScale(46.5 * i.sizeX)) then duraFont = "PuristaBold18" duraSizeY = EFGM.MenuScale(19)
            else duraFont = "PuristaBold14" duraSizeY = EFGM.MenuScale(15) end
        end

        function item:PaintOver(w, h)

            draw.SimpleTextOutlined(i.displayName, nameFont, w - EFGM.MenuScale(3), EFGM.MenuScale(-1), Colors.whiteColor, TEXT_ALIGN_RIGHT, TEXT_ALIGN_TOP, 1, Colors.blackColor)

            if i.equipType == EQUIPTYPE.Ammunition and i.stackSize > 1 then
                draw.SimpleTextOutlined(v.data.count, "PuristaBold18", w - EFGM.MenuScale(3), h - EFGM.MenuScale(19), Colors.whiteColor, TEXT_ALIGN_RIGHT, TEXT_ALIGN_TOP, 1, Colors.blackColor)
            elseif i.consumableType == "heal" or i.consumableType == "key" then
                draw.SimpleTextOutlined(v.data.durability .. "/" .. i.consumableValue, duraFont, w - EFGM.MenuScale(3), h - duraSizeY, Colors.whiteColor, TEXT_ALIGN_RIGHT, TEXT_ALIGN_TOP, 1, Colors.blackColor)
            end

            if i.caliber then

                draw.SimpleTextOutlined(i.caliber, "PuristaBold18", EFGM.MenuScale(3), h - EFGM.MenuScale(19), Colors.whiteColor, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP, 1, Colors.blackColor)

            end

            if v.data.tag then

                draw.SimpleTextOutlined(v.data.tag, tagFont, w - EFGM.MenuScale(3), tagH, Colors.whiteColor, TEXT_ALIGN_RIGHT, TEXT_ALIGN_TOP, 1, Colors.blackColor)

            end

            if v.data.fir then

                surface.SetDrawColor(Colors.pureWhiteColor)
                surface.SetMaterial(Mats.firIcon)

                if (i.equipType == EQUIPTYPE.Ammunition and v.data.count > 1) or i.consumableType == "heal" or i.consumableType == "key" then

                    surface.DrawTexturedRect(w - EFGM.MenuScale(17), h - EFGM.MenuScale(31), EFGM.MenuScale(14), EFGM.MenuScale(14))

                else

                    surface.DrawTexturedRect(w - EFGM.MenuScale(17), h - EFGM.MenuScale(17), EFGM.MenuScale(14), EFGM.MenuScale(14))

                end

            end

        end

        item.OnCursorEntered = function(s)

            surface.PlaySound("ui/inv_item_hover_" .. math.random(1, 3) .. ".wav")

        end

        function item:DoClick()

            if input.IsKeyDown(KEY_LSHIFT) and (Menu.Player:CompareStatus(0) and table.IsEmpty(Menu.Container)) then

                surface.PlaySound("ui/inv_item_tostash_" .. math.random(1, 7) .. ".wav")
                StashItemFromInventory(v.id)

            end

            if input.IsKeyDown(KEY_LALT) and (i.equipType == EQUIPTYPE.Weapon) then

                surface.PlaySound("ui/equip_" .. math.random(1, 6) .. ".wav")
                EquipItemFromInventory(v.id, i.equipSlot)

            end

        end

        function item:DoDoubleClick()

            if GetConVar("efgm_menu_doubleclick_consume"):GetInt() == 1 and !Menu.Player:CompareStatus(0) and i.equipType == EQUIPTYPE.Consumable then

                ConsumeItemFromInventory(v.id)
                surface.PlaySound("ui/element_consume.wav")
                return

            end

            Menu.InspectItem(v.name, v.data)
            surface.PlaySound("ui/element_select.wav")

        end

        function item:DoRightClick()

            local x, y = itemsHolder:LocalCursorPos()
            local sideH, sideV

            surface.PlaySound("ui/context.wav")

            if x <= (itemsHolder:GetWide() / 2) then sideH = true else sideH = false end
            if y <= (itemsHolder:GetTall() / 2) then sideV = true else sideV = false end

            if IsValid(contextMenu) then contextMenu:Remove() end
            contextMenu = vgui.Create("EFGMContextMenu", itemsHolder)
            contextMenu:SetSize(EFGM.MenuScale(100), EFGM.MenuScale(10))
            contextMenu:DockPadding(EFGM.MenuScale(5), EFGM.MenuScale(5), EFGM.MenuScale(5), EFGM.MenuScale(5))
            contextMenu:SetAlpha(0)
            contextMenu:AlphaTo(255, 0.1, 0, nil)
            contextMenu:RequestFocus()

            local inspectButton = vgui.Create("EFGMContextButton", contextMenu)
            inspectButton:SetText("INSPECT")
            inspectButton.OnClickEvent = function()

                Menu.InspectItem(v.name, v.data)

            end

            -- actions that can be performed on this specific item
            -- default
            local actions = {
                droppable = true,
                equipable = false,
                consumable = false,
                splittable = false,
                stashable = false,
                deletable = false,
                ammoBuyable = false
            }

            actions.stashable = Menu.Player:CompareStatus(0) and table.IsEmpty(Menu.Container)
            actions.equipable = i.equipType == EQUIPTYPE.Weapon
            actions.splittable = i.stackSize > 1 and v.data.count > 1
            actions.consumable = !Menu.Player:CompareStatus(0) and i.equipType == EQUIPTYPE.Consumable
            actions.deletable = Menu.Player:CompareStatus(0)
            actions.ammoBuyable = Menu.Player:CompareStatus(0) and i.ammoID
            actions.taggable = Menu.Player:CompareStatus(0) and v.data.tag == nil and (actions.ammoBuyable or i.equipSlot == WEAPONSLOTS.MELEE.ID)

            if actions.stashable then

                local stashButton = vgui.Create("EFGMContextButton", contextMenu)
                stashButton:SetText("STASH")
                stashButton.OnClickSound = "ui/inv_item_tostash_" .. math.random(1, 7) .. ".wav"
                stashButton.OnClickEvent = function()

                    StashItemFromInventory(v.id)

                end

            end

            if actions.equipable then

                local equipButton = vgui.Create("EFGMContextButton", contextMenu)
                equipButton:SetText("EQUIP")
                equipButton.OnClickSound = "ui/equip_" .. math.random(1, 6) .. ".wav"
                equipButton.OnClickEvent = function()

                    EquipItemFromInventory(v.id, i.equipSlot)

                end

            end

            if actions.ammoBuyable then

                local buyAmmoButton = vgui.Create("EFGMContextButton", contextMenu)
                buyAmmoButton:SetText("BUY AMMO")
                buyAmmoButton.OnClickSound = "nil"
                buyAmmoButton.OnClickEvent = function()

                    Menu.ConfirmPurchase(i.ammoID, "inv", false)

                end

            end

            if actions.taggable then

                local tagButton = vgui.Create("EFGMContextButton", contextMenu)
                tagButton:SetText("SET TAG")
                tagButton.OnClickEvent = function()

                    Menu.ConfirmTag(v.name, v.id, "inv", 0, 0)

                end

            end

            if actions.consumable then

                local consumeButton = vgui.Create("EFGMContextButton", contextMenu)
                consumeButton:SetText("USE")
                consumeButton.OnClickSound = "ui/element_consume.wav"
                consumeButton.OnClickEvent = function()

                    ConsumeItemFromInventory(v.id)

                end

            end

            if actions.splittable then

                local splitButton = vgui.Create("EFGMContextButton", contextMenu)
                splitButton:SetText("SPLIT")
                splitButton.OnClickSound = "nil"
                splitButton.OnClickEvent = function()

                    Menu.ConfirmSplit(v.name, v.data, v.id, "inv")

                end

            end

            if actions.droppable then

                local dropButton = vgui.Create("EFGMContextButton", contextMenu)
                dropButton:SetText("DROP")
                dropButton.OnClickEvent = function()

                    DropItemFromInventory(v.id)

                end

            end

            if actions.deletable then

                local deleteButton = vgui.Create("EFGMContextButton", contextMenu)
                deleteButton:SetText("DELETE")
                deleteButton.OnClickSound = "nil"
                deleteButton.OnClickEvent = function()

                    Menu.ConfirmDelete(v.name, v.id, "inv", 0, 0)

                end

            end

            contextMenu:SetTallAfterCTX()

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

function Menu.ReloadSlots()

    if !IsValid(primaryWeaponHolder) then return end

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

        function primaryItem:Paint(w, h)

            if !self:IsHovered() then surface.SetDrawColor(Colors.itemBackgroundColor) else surface.SetDrawColor(Colors.itemBackgroundColorHovered) end
            surface.DrawRect(0, 0, w, EFGM.MenuScale(1))
            surface.DrawRect(0, h - 1, w, EFGM.MenuScale(1))
            surface.DrawRect(0, 0, EFGM.MenuScale(1), h)
            surface.DrawRect(w - 1, 0, EFGM.MenuScale(1), h)

            surface.SetDrawColor(i.iconColor or Colors.itemColor)
            surface.DrawRect(0, 0, w, h)

            surface.SetDrawColor(Colors.pureWhiteColor)
            surface.SetMaterial(i.icon)
            surface.DrawTexturedRect(0, 0, w, h)

        end

        surface.SetFont("Purista18")

        local nameSize = surface.GetTextSize(i.displayName)
        local nameFont
        local tagFont
        local tagH

        if nameSize <= (EFGM.MenuScale(46.5 * i.sizeX)) then nameFont = "PuristaBold18" tagFont = "PuristaBold14" tagH = EFGM.MenuScale(12)
        else nameFont = "PuristaBold14" tagFont = "PuristaBold10" tagH = EFGM.MenuScale(10) end

        local wep = Menu.Player:GetWeapon(playerWeaponSlots[1][1].name)
        local clip = 0
        local clipMax = 0
        local mag = ""

        if isfunction(wep.Clip1) then

            clip = wep:Clip1()
            clipMax = wep:GetMaxClip1()

        end

        if clip == 0 then mag = "Empty"
        elseif clip >= clipMax * 0.9 then mag = "Full"
        elseif clip >= clipMax * 0.8 then mag = "Nearly full"
        elseif clip >= clipMax * 0.4 then mag = "About half"
        elseif clip >= clipMax * 0.2 then mag = "Less than half"
        elseif clip >= clipMax * 0.01 then mag = "Almost empty"
        else mag = "Empty" end

        if clip == -1 then mag = "∞" end

        local magFont = "PuristaBold18"
        local magSizeY = EFGM.MenuScale(19)
        if i.sizeX <= 2 then magFont = "PuristaBold14" magSizeY = EFGM.MenuScale(15) end

        function primaryItem:PaintOver(w, h)

            draw.SimpleTextOutlined(i.displayName, nameFont, w - EFGM.MenuScale(3), EFGM.MenuScale(-1), Colors.whiteColor, TEXT_ALIGN_RIGHT, TEXT_ALIGN_TOP, 1, Colors.blackColor)

            if i.caliber then

                draw.SimpleTextOutlined(i.caliber, magFont, EFGM.MenuScale(3), h - magSizeY, Colors.whiteColor, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP, 1, Colors.blackColor)

            end

            if playerWeaponSlots[1][1].data and playerWeaponSlots[1][1].data.tag then

                draw.SimpleTextOutlined(playerWeaponSlots[1][1].data.tag, tagFont, w - EFGM.MenuScale(3), tagH, Colors.whiteColor, TEXT_ALIGN_RIGHT, TEXT_ALIGN_TOP, 1, Colors.blackColor)

            end

            if mag != "" then

                draw.SimpleTextOutlined(string.upper(mag), magFont, w - EFGM.MenuScale(3), h - magSizeY, Colors.whiteColor, TEXT_ALIGN_RIGHT, TEXT_ALIGN_TOP, 1, Colors.blackColor)

            end

            if playerWeaponSlots[1][1].data and playerWeaponSlots[1][1].data.fir then

                surface.SetDrawColor(Colors.pureWhiteColor)
                surface.SetMaterial(Mats.firIcon)

                if mag != "" then

                    surface.DrawTexturedRect(w - EFGM.MenuScale(16), h - EFGM.MenuScale(30), EFGM.MenuScale(14), EFGM.MenuScale(14))

                else

                    surface.DrawTexturedRect(w - EFGM.MenuScale(16), h - EFGM.MenuScale(16), EFGM.MenuScale(14), EFGM.MenuScale(14))

                end

            end

        end

        primaryItem.OnCursorEntered = function(s)

            surface.PlaySound("ui/inv_item_hover_" .. math.random(1, 3) .. ".wav")

        end

        function primaryItem:DoClick()

            if input.IsKeyDown(KEY_LSHIFT) then

                surface.PlaySound("ui/equip_" .. math.random(1, 6) .. ".wav")
                UnEquipItemFromInventory(primaryItem.SLOTID, primaryItem.SLOT)

            end

        end

        function primaryItem:DoDoubleClick()

            Menu.InspectItem(playerWeaponSlots[1][1].name, playerWeaponSlots[1][1].data)
            surface.PlaySound("ui/element_select.wav")

        end

        function primaryItem:DoRightClick()

            local x, y = equipmentHolder:LocalCursorPos()
            local sideH, sideV

            surface.PlaySound("ui/context.wav")

            if x <= (equipmentHolder:GetWide() / 2) then sideH = true else sideH = false end
            if y <= (equipmentHolder:GetTall() / 2) then sideV = true else sideV = false end

            if IsValid(contextMenu) then contextMenu:Remove() end
            contextMenu = vgui.Create("EFGMContextMenu", equipmentHolder)
            contextMenu:SetSize(EFGM.MenuScale(100), EFGM.MenuScale(10))
            contextMenu:DockPadding(EFGM.MenuScale(5), EFGM.MenuScale(5), EFGM.MenuScale(5), EFGM.MenuScale(5))
            contextMenu:SetAlpha(0)
            contextMenu:AlphaTo(255, 0.1, 0, nil)
            contextMenu:RequestFocus()

            local inspectButton = vgui.Create("EFGMContextButton", contextMenu)
            inspectButton:SetText("INSPECT")
            inspectButton.OnClickEvent = function()

                Menu.InspectItem(playerWeaponSlots[1][1].name, playerWeaponSlots[1][1].data)

            end

            if Menu.Player:CompareStatus(0) and table.IsEmpty(Menu.Container) then

                local stashButton = vgui.Create("EFGMContextButton", contextMenu)
                stashButton:SetText("STASH")
                stashButton.OnClickSound = "ui/equip_" .. math.random(1, 6) .. ".wav"
                stashButton.OnClickEvent = function()

                    StashItemFromEquipped(primaryItem.SLOTID, primaryItem.SLOT)

                end

            end

            local unequipButton = vgui.Create("EFGMContextButton", contextMenu)
            unequipButton:SetText("UNEQUIP")
            unequipButton.OnClickSound = "ui/equip_" .. math.random(1, 6) .. ".wav"
            unequipButton.OnClickEvent = function()

                UnEquipItemFromInventory(primaryItem.SLOTID, primaryItem.SLOT)

            end

            if Menu.Player:CompareStatus(0) then

                if i.ammoID then

                    local buyAmmoButton = vgui.Create("EFGMContextButton", contextMenu)
                    buyAmmoButton:SetText("BUY AMMO")
                    buyAmmoButton.OnClickSound = "nil"
                    buyAmmoButton.OnClickEvent = function()

                        Menu.ConfirmPurchase(i.ammoID, "inv", false)

                    end

                end

                if playerWeaponSlots[1][1].data.tag == nil then

                    local tagButton = vgui.Create("EFGMContextButton", contextMenu)
                    tagButton:SetText("SET TAG")
                    tagButton.OnClickEvent = function()

                        Menu.ConfirmTag(playerWeaponSlots[1][1].name, 0, "equipped", primaryItem.SLOTID, primaryItem.SLOT)

                    end

                end

            end

            local dropButton = vgui.Create("EFGMContextButton", contextMenu)
            dropButton:SetText("DROP")
            dropButton.OnClickEvent = function()

                DropEquippedItem(primaryItem.SLOTID, primaryItem.SLOT)

            end

            if Menu.Player:CompareStatus(0) then

                local deleteButton = vgui.Create("EFGMContextButton", contextMenu)
                deleteButton:SetText("DELETE")
                deleteButton.OnClickSound = "nil"
                deleteButton.OnClickEvent = function()

                    Menu.ConfirmDelete(playerWeaponSlots[1][1].name, 0, "equipped", primaryItem.SLOTID, primaryItem.SLOT)

                end

            end

            contextMenu:SetTallAfterCTX()

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

        end

    else

        primaryWeaponHolder:SetSize(EFGM.MenuScale(285), EFGM.MenuScale(114))
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

        function secondaryItem:Paint(w, h)

            if !self:IsHovered() then surface.SetDrawColor(Colors.itemBackgroundColor) else surface.SetDrawColor(Colors.itemBackgroundColorHovered) end
            surface.DrawRect(0, 0, w, EFGM.MenuScale(1))
            surface.DrawRect(0, h - 1, w, EFGM.MenuScale(1))
            surface.DrawRect(0, 0, EFGM.MenuScale(1), h)
            surface.DrawRect(w - 1, 0, EFGM.MenuScale(1), h)

            surface.SetDrawColor(i.iconColor or Colors.itemColor)
            surface.DrawRect(0, 0, w, h)

            surface.SetDrawColor(Colors.pureWhiteColor)
            surface.SetMaterial(i.icon)
            surface.DrawTexturedRect(0, 0, w, h)

        end

        surface.SetFont("Purista18")

        local nameSize = surface.GetTextSize(i.displayName)
        local nameFont
        local tagFont
        local tagH

        if nameSize <= (EFGM.MenuScale(46.5 * i.sizeX)) then nameFont = "PuristaBold18" tagFont = "PuristaBold14" tagH = EFGM.MenuScale(12)
        else nameFont = "PuristaBold14" tagFont = "PuristaBold10" tagH = EFGM.MenuScale(10) end

        local wep = Menu.Player:GetWeapon(playerWeaponSlots[1][2].name)
        local clip = 0
        local clipMax = 0
        local mag = ""

        if isfunction(wep.Clip1) then

            clip = wep:Clip1()
            clipMax = wep:GetMaxClip1()

        end

        if clip == 0 then mag = "Empty"
        elseif clip >= clipMax * 0.9 then mag = "Full"
        elseif clip >= clipMax * 0.8 then mag = "Nearly full"
        elseif clip >= clipMax * 0.4 then mag = "About half"
        elseif clip >= clipMax * 0.2 then mag = "Less than half"
        elseif clip >= clipMax * 0.01 then mag = "Almost empty"
        else mag = "Empty" end

        if clip == -1 then mag = "∞" end

        local magFont = "PuristaBold18"
        local magSizeY = EFGM.MenuScale(19)
        if i.sizeX <= 2 then magFont = "PuristaBold14" magSizeY = EFGM.MenuScale(15) end

        function secondaryItem:PaintOver(w, h)

            draw.SimpleTextOutlined(i.displayName, nameFont, w - EFGM.MenuScale(3), EFGM.MenuScale(-1), Colors.whiteColor, TEXT_ALIGN_RIGHT, TEXT_ALIGN_TOP, 1, Colors.blackColor)

            if i.caliber then

                draw.SimpleTextOutlined(i.caliber, magFont, EFGM.MenuScale(3), h - magSizeY, Colors.whiteColor, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP, 1, Colors.blackColor)

            end

            if playerWeaponSlots[1][2].data and playerWeaponSlots[1][2].data.tag then

                draw.SimpleTextOutlined(playerWeaponSlots[1][2].data.tag, tagFont, w - EFGM.MenuScale(3), tagH, Colors.whiteColor, TEXT_ALIGN_RIGHT, TEXT_ALIGN_TOP, 1, Colors.blackColor)

            end

            if mag != "" then

                draw.SimpleTextOutlined(string.upper(mag), magFont, w - EFGM.MenuScale(3), h - magSizeY, Colors.whiteColor, TEXT_ALIGN_RIGHT, TEXT_ALIGN_TOP, 1, Colors.blackColor)

            end

            if playerWeaponSlots[1][2].data and playerWeaponSlots[1][2].data.fir then

                surface.SetDrawColor(Colors.pureWhiteColor)
                surface.SetMaterial(Mats.firIcon)

                if mag != "" then

                    surface.DrawTexturedRect(w - EFGM.MenuScale(16), h - EFGM.MenuScale(30), EFGM.MenuScale(14), EFGM.MenuScale(14))

                else

                    surface.DrawTexturedRect(w - EFGM.MenuScale(16), h - EFGM.MenuScale(16), EFGM.MenuScale(14), EFGM.MenuScale(14))

                end

            end

        end

        secondaryItem.OnCursorEntered = function(s)

            surface.PlaySound("ui/inv_item_hover_" .. math.random(1, 3) .. ".wav")

        end

        function secondaryItem:DoDoubleClick()

            Menu.InspectItem(playerWeaponSlots[1][2].name, playerWeaponSlots[1][2].data)
            surface.PlaySound("ui/element_select.wav")

        end

        function secondaryItem:DoClick()

            if input.IsKeyDown(KEY_LSHIFT) then

                surface.PlaySound("ui/equip_" .. math.random(1, 6) .. ".wav")
                UnEquipItemFromInventory(secondaryItem.SLOTID, secondaryItem.SLOT)

            end

        end

        function secondaryItem:DoRightClick()

            local x, y = equipmentHolder:LocalCursorPos()
            local sideH, sideV

            surface.PlaySound("ui/context.wav")

            if x <= (equipmentHolder:GetWide() / 2) then sideH = true else sideH = false end
            if y <= (equipmentHolder:GetTall() / 2) then sideV = true else sideV = false end

            if IsValid(contextMenu) then contextMenu:Remove() end
            contextMenu = vgui.Create("EFGMContextMenu", equipmentHolder)
            contextMenu:SetSize(EFGM.MenuScale(100), EFGM.MenuScale(10))
            contextMenu:DockPadding(EFGM.MenuScale(5), EFGM.MenuScale(5), EFGM.MenuScale(5), EFGM.MenuScale(5))
            contextMenu:SetAlpha(0)
            contextMenu:AlphaTo(255, 0.1, 0, nil)
            contextMenu:RequestFocus()

            local inspectButton = vgui.Create("EFGMContextButton", contextMenu)
            inspectButton:SetText("INSPECT")
            inspectButton.OnClickEvent = function()

                Menu.InspectItem(playerWeaponSlots[1][2].name, playerWeaponSlots[1][2].data)

            end

            if Menu.Player:CompareStatus(0) and table.IsEmpty(Menu.Container) then

                local stashButton = vgui.Create("EFGMContextButton", contextMenu)
                stashButton:SetText("STASH")
                stashButton.OnClickSound = "ui/equip_" .. math.random(1, 6) .. ".wav"
                stashButton.OnClickEvent = function()

                    StashItemFromEquipped(secondaryItem.SLOTID, secondaryItem.SLOT)

                end

            end

            local unequipButton = vgui.Create("EFGMContextButton", contextMenu)
            unequipButton:SetText("UNEQUIP")
            unequipButton.OnClickSound = "ui/equip_" .. math.random(1, 6) .. ".wav"
            unequipButton.OnClickEvent = function()

                UnEquipItemFromInventory(secondaryItem.SLOTID, secondaryItem.SLOT)

            end

            if Menu.Player:CompareStatus(0) then

                if i.ammoID then

                    local buyAmmoButton = vgui.Create("EFGMContextButton", contextMenu)
                    buyAmmoButton:SetText("BUY AMMO")
                    buyAmmoButton.OnClickSound = "nil"
                    buyAmmoButton.OnClickEvent = function()

                        Menu.ConfirmPurchase(i.ammoID, "inv", false)

                    end

                end

                if playerWeaponSlots[1][2].data.tag == nil then

                    local tagButton = vgui.Create("EFGMContextButton", contextMenu)
                    tagButton:SetText("SET TAG")
                    tagButton.OnClickEvent = function()

                        Menu.ConfirmTag(playerWeaponSlots[1][2].name, 0, "equipped", secondaryItem.SLOTID, secondaryItem.SLOT)

                    end

                end

            end

            local dropButton = vgui.Create("EFGMContextButton", contextMenu)
            dropButton:SetText("DROP")
            dropButton.OnClickEvent = function()

                DropEquippedItem(secondaryItem.SLOTID, secondaryItem.SLOT)

            end

            if Menu.Player:CompareStatus(0) then

                local deleteButton = vgui.Create("EFGMContextButton", contextMenu)
                deleteButton:SetText("DELETE")
                deleteButton.OnClickSound = "nil"
                deleteButton.OnClickEvent = function()

                    Menu.ConfirmDelete(playerWeaponSlots[1][2].name, 0, "equipped", secondaryItem.SLOTID, secondaryItem.SLOT)

                end

            end

            contextMenu:SetTallAfterCTX()

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

        end

    else

        secondaryWeaponHolder:SetSize(EFGM.MenuScale(285), EFGM.MenuScale(114))
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

        function holsterItem:Paint(w, h)

            if !self:IsHovered() then surface.SetDrawColor(Colors.itemBackgroundColor) else surface.SetDrawColor(Colors.itemBackgroundColorHovered) end
            surface.DrawRect(0, 0, w, EFGM.MenuScale(1))
            surface.DrawRect(0, h - 1, w, EFGM.MenuScale(1))
            surface.DrawRect(0, 0, EFGM.MenuScale(1), h)
            surface.DrawRect(w - 1, 0, EFGM.MenuScale(1), h)

            surface.SetDrawColor(i.iconColor or Colors.itemColor)
            surface.DrawRect(0, 0, w, h)

            surface.SetDrawColor(Colors.pureWhiteColor)
            surface.SetMaterial(i.icon)
            surface.DrawTexturedRect(0, 0, w, h)

        end

        surface.SetFont("Purista18")

        local nameSize = surface.GetTextSize(i.displayName)
        local nameFont
        local tagFont
        local tagH

        if nameSize <= (EFGM.MenuScale(46.5 * i.sizeX)) then nameFont = "PuristaBold18" tagFont = "PuristaBold14" tagH = EFGM.MenuScale(12)
        else nameFont = "PuristaBold14" tagFont = "PuristaBold10" tagH = EFGM.MenuScale(10) end

        local wep = Menu.Player:GetWeapon(playerWeaponSlots[2][1].name)
        local clip = 0
        local clipMax = 0
        local mag = ""

        if isfunction(wep.Clip1) then

            clip = wep:Clip1()
            clipMax = wep:GetMaxClip1()

        end

        if clip == 0 then mag = "Empty"
        elseif clip >= clipMax * 0.9 then mag = "Full"
        elseif clip >= clipMax * 0.8 then mag = "Nearly full"
        elseif clip >= clipMax * 0.4 then mag = "About half"
        elseif clip >= clipMax * 0.2 then mag = "Less than half"
        elseif clip >= clipMax * 0.01 then mag = "Almost empty"
        else mag = "Empty" end

        if clip == -1 then mag = "∞" end

        local magFont = "PuristaBold18"
        local magSizeY = EFGM.MenuScale(19)
        if i.sizeX <= 2 then magFont = "PuristaBold14" magSizeY = EFGM.MenuScale(15) end

        function holsterItem:PaintOver(w, h)

            draw.SimpleTextOutlined(i.displayName, nameFont, w - EFGM.MenuScale(3), EFGM.MenuScale(-1), Colors.whiteColor, TEXT_ALIGN_RIGHT, TEXT_ALIGN_TOP, 1, Colors.blackColor)

            if i.caliber then

                draw.SimpleTextOutlined(i.caliber, magFont, EFGM.MenuScale(3), h - magSizeY, Colors.whiteColor, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP, 1, Colors.blackColor)

            end

            if playerWeaponSlots[2][1].data and playerWeaponSlots[2][1].data.tag then

                draw.SimpleTextOutlined(playerWeaponSlots[2][1].data.tag, tagFont, w - EFGM.MenuScale(3), tagH, Colors.whiteColor, TEXT_ALIGN_RIGHT, TEXT_ALIGN_TOP, 1, Colors.blackColor)

            end

            if mag != "" then

                draw.SimpleTextOutlined(string.upper(mag), magFont, w - EFGM.MenuScale(3), h - magSizeY, Colors.whiteColor, TEXT_ALIGN_RIGHT, TEXT_ALIGN_TOP, 1, Colors.blackColor)

            end

            if playerWeaponSlots[2][1].data and playerWeaponSlots[2][1].data.fir then

                surface.SetDrawColor(Colors.pureWhiteColor)
                surface.SetMaterial(Mats.firIcon)

                if mag != "" then

                    surface.DrawTexturedRect(w - EFGM.MenuScale(16), h - EFGM.MenuScale(30), EFGM.MenuScale(14), EFGM.MenuScale(14))

                else

                    surface.DrawTexturedRect(w - EFGM.MenuScale(16), h - EFGM.MenuScale(16), EFGM.MenuScale(14), EFGM.MenuScale(14))

                end

            end

        end

        holsterItem.OnCursorEntered = function(s)

            surface.PlaySound("ui/inv_item_hover_" .. math.random(1, 3) .. ".wav")

        end

        function holsterItem:DoClick()

            if input.IsKeyDown(KEY_LSHIFT) then

                surface.PlaySound("ui/equip_" .. math.random(1, 6) .. ".wav")
                UnEquipItemFromInventory(holsterItem.SLOTID, holsterItem.SLOT)

            end

        end

        function holsterItem:DoDoubleClick()

            Menu.InspectItem(playerWeaponSlots[2][1].name, playerWeaponSlots[2][1].data)
            surface.PlaySound("ui/element_select.wav")

        end

        function holsterItem:DoRightClick()

            local x, y = equipmentHolder:LocalCursorPos()
            local sideH, sideV

            surface.PlaySound("ui/context.wav")

            if x <= (equipmentHolder:GetWide() / 2) then sideH = true else sideH = false end
            if y <= (equipmentHolder:GetTall() / 2) then sideV = true else sideV = false end

            if IsValid(contextMenu) then contextMenu:Remove() end
            contextMenu = vgui.Create("EFGMContextMenu", equipmentHolder)
            contextMenu:SetSize(EFGM.MenuScale(100), EFGM.MenuScale(10))
            contextMenu:DockPadding(EFGM.MenuScale(5), EFGM.MenuScale(5), EFGM.MenuScale(5), EFGM.MenuScale(5))
            contextMenu:SetAlpha(0)
            contextMenu:AlphaTo(255, 0.1, 0, nil)
            contextMenu:RequestFocus()

            local inspectButton = vgui.Create("EFGMContextButton", contextMenu)
            inspectButton:SetText("INSPECT")
            inspectButton.OnClickEvent = function()

                Menu.InspectItem(playerWeaponSlots[2][1].name, playerWeaponSlots[2][1].data)

            end

            if Menu.Player:CompareStatus(0) and table.IsEmpty(Menu.Container) then

                local stashButton = vgui.Create("EFGMContextButton", contextMenu)
                stashButton:SetText("STASH")
                stashButton.OnClickSound = "ui/equip_" .. math.random(1, 6) .. ".wav"
                stashButton.OnClickEvent = function()

                    StashItemFromEquipped(holsterItem.SLOTID, holsterItem.SLOT)

                end

            end

            local unequipButton = vgui.Create("EFGMContextButton", contextMenu)
            unequipButton:SetText("UNEQUIP")
            unequipButton.OnClickSound = "ui/equip_" .. math.random(1, 6) .. ".wav"
            unequipButton.OnClickEvent = function()

                UnEquipItemFromInventory(holsterItem.SLOTID, holsterItem.SLOT)

            end

            if Menu.Player:CompareStatus(0) then

                if i.ammoID then

                    local buyAmmoButton = vgui.Create("EFGMContextButton", contextMenu)
                    buyAmmoButton:SetText("BUY AMMO")
                    buyAmmoButton.OnClickSound = "nil"
                    buyAmmoButton.OnClickEvent = function()

                        Menu.ConfirmPurchase(i.ammoID, "inv", false)

                    end

                end

                if playerWeaponSlots[2][1].data.tag == nil then

                    local tagButton = vgui.Create("EFGMContextButton", contextMenu)
                    tagButton:SetText("SET TAG")
                    tagButton.OnClickEvent = function()

                        Menu.ConfirmTag(playerWeaponSlots[2][1].name, 0, "equipped", holsterItem.SLOTID, holsterItem.SLOT)

                    end

                end

            end

            local dropButton = vgui.Create("EFGMContextButton", contextMenu)
            dropButton:SetText("DROP")
            dropButton.OnClickEvent = function()

                DropEquippedItem(holsterItem.SLOTID, holsterItem.SLOT)

            end

            if Menu.Player:CompareStatus(0) then

                local deleteButton = vgui.Create("EFGMContextButton", contextMenu)
                deleteButton:SetText("DELETE")
                deleteButton.OnClickSound = "nil"
                deleteButton.OnClickEvent = function()

                    Menu.ConfirmDelete(playerWeaponSlots[2][1].name, 0, "equipped", holsterItem.SLOTID, holsterItem.SLOT)

                end

            end

            contextMenu:SetTallAfterCTX()

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

        end

    else

        holsterWeaponHolder:SetSize(EFGM.MenuScale(114), EFGM.MenuScale(57))
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

        function meleeItem:Paint(w, h)

            if !self:IsHovered() then surface.SetDrawColor(Colors.itemBackgroundColor) else surface.SetDrawColor(Colors.itemBackgroundColorHovered) end
            surface.DrawRect(0, 0, w, EFGM.MenuScale(1))
            surface.DrawRect(0, h - 1, w, EFGM.MenuScale(1))
            surface.DrawRect(0, 0, EFGM.MenuScale(1), h)
            surface.DrawRect(w - 1, 0, EFGM.MenuScale(1), h)

            surface.SetDrawColor(i.iconColor or Colors.itemColor)
            surface.DrawRect(0, 0, w, h)

            surface.SetDrawColor(Colors.pureWhiteColor)
            surface.SetMaterial(i.icon)
            surface.DrawTexturedRect(0, 0, w, h)

        end

        surface.SetFont("Purista18")

        local nameSize = surface.GetTextSize(i.displayName)
        local nameFont
        local tagFont
        local tagH

        if nameSize <= (EFGM.MenuScale(46.5 * i.sizeX)) then nameFont = "PuristaBold18" tagFont = "PuristaBold14" tagH = EFGM.MenuScale(12)
        else nameFont = "PuristaBold14" tagFont = "PuristaBold10" tagH = EFGM.MenuScale(10) end

        function meleeItem:PaintOver(w, h)

            draw.SimpleTextOutlined(i.displayName, nameFont, w - EFGM.MenuScale(3), EFGM.MenuScale(-1), Colors.whiteColor, TEXT_ALIGN_RIGHT, TEXT_ALIGN_TOP, 1, Colors.blackColor)

            if playerWeaponSlots[3][1].data and playerWeaponSlots[3][1].data.tag then

                draw.SimpleTextOutlined(playerWeaponSlots[3][1].data.tag, tagFont, w - EFGM.MenuScale(3), tagH, Colors.whiteColor, TEXT_ALIGN_RIGHT, TEXT_ALIGN_TOP, 1, Colors.blackColor)

            end

            if playerWeaponSlots[3][1].data and playerWeaponSlots[3][1].data.fir then

                surface.SetDrawColor(Colors.pureWhiteColor)
                surface.SetMaterial(Mats.firIcon)
                surface.DrawTexturedRect(w - EFGM.MenuScale(16), h - EFGM.MenuScale(16), EFGM.MenuScale(14), EFGM.MenuScale(14))

            end

        end

        meleeItem.OnCursorEntered = function(s)

            surface.PlaySound("ui/inv_item_hover_" .. math.random(1, 3) .. ".wav")

        end

        function meleeItem:DoClick()

            if input.IsKeyDown(KEY_LSHIFT) then

                surface.PlaySound("ui/equip_" .. math.random(1, 6) .. ".wav")
                UnEquipItemFromInventory(meleeItem.SLOTID, meleeItem.SLOT)

            end

        end

        function meleeItem:DoDoubleClick()

            Menu.InspectItem(playerWeaponSlots[3][1].name, playerWeaponSlots[3][1].data)
            surface.PlaySound("ui/element_select.wav")

        end

        function meleeItem:DoRightClick()

            local x, y = equipmentHolder:LocalCursorPos()
            local sideH, sideV

            surface.PlaySound("ui/context.wav")

            if x <= (equipmentHolder:GetWide() / 2) then sideH = true else sideH = false end
            if y <= (equipmentHolder:GetTall() / 2) then sideV = true else sideV = false end

            if IsValid(contextMenu) then contextMenu:Remove() end
            contextMenu = vgui.Create("EFGMContextMenu", equipmentHolder)
            contextMenu:SetSize(EFGM.MenuScale(100), EFGM.MenuScale(10))
            contextMenu:DockPadding(EFGM.MenuScale(5), EFGM.MenuScale(5), EFGM.MenuScale(5), EFGM.MenuScale(5))
            contextMenu:SetAlpha(0)
            contextMenu:AlphaTo(255, 0.1, 0, nil)
            contextMenu:RequestFocus()

            local inspectButton = vgui.Create("EFGMContextButton", contextMenu)
            inspectButton:SetText("INSPECT")
            inspectButton.OnClickEvent = function()

                Menu.InspectItem(playerWeaponSlots[3][1].name, playerWeaponSlots[3][1].data)

            end

            if Menu.Player:CompareStatus(0) and table.IsEmpty(Menu.Container) then

                local stashButton = vgui.Create("EFGMContextButton", contextMenu)
                stashButton:SetText("STASH")
                stashButton.OnClickSound = "ui/equip_" .. math.random(1, 6) .. ".wav"
                stashButton.OnClickEvent = function()

                    StashItemFromEquipped(meleeItem.SLOTID, meleeItem.SLOT)

                end

            end

            local unequipButton = vgui.Create("EFGMContextButton", contextMenu)
            unequipButton:SetText("UNEQUIP")
            unequipButton.OnClickSound = "ui/equip_" .. math.random(1, 6) .. ".wav"
            unequipButton.OnClickEvent = function()

                UnEquipItemFromInventory(meleeItem.SLOTID, meleeItem.SLOT)

            end

            if Menu.Player:CompareStatus(0) then

                if i.ammoID then

                    local buyAmmoButton = vgui.Create("EFGMContextButton", contextMenu)
                    buyAmmoButton:SetText("BUY AMMO")
                    buyAmmoButton.OnClickSound = "nil"
                    buyAmmoButton.OnClickEvent = function()

                        Menu.ConfirmPurchase(i.ammoID, "inv", false)

                    end

                end

                if playerWeaponSlots[3][1].data.tag == nil then

                    local tagButton = vgui.Create("EFGMContextButton", contextMenu)
                    tagButton:SetText("SET TAG")
                    tagButton.OnClickEvent = function()

                        Menu.ConfirmTag(playerWeaponSlots[3][1].name, 0, "equipped", meleeItem.SLOTID, meleeItem.SLOT)

                    end

                end

            end

            local dropButton = vgui.Create("EFGMContextButton", contextMenu)
            dropButton:SetText("DROP")
            dropButton.OnClickEvent = function()

                DropEquippedItem(meleeItem.SLOTID, meleeItem.SLOT)

            end

            if Menu.Player:CompareStatus(0) then

                local deleteButton = vgui.Create("EFGMContextButton", contextMenu)
                deleteButton:SetText("DELETE")
                deleteButton.OnClickSound = "nil"
                deleteButton.OnClickEvent = function()

                    Menu.ConfirmDelete(playerWeaponSlots[3][1].name, 0, "equipped", meleeItem.SLOTID, meleeItem.SLOT)

                end

            end

            contextMenu:SetTallAfterCTX()

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

        end

    else

        meleeWeaponHolder:SetSize(EFGM.MenuScale(114), EFGM.MenuScale(57))
        if IsValid(meleeItem) then meleeItem:Remove() end

    end

    if !table.IsEmpty(playerWeaponSlots[4][1]) then

        -- NADE

        local i = EFGMITEMS[playerWeaponSlots[4][1].name]

        if IsValid(nadeItem) then nadeItem:Remove() end
        nadeItem = vgui.Create("DButton", nadeWeaponHolder)
        nadeItem:Dock(FILL)
        nadeItem:SetText("")
        nadeItem:Droppable("items")
        nadeItem:Droppable("slot_grenade")
        nadeItem.SLOTID = 4
        nadeItem.SLOT = 1
        nadeItem.ORIGIN = "equipped"

        nadeWeaponHolder:SetSize(EFGM.MenuScale(57 * i.sizeX), EFGM.MenuScale(57 * i.sizeY))

        function nadeItem:Paint(w, h)

            if !self:IsHovered() then surface.SetDrawColor(Colors.itemBackgroundColor) else surface.SetDrawColor(Colors.itemBackgroundColorHovered) end
            surface.DrawRect(0, 0, w, EFGM.MenuScale(1))
            surface.DrawRect(0, h - 1, w, EFGM.MenuScale(1))
            surface.DrawRect(0, 0, EFGM.MenuScale(1), h)
            surface.DrawRect(w - 1, 0, EFGM.MenuScale(1), h)

            surface.SetDrawColor(i.iconColor or Colors.itemColor)
            surface.DrawRect(0, 0, w, h)

            surface.SetDrawColor(Colors.pureWhiteColor)
            surface.SetMaterial(i.icon)
            surface.DrawTexturedRect(0, 0, w, h)

        end

        surface.SetFont("Purista18")

        local nameSize = surface.GetTextSize(i.displayName)
        local nameFont
        local tagFont
        local tagH

        if nameSize <= (EFGM.MenuScale(46.5 * i.sizeX)) then nameFont = "PuristaBold18" tagFont = "PuristaBold14" tagH = EFGM.MenuScale(12)
        else nameFont = "PuristaBold14" tagFont = "PuristaBold10" tagH = EFGM.MenuScale(10) end

        function nadeItem:PaintOver(w, h)

            draw.SimpleTextOutlined(i.displayName, nameFont, w - EFGM.MenuScale(3), EFGM.MenuScale(-1), Colors.whiteColor, TEXT_ALIGN_RIGHT, TEXT_ALIGN_TOP, 1, Colors.blackColor)

            if playerWeaponSlots[4][1].data and playerWeaponSlots[4][1].data.tag then

                draw.SimpleTextOutlined(playerWeaponSlots[4][1].data.tag, tagFont, w - EFGM.MenuScale(3), tagH, Colors.whiteColor, TEXT_ALIGN_RIGHT, TEXT_ALIGN_TOP, 1, Colors.blackColor)

            end

            if i.caliber then -- flares i guess?

                draw.SimpleTextOutlined(i.caliber, "PuristaBold14", EFGM.MenuScale(3), h - EFGM.MenuScale(15), Colors.whiteColor, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP, 1, Colors.blackColor)

            end

            if playerWeaponSlots[4][1].data and playerWeaponSlots[4][1].data.fir then

                surface.SetDrawColor(Colors.pureWhiteColor)
                surface.SetMaterial(Mats.firIcon)
                surface.DrawTexturedRect(w - EFGM.MenuScale(16), h - EFGM.MenuScale(16), EFGM.MenuScale(14), EFGM.MenuScale(14))

            end

        end

        nadeItem.OnCursorEntered = function(s)

            surface.PlaySound("ui/inv_item_hover_" .. math.random(1, 3) .. ".wav")

        end

        function nadeItem:DoClick()

            if input.IsKeyDown(KEY_LSHIFT) then

                surface.PlaySound("ui/equip_" .. math.random(1, 6) .. ".wav")
                UnEquipItemFromInventory(nadeItem.SLOTID, nadeItem.SLOT)

            end

        end

        function nadeItem:DoDoubleClick()

            Menu.InspectItem(playerWeaponSlots[4][1].name, playerWeaponSlots[4][1].data)
            surface.PlaySound("ui/element_select.wav")

        end

        function nadeItem:DoRightClick()

            local x, y = equipmentHolder:LocalCursorPos()
            local sideH, sideV

            surface.PlaySound("ui/context.wav")

            if x <= (equipmentHolder:GetWide() / 2) then sideH = true else sideH = false end
            if y <= (equipmentHolder:GetTall() / 2) then sideV = true else sideV = false end

            if IsValid(contextMenu) then contextMenu:Remove() end
            contextMenu = vgui.Create("EFGMContextMenu", equipmentHolder)
            contextMenu:SetSize(EFGM.MenuScale(100), EFGM.MenuScale(10))
            contextMenu:DockPadding(EFGM.MenuScale(5), EFGM.MenuScale(5), EFGM.MenuScale(5), EFGM.MenuScale(5))
            contextMenu:SetAlpha(0)
            contextMenu:AlphaTo(255, 0.1, 0, nil)
            contextMenu:RequestFocus()

            local inspectButton = vgui.Create("EFGMContextButton", contextMenu)
            inspectButton:SetText("INSPECT")
            inspectButton.OnClickEvent = function()

                Menu.InspectItem(playerWeaponSlots[4][1].name, playerWeaponSlots[4][1].data)

            end

            if Menu.Player:CompareStatus(0) and table.IsEmpty(Menu.Container) then

                local stashButton = vgui.Create("EFGMContextButton", contextMenu)
                stashButton:SetText("STASH")
                stashButton.OnClickSound = "ui/equip_" .. math.random(1, 6) .. ".wav"
                stashButton.OnClickEvent = function()

                    StashItemFromEquipped(nadeItem.SLOTID, nadeItem.SLOT)

                end

            end

            local unequipButton = vgui.Create("EFGMContextButton", contextMenu)
            unequipButton:SetText("UNEQUIP")
            unequipButton.OnClickSound = "ui/equip_" .. math.random(1, 6) .. ".wav"
            unequipButton.OnClickEvent = function()

                UnEquipItemFromInventory(nadeItem.SLOTID, nadeItem.SLOT)

            end

            if Menu.Player:CompareStatus(0) then

                if i.ammoID then

                    local buyAmmoButton = vgui.Create("EFGMContextButton", contextMenu)
                    buyAmmoButton:SetText("BUY AMMO")
                    buyAmmoButton.OnClickSound = "nil"
                    buyAmmoButton.OnClickEvent = function()

                        Menu.ConfirmPurchase(i.ammoID, "inv", false)

                    end

                end

                if playerWeaponSlots[4][1].data.tag == nil then

                    local tagButton = vgui.Create("EFGMContextButton", contextMenu)
                    tagButton:SetText("SET TAG")
                    tagButton.OnClickEvent = function()

                        Menu.ConfirmTag(playerWeaponSlots[4][1].name, 0, "equipped", nadeItem.SLOTID, nadeItem.SLOT)

                    end

                end

            end

            local dropButton = vgui.Create("EFGMContextButton", contextMenu)
            dropButton:SetText("DROP")
            dropButton.OnClickEvent = function()

                DropEquippedItem(nadeItem.SLOTID, nadeItem.SLOT)

            end

            if Menu.Player:CompareStatus(0) then

                local deleteButton = vgui.Create("EFGMContextButton", contextMenu)
                deleteButton:SetText("DELETE")
                deleteButton.OnClickSound = "nil"
                deleteButton.OnClickEvent = function()

                    Menu.ConfirmDelete(playerWeaponSlots[4][1].name, 0, "equipped", nadeItem.SLOTID, nadeItem.SLOT)

                end

            end

            contextMenu:SetTallAfterCTX()

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

        end

    else

        nadeWeaponHolder:SetSize(EFGM.MenuScale(57), EFGM.MenuScale(57))
        if IsValid(nadeItem) then nadeItem:Remove() end

    end

    secondaryWeaponHolder:SetPos(equipmentHolder:GetWide() - secondaryWeaponHolder:GetWide(), equipmentHolder:GetTall() - secondaryWeaponHolder:GetTall())
    secondaryWeaponText:SetPos(equipmentHolder:GetWide() - secondaryWeaponText:GetWide(), secondaryWeaponHolder:GetY() - EFGM.MenuScale(30))
    primaryWeaponHolder:SetPos(equipmentHolder:GetWide() - primaryWeaponHolder:GetWide(), secondaryWeaponHolder:GetY() - primaryWeaponHolder:GetTall() - EFGM.MenuScale(40))
    primaryWeaponText:SetPos(equipmentHolder:GetWide() - primaryWeaponText:GetWide(), primaryWeaponHolder:GetY() - EFGM.MenuScale(30))
    holsterWeaponHolder:SetPos(equipmentHolder:GetWide() - holsterWeaponHolder:GetWide(), primaryWeaponHolder:GetY() - holsterWeaponHolder:GetTall() - EFGM.MenuScale(40))
    holsterWeaponText:SetPos(equipmentHolder:GetWide() - holsterWeaponText:GetWide(), holsterWeaponHolder:GetY() - EFGM.MenuScale(30))
    meleeWeaponHolder:SetPos(equipmentHolder:GetWide() - meleeWeaponHolder:GetWide(), holsterWeaponHolder:GetY() - meleeWeaponHolder:GetTall() - EFGM.MenuScale(40))
    meleeWeaponText:SetPos(equipmentHolder:GetWide() - meleeWeaponText:GetWide(), meleeWeaponHolder:GetY() - EFGM.MenuScale(30))
    nadeWeaponHolder:SetPos(equipmentHolder:GetWide() - nadeWeaponHolder:GetWide(), meleeWeaponHolder:GetY() - nadeWeaponHolder:GetTall() - EFGM.MenuScale(40))
    nadeWeaponText:SetPos(equipmentHolder:GetWide() - nadeWeaponText:GetWide(), nadeWeaponHolder:GetY() - EFGM.MenuScale(30))

end

local stashItemSearchText = ""

function Menu.ReloadStash(firstReload)

    Menu.ReloadMarketStash()

    if !IsValid(stashItems) then return end

    stashValue = 0
    stashItems:Clear()
    plyStashItems = {}

    for k, v in ipairs(playerStash) do

        local def = EFGMITEMS[v.name]
        if def == nil then continue end

        local baseValue = def.value
        local isConsumable = (def.consumableType == "heal" or def.consumableType == "key")
        local count = math.min(math.max(v.data.count or 1, 1), def.stackSize)

        local value
        if !isConsumable then
            value = baseValue * count
        else
            value = math.floor(baseValue * ((v.data.durability or def.consumableValue) / def.consumableValue))
        end

        plyStashItems[k] = {
            name = v.name,
            id = k,
            data = v.data,
            value = value,
            def = def
        }

        stashValue = stashValue + value

        if v.data.att then

            local atts = GetPrefixedAttachmentListFromCode(v.data.att)
            if !atts then continue end

            for _, a in ipairs(atts) do
                local att = EFGMITEMS[a]
                if att == nil then continue end
                plyStashItems[k].value = plyStashItems[k].value + att.value
                stashValue = stashValue + att.value
            end

        end

    end

    if plyStashItems[1] == nil then return end

    table.sort(plyStashItems, function(a, b)

        local a_def = a.def or EFGMITEMS[a.name]
        local b_def = b.def or EFGMITEMS[b.name]

        local a_pin = a.data.pin or 0
        local b_pin = b.data.pin or 0

        if a_pin != b_pin then
            return a_pin > b_pin
        end

        local a_size = a_def.sizeX * a_def.sizeY
        local b_size = b_def.sizeX * b_def.sizeY

        if a_size != b_size then
            return a_size > b_size
        end

        if a_def.equipType != b_def.equipType then
            return a_def.equipType < b_def.equipType
        end

        if a_def.displayName != b_def.displayName then
            return a_def.displayName < b_def.displayName
        end

        if a.data.tag != b.data.tag then
            if !a.data.tag then return false end
            if !b.data.tag then return true end
            return string.upper(a.data.tag) < string.upper(b.data.tag)
        end

        if a.data.durability and b.data.durability then
            return a.data.durability > b.data.durability
        end

        if a.data.count > 1 and b.data.count > 1 then
            return a.data.count > b.data.count
        end

        if a.value and b.value then
            return a.value > b.value
        end

    end)

    surface.SetFont("Purista18")

    local function LoadItem(i, k, v)

        local isConsumable = (i.consumableType == "heal" or i.consumableType == "key")

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

        end

        function item:Paint(w, h)

            if !self:IsHovered() then surface.SetDrawColor(Colors.itemBackgroundColor) else surface.SetDrawColor(Colors.itemBackgroundColorHovered) end
            surface.DrawRect(0, 0, w, EFGM.MenuScale(1))
            surface.DrawRect(0, h - 1, w, EFGM.MenuScale(1))
            surface.DrawRect(0, 0, EFGM.MenuScale(1), h)
            surface.DrawRect(w - 1, 0, EFGM.MenuScale(1), h)

            surface.SetDrawColor(i.iconColor or Colors.itemColor)
            surface.DrawRect(0, 0, w, h)

            surface.SetDrawColor(Colors.pureWhiteColor)
            surface.SetMaterial(i.icon)
            surface.DrawTexturedRect(0, 0, w, h)

        end

        local nameSize = surface.GetTextSize(i.displayName)
        local nameFont
        local tagFont
        local tagH

        if nameSize <= (EFGM.MenuScale(46.5 * i.sizeX)) then nameFont = "PuristaBold18" tagFont = "PuristaBold14" tagH = EFGM.MenuScale(12)
        else nameFont = "PuristaBold14" tagFont = "PuristaBold10" tagH = EFGM.MenuScale(10) end

        local duraSize = nil
        local duraSizeY = nil
        local duraFont = nil

        if isConsumable then

            duraSize = surface.GetTextSize(i.consumableValue .. "/" .. i.consumableValue)

            if duraSize <= (EFGM.MenuScale(46.5 * i.sizeX)) then duraFont = "PuristaBold18" duraSizeY = EFGM.MenuScale(19)
            else duraFont = "PuristaBold14" duraSizeY = EFGM.MenuScale(15) end

        end

        function item:PaintOver(w, h)

            draw.SimpleTextOutlined(i.displayName, nameFont, w - EFGM.MenuScale(3), EFGM.MenuScale(-1), Colors.whiteColor, TEXT_ALIGN_RIGHT, TEXT_ALIGN_TOP, 1, Colors.blackColor)

            if i.equipType == EQUIPTYPE.Ammunition and i.stackSize > 1 then
                draw.SimpleTextOutlined(v.data.count, "PuristaBold18", w - EFGM.MenuScale(3), h - EFGM.MenuScale(19), Colors.whiteColor, TEXT_ALIGN_RIGHT, TEXT_ALIGN_TOP, 1, Colors.blackColor)
            elseif isConsumable then
                draw.SimpleTextOutlined(v.data.durability .. "/" .. i.consumableValue, duraFont, w - EFGM.MenuScale(3), h - duraSizeY, Colors.whiteColor, TEXT_ALIGN_RIGHT, TEXT_ALIGN_TOP, 1, Colors.blackColor)
            end

            if i.caliber then

                draw.SimpleTextOutlined(i.caliber, "PuristaBold18", EFGM.MenuScale(3), h - EFGM.MenuScale(19), Colors.whiteColor, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP, 1, Colors.blackColor)

            end

            if v.data.tag then

                draw.SimpleTextOutlined(v.data.tag, tagFont, w - EFGM.MenuScale(3), tagH, Colors.whiteColor, TEXT_ALIGN_RIGHT, TEXT_ALIGN_TOP, 1, Colors.blackColor)

            end

            if v.data.pin == 1 then

                surface.SetDrawColor(Colors.pureWhiteColor)
                surface.SetMaterial(Mats.pinIcon)

                if i.equipType == EQUIPTYPE.Ammunition or isConsumable then

                    surface.DrawTexturedRect(w - EFGM.MenuScale(15), h - EFGM.MenuScale(32), EFGM.MenuScale(16), EFGM.MenuScale(16))

                else

                    surface.DrawTexturedRect(w - EFGM.MenuScale(15), h - EFGM.MenuScale(18), EFGM.MenuScale(16), EFGM.MenuScale(16))

                end

            end

            if v.data.fir then

                surface.SetDrawColor(Colors.pureWhiteColor)
                surface.SetMaterial(Mats.firIcon)

                local width, height = EFGM.MenuScale(17), EFGM.MenuScale(17)

                if v.data.pin == 1 then width = width + EFGM.MenuScale(10) end
                if (i.equipType == EQUIPTYPE.Ammunition and v.data.count > 1) or isConsumable then height = height + EFGM.MenuScale(14) end

                surface.DrawTexturedRect(w - width, h - height, EFGM.MenuScale(14), EFGM.MenuScale(14))

            end

        end

        item.OnCursorEntered = function(s)

            surface.PlaySound("ui/inv_item_hover_" .. math.random(1, 3) .. ".wav")

        end

        function item:DoClick()

            if input.IsKeyDown(KEY_LSHIFT) then

                surface.PlaySound("ui/inv_item_toinv_" .. math.random(1, 7) .. ".wav")
                TakeFromStashToInventory(v.id)

            end

            if input.IsKeyDown(KEY_LALT) and (i.equipType == EQUIPTYPE.Weapon) then

                surface.PlaySound("ui/equip_" .. math.random(1, 6) .. ".wav")
                EquipItemFromStash(v.id, i.equipSlot)

            end

        end

        function item:DoDoubleClick()

            Menu.InspectItem(v.name, v.data)
            surface.PlaySound("ui/element_select.wav")

        end

        function item:DoRightClick()

            local x, y = stashHolder:LocalCursorPos()
            local sideH, sideV

            surface.PlaySound("ui/context.wav")

            if x <= (stashHolder:GetWide() / 2) then sideH = true else sideH = false end
            if y <= (stashHolder:GetTall() / 2) then sideV = true else sideV = false end

            if IsValid(contextMenu) then contextMenu:Remove() end
            contextMenu = vgui.Create("EFGMContextMenu", stashHolder)
            contextMenu:SetSize(EFGM.MenuScale(100), EFGM.MenuScale(10))
            contextMenu:DockPadding(EFGM.MenuScale(5), EFGM.MenuScale(5), EFGM.MenuScale(5), EFGM.MenuScale(5))
            contextMenu:SetAlpha(0)
            contextMenu:AlphaTo(255, 0.1, 0, nil)
            contextMenu:RequestFocus()

            local inspectButton = vgui.Create("EFGMContextButton", contextMenu)
            inspectButton:SetText("INSPECT")
            inspectButton.OnClickEvent = function()

                Menu.InspectItem(v.name, v.data)

            end

            local takeButton = vgui.Create("EFGMContextButton", contextMenu)
            takeButton:SetText("TAKE")
            takeButton.OnClickSound = "ui/inv_item_toinv_" .. math.random(1, 7) .. ".wav"
            takeButton.OnClickEvent = function()

                TakeFromStashToInventory(v.id)

            end

            -- actions that can be performed on this specific item
            -- default
            local actions = {
                equipable = false,
                consumable = false,
                splittable = false,
                deletable = true
            }

            actions.equipable = i.equipType == EQUIPTYPE.Weapon
            actions.splittable = i.stackSize > 1 and v.data.count > 1
            actions.consumable = i.equipType == EQUIPTYPE.Consumable
            actions.ammoBuyable = Menu.Player:CompareStatus(0) and i.ammoID
            actions.taggable = Menu.Player:CompareStatus(0) and v.data.tag == nil and (actions.ammoBuyable or i.equipSlot == WEAPONSLOTS.MELEE.ID)

            if actions.equipable then

                local equipButton = vgui.Create("EFGMContextButton", contextMenu)
                equipButton:SetText("EQUIP")
                equipButton.OnClickSound = "ui/equip_" .. math.random(1, 6) .. ".wav"
                equipButton.OnClickEvent = function()

                    EquipItemFromStash(v.id, i.equipSlot)

                end

            end

            if actions.ammoBuyable then

                local buyAmmoButton = vgui.Create("EFGMContextButton", contextMenu)
                buyAmmoButton:SetText("BUY AMMO")
                buyAmmoButton.OnClickSound = "nil"
                buyAmmoButton.OnClickEvent = function()

                    Menu.ConfirmPurchase(i.ammoID, "stash", false)

                end

            end

            if actions.taggable then

                local tagButton = vgui.Create("EFGMContextButton", contextMenu)
                tagButton:SetText("SET TAG")
                tagButton.OnClickEvent = function()

                    Menu.ConfirmTag(v.name, v.id, "stash", 0, 0)

                end

            end

            if actions.splittable then

                local splitButton = vgui.Create("EFGMContextButton", contextMenu)
                splitButton:SetText("SPLIT")
                splitButton.OnClickSound = "nil"
                splitButton.OnClickEvent = function()

                    Menu.ConfirmSplit(v.name, v.data, v.id, "stash")

                end

            end

            local pinButton = vgui.Create("EFGMContextButton", contextMenu)
            if v.data.pin == 1 then
                pinButton:SetText("UNPIN")
                pinButton.OnClickSound = "ui/element_unpinned.wav"
            else
                pinButton:SetText("PIN")
                pinButton.OnClickSound = "ui/element_pin.wav"
            end
            pinButton.OnClickEvent = function()

                PinItemFromStash(v.id)

            end

            if actions.deletable then

                local deleteButton = vgui.Create("EFGMContextButton", contextMenu)
                deleteButton:SetText("DELETE")
                deleteButton.OnClickSound = "nil"
                deleteButton.OnClickEvent = function()

                    Menu.ConfirmDelete(v.name, v.id, "stash", 0, 0)

                end

            end

            contextMenu:SetTallAfterCTX()

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

    -- stash item entry
    for k, v in ipairs(plyStashItems) do

        local i = v.def or EFGMITEMS[v.name]
        if i == nil then continue end

        local ownerName = nil
        if v.data.owner then
            ownerName = EFGM.SteamNameCache[v.data.owner]
            if !ownerName then
                steamworks.RequestPlayerInfo(v.data.owner, function(steamName) EFGM.SteamNameCache[v.data.owner] = steamName or "" end)
            end
        end

        if stashItemSearchText then itemSearch = stashItemSearchText end

        local searchFor = (itemSearch and itemSearch:lower()) or ""

        if searchFor != "" and
            !string.find((i.fullName):lower(), itemSearch, 1, true) and
            !string.find((i.displayName):lower(), itemSearch, 1, true) and
            !string.find((i.displayType):lower(), itemSearch, 1, true) and
            !string.find((tostring(v.data.tag) or ""):lower(), itemSearch, 1, true) and
            !string.find((ownerName or ""):lower(), itemSearch, 1, true) then continue
        end

        LoadItem(i, k, v)

    end

end

local marketStashItemSearchText = ""

function Menu.ReloadMarketStash()

    if !IsValid(marketStashItems) then return end

    stashValue = 0
    marketStashItems:Clear()
    marketPlyStashItems = {}

    for k, v in ipairs(playerStash) do

        local def = EFGMITEMS[v.name]
        if def == nil then continue end

        local consumableType = def.consumableType
        local consumableValue = def.consumableValue
        local baseValue = def.value
        local isConsumable = consumableType == "heal" or consumableType == "key"

        marketPlyStashItems[k] = {
            name = v.name,
            id = k,
            data = v.data,
            value = !isConsumable and math.floor((baseValue * sellMultiplier) * math.min(math.max(v.data.count, 1), def.stackSize))
            or math.floor((baseValue * sellMultiplier) * (v.data.durability / consumableValue)),
            def = def
        }

        stashValue = stashValue + (!isConsumable and (baseValue * math.min(math.max(v.data.count, 1), def.stackSize))
        or math.floor(baseValue * (v.data.durability / consumableValue)))

        if v.data.att then

            local atts = GetPrefixedAttachmentListFromCode(v.data.att)
            if !atts then return end

            for _, a in ipairs(atts) do

                local att = EFGMITEMS[a]
                if att == nil then continue end

                marketPlyStashItems[k].value = marketPlyStashItems[k].value + math.floor(att.value * sellMultiplier)
                stashValue = stashValue + att.value

            end

        end

    end

    if marketPlyStashItems[1] == nil then return end

    table.sort(marketPlyStashItems, function(a, b)

        local a_def = a.def or EFGMITEMS[a.name]
        local b_def = b.def or EFGMITEMS[b.name]

        local a_pin = a.data.pin or 0
        local b_pin = b.data.pin or 0

        if a_pin != b_pin then
            return a_pin > b_pin
        end

        local a_size = a_def.sizeX * a_def.sizeY
        local b_size = b_def.sizeX * b_def.sizeY

        if a_size != b_size then
            return a_size > b_size
        end

        if a_def.equipType != b_def.equipType then
            return a_def.equipType < b_def.equipType
        end

        if a_def.displayName != b_def.displayName then
            return a_def.displayName < b_def.displayName
        end

        if a.data.tag != b.data.tag then
            if !a.data.tag then return false end
            if !b.data.tag then return true end
            return string.upper(a.data.tag) < string.upper(b.data.tag)
        end

        if a.data.durability and b.data.durability then
            return a.data.durability > b.data.durability
        end

        if a.data.count > 1 and b.data.count > 1 then
            return a.data.count > b.data.count
        end

        if a.value and b.value then
            return a.value > b.value
        end

    end)

    -- stash item entry
    for k, v in ipairs(marketPlyStashItems) do

        local i = v.def or EFGMITEMS[v.name]
        if i == nil then continue end

        local ownerName = nil
        if v.data.owner then
            ownerName = EFGM.SteamNameCache[v.data.owner]
            if !ownerName then
                steamworks.RequestPlayerInfo(v.data.owner, function(steamName) EFGM.SteamNameCache[v.data.owner] = steamName or "" end)
            end
        end

        if marketStashItemSearchText then itemSearch = marketStashItemSearchText end

        local searchFor = (itemSearch and itemSearch:lower()) or ""

        if searchFor != "" and
            !string.find((i.fullName):lower(), searchFor, 1, true) and
            !string.find((i.displayName):lower(), searchFor, 1, true) and
            !string.find((i.displayType):lower(), searchFor, 1, true) and
            !string.find((tostring(v.data.tag) or ""):lower(), searchFor, 1, true) and
            !string.find((ownerName or ""):lower(), searchFor, 1, true) then continue
        end

        local itemValue = v.value

        local item = marketStashItems:Add("DButton")
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

        end

        local costColor

        function item:Paint(w, h)

            costColor = Colors.whiteColor
            if !self:IsHovered() then surface.SetDrawColor(Colors.itemBackgroundColor) else surface.SetDrawColor(Colors.itemBackgroundColorHovered) end

            surface.DrawRect(0, 0, w, EFGM.MenuScale(1))
            surface.DrawRect(0, h - 1, w, EFGM.MenuScale(1))
            surface.DrawRect(0, 0, EFGM.MenuScale(1), h)
            surface.DrawRect(w - 1, 0, EFGM.MenuScale(1), h)

            surface.SetDrawColor(i.iconColor or Colors.itemColor)
            surface.DrawRect(0, 0, w, h)

            surface.SetDrawColor(Colors.pureWhiteColor)
            surface.SetMaterial(i.icon)
            surface.DrawTexturedRect(0, 0, w, h)

        end

        surface.SetFont("Purista18")

        local nameSize = surface.GetTextSize(i.displayName)
        local nameFont
        local tagFont
        local tagH

        if nameSize <= (EFGM.MenuScale(46.5 * i.sizeX)) then nameFont = "PuristaBold18" tagFont = "PuristaBold14" tagH = EFGM.MenuScale(12)
        else nameFont = "PuristaBold14" tagFont = "PuristaBold10" tagH = EFGM.MenuScale(10) end

        local duraSize = nil
        local duraSizeY = nil
        local duraFont = nil

        if i.consumableType == "heal" or i.consumableType == "key" then

            duraSize = surface.GetTextSize(i.consumableValue .. "/" .. i.consumableValue)

            if duraSize <= (EFGM.MenuScale(46.5 * i.sizeX)) then duraFont = "PuristaBold18" duraSizeY = EFGM.MenuScale(19)
            else duraFont = "PuristaBold14" duraSizeY = EFGM.MenuScale(15) end

        end

        function item:PaintOver(w, h)

            draw.SimpleTextOutlined(i.displayName, nameFont, w - EFGM.MenuScale(3), EFGM.MenuScale(-1), Colors.whiteColor, TEXT_ALIGN_RIGHT, TEXT_ALIGN_TOP, 1, Colors.blackColor)

            if i.equipType == EQUIPTYPE.Ammunition and i.stackSize > 1 then
                draw.SimpleTextOutlined(v.data.count, "PuristaBold18", w - EFGM.MenuScale(3), h - EFGM.MenuScale(19), Colors.whiteColor, TEXT_ALIGN_RIGHT, TEXT_ALIGN_TOP, 1, Colors.blackColor)
            elseif i.consumableType == "heal" or i.consumableType == "key" then
                draw.SimpleTextOutlined(v.data.durability .. "/" .. i.consumableValue, duraFont, w - EFGM.MenuScale(3), h - duraSizeY, Colors.whiteColor, TEXT_ALIGN_RIGHT, TEXT_ALIGN_TOP, 1, Colors.blackColor)
            end

            if i.caliber then

                draw.SimpleTextOutlined(i.caliber, "PuristaBold18", EFGM.MenuScale(3), h - EFGM.MenuScale(19), Colors.whiteColor, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP, 1, Colors.blackColor)

            end

            if v.data.tag then

                draw.SimpleTextOutlined(v.data.tag, tagFont, w - EFGM.MenuScale(3), tagH, Colors.whiteColor, TEXT_ALIGN_RIGHT, TEXT_ALIGN_TOP, 1, Colors.blackColor)

            end

            if v.data.pin == 1 then

                surface.SetDrawColor(Colors.pureWhiteColor)
                surface.SetMaterial(Mats.pinIcon)

                if i.equipType == EQUIPTYPE.Ammunition or i.consumableType == "heal" or i.consumableType == "key" then

                    surface.DrawTexturedRect(w - EFGM.MenuScale(15), h - EFGM.MenuScale(32), EFGM.MenuScale(16), EFGM.MenuScale(16))

                else

                    surface.DrawTexturedRect(w - EFGM.MenuScale(15), h - EFGM.MenuScale(18), EFGM.MenuScale(16), EFGM.MenuScale(16))

                end

            end

            if v.data.fir then

                surface.SetDrawColor(Colors.pureWhiteColor)
                surface.SetMaterial(Mats.firIcon)

                local width, height = EFGM.MenuScale(17), EFGM.MenuScale(17)

                if v.data.pin == 1 then width = width + EFGM.MenuScale(10) end
                if (i.equipType == EQUIPTYPE.Ammunition and v.data.count > 1) or i.consumableType == "heal" or i.consumableType == "key" then height = height + EFGM.MenuScale(14) end

                surface.DrawTexturedRect(w - width, h - height, EFGM.MenuScale(14), EFGM.MenuScale(14))

            end

            if i.sizeX > 1 then draw.SimpleTextOutlined("₽" .. itemValue, "PuristaBold18", w / 2, h / 2 - EFGM.MenuScale(9), costColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 1, Colors.blackColor)
            else draw.SimpleTextOutlined("₽" .. itemValue, "PuristaBold14", w / 2, h / 2 - EFGM.MenuScale(7), costColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 1, Colors.blackColor) end

        end

        item.OnCursorEntered = function(s)

            surface.PlaySound("ui/inv_item_hover_" .. math.random(1, 3) .. ".wav")

        end

        function item:DoClick()

            Menu.ConfirmSell(v.name, v.data, v.id)

        end

        function item:DoRightClick()

            local x, y = marketStashHolder:LocalCursorPos()
            local sideH, sideV

            surface.PlaySound("ui/context.wav")

            if x <= (marketStashHolder:GetWide() / 2) then sideH = true else sideH = false end
            if y <= (marketStashHolder:GetTall() / 2) then sideV = true else sideV = false end

            if IsValid(contextMenu) then contextMenu:Remove() end
            contextMenu = vgui.Create("EFGMContextMenu", marketStashHolder)
            contextMenu:SetSize(EFGM.MenuScale(100), EFGM.MenuScale(10))
            contextMenu:DockPadding(EFGM.MenuScale(5), EFGM.MenuScale(5), EFGM.MenuScale(5), EFGM.MenuScale(5))
            contextMenu:SetAlpha(0)
            contextMenu:AlphaTo(255, 0.1, 0, nil)
            contextMenu:RequestFocus()

            local inspectButton = vgui.Create("EFGMContextButton", contextMenu)
            inspectButton:SetText("INSPECT")
            inspectButton.OnClickEvent = function()

                Menu.InspectItem(v.name, v.data)

            end

            local sellButton = vgui.Create("EFGMContextButton", contextMenu)
            sellButton:SetText("SELL")
            sellButton.OnClickEvent = function()

                Menu.ConfirmSell(v.name, v.data, v.id)

            end

            contextMenu:SetTallAfterCTX()

            if sideH == true then

                contextMenu:SetX(math.Clamp(x + EFGM.MenuScale(5), EFGM.MenuScale(5), marketStashHolder:GetWide() - contextMenu:GetWide() - EFGM.MenuScale(5)))

            else

                contextMenu:SetX(math.Clamp(x - contextMenu:GetWide() - EFGM.MenuScale(5), EFGM.MenuScale(5), marketStashHolder:GetWide() - contextMenu:GetWide() - EFGM.MenuScale(5)))

            end

            if sideV == true then

                contextMenu:SetY(math.Clamp(y + EFGM.MenuScale(5), EFGM.MenuScale(5), marketStashHolder:GetTall() - contextMenu:GetTall() - EFGM.MenuScale(5)))

            else

                contextMenu:SetY(math.Clamp(y - contextMenu:GetTall() + EFGM.MenuScale(5), EFGM.MenuScale(5), marketStashHolder:GetTall() - contextMenu:GetTall() - EFGM.MenuScale(5)))

            end

        end

    end

end

function Menu.ReloadContainer()

    local container = Menu.Container
    if table.IsEmpty(container) then return end
    if !IsValid(containerItems) then return end

    containerItems:Clear()
    conItems = {}
    for k, v in ipairs(container.items) do

        local def = EFGMITEMS[v.name]
        if def == nil then continue end

        local consumableType = def.consumableType
        local baseValue = def.value

        conItems[k] = {
            name = v.name,
            id = k,
            data = v.data,
            value = (consumableType != "heal" and consumableType != "key") and (baseValue * math.min(math.max(v.data.count, 1), def.stackSize))
            or math.floor(baseValue * (v.data.durability / def.consumableValue)),
            def = def
        }

        if v.data.att then

            local atts = GetPrefixedAttachmentListFromCode(v.data.att)
            if !atts then return end

            for _, a in ipairs(atts) do

                local att = EFGMITEMS[a]
                if att == nil then continue end

                conItems[k].value = conItems[k].value + att.value

            end

        end

    end

    if conItems[1] == nil then return end

    table.sort(conItems, function(a, b)

        local a_def = a.def or EFGMITEMS[a.name]
        local b_def = b.def or EFGMITEMS[b.name]

        local a_size = a_def.sizeX * a_def.sizeY
        local b_size = b_def.sizeX * b_def.sizeY

        if a_size != b_size then
            return a_size > b_size
        end

        if a_def.equipType != b_def.equipType then
            return a_def.equipType < b_def.equipType
        end

        if a_def.displayName != b_def.displayName then
            return a_def.displayName < b_def.displayName
        end

        if a.data.tag != b.data.tag then
            if !a.data.tag then return false end
            if !b.data.tag then return true end
            return string.upper(a.data.tag) < string.upper(b.data.tag)
        end

        if a.data.durability and b.data.durability then
            return a.data.durability > b.data.durability
        end

        if a.data.count > 1 and b.data.count > 1 then
            return a.data.count > b.data.count
        end

        if a.value and b.value then
            return a.value > b.value
        end

    end)

    for k, v in ipairs(conItems) do

        local i = v.def or EFGMITEMS[v.name]
        if i == nil then continue end

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

            if !self:IsHovered() then surface.SetDrawColor(Colors.itemBackgroundColor) else surface.SetDrawColor(Colors.itemBackgroundColorHovered) end
            surface.DrawRect(0, 0, w, EFGM.MenuScale(1))
            surface.DrawRect(0, h - 1, w, EFGM.MenuScale(1))
            surface.DrawRect(0, 0, EFGM.MenuScale(1), h)
            surface.DrawRect(w - 1, 0, EFGM.MenuScale(1), h)

            surface.SetDrawColor(i.iconColor or Colors.itemColor)
            surface.DrawRect(0, 0, w, h)

            surface.SetDrawColor(Colors.pureWhiteColor)
            surface.SetMaterial(i.icon)
            surface.DrawTexturedRect(0, 0, w, h)

        end

        surface.SetFont("Purista18")

        local nameSize = surface.GetTextSize(i.displayName)
        local nameFont
        local tagFont
        local tagH

        if nameSize <= (EFGM.MenuScale(46.5 * i.sizeX)) then nameFont = "PuristaBold18" tagFont = "PuristaBold14" tagH = EFGM.MenuScale(12)
        else nameFont = "PuristaBold14" tagFont = "PuristaBold10" tagH = EFGM.MenuScale(10) end

        local duraSize = nil
        local duraSizeY = nil
        local duraFont = nil

        if i.consumableType == "heal" or i.consumableType == "key" then
            duraSize = surface.GetTextSize(i.consumableValue .. "/" .. i.consumableValue)

            if duraSize <= (EFGM.MenuScale(46.5 * i.sizeX)) then duraFont = "PuristaBold18" duraSizeY = EFGM.MenuScale(19)
            else duraFont = "PuristaBold14" duraSizeY = EFGM.MenuScale(15) end
        end

        function item:PaintOver(w, h)

            draw.SimpleTextOutlined(i.displayName, nameFont, w - EFGM.MenuScale(3), EFGM.MenuScale(-1), Colors.whiteColor, TEXT_ALIGN_RIGHT, TEXT_ALIGN_TOP, 1, Colors.blackColor)

            if i.equipType == EQUIPTYPE.Ammunition and i.stackSize > 1 then
                draw.SimpleTextOutlined(v.data.count, "PuristaBold18", w - EFGM.MenuScale(3), h - EFGM.MenuScale(19), Colors.whiteColor, TEXT_ALIGN_RIGHT, TEXT_ALIGN_TOP, 1, Colors.blackColor)
            elseif i.consumableType == "heal" or i.consumableType == "key" then
                draw.SimpleTextOutlined(v.data.durability .. "/" .. i.consumableValue, duraFont, w - EFGM.MenuScale(3), h - duraSizeY, Colors.whiteColor, TEXT_ALIGN_RIGHT, TEXT_ALIGN_TOP, 1, Colors.blackColor)
            end

            if i.caliber then

                draw.SimpleTextOutlined(i.caliber, "PuristaBold18", EFGM.MenuScale(3), h - EFGM.MenuScale(19), Colors.whiteColor, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP, 1, Colors.blackColor)

            end

            if v.data.tag then

                draw.SimpleTextOutlined(v.data.tag, tagFont, w - EFGM.MenuScale(3), tagH, Colors.whiteColor, TEXT_ALIGN_RIGHT, TEXT_ALIGN_TOP, 1, Colors.blackColor)

            end

            if v.data.fir then

                surface.SetDrawColor(Colors.pureWhiteColor)
                surface.SetMaterial(Mats.firIcon)

                if (i.equipType == EQUIPTYPE.Ammunition and v.data.count > 1) or i.consumableType == "heal" or i.consumableType == "key" then

                    surface.DrawTexturedRect(w - EFGM.MenuScale(17), h - EFGM.MenuScale(31), EFGM.MenuScale(14), EFGM.MenuScale(14))

                else

                    surface.DrawTexturedRect(w - EFGM.MenuScale(17), h - EFGM.MenuScale(17), EFGM.MenuScale(14), EFGM.MenuScale(14))

                end

            end

        end

        item.OnCursorEntered = function(s)

            surface.PlaySound("ui/inv_item_hover_" .. math.random(1, 3) .. ".wav")

        end

        function item:DoClick()

            if input.IsKeyDown(KEY_LSHIFT) then

                surface.PlaySound("ui/inv_item_toinv_" .. math.random(1, 7) .. ".wav")

                table.remove(container.items, v.id)

                net.Start("PlayerInventoryLootItemFromContainer", false)
                    net.WriteEntity(container.entity)
                    net.WriteUInt(v.id, 16)
                net.SendToServer()

                Menu.ReloadContainer()

            end

        end

        function item:DoDoubleClick()

            Menu.InspectItem(v.name, v.data)
            surface.PlaySound("ui/element_select.wav")

        end

        function item:DoRightClick()

            local x, y = containerHolder:LocalCursorPos()
            local sideH, sideV

            surface.PlaySound("ui/context.wav")

            if x <= (containerHolder:GetWide() / 2) then sideH = true else sideH = false end
            if y <= (containerHolder:GetTall() / 2) then sideV = true else sideV = false end

            if IsValid(contextMenu) then contextMenu:Remove() end
            contextMenu = vgui.Create("EFGMContextMenu", containerHolder)
            contextMenu:SetSize(EFGM.MenuScale(100), EFGM.MenuScale(10))
            contextMenu:DockPadding(EFGM.MenuScale(5), EFGM.MenuScale(5), EFGM.MenuScale(5), EFGM.MenuScale(5))
            contextMenu:SetAlpha(0)
            contextMenu:AlphaTo(255, 0.1, 0, nil)
            contextMenu:RequestFocus()

            local inspectButton = vgui.Create("EFGMContextButton", contextMenu)
            inspectButton:SetText("INSPECT")
            inspectButton.OnClickEvent = function()

                Menu.InspectItem(v.name, v.data)

            end

            -- actions that can be performed on this specific item
            -- default
            local actions = {
                lootable = true
            }

            if actions.lootable then

                local lootButton = vgui.Create("EFGMContextButton", contextMenu)
                lootButton:SetText("LOOT")
                lootButton.OnClickSound = "ui/inv_item_toinv_" .. math.random(1, 7) .. ".wav"
                lootButton.OnClickEvent = function()

                    table.remove(container.items, v.id)

                    net.Start("PlayerInventoryLootItemFromContainer", false)
                        net.WriteEntity(container.entity)
                        net.WriteUInt(v.id, 16)
                    net.SendToServer()

                    Menu.ReloadContainer()

                end

            end

            contextMenu:SetTallAfterCTX()

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

function Menu.OpenTab.Inventory(container)

    local contents = vgui.Create("DPanel", Menu.MenuFrame.LowerPanel)
    contents:Dock(FILL)
    contents:DockPadding(EFGM.MenuScale(10), EFGM.MenuScale(10), EFGM.MenuScale(10), EFGM.MenuScale(10))
    contents:SetAlpha(0)
    contents.Paint = nil

    Menu.MenuFrame.LowerPanel.Contents = contents

    local playerPanel = vgui.Create("DPanel", contents)
    playerPanel:Dock(LEFT)
    playerPanel:SetSize(EFGM.MenuScale(613), 0)
    playerPanel.Paint = function(s, w, h)

        BlurPanel(s, EFGM.MenuScale(10))

        surface.SetDrawColor(Colors.containerBackgroundColor)
        surface.DrawRect(0, 0, w, h)

        surface.SetDrawColor(Colors.transparentWhiteColor)
        surface.DrawRect(0, 0, w, EFGM.MenuScale(6))

        surface.SetDrawColor(Colors.itemBackgroundColor)
        if Menu.Player:GetModel() == "models/eft/pmcs/usec_extended_pm.mdl" then surface.SetMaterial(Mats.factionUSECIcon) else surface.SetMaterial(Mats.factionBEARIcon) end
        surface.DrawTexturedRect(EFGM.MenuScale(20), EFGM.MenuScale(50), EFGM.MenuScale(115), EFGM.MenuScale(119))

    end

    local playerText = vgui.Create("DPanel", playerPanel)
    playerText:Dock(TOP)
    playerText:SetSize(0, EFGM.MenuScale(36))
    function playerText:Paint(w, h)

        surface.SetDrawColor(Colors.containerHeaderColor)
        surface.DrawRect(0, 0, w, h)

        draw.SimpleTextOutlined(string.upper(Menu.Player:GetName()), "PuristaBold32", EFGM.MenuScale(5), EFGM.MenuScale(2), Colors.whiteColor, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP, 1, Colors.blackColor)

    end

    local playerModel = vgui.Create("DModelPanel", playerPanel)
    playerModel:Dock(FILL)
    playerModel:SetMouseInputEnabled(false)
    playerModel:SetFOV(26)
    playerModel:SetCamPos(Vector(10, 0, 0))
    playerModel:SetLookAt(Vector(-100, 0, -24))
    playerModel:SetDirectionalLight(BOX_RIGHT, Colors.modelLeftColor)
    playerModel:SetDirectionalLight(BOX_LEFT, Colors.modelRightColor)
    playerModel:SetAnimated(true)
    playerModel:SetModel(Menu.Player:GetModel())

    local seq = playerModel.Entity:LookupSequence(table.Random(holdtypes))
    playerModel.Entity:SetSequence(seq)

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
    playerModel.Entity:SetAngles(Angle(0, math.random(0, 40), 0))

    function playerModel:LayoutEntity(Entity)

        if !IsValid(Entity) then return end

    end

    equipmentHolder = vgui.Create("DPanel", playerPanel)
    equipmentHolder:SetPos(EFGM.MenuScale(153), EFGM.MenuScale(100))
    equipmentHolder:SetSize(EFGM.MenuScale(450), EFGM.MenuScale(850))
    equipmentHolder.Paint = nil

    -- secondary slot
    secondaryWeaponHolder = vgui.Create("DPanel", equipmentHolder)
    secondaryWeaponHolder:SetSize(EFGM.MenuScale(285), EFGM.MenuScale(114))
    secondaryWeaponHolder:SetPos(equipmentHolder:GetWide() - secondaryWeaponHolder:GetWide(), equipmentHolder:GetTall() - secondaryWeaponHolder:GetTall())

    function secondaryWeaponHolder:Paint(w, h)

        BlurPanel(secondaryWeaponHolder, EFGM.MenuScale(3))

        surface.SetDrawColor(Colors.containerBackgroundColor)
        surface.DrawRect(0, 0, w, h)

        surface.SetDrawColor(Colors.whiteBorderColor)
        surface.DrawRect(0, 0, w, EFGM.MenuScale(1))
        surface.DrawRect(0, h - 1, w, EFGM.MenuScale(1))
        surface.DrawRect(0, 0, EFGM.MenuScale(1), h)
        surface.DrawRect(w - 1, 0, EFGM.MenuScale(1), h)

        if !table.IsEmpty(playerWeaponSlots[1][2]) then return end

        surface.SetDrawColor(Colors.weaponSilhouetteColor)
        surface.SetMaterial(Mats.invPrimaryIcon)
        surface.DrawTexturedRect(EFGM.MenuScale(25), EFGM.MenuScale(15), EFGM.MenuScale(250), EFGM.MenuScale(80))

    end

    secondaryWeaponText = vgui.Create("DPanel", equipmentHolder)
    secondaryWeaponText:SetSize(EFGM.MenuScale(120), EFGM.MenuScale(30))
    secondaryWeaponText:SetPos(equipmentHolder:GetWide() - secondaryWeaponText:GetWide(), secondaryWeaponHolder:GetY() - EFGM.MenuScale(30))
    secondaryWeaponText.Paint = function(s, w, h)

        surface.SetDrawColor(Colors.containerBackgroundColor)
        surface.DrawRect(0, 0, w, h)

        surface.SetDrawColor(Colors.transparentWhiteColor)
        surface.DrawRect(0, 0, EFGM.MenuScale(220), EFGM.MenuScale(2))

        draw.SimpleTextOutlined("SECONDARY", "PuristaBold24", w / 2, EFGM.MenuScale(2), Colors.whiteColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 1, Colors.blackColor)

    end

    -- primary slot
    primaryWeaponHolder = vgui.Create("DPanel", equipmentHolder)
    primaryWeaponHolder:SetSize(EFGM.MenuScale(285), EFGM.MenuScale(114))
    primaryWeaponHolder:SetPos(equipmentHolder:GetWide() - primaryWeaponHolder:GetWide(), secondaryWeaponHolder:GetY() - primaryWeaponHolder:GetTall() - EFGM.MenuScale(40))

    function primaryWeaponHolder:Paint(w, h)

        BlurPanel(primaryWeaponHolder, EFGM.MenuScale(3))

        surface.SetDrawColor(Colors.containerBackgroundColor)
        surface.DrawRect(0, 0, w, h)

        surface.SetDrawColor(Colors.whiteBorderColor)
        surface.DrawRect(0, 0, w, EFGM.MenuScale(1))
        surface.DrawRect(0, h - 1, w, EFGM.MenuScale(1))
        surface.DrawRect(0, 0, EFGM.MenuScale(1), h)
        surface.DrawRect(w - 1, 0, EFGM.MenuScale(1), h)

        if !table.IsEmpty(playerWeaponSlots[1][1]) then return end

        surface.SetDrawColor(Colors.weaponSilhouetteColor)
        surface.SetMaterial(Mats.invPrimaryIcon)
        surface.DrawTexturedRect(EFGM.MenuScale(25), EFGM.MenuScale(15), EFGM.MenuScale(250), EFGM.MenuScale(80))

    end

    primaryWeaponText = vgui.Create("DPanel", equipmentHolder)
    primaryWeaponText:SetSize(EFGM.MenuScale(90), EFGM.MenuScale(30))
    primaryWeaponText:SetPos(equipmentHolder:GetWide() - primaryWeaponText:GetWide(), primaryWeaponHolder:GetY() - EFGM.MenuScale(30))
    primaryWeaponText.Paint = function(s, w, h)

        surface.SetDrawColor(Colors.containerBackgroundColor)
        surface.DrawRect(0, 0, w, h)

        surface.SetDrawColor(Colors.transparentWhiteColor)
        surface.DrawRect(0, 0, EFGM.MenuScale(220), EFGM.MenuScale(2))

        draw.SimpleTextOutlined("PRIMARY", "PuristaBold24", w / 2, EFGM.MenuScale(2), Colors.whiteColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 1, Colors.blackColor)

    end

    -- holster slot
    holsterWeaponHolder = vgui.Create("DPanel", equipmentHolder)
    holsterWeaponHolder:SetSize(EFGM.MenuScale(114), EFGM.MenuScale(57))
    holsterWeaponHolder:SetPos(equipmentHolder:GetWide() - holsterWeaponHolder:GetWide(), primaryWeaponHolder:GetY() - holsterWeaponHolder:GetTall() - EFGM.MenuScale(40))

    function holsterWeaponHolder:Paint(w, h)

        BlurPanel(holsterWeaponHolder, EFGM.MenuScale(3))

        surface.SetDrawColor(Colors.containerBackgroundColor)
        surface.DrawRect(0, 0, w, h)

        surface.SetDrawColor(Colors.whiteBorderColor)
        surface.DrawRect(0, 0, w, EFGM.MenuScale(1))
        surface.DrawRect(0, h - 1, w, EFGM.MenuScale(1))
        surface.DrawRect(0, 0, EFGM.MenuScale(1), h)
        surface.DrawRect(w - 1, 0, EFGM.MenuScale(1), h)

        if !table.IsEmpty(playerWeaponSlots[2][1]) then return end

        surface.SetDrawColor(Colors.weaponSilhouetteColor)
        surface.SetMaterial(Mats.invHolsterIcon)
        surface.DrawTexturedRect(EFGM.MenuScale(27), EFGM.MenuScale(8), EFGM.MenuScale(60), EFGM.MenuScale(40))

    end

    holsterWeaponText = vgui.Create("DPanel", equipmentHolder)
    holsterWeaponText:SetSize(EFGM.MenuScale(90), EFGM.MenuScale(30))
    holsterWeaponText:SetPos(equipmentHolder:GetWide() - holsterWeaponText:GetWide(), holsterWeaponHolder:GetY() - EFGM.MenuScale(30))
    holsterWeaponText.Paint = function(s, w, h)

        surface.SetDrawColor(Colors.containerBackgroundColor)
        surface.DrawRect(0, 0, w, h)

        surface.SetDrawColor(Colors.transparentWhiteColor)
        surface.DrawRect(0, 0, EFGM.MenuScale(220), EFGM.MenuScale(2))

        draw.SimpleTextOutlined("HOLSTER", "PuristaBold24", w / 2, EFGM.MenuScale(2), Colors.whiteColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 1, Colors.blackColor)

    end

    -- melee slot
    meleeWeaponHolder = vgui.Create("DPanel", equipmentHolder)
    meleeWeaponHolder:SetSize(EFGM.MenuScale(114), EFGM.MenuScale(57))
    meleeWeaponHolder:SetPos(equipmentHolder:GetWide() - meleeWeaponHolder:GetWide(), holsterWeaponHolder:GetY() - meleeWeaponHolder:GetTall() - EFGM.MenuScale(40))

    function meleeWeaponHolder:Paint(w, h)

        BlurPanel(meleeWeaponHolder, EFGM.MenuScale(3))

        surface.SetDrawColor(Colors.containerBackgroundColor)
        surface.DrawRect(0, 0, w, h)

        surface.SetDrawColor(Colors.whiteBorderColor)
        surface.DrawRect(0, 0, w, EFGM.MenuScale(1))
        surface.DrawRect(0, h - 1, w, EFGM.MenuScale(1))
        surface.DrawRect(0, 0, EFGM.MenuScale(1), h)
        surface.DrawRect(w - 1, 0, EFGM.MenuScale(1), h)

        if !table.IsEmpty(playerWeaponSlots[3][1]) then return end

        surface.SetDrawColor(Colors.weaponSilhouetteColor)
        surface.SetMaterial(Mats.invMeleeIcon)
        surface.DrawTexturedRect(EFGM.MenuScale(25), EFGM.MenuScale(8), EFGM.MenuScale(60), EFGM.MenuScale(40))

    end

    meleeWeaponText = vgui.Create("DPanel", equipmentHolder)
    meleeWeaponText:SetSize(EFGM.MenuScale(65), EFGM.MenuScale(30))
    meleeWeaponText:SetPos(equipmentHolder:GetWide() - meleeWeaponText:GetWide(), meleeWeaponHolder:GetY() - EFGM.MenuScale(30))
    meleeWeaponText.Paint = function(s, w, h)

        surface.SetDrawColor(Colors.containerBackgroundColor)
        surface.DrawRect(0, 0, w, h)

        surface.SetDrawColor(Colors.transparentWhiteColor)
        surface.DrawRect(0, 0, EFGM.MenuScale(220), EFGM.MenuScale(2))

        draw.SimpleTextOutlined("MELEE", "PuristaBold24", w / 2, EFGM.MenuScale(2), Colors.whiteColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 1, Colors.blackColor)

    end

    -- nade slot
    nadeWeaponHolder = vgui.Create("DPanel", equipmentHolder)
    nadeWeaponHolder:SetSize(EFGM.MenuScale(57), EFGM.MenuScale(57))
    nadeWeaponHolder:SetPos(equipmentHolder:GetWide() - nadeWeaponHolder:GetWide(), meleeWeaponHolder:GetY() - nadeWeaponHolder:GetTall() - EFGM.MenuScale(40))

    function nadeWeaponHolder:Paint(w, h)

        BlurPanel(nadeWeaponHolder, EFGM.MenuScale(3))

        surface.SetDrawColor(Colors.containerBackgroundColor)
        surface.DrawRect(0, 0, w, h)

        surface.SetDrawColor(Colors.whiteBorderColor)
        surface.DrawRect(0, 0, w, EFGM.MenuScale(1))
        surface.DrawRect(0, h - 1, w, EFGM.MenuScale(1))
        surface.DrawRect(0, 0, EFGM.MenuScale(1), h)
        surface.DrawRect(w - 1, 0, EFGM.MenuScale(1), h)

        if !table.IsEmpty(playerWeaponSlots[4][1]) then return end

        surface.SetDrawColor(Colors.weaponSilhouetteColor)
        surface.SetMaterial(Mats.invNadeIcon)
        surface.DrawTexturedRect(EFGM.MenuScale(2), 0, EFGM.MenuScale(57), EFGM.MenuScale(57))

    end

    nadeWeaponText = vgui.Create("DPanel", equipmentHolder)
    nadeWeaponText:SetSize(EFGM.MenuScale(57), EFGM.MenuScale(30))
    nadeWeaponText:SetPos(equipmentHolder:GetWide() - nadeWeaponText:GetWide(), nadeWeaponHolder:GetY() - EFGM.MenuScale(30))
    nadeWeaponText.Paint = function(s, w, h)

        surface.SetDrawColor(Colors.containerBackgroundColor)
        surface.DrawRect(0, 0, w, h)

        surface.SetDrawColor(Colors.transparentWhiteColor)
        surface.DrawRect(0, 0, EFGM.MenuScale(220), EFGM.MenuScale(2))

        draw.SimpleTextOutlined("NADE", "PuristaBold24", w / 2, EFGM.MenuScale(2), Colors.whiteColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 1, Colors.blackColor)

    end

    Menu.ReloadSlots()

    secondaryWeaponHolder:Receiver("slot_primary", function(self, panels, dropped, _, x, y)

        if !dropped then return end
        if !table.IsEmpty(playerWeaponSlots[1][2]) then return end

        if panels[1].ORIGIN == "inventory" then

            surface.PlaySound("ui/equip_" .. math.random(1, 6) .. ".wav")
            EquipItemFromInventory(panels[1].ID, panels[1].SLOT, 2)

        end

        if panels[1].ORIGIN == "stash" then

            surface.PlaySound("ui/equip_" .. math.random(1, 6) .. ".wav")
            EquipItemFromStash(panels[1].ID, panels[1].SLOT, 2)

        end

    end)

    primaryWeaponHolder:Receiver("slot_primary", function(self, panels, dropped, _, x, y)

        if !dropped then return end
        if !table.IsEmpty(playerWeaponSlots[1][1]) then return end

        if panels[1].ORIGIN == "inventory" then

            surface.PlaySound("ui/equip_" .. math.random(1, 6) .. ".wav")
            EquipItemFromInventory(panels[1].ID, panels[1].SLOT, 1)

        end

        if panels[1].ORIGIN == "stash" then

            surface.PlaySound("ui/equip_" .. math.random(1, 6) .. ".wav")
            EquipItemFromStash(panels[1].ID, panels[1].SLOT, 1)

        end

    end)

    holsterWeaponHolder:Receiver("slot_holster", function(self, panels, dropped, _, x, y)

        if !dropped then return end
        if !table.IsEmpty(playerWeaponSlots[2][1]) then return end

        if panels[1].ORIGIN == "inventory" then

            surface.PlaySound("ui/equip_" .. math.random(1, 6) .. ".wav")
            EquipItemFromInventory(panels[1].ID, panels[1].SLOT)

        end

        if panels[1].ORIGIN == "stash" then

            surface.PlaySound("ui/equip_" .. math.random(1, 6) .. ".wav")
            EquipItemFromStash(panels[1].ID, panels[1].SLOT)

        end

    end)

    meleeWeaponHolder:Receiver("slot_melee", function(self, panels, dropped, _, x, y)

        if !dropped then return end
        if !table.IsEmpty(playerWeaponSlots[3][1]) then return end

        if panels[1].ORIGIN == "inventory" then

            surface.PlaySound("ui/equip_" .. math.random(1, 6) .. ".wav")
            EquipItemFromInventory(panels[1].ID, panels[1].SLOT)

        end

        if panels[1].ORIGIN == "stash" then

            surface.PlaySound("ui/equip_" .. math.random(1, 6) .. ".wav")
            EquipItemFromStash(panels[1].ID, panels[1].SLOT)

        end

    end)

    nadeWeaponHolder:Receiver("slot_grenade", function(self, panels, dropped, _, x, y)

        if !dropped then return end
        if !table.IsEmpty(playerWeaponSlots[4][1]) then return end

        if panels[1].ORIGIN == "inventory" then

            surface.PlaySound("ui/equip_" .. math.random(1, 6) .. ".wav")
            EquipItemFromInventory(panels[1].ID, panels[1].SLOT)

        end

        if panels[1].ORIGIN == "stash" then

            surface.PlaySound("ui/equip_" .. math.random(1, 6) .. ".wav")
            EquipItemFromStash(panels[1].ID, panels[1].SLOT)

        end

    end)

    local healthHolder = vgui.Create("DPanel", playerPanel)
    healthHolder:SetPos(EFGM.MenuScale(10), EFGM.MenuScale(895))
    healthHolder:SetSize(EFGM.MenuScale(125), EFGM.MenuScale(55))
    function healthHolder:Paint(w, h)

        surface.SetDrawColor(Colors.containerBackgroundColor)
        surface.DrawRect(0, 0, w, h)

        surface.SetDrawColor(Colors.whiteBorderColor)
        surface.DrawRect(0, 0, w, EFGM.MenuScale(1))
        surface.DrawRect(0, h - 1, w, EFGM.MenuScale(1))
        surface.DrawRect(0, 0, EFGM.MenuScale(1), h)
        surface.DrawRect(w - 1, 0, EFGM.MenuScale(1), h)

        draw.SimpleTextOutlined(Menu.Player:Health() or "0", "PuristaBold50", w - EFGM.MenuScale(8), 0, Colors.healthGreenColor, TEXT_ALIGN_RIGHT, TEXT_ALIGN_TOP, 1, Colors.blackColor)

        surface.SetDrawColor(Colors.healthGreenColor)
        surface.SetMaterial(Mats.healthIcon)
        surface.DrawTexturedRect(0, 0, EFGM.MenuScale(53), EFGM.MenuScale(53))

    end

    local healthText = vgui.Create("DPanel", playerPanel)
    healthText:SetSize(EFGM.MenuScale(80), EFGM.MenuScale(30))
    healthText:SetPos(EFGM.MenuScale(10), EFGM.MenuScale(865))
    healthText.Paint = function(s, w, h)

        surface.SetDrawColor(Colors.containerBackgroundColor)
        surface.DrawRect(0, 0, w, h)

        surface.SetDrawColor(Colors.transparentWhiteColor)
        surface.DrawRect(0, 0, EFGM.MenuScale(220), EFGM.MenuScale(2))

        draw.SimpleTextOutlined("HEALTH", "PuristaBold24", w / 2, EFGM.MenuScale(2), Colors.whiteColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 1, Colors.blackColor)

    end

    if Menu.Player:CompareStatus(0) then

        surface.SetFont("PuristaBold24")
        local unloadText = "UNEQUIP ALL"
        local unloadTextSize = surface.GetTextSize(unloadText)
        local unloadButtonSize = unloadTextSize + EFGM.MenuScale(10)

        local unloadButton = vgui.Create("DButton", playerPanel)
        unloadButton:SetPos(playerPanel:GetWide() - unloadTextSize - EFGM.MenuScale(20), EFGM.MenuScale(46))
        unloadButton:SetSize(unloadButtonSize, EFGM.MenuScale(28))
        unloadButton:SetText("")
        unloadButton.Paint = function(s, w, h)

            surface.SetDrawColor(Colors.containerBackgroundColor)
            surface.DrawRect(0, 0, unloadTextSize + EFGM.MenuScale(10), h)

            surface.SetDrawColor(Colors.transparentWhiteColor)
            surface.DrawRect(0, 0, unloadTextSize + EFGM.MenuScale(10), EFGM.MenuScale(2))

            draw.SimpleTextOutlined(unloadText, "PuristaBold24", w / 2, EFGM.MenuScale(2), Colors.whiteColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 1, Colors.blackColor)

        end

        unloadButton.OnCursorEntered = function(s)

            surface.PlaySound("ui/element_hover_" .. math.random(1, 3) .. ".wav")

        end

        function unloadButton:DoClick()

            surface.PlaySound("ui/equip_" .. math.random(1, 6) .. ".wav")

            UnequipAll()

        end

        surface.SetFont("PuristaBold24")
        local factionText = "SWITCH TO SCAV"
        local factionTextSize = surface.GetTextSize(factionText)
        local factionButtonSize = factionTextSize + EFGM.MenuScale(10)

        local factionButton = vgui.Create("DButton", playerPanel)
        factionButton:SetPos(playerPanel:GetWide() - unloadButtonSize - factionTextSize - EFGM.MenuScale(25), EFGM.MenuScale(46))
        factionButton:SetSize(factionButtonSize, EFGM.MenuScale(28))
        factionButton:SetText("")
        factionButton.Paint = function(s, w, h)

            surface.SetFont("PuristaBold24")

            if Menu.Player:CompareFaction(true) then

                factionText = "SWITCH TO SCAV"
                factionTextSize = surface.GetTextSize(factionText)
                factionButtonSize = factionTextSize + EFGM.MenuScale(10)

            else

                factionText = "SWITCH TO PMC"
                factionTextSize = surface.GetTextSize(factionText)
                factionButtonSize = factionTextSize + EFGM.MenuScale(10)

            end

            factionButton:SetWide(factionButtonSize)
            factionButton:SetX(playerPanel:GetWide() - unloadButtonSize - factionTextSize - EFGM.MenuScale(25))

            surface.SetDrawColor(Colors.containerBackgroundColor)
            surface.DrawRect(0, 0, factionTextSize + EFGM.MenuScale(10), h)

            surface.SetDrawColor(Colors.transparentWhiteColor)
            surface.DrawRect(0, 0, factionTextSize + EFGM.MenuScale(10), EFGM.MenuScale(2))

            draw.SimpleTextOutlined(factionText, "PuristaBold24", w / 2, EFGM.MenuScale(2), Colors.whiteColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 1, Colors.blackColor)

        end

        factionButton.OnCursorEntered = function(s)

            surface.PlaySound("ui/element_hover_" .. math.random(1, 3) .. ".wav")

        end

        function factionButton:DoClick()

            surface.PlaySound("ui/equip_" .. math.random(1, 6) .. ".wav")

            net.Start("PlayerSwitchFactions", false)
            net.SendToServer()

        end

    end

    local inventoryPanel = vgui.Create("DPanel", contents)
    inventoryPanel:Dock(LEFT)
    inventoryPanel:DockMargin(EFGM.MenuScale(13), 0, 0, 0)
    inventoryPanel:SetSize(EFGM.MenuScale(613), 0)
    inventoryPanel.Paint = function(s, w, h)

        BlurPanel(s, EFGM.MenuScale(10))

        surface.SetDrawColor(Colors.containerBackgroundColor)
        surface.DrawRect(0, 0, w, h)

        surface.SetDrawColor(Colors.transparentWhiteColor)
        surface.DrawRect(0, 0, w, EFGM.MenuScale(6))

    end

    local inventoryText = vgui.Create("DPanel", inventoryPanel)
    inventoryText:Dock(TOP)
    inventoryText:SetSize(0, EFGM.MenuScale(36))
    function inventoryText:Paint(w, h)

        surface.SetDrawColor(Colors.containerHeaderColor)
        surface.DrawRect(0, 0, w, h)

        draw.SimpleTextOutlined("INVENTORY", "PuristaBold32", EFGM.MenuScale(5), EFGM.MenuScale(2), Colors.whiteColor, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP, 1, Colors.blackColor)

    end

    itemsHolder = vgui.Create("DPanel", inventoryPanel)
    itemsHolder:Dock(FILL)
    itemsHolder:DockMargin(EFGM.MenuScale(10), EFGM.MenuScale(10), EFGM.MenuScale(10), EFGM.MenuScale(9))
    itemsHolder:SetSize(0, 0)
    itemsHolder.Paint = nil

    local itemsText = vgui.Create("DPanel", itemsHolder)
    itemsText:Dock(TOP)
    itemsText:SetSize(0, EFGM.MenuScale(28))
    surface.SetFont("PuristaBold24")
    local usedWeight = string.format("%04.2f", Menu.Player:GetNWFloat("InventoryWeight", 0.00))
    local maxWeight = 85
    local weightText = usedWeight .. " / " .. maxWeight .. "KG"
    local weightTextSize = surface.GetTextSize(weightText)
    local weightColor
    itemsText.Paint = function(s, w, h)

        surface.SetFont("PuristaBold24")
        usedWeight = string.format("%04.2f", Menu.Player:GetNWFloat("InventoryWeight", 0.00))
        maxWeight = 85
        weightText = usedWeight .. " / " .. maxWeight .. "KG"
        weightTextSize = surface.GetTextSize(weightText)

        BlurPanel(s, EFGM.MenuScale(3))

        surface.SetDrawColor(Colors.containerBackgroundColor)
        surface.DrawRect(0, 0, weightTextSize + EFGM.MenuScale(220), h)

        surface.SetDrawColor(Colors.transparentWhiteColor)
        surface.DrawRect(0, 0, weightTextSize + EFGM.MenuScale(220), EFGM.MenuScale(2))

        draw.SimpleTextOutlined(weightText, "PuristaBold24", EFGM.MenuScale(215), EFGM.MenuScale(2), Colors.whiteColor, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP, 1, Colors.blackColor)

        -- total weight capacity
        surface.SetDrawColor(Colors.transparentBlackColor)
        surface.DrawRect(EFGM.MenuScale(30), EFGM.MenuScale(7), EFGM.MenuScale(180), EFGM.MenuScale(16))

        -- used weight capacity
        if Menu.Player:GetNWFloat("InventoryWeight", 0.00) < 30 then
            weightColor = Colors.weightUnderColor
        elseif Menu.Player:GetNWFloat("InventoryWeight", 0.00) >= 30 and Menu.Player:GetNWFloat("InventoryWeight", 0.00) < 85 then
            weightColor = Colors.weightWarningColor
        elseif Menu.Player:GetNWFloat("InventoryWeight", 0.00) >= 85 then
            weightColor = Colors.weightMaxColor
        end

        surface.SetDrawColor(weightColor)
        surface.DrawRect(EFGM.MenuScale(30), EFGM.MenuScale(7), math.min((usedWeight / maxWeight) * EFGM.MenuScale(180), EFGM.MenuScale(180)), EFGM.MenuScale(16))

        surface.SetDrawColor(Colors.whiteBorderColor)
        surface.DrawRect(EFGM.MenuScale(30), EFGM.MenuScale(7), EFGM.MenuScale(180), EFGM.MenuScale(1))
        surface.DrawRect(EFGM.MenuScale(30), EFGM.MenuScale(23), EFGM.MenuScale(180), EFGM.MenuScale(1))
        surface.DrawRect(EFGM.MenuScale(30), EFGM.MenuScale(7), EFGM.MenuScale(1), EFGM.MenuScale(16))
        surface.DrawRect(EFGM.MenuScale(210) - 1, EFGM.MenuScale(7), EFGM.MenuScale(1), EFGM.MenuScale(16))

    end

    local weightIcon = vgui.Create("DButton", itemsHolder)
    weightIcon:SetPos(0, 0)
    weightIcon:SetSize(EFGM.MenuScale(28), EFGM.MenuScale(28))
    weightIcon:SetText("")

    weightIcon.Paint = function(s, w, h)

        surface.SetDrawColor(Colors.pureWhiteColor)
        surface.SetMaterial(Mats.weightIcon)
        surface.DrawTexturedRect(0, EFGM.MenuScale(1), EFGM.MenuScale(28), EFGM.MenuScale(28))

    end

    weightIcon.OnCursorEntered = function(s)

        local x, y = Menu.MouseX, Menu.MouseY
        local sideH, sideV

        surface.PlaySound("ui/element_hover_" .. math.random(1, 3) .. ".wav")

        if x <= (ScrW() / 2) then sideH = true else sideH = false end
        if y <= (ScrH() / 2) then sideV = true else sideV = false end

        local function UpdatePopOutPos()

            if sideH == true then

                weightPopOut:SetX(math.Clamp(x + EFGM.MenuScale(15), EFGM.MenuScale(10), ScrW() - weightPopOut:GetWide() - EFGM.MenuScale(10)))

            else

                weightPopOut:SetX(math.Clamp(x - weightPopOut:GetWide() - EFGM.MenuScale(15), EFGM.MenuScale(10), ScrW() - weightPopOut:GetWide() - EFGM.MenuScale(10)))

            end

            if sideV == true then

                weightPopOut:SetY(math.Clamp(y + EFGM.MenuScale(15), EFGM.MenuScale(60), ScrH() - weightPopOut:GetTall() - EFGM.MenuScale(20)))

            else

                weightPopOut:SetY(math.Clamp(y - weightPopOut:GetTall() + EFGM.MenuScale(15), EFGM.MenuScale(60), ScrH() - weightPopOut:GetTall() - EFGM.MenuScale(20)))

            end

        end

        if IsValid(weightPopOut) then weightPopOut:Remove() end
        weightPopOut = vgui.Create("DPanel", Menu.MenuFrame)
        weightPopOut:SetSize(EFGM.MenuScale(560), EFGM.MenuScale(165))
        UpdatePopOutPos()
        weightPopOut:AlphaTo(255, 0.1, 0, nil)
        weightPopOut:SetMouseInputEnabled(false)

        local maxLossMove = 45
        local maxLossInertia = 0.75
        local maxLossADS = 3
        local maxLossSway = 1.2
        local maxLossLean = 0.6

        weightPopOut.Paint = function(s, w, h)

            if !IsValid(s) then return end

            BlurPanel(s, EFGM.MenuScale(3))

            -- panel position follows mouse position
            x, y = Menu.MouseX, Menu.MouseY

            UpdatePopOutPos()

            surface.SetDrawColor(Color(0, 0, 0, 205))
            surface.DrawRect(0, 0, w, h)

            surface.SetDrawColor(Color(55, 55, 55, 45))
            surface.DrawRect(0, 0, w, h)

            surface.SetDrawColor(Color(55, 55, 55))
            surface.DrawRect(0, 0, w, EFGM.MenuScale(5))

            surface.SetDrawColor(Colors.transparentWhiteColor)
            surface.DrawRect(0, 0, w, EFGM.MenuScale(1))
            surface.DrawRect(0, h - 1, w, EFGM.MenuScale(1))
            surface.DrawRect(0, 0, EFGM.MenuScale(1), h)
            surface.DrawRect(w - 1, 0, EFGM.MenuScale(1), h)

            draw.SimpleTextOutlined("WEIGHT", "PuristaBold24", EFGM.MenuScale(5), EFGM.MenuScale(5), Colors.whiteColor, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP, 1, Colors.blackColor)
            draw.SimpleTextOutlined("Your carry weight can begin to negatively affect your character if it goes unchecked.", "Purista18", EFGM.MenuScale(5), EFGM.MenuScale(25), Colors.whiteColor, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP, 1, Colors.blackColor)

            draw.SimpleTextOutlined("EFFECTS", "PuristaBold24", EFGM.MenuScale(5), EFGM.MenuScale(50), Colors.whiteColor, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP, 1, Colors.blackColor)
            draw.SimpleTextOutlined("MOVEMENT SPEED: -" .. math.max(0, math.min(maxLossMove, math.Round(math.max(0, Menu.Player:GetNWFloat("InventoryWeight", 0.00) - underweightLimit) * 0.818, 2))) .. "u/s", "PuristaBold16", EFGM.MenuScale(5), EFGM.MenuScale(70), Colors.whiteColor, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP, 1, Colors.blackColor)
            draw.SimpleTextOutlined("MOVEMENT INERTIA: +" .. math.max(0, math.min(maxLossInertia, math.Round(math.max(0, Menu.Player:GetNWFloat("InventoryWeight", 0.00) - underweightLimit) * 0.0136, 2))) * 100 .. "%", "PuristaBold16", EFGM.MenuScale(5), EFGM.MenuScale(83), Colors.whiteColor, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP, 1, Colors.blackColor)
            draw.SimpleTextOutlined("AIM DOWN SIGHTS TIME: +" .. math.max(1, 1 + math.min(maxLossADS, math.Round((math.max(0, Menu.Player:GetNWFloat("InventoryWeight", 0.00) - underweightLimit) * 0.011) * 5, 2))) * 100 .. "%", "PuristaBold16", EFGM.MenuScale(5), EFGM.MenuScale(96), Colors.whiteColor, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP, 1, Colors.blackColor)
            draw.SimpleTextOutlined("WEAPON SWAY: +" .. math.max(1, 1 + math.min(maxLossSway, math.Round((math.max(0, Menu.Player:GetNWFloat("InventoryWeight", 0.00) - underweightLimit) * 0.011) * 2, 2))) * 100 .. "%", "PuristaBold16", EFGM.MenuScale(5), EFGM.MenuScale(109), Colors.whiteColor, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP, 1, Colors.blackColor)
            draw.SimpleTextOutlined("LEANING SPEED: -" .. 100 - math.min(1, 1 - math.min(maxLossLean, math.Round(math.max(0, Menu.Player:GetNWFloat("InventoryWeight", 0.00) - underweightLimit) * 0.0109, 2))) * 100 .. "%", "PuristaBold16", EFGM.MenuScale(5), EFGM.MenuScale(122), Colors.whiteColor, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP, 1, Colors.blackColor)

            surface.SetDrawColor(Colors.transparentWhiteColor)
            surface.DrawRect(EFGM.MenuScale(5), EFGM.MenuScale(150), EFGM.MenuScale(550), EFGM.MenuScale(1))
            surface.DrawRect(EFGM.MenuScale(5), EFGM.MenuScale(159), EFGM.MenuScale(550), EFGM.MenuScale(1))
            surface.DrawRect(EFGM.MenuScale(5), EFGM.MenuScale(150), EFGM.MenuScale(1), EFGM.MenuScale(10))
            surface.DrawRect(EFGM.MenuScale(554), EFGM.MenuScale(150), EFGM.MenuScale(1), EFGM.MenuScale(10))

            surface.SetDrawColor(Color(255, 255, 0, 55))
            surface.DrawRect(EFGM.MenuScale(202), EFGM.MenuScale(150), EFGM.MenuScale(10), EFGM.MenuScale(10))

            surface.SetDrawColor(Color(255, 0, 0, 55))
            surface.DrawRect(EFGM.MenuScale(545), EFGM.MenuScale(150), EFGM.MenuScale(10), EFGM.MenuScale(10))

            surface.SetDrawColor(30, 30, 30, 125)
            surface.DrawRect(EFGM.MenuScale(5), EFGM.MenuScale(150), EFGM.MenuScale(550), EFGM.MenuScale(10))

            surface.SetDrawColor(weightColor)
            surface.DrawRect(EFGM.MenuScale(5), EFGM.MenuScale(150), math.min(usedWeight / maxWeight * EFGM.MenuScale(550), EFGM.MenuScale(550)), EFGM.MenuScale(10))

        end

    end

    weightIcon.OnCursorExited = function(s)

        if IsValid(weightPopOut) then

            weightPopOut:AlphaTo(0, 0.1, 0, function() weightPopOut:Remove() end)

        end

    end

    local unloadText = ""
    local unloadTextSize = EFGM.MenuScale(-15)
    local unloadButtonSize = 0

    if Menu.Player:CompareStatus(0) then

        surface.SetFont("PuristaBold24")
        unloadText = "STASH ALL"
        unloadTextSize = surface.GetTextSize(unloadText)
        unloadButtonSize = unloadTextSize + EFGM.MenuScale(10)

        local unloadButton = vgui.Create("DButton", itemsHolder)
        unloadButton:SetPos(EFGM.MenuScale(225) + weightTextSize, 0)
        unloadButton:SetSize(unloadButtonSize, EFGM.MenuScale(28))
        unloadButton:SetText("")
        unloadButton.Paint = function(s, w, h)

            unloadButton:SetX(EFGM.MenuScale(225) + weightTextSize)

            surface.SetDrawColor(Colors.containerBackgroundColor)
            surface.DrawRect(0, 0, unloadTextSize + EFGM.MenuScale(10), h)

            surface.SetDrawColor(Colors.transparentWhiteColor)
            surface.DrawRect(0, 0, unloadTextSize + EFGM.MenuScale(10), EFGM.MenuScale(2))

            draw.SimpleTextOutlined(unloadText, "PuristaBold24", w / 2, EFGM.MenuScale(2), Colors.whiteColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 1, Colors.blackColor)

        end

        unloadButton.OnCursorEntered = function(s)

            surface.PlaySound("ui/element_hover_" .. math.random(1, 3) .. ".wav")

        end

        function unloadButton:DoClick()

            surface.PlaySound("ui/equip_" .. math.random(1, 6) .. ".wav")

            UnloadInventoryToStash()

        end

    end

    surface.SetFont("PuristaBold24")
    local searchText = "SEARCH"
    local searchTextSize = surface.GetTextSize(searchText)
    local searchButtonSize = searchTextSize + EFGM.MenuScale(10)

    local searchButton = vgui.Create("DButton", itemsHolder)
    searchButton:SetPos(EFGM.MenuScale(240) + weightTextSize + unloadTextSize, 0)
    searchButton:SetSize(searchButtonSize, EFGM.MenuScale(28))
    searchButton:SetText("")
    searchButton.Paint = function(s, w, h)

        searchButton:SetX(EFGM.MenuScale(240) + weightTextSize + unloadTextSize)

        surface.SetDrawColor(Colors.containerBackgroundColor)
        surface.DrawRect(0, 0, searchTextSize + EFGM.MenuScale(10), h)

        surface.SetDrawColor(Colors.transparentWhiteColor)
        surface.DrawRect(0, 0, searchTextSize + EFGM.MenuScale(10), EFGM.MenuScale(2))

        draw.SimpleTextOutlined(searchText, "PuristaBold24", w / 2, EFGM.MenuScale(2), Colors.whiteColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 1, Colors.blackColor)

    end

    searchOpen = false
    itemSearchText = ""

    searchBox = vgui.Create("DTextEntry", itemsHolder)
    searchBox:SetSize(EFGM.MenuScale(593) - searchButton:GetX() - searchButton:GetWide(), EFGM.MenuScale(28))
    searchBox:SetPos(searchButton:GetX() + searchButtonSize, 0)
    searchBox:SetPlaceholderText("search...")
    searchBox:SetUpdateOnType(true)
    searchBox:SetTextColor(Colors.whiteColor)
    searchBox:SetCursorColor(Colors.whiteColor)
    searchBox:SetAlpha(0)
    searchBox:SetEditable(false)

    function searchBox:AllowInput(char)

        if char == "[" or char == "]" then return true end

    end

    searchBox.Think = function(s)

        searchBox:SetWide(EFGM.MenuScale(593) - searchButton:GetX() - searchButton:GetWide())
        searchBox:SetX(searchButton:GetX() + searchButtonSize)

    end

    searchBox.OnChange = function(self)

        local value = self:GetValue():lower()

        if value:match("^%s+") then

            self:SetText(value:match("^%s*(.-)$"))
            return

        end

        if !GetConVar("efgm_menu_search_automatic"):GetBool() then return end

        itemSearchText = value
        Menu.ReloadInventory()

    end

    searchBox.OnEnter = function(self)

        if GetConVar("efgm_menu_search_automatic"):GetBool() then return end
        itemSearchText = self:GetValue():lower()
        Menu.ReloadInventory()

    end

    searchButton.OnCursorEntered = function(s)

        surface.PlaySound("ui/element_hover_" .. math.random(1, 3) .. ".wav")

    end

    function searchButton:DoClick()

        surface.PlaySound("ui/element_select.wav")

        if searchOpen == false then

            searchBox:AlphaTo(255, 0.1, 0)
            searchBox:SetEditable(true)
            searchBox:RequestFocus()
            searchOpen = true

        else

            searchBox:AlphaTo(0, 0.1, 0)
            searchBox:SetEditable(false)
            searchBox:SetValue("")
            itemSearchText = ""
            searchOpen = false
            Menu.ReloadInventory()

        end

    end

    local playerItemsHolder = vgui.Create("DScrollPanel", itemsHolder)
    playerItemsHolder:SetPos(0, EFGM.MenuScale(32))
    playerItemsHolder:SetSize(EFGM.MenuScale(593), EFGM.MenuScale(872))
    function playerItemsHolder:Paint(w, h)

        BlurPanel(playerItemsHolder, EFGM.MenuScale(3))

        surface.SetDrawColor(Colors.containerBackgroundColor)
        surface.DrawRect(0, 0, w, h)

        surface.SetDrawColor(Colors.whiteBorderColor)
        surface.DrawRect(0, 0, w, EFGM.MenuScale(1))
        surface.DrawRect(0, h - 1, w, EFGM.MenuScale(1))
        surface.DrawRect(0, 0, EFGM.MenuScale(1), h)
        surface.DrawRect(w - 1, 0, EFGM.MenuScale(1), h)

    end

    function playerItemsHolder:OnVScroll(offset)

        self.pnlCanvas:SetPos(0, offset)
        if !IsValid(contextMenu) then return end
        contextMenu:AlphaTo(0, 0.1, 0, function() contextMenu:Remove() hook.Remove("Think", "CheckIfContextMenuStillFocused") end)

    end

    function playerItemsHolder:PaintOver(w, h)

        if Menu.Player:CompareFaction(false) then

            surface.SetDrawColor(Colors.whiteBorderColor)
            surface.SetMaterial(Mats.blockedIcon)
            surface.DrawTexturedRect(w / 2 - EFGM.MenuScale(72), h / 2 - EFGM.MenuScale(116), EFGM.MenuScale(144), EFGM.MenuScale(144))

        end

    end

    playerItemsHolder:Receiver("items", function(self, panels, dropped, _, x, y)

        if !dropped then return end

        if panels[1].ORIGIN == "equipped" then

            surface.PlaySound("ui/equip_" .. math.random(1, 6) .. ".wav")
            UnEquipItemFromInventory(panels[1].SLOTID, panels[1].SLOT)

        end

        if panels[1].ORIGIN == "stash" then

            surface.PlaySound("ui/inv_item_toinv_" .. math.random(1, 7) .. ".wav")
            TakeFromStashToInventory(panels[1].ID)

        end

        if panels[1].ORIGIN == "container" then

            surface.PlaySound("ui/inv_item_toinv_" .. math.random(1, 7) .. ".wav")
            table.remove(container.items, panels[1].ID)

            net.Start("PlayerInventoryLootItemFromContainer", false)
                net.WriteEntity(container.entity)
                net.WriteUInt(panels[1].ID, 16)
            net.SendToServer()

            Menu.ReloadContainer()

        end

    end)

    playerItems = vgui.Create("DIconLayout", playerItemsHolder)
    playerItems:Dock(TOP)
    playerItems:SetSpaceY(0)
    playerItems:SetSpaceX(0)

    local playerItemsBar = playerItemsHolder:GetVBar()
    playerItemsBar:SetHideButtons(true)
    playerItemsBar:SetSize(EFGM.MenuScale(15), EFGM.MenuScale(15))
    function playerItemsBar:Paint(w, h)
        draw.RoundedBox(0, EFGM.MenuScale(5), EFGM.MenuScale(8), EFGM.MenuScale(5), h - EFGM.MenuScale(16), Colors.scrollerColor)
    end
    function playerItemsBar.btnGrip:Paint(w, h)
        draw.RoundedBox(0, EFGM.MenuScale(5), EFGM.MenuScale(8), EFGM.MenuScale(5), h - EFGM.MenuScale(16), Colors.transparentWhiteColor)
    end

    Menu.ReloadInventory()

    if !table.IsEmpty(container) then

        local containerPanel = vgui.Create("DPanel", contents)
        containerPanel:Dock(LEFT)
        containerPanel:DockMargin(EFGM.MenuScale(13), 0, 0, 0)
        containerPanel:SetSize(EFGM.MenuScale(613), 0)
        containerPanel.Paint = function(s, w, h)

            BlurPanel(s, EFGM.MenuScale(10))

            surface.SetDrawColor(Colors.containerBackgroundColor)
            surface.DrawRect(0, 0, w, h)

            surface.SetDrawColor(Colors.transparentWhiteColor)
            surface.DrawRect(0, 0, w, EFGM.MenuScale(6))

        end

        local containerText = vgui.Create("DPanel", containerPanel)
        containerText:Dock(TOP)
        containerText:SetSize(0, EFGM.MenuScale(36))
        function containerText:Paint(w, h)

            surface.SetDrawColor(Colors.containerHeaderColor)
            surface.DrawRect(0, 0, w, h)

            draw.SimpleTextOutlined(string.upper(container.name), "PuristaBold32", EFGM.MenuScale(5), EFGM.MenuScale(2), Colors.whiteColor, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP, 1, Colors.blackColor)

        end

        containerHolder = vgui.Create("DPanel", containerPanel)
        containerHolder:Dock(FILL)
        containerHolder:DockMargin(EFGM.MenuScale(10), EFGM.MenuScale(10), EFGM.MenuScale(10), EFGM.MenuScale(9))
        containerHolder:SetSize(0, 0)
        containerHolder.Paint = nil

        local containerItemsHolder = vgui.Create("DScrollPanel", containerHolder)
        containerItemsHolder:SetPos(0, EFGM.MenuScale(32))
        containerItemsHolder:SetSize(EFGM.MenuScale(593), EFGM.MenuScale(872))
        function containerItemsHolder:Paint(w, h)

            BlurPanel(containerItemsHolder, EFGM.MenuScale(3))

            surface.SetDrawColor(Colors.containerBackgroundColor)
            surface.DrawRect(0, 0, w, h)

            surface.SetDrawColor(Colors.whiteBorderColor)
            surface.DrawRect(0, 0, w, EFGM.MenuScale(1))
            surface.DrawRect(0, h - 1, w, EFGM.MenuScale(1))
            surface.DrawRect(0, 0, EFGM.MenuScale(1), h)
            surface.DrawRect(w - 1, 0, EFGM.MenuScale(1), h)

        end

        function containerItemsHolder:OnVScroll(offset)

            self.pnlCanvas:SetPos(0, offset)
            if !IsValid(contextMenu) then return end
            contextMenu:AlphaTo(0, 0.1, 0, function() contextMenu:Remove() hook.Remove("Think", "CheckIfContextMenuStillFocused") end)

        end

        containerItems = vgui.Create("DIconLayout", containerItemsHolder)
        containerItems:Dock(TOP)
        containerItems:SetSpaceY(0)
        containerItems:SetSpaceX(0)

        containerItems.Think = function(s)

            if !IsValid(container.entity) then

                Menu.Closing = true
                Menu.MenuFrame:SetKeyboardInputEnabled(false)
                Menu.MenuFrame:SetMouseInputEnabled(false)
                Menu.IsOpen = false

                Menu.MenuFrame:AlphaTo(0, 0.1, 0, function()

                    Menu.MenuFrame:Close()

                end)

            end

        end

        local containerItemsBar = containerItemsHolder:GetVBar()
        containerItemsBar:SetHideButtons(true)
        containerItemsBar:SetSize(EFGM.MenuScale(15), EFGM.MenuScale(15))
        function containerItemsBar:Paint(w, h)
            draw.RoundedBox(0, EFGM.MenuScale(5), EFGM.MenuScale(8), EFGM.MenuScale(5), h - EFGM.MenuScale(16), Colors.scrollerColor)
        end
        function containerItemsBar.btnGrip:Paint(w, h)
            draw.RoundedBox(0, EFGM.MenuScale(5), EFGM.MenuScale(8), EFGM.MenuScale(5), h - EFGM.MenuScale(16), Colors.transparentWhiteColor)
        end

        Menu.ReloadContainer()

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

        surface.SetDrawColor(Colors.containerBackgroundColor)
        surface.DrawRect(0, 0, w, h)

        surface.SetDrawColor(Colors.transparentWhiteColor)
        surface.DrawRect(0, 0, w, EFGM.MenuScale(6))

    end

    local maxStash = Menu.Player:GetNWInt("StashMax", 0)
    local stashText = vgui.Create("DPanel", stashPanel)
    stashText:Dock(TOP)
    stashText:SetSize(0, EFGM.MenuScale(36))
    function stashText:Paint(w, h)

        surface.SetDrawColor(Colors.containerHeaderColor)
        surface.DrawRect(0, 0, w, h)

        draw.SimpleTextOutlined("STASH", "PuristaBold32", EFGM.MenuScale(5), EFGM.MenuScale(2), Colors.whiteColor, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP, 1, Colors.blackColor)
        draw.SimpleTextOutlined(Menu.Player:GetNWInt("StashCount", 0) .. "/" .. maxStash, "PuristaBold18", EFGM.MenuScale(95), EFGM.MenuScale(13), Colors.whiteColor, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP, 1, Colors.blackColor)

    end

    stashHolder = vgui.Create("DPanel", stashPanel)
    stashHolder:Dock(FILL)
    stashHolder:DockMargin(EFGM.MenuScale(10), EFGM.MenuScale(10), EFGM.MenuScale(10), EFGM.MenuScale(9))
    stashHolder:SetSize(0, 0)
    stashHolder.Paint = nil

    local stashInfoText = vgui.Create("DPanel", stashHolder)
    stashInfoText:Dock(TOP)
    stashInfoText:SetSize(0, EFGM.MenuScale(28))
    surface.SetFont("PuristaBold24")
    stashValue = 0
    local valueText = "EST. VALUE: ₽" .. comma_value(stashValue)
    local valueTextSize = surface.GetTextSize(valueText)
    stashInfoText.Paint = function(s, w, h)

        surface.SetFont("PuristaBold24")
        valueText = "EST. VALUE: ₽" .. comma_value(stashValue)
        valueTextSize = surface.GetTextSize(valueText)

        BlurPanel(s, EFGM.MenuScale(3))

        surface.SetDrawColor(Colors.containerBackgroundColor)
        surface.DrawRect(0, 0, valueTextSize + EFGM.MenuScale(10), h)

        surface.SetDrawColor(Colors.transparentWhiteColor)
        surface.DrawRect(0, 0, valueTextSize + EFGM.MenuScale(10), EFGM.MenuScale(2))

        draw.SimpleTextOutlined(valueText, "PuristaBold24", EFGM.MenuScale(5), EFGM.MenuScale(2), Colors.whiteColor, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP, 1, Colors.blackColor)

    end

    surface.SetFont("PuristaBold24")
    local stashSearchText = "SEARCH"
    local stashSearchTextSize = surface.GetTextSize(stashSearchText)
    local stashSearchButtonSize = stashSearchTextSize + EFGM.MenuScale(10)

    local stashSearchButton = vgui.Create("DButton", stashHolder)
    stashSearchButton:SetPos(EFGM.MenuScale(15) + valueTextSize, 0)
    stashSearchButton:SetSize(stashSearchButtonSize, EFGM.MenuScale(28))
    stashSearchButton:SetText("")
    stashSearchButton.Paint = function(s, w, h)

        stashSearchButton:SetX(EFGM.MenuScale(15) + valueTextSize)

        surface.SetDrawColor(Colors.containerBackgroundColor)
        surface.DrawRect(0, 0, stashSearchTextSize + EFGM.MenuScale(10), h)

        surface.SetDrawColor(Colors.transparentWhiteColor)
        surface.DrawRect(0, 0, stashSearchTextSize + EFGM.MenuScale(10), EFGM.MenuScale(2))

        draw.SimpleTextOutlined(stashSearchText, "PuristaBold24", w / 2, EFGM.MenuScale(2), Colors.whiteColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 1, Colors.blackColor)

    end

    stashSearchOpen = false
    stashItemSearchText = ""

    stashSearchBox = vgui.Create("DTextEntry", stashHolder)
    stashSearchBox:SetSize(EFGM.MenuScale(593) - stashSearchButton:GetX() - stashSearchButton:GetWide(), EFGM.MenuScale(28))
    stashSearchBox:SetPos(stashSearchButton:GetX() + stashSearchButtonSize, 0)
    stashSearchBox:SetPlaceholderText("search...")
    stashSearchBox:SetUpdateOnType(true)
    stashSearchBox:SetTextColor(Colors.whiteColor)
    stashSearchBox:SetCursorColor(Colors.whiteColor)
    stashSearchBox:SetAlpha(0)
    stashSearchBox:SetEditable(false)

    function stashSearchBox:AllowInput(char)

        if char == "[" or char == "]" then return true end

    end

    stashSearchBox.Think = function(s)

        stashSearchBox:SetWide(EFGM.MenuScale(593) - stashSearchButton:GetX() - stashSearchButton:GetWide())
        stashSearchBox:SetX(stashSearchButton:GetX() + stashSearchButtonSize)

    end

    stashSearchBox.OnChange = function(self)

        local value = self:GetValue():lower()

        if value:match("^%s+") then

            self:SetText(value:match("^%s*(.-)$"))
            return

        end

        if !GetConVar("efgm_menu_search_automatic"):GetBool() then return end

        stashItemSearchText = value
        Menu.ReloadStash()

    end

    stashSearchBox.OnEnter = function(self)

        if GetConVar("efgm_menu_search_automatic"):GetBool() then return end
        stashItemSearchText = self:GetValue():lower()
        Menu.ReloadStash()

    end

    stashSearchButton.OnCursorEntered = function(s)

        surface.PlaySound("ui/element_hover_" .. math.random(1, 3) .. ".wav")

    end

    function stashSearchButton:DoClick()

        surface.PlaySound("ui/element_select.wav")

        if stashSearchOpen == false then

            stashSearchBox:AlphaTo(255, 0.1, 0)
            stashSearchBox:SetEditable(true)
            stashSearchBox:RequestFocus()
            stashSearchOpen = true

        else

            stashSearchBox:AlphaTo(0, 0.1, 0)
            stashSearchBox:SetEditable(false)
            stashSearchBox:SetValue("")
            stashItemSearchText = ""
            stashSearchOpen = false
            Menu.ReloadStash()

        end

    end

    local stashItemsHolder = vgui.Create("DScrollPanel", stashHolder)
    stashItemsHolder:SetPos(0, EFGM.MenuScale(32))
    stashItemsHolder:SetSize(EFGM.MenuScale(593), EFGM.MenuScale(872))
    function stashItemsHolder:Paint(w, h)

        BlurPanel(stashItemsHolder, EFGM.MenuScale(3))

        surface.SetDrawColor(Colors.containerBackgroundColor)
        surface.DrawRect(0, 0, w, h)

        surface.SetDrawColor(Colors.whiteBorderColor)
        surface.DrawRect(0, 0, w, EFGM.MenuScale(1))
        surface.DrawRect(0, h - 1, w, EFGM.MenuScale(1))
        surface.DrawRect(0, 0, EFGM.MenuScale(1), h)
        surface.DrawRect(w - 1, 0, EFGM.MenuScale(1), h)

    end

    function stashItemsHolder:OnVScroll(offset)

        self.pnlCanvas:SetPos(0, offset)
        if !IsValid(contextMenu) then return end
        contextMenu:AlphaTo(0, 0.1, 0, function() contextMenu:Remove() hook.Remove("Think", "CheckIfContextMenuStillFocused") end)

    end

    stashItemsHolder:Receiver("items", function(self, panels, dropped, _, x, y)

        if !dropped then return end

        if panels[1].ORIGIN == "inventory" then

            surface.PlaySound("ui/inv_item_tostash_" .. math.random(1, 7) .. ".wav")

            StashItemFromInventory(panels[1].ID)

        end

        if panels[1].ORIGIN == "equipped" then

            surface.PlaySound("ui/equip_" .. math.random(1, 6) .. ".wav")

            StashItemFromEquipped(panels[1].SLOTID, panels[1].SLOT)

        end

    end)

    stashItems = vgui.Create("DIconLayout", stashItemsHolder)
    stashItems:Dock(TOP)
    stashItems:SetSpaceY(0)
    stashItems:SetSpaceX(0)

    local stashItemsBar = stashItemsHolder:GetVBar()
    stashItemsBar:SetHideButtons(true)
    stashItemsBar:SetSize(EFGM.MenuScale(15), EFGM.MenuScale(15))
    function stashItemsBar:Paint(w, h)
        draw.RoundedBox(0, EFGM.MenuScale(5), EFGM.MenuScale(8), EFGM.MenuScale(5), h - EFGM.MenuScale(16), Colors.scrollerColor)
    end
    function stashItemsBar.btnGrip:Paint(w, h)
        draw.RoundedBox(0, EFGM.MenuScale(5), EFGM.MenuScale(8), EFGM.MenuScale(5), h - EFGM.MenuScale(16), Colors.transparentWhiteColor)
    end

    Menu.ReloadStash(true)

end

function Menu.OpenTab.Market()

    local contents = vgui.Create("DPanel", Menu.MenuFrame.LowerPanel)
    contents:Dock(FILL)
    contents:DockPadding(EFGM.MenuScale(10), EFGM.MenuScale(10), EFGM.MenuScale(10), EFGM.MenuScale(10))
    contents:SetAlpha(0)
    contents.Paint = nil

    Menu.MenuFrame.LowerPanel.Contents = contents

    local marketStashPanel = vgui.Create("DPanel", contents)
    marketStashPanel:Dock(LEFT)
    marketStashPanel:DockMargin(EFGM.MenuScale(13), 0, 0, 0)
    marketStashPanel:SetSize(EFGM.MenuScale(613), 0)
    marketStashPanel.Paint = function(s, w, h)

        BlurPanel(s, EFGM.MenuScale(10))

        surface.SetDrawColor(Colors.containerBackgroundColor)
        surface.DrawRect(0, 0, w, h)

        surface.SetDrawColor(Colors.transparentWhiteColor)
        surface.DrawRect(0, 0, w, EFGM.MenuScale(6))

    end

    local maxStash = Menu.Player:GetNWInt("StashMax", 0)
    local marketStashText = vgui.Create("DPanel", marketStashPanel)
    marketStashText:Dock(TOP)
    marketStashText:SetSize(0, EFGM.MenuScale(36))
    function marketStashText:Paint(w, h)

        surface.SetDrawColor(Colors.containerHeaderColor)
        surface.DrawRect(0, 0, w, h)

        draw.SimpleTextOutlined("STASH", "PuristaBold32", EFGM.MenuScale(5), EFGM.MenuScale(2), Colors.whiteColor, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP, 1, Colors.blackColor)
        draw.SimpleTextOutlined(Menu.Player:GetNWInt("StashCount", 0) .. "/" .. maxStash, "PuristaBold18", EFGM.MenuScale(95), EFGM.MenuScale(13), Colors.whiteColor, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP, 1, Colors.blackColor)

    end

    marketStashHolder = vgui.Create("DPanel", marketStashPanel)
    marketStashHolder:Dock(FILL)
    marketStashHolder:DockMargin(EFGM.MenuScale(10), EFGM.MenuScale(10), EFGM.MenuScale(10), EFGM.MenuScale(9))
    marketStashHolder:SetSize(0, 0)
    marketStashHolder.Paint = nil

    local marketStashInfoText = vgui.Create("DPanel", marketStashHolder)
    marketStashInfoText:Dock(TOP)
    marketStashInfoText:SetSize(0, EFGM.MenuScale(28))
    surface.SetFont("PuristaBold24")
    stashValue = 0
    local valueText = "EST. VALUE: ₽" .. comma_value(stashValue)
    local valueTextSize = surface.GetTextSize(valueText)
    marketStashInfoText.Paint = function(s, w, h)

        surface.SetFont("PuristaBold24")
        valueText = "EST. VALUE: ₽" .. comma_value(stashValue)
        valueTextSize = surface.GetTextSize(valueText)

        BlurPanel(s, EFGM.MenuScale(3))

        surface.SetDrawColor(Colors.containerBackgroundColor)
        surface.DrawRect(0, 0, valueTextSize + EFGM.MenuScale(10), h)

        surface.SetDrawColor(Colors.transparentWhiteColor)
        surface.DrawRect(0, 0, valueTextSize + EFGM.MenuScale(10), EFGM.MenuScale(2))

        draw.SimpleTextOutlined(valueText, "PuristaBold24", EFGM.MenuScale(5), EFGM.MenuScale(2), Colors.whiteColor, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP, 1, Colors.blackColor)

    end

    surface.SetFont("PuristaBold24")
    local marketStashSearchText = "SEARCH"
    local marketStashSearchTextSize = surface.GetTextSize(marketStashSearchText)
    local marketStashSearchButtonSize = marketStashSearchTextSize + EFGM.MenuScale(10)

    local marketStashSearchButton = vgui.Create("DButton", marketStashHolder)
    marketStashSearchButton:SetPos(EFGM.MenuScale(15) + valueTextSize, 0)
    marketStashSearchButton:SetSize(marketStashSearchButtonSize, EFGM.MenuScale(28))
    marketStashSearchButton:SetText("")
    marketStashSearchButton.Paint = function(s, w, h)

        marketStashSearchButton:SetX(EFGM.MenuScale(15) + valueTextSize)

        surface.SetDrawColor(Colors.containerBackgroundColor)
        surface.DrawRect(0, 0, marketStashSearchTextSize + EFGM.MenuScale(10), h)

        surface.SetDrawColor(Colors.transparentWhiteColor)
        surface.DrawRect(0, 0, marketStashSearchTextSize + EFGM.MenuScale(10), EFGM.MenuScale(2))

        draw.SimpleTextOutlined(marketStashSearchText, "PuristaBold24", w / 2, EFGM.MenuScale(2), Colors.whiteColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 1, Colors.blackColor)

    end

    marketStashSearchOpen = false
    marketStashItemSearchText = ""

    marketStashSearchBox = vgui.Create("DTextEntry", marketStashHolder)
    marketStashSearchBox:SetSize(EFGM.MenuScale(593) - marketStashSearchButton:GetX() - marketStashSearchButton:GetWide(), EFGM.MenuScale(28))
    marketStashSearchBox:SetPos(marketStashSearchButton:GetX() + marketStashSearchButtonSize, 0)
    marketStashSearchBox:SetPlaceholderText("search...")
    marketStashSearchBox:SetUpdateOnType(true)
    marketStashSearchBox:SetTextColor(Colors.whiteColor)
    marketStashSearchBox:SetCursorColor(Colors.whiteColor)
    marketStashSearchBox:SetAlpha(0)
    marketStashSearchBox:SetEditable(false)

    function marketStashSearchBox:AllowInput(char)

        if char == "[" or char == "]" then return true end

    end

    marketStashSearchBox.Think = function(s)

        marketStashSearchBox:SetWide(EFGM.MenuScale(593) - marketStashSearchButton:GetX() - marketStashSearchButton:GetWide())
        marketStashSearchBox:SetX(marketStashSearchButton:GetX() + marketStashSearchButtonSize)

    end

    marketStashSearchBox.OnChange = function(self)

        local value = self:GetValue():lower()

        if value:match("^%s+") then

            self:SetText(value:match("^%s*(.-)$"))
            return

        end

        if !GetConVar("efgm_menu_search_automatic"):GetBool() then return end

        marketStashItemSearchText = value
        Menu.ReloadStash()

    end

    marketStashSearchBox.OnEnter = function(self)

        if GetConVar("efgm_menu_search_automatic"):GetBool() then return end
        marketStashItemSearchText = self:GetValue():lower()
        Menu.ReloadStash()

    end

    marketStashSearchButton.OnCursorEntered = function(s)

        surface.PlaySound("ui/element_hover_" .. math.random(1, 3) .. ".wav")

    end

    function marketStashSearchButton:DoClick()

        surface.PlaySound("ui/element_select.wav")

        if marketStashSearchOpen == false then

            marketStashSearchBox:AlphaTo(255, 0.1, 0)
            marketStashSearchBox:SetEditable(true)
            marketStashSearchBox:RequestFocus()
            marketStashSearchOpen = true

        else

            marketStashSearchBox:AlphaTo(0, 0.1, 0)
            marketStashSearchBox:SetEditable(false)
            marketStashSearchBox:SetValue("")
            marketStashItemSearchText = ""
            marketStashSearchOpen = false
            Menu.ReloadStash()

        end

    end

    local marketStashItemsHolder = vgui.Create("DScrollPanel", marketStashHolder)
    marketStashItemsHolder:SetPos(0, EFGM.MenuScale(32))
    marketStashItemsHolder:SetSize(EFGM.MenuScale(593), EFGM.MenuScale(872))
    function marketStashItemsHolder:Paint(w, h)

        BlurPanel(marketStashItemsHolder, EFGM.MenuScale(3))

        surface.SetDrawColor(Colors.containerBackgroundColor)
        surface.DrawRect(0, 0, w, h)

        surface.SetDrawColor(Colors.whiteBorderColor)
        surface.DrawRect(0, 0, w, EFGM.MenuScale(1))
        surface.DrawRect(0, h - 1, w, EFGM.MenuScale(1))
        surface.DrawRect(0, 0, EFGM.MenuScale(1), h)
        surface.DrawRect(w - 1, 0, EFGM.MenuScale(1), h)

    end

    function marketStashItemsHolder:OnVScroll(offset)

        self.pnlCanvas:SetPos(0, offset)
        if !IsValid(contextMenu) then return end
        contextMenu:AlphaTo(0, 0.1, 0, function() contextMenu:Remove() hook.Remove("Think", "CheckIfContextMenuStillFocused") end)

    end

    marketStashItems = vgui.Create("DIconLayout", marketStashItemsHolder)
    marketStashItems:Dock(TOP)
    marketStashItems:SetSpaceY(0)
    marketStashItems:SetSpaceX(0)

    local marketStashItemsBar = marketStashItemsHolder:GetVBar()
    marketStashItemsBar:SetHideButtons(true)
    marketStashItemsBar:SetSize(EFGM.MenuScale(15), EFGM.MenuScale(15))
    function marketStashItemsBar:Paint(w, h)
        draw.RoundedBox(0, EFGM.MenuScale(5), EFGM.MenuScale(8), EFGM.MenuScale(5), h - EFGM.MenuScale(16), Colors.scrollerColor)
    end
    function marketStashItemsBar.btnGrip:Paint(w, h)
        draw.RoundedBox(0, EFGM.MenuScale(5), EFGM.MenuScale(8), EFGM.MenuScale(5), h - EFGM.MenuScale(16), Colors.transparentWhiteColor)
    end

    Menu.ReloadMarketStash()

    local marketPanel = vgui.Create("DPanel", contents)
    marketPanel:Dock(LEFT)
    marketPanel:DockMargin(EFGM.MenuScale(13), 0, 0, 0)
    marketPanel:SetSize(EFGM.MenuScale(1239), 0)
    marketPanel.Paint = function(s, w, h)

        BlurPanel(s, EFGM.MenuScale(10))

        surface.SetDrawColor(Colors.containerBackgroundColor)
        surface.DrawRect(0, 0, w, h)

        surface.SetDrawColor(Colors.transparentWhiteColor)
        surface.DrawRect(0, 0, w, EFGM.MenuScale(6))

    end

    local marketText = vgui.Create("DPanel", marketPanel)
    marketText:Dock(TOP)
    marketText:SetSize(0, EFGM.MenuScale(36))
    function marketText:Paint(w, h)

        surface.SetDrawColor(Colors.containerHeaderColor)
        surface.DrawRect(0, 0, w, h)

        draw.SimpleTextOutlined("MARKET", "PuristaBold32", EFGM.MenuScale(5), EFGM.MenuScale(2), Colors.whiteColor, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP, 1, Colors.blackColor)

    end

    local marketHolder = vgui.Create("DPanel", marketPanel)
    marketHolder:Dock(FILL)
    marketHolder:DockMargin(EFGM.MenuScale(10), EFGM.MenuScale(10), EFGM.MenuScale(10), EFGM.MenuScale(9))
    marketHolder:SetSize(0, 0)
    marketHolder.Paint = nil

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

        surface.SetDrawColor(Colors.containerBackgroundColor)
        surface.DrawRect(0, 0, pageTextSize + EFGM.MenuScale(54), h)

        surface.SetDrawColor(Colors.transparentWhiteColor)
        surface.DrawRect(0, 0, pageTextSize + EFGM.MenuScale(54), EFGM.MenuScale(2))

        draw.SimpleTextOutlined(pageText, "PuristaBold24", EFGM.MenuScale(26), EFGM.MenuScale(2), Colors.whiteColor, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP, 1, Colors.blackColor)

    end

    local lastPageButton = vgui.Create("DButton", marketPageText)
    lastPageButton:SetPos(0, EFGM.MenuScale(2))
    lastPageButton:SetSize(EFGM.MenuScale(26), EFGM.MenuScale(26))
    lastPageButton:SetText("")
    lastPageButton.Paint = function(s, w, h)

        surface.SetDrawColor(Colors.pureWhiteColor)
        surface.SetMaterial(Mats.arrowBackIcon)
        surface.DrawTexturedRect(EFGM.MenuScale(3), EFGM.MenuScale(3), EFGM.MenuScale(20), EFGM.MenuScale(20))

    end

    lastPageButton.OnCursorEntered = function(s)

        surface.PlaySound("ui/element_hover_" .. math.random(1, 3) .. ".wav")

    end

    local nextPageButton = vgui.Create("DButton", marketPageText)
    nextPageButton:SetPos(pageTextSize + EFGM.MenuScale(29), EFGM.MenuScale(2))
    nextPageButton:SetSize(EFGM.MenuScale(26), EFGM.MenuScale(26))
    nextPageButton:SetText("")
    nextPageButton.Paint = function(s, w, h)

        s:SetX(pageTextSize + EFGM.MenuScale(29))
        surface.SetDrawColor(Colors.pureWhiteColor)
        surface.SetMaterial(Mats.arrowForwardIcon)
        surface.DrawTexturedRect(EFGM.MenuScale(3), EFGM.MenuScale(3), EFGM.MenuScale(20), EFGM.MenuScale(20))

    end

    nextPageButton.OnCursorEntered = function(s)

        surface.PlaySound("ui/element_hover_" .. math.random(1, 3) .. ".wav")

    end

    local marketEntryHolder = vgui.Create("DPanel", marketHolder)
    marketEntryHolder:SetPos(0, EFGM.MenuScale(32))
    marketEntryHolder:SetSize(EFGM.MenuScale(1219), EFGM.MenuScale(872))
    function marketEntryHolder:Paint(w, h)

        BlurPanel(marketEntryHolder, EFGM.MenuScale(3))

        surface.SetDrawColor(Colors.containerBackgroundColor)
        surface.DrawRect(0, 0, w, h)

        surface.SetDrawColor(Colors.whiteBorderColor)
        surface.DrawRect(0, 0, w, EFGM.MenuScale(1))
        surface.DrawRect(0, h - 1, w, EFGM.MenuScale(1))
        surface.DrawRect(0, 0, EFGM.MenuScale(1), h)
        surface.DrawRect(w - 1, 0, EFGM.MenuScale(1), h)

    end

    local marketTab = "All Items"
    local marketSearchText = ""

    local marketCategoryHolder = vgui.Create("DPanel", marketEntryHolder)
    marketCategoryHolder:SetPos(0, 0)
    marketCategoryHolder:SetSize(EFGM.MenuScale(216), EFGM.MenuScale(872))
    marketCategoryHolder:DockPadding(EFGM.MenuScale(5), EFGM.MenuScale(5), EFGM.MenuScale(5), EFGM.MenuScale(5))

    function marketCategoryHolder:Paint(w, h)

        surface.SetDrawColor(Colors.containerBackgroundColor)
        surface.DrawRect(0, 0, w, h)

        surface.SetDrawColor(Colors.whiteBorderColor)
        surface.DrawRect(w - 1, 0, 1, h)

    end

    local marketSearchBox = vgui.Create("DTextEntry", marketCategoryHolder)
    marketSearchBox:Dock(TOP)
    marketSearchBox:DockMargin(0, 0, 0, EFGM.MenuScale(5))
    marketSearchBox:SetPlaceholderText("search for items...")
    marketSearchBox:SetUpdateOnType(true)
    marketSearchBox:SetTextColor(Colors.whiteColor)
    marketSearchBox:SetCursorColor(Colors.whiteColor)

    function marketSearchBox:AllowInput(char)

        if char == "[" or char == "]" then return true end

    end

    local sortBy = "name"
    local marketSortByButton = vgui.Create("DButton", marketCategoryHolder)
    marketSortByButton:Dock(TOP)
    marketSortByButton:SetSize(0, EFGM.MenuScale(20))
    marketSortByButton:DockMargin(0, 0, 0, EFGM.MenuScale(5))
    marketSortByButton:SetText("SORT BY NAME")

    marketSortByButton.OnCursorEntered = function(s)

        surface.PlaySound("ui/element_hover_" .. math.random(1, 3) .. ".wav")

    end

    local sortWith = "ascending"
    local marketSortWithButton = vgui.Create("DButton", marketCategoryHolder)
    marketSortWithButton:Dock(TOP)
    marketSortWithButton:SetSize(0, EFGM.MenuScale(20))
    marketSortWithButton:DockMargin(0, 0, 0, EFGM.MenuScale(5))
    marketSortWithButton:SetText("ASCENDING ORDER")

    marketSortWithButton.OnCursorEntered = function(s)

        surface.PlaySound("ui/element_hover_" .. math.random(1, 3) .. ".wav")

    end

    local showBasedOnLevel = "all"
    local marketShowUnlockButton = vgui.Create("DButton", marketCategoryHolder)
    marketShowUnlockButton:Dock(TOP)
    marketShowUnlockButton:SetSize(0, EFGM.MenuScale(20))
    marketShowUnlockButton:DockMargin(0, 0, 0, EFGM.MenuScale(5))
    marketShowUnlockButton:SetText("SHOW EVERYTHING")

    marketShowUnlockButton.OnCursorEntered = function(s)

        surface.PlaySound("ui/element_hover_" .. math.random(1, 3) .. ".wav")

    end

    local marketCategoryEntryList = vgui.Create("DCategoryList", marketCategoryHolder)
    marketCategoryEntryList:Dock(FILL)
    marketCategoryEntryList:SetBackgroundColor(Colors.transparent)
    marketCategoryEntryList:GetVBar():SetSize(0, 0)

    local categoryBar = marketCategoryEntryList:GetVBar()
    categoryBar:SetHideButtons(true)
    categoryBar:SetSize(EFGM.MenuScale(15), EFGM.MenuScale(15))
    function categoryBar:Paint(w, h)
        draw.RoundedBox(0, EFGM.MenuScale(5), EFGM.MenuScale(8), EFGM.MenuScale(5), h - EFGM.MenuScale(16), Colors.scrollerColor)
    end
    function categoryBar.btnGrip:Paint(w, h)
        draw.RoundedBox(0, EFGM.MenuScale(5), EFGM.MenuScale(8), EFGM.MenuScale(5), h - EFGM.MenuScale(16), Colors.transparentWhiteColor)
    end

    -- market categories
    -- will load items based on the items "displayType" in it's item def.
    MarketCat = {}

    MarketCat.AAFAVORITE = {

        name = "★ Favorite Items",
        items = {"Assault Carbine", "Assault Rifle", "Light Machine Gun", "Pistol", "Shotgun", "Sniper Rifle", "Marksman Rifle", "Submachine Gun", "Launcher", "Melee", "Grenade", "Special", "Ammunition", "Accessory", "Barrel", "Cover", "Foregrip", "Gas Block", "Handguard", "Magazine", "Mount", "Muzzle", "Optic", "Pistol Grip", "Receiver", "Sight", "Stock", "Tactical", "Medical", "Belmont Key", "Concrete Key", "Factory Key", "Barter", "Building", "Electronic", "Energy", "Flammable", "Household", "Information", "Medicine", "Other", "Tool", "Valuable"},

        children = {}

    }

    MarketCat._ALLITEMS = {

        name = "All Items",
        items = {"Assault Carbine", "Assault Rifle", "Light Machine Gun", "Pistol", "Shotgun", "Sniper Rifle", "Marksman Rifle", "Submachine Gun", "Launcher", "Melee", "Grenade", "Special", "Ammunition", "Accessory", "Barrel", "Cover", "Foregrip", "Gas Block", "Handguard", "Magazine", "Mount", "Muzzle", "Optic", "Pistol Grip", "Receiver", "Sight", "Stock", "Tactical", "Medical", "Belmont Key", "Concrete Key", "Factory Key", "Barter", "Building", "Electronic", "Energy", "Flammable", "Household", "Information", "Medicine", "Other", "Tool", "Valuable"},

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
        items = {"Belmont Key", "Concrete Key", "Factory Key"},

        children = {

            ["Belmont"] = "Belmont Key",
            ["Concrete"] = "Concrete Key",
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

    local marketTbl = {}

    local marketItemHolder = vgui.Create("DPanel", marketEntryHolder)
    marketItemHolder:SetPos(EFGM.MenuScale(216), 0)
    marketItemHolder:SetSize(EFGM.MenuScale(1003), EFGM.MenuScale(872))
    marketItemHolder:DockPadding(EFGM.MenuScale(5), EFGM.MenuScale(5), EFGM.MenuScale(5), EFGM.MenuScale(5))
    marketItemHolder.Paint = nil

    local marketItems = vgui.Create("DIconLayout", marketItemHolder)
    marketItems:Dock(TOP)
    marketItems:SetSpaceY(0)
    marketItems:SetSpaceX(0)

    local function ReloadMarket()

        marketItems:Clear()

        for k, v in ipairs(marketTbl) do

            if k >= ((currentPage * 20) - 19) and k <= (currentPage * 20) then

                local item = marketItems:Add("DButton")
                item:SetText("")
                item:SetSize(EFGM.MenuScale(198.5), EFGM.MenuScale(215.5))

                function item:Paint(w, h)

                    surface.SetDrawColor(Colors.itemColor)
                    surface.DrawRect(0, 0, w, h)

                    if !self:IsHovered() then surface.SetDrawColor(Colors.itemBackgroundColor) else surface.SetDrawColor(Colors.itemBackgroundColorHovered) end

                    surface.DrawRect(0, 0, w, EFGM.MenuScale(1))
                    surface.DrawRect(0, h - 1, w, EFGM.MenuScale(1))
                    surface.DrawRect(0, 0, EFGM.MenuScale(1), h)
                    surface.DrawRect(w - 1, 0, EFGM.MenuScale(1), h)

                    surface.SetDrawColor(Colors.pureWhiteColor)
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

                surface.SetFont("PuristaBold18")
                local levelText = "LEVEL " .. v.level
                local levelTextSize = surface.GetTextSize(levelText)

                local caliberText = v.caliber or ""
                local caliberTextSize = surface.GetTextSize(caliberText)

                local value = v.value

                local plyLevel = Menu.Player:GetNWInt("Level", 1)

                function item:PaintOver(w, h)

                    if marketLimits[v.id] != 0 then surface.SetDrawColor(Colors.transparentBlackColor) else surface.SetDrawColor(Colors.marketItemOutOfStockColor) end
                    surface.DrawRect(EFGM.MenuScale(1), h - EFGM.MenuScale(31), w - EFGM.MenuScale(2), EFGM.MenuScale(30))

                    local countText
                    surface.SetFont("PuristaBold18")
                    if v.consumableValue then countText = v.consumableValue .. "/" .. v.consumableValue else countText = v.stack .. "x" end
                    if marketLimits[v.id] then

                        if !v.consumableValue then countText = marketLimits[v.id] .. "x" else countText = marketLimits[v.id] .. "x" .. " " .. v.consumableValue .. "/" .. v.consumableValue end

                    end
                    local countTextSize = surface.GetTextSize(countText)
                    if marketLimits[v.id] then countTextSize = countTextSize + EFGM.MenuScale(10) end

                    surface.SetFont("PuristaBold22")
                    local itemValueText
                    if marketLimits[v.id] != 0 then itemValueText = comma_value(value) else itemValueText = "SOLD OUT" end
                    local itemValueTextSize = surface.GetTextSize(itemValueText)

                    if v.canPurchase then

                        surface.SetDrawColor(Colors.marketItemValueColor)
                        surface.DrawRect(w - countTextSize - EFGM.MenuScale(11), h - EFGM.MenuScale(46), countTextSize + EFGM.MenuScale(10), EFGM.MenuScale(15))
                        surface.DrawRect(EFGM.MenuScale(1), EFGM.MenuScale(17), levelTextSize + EFGM.MenuScale(8), EFGM.MenuScale(15))

                        draw.SimpleTextOutlined(countText, "PuristaBold18", w - EFGM.MenuScale(5), h - EFGM.MenuScale(49), Colors.whiteColor, TEXT_ALIGN_RIGHT, TEXT_ALIGN_TOP, 1, Colors.blackColor)
                        draw.SimpleTextOutlined(levelText, "PuristaBold18", EFGM.MenuScale(5), EFGM.MenuScale(14), Colors.whiteColor, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP, 1, Colors.blackColor)

                    end

                    if v.caliber then

                        surface.SetDrawColor(Colors.marketItemValueColor)
                        surface.DrawRect(EFGM.MenuScale(1), h - EFGM.MenuScale(46), caliberTextSize + EFGM.MenuScale(10), EFGM.MenuScale(15))
                        draw.SimpleTextOutlined(caliberText, "PuristaBold18", EFGM.MenuScale(5), h - EFGM.MenuScale(49), Colors.whiteColor, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP, 1, Colors.blackColor)

                    end

                    draw.SimpleTextOutlined(v.name, "PuristaBold18", EFGM.MenuScale(5), 0, Colors.whiteColor, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP, 1, Colors.blackColor)
                    draw.SimpleTextOutlined(itemValueText, "PuristaBold22", (w / 2) + EFGM.MenuScale(12), h - EFGM.MenuScale(29), Colors.whiteColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 1, Colors.blackColor)

                    if EFGM.Favorites[v.id] then

                        surface.SetDrawColor(Colors.pureWhiteColor)
                        surface.SetMaterial(Mats.favoriteIcon)
                        surface.DrawTexturedRect(w - EFGM.MenuScale(31), EFGM.MenuScale(1), EFGM.MenuScale(30), EFGM.MenuScale(30))

                    end

                    if marketLimits[v.id] then

                        surface.SetDrawColor(Colors.pureWhiteColor)
                        surface.SetMaterial(Mats.restartIcon)
                        surface.DrawTexturedRect(w - countTextSize - EFGM.MenuScale(11), h - EFGM.MenuScale(47), EFGM.MenuScale(16), EFGM.MenuScale(16))

                    end

                    surface.SetDrawColor(Colors.pureWhiteColor)

                    if !v.canPurchase then surface.SetMaterial(Mats.sellIcon) else

                        if plyLevel < v.level then surface.SetMaterial(Mats.lockIcon) else surface.SetMaterial(Mats.roubleIcon) end
                        if marketLimits[v.id] == 0 then surface.SetMaterial(Mats.noStockIcon) end

                    end

                    surface.DrawTexturedRect((w / 2) - EFGM.MenuScale(12) - (itemValueTextSize / 2), h - EFGM.MenuScale(27), EFGM.MenuScale(20), EFGM.MenuScale(20))

                end

                item.OnCursorEntered = function(s)

                    surface.PlaySound("ui/inv_item_hover_" .. math.random(1, 3) .. ".wav")

                end

                function item:DoClick()

                    if !v.canPurchase then return end
                    Menu.ConfirmPurchase(v.id, nil, false)

                end

                function item:DoRightClick()

                    local x, y = marketItemHolder:LocalCursorPos()
                    local sideH, sideV

                    surface.PlaySound("ui/context.wav")

                    if x <= (marketItemHolder:GetWide() / 2) then sideH = true else sideH = false end
                    if y <= (marketItemHolder:GetTall() / 2) then sideV = true else sideV = false end

                    if IsValid(contextMenu) then contextMenu:Remove() end
                    contextMenu = vgui.Create("EFGMContextMenu", marketItemHolder)
                    contextMenu:SetSize(EFGM.MenuScale(100), EFGM.MenuScale(10))
                    contextMenu:DockPadding(EFGM.MenuScale(5), EFGM.MenuScale(5), EFGM.MenuScale(5), EFGM.MenuScale(5))
                    contextMenu:SetAlpha(0)
                    contextMenu:AlphaTo(255, 0.1, 0, nil)
                    contextMenu:RequestFocus()

                    local inspectButton = vgui.Create("EFGMContextButton", contextMenu)
                    inspectButton:SetText("INSPECT")
                    inspectButton.OnClickEvent = function()

                        local data = {
                            att = v.defAtts
                        }
                        Menu.InspectItem(v.id, data)

                    end

                    local favoriteButton = vgui.Create("EFGMContextButton", contextMenu)
                    favoriteButton:SetText("FAVORITE")
                    favoriteButton.OnClickSound = "nil"
                    favoriteButton.OnClickEvent = function()

                        EFGM:ToggleFavorite(v.id)

                    end

                    favoriteButton.Think = function(s)

                        favoriteButton:SetText((EFGM.Favorites[v.id] and "UNFAVORITE") or "FAVORITE")

                    end

                    if v.canPurchase and plyLevel >= v.level and marketLimits[v.id] != 0 then

                        local buyButton = vgui.Create("EFGMContextButton", contextMenu)
                        buyButton:SetText("BUY")
                        buyButton.OnClickSound = "nil"
                        buyButton.OnClickEvent = function()

                            Menu.ConfirmPurchase(v.id, nil, false)

                        end

                    end

                    contextMenu:SetTallAfterCTX()

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

    local curItems = MarketCat._ALLITEMS.items
    local function UpdateMarketList(items)

        if items == nil then items = curItems end

        local plyLevel = Menu.Player:GetNWInt("Level", 1)

        marketTbl = {}
        local numOfItems = 0
        currentPage = 1
        totalPages = 0
        curItems = items

        for k1, v1 in ipairs(items) do

            for k2, v2 in pairs(EFGMITEMS) do

                if marketSearchText != "" and !(string.find((v2.fullName and v2.fullName or v2.displayName):lower(), marketSearchText) or string.find((k2):lower(), marketSearchText)) then continue end
                if showBasedOnLevel == "unlocked" and plyLevel < (v2.levelReq or 1) then continue end
                if showBasedOnLevel == "unlocked" and !(v2.canPurchase or v2.canPurchase == nil) then continue end

                if marketTab == "★ Favorite Items" and !EFGM.Favorites[k2] then continue end

                if v2.displayType == v1 then

                    numOfItems = numOfItems + 1

                    local purchasable
                    if v2.canPurchase or v2.canPurchase == nil then purchasable = true else purchasable = false end

                    local entry = {}
                    entry.name = v2.displayName
                    entry.fullName = v2.fullName
                    entry.displayType = v2.displayType
                    entry.id = k2
                    entry.icon = v2.icon
                    entry.value = v2.value or 1000
                    entry.weight = v2.weight or 0.1
                    entry.level = v2.levelReq or 1
                    entry.equipType = v2.equipType
                    entry.consumableValue = v2.consumableValue
                    entry.stack = v2.stackSize
                    entry.sizeX = v2.sizeX or 1
                    entry.sizeY = v2.sizeY or 1
                    entry.defAtts = v2.defAtts
                    entry.caliber = v2.caliber
                    entry.canPurchase = purchasable

                    if EFGM.Favorites[k2] then entry.sortWeight = 9999 else entry.sortWeight = 0 end

                    if entry.equipType == EQUIPTYPE.Weapon and entry.defAtts then

                        local atts = GetPrefixedAttachmentListFromCode(entry.defAtts)
                        if !atts then return end

                        for _, a in ipairs(atts) do

                            local att = EFGMITEMS[a]
                            if att == nil then continue end

                            entry.value = entry.value + att.value
                            entry.weight = entry.weight + att.weight

                        end

                    end

                    table.insert(marketTbl, entry)

                end

            end

        end

        if sortBy == "name" then

            if sortWith == "ascending" then

                table.sort(marketTbl, function(a, b)

                    if a.sortWeight != b.sortWeight then

                        return a.sortWeight > b.sortWeight

                    elseif a.name != b.name then

                        return a.name < b.name

                    end

                end)

            else

                table.sort(marketTbl, function(a, b)

                    if a.sortWeight != b.sortWeight then

                        return a.sortWeight > b.sortWeight

                    elseif a.name != b.name then

                        return a.name > b.name

                    end

                end)

            end

        elseif sortBy == "value" then

            if sortWith == "ascending" then

                table.sort(marketTbl, function(a, b)

                    if a.sortWeight != b.sortWeight then

                        return a.sortWeight > b.sortWeight

                    elseif a.value != b.value then

                        return a.value < b.value

                    end

                end)

            else

                table.sort(marketTbl, function(a, b)

                    if a.sortWeight != b.sortWeight then

                        return a.sortWeight > b.sortWeight

                    elseif a.value != b.value then

                        return a.value > b.value

                    end

                end)

            end

        elseif sortBy == "level" then

            if sortWith == "ascending" then

                table.sort(marketTbl, function(a, b)

                    if a.sortWeight != b.sortWeight then

                        return a.sortWeight > b.sortWeight

                    elseif a.level != b.level then

                        return a.level < b.level

                    end

                end)

            else

                table.sort(marketTbl, function(a, b)

                    if a.sortWeight != b.sortWeight then

                        return a.sortWeight > b.sortWeight

                    elseif a.level != b.level then

                        return a.level > b.level

                    end

                end)

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

        local value = self:GetValue():lower()

        if value:match("^%s+") then

            self:SetText(value:match("^%s*(.-)$"))
            return

        end

        if !GetConVar("efgm_menu_search_automatic"):GetBool() then return end

        marketSearchText = value
        UpdateMarketList()

    end

    marketSearchBox.OnEnter = function(self)

        if GetConVar("efgm_menu_search_automatic"):GetBool() then return end
        marketSearchText = self:GetValue():lower()
        UpdateMarketList()

    end

    function marketSortByButton:DoClick()

        surface.PlaySound("ui/element_select.wav")

        if sortBy == "name" then

            sortBy = "value"
            marketSortByButton:SetText("SORT BY VALUE")

        elseif sortBy == "value" then

            sortBy = "level"
            marketSortByButton:SetText("SORT BY LEVEL")

        elseif sortBy == "level" then

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
    UpdateMarketList(MarketCat._ALLITEMS.items)

    for k1, v1 in SortedPairs(MarketCat) do

        local category = marketCategoryEntryList:Add(string.upper(v1.name))
        category:SetExpanded(true)
        category:SetHeaderHeight(EFGM.MenuScale(30))

        if v1.name == "Weapons" then category:SetExpanded(true) end

        function category:OnCursorEntered()

            surface.PlaySound("ui/element_hover_" .. math.random(1, 3) .. ".wav")

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
    contents.Paint = nil

    Menu.MenuFrame.LowerPanel.Contents = contents

    local mainEntryList = vgui.Create("DCategoryList", contents)
    mainEntryList:Dock(LEFT)
    mainEntryList:SetSize(EFGM.MenuScale(180), 0)
    mainEntryList:SetBackgroundColor(Colors.transparent)
    mainEntryList:GetVBar():SetSize(0, 0)

    local entryBar = mainEntryList:GetVBar()
    entryBar:SetHideButtons(true)
    entryBar:SetSize(EFGM.MenuScale(15), EFGM.MenuScale(15))
    function entryBar:Paint(w, h)
        draw.RoundedBox(0, EFGM.MenuScale(5), EFGM.MenuScale(8), EFGM.MenuScale(5), h - EFGM.MenuScale(16), Colors.scrollerColor)
    end
    function entryBar.btnGrip:Paint(w, h)
        draw.RoundedBox(0, EFGM.MenuScale(5), EFGM.MenuScale(8), EFGM.MenuScale(5), h - EFGM.MenuScale(16), Colors.transparentWhiteColor)
    end

    local subEntryPanel = vgui.Create("DPanel", contents)
    subEntryPanel:Dock(LEFT)
    subEntryPanel:SetSize(EFGM.MenuScale(180), 0)
    subEntryPanel:SetBackgroundColor(Colors.transparent)

    local subEntryList = vgui.Create("DIconLayout", subEntryPanel)
    subEntryList:Dock(LEFT)
    subEntryList:SetSize(EFGM.MenuScale(180), 0)
    subEntryList:SetSpaceY(EFGM.MenuScale(2))

    local entryPanel = vgui.Create("DPanel", contents)
    entryPanel:Dock(FILL)
    entryPanel.Paint = nil

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

                        surface.PlaySound("ui/element_hover_" .. math.random(1, 3) .. ".wav")

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
    contents.Paint = nil

    Menu.MenuFrame.LowerPanel.Contents = contents

    local pmcPanel = vgui.Create("DScrollPanel", contents)
    pmcPanel:Dock(LEFT)
    pmcPanel:SetSize(EFGM.MenuScale(320), 0)
    pmcPanel.Paint = nil

    if Menu.Player:CompareStatus(0) then

        local pmcTitle = vgui.Create("DPanel", pmcPanel)
        pmcTitle:Dock(TOP)
        pmcTitle:SetSize(0, EFGM.MenuScale(32))
        function pmcTitle:Paint(w, h)

            draw.SimpleTextOutlined("OPERATORS", "PuristaBold32", w / 2, 0, Colors.whiteColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 1, Colors.blackColor)

        end

        local pmcPanelBar = pmcPanel:GetVBar()
        pmcPanelBar:SetHideButtons(true)
        pmcPanelBar:SetSize(EFGM.MenuScale(15), EFGM.MenuScale(15))
        function pmcPanelBar:Paint(w, h)
            draw.RoundedBox(0, EFGM.MenuScale(5), EFGM.MenuScale(8), EFGM.MenuScale(5), h - EFGM.MenuScale(16), Colors.scrollerColor)
        end
        function pmcPanelBar.btnGrip:Paint(w, h)
            draw.RoundedBox(0, EFGM.MenuScale(5), EFGM.MenuScale(8), EFGM.MenuScale(5), h - EFGM.MenuScale(16), Colors.transparentWhiteColor)
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
            function pmcEntry:Paint(w, h)
                if !IsValid(v) then return end
                draw.SimpleTextOutlined(name, "Purista18", EFGM.MenuScale(50), EFGM.MenuScale(5), Colors.whiteColor, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP, 1, Colors.blackColor)
                draw.SimpleTextOutlined(ping  .. "ms", "Purista18", w - EFGM.MenuScale(5), EFGM.MenuScale(5), Colors.whiteColor, TEXT_ALIGN_RIGHT, TEXT_ALIGN_TOP, 1, Colors.blackColor)
                draw.SimpleTextOutlined(kills, "Purista18", EFGM.MenuScale(50), EFGM.MenuScale(25), Colors.inRaidColor, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP, 1, Colors.blackColor)
                draw.SimpleTextOutlined(deaths, "Purista18", EFGM.MenuScale(85), EFGM.MenuScale(25), Colors.deadColor, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP, 1, Colors.blackColor)
                if v:CompareStatus(1) or v:CompareStatus(2) then draw.SimpleTextOutlined("IN RAID", "Purista18", w - EFGM.MenuScale(5), EFGM.MenuScale(25), Colors.neutralColor, TEXT_ALIGN_RIGHT, TEXT_ALIGN_TOP, 1, Colors.blackColor) elseif v:CompareStatus(3) then draw.SimpleTextOutlined("IN DUEL", "Purista18", w - EFGM.MenuScale(5), EFGM.MenuScale(25), Colors.deadColor, TEXT_ALIGN_RIGHT, TEXT_ALIGN_TOP, 1, Colors.blackColor) end
            end

            local pmcPFP = vgui.Create("AvatarImage", pmcEntry)
            pmcPFP:SetPos(EFGM.MenuScale(5), EFGM.MenuScale(5))
            pmcPFP:SetSize(EFGM.MenuScale(40), EFGM.MenuScale(40))
            pmcPFP:SetPlayer(v, 184)

            pmcPFP.OnMousePressed = function()
                local dropdown = DermaMenu()

                local profile = dropdown:AddOption("Open Steam Profile", function() gui.OpenURL("http://steamcommunity.com/profiles/" .. v:SteamID64()) end)
                profile:SetIcon("games/16/all.png")
                local gameProfile = dropdown:AddOption("Open Game Profile", function() CreateNotification("I do not work yet LOL!", Mats.dontEvenAsk, "ui/boo.wav") end)
                gameProfile:SetIcon("icon16/chart_bar.png")

                if v != Menu.Player and status then

                    dropdown:AddSpacer()

                    local inviteToSquad = dropdown:AddOption("Invite To Squad", function() InvitePlayerToSquad(ply, v) end)
                    inviteToSquad:SetIcon("icon16/user_add.png")
                    local inviteToDuel = dropdown:AddOption("Invite To Duel", function() InvitePlayerToDuel(ply, v) end)
                    inviteToDuel:SetIcon("icon16/bomb.png")

                end

                dropdown:AddSpacer()

                dropdown:AddOption("Copy Name", function() SetClipboardText(v:GetName()) end):SetIcon("icon16/pencil_add.png")
                dropdown:AddOption("Copy SteamID64", function() SetClipboardText(v:SteamID64()) end):SetIcon("icon16/pencil_add.png")

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
    mapPanel.Paint = nil

    local mapTitle = vgui.Create("DPanel", mapPanel)
    mapTitle:Dock(TOP)
    mapTitle:SetSize(0, EFGM.MenuScale(40))
    function mapTitle:Paint(w, h)

        draw.SimpleTextOutlined("MAP", "PuristaBold32", w / 2, 0, Colors.whiteColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 1, Colors.blackColor)

    end

    local mapRawName = game.GetMap()
    local mapOverhead = Mats.curMapOverhad

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

        BlurPanel(self, EFGM.MenuScale(5))
        surface.SetDrawColor(Colors.containerBackgroundColor)
        surface.DrawRect(0, 0, w, h)

    end

    function mapHolder:PaintOver(w, h)

        surface.SetDrawColor(Colors.pureWhiteColor)
        surface.DrawRect(0, 0, w, EFGM.MenuScale(1))
        surface.DrawRect(0, h - 1, w, EFGM.MenuScale(1))
        surface.DrawRect(0, 0, EFGM.MenuScale(1), h)
        surface.DrawRect(w - 1, 0, EFGM.MenuScale(1), h)

    end


    local xDiff = EFGM.MenuScale(1210) / mapSizeX
    local yDiff = EFGM.MenuScale(1210) / mapSizeY

    local minZoom = math.max(xDiff, yDiff)

    if yDiff > xDiff and mapSizeX > mapSizeY then minZoom = math.min(xDiff, yDiff) end

    local map = vgui.Create("EFGMMap", mapHolder)
    map:SetSize(mapSizeX, mapSizeY)
    map:SetMouseInputEnabled(true)
    map:SetCursor("crosshair")
    map.Zoom = minZoom
    map.MinZoom = minZoom
    map.MaxZoom = 2.5
    map.MapHolderX, map.MapHolderY = mapHolder:GetSize()

    map.DrawRaidInfo = false
    map.DrawFullInfo = true

    map.MapSizeX = mapSizeX
    map.MapSizeY = mapSizeY

    map.MapInfo = MAPINFO[mapRawName]
    map.OverheadImage = mapOverhead

    map:ClampPanOffset()

    local mapName = MAPNAMES[mapRawName]
    surface.SetFont("PuristaBold50")
    local mapNameText = string.upper(mapName or "")
    local mapNameTextSize = surface.GetTextSize(mapNameText)

    local mapLegend = vgui.Create("DPanel", mapHolder)
    mapLegend:SetPos(mapHolder:GetWide() - math.max(mapNameTextSize + EFGM.MenuScale(30), EFGM.MenuScale(110)), EFGM.MenuScale(10))
    mapLegend:SetSize(math.max(mapNameTextSize + EFGM.MenuScale(20), EFGM.MenuScale(100)), EFGM.MenuScale(140))
    mapLegend.Paint = function(s, w, h)

        BlurPanel(s, EFGM.MenuScale(4))

        surface.SetDrawColor(Color(20, 20, 20, 155))
        surface.DrawRect(0, 0, w, h)

        surface.SetDrawColor(Colors.whiteBorderColor)
        surface.DrawRect(0, 0, w, EFGM.MenuScale(1))
        surface.DrawRect(0, h - 1, w, EFGM.MenuScale(1))
        surface.DrawRect(0, 0, EFGM.MenuScale(1), h)
        surface.DrawRect(w - 1, 0, EFGM.MenuScale(1), h)

        draw.SimpleTextOutlined(mapNameText, "PuristaBold50", w / 2, EFGM.MenuScale(-5), Colors.whiteColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 1, Colors.blackColor)

        draw.SimpleTextOutlined("LEGEND", "PuristaBold24", w - EFGM.MenuScale(10), EFGM.MenuScale(45), Colors.whiteColor, TEXT_ALIGN_RIGHT, TEXT_ALIGN_TOP, 1, Colors.blackColor)
        draw.SimpleTextOutlined("SPAWNS ■", "PuristaBold18", w - EFGM.MenuScale(10), EFGM.MenuScale(70), Colors.mapSpawn, TEXT_ALIGN_RIGHT, TEXT_ALIGN_TOP, 1, Colors.blackColor)
        draw.SimpleTextOutlined("EXTRACTS ■", "PuristaBold18", w - EFGM.MenuScale(10), EFGM.MenuScale(85), Colors.mapExtract, TEXT_ALIGN_RIGHT, TEXT_ALIGN_TOP, 1, Colors.blackColor)
        draw.SimpleTextOutlined("POIs ■", "PuristaBold18", w - EFGM.MenuScale(10), EFGM.MenuScale(100), Colors.mapLocation, TEXT_ALIGN_RIGHT, TEXT_ALIGN_TOP, 1, Colors.blackColor)
        draw.SimpleTextOutlined("KEYS ■", "PuristaBold18", w - EFGM.MenuScale(10), EFGM.MenuScale(115), Colors.mapKey, TEXT_ALIGN_RIGHT, TEXT_ALIGN_TOP, 1, Colors.blackColor)

    end

    if Menu.Player:CompareStatus(0) then

        local squad = Menu.Player:GetNW2String("PlayerInSquad", nil)

        local squadPanel = vgui.Create("DPanel", contents)
        squadPanel:Dock(LEFT)
        squadPanel:SetSize(EFGM.MenuScale(320), 0)
        squadPanel.Paint = nil

        local CreateSquadPlayerLimit
        local CreateSquadColor = {RED = 255, GREEN = 255, BLUE = 255}

        local createSquadTitle = vgui.Create("DPanel", squadPanel)
        createSquadTitle:Dock(TOP)
        createSquadTitle:SetSize(0, EFGM.MenuScale(32))
        function createSquadTitle:Paint(w, h)

            draw.SimpleTextOutlined("CREATE SQUAD", "PuristaBold32", w / 2, 0, Colors.whiteColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 1, Colors.blackColor)

        end

        squadNamePanel = vgui.Create("DPanel", squadPanel)
        squadNamePanel:Dock(TOP)
        squadNamePanel:SetSize(0, EFGM.MenuScale(55))
        squadNamePanel.Paint = function(s, w, h)

            draw.SimpleTextOutlined("Squad Name", "Purista18", w / 2, EFGM.MenuScale(5), Colors.whiteColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 1, Colors.blackColor)

        end

        squadNameBG = vgui.Create("DPanel", squadNamePanel)
        squadNameBG:SetPos(EFGM.MenuScale(85), EFGM.MenuScale(30))
        squadNameBG:SetSize(EFGM.MenuScale(150), EFGM.MenuScale(20))
        squadNameBG:SetBackgroundColor(Colors.transparent)

        local squadName = vgui.Create("DTextEntry", squadNameBG)
        squadName:Dock(FILL)
        squadName:SetPlaceholderText(" ")
        squadName:SetUpdateOnType(true)
        squadName:SetTextColor(Colors.whiteColor)
        squadName:SetCursorColor(Colors.whiteColor)

        squadName.OnValueChange = function(self, value)

            CreateSquadName = self:GetValue()

        end

        squadPasswordPanel = vgui.Create("DPanel", squadPanel)
        squadPasswordPanel:Dock(TOP)
        squadPasswordPanel:SetSize(0, EFGM.MenuScale(55))
        squadPasswordPanel.Paint = function(s, w, h)

            draw.SimpleTextOutlined("Squad Password (optional)", "Purista18", w / 2, EFGM.MenuScale(5), Colors.whiteColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 1, Colors.blackColor)

        end

        squadPasswordBG = vgui.Create("DPanel", squadPasswordPanel)
        squadPasswordBG:SetPos(EFGM.MenuScale(85), EFGM.MenuScale(30))
        squadPasswordBG:SetSize(EFGM.MenuScale(150), EFGM.MenuScale(20))
        squadPasswordBG:SetBackgroundColor(Colors.transparent)

        local squadPassword = vgui.Create("DTextEntry", squadPasswordBG)
        squadPassword:Dock(FILL)
        squadPassword:SetPlaceholderText(" ")
        squadPassword:SetUpdateOnType(true)
        squadPassword:SetTextColor(Colors.whiteColor)
        squadPassword:SetCursorColor(Colors.whiteColor)

        squadPassword.OnValueChange = function(self, value)

            CreateSquadPassword = self:GetValue()

        end

        local squadMemberLimitPanel = vgui.Create("DPanel", squadPanel)
        squadMemberLimitPanel:Dock(TOP)
        squadMemberLimitPanel:SetSize(0, EFGM.MenuScale(55))
        function squadMemberLimitPanel:Paint(w, h)

            draw.SimpleTextOutlined("Squad Member Limit (1 to 4)", "Purista18", w / 2, EFGM.MenuScale(5), Colors.whiteColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 1, Colors.blackColor)

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

            draw.SimpleTextOutlined("Squad Color", "Purista18", w / 2, EFGM.MenuScale(5), Colors.whiteColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 1, Colors.blackColor)
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

            surface.PlaySound("ui/element_hover_" .. math.random(1, 3) .. ".wav")

        end

        function squadCreateButton:DoClick()

            surface.PlaySound("ui/element_select.wav")

            RunConsoleCommand("efgm_squad_create", squadName:GetValue(), squadPassword:GetValue(), CreateSquadPlayerLimit, CreateSquadColor.RED, CreateSquadColor.GREEN, CreateSquadColor.BLUE)

        end

        local joinSquadTitle = vgui.Create("DPanel", squadPanel)
        joinSquadTitle:Dock(TOP)
        joinSquadTitle:SetSize(0, EFGM.MenuScale(32 + 10))
        function joinSquadTitle:Paint(w, h)

            draw.SimpleTextOutlined("JOIN SQUAD", "PuristaBold32", w / 2, 0, Colors.whiteColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 1, Colors.blackColor)

        end

        local availableSquadsPanel = vgui.Create("DScrollPanel", squadPanel)
        availableSquadsPanel:Dock(TOP)
        availableSquadsPanel:SetSize(0, EFGM.MenuScale(220))
        availableSquadsPanel.Paint = nil

        local availableSquadsPanelBar = availableSquadsPanel:GetVBar()
        availableSquadsPanelBar:SetHideButtons(true)
        availableSquadsPanelBar:SetSize(EFGM.MenuScale(15), EFGM.MenuScale(15))
        function availableSquadsPanelBar:Paint(w, h)
            draw.RoundedBox(0, EFGM.MenuScale(5), EFGM.MenuScale(8), EFGM.MenuScale(5), h - EFGM.MenuScale(16), Colors.scrollerColor)
        end
        function availableSquadsPanelBar.btnGrip:Paint(w, h)
            draw.RoundedBox(0, EFGM.MenuScale(5), EFGM.MenuScale(8), EFGM.MenuScale(5), h - EFGM.MenuScale(16), Colors.transparentWhiteColor)
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
                        surface.SetDrawColor(Colors.transparentBlackColor)
                    else
                        surface.SetDrawColor(Color(50, 0, 0, 100))
                    end
                    surface.DrawRect(0, 0, w, h)

                    draw.SimpleTextOutlined(name, "PuristaBold24", w / 2, EFGM.MenuScale(5), Color(color.RED, color.GREEN, color.BLUE), TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 1, Colors.blackColor)
                    draw.SimpleTextOutlined(table.Count(members) .. " / " .. limit .. "   |   " .. status, "PuristaBold18", w / 2, EFGM.MenuScale(30), Colors.whiteColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 1, Colors.blackColor)

                end

                squadEntry.DoClick = function(s, w, h)

                    if open and !protected then

                        surface.PlaySound("ui/element_select.wav")

                        RunConsoleCommand("efgm_squad_join", name, password)

                    end

                end

                squadEntry.OnCursorEntered = function(s)

                    local x, y = Menu.MouseX, Menu.MouseY
                    local sideH, sideV

                    surface.PlaySound("ui/element_hover_" .. math.random(1, 3) .. ".wav")

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

                        surface.SetDrawColor(Colors.transparentWhiteColor)
                        surface.DrawRect(0, 0, w, EFGM.MenuScale(1))
                        surface.DrawRect(0, h - 1, w, EFGM.MenuScale(1))
                        surface.DrawRect(0, 0, EFGM.MenuScale(1), h)
                        surface.DrawRect(w - 1, 0, EFGM.MenuScale(1), h)

                        draw.SimpleTextOutlined("MEMBERS", "PuristaBold24", EFGM.MenuScale(5), EFGM.MenuScale(5), Colors.whiteColor, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP, 1, Colors.blackColor)

                        -- draw name for each member
                        for k, v in SortedPairs(members) do

                            if v == owner then

                                draw.SimpleTextOutlined(v:GetName() .. "*", "PuristaBold18", EFGM.MenuScale(27), (k * EFGM.MenuScale(20)) + EFGM.MenuScale(10), Colors.whiteColor, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP, 1, Colors.blackColor)
                            else

                                draw.SimpleTextOutlined(v:GetName(), "PuristaBold18", EFGM.MenuScale(27), (k * EFGM.MenuScale(20)) + EFGM.MenuScale(10), Colors.whiteColor, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP, 1, Colors.blackColor)

                            end

                        end

                        -- don't show join text if client is already in a squad
                        if squad != "nil" then return end

                        if !open then

                            draw.SimpleTextOutlined("SQUAD FULL!", "PuristaBold18", EFGM.MenuScale(5), h - EFGM.MenuScale(23), Colors.whiteColor, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP, 1, Colors.deadColor)
                            return

                        end

                        if !protected then

                            draw.SimpleTextOutlined("CLICK TO JOIN!", "PuristaBold18", EFGM.MenuScale(5), h - EFGM.MenuScale(23), Colors.whiteColor, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP, 1, Colors.blackColor)

                        else

                            draw.SimpleTextOutlined("ENTER PASSWORD TO JOIN!", "PuristaBold18", EFGM.MenuScale(5), h - EFGM.MenuScale(23), Colors.whiteColor, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP, 1, Colors.blackColor)

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
                        squadPasswordEntry:SetTextColor(Colors.whiteColor)
                        squadPasswordEntry:SetCursorColor(Colors.whiteColor)
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
        currentSquadPanel.Paint = nil

        local function RenderCurrentSquad(array)

            if array == nil then return end
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

                surface.SetDrawColor(Colors.transparentWhiteColor)
                surface.DrawRect(0, 0, w, EFGM.MenuScale(1))
                surface.DrawRect(0, 0, EFGM.MenuScale(1), h)
                surface.DrawRect(w - 1, 0, EFGM.MenuScale(1), h)

                draw.SimpleTextOutlined(squad, "PuristaBold32", w / 2, EFGM.MenuScale(5), Colors.whiteColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 1, Colors.blackColor)
                draw.SimpleTextOutlined(status, "PuristaBold18", w / 2, EFGM.MenuScale(37), Colors.whiteColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 1, Colors.blackColor)

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

                    draw.SimpleTextOutlined("Copy Password", "PuristaBold18", w / 2, EFGM.MenuScale(-2), Colors.whiteColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 1, Colors.blackColor)

                end

                function currentSquadPasswordButton:OnCursorEntered()

                    surface.PlaySound("ui/element_hover_" .. math.random(1, 3) .. ".wav")

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

                surface.SetDrawColor(Colors.transparentWhiteColor)
                surface.DrawRect(0, 0, EFGM.MenuScale(1), h)
                surface.DrawRect(w - 1, 0, EFGM.MenuScale(1), h)

                draw.SimpleTextOutlined("MEMBERS", "PuristaBold24", EFGM.MenuScale(5), 0, Colors.whiteColor, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP, 1, Colors.blackColor)

                for k, v in SortedPairs(members) do

                    if v == owner then

                        draw.SimpleTextOutlined(v:GetName() .. "*", "PuristaBold24", EFGM.MenuScale(40), (k * EFGM.MenuScale(35)) - EFGM.MenuScale(3), Colors.whiteColor, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP, 1, Colors.blackColor)
                    else

                        draw.SimpleTextOutlined(v:GetName(), "PuristaBold24", EFGM.MenuScale(40), (k * EFGM.MenuScale(35)) - EFGM.MenuScale(3), Colors.whiteColor, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP, 1, Colors.blackColor)

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
                    profile:SetIcon("games/16/all.png")
                    local gameProfile = dropdown:AddOption("Open Game Profile", function() CreateNotification("I do not work yet LOL!", Mats.dontEvenAsk, "ui/boo.wav") end)
                    gameProfile:SetIcon("icon16/chart_bar.png")

                    if v != Menu.Player and v:CompareStatus(0) then

                        dropdown:AddSpacer()

                        local inviteToDuel = dropdown:AddOption("Invite To Duel", function() InvitePlayerToDuel(ply, v) end)
                        inviteToDuel:SetIcon("icon16/bomb.png")

                    end

                    dropdown:AddSpacer()

                    dropdown:AddOption("Copy Name", function() SetClipboardText(v:GetName()) end):SetIcon("icon16/pencil_add.png")
                    dropdown:AddOption("Copy SteamID64", function() SetClipboardText(v:SteamID64()) end):SetIcon("icon16/pencil_add.png")

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

                    local transferToMember = vgui.Create("DButton", currentSquadMembers)
                    transferToMember:SetPos(EFGM.MenuScale(262), (k * EFGM.MenuScale(35)) - EFGM.MenuScale(2))
                    transferToMember:SetSize(EFGM.MenuScale(24), EFGM.MenuScale(24))
                    transferToMember:SetText("")
                    transferToMember.Paint = function(s, w, h)

                        surface.SetDrawColor(Colors.pureWhiteColor)
                        surface.SetMaterial(Mats.squadTransferIcon)
                        surface.DrawTexturedRect(0, 0, EFGM.MenuScale(24), EFGM.MenuScale(24))

                    end

                    transferToMember.OnCursorEntered = function(s)

                        local x, y = Menu.MouseX, Menu.MouseY
                        local sideH, sideV

                        surface.PlaySound("ui/element_hover_" .. math.random(1, 3) .. ".wav")

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

                            surface.SetDrawColor(Colors.transparentWhiteColor)
                            surface.DrawRect(0, 0, w, EFGM.MenuScale(1))
                            surface.DrawRect(0, h - 1, w, EFGM.MenuScale(1))
                            surface.DrawRect(0, 0, EFGM.MenuScale(1), h)
                            surface.DrawRect(w - 1, 0, EFGM.MenuScale(1), h)

                            draw.SimpleTextOutlined(text, "Purista18", EFGM.MenuScale(5), EFGM.MenuScale(2), Colors.whiteColor, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP, 1, Colors.blackColor)

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

                    local kickMember = vgui.Create("DButton", currentSquadMembers)
                    kickMember:SetPos(EFGM.MenuScale(291), (k * EFGM.MenuScale(35)) - EFGM.MenuScale(2))
                    kickMember:SetSize(EFGM.MenuScale(24), EFGM.MenuScale(24))
                    kickMember:SetText("")
                    kickMember.Paint = function(s, w, h)

                        surface.SetDrawColor(Colors.pureWhiteColor)
                        surface.SetMaterial(Mats.squadKickIcon)
                        surface.DrawTexturedRect(0, 0, EFGM.MenuScale(24), EFGM.MenuScale(24))

                    end

                    kickMember.OnCursorEntered = function(s)

                        local x, y = Menu.MouseX, Menu.MouseY
                        local sideH, sideV

                        surface.PlaySound("ui/element_hover_" .. math.random(1, 3) .. ".wav")

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

                            surface.SetDrawColor(Colors.transparentWhiteColor)
                            surface.DrawRect(0, 0, w, EFGM.MenuScale(1))
                            surface.DrawRect(0, h - 1, w, EFGM.MenuScale(1))
                            surface.DrawRect(0, 0, EFGM.MenuScale(1), h)
                            surface.DrawRect(w - 1, 0, EFGM.MenuScale(1), h)

                            draw.SimpleTextOutlined(text, "Purista18", EFGM.MenuScale(5), EFGM.MenuScale(2), Colors.whiteColor, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP, 1, Colors.blackColor)

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

                surface.SetDrawColor(Colors.transparentWhiteColor)
                surface.DrawRect(0, h - 1, w, EFGM.MenuScale(1))
                surface.DrawRect(0, 0, EFGM.MenuScale(1), h)
                surface.DrawRect(w - 1, 0, EFGM.MenuScale(1), h)

            end

            local currentSquadLeaveButton = vgui.Create("DButton", currentSquadLeavePanel)
            currentSquadLeaveButton:SetPos(EFGM.MenuScale(85), EFGM.MenuScale(5))
            currentSquadLeaveButton:SetSize(EFGM.MenuScale(175), EFGM.MenuScale(25))
            currentSquadLeaveButton:SetText("")
            currentSquadLeaveButton.Paint = function(s, w, h)

                surface.SetDrawColor(Color(25, 25, 25, 155))
                surface.DrawRect(0, 0, w, h)

                if owner != Menu.Player then

                    draw.SimpleTextOutlined("LEAVE SQUAD", "PuristaBold24", w / 2, EFGM.MenuScale(-2), Colors.whiteColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 1, Colors.blackColor)

                else

                    draw.SimpleTextOutlined("DISBAND SQUAD", "PuristaBold24", w / 2, EFGM.MenuScale(-2), Colors.whiteColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 1, Colors.blackColor)

                end

            end

            function currentSquadLeaveButton:OnCursorEntered()

                surface.PlaySound("ui/element_hover_" .. math.random(1, 3) .. ".wav")

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
    contents.Paint = nil

    Menu.MenuFrame.LowerPanel.Contents = contents

    local stats = vgui.Create("DScrollPanel", contents)
    stats:Dock(LEFT)
    stats:SetSize(EFGM.MenuScale(320), 0)
    stats.Paint = nil

    local statsTitle = vgui.Create("DPanel", stats)
    statsTitle:Dock(TOP)
    statsTitle:SetSize(0, EFGM.MenuScale(32))
    function statsTitle:Paint(w, h)

        draw.SimpleTextOutlined("STATISTICS", "PuristaBold32", w / 2, 0, Colors.whiteColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 1, Colors.blackColor)

    end

    local statsBar = stats:GetVBar()
    statsBar:SetHideButtons(true)
    statsBar:SetSize(EFGM.MenuScale(15), EFGM.MenuScale(15))
    function statsBar:Paint(w, h)
        draw.RoundedBox(0, EFGM.MenuScale(5), EFGM.MenuScale(8), EFGM.MenuScale(5), h - EFGM.MenuScale(16), Colors.scrollerColor)
    end
    function statsBar.btnGrip:Paint(w, h)
        draw.RoundedBox(0, EFGM.MenuScale(5), EFGM.MenuScale(8), EFGM.MenuScale(5), h - EFGM.MenuScale(16), Colors.transparentWhiteColor)
    end

    local importantStats = vgui.Create("DPanel", stats)
    importantStats:Dock(TOP)
    importantStats:SetSize(0, EFGM.MenuScale(580))
    importantStats.Paint = nil

    -- only temporary, I gotta find a way to automate this shit

    local statsTbl = {}

    statsTbl["Level"] = Menu.Player:GetNWInt("Level")
    statsTbl["Experience"] = comma_value(Menu.Player:GetNWInt("Experience"))
    statsTbl["Money Earned"] = "₽" .. comma_value(Menu.Player:GetNWInt("MoneyEarned"))
    statsTbl["Money Spent"] = "₽" .. comma_value(Menu.Player:GetNWInt("MoneySpent"))
    statsTbl["Time"] = format_seconds(Menu.Player:GetNWInt("Time"))
    statsTbl["Stash Value"] = "₽" .. comma_value(Menu.Player:GetNWInt("StashValue"))
    statsTbl["Items Looted"] = comma_value(Menu.Player:GetNWInt("ItemsLooted"))
    statsTbl["Containers Opened"] = comma_value(Menu.Player:GetNWInt("ContainersLooted"))
    statsTbl["Keys Used"] = comma_value(Menu.Player:GetNWInt("KeysUsed"))

    statsTbl["Kills"] = comma_value(Menu.Player:GetNWInt("Kills"))
    statsTbl["Deaths"] = comma_value(Menu.Player:GetNWInt("Deaths"))
    statsTbl["Suicides"] = comma_value(Menu.Player:GetNWInt("Suicides"))
    statsTbl["Damage Dealt"] = comma_value(math.Round(Menu.Player:GetNWInt("DamageDealt")))
    statsTbl["Damage Received"] = comma_value(math.Round(Menu.Player:GetNWInt("DamageRecieved")))
    statsTbl["Health Healed"] = comma_value(math.Round(Menu.Player:GetNWInt("HealthHealed")))
    statsTbl["Shots Fired"] = comma_value(Menu.Player:GetNWInt("ShotsFired"))
    statsTbl["Shots Hit"] = comma_value(Menu.Player:GetNWInt("ShotsHit"))
    statsTbl["Headshots"] = comma_value(Menu.Player:GetNWInt("Headshots"))
    statsTbl["Farthest Kill"] = comma_value(Menu.Player:GetNWInt("FarthestKill"))

    statsTbl["Extractions"] = comma_value(Menu.Player:GetNWInt("Extractions"))
    statsTbl["Quits"] = comma_value(Menu.Player:GetNWInt("Quits"))
    statsTbl["Raids Played"] = comma_value(Menu.Player:GetNWInt("RaidsPlayed"))

    statsTbl["Duels Played"] = comma_value(Menu.Player:GetNWInt("DuelsPlayed"))
    statsTbl["Duels Won"] = comma_value(Menu.Player:GetNWInt("DuelsWon"))

    statsTbl["Current Kill Streak"] = comma_value(Menu.Player:GetNWInt("CurrentKillStreak"))
    statsTbl["Best Kill Streak"] = comma_value(Menu.Player:GetNWInt("BestKillStreak"))
    statsTbl["Current Extraction Streak"] = comma_value(Menu.Player:GetNWInt("CurrentExtractionStreak"))
    statsTbl["Best Extraction Streak"] = comma_value(Menu.Player:GetNWInt("BestExtractionStreak"))
    statsTbl["Current Duel Win Streak"] = comma_value(Menu.Player:GetNWInt("CurrentDuelWinStreak"))
    statsTbl["Best Duel Win Streak"] = comma_value(Menu.Player:GetNWInt("BestDuelWinStreak"))

    statsTbl["K/D Ratio"] = math.Round(Menu.Player:GetNWInt("Kills") / math.min(Menu.Player:GetNWInt("Deaths"), 1), 3)
    statsTbl["Survival Rate"] = math.Round(Menu.Player:GetNWInt("Extractions") / Menu.Player:GetNWInt("RaidsPlayed") * 100) .. "%"
    statsTbl["Accuracy"] = math.Round(Menu.Player:GetNWInt("ShotsHit") / Menu.Player:GetNWInt("ShotsFired") * 100) .. "%"
    statsTbl["Duels Win Rate"] = math.Round(Menu.Player:GetNWInt("DuelsWon") / Menu.Player:GetNWInt("DuelsPlayed") * 100) .. "%"

    for k, v in SortedPairs(statsTbl) do

        local statEntry = vgui.Create("DPanel", importantStats)
        statEntry:Dock(TOP)
        statEntry:SetSize(0, EFGM.MenuScale(17))
        function statEntry:Paint(w, h)

            draw.SimpleTextOutlined(k .. "", "Purista18", EFGM.MenuScale(5), 0, Colors.whiteColor, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP, 1, Colors.blackColor)
            draw.SimpleTextOutlined(v, "Purista18", w - EFGM.MenuScale(5), 0, Colors.whiteColor, TEXT_ALIGN_RIGHT, TEXT_ALIGN_TOP, 1, Colors.blackColor)

        end

    end

    local selectedBoard
    local selectedBoardName

    local leaderboardTitle = vgui.Create("DPanel", stats)
    leaderboardTitle:Dock(TOP)
    leaderboardTitle:SetSize(0, EFGM.MenuScale(32))
    function leaderboardTitle:Paint(w, h)

        draw.SimpleTextOutlined("LEADERBOARDS", "PuristaBold32", w / 2, 0, Colors.whiteColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 1, Colors.blackColor)

    end

    function selectBoard(text, data)

        if selectedBoardName == text then return end

        net.Start("GrabLeaderboardData")
        net.WriteString(data)
        net.SendToServer()

        selectedBoardName = text

    end

    local leaderboardSelectButton = vgui.Create("DButton", stats)
    leaderboardSelectButton:Dock(TOP)
    leaderboardSelectButton:SetText("SELECT LEADERBOARD")

    leaderboardSelectButton.OnCursorEntered = function(s)

        surface.PlaySound("ui/element_hover_" .. math.random(1, 3) .. ".wav")

    end

    function leaderboardSelectButton:DoClick()

        surface.PlaySound("ui/element_select.wav")

        local boardSelection = DermaMenu()

        for text, board in SortedPairs(LEADERBOARDS) do

            boardSelection:AddOption(text, function() selectBoard(text, board) end)

        end

        boardSelection:Open()

    end

    local yColor = Color(255, 255, 0, 255)
    selectBoard("Stash Value", "StashValue")

    local leaderboardContents = vgui.Create("DScrollPanel", stats)
    leaderboardContents:Dock(TOP)
    leaderboardContents:SetSize(0, EFGM.MenuScale(380))
    leaderboardContents.Paint = function(s, w, h)

        if selectedBoard == nil then return end

        draw.SimpleTextOutlined(string.upper(selectedBoardName), "PuristaBold22", w / 2, EFGM.MenuScale(5), Colors.whiteColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 1, Colors.blackColor)

        for k, v in ipairs(selectedBoard) do

            local color = Colors.whiteColor
            if v.SteamID == Menu.Player:SteamID64() then color = yColor end
            if !v.Name then return end
            draw.SimpleTextOutlined(k, "Purista18", EFGM.MenuScale(5), EFGM.MenuScale(25) + ((k - 1) * EFGM.MenuScale(20)), color, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP, 1, Colors.blackColor)
            draw.SimpleTextOutlined(string.sub(v.Name, 1, 21), "Purista18", EFGM.MenuScale(25), EFGM.MenuScale(25) + ((k - 1) * EFGM.MenuScale(20)), color, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP, 1, Colors.blackColor)

            --asdofiauhasdofiauashydafasdifa
            if selectedBoardName == "Money Earned" or selectedBoardName == "Money Spent" or selectedBoardName == "Stash Value" then

                draw.SimpleTextOutlined("₽" .. comma_value(v.Value), "Purista18", w - EFGM.MenuScale(5), EFGM.MenuScale(25) + ((k - 1) * EFGM.MenuScale(20)), color, TEXT_ALIGN_RIGHT, TEXT_ALIGN_TOP, 1, Colors.blackColor)

            elseif selectedBoardName == "Time" then

                draw.SimpleTextOutlined(comma_value(v.Value) .. "s", "Purista18", w - EFGM.MenuScale(5), EFGM.MenuScale(25) + ((k - 1) * EFGM.MenuScale(20)), color, TEXT_ALIGN_RIGHT, TEXT_ALIGN_TOP, 1, Colors.blackColor)

            else

                draw.SimpleTextOutlined(comma_value(v.Value), "Purista18", w - EFGM.MenuScale(5), EFGM.MenuScale(25) + ((k - 1) * EFGM.MenuScale(20)), color, TEXT_ALIGN_RIGHT, TEXT_ALIGN_TOP, 1, Colors.blackColor)

            end

        end

    end

    net.Receive("SendLeaderboardData", function(len, ply)

        local str = net.ReadString()

        if !str then return end

        str = util.Base64Decode(str)
        str = util.Decompress(str)

        if !str then return end

        local tbl = util.JSONToTable(str)

        selectedBoard = tbl

        if !selectedBoard then return end

        for k, v in ipairs(selectedBoard) do

            local name = ""
            steamworks.RequestPlayerInfo(v.SteamID, function(steamName) name = steamName end)

            timer.Simple(k * 0.01, function()

                selectedBoard[k].Name = name

            end)

        end

    end )

end

function Menu.OpenTab.Skills()

    local contents = vgui.Create("DPanel", Menu.MenuFrame.LowerPanel)
    contents:Dock(FILL)
    contents:DockPadding(EFGM.MenuScale(10), EFGM.MenuScale(10), EFGM.MenuScale(10), EFGM.MenuScale(10))
    contents:SetAlpha(0)
    contents.Paint = nil

    Menu.MenuFrame.LowerPanel.Contents = contents

    local skills = vgui.Create("DScrollPanel", contents)
    skills:Dock(FILL)
    skills.Paint = nil

    local skillsTitle = vgui.Create("DPanel", skills)
    skillsTitle:Dock(TOP)
    skillsTitle:SetSize(0, EFGM.MenuScale(32))
    function skillsTitle:Paint(w, h)

        draw.SimpleTextOutlined("SKILLS", "PuristaBold32", 265, 0, Colors.whiteColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 1, Colors.blackColor)

    end

    local skillsBar = skills:GetVBar()
    skillsBar:SetHideButtons(true)
    skillsBar:SetSize(EFGM.MenuScale(15), EFGM.MenuScale(15))
    function skillsBar:Paint(w, h)
        draw.RoundedBox(0, EFGM.MenuScale(5), EFGM.MenuScale(8), EFGM.MenuScale(5), h - EFGM.MenuScale(16), Colors.scrollerColor)
    end
    function skillsBar.btnGrip:Paint(w, h)
        draw.RoundedBox(0, EFGM.MenuScale(5), EFGM.MenuScale(8), EFGM.MenuScale(5), h - EFGM.MenuScale(16), Colors.transparentWhiteColor)
    end

    local skillsList = vgui.Create("DIconLayout", skills)
    skillsList:Dock(LEFT)
    skillsList:SetSize(EFGM.MenuScale(530), 0)
    skillsList:SetSpaceY(EFGM.MenuScale(20))
    skillsList:SetSpaceX(EFGM.MenuScale(20))
    skillsList.Paint = nil

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

            surface.SetDrawColor(Colors.whiteColor)
            surface.DrawRect(0, 0, w, h)

            surface.SetDrawColor(Colors.pureWhiteColor)
            surface.SetMaterial(v1.Icon)
            surface.DrawTexturedRect(EFGM.MenuScale(3), EFGM.MenuScale(3), EFGM.MenuScale(84), EFGM.MenuScale(84))

        end

        skillItem.PaintOver = function(s, w, h)

            draw.SimpleTextOutlined("1", "PuristaBold32", EFGM.MenuScale(4), EFGM.MenuScale(52), Colors.whiteColor, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP, 1, Colors.blackColor)
            draw.SimpleTextOutlined("0/10", "Purista18", w - EFGM.MenuScale(4), EFGM.MenuScale(64), Colors.whiteColor, TEXT_ALIGN_RIGHT, TEXT_ALIGN_TOP, 1, Colors.blackColor)

        end

        skillItem.OnCursorEntered = function(s)

            local x, y = Menu.MouseX, Menu.MouseY
            local sideH, sideV

            surface.PlaySound("ui/element_hover_" .. math.random(1, 3) .. ".wav")

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

                surface.SetDrawColor(Colors.transparentWhiteColor)
                surface.DrawRect(0, 0, w, EFGM.MenuScale(1))
                surface.DrawRect(0, h - 1, w, EFGM.MenuScale(1))
                surface.DrawRect(0, 0, EFGM.MenuScale(1), h)
                surface.DrawRect(w - 1, 0, EFGM.MenuScale(1), h)

                draw.SimpleTextOutlined(string.upper(v1.Name), "PuristaBold24", EFGM.MenuScale(5), EFGM.MenuScale(5), Colors.whiteColor, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP, 1, Colors.blackColor)
                draw.SimpleTextOutlined(string.upper(v1.Category), "Purista18Italic", EFGM.MenuScale(5), EFGM.MenuScale(25), Colors.whiteColor, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP, 1, Colors.blackColor)
                draw.SimpleTextOutlined(v1.Description, "Purista18", EFGM.MenuScale(5), EFGM.MenuScale(55), Colors.whiteColor, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP, 1, Colors.blackColor)
                draw.SimpleTextOutlined("1", "PuristaBold64", w - EFGM.MenuScale(5), EFGM.MenuScale(-10), Colors.whiteColor, TEXT_ALIGN_RIGHT, TEXT_ALIGN_TOP, 1, Colors.blackColor)

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
    contents.Paint = nil

    Menu.MenuFrame.LowerPanel.Contents = contents

    local gameplayHolder = vgui.Create("DPanel", contents)
    gameplayHolder:Dock(LEFT)
    gameplayHolder:SetSize(EFGM.MenuScale(320), 0)
    gameplayHolder.Paint = nil

    local gameplayTitle = vgui.Create("DPanel", gameplayHolder)
    gameplayTitle:Dock(TOP)
    gameplayTitle:SetSize(0, EFGM.MenuScale(32))
    function gameplayTitle:Paint(w, h)

        draw.SimpleTextOutlined("GAMEPLAY", "PuristaBold32", w / 2, 0, Colors.whiteColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 1, Colors.blackColor)

    end

    local gameplay = vgui.Create("DScrollPanel", gameplayHolder)
    gameplay:Dock(LEFT)
    gameplay:SetSize(EFGM.MenuScale(320), 0)
    gameplay.Paint = nil

    local gameplayBar = gameplay:GetVBar()
    gameplayBar:SetHideButtons(true)
    gameplayBar:SetSize(EFGM.MenuScale(15), EFGM.MenuScale(15))
    function gameplayBar:Paint(w, h)
        draw.RoundedBox(0, EFGM.MenuScale(5), EFGM.MenuScale(8), EFGM.MenuScale(5), h - EFGM.MenuScale(16), Colors.scrollerColor)
    end
    function gameplayBar.btnGrip:Paint(w, h)
        draw.RoundedBox(0, EFGM.MenuScale(5), EFGM.MenuScale(8), EFGM.MenuScale(5), h - EFGM.MenuScale(16), Colors.transparentWhiteColor)
    end

    local controlsHolder = vgui.Create("DPanel", contents)
    controlsHolder:Dock(LEFT)
    controlsHolder:SetSize(EFGM.MenuScale(320), 0)
    controlsHolder.Paint = nil

    local controlsTitle = vgui.Create("DPanel", controlsHolder)
    controlsTitle:Dock(TOP)
    controlsTitle:SetSize(0, EFGM.MenuScale(32))
    function controlsTitle:Paint(w, h)

        draw.SimpleTextOutlined("CONTROLS", "PuristaBold32", w / 2, 0, Colors.whiteColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 1, Colors.blackColor)

    end

    local controls = vgui.Create("DScrollPanel", controlsHolder)
    controls:Dock(LEFT)
    controls:SetSize(EFGM.MenuScale(320), 0)
    controls.Paint = nil

    local controlsBar = controls:GetVBar()
    controlsBar:SetHideButtons(true)
    controlsBar:SetSize(EFGM.MenuScale(1), EFGM.MenuScale(15))

    local interfaceHolder = vgui.Create("DPanel", contents)
    interfaceHolder:Dock(LEFT)
    interfaceHolder:SetSize(EFGM.MenuScale(320), 0)
    interfaceHolder.Paint = nil

    local interfaceTitle = vgui.Create("DPanel", interfaceHolder)
    interfaceTitle:Dock(TOP)
    interfaceTitle:SetSize(0, EFGM.MenuScale(32))
    function interfaceTitle:Paint(w, h)

        draw.SimpleTextOutlined("INTERFACE", "PuristaBold32", w / 2, 0, Colors.whiteColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 1, Colors.blackColor)

    end

    local interface = vgui.Create("DScrollPanel", interfaceHolder)
    interface:Dock(LEFT)
    interface:SetSize(EFGM.MenuScale(320), 0)
    interface.Paint = nil

    local interfaceBar = interface:GetVBar()
    interfaceBar:SetHideButtons(true)
    interfaceBar:SetSize(EFGM.MenuScale(15), EFGM.MenuScale(15))
    function interfaceBar:Paint(w, h)
        draw.RoundedBox(0, EFGM.MenuScale(5), EFGM.MenuScale(8), EFGM.MenuScale(5), h - EFGM.MenuScale(16), Colors.scrollerColor)
    end
    function interfaceBar.btnGrip:Paint(w, h)
        draw.RoundedBox(0, EFGM.MenuScale(5), EFGM.MenuScale(8), EFGM.MenuScale(5), h - EFGM.MenuScale(16), Colors.transparentWhiteColor)
    end

    local visualsHolder = vgui.Create("DPanel", contents)
    visualsHolder:Dock(LEFT)
    visualsHolder:SetSize(EFGM.MenuScale(320), 0)
    visualsHolder.Paint = nil

    local visualsTitle = vgui.Create("DPanel", visualsHolder)
    visualsTitle:Dock(TOP)
    visualsTitle:SetSize(0, EFGM.MenuScale(32))
    function visualsTitle:Paint(w, h)

        draw.SimpleTextOutlined("VISUALS", "PuristaBold32", w / 2, 0, Colors.whiteColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 1, Colors.blackColor)

    end

    local visuals = vgui.Create("DScrollPanel", visualsHolder)
    visuals:Dock(LEFT)
    visuals:SetSize(EFGM.MenuScale(320), 0)
    visuals.Paint = nil

    local visualsBar = visuals:GetVBar()
    visualsBar:SetHideButtons(true)
    visualsBar:SetSize(EFGM.MenuScale(15), EFGM.MenuScale(15))
    function visualsBar:Paint(w, h)
        draw.RoundedBox(0, EFGM.MenuScale(5), EFGM.MenuScale(8), EFGM.MenuScale(5), h - EFGM.MenuScale(16), Colors.scrollerColor)
    end
    function visualsBar.btnGrip:Paint(w, h)
        draw.RoundedBox(0, EFGM.MenuScale(5), EFGM.MenuScale(8), EFGM.MenuScale(5), h - EFGM.MenuScale(16), Colors.transparentWhiteColor)
    end

    local accountHolder = vgui.Create("DPanel", contents)
    accountHolder:Dock(LEFT)
    accountHolder:SetSize(EFGM.MenuScale(320), 0)
    accountHolder.Paint = nil

    local accountTitle = vgui.Create("DPanel", accountHolder)
    accountTitle:Dock(TOP)
    accountTitle:SetSize(0, EFGM.MenuScale(32))
    function accountTitle:Paint(w, h)

        draw.SimpleTextOutlined("ACCOUNT", "PuristaBold32", w / 2, 0, Colors.whiteColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 1, Colors.blackColor)

    end

    local account = vgui.Create("DScrollPanel", accountHolder)
    account:Dock(LEFT)
    account:SetSize(EFGM.MenuScale(320), 0)
    account.Paint = nil

    local accountBar = account:GetVBar()
    accountBar:SetHideButtons(true)
    accountBar:SetSize(EFGM.MenuScale(15), EFGM.MenuScale(15))
    function accountBar:Paint(w, h)
        draw.RoundedBox(0, EFGM.MenuScale(5), EFGM.MenuScale(8), EFGM.MenuScale(5), h - EFGM.MenuScale(16), Colors.scrollerColor)
    end
    function accountBar.btnGrip:Paint(w, h)
        draw.RoundedBox(0, EFGM.MenuScale(5), EFGM.MenuScale(8), EFGM.MenuScale(5), h - EFGM.MenuScale(16), Colors.transparentWhiteColor)
    end

    local miscHolder = vgui.Create("DPanel", contents)
    miscHolder:Dock(LEFT)
    miscHolder:SetSize(EFGM.MenuScale(260), EFGM.MenuScale(353))
    miscHolder.Paint = nil

    local miscTitle = vgui.Create("DPanel", miscHolder)
    miscTitle:Dock(TOP)
    miscTitle:SetSize(0, EFGM.MenuScale(32))
    function miscTitle:Paint(w, h)

        draw.SimpleTextOutlined("MISC.", "PuristaBold32", w / 2, 0, Colors.whiteColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 1, Colors.blackColor)

    end

    local misc = vgui.Create("DScrollPanel", miscHolder)
    misc:Dock(LEFT)
    misc:SetSize(EFGM.MenuScale(260), EFGM.MenuScale(353))
    misc.Paint = nil

    local miscBar = misc:GetVBar()
    miscBar:SetHideButtons(true)
    miscBar:SetSize(EFGM.MenuScale(15), EFGM.MenuScale(15))
    function miscBar:Paint(w, h)
        draw.RoundedBox(0, EFGM.MenuScale(5), EFGM.MenuScale(8), EFGM.MenuScale(5), h - EFGM.MenuScale(16), Colors.scrollerColor)
    end
    function miscBar.btnGrip:Paint(w, h)
        draw.RoundedBox(0, EFGM.MenuScale(5), EFGM.MenuScale(8), EFGM.MenuScale(5), h - EFGM.MenuScale(16), Colors.transparentWhiteColor)
    end

    -- settings go below

    -- gameplay

    local toggleCrouchPanel = vgui.Create("DPanel", gameplay)
    toggleCrouchPanel:Dock(TOP)
    toggleCrouchPanel:SetSize(0, EFGM.MenuScale(50))
    function toggleCrouchPanel:Paint(w, h)

        draw.SimpleTextOutlined("Toggle Crouching", "Purista18", w / 2, EFGM.MenuScale(5), Colors.whiteColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 1, Colors.blackColor)

    end

    local toggleCrouch = vgui.Create("DCheckBox", toggleCrouchPanel)
    toggleCrouch:SetPos(EFGM.MenuScale(152), EFGM.MenuScale(30))
    toggleCrouch:SetConVar("efgm_controls_toggleduck")
    toggleCrouch:SetSize(EFGM.MenuScale(15), EFGM.MenuScale(15))

    local toggleADSPanel = vgui.Create("DPanel", gameplay)
    toggleADSPanel:Dock(TOP)
    toggleADSPanel:SetSize(0, EFGM.MenuScale(50))
    function toggleADSPanel:Paint(w, h)

        draw.SimpleTextOutlined("Toggle Aim Down Sights", "Purista18", w / 2, EFGM.MenuScale(5), Colors.whiteColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 1, Colors.blackColor)

    end

    local toggleADS = vgui.Create("DCheckBox", toggleADSPanel)
    toggleADS:SetPos(EFGM.MenuScale(152), EFGM.MenuScale(30))
    toggleADS:SetConVar("arc9_toggleads")
    toggleADS:SetSize(EFGM.MenuScale(15), EFGM.MenuScale(15))


    local toggleLeanPanel = vgui.Create("DPanel", gameplay)
    toggleLeanPanel:Dock(TOP)
    toggleLeanPanel:SetSize(0, EFGM.MenuScale(50))
    function toggleLeanPanel:Paint(w, h)

        draw.SimpleTextOutlined("Toggle Leaning", "Purista18", w / 2, EFGM.MenuScale(5), Colors.whiteColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 1, Colors.blackColor)

    end

    local toggleLean = vgui.Create("DCheckBox", toggleLeanPanel)
    toggleLean:SetPos(EFGM.MenuScale(152), EFGM.MenuScale(30))
    toggleLean:SetConVar("efgm_controls_togglelean")
    toggleLean:SetSize(EFGM.MenuScale(15), EFGM.MenuScale(15))

    local musicPanel = vgui.Create("DPanel", gameplay)
    musicPanel:Dock(TOP)
    musicPanel:SetSize(0, EFGM.MenuScale(50))
    function musicPanel:Paint(w, h)

        draw.SimpleTextOutlined("Music", "Purista18", w / 2, EFGM.MenuScale(5), Colors.whiteColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 1, Colors.blackColor)

    end

    local music = vgui.Create("DCheckBox", musicPanel)
    music:SetPos(EFGM.MenuScale(152), EFGM.MenuScale(30))
    music:SetConVar("efgm_music")
    music:SetSize(EFGM.MenuScale(15), EFGM.MenuScale(15))

    local musicVolumePanel = vgui.Create("DPanel", gameplay)
    musicVolumePanel:Dock(TOP)
    musicVolumePanel:SetSize(0, EFGM.MenuScale(50))
    function musicVolumePanel:Paint(w, h)

        draw.SimpleTextOutlined("Music Volume", "Purista18", w / 2, EFGM.MenuScale(5), Colors.whiteColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 1, Colors.blackColor)

    end

    local musicVolume = vgui.Create("DNumSlider", musicVolumePanel)
    musicVolume:SetPos(EFGM.MenuScale(35), EFGM.MenuScale(30))
    musicVolume:SetSize(EFGM.MenuScale(200), EFGM.MenuScale(15))
    musicVolume:SetConVar("efgm_musicvolume")
    musicVolume:SetMin(0)
    musicVolume:SetMax(2)
    musicVolume:SetDecimals(2)

    local infilNearEndPanel = vgui.Create("DPanel", gameplay)
    infilNearEndPanel:Dock(TOP)
    infilNearEndPanel:SetSize(0, EFGM.MenuScale(50))
    function infilNearEndPanel:Paint(w, h)

        draw.SimpleTextOutlined("Block Raid Infil Near Raid End", "Purista18", w / 2, EFGM.MenuScale(5), Colors.whiteColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 1, Colors.blackColor)

    end

    local infilNearEnd = vgui.Create("DCheckBox", infilNearEndPanel)
    infilNearEnd:SetPos(EFGM.MenuScale(152), EFGM.MenuScale(30))
    infilNearEnd:SetConVar("efgm_infil_nearend_block")
    infilNearEnd:SetSize(EFGM.MenuScale(15), EFGM.MenuScale(15))

    local infilNearEndThresholdPanel = vgui.Create("DPanel", gameplay)
    infilNearEndThresholdPanel:Dock(TOP)
    infilNearEndThresholdPanel:SetSize(0, EFGM.MenuScale(50))
    function infilNearEndThresholdPanel:Paint(w, h)

        draw.SimpleTextOutlined("Block Raid Infil Near Raid End Threshold", "Purista18", w / 2, EFGM.MenuScale(5), Colors.whiteColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 1, Colors.blackColor)

    end

    local infilNearEndThreshold = vgui.Create("DNumSlider", infilNearEndThresholdPanel)
    infilNearEndThreshold:SetPos(EFGM.MenuScale(35), EFGM.MenuScale(30))
    infilNearEndThreshold:SetSize(EFGM.MenuScale(200), EFGM.MenuScale(15))
    infilNearEndThreshold:SetConVar("efgm_infil_nearend_limit")
    infilNearEndThreshold:SetMin(30)
    infilNearEndThreshold:SetMax(180)
    infilNearEndThreshold:SetDecimals(0)

    -- controls

    local adsSensPanel = vgui.Create("DPanel", controls)
    adsSensPanel:Dock(TOP)
    adsSensPanel:SetSize(0, EFGM.MenuScale(50))
    function adsSensPanel:Paint(w, h)

        draw.SimpleTextOutlined("Aim Down Sights Sensitivity", "Purista18", w / 2, EFGM.MenuScale(5), Colors.whiteColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 1, Colors.blackColor)

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

        draw.SimpleTextOutlined("Gradual Aim Down Sights Sensitivity", "Purista18", w / 2, EFGM.MenuScale(5), Colors.whiteColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 1, Colors.blackColor)

    end

    local gradualADS = vgui.Create("DCheckBox", gradualADSPanel)
    gradualADS:SetPos(EFGM.MenuScale(152), EFGM.MenuScale(30))
    gradualADS:SetConVar("arc9_gradual_sens")
    gradualADS:SetSize(EFGM.MenuScale(15), EFGM.MenuScale(15))

    local magnificationCompensationPanel = vgui.Create("DPanel", controls)
    magnificationCompensationPanel:Dock(TOP)
    magnificationCompensationPanel:SetSize(0, EFGM.MenuScale(50))
    function magnificationCompensationPanel:Paint(w, h)

        draw.SimpleTextOutlined("Scale Sensitivity With Magnification", "Purista18", w / 2, EFGM.MenuScale(5), Colors.whiteColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 1, Colors.blackColor)

    end

    local bindsControlsTitle = vgui.Create("DPanel", controls)
    bindsControlsTitle:Dock(TOP)
    bindsControlsTitle:SetSize(0, EFGM.MenuScale(32))
    function bindsControlsTitle:Paint(w, h)

        draw.SimpleTextOutlined("KEYBINDS", "PuristaBold32", w / 2, 0, Colors.whiteColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 1, Colors.blackColor)

    end

    local magnificationCompensation = vgui.Create("DCheckBox", magnificationCompensationPanel)
    magnificationCompensation:SetPos(EFGM.MenuScale(152), EFGM.MenuScale(30))
    magnificationCompensation:SetConVar("arc9_compensate_sens")
    magnificationCompensation:SetSize(EFGM.MenuScale(15), EFGM.MenuScale(15))

    local gameMenuPanel = vgui.Create("DPanel", controls)
    gameMenuPanel:Dock(TOP)
    gameMenuPanel:SetSize(0, EFGM.MenuScale(55))
    function gameMenuPanel:Paint(w, h)

        draw.SimpleTextOutlined("Game Menu", "Purista18", w / 2, EFGM.MenuScale(5), Colors.whiteColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 1, Colors.blackColor)

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

        draw.SimpleTextOutlined("Show Compass", "Purista18", w / 2, EFGM.MenuScale(5), Colors.whiteColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 1, Colors.blackColor)

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

        draw.SimpleTextOutlined("Show Extracts", "Purista18", w / 2, EFGM.MenuScale(5), Colors.whiteColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 1, Colors.blackColor)

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

        draw.SimpleTextOutlined("Lean Left", "Purista18", w / 2, EFGM.MenuScale(5), Colors.whiteColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 1, Colors.blackColor)

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

        draw.SimpleTextOutlined("Lean Right", "Purista18", w / 2, EFGM.MenuScale(5), Colors.whiteColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 1, Colors.blackColor)

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

        draw.SimpleTextOutlined("Free Look", "Purista18", w / 2, EFGM.MenuScale(5), Colors.whiteColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 1, Colors.blackColor)

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

        draw.SimpleTextOutlined("Toggle Fire Mode", "Purista18", w / 2, EFGM.MenuScale(5), Colors.whiteColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 1, Colors.blackColor)

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

        draw.SimpleTextOutlined("Change Sight Zoom/Reticle", "Purista18", w / 2, EFGM.MenuScale(5), Colors.whiteColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 1, Colors.blackColor)

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

        draw.SimpleTextOutlined("Toggle UBGL (Under Barrel Launcher)", "Purista18", w / 2, EFGM.MenuScale(5), Colors.whiteColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 1, Colors.blackColor)

    end

    local toggleUBGL = vgui.Create("DBinder", toggleUBGLPanel)
    toggleUBGL:SetPos(EFGM.MenuScale(110), EFGM.MenuScale(30))
    toggleUBGL:SetSize(EFGM.MenuScale(100), EFGM.MenuScale(20))
    toggleUBGL:SetSelectedNumber(GetConVar("efgm_bind_toggleubgl"):GetInt())
    function toggleUBGL:OnChange(num)

        RunConsoleCommand("efgm_bind_toggleubgl", toggleUBGL:GetSelectedNumber())

    end

    local inspectWeaponPanel = vgui.Create("DPanel", controls)
    inspectWeaponPanel:Dock(TOP)
    inspectWeaponPanel:SetSize(0, EFGM.MenuScale(55))
    function inspectWeaponPanel:Paint(w, h)

        draw.SimpleTextOutlined("Inspect Weapon", "Purista18", w / 2, EFGM.MenuScale(5), Colors.whiteColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 1, Colors.blackColor)

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

        draw.SimpleTextOutlined("Invite Player To Squad", "Purista18", w / 2, EFGM.MenuScale(5), Colors.whiteColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 1, Colors.blackColor)

    end

    local teamInvite = vgui.Create("DBinder", teamInvitePanel)
    teamInvite:SetPos(EFGM.MenuScale(110), EFGM.MenuScale(30))
    teamInvite:SetSize(EFGM.MenuScale(100), EFGM.MenuScale(20))
    teamInvite:SetSelectedNumber(GetConVar("efgm_bind_teaminvite"):GetInt())
    function teamInvite:OnChange(num)

        RunConsoleCommand("efgm_bind_teaminvite", teamInvite:GetSelectedNumber())

    end

    local duelInvitePanel = vgui.Create("DPanel", controls)
    duelInvitePanel:Dock(TOP)
    duelInvitePanel:SetSize(0, EFGM.MenuScale(55))
    function duelInvitePanel:Paint(w, h)

        draw.SimpleTextOutlined("Invite Player To Duel", "Purista18", w / 2, EFGM.MenuScale(5), Colors.whiteColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 1, Colors.blackColor)

    end

    local duelInvite = vgui.Create("DBinder", duelInvitePanel)
    duelInvite:SetPos(EFGM.MenuScale(110), EFGM.MenuScale(30))
    duelInvite:SetSize(EFGM.MenuScale(100), EFGM.MenuScale(20))
    duelInvite:SetSelectedNumber(GetConVar("efgm_bind_duelinvite"):GetInt())
    function duelInvite:OnChange(num)

        RunConsoleCommand("efgm_bind_duelinvite", duelInvite:GetSelectedNumber())

    end

    local acceptInvitePanel = vgui.Create("DPanel", controls)
    acceptInvitePanel:Dock(TOP)
    acceptInvitePanel:SetSize(0, EFGM.MenuScale(55))
    function acceptInvitePanel:Paint(w, h)

        draw.SimpleTextOutlined("Accept Invite", "Purista18", w / 2, EFGM.MenuScale(5), Colors.whiteColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 1, Colors.blackColor)

    end

    local acceptInvite = vgui.Create("DBinder", acceptInvitePanel)
    acceptInvite:SetPos(EFGM.MenuScale(110), EFGM.MenuScale(30))
    acceptInvite:SetSize(EFGM.MenuScale(100), EFGM.MenuScale(20))
    acceptInvite:SetSelectedNumber(GetConVar("efgm_bind_invites_accept"):GetInt())
    function acceptInvite:OnChange(num)

        RunConsoleCommand("efgm_bind_invites_accept", acceptInvite:GetSelectedNumber())

    end

    local declineInvitePanel = vgui.Create("DPanel", controls)
    declineInvitePanel:Dock(TOP)
    declineInvitePanel:SetSize(0, EFGM.MenuScale(55))
    function declineInvitePanel:Paint(w, h)

        draw.SimpleTextOutlined("Ignore Invite", "Purista18", w / 2, EFGM.MenuScale(5), Colors.whiteColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 1, Colors.blackColor)

    end

    local declineInvite = vgui.Create("DBinder", declineInvitePanel)
    declineInvite:SetPos(EFGM.MenuScale(110), EFGM.MenuScale(30))
    declineInvite:SetSize(EFGM.MenuScale(100), EFGM.MenuScale(20))
    declineInvite:SetSelectedNumber(GetConVar("efgm_bind_invites_decline"):GetInt())
    function declineInvite:OnChange(num)

        RunConsoleCommand("efgm_bind_invites_decline", declineInvite:GetSelectedNumber())

    end

    local primaryWeaponPanel = vgui.Create("DPanel", controls)
    primaryWeaponPanel:Dock(TOP)
    primaryWeaponPanel:SetSize(0, EFGM.MenuScale(55))
    function primaryWeaponPanel:Paint(w, h)

        draw.SimpleTextOutlined("Primary Weapon", "Purista18", w / 2, EFGM.MenuScale(5), Colors.whiteColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 1, Colors.blackColor)

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

        draw.SimpleTextOutlined("Secondary Weapon", "Purista18", w / 2, EFGM.MenuScale(5), Colors.whiteColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 1, Colors.blackColor)

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

        draw.SimpleTextOutlined("Holster Weapon", "Purista18", w / 2, EFGM.MenuScale(5), Colors.whiteColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 1, Colors.blackColor)

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

        draw.SimpleTextOutlined("Melee Weapon", "Purista18", w / 2, EFGM.MenuScale(5), Colors.whiteColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 1, Colors.blackColor)

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

        draw.SimpleTextOutlined("Throwable", "Purista18", w / 2, EFGM.MenuScale(5), Colors.whiteColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 1, Colors.blackColor)

    end

    local utilityThrowable = vgui.Create("DBinder", utilityThrowablePanel)
    utilityThrowable:SetPos(EFGM.MenuScale(110), EFGM.MenuScale(30))
    utilityThrowable:SetSize(EFGM.MenuScale(100), EFGM.MenuScale(20))
    utilityThrowable:SetSelectedNumber(GetConVar("efgm_bind_equip_utility"):GetInt())
    function utilityThrowable:OnChange(num)

        RunConsoleCommand("efgm_bind_equip_utility", utilityThrowable:GetSelectedNumber())

    end

    local gmodControlsTitle = vgui.Create("DPanel", controls)
    gmodControlsTitle:Dock(TOP)
    gmodControlsTitle:SetSize(0, EFGM.MenuScale(54))
    function gmodControlsTitle:Paint(w, h)

        draw.SimpleTextOutlined("GARRY'S MOD KEYBINDS", "PuristaBold32", w / 2, 0, Colors.whiteColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 1, Colors.blackColor)
        draw.SimpleTextOutlined("[MUST BE CHANGED IN YOUR GAME OPTIONS]", "PuristaBold18", w / 2, EFGM.MenuScale(30), Colors.whiteColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 1, Colors.blackColor)

    end

    local customizeWeaponPanel = vgui.Create("DPanel", controls)
    customizeWeaponPanel:Dock(TOP)
    customizeWeaponPanel:SetSize(0, EFGM.MenuScale(65))
    function customizeWeaponPanel:Paint(w, h)

        draw.SimpleTextOutlined("Customize Weapon", "Purista18", w / 2, EFGM.MenuScale(5), Colors.whiteColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 1, Colors.blackColor)
        draw.SimpleTextOutlined("Keyboard > Garry's Mod > Open context menu", "Purista14", w / 2, EFGM.MenuScale(20), Colors.whiteColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 1, Colors.blackColor)

    end

    local customizeWeapon = vgui.Create("DBinder", customizeWeaponPanel)
    customizeWeapon:SetPos(EFGM.MenuScale(110), EFGM.MenuScale(40))
    customizeWeapon:SetSize(EFGM.MenuScale(100), EFGM.MenuScale(20))
    customizeWeapon:SetSelectedNumber(input.GetKeyCode(input.LookupBinding("+menu_context") or 0))
    customizeWeapon:SetEnabled(false)
    customizeWeapon:SetTooltip(nil)

    local buyAttPanel = vgui.Create("DPanel", controls)
    buyAttPanel:Dock(TOP)
    buyAttPanel:SetSize(0, EFGM.MenuScale(65))
    function buyAttPanel:Paint(w, h)

        draw.SimpleTextOutlined("Purchase Hovered Attachment", "Purista18", w / 2, EFGM.MenuScale(5), Colors.whiteColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 1, Colors.blackColor)
        draw.SimpleTextOutlined("Keyboard > Combat > Reload weapon", "Purista14", w / 2, EFGM.MenuScale(20), Colors.whiteColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 1, Colors.blackColor)

    end

    local buyAtt = vgui.Create("DBinder", buyAttPanel)
    buyAtt:SetPos(EFGM.MenuScale(110), EFGM.MenuScale(40))
    buyAtt:SetSize(EFGM.MenuScale(100), EFGM.MenuScale(20))
    buyAtt:SetSelectedNumber(input.GetKeyCode(input.LookupBinding("+reload") or 0))
    buyAtt:SetEnabled(false)
    buyAtt:SetTooltip(nil)

    local toggleTacticalPanel = vgui.Create("DPanel", controls)
    toggleTacticalPanel:Dock(TOP)
    toggleTacticalPanel:SetSize(0, EFGM.MenuScale(65))
    function toggleTacticalPanel:Paint(w, h)

        draw.SimpleTextOutlined("Toggle Tactical Devices (lasers/lights)", "Purista18", w / 2, EFGM.MenuScale(5), Colors.whiteColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 1, Colors.blackColor)
        draw.SimpleTextOutlined("Keyboard > Combat > Flashlight", "Purista14", w / 2, EFGM.MenuScale(20), Colors.whiteColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 1, Colors.blackColor)

    end

    local toggleTactical = vgui.Create("DBinder", toggleTacticalPanel)
    toggleTactical:SetPos(EFGM.MenuScale(110), EFGM.MenuScale(40))
    toggleTactical:SetSize(EFGM.MenuScale(100), EFGM.MenuScale(20))
    toggleTactical:SetSelectedNumber(input.GetKeyCode(input.LookupBinding("impulse 100") or 0))
    toggleTactical:SetEnabled(false)
    toggleTactical:SetTooltip(nil)

    local graduallyZoomInScopePanel = vgui.Create("DPanel", controls)
    graduallyZoomInScopePanel:Dock(TOP)
    graduallyZoomInScopePanel:SetSize(0, EFGM.MenuScale(65))
    function graduallyZoomInScopePanel:Paint(w, h)

        draw.SimpleTextOutlined("Gradually Zoom In Scope Magnification", "Purista18", w / 2, EFGM.MenuScale(5), Colors.whiteColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 1, Colors.blackColor)
        draw.SimpleTextOutlined("Keyboard > Combat > Previous weapon", "Purista14", w / 2, EFGM.MenuScale(20), Colors.whiteColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 1, Colors.blackColor)

    end

    local graduallyZoomInScope = vgui.Create("DBinder", graduallyZoomInScopePanel)
    graduallyZoomInScope:SetPos(EFGM.MenuScale(110), EFGM.MenuScale(40))
    graduallyZoomInScope:SetSize(EFGM.MenuScale(100), EFGM.MenuScale(20))
    graduallyZoomInScope:SetSelectedNumber(input.GetKeyCode(input.LookupBinding("invprev") or 0))
    graduallyZoomInScope:SetEnabled(false)
    graduallyZoomInScope:SetTooltip(nil)

    local graduallyZoomOutScopePanel = vgui.Create("DPanel", controls)
    graduallyZoomOutScopePanel:Dock(TOP)
    graduallyZoomOutScopePanel:SetSize(0, EFGM.MenuScale(65))
    function graduallyZoomOutScopePanel:Paint(w, h)

        draw.SimpleTextOutlined("Gradually Zoom Out Scope Magnification", "Purista18", w / 2, EFGM.MenuScale(5), Colors.whiteColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 1, Colors.blackColor)
        draw.SimpleTextOutlined("Keyboard > Combat > Next weapon", "Purista14", w / 2, EFGM.MenuScale(20), Colors.whiteColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 1, Colors.blackColor)

    end

    local graduallyZoomOutScope = vgui.Create("DBinder", graduallyZoomOutScopePanel)
    graduallyZoomOutScope:SetPos(EFGM.MenuScale(110), EFGM.MenuScale(40))
    graduallyZoomOutScope:SetSize(EFGM.MenuScale(100), EFGM.MenuScale(20))
    graduallyZoomOutScope:SetSelectedNumber(input.GetKeyCode(input.LookupBinding("invnext") or 0))
    graduallyZoomOutScope:SetEnabled(false)
    graduallyZoomOutScope:SetTooltip(nil)

    local transmitVoicePanel = vgui.Create("DPanel", controls)
    transmitVoicePanel:Dock(TOP)
    transmitVoicePanel:SetSize(0, EFGM.MenuScale(65))
    function transmitVoicePanel:Paint(w, h)

        draw.SimpleTextOutlined("Transmit Voice Over Proximity Chat", "Purista18", w / 2, EFGM.MenuScale(5), Colors.whiteColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 1, Colors.blackColor)
        draw.SimpleTextOutlined("Keyboard > Communication > Use voice communication", "Purista14", w / 2, EFGM.MenuScale(20), Colors.whiteColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 1, Colors.blackColor)

    end

    local transmitVoice = vgui.Create("DBinder", transmitVoicePanel)
    transmitVoice:SetPos(EFGM.MenuScale(110), EFGM.MenuScale(40))
    transmitVoice:SetSize(EFGM.MenuScale(100), EFGM.MenuScale(20))
    transmitVoice:SetSelectedNumber(input.GetKeyCode(input.LookupBinding("+voicerecord") or 0))
    transmitVoice:SetEnabled(false)
    transmitVoice:SetTooltip(nil)

    local sendTextAllPanel = vgui.Create("DPanel", controls)
    sendTextAllPanel:Dock(TOP)
    sendTextAllPanel:SetSize(0, EFGM.MenuScale(65))
    function sendTextAllPanel:Paint(w, h)

        draw.SimpleTextOutlined("Send Message To All Chat", "Purista18", w / 2, EFGM.MenuScale(5), Colors.whiteColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 1, Colors.blackColor)
        draw.SimpleTextOutlined("Keyboard > Communication > Chat message", "Purista14", w / 2, EFGM.MenuScale(20), Colors.whiteColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 1, Colors.blackColor)

    end

    local sendTextAll = vgui.Create("DBinder", sendTextAllPanel)
    sendTextAll:SetPos(EFGM.MenuScale(110), EFGM.MenuScale(40))
    sendTextAll:SetSize(EFGM.MenuScale(100), EFGM.MenuScale(20))
    sendTextAll:SetSelectedNumber(input.GetKeyCode(input.LookupBinding("messagemode") or 0))
    sendTextAll:SetEnabled(false)
    sendTextAll:SetTooltip(nil)

    local sendTextSquadPanel = vgui.Create("DPanel", controls)
    sendTextSquadPanel:Dock(TOP)
    sendTextSquadPanel:SetSize(0, EFGM.MenuScale(65))
    function sendTextSquadPanel:Paint(w, h)

        draw.SimpleTextOutlined("Send Message To Squad Chat", "Purista18", w / 2, EFGM.MenuScale(5), Colors.whiteColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 1, Colors.blackColor)
        draw.SimpleTextOutlined("Keyboard > Communication > Team message", "Purista14", w / 2, EFGM.MenuScale(20), Colors.whiteColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 1, Colors.blackColor)

    end

    local sendTextSquad = vgui.Create("DBinder", sendTextSquadPanel)
    sendTextSquad:SetPos(EFGM.MenuScale(110), EFGM.MenuScale(40))
    sendTextSquad:SetSize(EFGM.MenuScale(100), EFGM.MenuScale(20))
    sendTextSquad:SetSelectedNumber(input.GetKeyCode(input.LookupBinding("messagemode2") or 0))
    sendTextSquad:SetEnabled(false)
    sendTextSquad:SetTooltip(nil)

    local applySprayPanel = vgui.Create("DPanel", controls)
    applySprayPanel:Dock(TOP)
    applySprayPanel:SetSize(0, EFGM.MenuScale(65))
    function applySprayPanel:Paint(w, h)

        draw.SimpleTextOutlined("Apply Spray Paint", "Purista18", w / 2, EFGM.MenuScale(5), Colors.whiteColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 1, Colors.blackColor)
        draw.SimpleTextOutlined("Keyboard > Communication > Spray logo", "Purista14", w / 2, EFGM.MenuScale(20), Colors.whiteColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 1, Colors.blackColor)

    end

    local applySpray = vgui.Create("DBinder", applySprayPanel)
    applySpray:SetPos(EFGM.MenuScale(110), EFGM.MenuScale(40))
    applySpray:SetSize(EFGM.MenuScale(100), EFGM.MenuScale(20))
    applySpray:SetSelectedNumber(input.GetKeyCode(input.LookupBinding("impulse 201") or 0))
    applySpray:SetEnabled(false)
    applySpray:SetTooltip(nil)

    -- interface

    local hudEnablePanel = vgui.Create("DPanel", interface)
    hudEnablePanel:Dock(TOP)
    hudEnablePanel:SetSize(0, EFGM.MenuScale(50))
    function hudEnablePanel:Paint(w, h)

        draw.SimpleTextOutlined("Enable HUD", "Purista18", w / 2, EFGM.MenuScale(5), Colors.whiteColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 1, Colors.blackColor)

    end

    local hudEnable = vgui.Create("DCheckBox", hudEnablePanel)
    hudEnable:SetPos(EFGM.MenuScale(152), EFGM.MenuScale(30))
    hudEnable:SetConVar("efgm_hud_enable")
    hudEnable:SetSize(EFGM.MenuScale(15), EFGM.MenuScale(15))

    local hudScalePanel = vgui.Create("DPanel", interface)
    hudScalePanel:Dock(TOP)
    hudScalePanel:SetSize(0, EFGM.MenuScale(50))
    function hudScalePanel:Paint(w, h)

        draw.SimpleTextOutlined("HUD Scale", "Purista18", w / 2, EFGM.MenuScale(5), Colors.whiteColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 1, Colors.blackColor)

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

        draw.SimpleTextOutlined("Menu Parallax", "Purista18", w / 2, EFGM.MenuScale(5), Colors.whiteColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 1, Colors.blackColor)

    end

    local menuParallax = vgui.Create("DCheckBox", menuParallaxPanel)
    menuParallax:SetPos(EFGM.MenuScale(152), EFGM.MenuScale(30))
    menuParallax:SetConVar("efgm_menu_parallax")
    menuParallax:SetSize(EFGM.MenuScale(15), EFGM.MenuScale(15))

    local menuScalingMethodPanel = vgui.Create("DPanel", interface)
    menuScalingMethodPanel:Dock(TOP)
    menuScalingMethodPanel:SetSize(0, EFGM.MenuScale(55))
    function menuScalingMethodPanel:Paint(w, h)

        draw.SimpleTextOutlined("Menu Scaling Method", "Purista18", w / 2, EFGM.MenuScale(5), Colors.whiteColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 1, Colors.blackColor)

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

    local menuDoubleConsumePanel = vgui.Create("DPanel", interface)
    menuDoubleConsumePanel:Dock(TOP)
    menuDoubleConsumePanel:SetSize(0, EFGM.MenuScale(50))
    function menuDoubleConsumePanel:Paint(w, h)

        draw.SimpleTextOutlined("Consume Item On Double Click", "Purista18", w / 2, EFGM.MenuScale(5), Colors.whiteColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 1, Colors.blackColor)

    end

    local menuDoubleConsume = vgui.Create("DCheckBox", menuDoubleConsumePanel)
    menuDoubleConsume:SetPos(EFGM.MenuScale(152), EFGM.MenuScale(30))
    menuDoubleConsume:SetConVar("efgm_menu_doubleclick_consume")
    menuDoubleConsume:SetSize(EFGM.MenuScale(15), EFGM.MenuScale(15))

    local menuDeletePromptPanel = vgui.Create("DPanel", interface)
    menuDeletePromptPanel:Dock(TOP)
    menuDeletePromptPanel:SetSize(0, EFGM.MenuScale(50))
    function menuDeletePromptPanel:Paint(w, h)

        draw.SimpleTextOutlined("Show Confirmation On Item Deletion", "Purista18", w / 2, EFGM.MenuScale(5), Colors.whiteColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 1, Colors.blackColor)

    end

    local menuDeletePrompt = vgui.Create("DCheckBox", menuDeletePromptPanel)
    menuDeletePrompt:SetPos(EFGM.MenuScale(152), EFGM.MenuScale(30))
    menuDeletePrompt:SetConVar("efgm_menu_deleteprompt")
    menuDeletePrompt:SetSize(EFGM.MenuScale(15), EFGM.MenuScale(15))

    local menuSellPromptPanel = vgui.Create("DPanel", interface)
    menuSellPromptPanel:Dock(TOP)
    menuSellPromptPanel:SetSize(0, EFGM.MenuScale(50))
    function menuSellPromptPanel:Paint(w, h)

        draw.SimpleTextOutlined("Show Confirmation On Single Item Sell", "Purista18", w / 2, EFGM.MenuScale(5), Colors.whiteColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 1, Colors.blackColor)

    end

    local menuSellPrompt = vgui.Create("DCheckBox", menuSellPromptPanel)
    menuSellPrompt:SetPos(EFGM.MenuScale(152), EFGM.MenuScale(30))
    menuSellPrompt:SetConVar("efgm_menu_sellprompt_single")
    menuSellPrompt:SetSize(EFGM.MenuScale(15), EFGM.MenuScale(15))

    local menuSellStackedPromptPanel = vgui.Create("DPanel", interface)
    menuSellStackedPromptPanel:Dock(TOP)
    menuSellStackedPromptPanel:SetSize(0, EFGM.MenuScale(50))
    function menuSellStackedPromptPanel:Paint(w, h)

        draw.SimpleTextOutlined("Show Confirmation On Stacked Item Sell", "Purista18", w / 2, EFGM.MenuScale(5), Colors.whiteColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 1, Colors.blackColor)

    end

    local menuSellStackedPrompt = vgui.Create("DCheckBox", menuSellStackedPromptPanel)
    menuSellStackedPrompt:SetPos(EFGM.MenuScale(152), EFGM.MenuScale(30))
    menuSellStackedPrompt:SetConVar("efgm_menu_sellprompt_stacked")
    menuSellStackedPrompt:SetSize(EFGM.MenuScale(15), EFGM.MenuScale(15))

    local menuSearchModePanel = vgui.Create("DPanel", interface)
    menuSearchModePanel:Dock(TOP)
    menuSearchModePanel:SetSize(0, EFGM.MenuScale(50))
    function menuSearchModePanel:Paint(w, h)

        draw.SimpleTextOutlined("Auto Search On Search Box Text Change", "Purista18", w / 2, EFGM.MenuScale(5), Colors.whiteColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 1, Colors.blackColor)

    end

    local menuSearchMode = vgui.Create("DCheckBox", menuSearchModePanel)
    menuSearchMode:SetPos(EFGM.MenuScale(152), EFGM.MenuScale(30))
    menuSearchMode:SetConVar("efgm_menu_search_automatic")
    menuSearchMode:SetSize(EFGM.MenuScale(15), EFGM.MenuScale(15))

    -- visuals

    local vmFOVPanel = vgui.Create("DPanel", visuals)
    vmFOVPanel:Dock(TOP)
    vmFOVPanel:SetSize(0, EFGM.MenuScale(50))
    function vmFOVPanel:Paint(w, h)

        draw.SimpleTextOutlined("Viewmodel FOV Scale [EXPERIMENTAL]", "Purista18", w / 2, EFGM.MenuScale(5), Colors.whiteColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 1, Colors.blackColor)

    end

    local vmFOV = vgui.Create("DNumSlider", vmFOVPanel)
    vmFOV:SetPos(EFGM.MenuScale(35), EFGM.MenuScale(30))
    vmFOV:SetSize(EFGM.MenuScale(200), EFGM.MenuScale(15))
    vmFOV:SetConVar("arc9_fov")
    vmFOV:SetMin(-10)
    vmFOV:SetMax(30)
    vmFOV:SetDecimals(0)

    local headBobPanel = vgui.Create("DPanel", visuals)
    headBobPanel:Dock(TOP)
    headBobPanel:SetSize(0, EFGM.MenuScale(50))
    function headBobPanel:Paint(w, h)

        draw.SimpleTextOutlined("Head Bobbing", "Purista18", w / 2, EFGM.MenuScale(5), Colors.whiteColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 1, Colors.blackColor)

    end

    local headBob = vgui.Create("DCheckBox", headBobPanel)
    headBob:SetPos(EFGM.MenuScale(152), EFGM.MenuScale(30))
    headBob:SetConVar("efgm_visuals_headbob")
    headBob:SetSize(EFGM.MenuScale(15), EFGM.MenuScale(15))

    local lensFlarePanel = vgui.Create("DPanel", visuals)
    lensFlarePanel:Dock(TOP)
    lensFlarePanel:SetSize(0, EFGM.MenuScale(50))
    function lensFlarePanel:Paint(w, h)

        draw.SimpleTextOutlined("Lens Flare", "Purista18", w / 2, EFGM.MenuScale(5), Colors.whiteColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 1, Colors.blackColor)

    end

    local lensFlare = vgui.Create("DCheckBox", lensFlarePanel)
    lensFlare:SetPos(EFGM.MenuScale(152), EFGM.MenuScale(30))
    lensFlare:SetConVar("efgm_visuals_lensflare")
    lensFlare:SetSize(EFGM.MenuScale(15), EFGM.MenuScale(15))

    local pmShadowPanel = vgui.Create("DPanel", visuals)
    pmShadowPanel:Dock(TOP)
    pmShadowPanel:SetSize(0, EFGM.MenuScale(50))
    function pmShadowPanel:Paint(w, h)

        draw.SimpleTextOutlined("Render Own Player Model Shadow", "Purista18", w / 2, EFGM.MenuScale(5), Colors.whiteColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 1, Colors.blackColor)

    end

    local pmShadow = vgui.Create("DCheckBox", pmShadowPanel)
    pmShadow:SetPos(EFGM.MenuScale(152), EFGM.MenuScale(30))
    pmShadow:SetConVar("efgm_visuals_selfshadow")
    pmShadow:SetSize(EFGM.MenuScale(15), EFGM.MenuScale(15))

    local vmLightingPanel = vgui.Create("DPanel", visuals)
    vmLightingPanel:Dock(TOP)
    vmLightingPanel:SetSize(0, EFGM.MenuScale(50))
    function vmLightingPanel:Paint(w, h)

        draw.SimpleTextOutlined("High Quality Viewmodel Lighting", "Purista18", w / 2, EFGM.MenuScale(5), Colors.whiteColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 1, Colors.blackColor)

    end

    local vmLighting = vgui.Create("DCheckBox", vmLightingPanel)
    vmLighting:SetPos(EFGM.MenuScale(152), EFGM.MenuScale(30))
    vmLighting:SetConVar("arc9_drawprojectedlights")
    vmLighting:SetSize(EFGM.MenuScale(15), EFGM.MenuScale(15))

    local impactFXPanel = vgui.Create("DPanel", visuals)
    impactFXPanel:Dock(TOP)
    impactFXPanel:SetSize(0, EFGM.MenuScale(50))
    function impactFXPanel:Paint(w, h)

        draw.SimpleTextOutlined("High Quality Bullet Impact FX", "Purista18", w / 2, EFGM.MenuScale(5), Colors.whiteColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 1, Colors.blackColor)

    end

    local impactFX = vgui.Create("DCheckBox", impactFXPanel)
    impactFX:SetPos(EFGM.MenuScale(152), EFGM.MenuScale(30))
    impactFX:SetConVar("efgm_visuals_highqualimpactfx")
    impactFX:SetSize(EFGM.MenuScale(15), EFGM.MenuScale(15))

    local tpikAllPanel = vgui.Create("DPanel", visuals)
    tpikAllPanel:Dock(TOP)
    tpikAllPanel:SetSize(0, EFGM.MenuScale(50))
    function tpikAllPanel:Paint(w, h)

        draw.SimpleTextOutlined("TPP Animations On Other Players", "Purista18", w / 2, EFGM.MenuScale(5), Colors.whiteColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 1, Colors.blackColor)

    end

    local tpikAll = vgui.Create("DCheckBox", tpikAllPanel)
    tpikAll:SetPos(EFGM.MenuScale(152), EFGM.MenuScale(30))
    tpikAll:SetConVar("arc9_tpik_others")
    tpikAll:SetSize(EFGM.MenuScale(15), EFGM.MenuScale(15))

    local ejectedShellLifePanel = vgui.Create("DPanel", visuals)
    ejectedShellLifePanel:Dock(TOP)
    ejectedShellLifePanel:SetSize(0, EFGM.MenuScale(50))
    function ejectedShellLifePanel:Paint(w, h)

        draw.SimpleTextOutlined("Ejected Bullet Casing Life Time", "Purista18", w / 2, EFGM.MenuScale(5), Colors.whiteColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 1, Colors.blackColor)

    end

    local ejectedShellLife = vgui.Create("DNumSlider", ejectedShellLifePanel)
    ejectedShellLife:SetPos(EFGM.MenuScale(35), EFGM.MenuScale(30))
    ejectedShellLife:SetSize(EFGM.MenuScale(200), EFGM.MenuScale(15))
    ejectedShellLife:SetConVar("arc9_eject_time")
    ejectedShellLife:SetMin(0)
    ejectedShellLife:SetMax(10)
    ejectedShellLife:SetDecimals(0)

    local lodDistancePanel = vgui.Create("DPanel", visuals)
    lodDistancePanel:Dock(TOP)
    lodDistancePanel:SetSize(0, EFGM.MenuScale(50))
    function lodDistancePanel:Paint(w, h)

        draw.SimpleTextOutlined("LOD (Level Of Detail) Distance Multiplier", "Purista18", w / 2, EFGM.MenuScale(5), Colors.whiteColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 1, Colors.blackColor)

    end

    local lodDistance = vgui.Create("DNumSlider", lodDistancePanel)
    lodDistance:SetPos(EFGM.MenuScale(35), EFGM.MenuScale(30))
    lodDistance:SetSize(EFGM.MenuScale(200), EFGM.MenuScale(15))
    lodDistance:SetConVar("arc9_lod_distance")
    lodDistance:SetMin(0.3)
    lodDistance:SetMax(3)
    lodDistance:SetDecimals(1)

    -- account

    local factionPreferencePanel = vgui.Create("DPanel", account)
    factionPreferencePanel:Dock(TOP)
    factionPreferencePanel:SetSize(0, EFGM.MenuScale(55))
    function factionPreferencePanel:Paint(w, h)

        draw.SimpleTextOutlined("Faction Preference", "Purista18", w / 2, EFGM.MenuScale(5), Colors.whiteColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 1, Colors.blackColor)

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

        draw.SimpleTextOutlined("Receive Squad Invites From", "Purista18", w / 2, EFGM.MenuScale(5), Colors.whiteColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 1, Colors.blackColor)

    end

    local invitePrivacy = vgui.Create("DComboBox", invitePrivacyPanel)
    invitePrivacy:SetPos(EFGM.MenuScale(100), EFGM.MenuScale(30))
    invitePrivacy:SetSize(EFGM.MenuScale(120), EFGM.MenuScale(20))

    if GetConVar("efgm_privacy_invites_squad"):GetInt() == 0 then
        invitePrivacy:SetValue("Nobody")
    elseif GetConVar("efgm_privacy_invites_squad"):GetInt() == 1 then
        invitePrivacy:SetValue("Steam Friends")
    elseif GetConVar("efgm_privacy_invites_squad"):GetInt() == 2  then
        invitePrivacy:SetValue("Everyone")
    end

    invitePrivacy:AddChoice("Nobody")
    invitePrivacy:AddChoice("Steam Friends")
    invitePrivacy:AddChoice("Everyone")
    invitePrivacy:SetSortItems(false)
    invitePrivacy.OnSelect = function(self, value)
        RunConsoleCommand("efgm_privacy_invites_squad", value - 1)
    end

    local duelPrivacyPanel = vgui.Create("DPanel", account)
    duelPrivacyPanel:Dock(TOP)
    duelPrivacyPanel:SetSize(0, EFGM.MenuScale(55))
    function duelPrivacyPanel:Paint(w, h)

        draw.SimpleTextOutlined("Receive Duel Invites From", "Purista18", w / 2, EFGM.MenuScale(5), Colors.whiteColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 1, Colors.blackColor)

    end

    local duelPrivacy = vgui.Create("DComboBox", duelPrivacyPanel)
    duelPrivacy:SetPos(EFGM.MenuScale(100), EFGM.MenuScale(30))
    duelPrivacy:SetSize(EFGM.MenuScale(120), EFGM.MenuScale(20))

    if GetConVar("efgm_privacy_invites_duel"):GetInt() == 0 then
        duelPrivacy:SetValue("Nobody")
    elseif GetConVar("efgm_privacy_invites_duel"):GetInt() == 1 then
        duelPrivacy:SetValue("Steam Friends")
    elseif GetConVar("efgm_privacy_invites_duel"):GetInt() == 2  then
        duelPrivacy:SetValue("Everyone")
    end

    duelPrivacy:AddChoice("Nobody")
    duelPrivacy:AddChoice("Steam Friends")
    duelPrivacy:AddChoice("Everyone")
    duelPrivacy:SetSortItems(false)
    duelPrivacy.OnSelect = function(self, value)
        RunConsoleCommand("efgm_privacy_invites_duel", value - 1)
    end

    local invitesBlockedPanel = vgui.Create("DPanel", account)
    invitesBlockedPanel:Dock(TOP)
    invitesBlockedPanel:SetSize(0, EFGM.MenuScale(50))
    function invitesBlockedPanel:Paint(w, h)

        draw.SimpleTextOutlined("Receive Invites From Blocked Players", "Purista18", w / 2, EFGM.MenuScale(5), Colors.whiteColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 1, Colors.blackColor)

    end

    local invitesBlocked = vgui.Create("DCheckBox", invitesBlockedPanel)
    invitesBlocked:SetPos(EFGM.MenuScale(152), EFGM.MenuScale(30))
    invitesBlocked:SetConVar("efgm_privacy_invites_blocked")
    invitesBlocked:SetSize(EFGM.MenuScale(15), EFGM.MenuScale(15))

    -- misc
    local clearDecals = vgui.Create("DButton", misc)
    clearDecals:Dock(TOP)
    clearDecals:DockMargin(EFGM.MenuScale(5), EFGM.MenuScale(5), EFGM.MenuScale(5), 0)
    clearDecals:SetSize(0, EFGM.MenuScale(25))
    clearDecals:SetText("CLEAR ALL DECALS")

    function clearDecals:DoClick()

        surface.PlaySound("ui/element_select.wav")
        RunConsoleCommand("r_cleardecals")

    end

    local flushAudio = vgui.Create("DButton", misc)
    flushAudio:Dock(TOP)
    flushAudio:DockMargin(EFGM.MenuScale(5), EFGM.MenuScale(5), EFGM.MenuScale(5), 0)
    flushAudio:SetSize(0, EFGM.MenuScale(25))
    flushAudio:SetText("FLUSH AUDIO ENGINE")

    function flushAudio:DoClick()

        RunConsoleCommand("snd_restart")
        RunConsoleCommand("snd_async_flush")

    end

    local fixInvDesync = vgui.Create("DButton", misc)
    fixInvDesync:Dock(TOP)
    fixInvDesync:DockMargin(EFGM.MenuScale(5), EFGM.MenuScale(5), EFGM.MenuScale(5), 0)
    fixInvDesync:SetSize(0, EFGM.MenuScale(25))
    fixInvDesync:SetText("FIX INVENTORY DESYNC")

    function fixInvDesync:DoClick()

        if timer.Exists(Menu.Player:SteamID() .. "desyncCD") then surface.PlaySound("ui/element_deselect.wav") return end

        surface.PlaySound("ui/element_select.wav")
        net.Start("PlayerInventoryFixDesyncCL")
        net.SendToServer()

        timer.Create(Menu.Player:SteamID() .. "desyncCD", 60, 1, function() end)

    end

end

function Menu.OpenTab.Tasks()

    local contents = vgui.Create("DPanel", Menu.MenuFrame.LowerPanel)
    contents:Dock(FILL)
    contents:DockPadding(EFGM.MenuScale(10), EFGM.MenuScale(10), EFGM.MenuScale(10), EFGM.MenuScale(10))
    contents:SetAlpha(0)
    contents.Paint = nil

    -- Task List

        local taskList = vgui.Create("DPanel", contents)
        taskList:Dock(LEFT)
        taskList:SetSize(EFGM.MenuScale(550), 0)
        taskList.Paint = function(s, w, h)

            BlurPanel(s, EFGM.MenuScale(10))

            surface.SetDrawColor(Colors.containerBackgroundColor)
            surface.DrawRect(0, 0, w, h)

            surface.SetDrawColor(Colors.transparentWhiteColor)
            surface.DrawRect(0, 0, w, EFGM.MenuScale(6))

        end

        function DrawTaskList()

            taskList:Clear()

            local taskListHeader = vgui.Create("DPanel", taskList)
            taskListHeader:Dock(TOP)
            taskListHeader:SetSize(0, EFGM.MenuScale(36))
            function taskListHeader:Paint(w, h)

                surface.SetDrawColor(Colors.containerHeaderColor)
                surface.DrawRect(0, 0, w, h)

                draw.SimpleTextOutlined("TASKS", "PuristaBold32", EFGM.MenuScale(5), EFGM.MenuScale(2), Colors.whiteColor, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP, 1, Colors.blackColor)

            end

            local taskListScroller = vgui.Create("DScrollPanel", taskList)
            taskListScroller:Dock(FILL)

            local taskListBar = taskListScroller:GetVBar()
            taskListBar:SetHideButtons(true)
            taskListBar:SetSize(EFGM.MenuScale(15), EFGM.MenuScale(15))
            function taskListBar:Paint(w, h)
                draw.RoundedBox(0, EFGM.MenuScale(5), EFGM.MenuScale(8), EFGM.MenuScale(5), h - EFGM.MenuScale(16), Colors.scrollerColor)
            end
            function taskListBar.btnGrip:Paint(w, h)
                draw.RoundedBox(0, EFGM.MenuScale(5), EFGM.MenuScale(8), EFGM.MenuScale(5), h - EFGM.MenuScale(16), Colors.transparentWhiteColor)
            end

            if !table.IsEmpty(playerTasks) then

                for taskName, taskInstance in pairs(playerTasks) do

                    local taskInfo = EFGMTASKS[taskName]

                    local taskButton = taskListScroller:Add("DButton")
                    taskButton:SetHeight(EFGM.MenuScale(110))
                    taskButton:SetText("")
                    taskButton:Dock(TOP)
                    taskButton:DockMargin(EFGM.MenuScale(5), EFGM.MenuScale(5), EFGM.MenuScale(5), 0)

                    local genericTaskBG = Material("taskbg/concrete/general.jpg", "smooth")

                    function taskButton:Paint(w, h)

                        surface.SetMaterial(taskInfo.uibackground or genericTaskBG)
                        surface.SetDrawColor(Colors.pureWhiteColor)
                        surface.DrawTexturedRect(0, 0, w, h)

                    end

                    function taskButton:PaintOver(w, h)

                        surface.SetDrawColor(Color(0, 0, 0, 155))
                        surface.DrawRect(0, 0, w, EFGM.MenuScale(36))

                        surface.SetDrawColor(Colors.transparentWhiteColor)
                        surface.DrawRect(0, 0, w, EFGM.MenuScale(6))

                        surface.SetDrawColor(Colors.whiteBorderColor)
                        surface.DrawRect(0, 0, w, EFGM.MenuScale(1))
                        surface.DrawRect(0, h - 1, w, EFGM.MenuScale(1))
                        surface.DrawRect(0, 0, EFGM.MenuScale(1), h)
                        surface.DrawRect(w - 1, 0, EFGM.MenuScale(1), h)

                        draw.SimpleTextOutlined(string.upper(taskInfo.name), "PuristaBold24", EFGM.MenuScale(5), EFGM.MenuScale(7), Colors.whiteColor, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP, 1, Colors.blackColor)

                        draw.SimpleTextOutlined("[" .. string.upper(TASKSTATUSSTRING[playerTasks[taskName].status]) .. "]", "PuristaBold24", w - EFGM.MenuScale(5), EFGM.MenuScale(7), Colors.whiteColor, TEXT_ALIGN_RIGHT, TEXT_ALIGN_TOP, 1, Colors.blackColor)

                    end

                    taskButton.OnCursorEntered = function(s)

                        surface.PlaySound("ui/element_hover_" .. math.random(1, 3) .. ".wav")

                    end

                    function taskButton:DoClick()

                        surface.PlaySound("ui/element_select.wav")
                        DrawTaskDisplay(taskName)

                    end

                end

            end

        end

        DrawTaskList()

    -- Task Display

        local taskDisplay = vgui.Create("DPanel", contents)
        taskDisplay:Dock(LEFT)
        taskDisplay:SetSize(EFGM.MenuScale(1305), 0)
        taskDisplay:DockMargin(EFGM.MenuScale(13), 0, 0, 0)
        taskDisplay.Paint = function(s, w, h)

            BlurPanel(s, EFGM.MenuScale(10))

            surface.SetDrawColor(Colors.containerBackgroundColor)
            surface.DrawRect(0, 0, w, h)

            surface.SetDrawColor(Colors.transparentWhiteColor)
            surface.DrawRect(0, 0, w, EFGM.MenuScale(6))

        end
        taskDisplay:SetVisible(false)

        function DrawTaskDisplay(taskName)

            taskDisplay:Clear()
            taskDisplay:SetVisible(true)

            local taskInfo = EFGMTASKS[taskName]

            local taskDisplayHeader = vgui.Create("DPanel", taskDisplay)
            taskDisplayHeader:Dock(TOP)
            taskDisplayHeader:SetSize(0, EFGM.MenuScale(36))
            function taskDisplayHeader:Paint(w, h)

                surface.SetDrawColor(Colors.containerHeaderColor)
                surface.DrawRect(0, 0, w, h)

                draw.SimpleTextOutlined(string.upper(taskInfo.name), "PuristaBold32", EFGM.MenuScale(5), EFGM.MenuScale(2), Colors.whiteColor, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP, 1, Colors.blackColor)

            end

            -- Accept Button

                if playerTasks[taskName].status == TASKSTATUS.AcceptPending and Menu.Player:CompareStatus(0) then

                    local acceptButton = vgui.Create("DButton", taskDisplay)
                    acceptButton:Dock(TOP)
                    acceptButton:DockMargin(EFGM.MenuScale(5), EFGM.MenuScale(5), EFGM.MenuScale(5), 0)
                    acceptButton:SetSize(0, EFGM.MenuScale(50))
                    acceptButton:SetText("")

                    function acceptButton:Paint(w, h)

                        surface.SetDrawColor(Colors.containerBackgroundColor)
                        surface.DrawRect(0, 0, w, h)

                        surface.SetDrawColor(Colors.transparentWhiteColor)
                        surface.DrawRect(0, 0, acceptButton:GetWide(), EFGM.MenuScale(2))

                        draw.SimpleTextOutlined("ACCEPT", "PuristaBold32", w / 2, EFGM.MenuScale(7), Colors.whiteColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 1, Colors.blackColor)

                    end

                    acceptButton.OnCursorEntered = function(s)

                        surface.PlaySound("ui/element_hover_" .. math.random(1, 3) .. ".wav")

                    end

                    function acceptButton:DoClick()

                        surface.PlaySound("ui/element_select.wav")
                        RunConsoleCommand("efgm_task_accept", taskName)
                        RunConsoleCommand("efgm_task_requestall")
                        taskDisplay:Clear()
                        timer.Simple(0.1, function()
                            DrawTaskDisplay(taskName)
                            DrawTaskList()
                        end)

                    end

                end

            -- Complete button

                if playerTasks[taskName].status == TASKSTATUS.CompletePending and Menu.Player:CompareStatus(0) then

                    local completeButton = vgui.Create("DButton", taskDisplay)
                    completeButton:Dock(TOP)
                    completeButton:DockMargin(EFGM.MenuScale(5), EFGM.MenuScale(5), EFGM.MenuScale(5), 0)
                    completeButton:SetHeight(EFGM.MenuScale(50))
                    completeButton:SetText("")

                    function completeButton:Paint(w, h)

                        surface.SetDrawColor(Colors.containerBackgroundColor)
                        surface.DrawRect(0, 0, w, h)

                        surface.SetDrawColor(Colors.transparentWhiteColor)
                        surface.DrawRect(0, 0, completeButton:GetWide(), EFGM.MenuScale(2))

                        draw.SimpleTextOutlined("COMPLETE", "PuristaBold32", w / 2, EFGM.MenuScale(7), Colors.whiteColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 1, Colors.blackColor)

                    end

                    completeButton.OnCursorEntered = function(s)

                        surface.PlaySound("ui/element_hover_" .. math.random(1, 3) .. ".wav")

                    end

                    function completeButton:DoClick()

                        surface.PlaySound("ui/element_select.wav")
                        RunConsoleCommand("efgm_task_complete", taskName)
                        RunConsoleCommand("efgm_task_requestall")
                        taskDisplay:Clear()
                        timer.Simple(0.1, function()
                            DrawTaskDisplay(taskName)
                            DrawTaskList()
                        end)

                    end

                end

            -- Task Description

                local genericTraderIcon = Material("traders/generic.png", "smooth")

                local messageMarkup = markup.Parse("<font=PuristaBold24>" .. taskInfo.description .. "</font>", EFGM.MenuScale(1025))

                local messagePanel = vgui.Create("DPanel", taskDisplay)
                messagePanel:Dock(TOP)
                messagePanel:DockMargin(EFGM.MenuScale(5), EFGM.MenuScale(5), EFGM.MenuScale(5), 0)
                messagePanel:SetSize(0, EFGM.MenuScale(246))

                local messagePanelHeader = vgui.Create("DPanel", messagePanel)
                messagePanelHeader:Dock(TOP)
                messagePanelHeader:SetSize(0, EFGM.MenuScale(36))
                function messagePanelHeader:Paint(w, h)

                    surface.SetDrawColor(Colors.containerHeaderColor)
                    surface.DrawRect(0, 0, w, h)

                    surface.SetDrawColor(Colors.transparentWhiteColor)
                    surface.DrawRect(0, 0, w, EFGM.MenuScale(6))

                    draw.SimpleTextOutlined(taskInfo.messageOverride or "INCOMING TRANSMISSION FROM " .. string.upper(taskInfo.traderName), "PuristaBold32", EFGM.MenuScale(5), EFGM.MenuScale(2), Colors.whiteColor, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP, 1, Colors.blackColor)

                end

                local messageIcon = vgui.Create("DPanel", messagePanel)
                messageIcon:Dock(LEFT)
                messageIcon:SetSize(EFGM.MenuScale(200), EFGM.MenuScale(200))
                messageIcon:DockMargin(EFGM.MenuScale(5), EFGM.MenuScale(5), EFGM.MenuScale(5), 0)

                function messageIcon:Paint(w, h)

                    surface.SetMaterial(taskInfo.traderIcon or genericTraderIcon)
                    surface.SetDrawColor(Colors.pureWhiteColor)
                    surface.DrawTexturedRect(0, 0, EFGM.MenuScale(200), EFGM.MenuScale(200))

                end

                function messageIcon:PaintOver(w, h)

                    surface.SetDrawColor(Colors.whiteBorderColor)
                    surface.DrawRect(0, 0, EFGM.MenuScale(200), EFGM.MenuScale(1))
                    surface.DrawRect(0, EFGM.MenuScale(200) - 1, EFGM.MenuScale(200), EFGM.MenuScale(1))
                    surface.DrawRect(0, 0, EFGM.MenuScale(1), EFGM.MenuScale(200))
                    surface.DrawRect(EFGM.MenuScale(200) - 1, 0, EFGM.MenuScale(1), EFGM.MenuScale(200))

                end

                local messageScroller = vgui.Create("DScrollPanel", messagePanel)
                messageScroller:Dock(LEFT)
                messageScroller:SetSize(EFGM.MenuScale(1075), 0)
                messageScroller:DockMargin(0, EFGM.MenuScale(5), EFGM.MenuScale(5), 0)

                local messageBar = messageScroller:GetVBar()
                messageBar:SetHideButtons(true)
                messageBar:SetSize(EFGM.MenuScale(15), EFGM.MenuScale(15))
                function messageBar:Paint(w, h)
                    draw.RoundedBox(0, EFGM.MenuScale(5), EFGM.MenuScale(8), EFGM.MenuScale(5), h - EFGM.MenuScale(16), Colors.scrollerColor)
                end
                function messageBar.btnGrip:Paint(w, h)
                    draw.RoundedBox(0, EFGM.MenuScale(5), EFGM.MenuScale(8), EFGM.MenuScale(5), h - EFGM.MenuScale(16), Colors.transparentWhiteColor)
                end

                local messageTextPanel = vgui.Create("DPanel", messageScroller)
                messageTextPanel:SetSize(messageMarkup:GetWidth(), messageMarkup:GetHeight())
                messageTextPanel:SetPos(EFGM.MenuScale(5), 0)
                function messageTextPanel:Paint(w, h)

                    messageMarkup:Draw(0, EFGM.MenuScale(-5), TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)

                end

            -- Task Objectives

                local objectivePanel = vgui.Create("DPanel", taskDisplay)
                objectivePanel:Dock(TOP)
                objectivePanel:DockMargin(EFGM.MenuScale(5), EFGM.MenuScale(5), EFGM.MenuScale(5), EFGM.MenuScale(5))
                objectivePanel:SetSize(0, EFGM.MenuScale(41))

                local objectivePanelHeader = vgui.Create("DPanel", objectivePanel)
                objectivePanelHeader:Dock(TOP)
                objectivePanelHeader:SetSize(0, EFGM.MenuScale(36))
                function objectivePanelHeader:Paint(w, h)

                    surface.SetDrawColor(Colors.containerHeaderColor)
                    surface.DrawRect(0, 0, w, h)

                    surface.SetDrawColor(Colors.transparentWhiteColor)
                    surface.DrawRect(0, 0, w, EFGM.MenuScale(6))

                    draw.SimpleTextOutlined("OBJECTIVES", "PuristaBold32", EFGM.MenuScale(5), EFGM.MenuScale(2), Colors.whiteColor, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP, 1, Colors.blackColor)

                end

                local objectiveScroller = vgui.Create("DScrollPanel", objectivePanel)
                objectiveScroller:Dock(FILL)
                objectiveScroller:DockMargin(EFGM.MenuScale(5), EFGM.MenuScale(5), EFGM.MenuScale(5), 0)

                local objectiveBar = objectiveScroller:GetVBar()
                objectiveBar:SetHideButtons(true)
                objectiveBar:SetSize(EFGM.MenuScale(15), EFGM.MenuScale(15))
                function objectiveBar:Paint(w, h)
                    draw.RoundedBox(0, EFGM.MenuScale(5), EFGM.MenuScale(8), EFGM.MenuScale(5), h - EFGM.MenuScale(16), Colors.scrollerColor)
                end
                function objectiveBar.btnGrip:Paint(w, h)
                    draw.RoundedBox(0, EFGM.MenuScale(5), EFGM.MenuScale(8), EFGM.MenuScale(5), h - EFGM.MenuScale(16), Colors.transparentWhiteColor)
                end

                for objIndex, objInfo in ipairs(taskInfo.objectives) do

                    local curProgress = playerTasks[taskName].progress[objIndex]
                    local curTempProgress = playerTasks[taskName].tempProgress[objIndex]
                    local curProgressTotal = curProgress + curTempProgress
                    local maxProgress = objInfo.count or 1

                    objectivePanel:SetTall(objectivePanel:GetTall() + EFGM.MenuScale(45))

                    local objective = objectiveScroller:Add("DPanel")
                    objective:Dock(TOP)
                    objective:DockMargin(0, 0, 0, EFGM.MenuScale(5))
                    objective:SetSize(0, EFGM.MenuScale(40))

                    local progressText
                    local progressTextSize

                    local objText = GetObjectiveText(objInfo)

                    function objective:Paint(w, h)

                        surface.SetDrawColor(Colors.containerHeaderColor)
                        surface.DrawRect(0, 0, w, h)

                        draw.SimpleTextOutlined(objText, "PuristaBold24", EFGM.MenuScale(5), EFGM.MenuScale(6), Colors.whiteColor, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP, 1, Colors.blackColor)

                        if playerTasks[taskName].status == TASKSTATUS.AcceptPending then

                            surface.SetFont("PuristaBold24")
                            progressText = "0/" .. comma_value(maxProgress)
                            progressTextSize = surface.GetTextSize(progressText)
                            draw.SimpleTextOutlined(progressText, "PuristaBold24", w - EFGM.MenuScale(5), EFGM.MenuScale(6), Colors.whiteColor, TEXT_ALIGN_RIGHT, TEXT_ALIGN_TOP, 1, Colors.blackColor)

                        else

                            surface.SetFont("PuristaBold24")
                            progressText = comma_value(curProgressTotal) .. "/" .. comma_value(maxProgress)
                            progressTextSize = surface.GetTextSize(progressText)

                            if curTempProgress > 0 then

                                surface.SetDrawColor(Color(202, 20, 20, 255))
                                surface.DrawRect(w - EFGM.MenuScale(410), EFGM.MenuScale(5), math.Remap(curProgressTotal, 0, maxProgress, 0, EFGM.MenuScale(400) - progressTextSize), h - EFGM.MenuScale(10))

                            end

                            surface.SetDrawColor(Color(80, 80, 80, 255))
                            surface.DrawRect(w - EFGM.MenuScale(410), EFGM.MenuScale(5), math.Remap(curProgress, 0, maxProgress, 0, EFGM.MenuScale(400) - progressTextSize), h - EFGM.MenuScale(10))

                            draw.SimpleTextOutlined(progressText, "PuristaBold24", w - EFGM.MenuScale(5), EFGM.MenuScale(6), Colors.whiteColor, TEXT_ALIGN_RIGHT, TEXT_ALIGN_TOP, 1, Colors.blackColor)

                        end

                        surface.SetDrawColor(Color(205, 205, 205, 255))
                        surface.DrawOutlinedRect(w - EFGM.MenuScale(410), EFGM.MenuScale(5), EFGM.MenuScale(400) - progressTextSize, h - EFGM.MenuScale(10), EFGM.MenuScale(1))

                    end

                    function objective:PaintOver(w, h)

                        surface.SetDrawColor(Colors.whiteBorderColor)
                        surface.DrawRect(0, 0, w, EFGM.MenuScale(1))
                        surface.DrawRect(0, h - 1, w, EFGM.MenuScale(1))
                        surface.DrawRect(0, 0, EFGM.MenuScale(1), h)
                        surface.DrawRect(w - 1, 0, EFGM.MenuScale(1), h)

                    end

                    if curProgress != maxProgress and objInfo.type == OBJECTIVE.Pay and playerTasks[taskName].status == TASKSTATUS.InProgress and Menu.Player:CompareStatus(0) then

                        local payAmount = math.Clamp(maxProgress - curProgress, 0, Menu.Player:GetNWInt("Money", 0))

                        local payButton = vgui.Create("DButton", objective)
                        payButton:SetSize(EFGM.MenuScale(120), EFGM.MenuScale(25))
                        payButton:Center()
                        payButton:AlignLeft(EFGM.MenuScale(520))
                        payButton:SetText("Pay "..payAmount.."₽")
                        function payButton:DoClick()

                            RunConsoleCommand("efgm_task_pay", taskName, payAmount)
                            RunConsoleCommand("efgm_task_requestall")
                            taskDisplay:Clear()

                            timer.Simple(0.1, function()
                                DrawTaskDisplay(taskName)
                                DrawTaskList()
                            end)

                        end

                    end

                end

            -- Task Rewards

                local rewardPanel = vgui.Create("DPanel", taskDisplay)
                rewardPanel:Dock(TOP)
                rewardPanel:DockMargin(EFGM.MenuScale(5), EFGM.MenuScale(5), EFGM.MenuScale(5), EFGM.MenuScale(5))
                rewardPanel:SetSize(0, EFGM.MenuScale(41))

                local rewardPanelHeader = vgui.Create("DPanel", rewardPanel)
                rewardPanelHeader:Dock(TOP)
                rewardPanelHeader:SetSize(0, EFGM.MenuScale(36))
                function rewardPanelHeader:Paint(w, h)

                    surface.SetDrawColor(Colors.containerHeaderColor)
                    surface.DrawRect(0, 0, w, h)

                    surface.SetDrawColor(Colors.transparentWhiteColor)
                    surface.DrawRect(0, 0, w, EFGM.MenuScale(6))

                    draw.SimpleTextOutlined("REWARDS", "PuristaBold32", EFGM.MenuScale(5), EFGM.MenuScale(2), Colors.whiteColor, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP, 1, Colors.blackColor)

                end

                local rewardScroller = vgui.Create("DScrollPanel", rewardPanel)
                rewardScroller:Dock(FILL)
                rewardScroller:DockMargin(EFGM.MenuScale(5), EFGM.MenuScale(5), EFGM.MenuScale(5), 0)

                local rewardBar = rewardScroller:GetVBar()
                rewardBar:SetHideButtons(true)
                rewardBar:SetSize(EFGM.MenuScale(15), EFGM.MenuScale(15))
                function rewardBar:Paint(w, h)
                    draw.RoundedBox(0, EFGM.MenuScale(5), EFGM.MenuScale(8), EFGM.MenuScale(5), h - EFGM.MenuScale(16), Colors.scrollerColor)
                end
                function rewardBar.btnGrip:Paint(w, h)
                    draw.RoundedBox(0, EFGM.MenuScale(5), EFGM.MenuScale(8), EFGM.MenuScale(5), h - EFGM.MenuScale(16), Colors.transparentWhiteColor)
                end

                for rewardIndex, rewardInfo in ipairs(taskInfo.rewards) do

                    local amount = rewardInfo.count .. "x" or "1x"
                    if amount == "1x" then amount = "" end

                    rewardPanel:SetTall(rewardPanel:GetTall() + EFGM.MenuScale(45))

                    local reward = rewardScroller:Add("DPanel")
                    reward:Dock(TOP)
                    reward:DockMargin(0, 0, 0, EFGM.MenuScale(5))
                    reward:SetSize(0, EFGM.MenuScale(40))

                    local rewardText = GetRewardText(rewardInfo)

                    function reward:Paint(w, h)

                        surface.SetDrawColor(Colors.containerHeaderColor)
                        surface.DrawRect(0, 0, w, h)

                        draw.SimpleTextOutlined(rewardText, "PuristaBold24", EFGM.MenuScale(5), EFGM.MenuScale(6), Colors.whiteColor, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP, 1, Colors.blackColor)

                    end

                    function reward:PaintOver(w, h)

                        surface.SetDrawColor(Colors.whiteBorderColor)
                        surface.DrawRect(0, 0, w, EFGM.MenuScale(1))
                        surface.DrawRect(0, h - 1, w, EFGM.MenuScale(1))
                        surface.DrawRect(0, 0, EFGM.MenuScale(1), h)
                        surface.DrawRect(w - 1, 0, EFGM.MenuScale(1), h)

                    end

                end

        end

    Menu.MenuFrame.LowerPanel.Contents = contents

end

function GetObjectiveText(obj)

    if obj.type == OBJECTIVE.Kill then
        if obj.areaName != nil then
            return "Eliminate PMC's across "..MAPNAMES[obj.mapName].." at "..obj.areaDisplayName or obj.areaName
        elseif obj.mapName != nil then
            return "Eliminate PMC's across "..MAPNAMES[obj.mapName]
        else
            return "Eliminate PMC's across Garkov"
        end
    end


    if obj.type == OBJECTIVE.Extract then
        if obj.extractName != nil then
            return "Extract from " .. MAPNAMES[obj.mapName] .. " through " .. obj.extractDisplayName or obj.extractName
        elseif obj.mapName != nil then
            return "Extract from " .. MAPNAMES[obj.mapName]
        else
            return "Extract from any location across Garkov"
        end
    end

    if obj.type == OBJECTIVE.GiveItem then
        if obj.isFIR != nil then
            return "Hand over found in raid " .. EFGMITEMS[obj.itemName].fullName
        else
            return "Hand over " .. EFGMITEMS[obj.itemName].fullName
        end

    end

    if obj.type == OBJECTIVE.Pay then
        if obj.count != 1 then
            return "Pay " .. comma_value(obj.count) .. " roubles"
        else
            return "Pay a singular rouble..."
        end
    end

    if obj.type == OBJECTIVE.QuestItem then
        return "Retrieve " .. EFGMQUESTITEM[obj.itemName].name
    end

    if obj.type == OBJECTIVE.VisitArea then
        return "Scout out " .. obj.areaDisplayName .. " at " .. MAPNAMES[obj.mapName]
    end

    return "Counting or not counting OBJECTIVE[" .. obj.type .. "]?"

end

function GetRewardText(reward)

    local amount = comma_value(reward.count) .. "x" or "1x"
    if amount == "1x" then amount = "" end

    if reward.type == REWARD.PlayerStat then
        return amount .. " " .. reward.info
    end

    if reward.type == REWARD.Item then
        return amount .. " " .. reward.info
    end

    if reward.type == REWARD.MarketUnlock then
        return "Unlock " .. reward.info .. " on the market"
    end

    return "Counting or not counting REWARD[" .. reward.type .. "]?"

end

function GetProgressNumbers(progress, obj, objType)

    return progress, obj.count or 1

end

concommand.Add("efgm_gamemenu", function(ply, cmd, args)

    local tab = args[1] -- tab currently does jack

    if !LocalPlayer():Alive() then return end
    if HUD.InTransition then return end

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