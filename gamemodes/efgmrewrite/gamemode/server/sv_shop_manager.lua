
-- basically just handles transactions and shit
-- eventually there might be deals and shit to encourage rats to go in with underused and extremely shit guns that nobody buys, but im to sleepy for that

util.AddNetworkString("RequestTransactionShop")

function ShopTransaction(ply, buy, sell)

    -- will be like buy and sell mixed into one

    local currentMoney = ply:GetNWInt("PlayerMoney", nil)
    if currentMoney == nil then return end

    local transactionProfit = 0

    local isTransactionValid = true -- isn't valid if player doesnt have a weapon they're trying to buy, or they don't have a weapon they're trying to sell

    for k, v in pairs(buy.contents) do

        local gunInfo = ITEMS[k]

        if gunInfo != nil then
            
            transactionProfit = transactionProfit - GetCost[v.type](k, v.count)

            if PlayerHasItem[v.type](ply, k, v.count) && v.type == 1 then -- if player has the gun
                isTransactionValid = false
            end

        else

            isTransactionValid = false

        end

    end

    for k, v in pairs(sell.contents) do

        local gunInfo = ITEMS[k]

        if gunInfo != nil then

            transactionProfit = transactionProfit + (GetCost[v.type](k, v.count) * sellMultiplier)

            if !PlayerHasItem[v.type](ply, k, v.count) then
                isTransactionValid = false
            end

        else

            isTransactionValid = false

        end

    end

    transactionProfit = math.floor(transactionProfit)

    if !isTransactionValid then print("transaction not valid") return end -- the player has the shit they wanna sell and doesnt have shit they wanna buy
    if currentMoney + transactionProfit < 0 then ply:PrintMessage(HUD_PRINTCENTER, "Transaction failed, you need $".. -transactionProfit - currentMoney .." more!") return end -- if the player has enough money

    if !table.IsEmpty(buy.contents) then
        for k, v in pairs(buy.contents) do
            GiveItem[v.type](ply, k, v.count)
        end
    end
   
    if !table.IsEmpty(sell.contents) then
        for k, v in pairs(sell.contents) do
            TakeItem[v.type](ply, k, v.count)
        end
    end

    ply:SetNWInt("PlayerMoney", currentMoney + transactionProfit)
    ply:PrintMessage(HUD_PRINTCENTER, "Shop transaction complete, it had a profit of $" .. transactionProfit .. ", and you now have $" .. currentMoney + transactionProfit .. ".")

end

net.Receive("RequestTransactionShop", function(len, ply)

    if !ply:CompareStatus(0) then return end
    
    local args = net.ReadTable()

    if args[1] == nil then
        
        ply:PrintMessage(HUD_PRINTCONSOLE, "Format: efgm_transaction_shop +/- itemType(integer) itemCount(integer) itemName(integer)")

        return

    end

    local buy, sell = INV(), INV()

    -- cmd == -/+, type (number), count, weapon_name
    for k, v in ipairs(args) do
        if v == "+" then

            local type = tonumber( args[k + 1] )
            local count = tonumber( args[k + 2] )
            local name = args[k + 3]

            if buy.contents[name] == nil then

                if count < 1 then return end
                if count != 1 && type == 1 then return end
    
                buy:AddItem(name, type, count)

            end

        elseif v == "-" then

            local type = tonumber( args[k + 1] )
            local count = tonumber( args[k + 2] )
            local name = args[k + 3]

            if sell.contents[name] == nil then

                if count < 1 then return end
                if count != 1 && type == 1 then return end
    
                sell:AddItem(name, type, count)

            end

        end
    end

    ShopTransaction(ply, buy, sell)

end)