
-- establishes global menu object, this will have tabs and will handle shit like shop, player progression, in-raid shit, other stuff
-- this is not a panel, but a collection of panels and supporting functions
Menu = {}

Menu.MusicList = {"sound/music/menu_01.mp4", "sound/music/menu_02.mp4", "sound/music/menu_03.mp4", "sound/music/menu_04.mp4"}
Menu.TabList = {"stats", "match", "inventory", "intel", "settings"}
Menu.ActiveTab = ""

local menuBind = GetConVar("efgm_bind_menu"):GetInt()
cvars.AddChangeCallback("efgm_bind_menu", function(convar_name, value_old, value_new)
    menuBind = tonumber(value_new)
end)

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
    tabParentPanel:Dock(TOP)
    tabParentPanel:SetSize(0, EFGM.MenuScale(25))

    function tabParentPanel:Paint(w, h)

        surface.SetDrawColor(0, 0, 0, 0)
        surface.DrawRect(0, 0, w, h)

    end

    self.MenuFrame.TabParentPanel = tabParentPanel

    local lowerPanel = vgui.Create("DPanel", self.MenuFrame)
    lowerPanel:SetSize(EFGM.MenuScale(1880), EFGM.MenuScale(980))
    lowerPanel:NoClipping(true)

    function lowerPanel:Paint(w, h)

        surface.SetDrawColor(0, 0, 0, 0)
        surface.DrawRect(0, 0, w, h)

        if GetConVar("efgm_menu_parallax"):GetInt() == 1 then

            if Menu.MenuFrame.Closing then return end

            local x, y = menuFrame:CursorPos()

            local mouseX = (x / math.Round(EFGM.MenuScale(1900), 1)) - 0.5
            local mouseY = (y / math.Round(EFGM.MenuScale(1060), 1)) - 0.5

            lowerPanel:SetPos(ScrW() / 2 - (EFGM.MenuScale(1900) / 2) + (mouseX * EFGM.MenuScale(20)), 1060 / 2 - (920 / 2) + (mouseY * EFGM.MenuScale(20)))

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

        surface.SetDrawColor(Color(0, 0, 0, 0))
        surface.DrawRect(0, 0, w, h)

    end

    Menu.MenuFrame.LowerPanel.Contents = contents

    -- for text size calculations
    surface.SetFont("PuristaBold18")

    local statsTab = vgui.Create("DButton", self.MenuFrame.TabParentPanel)
    statsTab:Dock(LEFT)
    statsTab:SetFont("PuristaBold18")
    statsTab:SetSize(surface.GetTextSize(tostring(LocalPlayer():Name())) + EFGM.MenuScale(50), 0)
    statsTab:SetText(LocalPlayer():Name())

    function statsTab:DoClick()

        if Menu.ActiveTab == "Stats" then return end

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

    local matchTab = vgui.Create("DButton", self.MenuFrame.TabParentPanel)
    matchTab:Dock(LEFT)
    matchTab:SetFont("PuristaBold18")
    matchTab:SetSize(surface.GetTextSize("Match") + EFGM.MenuScale(50), 0)
    matchTab:SetText("Match")

    function matchTab:DoClick()

        if !Menu.Player:CompareStatus(0) then

            surface.PlaySound("common/wpn_denyselect.wav")
            return

        end

        if Menu.ActiveTab == "Match" then return end

        Menu.MenuFrame.LowerPanel.Contents:AlphaTo(0, 0.05, 0, function()

            Menu.MenuFrame.LowerPanel.Contents:Remove()
            Menu.OpenTab.Match()
            Menu.ActiveTab = "Match"

            Menu.MenuFrame.LowerPanel.Contents:AlphaTo(255, 0.05, 0, function() end)

        end)

        net.Start("AddPlayerSquadRF")
        net.SendToServer()
    end

    local inventoryTab = vgui.Create("DButton", self.MenuFrame.TabParentPanel)
    inventoryTab:Dock(LEFT)
    inventoryTab:SetFont("PuristaBold18")
    inventoryTab:SetSize(surface.GetTextSize("Inventory") + EFGM.MenuScale(50), 0)
    inventoryTab:SetText("Inventory")

    function inventoryTab:DoClick()

        if Menu.ActiveTab == "Match" then

            net.Start("RemovePlayerSquadRF")
            net.SendToServer()

        end

        -- placeholder until inventory functions chop chop portapotty
        surface.PlaySound("common/wpn_denyselect.wav")
        return

        Menu.MenuFrame.LowerPanel.Contents:AlphaTo(0, 0.05, 0, function()

            Menu.MenuFrame.LowerPanel.Contents:Remove()
            Menu.OpenTab.Inventory()
            Menu.ActiveTab = "Inventory"

            Menu.MenuFrame.LowerPanel.Contents:AlphaTo(255, 0.05, 0, function() end)

        end)

    end

    local intelTab = vgui.Create("DButton", self.MenuFrame.TabParentPanel)
    intelTab:Dock(LEFT)
    intelTab:SetFont("PuristaBold18")
    intelTab:SetSize(surface.GetTextSize("Intel") + EFGM.MenuScale(50), 0)
    intelTab:SetText("Intel")

    function intelTab:DoClick()

        if Menu.ActiveTab == "Intel" then return end

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

    -- local contractsTab = vgui.Create("DButton", self.MenuFrame.TabParentPanel)
    -- contractsTab:Dock(LEFT)
    -- contractsTab:SetFont("PuristaBold18")
    -- contractsTab:SetSize(surface.GetTextSize("Contracts") + EFGM.MenuScale(50), 0)
    -- contractsTab:SetText("Contracts")

    -- local unlocksTab = vgui.Create("DButton", self.MenuFrame.TabParentPanel)
    -- unlocksTab:Dock(LEFT)
    -- unlocksTab:SetFont("PuristaBold18")
    -- unlocksTab:SetSize(surface.GetTextSize("Unlocks") + EFGM.MenuScale(50), 0)
    -- unlocksTab:SetText("Unlocks")

    local settingsTab = vgui.Create("DButton", self.MenuFrame.TabParentPanel)
    settingsTab:Dock(LEFT)
    settingsTab:SetFont("PuristaBold18")
    settingsTab:SetSize(surface.GetTextSize("Settings") + EFGM.MenuScale(50), 0)
    settingsTab:SetText("Settings")

    function settingsTab:DoClick()

        if Menu.ActiveTab == "Settings" then return end

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

    local unblurTab = vgui.Create("DButton", self.MenuFrame.TabParentPanel)
    unblurTab:Dock(RIGHT)
    unblurTab:SetFont("PuristaBold18")
    unblurTab:SetSize(surface.GetTextSize("") + EFGM.MenuScale(25), 0)
    unblurTab:SetText("")

    function unblurTab:DoClick()

        if Menu.MenuFrame.Unblur == false then

            Menu.MenuFrame.Unblur = true

        else

            Menu.MenuFrame.Unblur = false

        end

    end

    -- if provided, open to the tab of the users choice
    if openTo != nil then

        -- i cant figure this out so enjoy the Stats tab
        Menu.OpenTab.Stats()
        Menu.MenuFrame.LowerPanel.Contents:AlphaTo(255, 0.05, 0, function() end)
        Menu.ActiveTab = "Stats"

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
    contents:DockPadding(EFGM.MenuScale(10), EFGM.MenuScale(10), EFGM.MenuScale(10), EFGM.MenuScale(10))
    contents.Paint = function(s, w, h)

        surface.SetDrawColor(Color(0, 0, 0, 0))
        surface.DrawRect(0, 0, w, h)

    end

    Menu.MenuFrame.LowerPanel.Contents = contents

