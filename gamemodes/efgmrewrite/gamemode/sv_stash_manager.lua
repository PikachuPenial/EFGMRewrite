
util.AddNetworkString( "SendClientStash" )

STASH = {}

hook.Add("Initialize", "StashInit", function()

    sql.Query( "CREATE TABLE IF NOT EXISTS Stash ( ItemName TEXT, ItemCount INTEGER, ItemType INTEGER, ItemOwner INTEGER );" )

end)

hook.Add("PlayerInitialSpawn", "SendClientStash", function(ply) -- sends a client their stash on joining the server (i have no idea how this is gonna work when like 20 people join after a map switch)

    local playerStash = STASH.GetPlayerStashLimited( ply:SteamID64() )

    if playerStash == nil then return end

    local jsonStash = util.TableToJSON( playerStash )
    local compStash = util.Compress( jsonStash )
    local bytes = #compStash

    net.Start("SendClientStash")
    net.WriteUInt( bytes, 16 ) -- Writes the amount of bytes we have. Needed to read the data
    net.WriteData( compStash, bytes ) -- Writes the datas
    net.Send(ply)

end)

function STASH.StashHasItem(plyID, item, type, count) -- returns true if the player has an item in their stash, returns false if they dont

    if sql.Query( "SELECT ItemName FROM Stash WHERE ItemOwner = ".. plyID .." AND ItemName = ".. sql.SQLStr(item) .." AND ItemType = ".. type .." AND ItemCount >= ".. count ..";" ) == nil then
        return false
    else    
        return true
    end
end

function STASH.StashItemCount(plyID, item)
    local count = tonumber( sql.QueryValue( "SELECT ItemCount FROM Stash WHERE ItemOwner = ".. plyID .." AND ItemName = ".. sql.SQLStr(item) ..";" ) )

    if count == "NULL" then return 0 end
    if count == nil then return 0 end

    return count
end

function STASH.GetPlayerStash(plyID)

    local query = sql.Query( "SELECT ItemName, ItemCount, ItemType, ItemOwner FROM Stash WHERE ItemOwner = " .. plyID .. " ORDER BY ItemType ASC, ItemCount DESC;" )
    
    if query == "NULL" then return nil end

    return query

end

function STASH.GetPlayerStashLimited(plyID)

    local query = sql.Query( "SELECT ItemName, ItemCount, ItemType FROM Stash WHERE ItemOwner = ".. plyID ..";" )

    if query == "NULL" then return nil end

    return query

end

function STASH.StashTotalCount(plyID)

    local sum = sql.Query( "SELECT SUM(ItemCount) FROM Stash WHERE ItemOwner = ".. plyID ..";" )[1]["SUM(ItemCount)"]

    if sum == "NULL" then return 0 end
    if sum == nil then return 0 end

    return sum

end

