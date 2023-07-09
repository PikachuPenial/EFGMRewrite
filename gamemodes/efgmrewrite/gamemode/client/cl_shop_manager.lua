
-- handles the shop shit for the client
-- basically keeps track of commands, etc so the cl_menu can focus on menu shit

SHOP = {} -- collection of functions and utilities

SHOP.BuyOrders = {} -- stores item count, name, type
SHOP.SellOrders = {} -- these basically will compress down to a command

function SHOP:AddOrder(itemName, itemType, itemCount, isBuyOrder)

    local order = {}
    order.ItemType = itemType
    order.ItemCount = itemCount

    if isBuyOrder == true then
        self.BuyOrders[itemName] = order
    else
        self.SellOrders[itemName] = order
    end

    print("Added or edited order: "..itemName)
    PrintTable(order)

end

function SHOP:RemoveOrder(itemName, isBuyOrder)

    if isBuyOrder == true then
        self.BuyOrders[itemName] = nil
    else
        self.SellOrders[itemName] = nil
    end

end

function SHOP:WipeOrders()

    table.Empty( self.BuyOrders )
    table.Empty( self.SellOrders )

end

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

concommand.Add("efgm_debug_getinventory", function(ply, cmd, args)

    local weps = {}
    local ammo = {}

    local rawWeapons = ply:GetWeapons()
    local rawAmmo = ply:GetAmmo()

    for k, v in pairs(rawWeapons) do

        local wep = v:GetClass()

        local lmao = {}
        lmao[-1] = "Nothing"

        local ammo1 = lmao[ v:GetPrimaryAmmoType() ] or game.GetAmmoName(v:GetPrimaryAmmoType())
        local ammo2 = lmao[ v:GetSecondaryAmmoType() ] or game.GetAmmoName(v:GetSecondaryAmmoType())

        table.insert(weps, wep.." (Primary: ".. ammo1 ..", Secondary: ".. ammo2 ..")")

    end

    for k, v in pairs(rawAmmo) do
        
        ammo[game.GetAmmoName(k)] = v

    end

    print("Weapons:")
    PrintTable(weps)
    print("Ammo:")
    PrintTable(ammo)

end)

concommand.Add("efgm_transaction_shop", function(ply, cmd, args)

    net.Start("RequestTransactionShop", false)
    net.WriteTable(args)
    net.SendToServer()

end)