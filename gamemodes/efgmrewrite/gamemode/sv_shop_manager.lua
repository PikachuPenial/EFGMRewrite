
-- basically just handles transactions and shit
-- eventually there might be deals and shit to encourage rats to go in with underused and extremely shit guns that nobody buys, but im to sleepy for that

function ShopTransaction(ply, buy, sell)

    -- will be like buy and sell mixed into one

    local currentMoney = ply:GetNWInt("PlayerMoney", nil)
    if currentMoney == nil then return end
    local transactionProfit = 0

    local isTransactionValid = true -- isn't valid if player doesnt have a weapon they're trying to buy, or they don't have a weapon they're trying to sell

    for k, v in pairs(buy) do

        local gunInfo = LOOT[1][v]

        if gunInfo != nil then
            
            if ply:HasWeapon(v) then isTransactionValid = false end
            transactionProfit = transactionProfit - gunInfo[2]

        end

    end

    for k, v in pairs(sell) do

        local gunInfo = LOOT[1][v]

        if gunInfo != nil then

            if !ply:HasWeapon(v) then isTransactionValid = false end
            transactionProfit = transactionProfit + gunInfo[2]

        end
        
    end

    if !isTransactionValid then print("transaction not valid") return end -- the player has the shit they wanna sell and doesnt have shit they wanna buy
    if currentMoney + transactionProfit < 0 then ply:PrintMessage(HUD_PRINTCENTER, "Transaction failed, you need $".. -transactionProfit - currentMoney .." more!") return end -- if the player has enough money

    if !table.IsEmpty(buy) then
        for k, v in ipairs(buy) do
            ply:Give(v)
        end
    end
   
    if !table.IsEmpty(sell) then
        for k, v in ipairs(sell) do
            ply:StripWeapon(v)
        end
    end

    ply:SetNWInt("PlayerMoney", currentMoney + transactionProfit)
    ply:PrintMessage(HUD_PRINTCENTER, "Shop transaction complete, it had a profit of $" .. transactionProfit .. ", and you now have $" .. currentMoney + transactionProfit .. ".")

end
concommand.Add("efgm_shop_transaction", function(ply, cmd, args)

    local buy = {}
    local sell = {}

    for k, v in ipairs(args) do
        -- god i wish lua had fucking switches (i could easily make my own)
        if v == "+" then table.insert(buy, args[k + 1])
        elseif v == "-" then table.insert(sell, args[k + 1]) end
    end

    ShopTransaction(ply, buy, sell)

end)