function STASH.Transaction(ply, deposits, withdraws)

    -- Declaring variables

    local owner = ply:SteamID64()
    
    local transItems = 0 -- trans is short for transaction eat shit lgbt community
    local stashItems = STASH.StashTotalCount(owner)

    local maxItems = 4 -- number for testing, can increase / decrease whenever (ima have this on hold until i get around to making clientside ui)

    local isTransactionValid = true

    -- Transaction validity checks

    for k, v in ipairs(deposits) do -- check if player has the shit
        
        transItems = transItems + v.ItemCount -- adding because this will add to the stash

        if !PlayerHasItem[v.ItemType](ply, v.ItemName, v.ItemCount) then
            isTransactionValid = false
        end

    end

    for k, v in ipairs(withdraws) do -- check if stash has the shit
        
        transItems = transItems - v.ItemCount -- subtracting because this will take from the stash

        if !STASH.StashHasItem(owner, v.ItemName, v.ItemType, v.ItemCount) then
            isTransactionValid = false
        end

        if PlayerHasItem[v.ItemType](ply, v.ItemName, v.ItemCount) && v.ItemType == 1 then
            isTransactionValid = false
        end

    end

    if isTransactionValid == false then print("transaction not valid") return end -- the player has the shit they wanna sell and doesnt have shit they wanna buy
    -- if transItems + stashItems > maxItems then ply:PrintMessage(HUD_PRINTCENTER, "Stash transaction failed, your stash can only hold 4 items, but you tried to hold ".. transItems + stashItems .."!") return end

    -- Transaction logic

    if !table.IsEmpty(deposits) then -- insert or update depending on if the count > 0
        for k, v in ipairs(deposits) do

            local count = STASH.StashItemCount(owner, v.ItemName)

            if count > 0 then -- update
                
                sql.Query( "UPDATE Stash SET ItemCount = ".. count + v.ItemCount .." WHERE ItemOwner = ".. owner .." AND ItemName = ".. sql.SQLStr(v.ItemName) .." AND ItemType = ".. v.ItemType ..";" )
                
            else -- insert

                sql.Query( "INSERT INTO Stash (ItemName, ItemCount, ItemType, ItemOwner) VALUES (".. SQLStr(v.ItemName) ..", ".. v.ItemCount ..", ".. v.ItemType ..", ".. owner ..");" )

            end

            TakeItem[v.ItemType](ply, v.ItemName, v.ItemCount)

        end
    end

    if !table.IsEmpty(withdraws) then -- delete row or decrement the count
        for k, v in ipairs(withdraws) do

            local count = STASH.StashItemCount(owner, v.ItemName)

            if count > v.ItemCount then -- update
                
                sql.Query( "UPDATE Stash SET ItemCount = ".. count - v.ItemCount .." WHERE ItemOwner = ".. owner .." AND ItemName = ".. sql.SQLStr(v.ItemName) .." AND ItemType = ".. v.ItemType ..";" )
                
            else -- remove

                sql.Query( "DELETE FROM Stash WHERE ItemOwner = ".. owner .." AND ItemName = ".. sql.SQLStr(v.ItemName) .." AND ItemType = ".. v.ItemType ..";" )

            end

            GiveItem[v.ItemType](ply, v.ItemName, v.ItemCount)

        end
    end

    ply:PrintMessage(HUD_PRINTCENTER, "Stash transaction complete, you deposited ".. #deposits .." item(s) and withdrew ".. #withdraws .." item(s).")

end

concommand.Add("efgm_stash_transaction", function(ply, cmd, args)

    if ply:IsInRaid() then return end
    
    local deposits = {} -- ["ItemName"] and ["ItemType"]
    local dpChecks = {}

    local withdraws = {} -- same
    local wdChecks = {}

    -- cmd == -/+, type (number), count, weapon_name
    for k, v in ipairs(args) do
        if v == "+" then

            local tbl = {}
            tbl.ItemType = tonumber( args[k + 1] )
            tbl.ItemCount = tonumber( args[k + 2] )
            tbl.ItemName = args[k + 3]

            if wdChecks[tbl.ItemName] == nil then

                if tbl.ItemCount < 1 then return end
                if tbl.ItemCount != 1 && tbl.ItemType == 1 then return end -- if a weapon has a count other than 1 bc you can only hold 1 of each weapon
    
                table.insert(withdraws, tbl)
                wdChecks[tbl.ItemName] = 1

            end

        elseif v == "-" then

            local tbl = {}
            tbl.ItemType = tonumber( args[k + 1] )
            tbl.ItemCount = tonumber( args[k + 2] )
            tbl.ItemName = args[k + 3]

            if dpChecks[tbl.ItemName] == nil then

                if tbl.ItemCount < 1 then return end
                if tbl.ItemCount != 1 && tbl.ItemType == 1 then return end -- if a weapon has a count other than 1 bc you can only hold 1 of each weapon
    
                table.insert(deposits, tbl)
                dpChecks[tbl.ItemName] = 1

            end

        end
    end

    STASH.Transaction(ply, deposits, withdraws)

    -- im tired of calling this every fucking time
    ply:ConCommand("efgm_debug_getstash")

end)

concommand.Add("efgm_debug_resetstash", function(ply, cmd, args)

    sql.Query( "DROP TABLE IF EXISTS Stash;" )
    sql.Query( "CREATE TABLE IF NOT EXISTS Stash ( ItemName TEXT, ItemCount INTEGER, ItemType INTEGER, ItemOwner INTEGER );" )

end)

concommand.Add("efgm_debug_getstash", function(ply, cmd, args)

    local tbl = STASH.GetPlayerStash(ply:SteamID64())

    if tbl == nil then return print("Stash is empty, or doesn't exist. Eat shit.") end

    PrintTable( tbl )

end)