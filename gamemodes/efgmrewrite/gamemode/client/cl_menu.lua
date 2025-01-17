
-- establishes global menu object, this will have tabs and will handle shit like shop, player progression, in-raid shit, other stuff
-- this is not a panel, but a collection of panels and supporting functions
Menu = {}

Menu.MusicList = {"sound/music/menu_01.mp4", "sound/music/menu_02.mp4", "sound/music/menu_03.mp4", "sound/music/menu_04.mp4"}
Menu.TabList = {"stats", "match", "inventory", "intel", "achievements", "settings"}
Menu.ActiveTab = ""
Menu.MouseX = 0
Menu.MouseY = 0

local menuBind = GetConVar("efgm_bind_menu"):GetInt()
cvars.AddChangeCallback("efgm_bind_menu", function(convar_name, value_old, value_new)
    menuBind = tonumber(value_new)
end)

local function GetEntityBodygroups(ent, override)

    local bg = {}

    for i = 0, ent:GetNumBodyGroups() - 1 do

		if override and override[i] then

			bg[i] = override[i]

		else

			if ent:GetBodygroupCount(i) <= 1 then continue end
			bg[i] = ent:GetBodygroup(i)

		end

	end

	if next(bg) then

		return bg

	end

end

local function GetEntitySkin(ent, override)

	if override then return override end
	if ent:SkinCount() > 1 then return ent:GetSkin() end

end

local function GetEntityGroups(ent, override)

	local groups = {}

	groups.Bodygroups = GetEntityBodygroups(ent, override and override.Bodygroups)
	groups.Skin = GetEntitySkin(ent, override and override.Skin)

	if next(groups) then

		return groups

	end

end

local conditions = {}

-- called non-globally to initialize the menu, that way it can only be initialized once by Menu:Open()
-- also openTab is the name of the tab it should open to
function Menu:Initialize(openTo)

    local menuFrame = vgui.Create("DFrame")
    menuFrame:SetSize(EFGM.MenuScale(1900), ScrH() - EFGM.MenuScale(20))
    menuFrame:Center()
    menuFrame:SetTitle("")
    menuFrame:SetVisible(true)
    menuFrame:SetDraggable(false)
    menuFrame:SetDeleteOnClose(false)
    menuFrame:ShowCloseButton(false)
    menuFrame:MakePopup()
    menuFrame:SetAlpha(0)
    menuFrame:SetBackgroundBlur(true)
    menuFrame:NoClipping(true)

    menuFrame:AlphaTo(255, 0.2, 0, function() end)

    self.StartTime = SysTime()
    self.Unblur = false
    self.Closing = false

    function menuFrame:Paint(w, h)

        surface.SetDrawColor(0, 0, 0, 200)
        surface.DrawRect(EFGM.MenuScale(-20), EFGM.MenuScale(-20), ScrW() + EFGM.MenuScale(20), ScrH() + EFGM.MenuScale(20))

        -- draw.SimpleTextOutlined("Escape From Garry's Mod", "Purista32", EFGM.MenuScale(5), EFGM.MenuScale(0), MenuAlias.whiteColor, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP, 1, MenuAlias.blackColor)

        if self.Unblur then return end -- hide the blur when customizing certain settings and whatnot

        -- calling this function twice is the only way to make the blur darker lmao
        Derma_DrawBackgroundBlur(self, self.StartTime)

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
    tabParentPanel:SetPos(0, 0)
    tabParentPanel:SetSize(ScrW(), EFGM.MenuScale(41))

    function tabParentPanel:Paint(w, h)

        surface.SetDrawColor(MenuAlias.transparent)
        surface.DrawRect(0, 0, w, h)

    end

    self.MenuFrame.TabParentPanel = tabParentPanel

    local lowerPanel = vgui.Create("DPanel", self.MenuFrame)
    lowerPanel:SetSize(EFGM.MenuScale(1880), EFGM.MenuScale(980))
    lowerPanel:NoClipping(true)

    function lowerPanel:Paint(w, h)

        surface.SetDrawColor(MenuAlias.transparent)
        surface.DrawRect(0, 0, w, h)

        if Menu.MenuFrame.Closing then return end

        if GetConVar("efgm_menu_parallax"):GetInt() == 1 then

            local x, y = menuFrame:CursorPos()

            Menu.MouseX = (x / math.Round(EFGM.MenuScale(1900), 1)) - 0.5
            Menu.MouseY = (y / math.Round(EFGM.MenuScale(1060), 1)) - 0.5

            lowerPanel:SetPos(ScrW() / 2 - (EFGM.MenuScale(1900) / 2) + (Menu.MouseX * EFGM.MenuScale(20)), 1060 / 2 - (920 / 2) + (Menu.MouseY * EFGM.MenuScale(20)))

        else

            lowerPanel:SetPos(ScrW() / 2 - (EFGM.MenuScale(1900) / 2), 1060 / 2 - (920 / 2))

        end

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
    local statsTextSize = EFGM.MenuScale(surface.GetTextSize(statsText))

    statsTab.Paint = function(s, w, h)

        surface.SetDrawColor(statsBGColor)
        surface.DrawRect(0, 0, w, h)

        draw.SimpleTextOutlined(statsText, "PuristaBold32", EFGM.MenuScale(43), EFGM.MenuScale(2), MenuAlias.whiteColor, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP, 1, MenuAlias.blackColor)

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

            Menu.MenuFrame.LowerPanel.Contents:AlphaTo(255, 0.05, 0, function() end)

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
    local matchTextSize = EFGM.MenuScale(surface.GetTextSize(matchText))

    matchTab.Paint = function(s, w, h)

        surface.SetDrawColor(matchBGColor)
        surface.DrawRect(0, 0, w, h)

        draw.SimpleTextOutlined(matchText, "PuristaBold32", EFGM.MenuScale(43), EFGM.MenuScale(2), MenuAlias.whiteColor, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP, 1, MenuAlias.blackColor)

    end

    matchIcon.OnCursorEntered = function(s)

        matchTab:SizeTo(EFGM.MenuScale(46) + matchTextSize, matchTab:GetTall(), 0.15, 0, 0.5)
        surface.PlaySound("ui/element_hover.wav")

    end

    matchIcon.OnCursorExited = function(s)

        matchTab:SizeTo(EFGM.MenuScale(38), matchTab:GetTall(), 0.15, 0, 0.5)

    end

    function matchIcon:DoClick()

        if !Menu.Player:CompareStatus(0) then

            surface.PlaySound("common/wpn_denyselect.wav")
            return

        end

        if Menu.ActiveTab == "Match" then return end

        surface.PlaySound("ui/element_select.wav")

        Menu.MenuFrame.LowerPanel.Contents:AlphaTo(0, 0.05, 0, function()

            Menu.MenuFrame.LowerPanel.Contents:Remove()
            Menu.OpenTab.Match()
            Menu.ActiveTab = "Match"

            Menu.MenuFrame.LowerPanel.Contents:AlphaTo(255, 0.05, 0, function() end)

        end)

        net.Start("AddPlayerSquadRF")
        net.SendToServer()
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
    local inventoryTextSize = EFGM.MenuScale(surface.GetTextSize(inventoryText))

    inventoryTab.Paint = function(s, w, h)

        surface.SetDrawColor(inventoryBGColor)
        surface.DrawRect(0, 0, w, h)

        draw.SimpleTextOutlined(inventoryText, "PuristaBold32", EFGM.MenuScale(43), EFGM.MenuScale(2), MenuAlias.whiteColor, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP, 1, MenuAlias.blackColor)

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
            Menu.OpenTab.Inventory()
            Menu.ActiveTab = "Inventory"

            Menu.MenuFrame.LowerPanel.Contents:AlphaTo(255, 0.05, 0, function() end)

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
    local tasksTextSize = EFGM.MenuScale(surface.GetTextSize(tasksText))

    tasksTab.Paint = function(s, w, h)

        surface.SetDrawColor(tasksBGColor)
        surface.DrawRect(0, 0, w, h)

        draw.SimpleTextOutlined(tasksText, "PuristaBold32", EFGM.MenuScale(43), EFGM.MenuScale(2), MenuAlias.whiteColor, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP, 1, MenuAlias.blackColor)

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
    local skillsTextSize = EFGM.MenuScale(surface.GetTextSize(skillsText))

    skillsTab.Paint = function(s, w, h)

        surface.SetDrawColor(skillsBGColor)
        surface.DrawRect(0, 0, w, h)

        draw.SimpleTextOutlined(skillsText, "PuristaBold32", EFGM.MenuScale(43), EFGM.MenuScale(2), MenuAlias.whiteColor, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP, 1, MenuAlias.blackColor)

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

            Menu.MenuFrame.LowerPanel.Contents:AlphaTo(255, 0.05, 0, function() end)

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
    local intelTextSize = EFGM.MenuScale(surface.GetTextSize(intelText))

    intelTab.Paint = function(s, w, h)

        surface.SetDrawColor(intelBGColor)
        surface.DrawRect(0, 0, w, h)

        draw.SimpleTextOutlined(intelText, "PuristaBold32", EFGM.MenuScale(43), EFGM.MenuScale(2), MenuAlias.whiteColor, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP, 1, MenuAlias.blackColor)

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

            Menu.MenuFrame.LowerPanel.Contents:AlphaTo(255, 0.05, 0, function() end)

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
    local achievementsTextSize = EFGM.MenuScale(surface.GetTextSize(achievementsText))

    achievementsTab.Paint = function(s, w, h)

        surface.SetDrawColor(achievementsBGColor)
        surface.DrawRect(0, 0, w, h)

        draw.SimpleTextOutlined(achievementsText, "PuristaBold32", EFGM.MenuScale(43), EFGM.MenuScale(2), MenuAlias.whiteColor, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP, 1, MenuAlias.blackColor)

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
    local settingsTextSize = EFGM.MenuScale(surface.GetTextSize(settingsText))

    settingsTab.Paint = function(s, w, h)

        surface.SetDrawColor(settingsBGColor)
        surface.DrawRect(0, 0, w, h)

        draw.SimpleTextOutlined(settingsText, "PuristaBold32", EFGM.MenuScale(43), EFGM.MenuScale(2), MenuAlias.whiteColor, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP, 1, MenuAlias.blackColor)

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

            Menu.MenuFrame.LowerPanel.Contents:AlphaTo(255, 0.05, 0, function() end)

        end)

    end

    local helpTab = vgui.Create("DPanel", self.MenuFrame.TabParentPanel)
    helpTab:Dock(RIGHT)
    helpTab:SetSize(EFGM.MenuScale(54), 0)

    local helpIcon = vgui.Create("DImageButton", helpTab)
    helpIcon:SetPos(EFGM.MenuScale(2), EFGM.MenuScale(2))
    helpIcon:SetSize(EFGM.MenuScale(36), EFGM.MenuScale(36))
    helpIcon:SetImage("icons/help_icon.png")
    helpIcon:SetDepressImage(false)

    local helpBGColor = MenuAlias.transparent

    helpTab.Paint = function(s, w, h)

        surface.SetDrawColor(helpBGColor)
        surface.DrawRect(0, 0, w, h)

    end

    helpIcon.OnCursorEntered = function(s)

        statsTab:SizeTo(EFGM.MenuScale(46) + statsTextSize, statsTab:GetTall(), 0.15, 0, 0.5)
        matchTab:SizeTo(EFGM.MenuScale(46) + matchTextSize, matchTab:GetTall(), 0.15, 0, 0.5)
        inventoryTab:SizeTo(EFGM.MenuScale(46) + inventoryTextSize, inventoryTab:GetTall(), 0.15, 0, 0.5)
        tasksTab:SizeTo(EFGM.MenuScale(46) + tasksTextSize, tasksTab:GetTall(), 0.15, 0, 0.5)
        skillsTab:SizeTo(EFGM.MenuScale(46) + skillsTextSize, skillsTab:GetTall(), 0.15, 0, 0.5)
        intelTab:SizeTo(EFGM.MenuScale(46) + intelTextSize, intelTab:GetTall(), 0.15, 0, 0.5)
        achievementsTab:SizeTo(EFGM.MenuScale(46) + achievementsTextSize, achievementsTab:GetTall(), 0.15, 0, 0.5)
        settingsTab:SizeTo(EFGM.MenuScale(46) + settingsTextSize, settingsTab:GetTall(), 0.15, 0, 0.5)
        surface.PlaySound("ui/element_hover.wav")

    end

    helpIcon.OnCursorExited = function(s)

        statsTab:SizeTo(EFGM.MenuScale(38), statsTab:GetTall(), 0.15, 0, 0.5)
        matchTab:SizeTo(EFGM.MenuScale(38), matchTab:GetTall(), 0.15, 0, 0.5)
        inventoryTab:SizeTo(EFGM.MenuScale(38), inventoryTab:GetTall(), 0.15, 0, 0.5)
        tasksTab:SizeTo(EFGM.MenuScale(38), tasksTab:GetTall(), 0.15, 0, 0.5)
        skillsTab:SizeTo(EFGM.MenuScale(38), skillsTab:GetTall(), 0.15, 0, 0.5)
        intelTab:SizeTo(EFGM.MenuScale(38), intelTab:GetTall(), 0.15, 0, 0.5)
        achievementsTab:SizeTo(EFGM.MenuScale(38), achievementsTab:GetTall(), 0.15, 0, 0.5)
        settingsTab:SizeTo(EFGM.MenuScale(38), settingsTab:GetTall(), 0.15, 0, 0.5)

    end

    -- if provided, open to the tab of the users choice
    if openTo != nil then

        -- i cant figure this out so enjoy the Stats tab
        Menu.OpenTab.Inventory()
        Menu.MenuFrame.LowerPanel.Contents:AlphaTo(255, 0.05, 0, function() end)
        Menu.ActiveTab = "Inventory"

    end