end

function Menu.OpenTab.Intel()

    local contents = vgui.Create("DPanel", Menu.MenuFrame.LowerPanel)
    contents:Dock(FILL)
    contents:DockPadding(EFGM.MenuScale(10), EFGM.MenuScale(10), EFGM.MenuScale(10), EFGM.MenuScale(10))
    contents:SetAlpha(0)
    contents.Paint = function(s, w, h)

        surface.SetDrawColor(Color(0, 0, 0, 0))
        surface.DrawRect(0, 0, w, h)

    end

    Menu.MenuFrame.LowerPanel.Contents = contents

    local mainEntryList = vgui.Create("DCategoryList", contents)
    mainEntryList:Dock(LEFT)
    mainEntryList:SetSize(EFGM.MenuScale(180), 0)
    mainEntryList:SetBackgroundColor(Color(0, 0, 0, 100))

    local subEntryList = vgui.Create("DIconLayout", contents)
    subEntryList:Dock(LEFT)
    subEntryList:SetSize(EFGM.MenuScale(180), 0)

    local entryPanel = vgui.Create("DPanel", contents)
    entryPanel:Dock(FILL)
    function entryPanel:Paint(w, h)
        surface.SetDrawColor(50, 50, 50, 0)
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

                    surface.SetDrawColor(190, 190, 190)
                    if k % 2 == 1 then 
                        surface.SetDrawColor(210, 210, 210)
                    end

                    surface.DrawRect(0, (k - 1) * EFGM.MenuScale(40), w, EFGM.MenuScale(40))

                    local text = markup.Parse( "<font=PuristaBold32><color=0,0,0>\n\n" .. v .. "</color></font>", w - EFGM.MenuScale(40) )
                    text:Draw(EFGM.MenuScale(20), (k - 1) * EFGM.MenuScale(40) + EFGM.MenuScale(5))

                end

            end

        else

            entryStats:SetSize(0, 0)
            entryStats.Paint = nil
            
        end

        function entryTextDisplay:Paint(w, h)

            -- chatgpt hallucinated an entire fucking function to get this shit to wrap, apologised profusely when called out on its artificial bs, but then told me about markup thanks chatgpt

            local text = markup.Parse( "<font=PuristaBold64><color=50,212,50>" .. entryName .. "</color></font><font=Purista32><color=255,255,255>\n" .. entryText .. "</color></font>", w - EFGM.MenuScale(40) )
            text:Draw(EFGM.MenuScale(20), EFGM.MenuScale(20))

        end

    end

    -- Entries

    for k1, v1 in pairs(Intel) do

        local category = mainEntryList:Add(k1)
        category:DoExpansion(true)

        for k2, v2 in pairs(v1) do

            local entry = category:Add(v2.Name)
            function entry:DoClick()

                subEntryList:Clear()
                DrawEntry(v2.Name, v2.Description, v2.Stats)

                for k3, v3 in ipairs(v2.Children) do -- jesus christ

                    local subEntry = subEntryList:Add("DButton")
                    subEntry:SetSize(EFGM.MenuScale(180), EFGM.MenuScale(20))
                    subEntry:SetFont("PuristaBold18")
                    subEntry:SetText(v3.Name)
                    function subEntry:DoClick()

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

        surface.SetDrawColor(Color(0, 0, 0, 0))
        surface.DrawRect(0, 0, w, h)

    end

    Menu.MenuFrame.LowerPanel.Contents = contents

    local pmcPanel = vgui.Create("DScrollPanel", contents)
    pmcPanel:Dock(LEFT)
    pmcPanel:SetSize(EFGM.MenuScale(320), 0)
    pmcPanel.Paint = function(s, w, h)

        surface.SetDrawColor(Color(0, 0, 0, 0))
        surface.DrawRect(0, 0, w, h)

    end

    local pmcTitle = vgui.Create("DPanel", pmcPanel)
    pmcTitle:Dock(TOP)
    pmcTitle:SetSize(0, EFGM.MenuScale(32))
    function pmcTitle:Paint(w, h)

        surface.SetDrawColor(Color(0, 0, 0, 0))
        surface.DrawRect(0, 0, w, h)

        draw.SimpleTextOutlined("OPERATORS", "PuristaBold32", w / 2, 0, MenuAlias.whiteColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 1, MenuAlias.blackColor)

    end

    local pmcPanelBar = pmcPanel:GetVBar()
    pmcPanelBar:SetHideButtons(true)
    function pmcPanelBar:Paint(w, h)
        draw.RoundedBox(0, 0, 0, w, h, Color(0, 0, 0, 0))
    end
    function pmcPanelBar.btnGrip:Paint(w, h)
        draw.RoundedBox(0, EFGM.MenuScale(5), EFGM.MenuScale(8), EFGM.MenuScale(5), h - EFGM.MenuScale(16), Color(0, 0, 0, 0))
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
                    if v:IsMuted() then v:SetMuted(false) else v:SetMuted(true) end
                end)

                if v:IsMuted() then mute:SetIcon("icon16/sound.png") mute:SetText("Unmute Player") else mute:SetIcon("icon16/sound_mute.png") mute:SetText("Mute Player") end
            end

            dropdown:Open()
        end
    end

    local squadPanel = vgui.Create("DPanel", contents)
    squadPanel:Dock(LEFT)
    squadPanel:SetSize(EFGM.MenuScale(320), 0)
    squadPanel.Paint = function(s, w, h)

        surface.SetDrawColor(Color(0, 0, 0, 0))
        surface.DrawRect(0, 0, w, h)

    end

    local CreateSquadPlayerLimit
    local CreateSquadColor = {RED = 255, GREEN = 255, BLUE = 255}

    local createSquadTitle = vgui.Create("DPanel", squadPanel)
    createSquadTitle:Dock(TOP)
    createSquadTitle:SetSize(0, EFGM.MenuScale(32))
    function createSquadTitle:Paint(w, h)

        surface.SetDrawColor(Color(0, 0, 0, 0))
        surface.DrawRect(0, 0, w, h)

        draw.SimpleTextOutlined("CREATE SQUAD", "PuristaBold32", w / 2, 0, MenuAlias.whiteColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 1, MenuAlias.blackColor)

    end

    squadNamePanel = vgui.Create("DPanel", squadPanel)
    squadNamePanel:Dock(TOP)
    squadNamePanel:SetSize(0, EFGM.MenuScale(55))
    squadNamePanel.Paint = function(s, w, h)

        surface.SetDrawColor(Color(0, 0, 0, 0))
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
    squadName:SetFont("PuristaBold18")
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

        surface.SetDrawColor(Color(0, 0, 0, 0))
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
    squadPassword:SetFont("PuristaBold18")
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
    squadMemberLimit:SetFont("PuristaBold18")

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
    squadColorR:SetFont("PuristaBold18")

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
    squadColorG:SetFont("PuristaBold18")

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
    squadColorB:SetFont("PuristaBold18")

    squadColorB.OnValueChanged = function(self)

        val = math.Clamp(self:GetValue(), self:GetMin(), self:GetMax())
        CreateSquadColor.BLUE = val

    end
    squadColorB:SetValue(255) -- so, how has your day been?

    local squadCreateButton = vgui.Create("DButton", squadColorPanel)
    squadCreateButton:SetPos(EFGM.MenuScale(85), EFGM.MenuScale(75))
    squadCreateButton:SetSize(EFGM.MenuScale(150), EFGM.MenuScale(20))
    squadCreateButton:SetFont("PuristaBold18")
    squadCreateButton:SetText("Create Squad")

    function squadCreateButton:DoClick()

        RunConsoleCommand("efgm_squad_create", squadName:GetValue(), squadPassword:GetValue(), CreateSquadPlayerLimit, CreateSquadColor.RED, CreateSquadColor.GREEN, CreateSquadColor.BLUE)

    end

    local joinSquadTitle = vgui.Create("DPanel", squadPanel)
    joinSquadTitle:Dock(TOP)
    joinSquadTitle:SetSize(0, EFGM.MenuScale(32 + 10))
    function joinSquadTitle:Paint(w, h)

        surface.SetDrawColor(Color(0, 0, 0, 0))
        surface.DrawRect(0, 0, w, h)

        draw.SimpleTextOutlined("JOIN SQUAD", "PuristaBold32", w / 2, 0, MenuAlias.whiteColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 1, MenuAlias.blackColor)

    end

    local availableSquadsPanel = vgui.Create("DScrollPanel", squadPanel)
    availableSquadsPanel:Dock(TOP)
    availableSquadsPanel:SetSize(0, EFGM.MenuScale(330))
    availableSquadsPanel.Paint = function(s, w, h)

        surface.SetDrawColor(Color(0, 0, 0, 0))
        surface.DrawRect(0, 0, w, h)

    end

    local availableSquadsPanelBar = availableSquadsPanel:GetVBar()
    availableSquadsPanelBar:SetHideButtons(true)
    function availableSquadsPanelBar:Paint(w, h)
        draw.RoundedBox(0, 0, 0, w, h, Color(0, 0, 0, 0))
    end
    function availableSquadsPanelBar.btnGrip:Paint(w, h)
        draw.RoundedBox(0, EFGM.MenuScale(5), EFGM.MenuScale(8), EFGM.MenuScale(5), h - EFGM.MenuScale(16), Color(0, 0, 0, 0))
    end

    local availableSquadsList = vgui.Create("DListLayout", availableSquadsPanel)
    availableSquadsList:Dock(TOP)
    availableSquadsList:SetSize(0, EFGM.MenuScale(330))

    function GenerateJoinableSquads(array)

        for k, v in SortedPairs(array) do

            local name = k
            local color = v.COLOR
            local owner = v.OWNER
            local status
            local password = v.PASSWORD
            local limit = v.LIMIT
            local members = v.MEMBERS
            local memberCount = table.Count(v.MEMBERS)
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

                    RunConsoleCommand("efgm_squad_join", name, password)

                end

            end

            -- mouse position
            local x, y = 0, 0

            squadEntry.OnCursorEntered = function(s)

                x, y = Menu.MenuFrame:CursorPos()

                if IsValid(squadPopOut) then squadPopOut:Remove() end
                squadPopOut = vgui.Create("DPanel", Menu.MenuFrame.LowerPanel.Contents)
                squadPopOut:SetSize(EFGM.MenuScale(200), EFGM.MenuScale(60) + (memberCount * EFGM.MenuScale(19)))
                squadPopOut:SetPos(x + EFGM.MenuScale(10), y - EFGM.MenuScale(45))
                squadPopOut:SetAlpha(0)
                squadPopOut:AlphaTo(255, 0.2, 0, function() end)

                -- panel needs to be slightly taller for password entry
                if protected and open then
                    squadPopOut:SetSize(EFGM.MenuScale(200), EFGM.MenuScale(90) + (memberCount * EFGM.MenuScale(19)))
                end

                squadPopOut.Paint = function(s, w, h)

                    if !IsValid(s) then return end

                    -- panel position follows mouse position
                    x, y = Menu.MenuFrame:CursorPos()
                    squadPopOut:SetPos(x + EFGM.MenuScale(10), y - EFGM.MenuScale(45))

                    surface.SetDrawColor(Color(0, 0, 0, 225))
                    surface.DrawRect(0, 0, w, h)

                    surface.SetDrawColor(Color(color.RED, color.GREEN, color.BLUE, 45))
                    surface.DrawRect(0, 0, w, h)

                    surface.SetDrawColor(Color(color.RED, color.GREEN, color.BLUE, 255))
                    surface.DrawRect(0, 0, w, 5)

                    draw.SimpleTextOutlined("MEMBERS", "PuristaBold24", EFGM.MenuScale(5), EFGM.MenuScale(5), MenuAlias.whiteColor, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP, 1, MenuAlias.blackColor)

                    -- draw name for each member
                    for k, v in SortedPairs(members) do

                        if v == owner then

                            draw.SimpleTextOutlined(v:GetName() .. "*", "PuristaBold18", EFGM.MenuScale(27), (k * EFGM.MenuScale(20)) + EFGM.MenuScale(10), MenuAlias.whiteColor, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP, 1, MenuAlias.blackColor)
                        else

                            draw.SimpleTextOutlined(v:GetName(), "PuristaBold18", EFGM.MenuScale(27), (k * EFGM.MenuScale(20)) + EFGM.MenuScale(10), MenuAlias.whiteColor, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP, 1, MenuAlias.blackColor)

                        end

                    end

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
                if protected and open then

                    squadPasswordEntryBG = vgui.Create("DPanel", squadPopOut)
                    squadPasswordEntryBG:SetPos(EFGM.MenuScale(5), squadPopOut:GetTall() - EFGM.MenuScale(43))
                    squadPasswordEntryBG:SetSize(EFGM.MenuScale(181), EFGM.MenuScale(20))
                    squadPasswordEntryBG:SetBackgroundColor(Color(25, 25, 25, 155))

                    local squadPasswordEntry = vgui.Create("DTextEntry", squadPasswordEntryBG)
                    squadPasswordEntry:Dock(FILL)
                    squadPasswordEntry:SetPlaceholderText(" ")
                    squadPasswordEntry:SetFont("PuristaBold18")
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

    net.Receive("SendSquadData", function(len, ply)

        availableSquadsList:Clear()
        if IsValid(squadPopOut) then squadPopOut:Remove() end
        squadArray = table.Copy(net.ReadTable())
        GenerateJoinableSquads(squadArray)

    end )

    net.Start("GrabSquadData", true)
    net.SendToServer()

    local joinSquadLegacyTitle = vgui.Create("DPanel", squadPanel)
    joinSquadLegacyTitle:Dock(TOP)
    joinSquadLegacyTitle:SetSize(0, EFGM.MenuScale(32))
    function joinSquadLegacyTitle:Paint(w, h)

        surface.SetDrawColor(Color(0, 0, 0, 0))
        surface.DrawRect(0, 0, w, h)

        draw.SimpleTextOutlined("JOIN SQUAD (LEGACY)", "PuristaBold32", w / 2, 0, MenuAlias.whiteColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 1, MenuAlias.blackColor)

    end

    squadJoinLegacyPanel = vgui.Create("DPanel", squadPanel)
    squadJoinLegacyPanel:Dock(TOP)
    squadJoinLegacyPanel:SetSize(0, EFGM.MenuScale(55 + 55))
    squadJoinLegacyPanel.Paint = function(s, w, h)

        surface.SetDrawColor(Color(0, 0, 0, 0))
        surface.DrawRect(0, 0, w, h)

        draw.SimpleTextOutlined("Squad Name", "Purista18", w / 2, EFGM.MenuScale(5), MenuAlias.whiteColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 1, MenuAlias.blackColor)

    end

    squadJoinLegacyBG = vgui.Create("DPanel", squadJoinLegacyPanel)
    squadJoinLegacyBG:SetPos(EFGM.MenuScale(85), EFGM.MenuScale(30))
    squadJoinLegacyBG:SetSize(EFGM.MenuScale(150), EFGM.MenuScale(20))
    squadJoinLegacyBG:SetBackgroundColor(Color(25, 25, 25, 155))

    local squadJoinLegacy = vgui.Create("DTextEntry", squadJoinLegacyBG)
    squadJoinLegacy:Dock(FILL)
    squadJoinLegacy:SetPlaceholderText(" ")
    squadJoinLegacy:SetFont("PuristaBold18")
    squadJoinLegacy:SetPaintBackground(false)
    squadJoinLegacy:SetTextColor(MenuAlias.whiteColor)
    squadJoinLegacy:SetCursorColor(MenuAlias.whiteColor)

    squadJoinLegacy.OnEnter = function(self)
        RunConsoleCommand("efgm_team_join", self:GetValue())
    end

    local squadLeaveLegacy = vgui.Create("DButton", squadJoinLegacyPanel)
    squadLeaveLegacy:SetPos(EFGM.MenuScale(85), EFGM.MenuScale(55))
    squadLeaveLegacy:SetSize(EFGM.MenuScale(150), EFGM.MenuScale(20))
    squadLeaveLegacy:SetFont("PuristaBold18")
    squadLeaveLegacy:SetText("Leave Current Squad")

    function squadLeaveLegacy:DoClick()
        RunConsoleCommand("efgm_team_leave")
    end

