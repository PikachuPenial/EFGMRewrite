
-- handles the shop shit for the client
-- basically keeps track of commands, etc so the cl_menu can focus on menu shit

SHOP = {} -- collection of functions and utilities

SHOP.BuyOrders = {} -- stores item count, name, type
SHOP.SellOrders = {} -- these basically will compress down to a command

-- adding orders

function SHOP:AddBuyOrder(itemType, itemCount, itemName)

    local order = {}
    order.ItemType = itemType
    order.ItemCount = itemCount

    self.BuyOrders[itemName] = order

end

function SHOP:AddSellOrder(itemType, itemCount, itemName)

    local order = {}
    order.ItemType = itemType
    order.ItemCount = itemCount

    self.SellOrders[itemName] = order

end

-- removing orders

function SHOP:RemoveBuyOrder(itemName)

    self.BuyOrders[itemName] = nil

end

function SHOP:RemoveSellOrder(itemName)

    self.SellOrders[itemName] = nil

end

function SHOP:WipeOrders()

    table.Empty( self.BuyOrders )
    table.Empty( self.SellOrders )

end

-- funny order compilation

function SHOP:CompileOrders() -- returns the "+ 1 1 weapon_name - 2 64 ammo" shit to use in a command

    local command = ""

    if !table.IsEmpty(self.BuyOrders) then
        for k, v in pairs(self.BuyOrders) do
        
            command = command .."+ ".. v.ItemType .." ".. v.ItemCount .." ".. k .." "
    
        end
    end

    if !table.IsEmpty(self.SellOrders) then
        for k, v in pairs(self.SellOrders) do
        
            command = command .."- ".. v.ItemType .." ".. v.ItemCount .." ".. k .." "
    
        end
    end

    return command

end