end

-- called to either initialize or open the menu
function Menu:Open(openTo)

    if self.MenuFrame != nil then

        self.MenuFrame:Remove()

    end

    self:Initialize(openTo)

end

Menu.OpenTab = {}

function Menu.OpenTab.Inventory()

    local contents = vgui.Create("DPanel", Menu.MenuFrame.LowerPanel)
    contents:Dock(FILL)
    contents:DockPadding(EFGM.MenuScale(15), EFGM.MenuScale(10), EFGM.MenuScale(10), EFGM.MenuScale(10))
    contents.Paint = function(s, w, h)

        surface.SetDrawColor(MenuAlias.transparent)
        surface.DrawRect(0, 0, w, h)

    end

    Menu.MenuFrame.LowerPanel.Contents = contents

    local playerPanel = vgui.Create("DPanel", contents)
    playerPanel:Dock(LEFT)
    playerPanel:SetSize(EFGM.MenuScale(613), 0)
    playerPanel.Paint = function(s, w, h)

        BlurPanel(s, EFGM.MenuScale(13))
        BlurPanel(s, EFGM.MenuScale(13))

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

        draw.SimpleTextOutlined(string.upper(Menu.Player:GetName()), "PuristaBold32", EFGM.MenuScale(5), EFGM.MenuScale(19), MenuAlias.whiteColor, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER, 1, MenuAlias.blackColor)

    end

    local playerModel = vgui.Create("DModelPanel", playerPanel)
    playerModel:Dock(FILL)
    playerModel:SetMouseInputEnabled(false)
    playerModel:SetFOV(26)
    playerModel:SetCamPos(Vector(10, 0, 0))
    playerModel:SetLookAt(Vector(-100, 0, -24))
    playerModel:SetDirectionalLight(BOX_RIGHT, Color(255, 160, 80, 255))
    playerModel:SetDirectionalLight(BOX_LEFT, Color(80, 160, 255, 255))
    playerModel:SetAnimated(true)
    playerModel:SetModel(Menu.Player:GetModel())

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

    local primaryWeaponHolder = vgui.Create("DPanel", playerPanel)
    primaryWeaponHolder:SetPos(EFGM.MenuScale(313), EFGM.MenuScale(700))
    primaryWeaponHolder:SetSize(EFGM.MenuScale(300), EFGM.MenuScale(120))
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

    local primaryWeaponIcon = vgui.Create("DImage", primaryWeaponHolder)
    primaryWeaponIcon:SetPos(EFGM.MenuScale(25), EFGM.MenuScale(15))
    primaryWeaponIcon:SetSize(EFGM.MenuScale(250), EFGM.MenuScale(80))
    primaryWeaponIcon:SetImage("icons/inventory_primary_icon.png")
    primaryWeaponIcon:SetImageColor(Color(255, 255, 255, 10))

    local secondaryWeaponHolder = vgui.Create("DPanel", playerPanel)
    secondaryWeaponHolder:SetPos(EFGM.MenuScale(313), EFGM.MenuScale(840))
    secondaryWeaponHolder:SetSize(EFGM.MenuScale(300), EFGM.MenuScale(120))
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

    local secondaryWeaponIcon = vgui.Create("DImage", secondaryWeaponHolder)
    secondaryWeaponIcon:SetPos(EFGM.MenuScale(25), EFGM.MenuScale(15))
    secondaryWeaponIcon:SetSize(EFGM.MenuScale(250), EFGM.MenuScale(80))
    secondaryWeaponIcon:SetImage("icons/inventory_primary_icon.png")
    secondaryWeaponIcon:SetImageColor(Color(255, 255, 255, 10))

    local holsterWeaponHolder = vgui.Create("DPanel", playerPanel)
    holsterWeaponHolder:SetPos(EFGM.MenuScale(493), EFGM.MenuScale(560))
    holsterWeaponHolder:SetSize(EFGM.MenuScale(120), EFGM.MenuScale(120))
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

    local holsterWeaponIcon = vgui.Create("DImage", holsterWeaponHolder)
    holsterWeaponIcon:SetPos(EFGM.MenuScale(22), EFGM.MenuScale(32))
    holsterWeaponIcon:SetSize(EFGM.MenuScale(80), EFGM.MenuScale(54))
    holsterWeaponIcon:SetImage("icons/inventory_holster_icon.png")
    holsterWeaponIcon:SetImageColor(Color(255, 255, 255, 10))

    local inventoryPanel = vgui.Create("DPanel", contents)
    inventoryPanel:Dock(LEFT)
    inventoryPanel:DockMargin(EFGM.MenuScale(13), 0, 0, 0)
    inventoryPanel:SetSize(EFGM.MenuScale(613), 0)
    inventoryPanel.Paint = function(s, w, h)

        BlurPanel(s, EFGM.MenuScale(13))
        BlurPanel(s, EFGM.MenuScale(13))

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

        draw.SimpleTextOutlined("INVENTORY", "PuristaBold32", EFGM.MenuScale(5), EFGM.MenuScale(19), MenuAlias.whiteColor, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER, 1, MenuAlias.blackColor)

    end

    local rigHolder = vgui.Create("DPanel", inventoryPanel)
    rigHolder:Dock(TOP)
    rigHolder:DockMargin(EFGM.MenuScale(10), EFGM.MenuScale(10), EFGM.MenuScale(10), EFGM.MenuScale(9))
    rigHolder:SetSize(0, EFGM.MenuScale(152))
    rigHolder.Paint = function(s, w, h)

        surface.SetDrawColor(Color(0, 0, 0, 0))
        surface.DrawRect(0, 0, w, h)

    end

    local rigText = vgui.Create("DPanel", rigHolder)
    rigText:Dock(TOP)
    rigText:SetSize(0, EFGM.MenuScale(28))
    surface.SetFont("PuristaBold24")
    rigText.Paint = function(s, w, h)

        BlurPanel(s, EFGM.MenuScale(3))

        surface.SetDrawColor(Color(80, 80, 80, 10))
        surface.DrawRect(0, 0, surface.GetTextSize("RIG"), h)

        surface.SetDrawColor(Color(255, 255, 255, 155))
        surface.DrawRect(0, 0, surface.GetTextSize("RIG"), EFGM.MenuScale(2))

        draw.SimpleTextOutlined("RIG", "PuristaBold24", EFGM.MenuScale(5), EFGM.MenuScale(13), MenuAlias.whiteColor, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER, 1, MenuAlias.blackColor)

    end

    local rigEquipedHolder = vgui.Create("DPanel", rigHolder)
    rigEquipedHolder:SetPos(0, EFGM.MenuScale(32))
    rigEquipedHolder:SetSize(EFGM.MenuScale(120), EFGM.MenuScale(120))
    function rigEquipedHolder:Paint(w, h)

        BlurPanel(rigEquipedHolder, EFGM.MenuScale(3))

        surface.SetDrawColor(Color(80, 80, 80, 10))
        surface.DrawRect(0, 0, w, h)

        surface.SetDrawColor(Color(255, 255, 255, 25))
        surface.DrawRect(0, 0, w, EFGM.MenuScale(1))
        surface.DrawRect(0, h - EFGM.MenuScale(1), w, EFGM.MenuScale(1))
        surface.DrawRect(0, 0, EFGM.MenuScale(1), h)
        surface.DrawRect(w - EFGM.MenuScale(1), 0, EFGM.MenuScale(1), h)

    end

    local rigEquipedIcon = vgui.Create("DImage", rigEquipedHolder)
    rigEquipedIcon:SetPos(EFGM.MenuScale(10), EFGM.MenuScale(10))
    rigEquipedIcon:SetSize(EFGM.MenuScale(100), EFGM.MenuScale(100))
    rigEquipedIcon:SetImage("icons/inventory_rig_icon.png")
    rigEquipedIcon:SetImageColor(Color(255, 255, 255, 10))

    local rigSlotHolder = vgui.Create("DPanel", rigHolder)
    rigSlotHolder:SetPos(EFGM.MenuScale(124), EFGM.MenuScale(32))
    rigSlotHolder:SetSize(EFGM.MenuScale(448), EFGM.MenuScale(120))
    rigSlotHolder.Paint = function(s, w, h)

        surface.SetDrawColor(Color(0, 0, 0, 0))
        surface.DrawRect(0, 0, w, h)

    end

    local pocketsHolder = vgui.Create("DPanel", inventoryPanel)
    pocketsHolder:Dock(TOP)
    pocketsHolder:DockMargin(EFGM.MenuScale(10), EFGM.MenuScale(10), EFGM.MenuScale(10), EFGM.MenuScale(9))
    pocketsHolder:SetSize(0, EFGM.MenuScale(96))
    pocketsHolder.Paint = function(s, w, h)

        surface.SetDrawColor(Color(0, 0, 0, 0))
        surface.DrawRect(0, 0, w, h)

    end

    local pocketsText = vgui.Create("DPanel", pocketsHolder)
    pocketsText:Dock(TOP)
    pocketsText:SetSize(0, EFGM.MenuScale(28))
    surface.SetFont("PuristaBold24")
    pocketsText.Paint = function(s, w, h)

        BlurPanel(s, EFGM.MenuScale(3))

        surface.SetDrawColor(Color(80, 80, 80, 10))
        surface.DrawRect(0, 0, surface.GetTextSize("POCKETS") + 10, h)

        surface.SetDrawColor(Color(255, 255, 255, 155))
        surface.DrawRect(0, 0, surface.GetTextSize("POCKETS") + 10, EFGM.MenuScale(2))

        draw.SimpleTextOutlined("POCKETS", "PuristaBold24", EFGM.MenuScale(5), EFGM.MenuScale(13), MenuAlias.whiteColor, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER, 1, MenuAlias.blackColor)

    end

    local pocketsSlotHolder = vgui.Create("DPanel", pocketsHolder)
    pocketsSlotHolder:Dock(TOP)
    pocketsSlotHolder:DockMargin(0, EFGM.MenuScale(4), 0, 0)
    pocketsSlotHolder:SetSize(0, EFGM.MenuScale(64))
    pocketsSlotHolder.Paint = function(s, w, h)

        surface.SetDrawColor(Color(0, 0, 0, 0))
        surface.DrawRect(0, 0, w, h)

    end

    for i = 1, 5 do

        local pocketSlot = vgui.Create("DPanel", pocketsSlotHolder)
        pocketSlot:Dock(LEFT)
        pocketSlot:DockMargin(0, 0, EFGM.MenuScale(4), 0)
        pocketSlot:SetSize(EFGM.MenuScale(64), EFGM.MenuScale(64))
        pocketSlot.Paint = function(s, w, h)

            BlurPanel(s, EFGM.MenuScale(3))

            surface.SetDrawColor(Color(80, 80, 80, 10))
            surface.DrawRect(0, 0, w, h)

            surface.SetDrawColor(Color(255, 255, 255, 25))
            surface.DrawRect(0, 0, w, EFGM.MenuScale(1))
            surface.DrawRect(0, h - EFGM.MenuScale(1), w, EFGM.MenuScale(1))
            surface.DrawRect(0, 0, EFGM.MenuScale(1), h)
            surface.DrawRect(w - EFGM.MenuScale(1), 0, EFGM.MenuScale(1), h)

        end

    end

    local bagHolder = vgui.Create("DPanel", inventoryPanel)
    bagHolder:Dock(TOP)
    bagHolder:DockMargin(EFGM.MenuScale(10), EFGM.MenuScale(10), EFGM.MenuScale(10), 0)
    bagHolder:SetSize(0, EFGM.MenuScale(152))
    bagHolder.Paint = function(s, w, h)

        surface.SetDrawColor(Color(0, 0, 0, 0))
        surface.DrawRect(0, 0, w, h)

    end

    local bagText = vgui.Create("DPanel", bagHolder)
    bagText:Dock(TOP)
    bagText:SetSize(0, EFGM.MenuScale(28))
    surface.SetFont("PuristaBold24")
    bagText.Paint = function(s, w, h)

        BlurPanel(s, EFGM.MenuScale(3))

        surface.SetDrawColor(Color(80, 80, 80, 10))
        surface.DrawRect(0, 0, surface.GetTextSize("BAG") + 10, h)

        surface.SetDrawColor(Color(255, 255, 255, 155))
        surface.DrawRect(0, 0, surface.GetTextSize("BAG") + 10, EFGM.MenuScale(2))

        draw.SimpleTextOutlined("BAG", "PuristaBold24", EFGM.MenuScale(5), EFGM.MenuScale(13), MenuAlias.whiteColor, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER, 1, MenuAlias.blackColor)

    end

    local bagEquipedHolder = vgui.Create("DPanel", bagHolder)
    bagEquipedHolder:SetPos(0, EFGM.MenuScale(32))
    bagEquipedHolder:SetSize(EFGM.MenuScale(120), EFGM.MenuScale(120))
    function bagEquipedHolder:Paint(w, h)

        BlurPanel(bagEquipedHolder, EFGM.MenuScale(3))

        surface.SetDrawColor(Color(80, 80, 80, 10))
        surface.DrawRect(0, 0, w, h)

        surface.SetDrawColor(Color(255, 255, 255, 25))
        surface.DrawRect(0, 0, w, EFGM.MenuScale(1))
        surface.DrawRect(0, h - EFGM.MenuScale(1), w, EFGM.MenuScale(1))
        surface.DrawRect(0, 0, EFGM.MenuScale(1), h)
        surface.DrawRect(w - EFGM.MenuScale(1), 0, EFGM.MenuScale(1), h)

    end

    local bagEquipedIcon = vgui.Create("DImage", bagEquipedHolder)
    bagEquipedIcon:SetPos(EFGM.MenuScale(10), EFGM.MenuScale(8))
    bagEquipedIcon:SetSize(EFGM.MenuScale(100), EFGM.MenuScale(100))
    bagEquipedIcon:SetImage("icons/inventory_bag_icon.png")
    bagEquipedIcon:SetImageColor(Color(255, 255, 255, 10))

    local bagSlotHolder = vgui.Create("DPanel", bagHolder)
    bagSlotHolder:SetPos(EFGM.MenuScale(124), EFGM.MenuScale(32))
    bagSlotHolder:SetSize(EFGM.MenuScale(448), EFGM.MenuScale(120))
    bagSlotHolder.Paint = function(s, w, h)

        surface.SetDrawColor(Color(0, 0, 0, 0))
        surface.DrawRect(0, 0, w, h)

    end

    local secureHolder = vgui.Create("DPanel", inventoryPanel)
    secureHolder:Dock(TOP)
    secureHolder:DockMargin(EFGM.MenuScale(10), EFGM.MenuScale(10), EFGM.MenuScale(10), 0)
    secureHolder:SetSize(0, EFGM.MenuScale(152))
    secureHolder.Paint = function(s, w, h)

        surface.SetDrawColor(Color(0, 0, 0, 0))
        surface.DrawRect(0, 0, w, h)

    end

    local secureText = vgui.Create("DPanel", secureHolder)
    secureText:Dock(TOP)
    secureText:SetSize(0, EFGM.MenuScale(28))
    surface.SetFont("PuristaBold24")
    secureText.Paint = function(s, w, h)

        BlurPanel(s, EFGM.MenuScale(3))

        surface.SetDrawColor(Color(80, 80, 80, 10))
        surface.DrawRect(0, 0, surface.GetTextSize("CONTAINER") + 10, h)

        surface.SetDrawColor(Color(255, 255, 255, 155))
        surface.DrawRect(0, 0, surface.GetTextSize("CONTAINER") + 10, EFGM.MenuScale(2))

        draw.SimpleTextOutlined("CONTAINER", "PuristaBold24", EFGM.MenuScale(5), EFGM.MenuScale(13), MenuAlias.whiteColor, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER, 1, MenuAlias.blackColor)

    end

    local secureEquipedHolder = vgui.Create("DPanel", secureHolder)
    secureEquipedHolder:SetPos(0, EFGM.MenuScale(32))
    secureEquipedHolder:SetSize(EFGM.MenuScale(120), EFGM.MenuScale(120))
    function secureEquipedHolder:Paint(w, h)

        BlurPanel(secureEquipedHolder, EFGM.MenuScale(3))

        surface.SetDrawColor(Color(80, 80, 80, 10))
        surface.DrawRect(0, 0, w, h)

        surface.SetDrawColor(Color(255, 255, 255, 25))
        surface.DrawRect(0, 0, w, EFGM.MenuScale(1))
        surface.DrawRect(0, h - EFGM.MenuScale(1), w, EFGM.MenuScale(1))
        surface.DrawRect(0, 0, EFGM.MenuScale(1), h)
        surface.DrawRect(w - EFGM.MenuScale(1), 0, EFGM.MenuScale(1), h)

    end

    local secureEquipedIcon = vgui.Create("DImage", secureEquipedHolder)
    secureEquipedIcon:SetPos(EFGM.MenuScale(1), EFGM.MenuScale(18))
    secureEquipedIcon:SetSize(EFGM.MenuScale(120), EFGM.MenuScale(80))
    secureEquipedIcon:SetImage("icons/inventory_container_icon.png")
    secureEquipedIcon:SetImageColor(Color(255, 255, 255, 10))

    local secureSlotHolder = vgui.Create("DPanel", secureHolder)
    secureSlotHolder:SetPos(EFGM.MenuScale(124), EFGM.MenuScale(32))
    secureSlotHolder:SetSize(EFGM.MenuScale(448), EFGM.MenuScale(120))
    secureSlotHolder.Paint = function(s, w, h)

        surface.SetDrawColor(Color(0, 0, 0, 0))
        surface.DrawRect(0, 0, w, h)

    end

    -- dont show stash when player is in a raid
    if !Menu.Player:CompareStatus(0) then return end

    local stashPanel = vgui.Create("DPanel", contents)
    stashPanel:Dock(LEFT)
    stashPanel:DockMargin(EFGM.MenuScale(13), 0, 0, 0)
    stashPanel:SetSize(EFGM.MenuScale(613), 0)
    stashPanel.Paint = function(s, w, h)

        BlurPanel(s, EFGM.MenuScale(13))
        BlurPanel(s, EFGM.MenuScale(13))

        surface.SetDrawColor(Color(80, 80, 80, 10))
        surface.DrawRect(0, 0, w, h)

        surface.SetDrawColor(Color(255, 255, 255, 155))
        surface.DrawRect(0, 0, w, EFGM.MenuScale(6))

    end

    local currentStashUsed = 0
    local stashText = vgui.Create("DPanel", stashPanel)
    stashText:Dock(TOP)
    stashText:SetSize(0, EFGM.MenuScale(36))
    function stashText:Paint(w, h)

        surface.SetDrawColor(Color(155, 155, 155, 10))
        surface.DrawRect(0, 0, w, h)

        draw.SimpleTextOutlined("STASH", "PuristaBold32", EFGM.MenuScale(5), EFGM.MenuScale(19), MenuAlias.whiteColor, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER, 1, MenuAlias.blackColor)
        draw.SimpleTextOutlined(currentStashUsed .. "/144", "PuristaBold18", EFGM.MenuScale(95), EFGM.MenuScale(23), MenuAlias.whiteColor, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER, 1, MenuAlias.blackColor)

    end

    local stashHolder = vgui.Create("DScrollPanel", stashPanel)
    stashHolder:Dock(FILL)
    stashHolder:DockMargin(EFGM.MenuScale(37), 0, 0, 0)
    function stashHolder:Paint(w, h)

        surface.SetDrawColor(Color(80, 80, 80, 10))
        surface.DrawRect(0, 0, w, h)

        surface.SetDrawColor(Color(255, 255, 255, 25))
        surface.DrawRect(0, 0, w, EFGM.MenuScale(1))
        surface.DrawRect(0, 0, EFGM.MenuScale(1), h)
        surface.DrawRect(w - EFGM.MenuScale(1), 0, EFGM.MenuScale(1), h)

        for i = 1, stashHolder:GetTall() do

            if i % EFGM.MenuScale(64) == 0 then

                surface.DrawRect(0, i, w, EFGM.MenuScale(1))

                if i <= EFGM.MenuScale(576) then

                    surface.DrawRect(i, 0, EFGM.MenuScale(1), h)

                end

            end

        end

    end

    local stashBar = stashHolder:GetVBar()
    stashBar:SetSize(0, 0)

    local sortButton = vgui.Create("DImageButton", stashPanel)
    sortButton:SetPos(EFGM.MenuScale(0), EFGM.MenuScale(924))
    sortButton:SetSize(EFGM.MenuScale(36), EFGM.MenuScale(36))
    sortButton:SetImage("icons/sort_icon.png")
    sortButton:SetDepressImage(false)

    local sortButtonText = vgui.Create("DPanel", stashPanel)
    sortButtonText:SetSize(EFGM.MenuScale(577), EFGM.MenuScale(36))
    sortButtonText:SetPos(EFGM.MenuScale(37), EFGM.MenuScale(924))
    sortButtonText:SetAlpha(0)
    function sortButtonText:Paint(w, h)

        BlurPanel(sortButtonText, EFGM.MenuScale(5))

        surface.SetDrawColor(Color(80, 80, 80, 10))
        surface.DrawRect(0, 0, w, h)

        draw.SimpleTextOutlined("AUTO-SORT", "PuristaBold32", EFGM.MenuScale(5), EFGM.MenuScale(16), MenuAlias.whiteColor, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER, 1, MenuAlias.blackColor)

    end

    sortButton.OnCursorEntered = function(s)

        sortButtonText:AlphaTo(255, 0.05, 0)
        surface.PlaySound("ui/element_hover.wav")

    end

    sortButton.OnCursorExited = function(s)

        sortButtonText:AlphaTo(0, 0.05, 0)

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

    local entryBar = mainEntryList:GetVBar()
    entryBar:SetHideButtons(true)
    function entryBar:Paint(w, h)
        draw.RoundedBox(0, 0, 0, w, h, MenuAlias.transparent)
    end
    function entryBar.btnGrip:Paint(w, h)
        draw.RoundedBox(0, EFGM.MenuScale(5), EFGM.MenuScale(8), EFGM.MenuScale(5), h - EFGM.MenuScale(16), MenuAlias.transparent)
    end

    local subEntryPanel = vgui.Create("DPanel", contents)
    subEntryPanel:Dock(LEFT)
    subEntryPanel:SetSize(EFGM.MenuScale(180), 0)
    subEntryPanel:SetBackgroundColor(Color(0, 0, 0, 0))

    local subEntryList = vgui.Create("DIconLayout", subEntryPanel)
    subEntryList:Dock(LEFT)
    subEntryList:SetSize(EFGM.MenuScale(180), 0)

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

            function entry:OnCursorEntered()

                surface.PlaySound("ui/element_hover.wav")

            end

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
    function pmcPanelBar:Paint(w, h)
        draw.RoundedBox(0, 0, 0, w, h, MenuAlias.transparent)
    end
    function pmcPanelBar.btnGrip:Paint(w, h)
        draw.RoundedBox(0, EFGM.MenuScale(5), EFGM.MenuScale(8), EFGM.MenuScale(5), h - EFGM.MenuScale(16), MenuAlias.transparent)
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
    squadNameBG:SetBackgroundColor(Color(25, 25, 25, 155))

    local squadName = vgui.Create("DTextEntry", squadNameBG)
    squadName:Dock(FILL)
    squadName:SetPlaceholderText(" ")
    squadName:SetUpdateOnType(true)
    squadName:SetPaintBackground(false)
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
    squadPasswordBG:SetBackgroundColor(Color(25, 25, 25, 155))

    local squadPassword = vgui.Create("DTextEntry", squadPasswordBG)
    squadPassword:Dock(FILL)
    squadPassword:SetPlaceholderText(" ")
    squadPassword:SetUpdateOnType(true)
    squadPassword:SetPaintBackground(false)
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
    squadCreateButton:SetText("Create Squad")

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
    availableSquadsPanel:SetSize(0, EFGM.MenuScale(330))
    availableSquadsPanel.Paint = function(s, w, h)

        surface.SetDrawColor(MenuAlias.transparent)
        surface.DrawRect(0, 0, w, h)

    end

    local availableSquadsPanelBar = availableSquadsPanel:GetVBar()
    availableSquadsPanelBar:SetHideButtons(true)
    function availableSquadsPanelBar:Paint(w, h)
        draw.RoundedBox(0, 0, 0, w, h, MenuAlias.transparent)
    end
    function availableSquadsPanelBar.btnGrip:Paint(w, h)
        draw.RoundedBox(0, EFGM.MenuScale(5), EFGM.MenuScale(8), EFGM.MenuScale(5), h - EFGM.MenuScale(16), MenuAlias.transparent)
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

            -- mouse position
            local x, y = 0, 0
            local sideH, sideV

            squadEntry.OnCursorEntered = function(s)

                x, y = Menu.MenuFrame:CursorPos()
                surface.PlaySound("ui/element_hover.wav")

                -- offset for pop up depending on the quadrant of the mouse when first selected, true = left/up, false = right/down
                if x <= (ScrW() / 2) then sideH = true else sideH = false end
                if y <= (ScrH() / 2) then sideV = true else sideV = false end

                local function UpdatePopOutPos()

                    if sideH == true then

                        squadPopOut:SetX(math.Clamp(x - (Menu.MouseX * EFGM.MenuScale(20)), 0, ScrW() - squadPopOut:GetWide() - EFGM.MenuScale(40)))

                    else

                        squadPopOut:SetX(math.Clamp(x - squadPopOut:GetWide() - EFGM.MenuScale(10) - (Menu.MouseX * EFGM.MenuScale(20)), 0, ScrW() - squadPopOut:GetWide() - EFGM.MenuScale(40)))

                    end

                    if sideV == true then

                        squadPopOut:SetY(math.Clamp(y - EFGM.MenuScale(45) - (Menu.MouseY * EFGM.MenuScale(20)), 0, ScrH() - squadPopOut:GetTall() - EFGM.MenuScale(100)))
                    else

                        squadPopOut:SetY(math.Clamp(y - squadPopOut:GetTall() - EFGM.MenuScale(65) - (Menu.MouseY * EFGM.MenuScale(20)), 0, ScrH() - squadPopOut:GetTall() - EFGM.MenuScale(100)))

                    end

                end

                if IsValid(squadPopOut) then squadPopOut:Remove() end
                squadPopOut = vgui.Create("DPanel", Menu.MenuFrame.LowerPanel.Contents)
                squadPopOut:SetSize(EFGM.MenuScale(200), EFGM.MenuScale(60) + (memberCount * EFGM.MenuScale(19)))
                UpdatePopOutPos()
                squadPopOut:SetAlpha(0)
                squadPopOut:AlphaTo(255, 0.1, 0, function() end)

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
                    x, y = Menu.MenuFrame:CursorPos()

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

                    squadPasswordEntry.OnEnter = function(self)

                        RunConsoleCommand("efgm_squad_join", name, password)

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

    local currentSquadPanel = vgui.Create("DPanel", contents)
    currentSquadPanel:Dock(LEFT)
    currentSquadPanel:SetSize(EFGM.MenuScale(320), 0)
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

                function transferToMember:OnCursorEntered()

                    surface.PlaySound("ui/element_hover.wav")

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

                function kickMember:OnCursorEntered()

                    surface.PlaySound("ui/element_hover.wav")

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

