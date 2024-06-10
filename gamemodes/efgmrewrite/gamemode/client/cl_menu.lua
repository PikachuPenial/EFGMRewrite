
-- establishes global menu object, this will have tabs and will handle shit like shop, player progression, in-raid shit, other stuff
-- this is not a panel, but a collection of panels and supporting functions
Menu = {}

Menu.MusicList = {"sound/music/menu_01.mp4", "sound/music/menu_02.mp4", "sound/music/menu_03.mp4", "sound/music/menu_04.mp4"}

local menuBind = GetConVar("efgm_bind_menu"):GetInt()
cvars.AddChangeCallback("efgm_bind_menu", function(convar_name, value_old, value_new)
    menuBind = tonumber(value_new)
end)

local conditions = {}

-- called non-globally to initialize the menu, that way it can only be initialized once by Menu:Open()
-- also openTab is the name of the tab it should open to
function Menu:Initialize(openTab)

    local menuFrame = vgui.Create("DFrame")
    menuFrame:SetSize(EFGM.ScreenScale(1500), EFGM.ScreenScale(800))
    menuFrame:Center()
    menuFrame:SetTitle("")
    menuFrame:SetVisible(true)
    menuFrame:SetDraggable(false)
    menuFrame:SetDeleteOnClose(false)
    menuFrame:ShowCloseButton(false)
    menuFrame:MakePopup()
    menuFrame:SetAlpha(0)
    menuFrame:SetBackgroundBlur(true)

    menuFrame:AlphaTo(255, 0.2, 0, function() end)

    self.StartTime = SysTime()

    function menuFrame:Paint(w, h)

        -- calling this function twice is the only way to make the blur darker lmao
        Derma_DrawBackgroundBlur(self, self.StartTime)
        Derma_DrawBackgroundBlur(self, self.StartTime)

        surface.SetDrawColor(0, 0, 0, 25)
        surface.DrawRect(0, 0, w, h)

        draw.SimpleTextOutlined("Escape From Garry's Mod", "Purista32", EFGM.ScreenScale(5), EFGM.ScreenScale(-5), MenuAlias.whiteColor, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP, 1, MenuAlias.blackColor)

    end

    -- close menu with the game menu keybind
    function menuFrame:OnKeyCodeReleased(key)

        if key == menuBind then

            menuFrame:SetKeyboardInputEnabled(false)
            menuFrame:SetMouseInputEnabled(false)

            menuFrame:AlphaTo(0, 0.1, 0, function()
                menuFrame:Close()
            end)

        end

    end

    hook.Add("Think", "MenuController", function()

        if !gui.IsGameUIVisible() then menuFrame:Show() else menuFrame:Hide() end

    end)

    function menuFrame:OnClose()

        Menu.IsOpen = false
        hook.Remove("Think", "MenuController")

    end

    self.Player = LocalPlayer()
    self.MenuFrame = menuFrame

    local tabParentPanel = vgui.Create("DPanel", self.MenuFrame)
    tabParentPanel:Dock(TOP)
    tabParentPanel:SetSize(0, EFGM.ScreenScale(25))

    function tabParentPanel:Paint(w, h)

        surface.SetDrawColor(0, 0, 0, 0)
        surface.DrawRect(0, 0, w, h)

    end

    self.MenuFrame.TabParentPanel = tabParentPanel

    local lowerPanel = vgui.Create("DPanel", self.MenuFrame)
    lowerPanel:Dock(FILL)
    lowerPanel:DockMargin(0, EFGM.ScreenScale(5), 0, 0)

    function lowerPanel:Paint(w, h)

        surface.SetDrawColor(0, 0, 0, 0)
        surface.DrawRect(0, 0, w, h)

    end

    self.MenuFrame.LowerPanel = lowerPanel

    local contents = vgui.Create("DPanel", Menu.MenuFrame.LowerPanel)
    contents:Dock(FILL)
    contents.Paint = nil

    Menu.MenuFrame.LowerPanel.Contents = contents

    -- for text size calculations
    surface.SetFont("PuristaBold18")

    local statsTab = vgui.Create("DButton", self.MenuFrame.TabParentPanel)
    statsTab:Dock(LEFT)
    statsTab:SetFont("PuristaBold18")
    statsTab:SetSize(surface.GetTextSize(tostring(LocalPlayer():Name())) + EFGM.ScreenScale(50), 0)
    statsTab:SetText(LocalPlayer():Name())

    function statsTab:DoClick()
        Menu.MenuFrame.LowerPanel.Contents:Remove()
        Menu.OpenTab.Stats()
    end

    local matchTab = vgui.Create("DButton", self.MenuFrame.TabParentPanel)
    matchTab:Dock(LEFT)
    matchTab:SetFont("PuristaBold18")
    matchTab:SetSize(surface.GetTextSize("Match") + EFGM.ScreenScale(50), 0)
    matchTab:SetText("Match")

    function matchTab:DoClick()
        if !Menu.Player:CompareStatus(0) then
            surface.PlaySound("common/wpn_denyselect.wav")
            return
        end
        Menu.MenuFrame.LowerPanel.Contents:Remove()
        Menu.OpenTab.Match()
    end

    local inventoryTab = vgui.Create("DButton", self.MenuFrame.TabParentPanel)
    inventoryTab:Dock(LEFT)
    inventoryTab:SetFont("PuristaBold18")
    inventoryTab:SetSize(surface.GetTextSize("Inventory") + EFGM.ScreenScale(50), 0)
    inventoryTab:SetText("Inventory")

    function inventoryTab:DoClick()
        -- placeholder until inventory functions chop chop portapotty
        surface.PlaySound("common/wpn_denyselect.wav")
        return

        -- Menu.MenuFrame.LowerPanel.Contents:Remove()
        -- Menu.OpenTab.Inventory()
    end

    local intelTab = vgui.Create("DButton", self.MenuFrame.TabParentPanel)
    intelTab:Dock(LEFT)
    intelTab:SetFont("PuristaBold18")
    intelTab:SetSize(surface.GetTextSize("Intel") + EFGM.ScreenScale(50), 0)
    intelTab:SetText("Intel")

    function intelTab:DoClick()
        Menu.MenuFrame.LowerPanel.Contents:Remove()
        Menu.OpenTab.Intel()
    end

    -- local contractsTab = vgui.Create("DButton", self.MenuFrame.TabParentPanel)
    -- contractsTab:Dock(LEFT)
    -- contractsTab:SetFont("PuristaBold18")
    -- contractsTab:SetSize(surface.GetTextSize("Contracts") + EFGM.ScreenScale(50), 0)
    -- contractsTab:SetText("Contracts")

    -- local unlocksTab = vgui.Create("DButton", self.MenuFrame.TabParentPanel)
    -- unlocksTab:Dock(LEFT)
    -- unlocksTab:SetFont("PuristaBold18")
    -- unlocksTab:SetSize(surface.GetTextSize("Unlocks") + EFGM.ScreenScale(50), 0)
    -- unlocksTab:SetText("Unlocks")

