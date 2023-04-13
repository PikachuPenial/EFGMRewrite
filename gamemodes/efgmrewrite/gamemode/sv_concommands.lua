-- shit you'd actually use

local function ShopTransaction(ply, cmd, args)

    -- will be like buy and sell mixed into one

    local currentMoney = ply:GetNWInt("PlayerMoney", nil)

    if currentMoney == nil then return end

    local transactionProfit = 0

    local isTransactionValid = true -- isn't valid if player doesnt have a weapon they're trying to buy, or they don't have a weapon they're trying to sell

    local buyGuns, sellGuns = {}, {}

    -- args will be formatted like args[1] == "+|gunname1" args[2] == "-|gunname2"
    -- + meaning buy, - meaning sell
    -- using that you can calculate the total money earned / lost by the transaction, that way you can sell
    -- your entire rat goblin inventory and buy a chad kit that'll sit in your stash all wipe at the same exact time,
    -- saving network shit idk

    for k, v in pairs(args) do
        -- v == "+/-|gunname"

        -- print(v)

        local shouldAdd = true

        local vSplit = string.Split(v, "|") -- [1] == "+" or "-", [2] == "gunname"

        -- print("vSplit[1], vSplit[2] = " .. vSplit[1] .. ", " .. vSplit[2])

        local gunInfo = LOOT[1][vSplit[2]]

        if gunInfo != nil then -- if the shop even has the fucking weapon available

            if vSplit[1] == "+" then -- buying from the shop

                if ply:HasWeapon(vSplit[2]) then isTransactionValid = false end
                
                if !table.IsEmpty(buyGuns) then
                    for l, b in ipairs(buyGuns) do
                        if b == vSplit[2] then shouldAdd = false end
                    end
                end

                if shouldAdd then
                    transactionProfit = transactionProfit - gunInfo[2]
                    table.insert(buyGuns, vSplit[2])
                end
    
            elseif vSplit[1] == "-" then -- selling from inventory

                if !ply:HasWeapon(vSplit[2]) then isTransactionValid = false end

                if !table.IsEmpty(sellGuns) then
                    for l, b in ipairs(sellGuns) do
                        if b == vSplit[2] then shouldAdd = false end
                    end
                end

                if shouldAdd then
                    transactionProfit = transactionProfit + gunInfo[2]
                    table.insert(sellGuns, vSplit[2])
                end 
                
            end

        end

    end

    if !isTransactionValid then print("transaction not valid") return end -- the player has the shit they wanna sell and doesnt have shit they wanna buy
    if currentMoney + transactionProfit < 0 then print("not enough money") return end -- if the player has enough money

    if !table.IsEmpty(buyGuns) then
        for k, v in ipairs(buyGuns) do
            ply:Give(v)
        end
    end

    if !table.IsEmpty(sellGuns) then
        for k, v in ipairs(sellGuns) do
            ply:StripWeapon(v)
        end
    end

    ply:SetNWInt("PlayerMoney", currentMoney + transactionProfit)
    ply:PrintMessage(HUD_PRINTCENTER, "Transaction complete, it had a profit of $" .. transactionProfit .. ", and you now have $" .. currentMoney + transactionProfit .. ".")

end
concommand.Add("efgm_transaction", ShopTransaction)

-- debug shit

local function ChangeStatus(ply, cmd, args)

    if args[1] == nil then return end

    local status = tonumber( args[1] )

    ply:SetRaidStatus(status)

end
concommand.Add("efgm_debug_changeraidstatus", ChangeStatus)

local function GetStatus(ply, cmd, args)

    print( ply:GetRaidStatus() )

end
concommand.Add("efgm_debug_getraidstatus", GetStatus)

local function GetEntireFuckingRaidStatusTable(ply, cmd, args)

    -- this shit has got to be removed before anybody gets a hold of it jesus christ

    PrintTable( DumpTable("PlayerData64") )

end
concommand.Add("efgm_debug_dumpraidtable", GetEntireFuckingRaidStatusTable)

local function DeleteTable(ply, cmd, args)

    DropTable()

end
concommand.Add("efgm_debug_deleteraidtable", DeleteTable)

local function GetRaidInfo(ply, cmd, args)

    print(RAID.Status .. " " .. RAID.StartingTime .. " " .. RAID.CurrentTime)

end
concommand.Add("efgm_debug_getraidinfo", GetRaidInfo)

local function DebugStartRaid(ply, cmd, args)

    RAID:StartRaid()

    GetRaidInfo()

end
concommand.Add("efgm_debug_startraid", DebugStartRaid)

local function DebugEndRaid(ply, cmd, args)

    -- what i said on GEFRST 999x

    RAID:EndRaid()

    GetRaidInfo()

end
concommand.Add("efgm_debug_endraid", DebugEndRaid)

local function GetNetworkInt(ply, cmd, args)

    ply:PrintMessage(HUD_PRINTCENTER, ply:GetNWInt(args[1]))

end
concommand.Add("efgm_debug_getint", GetNetworkInt)