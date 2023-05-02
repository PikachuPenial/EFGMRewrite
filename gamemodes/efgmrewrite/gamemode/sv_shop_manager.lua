
-- basically just handles transactions and shit
-- eventually there might be deals and shit to encourage rats to go in with underused and extremely shit guns that nobody buys, but im to sleepy for that

function ShopTransaction(ply, buy, sell)

    -- will be like buy and sell mixed into one

    local currentMoney = ply:GetNWInt("PlayerMoney", nil)
    if currentMoney == nil then return end

    local transactionProfit = 0

    local isTransactionValid = true -- isn't valid if player doesnt have a weapon they're trying to buy, or they don't have a weapon they're trying to sell

    for k, v in pairs(buy) do

        local gunInfo = LOOT[v.ItemType][v.ItemName]

        if gunInfo != nil then
            
            transactionProfit = transactionProfit - LOOT.FUNCTIONS.GetCost[v.ItemType](v.ItemName, v.ItemCount)

            if LOOT.FUNCTIONS.PlayerHasItem[v.ItemType](ply, v.ItemName, v.ItemCount) && v.ItemType == 1 then -- if player has the gun
                isTransactionValid = false
            end

        else

            isTransactionValid = false

        end

    end

    for k, v in pairs(sell) do

        local gunInfo = LOOT[v.ItemType][v.ItemName]

        if gunInfo != nil then

            transactionProfit = transactionProfit + (LOOT.FUNCTIONS.GetCost[v.ItemType](v.ItemName, v.ItemCount) * sellMultiplier)

            if !LOOT.FUNCTIONS.PlayerHasItem[v.ItemType](ply, v.ItemName, v.ItemCount) then
                isTransactionValid = false
            end

        else

            isTransactionValid = false

        end

    end

    transactionProfit = math.floor(transactionProfit)

    if !isTransactionValid then print("transaction not valid") return end -- the player has the shit they wanna sell and doesnt have shit they wanna buy
    if currentMoney + transactionProfit < 0 then ply:PrintMessage(HUD_PRINTCENTER, "Transaction failed, you need $".. -transactionProfit - currentMoney .." more!") return end -- if the player has enough money

    if !table.IsEmpty(buy) then
        for k, v in ipairs(buy) do
            LOOT.FUNCTIONS.GiveItem[v.ItemType](ply, v.ItemName, v.ItemCount)
        end
    end
   
    if !table.IsEmpty(sell) then
        for k, v in ipairs(sell) do
            LOOT.FUNCTIONS.TakeItem[v.ItemType](ply, v.ItemName, v.ItemCount)
        end
    end

    ply:SetNWInt("PlayerMoney", currentMoney + transactionProfit)
    ply:PrintMessage(HUD_PRINTCENTER, "Shop transaction complete, it had a profit of $" .. transactionProfit .. ", and you now have $" .. currentMoney + transactionProfit .. ".")

end
concommand.Add("efgm_shop_transaction", function(ply, cmd, args)

    if ply:IsInRaid() then return end

    local sell = {} -- ["ItemName"] and ["ItemType"]
    local slChecks = {}

    local buy = {} -- same
    local byChecks = {}

    -- cmd == -/+, type (number), count, weapon_name
    for k, v in ipairs(args) do
        if v == "+" then

            local tbl = {}
            tbl.ItemType = tonumber( args[k + 1] )
            tbl.ItemCount = tonumber( args[k + 2] )
            tbl.ItemName = args[k + 3]

            if byChecks[tbl.ItemName] == nil then

                if tbl.ItemCount < 1 then return end
                if tbl.ItemCount != 1 && tbl.ItemType == 1 then return end -- if a weapon has a count other than 1 bc you can only hold 1 of each weapon
    
                table.insert(buy, tbl)
                byChecks[tbl.ItemName] = 1

            end

        elseif v == "-" then

            local tbl = {}
            tbl.ItemType = tonumber( args[k + 1] )
            tbl.ItemCount = tonumber( args[k + 2] )
            tbl.ItemName = args[k + 3]

            if slChecks[tbl.ItemName] == nil then

                if tbl.ItemCount < 1 then return end
                if tbl.ItemCount != 1 && tbl.ItemType == 1 then return end -- if a weapon has a count other than 1 bc you can only hold 1 of each weapon
    
                table.insert(sell, tbl)
                slChecks[tbl.ItemName] = 1

            end

        end
    end

    ShopTransaction(ply, buy, sell)

end)