end

-- called to either initialize or open the menu
function Menu:Open(openTab)

    if self.MenuFrame != nil then

        self.MenuFrame:Remove()

    end

    self:Initialize( openTab )

end

Menu.OpenTab = {}

function Menu.OpenTab.Inventory()

    local contents = vgui.Create("DPanel", Menu.MenuFrame.LowerPanel)
    contents:Dock(FILL)
    contents.Paint = nil

    Menu.MenuFrame.LowerPanel.Contents = contents

end

function Menu.OpenTab.Intel()

    local contents = vgui.Create("DPanel", Menu.MenuFrame.LowerPanel)
    contents:Dock(FILL)
    contents.Paint = nil

    Menu.MenuFrame.LowerPanel.Contents = contents

    local mainEntryList = vgui.Create("DCategoryList", contents)
    mainEntryList:Dock(LEFT)
    mainEntryList:SetSize(EFGM.ScreenScale(180), 0)

    local subEntryList = vgui.Create("DIconLayout", contents)
    subEntryList:Dock(LEFT)
    subEntryList:SetSize(EFGM.ScreenScale(180), 0)

    local entryPanel = vgui.Create("DPanel", contents)
    entryPanel:Dock(FILL)
    function entryPanel:Paint(w, h)
        surface.SetDrawColor(50, 50, 50, 0)
        surface.DrawRect(0, 0, w, h)
    end

    local entryStats = vgui.Create("DPanel", entryPanel)
    entryStats:Dock(TOP)
    entryStats:SetSize(0, EFGM.ScreenScale(40))
    entryStats.Paint = nil

    local entryTextDisplay = vgui.Create("DPanel", entryPanel)
    entryTextDisplay:Dock(FILL)
    entryTextDisplay.Paint = nil

    local function DrawEntry(entryName, entryText, stats)

        if stats != nil then

            entryStats:SetSize(0, #stats * EFGM.ScreenScale(40))

            function entryStats:Paint(w, h)

                for k, v in ipairs(stats) do

                    surface.SetDrawColor(190, 190, 190)
                    if k % 2 == 1 then 
                        surface.SetDrawColor(210, 210, 210)
                    end

                    surface.DrawRect(0, (k - 1) * EFGM.ScreenScale(40), w, EFGM.ScreenScale(40))

                    local text = markup.Parse( "<font=PuristaBold32><color=0,0,0>\n\n" .. v .. "</color></font>", w - EFGM.ScreenScale(40) )
                    text:Draw(EFGM.ScreenScale(20), (k - 1) * EFGM.ScreenScale(40) + EFGM.ScreenScale(5))

                end

            end

        else

            entryStats:SetSize(0, 0)
            entryStats.Paint = nil
            
        end

        function entryTextDisplay:Paint(w, h)

            -- chatgpt hallucinated an entire fucking function to get this shit to wrap, apologised profusely when called out on its artificial bs, but then told me about markup thanks chatgpt

            local text = markup.Parse( "<font=PuristaBold64><color=50,212,50>" .. entryName .. "</color></font><font=Purista32><color=255,255,255>\n" .. entryText .. "</color></font>", w - EFGM.ScreenScale(40) )
            text:Draw(EFGM.ScreenScale(20), EFGM.ScreenScale(20))

        end

    end

    -- Entries

    for k1, v1 in pairs(Intel) do

        local category = mainEntryList:Add(k1)
        category:DoExpansion(false)

        for k2, v2 in pairs(v1) do

            print(v2.Name)

            local entry = category:Add(v2.Name)
            function entry:DoClick()
            
                print("Clicked " .. v2.Name)
                subEntryList:Clear()
                DrawEntry(v2.Name, v2.Description, v2.Stats)

                for k3, v3 in ipairs(v2.Children) do -- jesus christ
                    
                    local subEntry = subEntryList:Add("DButton")
                    subEntry:SetSize(EFGM.ScreenScale(180), EFGM.ScreenScale(20))
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
    contents.Paint = nil

    Menu.MenuFrame.LowerPanel.Contents = contents

    local pmcSP = vgui.Create("DScrollPanel", contents)
    pmcSP:Dock(LEFT)
    pmcSP:SetSize(EFGM.ScreenScale(400), 0)
    pmcSP.Paint = function(s, w, h)

        surface.SetDrawColor(Color(0, 0, 0, 0))
        surface.DrawRect(0, 0, w, h)

    end

    local pmcSPBar = pmcSP:GetVBar()
    pmcSPBar:SetHideButtons(true)
    function pmcSPBar:Paint(w, h)
        draw.RoundedBox(0, 0, 0, w, h, Color(0, 0, 0, 0))
    end
    function pmcSPBar.btnGrip:Paint(w, h)
        draw.RoundedBox(0, EFGM.ScreenScale(5), EFGM.ScreenScale(8), EFGM.ScreenScale(5), h - EFGM.ScreenScale(16), Color(0, 0, 0, 0))
    end

    pmcList = vgui.Create("DListLayout", pmcSP)
    pmcList:SetSize(pmcSP:GetWide(), 0)
    pmcList:SetPos(0, 0)

    local onlinePlayers = player.GetAll()

    for k, v in pairs(onlinePlayers) do
        local name = v:GetName()
        local ping = v:Ping()
        local kills = v:Frags()
        local deaths = v:Deaths()

        local pmcPanel = vgui.Create("DPanel", pmcList)
        pmcPanel:SetSize(pmcList:GetWide(), EFGM.ScreenScale(50))
        pmcPanel:SetPos(0, 0)
        pmcPanel.Paint = function(w, h)
            if !IsValid(v) then return end
            draw.SimpleTextOutlined(name .. "         " .. ping  .. "ms", "Purista18", EFGM.ScreenScale(50), EFGM.ScreenScale(5), MenuAlias.whiteColor, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP, 1, MenuAlias.blackColor)
            draw.SimpleTextOutlined(kills, "Purista18", EFGM.ScreenScale(50), EFGM.ScreenScale(25), Color(0, 255, 0), TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP, 1, MenuAlias.blackColor)
            draw.SimpleTextOutlined(deaths, "Purista18", EFGM.ScreenScale(85), EFGM.ScreenScale(25), Color(255, 0, 0), TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP, 1, MenuAlias.blackColor)
        end

        local pmcPFP = vgui.Create("AvatarImage", pmcPanel)
        pmcPFP:SetPos(EFGM.ScreenScale(5), EFGM.ScreenScale(5))
        pmcPFP:SetSize(EFGM.ScreenScale(40), EFGM.ScreenScale(40))
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

end

function Menu.OpenTab.Shop()

    local contents = vgui.Create("DPanel", Menu.MenuFrame.LowerPanel)
    contents:Dock(FILL)
    contents.Paint = function(s, w, h)

        surface.SetDrawColor(MenuAlias.secondaryColor)
        surface.DrawRect(0, 0, w, h)

    end

    Menu.MenuFrame.LowerPanel.Contents = contents

    local sellerInventoryPanel, buyInventoryPanel, playerInventoryPanel, sellInventoryPanel = {}, {}, {}, {}

    -- { SELLER (Inventory on right)

        local sellerBackground = vgui.Create("DPanel", contents)
        sellerBackground:Dock(LEFT)
        sellerBackground:SetSize(EFGM.ScreenScale(650), 0)
        sellerBackground:DockPadding(unpack(MenuAlias.margins))
        sellerBackground.Paint = function(s, w, h)

            surface.SetDrawColor(MenuAlias.primaryColor)
            surface.DrawRect(0, 0, w, h)

        end

        local sellerInventoryScroller = vgui.Create("DScrollPanel", sellerBackground)
        sellerInventoryScroller:Dock(BOTTOM)
        sellerInventoryScroller:SetSize(0, EFGM.ScreenScale(450))
        sellerInventoryScroller.Paint = nil

        local buyScroller = vgui.Create("DScrollPanel", sellerBackground)
        buyScroller:Dock(TOP)
        buyScroller:SetSize(0, EFGM.ScreenScale(200))
        buyScroller.Paint = nil

    -- }

    -- { PLAYER (Inventory on left)

        local playerBackground = vgui.Create("DPanel", contents)
        playerBackground:Dock(RIGHT)
        playerBackground:SetSize(EFGM.ScreenScale(650), 0)
        playerBackground:DockPadding(unpack(MenuAlias.margins))
        playerBackground.Paint = function(s, w, h)

            surface.SetDrawColor(MenuAlias.primaryColor)
            surface.DrawRect(0, 0, w, h)

        end

        local playerInventoryScroller = vgui.Create("DScrollPanel", playerBackground)
        playerInventoryScroller:Dock(BOTTOM)
        playerInventoryScroller:SetSize(0, EFGM.ScreenScale(450))
        playerInventoryScroller.Paint = nil

        local sellScroller = vgui.Create("DScrollPanel", playerBackground)
        sellScroller:Dock(TOP)
        sellScroller:SetSize(0, EFGM.ScreenScale(200))
        sellScroller.Paint = nil

    -- }

    -- { MIDDLE ROW

        local purchaseInfoPanel = vgui.Create("DPanel", contents)
        purchaseInfoPanel:Dock(TOP)
        purchaseInfoPanel:SetSize(0, EFGM.ScreenScale(200))
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
        iconPanel:SetSize(EFGM.ScreenScale(120), EFGM.ScreenScale(120))

        function iconPanel:Paint(w, h)

            surface.SetDrawColor(MenuAlias.secondaryColor)
            surface.DrawRect(EFGM.ScreenScale(5), EFGM.ScreenScale(5), w, h)

            draw.DrawText(displayName, "DermaDefaultBold", w / 2, 7, MenuAlias.blackColor, TEXT_ALIGN_CENTER)
            draw.DrawText(countNames[count] or count, "DermaDefaultBold", w / 2, h - 7, MenuAlias.blackColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_BOTTOM)

        end

        iconPanel.spawnButton = vgui.Create("SpawnIcon", iconPanel)
        iconPanel.spawnButton:SetSize(EFGM.ScreenScale(80), EFGM.ScreenScale(80))
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
    contents:DockPadding(EFGM.ScreenScale(10), EFGM.ScreenScale(10), EFGM.ScreenScale(10), EFGM.ScreenScale(10))
    contents.Paint = function(s, w, h)

        surface.SetDrawColor(Color(0, 0, 0, 0))
        surface.DrawRect(0, 0, w, h)

    end

    Menu.MenuFrame.LowerPanel.Contents = contents

    local importantStatsSP = vgui.Create("DScrollPanel", contents)
    importantStatsSP:Dock(LEFT)
    importantStatsSP:SetSize(EFGM.ScreenScale(400), 0)
    importantStatsSP.Paint = function(s, w, h)

        surface.SetDrawColor(Color(0, 0, 0, 0))
        surface.DrawRect(0, 0, w, h)

    end

    local importantStats = vgui.Create("DPanel", importantStatsSP)
    importantStats:Dock(TOP)
    importantStats:SetSize(0, EFGM.ScreenScale(500))
    importantStats.Paint = function(s, w, h)

        surface.SetDrawColor(Color(0, 0, 0, 0))
        surface.DrawRect(0, 0, w, h)

    end

    local playerInfo = vgui.Create("DPanel", contents)
    playerInfo:Dock(TOP)
    playerInfo:SetSize(0, EFGM.ScreenScale(300))
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

	stats.Kills = LocalPlayer():GetNWInt("Kills")
	stats.Deaths = LocalPlayer():GetNWInt("Deaths")
	stats.DamageGiven = LocalPlayer():GetNWInt("DamageGiven")
	stats.DamageRecieved = LocalPlayer():GetNWInt("DamageRecieved")
	stats.DamageHealed = LocalPlayer():GetNWInt("DamageHealed")

	stats.Extractions = LocalPlayer():GetNWInt("Extractions")
	stats.Quits = LocalPlayer():GetNWInt("Quits")
	stats.FullRaids = LocalPlayer():GetNWInt("FullRaids")

    local height = 0

    for k, v in pairs(stats) do
        
        local statEntry = vgui.Create("DPanel", importantStats)
        statEntry:Dock(TOP)
        statEntry:SetSize(0, EFGM.ScreenScale(20))
        function statEntry:Paint(w, h)

            surface.SetDrawColor(Color(0, 0, 0, 0))
            surface.DrawRect(0, 0, w, h)

            draw.SimpleTextOutlined(k .. " = " .. v, "Purista18", 0, 0, MenuAlias.whiteColor, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP, 1, MenuAlias.blackColor)

        end

        height = height + 20

    end

    local cw, ch = importantStats:GetContentSize()
    importantStatsSP:GetCanvas():SetSize( cw, height )

end

concommand.Add("efgm_gamemenu", function(ply, cmd, args)

    local tab = args[1] -- tab currently does jack

    Menu:Open(tab)

end)