end

function Menu.OpenTab.Shop()

    local contents = vgui.Create("DPanel", Menu.MenuFrame.LowerPanel)
    contents:Dock(FILL)
    contents:DockPadding(EFGM.MenuScale(10), EFGM.MenuScale(10), EFGM.MenuScale(10), EFGM.MenuScale(10))
    contents:SetAlpha(0)
    contents.Paint = function(s, w, h)

        surface.SetDrawColor(Color(0, 0, 0, 0))
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
        purchaseButton:SetFont("PuristaBold18")
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

        for k, v in pairs(LocalPlayer():GetWeapons()) do
            
            local wep = v:GetClass()

            if CheckExists[1](wep) then
                
                playerInventory:AddItem(wep, 1, 1)

            end

        end

        for k, v in pairs(LocalPlayer():GetAmmo()) do
            
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

        surface.SetDrawColor(Color(0, 0, 0, 0))
        surface.DrawRect(0, 0, w, h)

    end

    Menu.MenuFrame.LowerPanel.Contents = contents

    local stats = vgui.Create("DScrollPanel", contents)
    stats:Dock(LEFT)
    stats:SetSize(EFGM.MenuScale(320), 0)
    stats.Paint = function(s, w, h)

        surface.SetDrawColor(Color(0, 0, 0, 0))
        surface.DrawRect(0, 0, w, h)

    end

    local statsTitle = vgui.Create("DPanel", stats)
    statsTitle:Dock(TOP)
    statsTitle:SetSize(0, EFGM.MenuScale(32))
    function statsTitle:Paint(w, h)

        surface.SetDrawColor(Color(0, 0, 0, 0))
        surface.DrawRect(0, 0, w, h)

        draw.SimpleTextOutlined("STATISTICS", "PuristaBold32", w / 2, 0, MenuAlias.whiteColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 1, MenuAlias.blackColor)

    end

    local statsBar = stats:GetVBar()
    statsBar:SetHideButtons(true)
    function statsBar:Paint(w, h)
        draw.RoundedBox(0, 0, 0, w, h, Color(0, 0, 0, 0))
    end
    function statsBar.btnGrip:Paint(w, h)
        draw.RoundedBox(0, EFGM.MenuScale(5), EFGM.MenuScale(8), EFGM.MenuScale(5), h - EFGM.MenuScale(16), Color(0, 0, 0, 0))
    end

    local importantStats = vgui.Create("DPanel", stats)
    importantStats:Dock(TOP)
    importantStats:SetSize(0, EFGM.MenuScale(500))
    importantStats.Paint = function(s, w, h)

        surface.SetDrawColor(Color(0, 0, 0, 0))
        surface.DrawRect(0, 0, w, h)

    end

    local playerInfo = vgui.Create("DPanel", contents)
    playerInfo:Dock(TOP)
    playerInfo:SetSize(0, EFGM.MenuScale(300))
    playerInfo.Paint = function(s, w, h)

        surface.SetDrawColor(Color(0, 0, 0, 0))
        surface.DrawRect(0, 0, w, h)

    end

    -- only temporary, I gotta find a way to automate this shit

    local stats = {}

    stats.Level = LocalPlayer():GetNWInt("Level")
    stats.Experience = LocalPlayer():GetNWInt("Experience")
    stats.MoneyEarned = LocalPlayer():GetNWInt("MoneyEarned")
    stats.MoneySpent = LocalPlayer():GetNWInt("MoneySpent")
    stats.Time = LocalPlayer():GetNWInt("Time")
    stats.StashValie = LocalPlayer():GetNWInt("StashValie")

    stats.Kills = LocalPlayer():GetNWInt("Kills")
    stats.Deaths = LocalPlayer():GetNWInt("Deaths")
    stats.Suicides = LocalPlayer():GetNWInt("Suicides")
    stats.DamageGiven = LocalPlayer():GetNWInt("DamageGiven")
    stats.DamageRecieved = LocalPlayer():GetNWInt("DamageRecieved")
    stats.DamageHealed = LocalPlayer():GetNWInt("DamageHealed") 
    stats.Extractions = LocalPlayer():GetNWInt("Extractions")
    stats.Quits = LocalPlayer():GetNWInt("Quits")
    stats.FullRaids = LocalPlayer():GetNWInt("FullRaids")

    stats.CurrentKillStreak = LocalPlayer():GetNWInt("CurrentKillStreak") 
    stats.BestKillStreak = LocalPlayer():GetNWInt("BestKillStreak")
    stats.CurrentExtractionStreak = LocalPlayer():GetNWInt("CurrentExtractionStreak")
    stats.BestExtractionStreak = LocalPlayer():GetNWInt("BestExtractionStreak")

    for k, v in SortedPairs(stats) do

        local statEntry = vgui.Create("DPanel", importantStats)
        statEntry:Dock(TOP)
        statEntry:SetSize(0, EFGM.MenuScale(20))
        function statEntry:Paint(w, h)

            surface.SetDrawColor(Color(0, 0, 0, 0))
            surface.DrawRect(0, 0, w, h)

            draw.SimpleTextOutlined(k .. "", "Purista18", 0, 0, MenuAlias.whiteColor, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP, 1, MenuAlias.blackColor)
            draw.SimpleTextOutlined(math.Round(v), "Purista18", w, 0, MenuAlias.whiteColor, TEXT_ALIGN_RIGHT, TEXT_ALIGN_TOP, 1, MenuAlias.blackColor)

        end

    end

