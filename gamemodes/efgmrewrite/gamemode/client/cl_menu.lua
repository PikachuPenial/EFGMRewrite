
-- establishes global menu object, this will have tabs and will handle shit like shop, player progression, in-raid shit, other stuff
-- this is not a panel, but a collection of panels and supporting functions
Menu = {}

Menu.MusicList = {"sound/music/menu_01.mp4", "sound/music/menu_02.mp4", "sound/music/menu_03.mp4", "sound/music/menu_04.mp4"}

local conditions = {}

-- called non-globally to initialize the menu, that way it can only be initialized once by Menu:Open()
-- also openTab is the name of the tab it should open to
function Menu:Initialize( openTab )

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

    local contents = vgui.Create("DPanel", Menu.MenuFrame.LowerPanel)
    contents:Dock(FILL)
    contents.Paint = nil

    Menu.MenuFrame.LowerPanel.Contents = contents

    local statsTab = vgui.Create("DButton", self.MenuFrame.TabParentPanel)
    statsTab:Dock(LEFT)
    statsTab:SetSize(180, 0)
    statsTab:SetText(LocalPlayer():Name())

    function statsTab:DoClick()
        Menu.MenuFrame.LowerPanel.Contents:Remove()
        Menu.OpenTab.Stats()
    end

    local intelTab = vgui.Create("DButton", self.MenuFrame.TabParentPanel)
    intelTab:Dock(LEFT)
    intelTab:SetSize(90, 0)
    intelTab:SetText("Intel")

    function intelTab:DoClick()
        Menu.MenuFrame.LowerPanel.Contents:Remove()
        Menu.OpenTab.Intel()
    end

    local inventoryTab = vgui.Create("DButton", self.MenuFrame.TabParentPanel)
    inventoryTab:Dock(LEFT)
    inventoryTab:SetSize(90, 0)
    inventoryTab:SetText("Inventory")
    
    local contractsTab = vgui.Create("DButton", self.MenuFrame.TabParentPanel)
    contractsTab:Dock(LEFT)
    contractsTab:SetSize(90, 0)
    contractsTab:SetText("Contracts")
    
    local unlocksTab = vgui.Create("DButton", self.MenuFrame.TabParentPanel)
    unlocksTab:Dock(LEFT)
    unlocksTab:SetSize(90, 0)
    unlocksTab:SetText("Unlocks")

end

-- called to either initialize or open the menu
function Menu:Open( openTab )

    if self.MenuFrame != nil then 

        self.MenuFrame:Remove()

    end

    self:Initialize( openTab )

end

Menu.OpenTab = {}