function Menu.OpenTab.Shop()

    local contents = vgui.Create("DPanel", Menu.MenuFrame.LowerPanel)
    contents:Dock(FILL)
    contents:DockPadding(EFGM.MenuScale(10), EFGM.MenuScale(10), EFGM.MenuScale(10), EFGM.MenuScale(10))
    contents:SetAlpha(0)
    contents.Paint = function(s, w, h)

        surface.SetDrawColor(MenuAlias.transparent)
        surface.DrawRect(0, 0, w, h)

    end

    Menu.MenuFrame.LowerPanel.Contents = contents

    local sellerInventoryPanel, buyInventoryPanel, playerInventoryPanel, sellInventoryPanel = {}, {}, {}, {}

    -- { SELLER (Inventory on right)

        local sellerBackground = vgui.Create("DPanel", contents)
        sellerBackground:Dock(LEFT)
        sellerBackground:SetSize(EFGM.MenuScale(650), 0)
        sellerBackground:DockPadding(unpack(MenuAlias.margins))
        sellerBackground.Paint = function(s, w, h)

            surface.SetDrawColor(MenuAlias.primaryColor)
            surface.DrawRect(0, 0, w, h)

        end

        local sellerInventoryScroller = vgui.Create("DScrollPanel", sellerBackground)
        sellerInventoryScroller:Dock(BOTTOM)
        sellerInventoryScroller:SetSize(0, EFGM.MenuScale(450))
        sellerInventoryScroller.Paint = nil

        local buyScroller = vgui.Create("DScrollPanel", sellerBackground)
        buyScroller:Dock(TOP)
        buyScroller:SetSize(0, EFGM.MenuScale(200))
        buyScroller.Paint = nil

    -- }

    -- { PLAYER (Inventory on left)

        local playerBackground = vgui.Create("DPanel", contents)
        playerBackground:Dock(RIGHT)
        playerBackground:SetSize(EFGM.MenuScale(650), 0)
        playerBackground:DockPadding(unpack(MenuAlias.margins))
        playerBackground.Paint = function(s, w, h)

            surface.SetDrawColor(MenuAlias.primaryColor)
            surface.DrawRect(0, 0, w, h)

        end

        local playerInventoryScroller = vgui.Create("DScrollPanel", playerBackground)
        playerInventoryScroller:Dock(BOTTOM)
        playerInventoryScroller:SetSize(0, EFGM.MenuScale(450))
        playerInventoryScroller.Paint = nil

        local sellScroller = vgui.Create("DScrollPanel", playerBackground)
        sellScroller:Dock(TOP)
        sellScroller:SetSize(0, EFGM.MenuScale(200))
        sellScroller.Paint = nil

    -- }

    -- { MIDDLE ROW

        local purchaseInfoPanel = vgui.Create("DPanel", contents)
        purchaseInfoPanel:Dock(TOP)
        purchaseInfoPanel:SetSize(0, EFGM.MenuScale(200))
        purchaseInfoPanel.Paint = function(s, w, h)

            surface.SetDrawColor(MenuAlias.secondaryColor)
            surface.DrawRect(0, 0, w, h)

        end

        local purchaseButton = vgui.Create("DButton", purchaseInfoPanel)
        purchaseButton:Dock(TOP)
        purchaseButton:SetText("DEAL")
        purchaseButton:SetConsoleCommand("efgm_shop_transaction", SHOP:CompileOrders())

    -- }

    -- ima do this shit later
    -- fucking hell its later
    
    local transferLimit = {}
    transferLimit[1] = 1
    transferLimit[2] = 500

    local lotToLimit = {}

    lotToLimit[1] = {
        [-1] = transferLimit[1] -- setting arbitrary transfer limit to 500
    }

    lotToLimit[2] = {
        [-1] = transferLimit[2] -- setting arbitrary transfer limit to 500
    }

    local countNames = {

        [-1] = "A lot"

    }

    -- { INVENTORY INITIALIZATION

        playerInventory = inv.NewInventory() -- self[itemname] = table, table.count = int, table.type = int, table.transferCount = int (should be under or equal to count)

        sellerInventory = inv.NewInventory()

        function playerInventory:TransferItem(item, tCount)

            print("transferring "..item.." with transfer count of "..tCount)

            if self[item] == nil then return end

            self[item].tCount = tCount
            
            if tCount == 0 then

                SHOP:RemoveOrder(item, false)

            elseif tCount > 0 && tCount <= transferLimit then
                
                SHOP:AddOrder(item, self[item].type, tCount, false)

            end

        end

        function sellerInventory:TransferItem(item, tCount)

            print("transferring "..item.." with transfer count of "..tCount)

            if self[item] == nil then return end

            self[item].tCount = tCount
            
            if tCount == 0 then

                SHOP:RemoveOrder(item, true)

            elseif tCount > 0 && tCount <= transferLimit then
                
                SHOP:AddOrder(item, self[item].type, tCount, true)

            end

        end

        for k, v in pairs(Menu.Player:GetWeapons()) do
            
            local wep = v:GetClass()

            if CheckExists[1](wep) then
                
                playerInventory:AddItem(wep, 1, 1)

            end

        end

        for k, v in pairs(Menu.Player:GetAmmo()) do
            
            local ammo = game.GetAmmoName(k)

            if CheckExists[2](ammo) then
                
                playerInventory:AddItem(ammo, 2, v)

            end

        end

        for k, v in pairs(ITEMS) do
                
            sellerInventory:AddItem(k, v[1], -1)

            sellerInventory[k] = {}
            sellerInventory[k].count = -1
            sellerInventory[k].type = v[1]
            sellerInventory[k].transferCount = 0
            
        end

    -- }

    local function drawIcon(item, type, count, iconLayout)

        if !CheckExists[type](item) then return end

        local displayName, model, category, price = GetShopIconInfo[type](item)

        local iconPanel = iconLayout:Add("DPanel")
        iconPanel:SetSize(EFGM.MenuScale(120), EFGM.MenuScale(120))

        function iconPanel:Paint(w, h)

            surface.SetDrawColor(MenuAlias.secondaryColor)
            surface.DrawRect(EFGM.MenuScale(5), EFGM.MenuScale(5), w, h)

            draw.DrawText(displayName, "DermaDefaultBold", w / 2, 7, MenuAlias.blackColor, TEXT_ALIGN_CENTER)
            draw.DrawText(countNames[count] or count, "DermaDefaultBold", w / 2, h - 7, MenuAlias.blackColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_BOTTOM)

        end

        iconPanel.spawnButton = vgui.Create("SpawnIcon", iconPanel)
        iconPanel.spawnButton:SetSize(EFGM.MenuScale(80), EFGM.MenuScale(80))
        iconPanel.spawnButton:Center()
        iconPanel.spawnButton:SetModel(model)
        iconPanel.spawnButton:SetTooltip(displayName .." (".. revCat[category] ..")\n$"..price)

        return iconPanel

    end

    local function shitFart(item, itemType, itemCount, itemTCount, iconLayoutP, iconLayoutT, inventory) -- i really dont know what else to call it
    
        local iconP, iconT = {} -- shitty solution but idc (p meaning primary, t meaning transfer)

        if itemTCount == 0 then -- if not transferring

            iconP = drawIcon(item, itemType, itemCount, iconLayoutP)

            function iconP.spawnButton:DoClick()

                inventory:TransferItem( item, math.random(0, math.min( lotToLimit[itemCount] or itemCount, transferLimit ) ) )
                redrawMenus()

            end
        
        elseif itemTCount == itemCount then -- if transferring everything
            
            iconT = drawIcon(item, itemType, itemTCount, iconLayoutT)

            function iconT.spawnButton:DoClick()

                inventory:TransferItem( item, math.random(0, math.min( lotToLimit[itemCount] or itemCount, transferLimit ) ) )
                redrawMenus()

            end
        
        else -- if partial transfer

            iconT = drawIcon(item, itemType, itemTCount, iconLayoutT)

            function iconT.spawnButton:DoClick()

                inventory:TransferItem( item, math.random(0, math.min( lotToLimit[itemCount] or itemCount, transferLimit ) ) )
                redrawMenus()

            end

            iconP = drawIcon(item, itemType, math.Clamp( itemCount - itemTCount, -1, transferLimit ), iconLayoutP)

            function iconP.spawnButton:DoClick()

                inventory:TransferItem( item, math.random(0, math.min( lotToLimit[itemCount] or itemCount, transferLimit ) ) )
                redrawMenus()

            end
            
        end

    end

    function drawMenu()

        --{ BULLSHIT

            sellerInventoryPanel = vgui.Create("DIconLayout", sellerInventoryScroller)
            sellerInventoryPanel:Dock(FILL)
            sellerInventoryPanel:SetSpaceY(5)
            sellerInventoryPanel:SetSpaceX(5)
            sellerInventoryPanel:SetPaintBackgroundEnabled(true)
            sellerInventoryPanel.Paint = function(self, w, h)

                surface.SetDrawColor(Color(255, 0, 0))
                surface.DrawRect(0, 0, w, h)

            end

            buyInventoryPanel = vgui.Create("DIconLayout", buyScroller)
            buyInventoryPanel:Dock(FILL)
            buyInventoryPanel:SetSpaceY(5)
            buyInventoryPanel:SetSpaceX(5)
            buyInventoryPanel:SetPaintBackgroundEnabled(true)
            buyInventoryPanel.Paint = function(self, w, h)

                surface.SetDrawColor(Color(255, 0, 0))
                surface.DrawRect(0, 0, w, h)

            end

            playerInventoryPanel = vgui.Create("DIconLayout", playerInventoryScroller)
            playerInventoryPanel:Dock(FILL)
            playerInventoryPanel:SetSpaceY(5)
            playerInventoryPanel:SetSpaceX(5)
            playerInventoryPanel:SetPaintBackgroundEnabled(true)
            playerInventoryPanel.Paint = function(self, w, h)

                surface.SetDrawColor(Color(255, 0, 0))
                surface.DrawRect(0, 0, w, h)

            end

            sellInventoryPanel = vgui.Create("DIconLayout", sellScroller)
            sellInventoryPanel:Dock(FILL)
            sellInventoryPanel:SetSpaceY(5)
            sellInventoryPanel:SetSpaceX(5)
            sellInventoryPanel:SetPaintBackgroundEnabled(true)
            sellInventoryPanel.Paint = function(self, w, h)

                surface.SetDrawColor(Color(255, 0, 0))
                surface.DrawRect(0, 0, w, h)

            end

        --}

        for k, v in pairs(playerInventory) do
            
            if(type(v)) == "table" then

                shitFart(k, v.type, v.count, v.tCount or 0, playerInventoryPanel, sellInventoryPanel, playerInventory)

            end

        end

        for k, v in pairs(sellerInventory) do
            
            if(type(v)) == "table" then

                shitFart(k, v.type, v.count, v.tCount or 0, sellerInventoryPanel, buyInventoryPanel, sellerInventory)
                
            end
            
        end
        
        -- i hate this awfulness
        
        local contentWidth1, contentHeight1 = sellerInventoryPanel:GetContentSize()
        sellerInventoryScroller:GetCanvas():SetSize(contentWidth1, contentHeight1)
        
        local contentWidth2, contentHeight2 = buyInventoryPanel:GetContentSize()
        buyScroller:GetCanvas():SetSize(contentWidth2, contentHeight2)
        
        local contentWidth3, contentHeight3 = playerInventoryPanel:GetContentSize()
        playerInventoryScroller:GetCanvas():SetSize(contentWidth3, contentHeight3)
        
        local contentWidth4, contentHeight4 = sellInventoryPanel:GetContentSize()
        sellScroller:GetCanvas():SetSize(contentWidth4, contentHeight4)

    end

    function redrawMenus()

        sellerInventoryPanel:Remove()
        playerInventoryPanel:Remove()

        buyInventoryPanel:Remove()
        sellInventoryPanel:Remove()

        drawMenu()

    end

    drawMenu()

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
    function statsBar:Paint(w, h)
        draw.RoundedBox(0, 0, 0, w, h, MenuAlias.transparent)
    end
    function statsBar.btnGrip:Paint(w, h)
        draw.RoundedBox(0, EFGM.MenuScale(5), EFGM.MenuScale(8), EFGM.MenuScale(5), h - EFGM.MenuScale(16), MenuAlias.transparent)
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
    function skillsBar:Paint(w, h)
        draw.RoundedBox(0, 0, 0, w, h, MenuAlias.transparent)
    end
    function skillsBar.btnGrip:Paint(w, h)
        draw.RoundedBox(0, EFGM.MenuScale(5), EFGM.MenuScale(8), EFGM.MenuScale(5), h - EFGM.MenuScale(16), MenuAlias.transparent)
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

            x, y = Menu.MenuFrame:CursorPos()
            surface.PlaySound("ui/element_hover.wav")

            -- offset for pop up depending on the quadrant of the mouse when first selected, true = left/up, false = right/down
            if x <= (ScrW() / 2) then sideH = true else sideH = false end
            if y <= (ScrH() / 2) then sideV = true else sideV = false end

            -- for text size calculations
            surface.SetFont("Purista18")
            local skillDescTextSize = EFGM.MenuScale(surface.GetTextSize(v1.Description))

            local function UpdatePopOutPos()

                if sideH == true then

                    skillPopOut:SetX(math.Clamp(x - (Menu.MouseX * EFGM.MenuScale(20)), 0, ScrW() - skillPopOut:GetWide() - EFGM.MenuScale(40)))

                else

                    skillPopOut:SetX(math.Clamp(x - skillPopOut:GetWide() - EFGM.MenuScale(10) - (Menu.MouseX * EFGM.MenuScale(20)), 0, ScrW() - skillPopOut:GetWide() - EFGM.MenuScale(40)))

                end

                if sideV == true then

                    skillPopOut:SetY(math.Clamp(y - EFGM.MenuScale(45) - (Menu.MouseY * EFGM.MenuScale(20)), 0, ScrH() - skillPopOut:GetTall() - EFGM.MenuScale(100)))

                else

                    skillPopOut:SetY(math.Clamp(y - skillPopOut:GetTall() - EFGM.MenuScale(65) - (Menu.MouseY * EFGM.MenuScale(20)), 0, ScrH() - skillPopOut:GetTall() - EFGM.MenuScale(100)))

                end

            end

            if IsValid(skillPopOut) then skillPopOut:Remove() end
            skillPopOut = vgui.Create("DPanel", Menu.MenuFrame.LowerPanel.Contents)
            skillPopOut:SetSize(EFGM.MenuScale(10) + skillDescTextSize, EFGM.MenuScale(80))
            UpdatePopOutPos()
            skillPopOut:AlphaTo(255, 0.1, 0, function() end)

            skillPopOut.Paint = function(s, w, h)

                if !IsValid(s) then return end

                BlurPanel(s, EFGM.MenuScale(3))

                -- panel position follows mouse position
                x, y = Menu.MenuFrame:CursorPos()

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
    function gameplayBar:Paint(w, h)
        draw.RoundedBox(0, 0, 0, w, h, MenuAlias.transparent)
    end
    function gameplayBar.btnGrip:Paint(w, h)
        draw.RoundedBox(0, EFGM.MenuScale(5), EFGM.MenuScale(8), EFGM.MenuScale(5), h - EFGM.MenuScale(16), MenuAlias.transparent)
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
    function controlsBar:Paint(w, h)
        draw.RoundedBox(0, 0, 0, w, h, MenuAlias.transparent)
    end
    function controlsBar.btnGrip:Paint(w, h)
        draw.RoundedBox(0, EFGM.MenuScale(5), EFGM.MenuScale(8), EFGM.MenuScale(5), h - EFGM.MenuScale(16), MenuAlias.transparent)
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
    function interfaceBar:Paint(w, h)
        draw.RoundedBox(0, 0, 0, w, h, MenuAlias.transparent)
    end
    function interfaceBar.btnGrip:Paint(w, h)
        draw.RoundedBox(0, EFGM.MenuScale(5), EFGM.MenuScale(8), EFGM.MenuScale(5), h - EFGM.MenuScale(16), MenuAlias.transparent)
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
    function visualsBar:Paint(w, h)
        draw.RoundedBox(0, 0, 0, w, h, MenuAlias.transparent)
    end
    function visualsBar.btnGrip:Paint(w, h)
        draw.RoundedBox(0, EFGM.MenuScale(5), EFGM.MenuScale(8), EFGM.MenuScale(5), h - EFGM.MenuScale(16), MenuAlias.transparent)
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
    function accountBar:Paint(w, h)
        draw.RoundedBox(0, 0, 0, w, h, MenuAlias.transparent)
    end
    function accountBar.btnGrip:Paint(w, h)
        draw.RoundedBox(0, EFGM.MenuScale(5), EFGM.MenuScale(8), EFGM.MenuScale(5), h - EFGM.MenuScale(16), MenuAlias.transparent)
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
    function miscBar:Paint(w, h)
        draw.RoundedBox(0, 0, 0, w, h, MenuAlias.transparent)
    end
    function miscBar.btnGrip:Paint(w, h)
        draw.RoundedBox(0, EFGM.MenuScale(5), EFGM.MenuScale(8), EFGM.MenuScale(5), h - EFGM.MenuScale(16), MenuAlias.transparent)
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

        draw.SimpleTextOutlined("Aim Down Sight Sensitivity", "Purista18", w / 2, EFGM.MenuScale(5), MenuAlias.whiteColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 1, MenuAlias.blackColor)

    end

    local adsSens = vgui.Create("DNumSlider", adsSensPanel)
    adsSens:SetPos(EFGM.MenuScale(33), EFGM.MenuScale(30))
    adsSens:SetSize(EFGM.MenuScale(200), EFGM.MenuScale(15))
    adsSens:SetConVar("arc9_mult_sens")
    adsSens:SetMin(0)
    adsSens:SetMax(2)
    adsSens:SetDecimals(2)

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

    local dropWeaponPanel = vgui.Create("DPanel", controls)
    dropWeaponPanel:Dock(TOP)
    dropWeaponPanel:SetSize(0, EFGM.MenuScale(55))
    function dropWeaponPanel:Paint(w, h)

        draw.SimpleTextOutlined("Drop Weapon keybind", "Purista18", w / 2, EFGM.MenuScale(5), MenuAlias.whiteColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 1, MenuAlias.blackColor)

    end

    local dropWeapon = vgui.Create("DBinder", dropWeaponPanel)
    dropWeapon:SetPos(EFGM.MenuScale(110), EFGM.MenuScale(30))
    dropWeapon:SetSize(EFGM.MenuScale(100), EFGM.MenuScale(20))
    dropWeapon:SetSelectedNumber(GetConVar("efgm_bind_dropweapon"):GetInt())
    function dropWeapon:OnChange(num)

        RunConsoleCommand("efgm_bind_dropweapon", dropWeapon:GetSelectedNumber())

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

        draw.SimpleTextOutlined("Game Menu Parallax", "Purista18", w / 2, EFGM.MenuScale(5), MenuAlias.whiteColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 1, MenuAlias.blackColor)

    end

    local menuParallax = vgui.Create("DCheckBox", menuParallaxPanel)
    menuParallax:SetPos(EFGM.MenuScale(152), EFGM.MenuScale(30))
    menuParallax:SetConVar("efgm_menu_parallax")
    menuParallax:SetSize(EFGM.MenuScale(15), EFGM.MenuScale(15))

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

        draw.SimpleTextOutlined("Viewmodel Y Position", "Purista18", w / 2, EFGM.MenuScale(5), MenuAlias.whiteColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 1, MenuAlias.blackColor)

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

    local viewRollPanel = vgui.Create("DPanel", visuals)
    viewRollPanel:Dock(TOP)
    viewRollPanel:SetSize(0, EFGM.MenuScale(50))
    function viewRollPanel:Paint(w, h)

        draw.SimpleTextOutlined("View Rolling", "Purista18", w / 2, EFGM.MenuScale(5), MenuAlias.whiteColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 1, MenuAlias.blackColor)

    end

    local viewRoll = vgui.Create("DCheckBox", viewRollPanel)
    viewRoll:SetPos(EFGM.MenuScale(152), EFGM.MenuScale(30))
    viewRoll:SetConVar("efgm_visuals_viewroll")
    viewRoll:SetSize(EFGM.MenuScale(15), EFGM.MenuScale(15))

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

    local clTPIKPanel = vgui.Create("DPanel", visuals)
    clTPIKPanel:Dock(TOP)
    clTPIKPanel:SetSize(0, EFGM.MenuScale(50))
    function clTPIKPanel:Paint(w, h)

        draw.SimpleTextOutlined("High Quality TPP Animations", "Purista18", w / 2, EFGM.MenuScale(5), MenuAlias.whiteColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 1, MenuAlias.blackColor)

    end

    local clTPIK = vgui.Create("DCheckBox", clTPIKPanel)
    clTPIK:SetPos(EFGM.MenuScale(152), EFGM.MenuScale(30))
    clTPIK:SetConVar("arc9_tpik")
    clTPIK:SetSize(EFGM.MenuScale(15), EFGM.MenuScale(15))

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

    Menu:Open(tab)

end)