end

function Menu.OpenTab.Settings()

    local contents = vgui.Create("DPanel", Menu.MenuFrame.LowerPanel)
    contents:Dock(FILL)
    contents:DockPadding(EFGM.MenuScale(10), EFGM.MenuScale(10), EFGM.MenuScale(10), EFGM.MenuScale(10))
    contents:SetAlpha(0)
    contents.Paint = function(s, w, h)

        surface.SetDrawColor(Color(0, 0, 0, 0))
        surface.DrawRect(0, 0, w, h)

    end

    Menu.MenuFrame.LowerPanel.Contents = contents

    local gameplay = vgui.Create("DScrollPanel", contents)
    gameplay:Dock(LEFT)
    gameplay:SetSize(EFGM.MenuScale(320), 0)
    gameplay.Paint = function(s, w, h)

        surface.SetDrawColor(Color(0, 0, 0, 0))
        surface.DrawRect(0, 0, w, h)

    end

    local gameplayTitle = vgui.Create("DPanel", gameplay)
    gameplayTitle:Dock(TOP)
    gameplayTitle:SetSize(0, EFGM.MenuScale(32))
    function gameplayTitle:Paint(w, h)

        surface.SetDrawColor(Color(0, 0, 0, 0))
        surface.DrawRect(0, 0, w, h)

        draw.SimpleTextOutlined("GAMEPLAY", "PuristaBold32", w / 2, 0, MenuAlias.whiteColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 1, MenuAlias.blackColor)

    end

    local gameplayBar = gameplay:GetVBar()
    gameplayBar:SetHideButtons(true)
    function gameplayBar:Paint(w, h)
        draw.RoundedBox(0, 0, 0, w, h, Color(0, 0, 0, 0))
    end
    function gameplayBar.btnGrip:Paint(w, h)
        draw.RoundedBox(0, EFGM.MenuScale(5), EFGM.MenuScale(8), EFGM.MenuScale(5), h - EFGM.MenuScale(16), Color(0, 0, 0, 0))
    end

    local controls = vgui.Create("DScrollPanel", contents)
    controls:Dock(LEFT)
    controls:SetSize(EFGM.MenuScale(320), 0)
    controls.Paint = function(s, w, h)

        surface.SetDrawColor(Color(0, 0, 0, 0))
        surface.DrawRect(0, 0, w, h)

    end

    local controlsTitle = vgui.Create("DPanel", controls)
    controlsTitle:Dock(TOP)
    controlsTitle:SetSize(0, EFGM.MenuScale(32))
    function controlsTitle:Paint(w, h)

        surface.SetDrawColor(Color(0, 0, 0, 0))
        surface.DrawRect(0, 0, w, h)

        draw.SimpleTextOutlined("CONTROLS", "PuristaBold32", w / 2, 0, MenuAlias.whiteColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 1, MenuAlias.blackColor)

    end

    local controlsBar = controls:GetVBar()
    controlsBar:SetHideButtons(true)
    function controlsBar:Paint(w, h)
        draw.RoundedBox(0, 0, 0, w, h, Color(0, 0, 0, 0))
    end
    function controlsBar.btnGrip:Paint(w, h)
        draw.RoundedBox(0, EFGM.MenuScale(5), EFGM.MenuScale(8), EFGM.MenuScale(5), h - EFGM.MenuScale(16), Color(0, 0, 0, 0))
    end

    local interface = vgui.Create("DScrollPanel", contents)
    interface:Dock(LEFT)
    interface:SetSize(EFGM.MenuScale(320), 0)
    interface.Paint = function(s, w, h)

        surface.SetDrawColor(Color(0, 0, 0, 0))
        surface.DrawRect(0, 0, w, h)

    end

    local interfaceTitle = vgui.Create("DPanel", interface)
    interfaceTitle:Dock(TOP)
    interfaceTitle:SetSize(0, EFGM.MenuScale(32))
    function interfaceTitle:Paint(w, h)

        surface.SetDrawColor(Color(0, 0, 0, 0))
        surface.DrawRect(0, 0, w, h)

        draw.SimpleTextOutlined("INTERFACE", "PuristaBold32", w / 2, 0, MenuAlias.whiteColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 1, MenuAlias.blackColor)

    end

    local interfaceBar = interface:GetVBar()
    interfaceBar:SetHideButtons(true)
    function interfaceBar:Paint(w, h)
        draw.RoundedBox(0, 0, 0, w, h, Color(0, 0, 0, 0))
    end
    function interfaceBar.btnGrip:Paint(w, h)
        draw.RoundedBox(0, EFGM.MenuScale(5), EFGM.MenuScale(8), EFGM.MenuScale(5), h - EFGM.MenuScale(16), Color(0, 0, 0, 0))
    end

    local visuals = vgui.Create("DScrollPanel", contents)
    visuals:Dock(LEFT)
    visuals:SetSize(EFGM.MenuScale(320), 0)
    visuals.Paint = function(s, w, h)

        surface.SetDrawColor(Color(0, 0, 0, 0))
        surface.DrawRect(0, 0, w, h)

    end

    local visualsTitle = vgui.Create("DPanel", visuals)
    visualsTitle:Dock(TOP)
    visualsTitle:SetSize(0, EFGM.MenuScale(32))
    function visualsTitle:Paint(w, h)

        surface.SetDrawColor(Color(0, 0, 0, 0))
        surface.DrawRect(0, 0, w, h)

        draw.SimpleTextOutlined("VISUALS", "PuristaBold32", w / 2, 0, MenuAlias.whiteColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 1, MenuAlias.blackColor)

    end

    local visualsBar = visuals:GetVBar()
    visualsBar:SetHideButtons(true)
    function visualsBar:Paint(w, h)
        draw.RoundedBox(0, 0, 0, w, h, Color(0, 0, 0, 0))
    end
    function visualsBar.btnGrip:Paint(w, h)
        draw.RoundedBox(0, EFGM.MenuScale(5), EFGM.MenuScale(8), EFGM.MenuScale(5), h - EFGM.MenuScale(16), Color(0, 0, 0, 0))
    end

    local account = vgui.Create("DScrollPanel", contents)
    account:Dock(LEFT)
    account:SetSize(EFGM.MenuScale(320), 0)
    account.Paint = function(s, w, h)

        surface.SetDrawColor(Color(0, 0, 0, 0))
        surface.DrawRect(0, 0, w, h)

    end

    local accountTitle = vgui.Create("DPanel", account)
    accountTitle:Dock(TOP)
    accountTitle:SetSize(0, EFGM.MenuScale(32))
    function accountTitle:Paint(w, h)

        surface.SetDrawColor(Color(0, 0, 0, 0))
        surface.DrawRect(0, 0, w, h)

        draw.SimpleTextOutlined("ACCOUNT", "PuristaBold32", w / 2, 0, MenuAlias.whiteColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 1, MenuAlias.blackColor)

    end

    local accountBar = account:GetVBar()
    accountBar:SetHideButtons(true)
    function accountBar:Paint(w, h)
        draw.RoundedBox(0, 0, 0, w, h, Color(0, 0, 0, 0))
    end
    function accountBar.btnGrip:Paint(w, h)
        draw.RoundedBox(0, EFGM.MenuScale(5), EFGM.MenuScale(8), EFGM.MenuScale(5), h - EFGM.MenuScale(16), Color(0, 0, 0, 0))
    end

    local misc = vgui.Create("DScrollPanel", contents)
    misc:Dock(LEFT)
    misc:SetSize(EFGM.MenuScale(260), EFGM.MenuScale(353))
    misc.Paint = function(s, w, h)

        surface.SetDrawColor(Color(0, 0, 0, 0))
        surface.DrawRect(0, 0, w, h)

    end

    local miscTitle = vgui.Create("DPanel", misc)
    miscTitle:Dock(TOP)
    miscTitle:SetSize(0, EFGM.MenuScale(32))
    function miscTitle:Paint(w, h)

        surface.SetDrawColor(Color(0, 0, 0, 0))
        surface.DrawRect(0, 0, w, h)

        draw.SimpleTextOutlined("MISC.", "PuristaBold32", w / 2, 0, MenuAlias.whiteColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 1, MenuAlias.blackColor)

    end

    local miscBar = misc:GetVBar()
    miscBar:SetHideButtons(true)
    function miscBar:Paint(w, h)
        draw.RoundedBox(0, 0, 0, w, h, Color(0, 0, 0, 0))
    end
    function miscBar.btnGrip:Paint(w, h)
        draw.RoundedBox(0, EFGM.MenuScale(5), EFGM.MenuScale(8), EFGM.MenuScale(5), h - EFGM.MenuScale(16), Color(0, 0, 0, 0))
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

        draw.SimpleTextOutlined("Toggle Lean", "Purista18", w / 2, EFGM.MenuScale(5), MenuAlias.whiteColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 1, MenuAlias.blackColor)

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

    local gameMenuPanel = vgui.Create("DPanel", controls)
    gameMenuPanel:Dock(TOP)
    gameMenuPanel:SetSize(0, EFGM.MenuScale(55))
    function gameMenuPanel:Paint(w, h)

        draw.SimpleTextOutlined("Game Menu keybind", "Purista18", w / 2, EFGM.MenuScale(5), MenuAlias.whiteColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 1, MenuAlias.blackColor)

    end

    local gameMenu = vgui.Create("DBinder", gameMenuPanel)
    gameMenu:SetPos(EFGM.MenuScale(110), EFGM.MenuScale(30))
    gameMenu:SetSize(EFGM.MenuScale(100), EFGM.MenuScale(20))
    gameMenu:SetFont("PuristaBold18")
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
    showCompass:SetFont("PuristaBold18")
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
    showRaidInfo:SetFont("PuristaBold18")
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
    leanLeft:SetFont("PuristaBold18")
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
    leanRight:SetFont("PuristaBold18")
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
    freeLook:SetFont("PuristaBold18")
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
    changeSight:SetFont("PuristaBold18")
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
    inspectWeapon:SetFont("PuristaBold18")
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
    dropWeapon:SetFont("PuristaBold18")
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
    teamInvite:SetFont("PuristaBold18")
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
    primaryWeapon:SetFont("PuristaBold18")
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
    primaryWeaponTwo:SetFont("PuristaBold18")
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
    secondaryWeapon:SetFont("PuristaBold18")
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
    meleeWeapon:SetFont("PuristaBold18")
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
    utilityThrowable:SetFont("PuristaBold18")
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
    factionPreference:SetFont("PuristaBold18")
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
    invitePrivacy:SetFont("PuristaBold18")
    invitePrivacy:SetSortItems(false)
    invitePrivacy.OnSelect = function(self, value)
        RunConsoleCommand("efgm_privacy_invites", value - 1)
    end

end

concommand.Add("efgm_gamemenu", function(ply, cmd, args)

    local tab = args[1] -- tab currently does jack

    Menu:Open(tab)

end)