function Menu.OpenTab.Intel()

    local contents = vgui.Create("DPanel", Menu.MenuFrame.LowerPanel)
    contents:Dock(FILL)
    contents.Paint = nil

    Menu.MenuFrame.LowerPanel.Contents = contents

    local mainEntryList = vgui.Create("DCategoryList", contents)
    mainEntryList:Dock(LEFT)
    mainEntryList:SetSize(180, 0)

    local subEntryList = vgui.Create("DIconLayout", contents)
    subEntryList:Dock(LEFT)
    subEntryList:SetSize(180, 0)

    local entryPanel = vgui.Create("DPanel", contents)
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

    local function DrawEntry(entryName, entryText, stats)

        if stats != nil then

            entryStats:SetSize(0, #stats * 40)

            function entryStats:Paint(w, h)
                
                for k, v in ipairs(stats) do

                    surface.SetDrawColor(190, 190, 190)
                    if k % 2 == 1 then 
                        surface.SetDrawColor(210, 210, 210)
                    end
                    
                    surface.DrawRect(0, (k - 1) * 40, w, 40)

                    local text = markup.Parse( "<font=DermaLarge><color=0,0,0>\n\n" .. v .. "</color></font>", w - 40 )
                    text:Draw(20, (k - 1) * 40 + 5)

                end

            end

        else

            entryStats:SetSize(0, 0)
            entryStats.Paint = nil
            
        end

        function entryTextDisplay:Paint(w, h)

            -- chatgpt hallucinated an entire fucking function to get this shit to wrap, apologised profusely when called out on its artificial bs, but then told me about markup thanks chatgpt

            local text = markup.Parse( "<font=DermaLarge><color=50,212,50>" .. entryName .. "</color></font><font=DermaLarge><color=255,255,255>\n\n" .. entryText .. "</color></font>", w - 40 )
            text:Draw(20, 20)

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
                    subEntry:SetSize(180, 20)
                    subEntry:SetText(v3.Name)
                    function subEntry:DoClick()

                        DrawEntry(v3.Name, v3.Description, v3.Stats)

                    end

                end

            end

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
        sellerBackground:SetSize(650, 0)
        sellerBackground:DockPadding(unpack(MenuAlias.margins))
        sellerBackground.Paint = function(s, w, h)

            surface.SetDrawColor(MenuAlias.primaryColor)
            surface.DrawRect(0, 0, w, h)

        end

        local sellerInventoryScroller = vgui.Create("DScrollPanel", sellerBackground)
        sellerInventoryScroller:Dock(BOTTOM)
        sellerInventoryScroller:SetSize(0, 450)
        sellerInventoryScroller.Paint = nil

        local buyScroller = vgui.Create("DScrollPanel", sellerBackground)
        buyScroller:Dock(TOP)
        buyScroller:SetSize(0, 200)
        buyScroller.Paint = nil

    -- }

    -- { PLAYER (Inventory on left)

        local playerBackground = vgui.Create("DPanel", contents)
        playerBackground:Dock(RIGHT)
        playerBackground:SetSize(650, 0)
        playerBackground:DockPadding(unpack(MenuAlias.margins))
        playerBackground.Paint = function(s, w, h)

            surface.SetDrawColor(MenuAlias.primaryColor)
            surface.DrawRect(0, 0, w, h)

        end

        local playerInventoryScroller = vgui.Create("DScrollPanel", playerBackground)
        playerInventoryScroller:Dock(BOTTOM)
        playerInventoryScroller:SetSize(0, 450)
        playerInventoryScroller.Paint = nil

        local sellScroller = vgui.Create("DScrollPanel", playerBackground)
        sellScroller:Dock(TOP)
        sellScroller:SetSize(0, 200)
        sellScroller.Paint = nil

    -- }

    -- { MIDDLE ROW

        local purchaseInfoPanel = vgui.Create("DPanel", contents)
        purchaseInfoPanel:Dock(TOP)
        purchaseInfoPanel:SetSize(0, 200)
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
        iconPanel:SetSize(120, 120)

        function iconPanel:Paint(w, h)

            surface.SetDrawColor(MenuAlias.secondaryColor)
            surface.DrawRect(5, 5, w, h)

            draw.SimpleText(displayName, "DermaDefaultBold", w / 2, 7, MenuAlias.blackColor, TEXT_ALIGN_CENTER)
            draw.SimpleText(countNames[count] or count, "DermaDefaultBold", w / 2, h - 7, MenuAlias.blackColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_BOTTOM)

        end

        iconPanel.spawnButton = vgui.Create("SpawnIcon", iconPanel)
        iconPanel.spawnButton:SetSize(80, 80)
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
    contents:DockPadding(10, 10, 10, 10)
    contents.Paint = function(s, w, h)

        surface.SetDrawColor(MenuAlias.secondaryColor)
        surface.DrawRect(0, 0, w, h)

    end

    Menu.MenuFrame.LowerPanel.Contents = contents

    local importantStatsSP = vgui.Create("DScrollPanel", contents)
    importantStatsSP:Dock(LEFT)
    importantStatsSP:SetSize(400, 0)

    local importantStats = vgui.Create("DPanel", importantStatsSP)
    importantStats:Dock(TOP)
    importantStats:SetSize(0, 500)

    local playerInfo = vgui.Create("DPanel", contents)
    playerInfo:Dock(TOP)
    playerInfo:SetSize(0, 300)

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
        statEntry:SetSize(0, 30)
        function statEntry:Paint(w, h)

            draw.SimpleText(k.." = "..v, "DermaDefault", 15, 15, MenuAlias.blackColor, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)

        end

        height = height + 30

        print(k)

    end

    local cw, ch = importantStats:GetContentSize()
    importantStatsSP:GetCanvas():SetSize( cw, height )
    
end

-- shitty showspare2 offbrand because i really don't want to use the net library yet (todo: remove bc concommands do this better)
hook.Add("Think", "MySpare2Function", function()
    if input.IsKeyDown(KEY_F4) then

        -- print("showing spare 1")
        
        Menu:Open("Intel")

    end
end)

concommand.Add("efgm_gamemenu", function(ply, cmd, args)
    
    local tab = args[1] -- tab currently does jack

    Menu:Open(tab)

end)

-- menu shit for later
--[[ {

    local countNames = {

        [-1] = "A lot"

    }

    local function drawInventoryIcon(item, type, count, invPanel)
    
        local icon = invPanel:Add("SpawnIcon")
        icon:SetSize(75, 75)

        local displayName, model, category, price = GetShopIconInfo[type](item)

        icon:SetModel(model)
        icon:SetTooltip(displayName .." (".. revCat[category] ..")\n$"..price)

        function icon:Paint(w, h)

            surface.SetDrawColor(MenuAlias.secondaryColor)
            surface.DrawRect(5, 5, w, h)
        
            draw.SimpleText(displayName, "DermaDefaultBold", w / 2, 7, MenuAlias.blackColor, TEXT_ALIGN_CENTER)
            draw.SimpleText(countNames[count] or count, "DermaDefaultBold", w / 2, h - 7, MenuAlias.blackColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_BOTTOM)

        end

        return icon
    
    end

    function drawInventories()

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

        for k, v in pairs(playerInventory) do
            
            local iconP, iconT = {} -- shitty solution but idc (p meaning primary, t meaning transfer)

            if v.transferCount == 0 then -- if not transferring

                iconP = drawInventoryIcon(k, v.type, v.count, playerInventoryPanel)

                function iconP:DoClick()
    
                    transferItem(k, v.type, v.count, playerInventory, false)
                    redrawInventories()
    
                end
            
            elseif v.transferCount == v.count then -- if transferring everything

                -- print(k.." is transferring!")

                iconT = drawInventoryIcon(k, v.type, v.transferCount, sellInventoryPanel)

                function iconT:DoClick()
    
                    transferItem(k, v.type, 0, playerInventory, false)
                    redrawInventories()
    
                end
            
            else -- if partial transfer

                iconT = drawInventoryIcon(k, v.type, v.transferCount, sellInventoryPanel)

                function iconT:DoClick()
    
                    transferItem(k, v.type, 0, playerInventory, false)
                    redrawInventories()
    
                end

                iconP = drawInventoryIcon(k, v.type, v.count - v.transferCount, playerInventoryPanel)

                function iconP:DoClick()
    
                    transferItem(k, v.type, v.count, playerInventory, false)
                    redrawInventories()
    
                end
                
            end

        end

        for k, v in pairs(sellerInventory) do
            
            local iconP, iconT = {} -- shitty solution but idc (p meaning primary, t meaning transfer)

            if v.transferCount == 0 then -- if not transferring

                iconP = drawInventoryIcon(k, v.type, v.count, sellerInventoryPanel)

                function iconP:DoClick()
    
                    transferItem(k, v.type, 1, sellerInventory, false)
                    redrawInventories()
    
                end
            
            elseif v.transferCount == v.count then -- if transferring everything

                -- print(k.." is transferring!")

                iconT = drawInventoryIcon(k, v.type, v.transferCount, buyInventoryPanel)

                function iconT:DoClick()
    
                    transferItem(k, v.type, 0, sellerInventory, false)
                    redrawInventories()
    
                end
            
            else -- if partial transfer

                iconT = drawInventoryIcon(k, v.type, v.transferCount, buyInventoryPanel)

                function iconT:DoClick()
    
                    transferItem(k, v.type, 0, sellerInventory, false)
                    redrawInventories()
    
                end

                iconP = drawInventoryIcon(k, v.type, v.count - v.transferCount, sellerInventoryPanel)

                function iconP:DoClick()
    
                    transferItem(k, v.type, 1, sellerInventory, false)
                    redrawInventories()
    
                end
                
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

    function redrawInventories()

        sellerInventoryPanel:Remove()
        playerInventoryPanel:Remove()

        buyInventoryPanel:Remove()
        sellInventoryPanel:Remove()

        drawInventories()

    end

} ]]