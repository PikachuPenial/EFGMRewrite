
STASH = {}

hook.Add("Initialize", "StashInit", function()

    sql.Query( "CREATE TABLE IF NOT EXISTS Stash ( ItemName TEXT, ItemCount INTEGER, ItemType INTEGER, ItemOwner INTEGER );" )

end)

function STASH.StashHasItem(plyID, item) -- returns true if the player has an item in their stash, returns false if they dont
    if sql.Query( "SELECT ItemName FROM Stash WHERE ItemOwner = ".. plyID .." AND ItemName = ".. sql.SQLStr(item) ..";" ) == nil then
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

    return sql.Query( "SELECT ItemName, ItemCount, ItemType, ItemOwner FROM Stash WHERE ItemOwner = " .. plyID .. " ORDER BY ItemCount DESC;" )

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
    local transactionCount = 0 -- positive if transaction adds more than it takes, etc
    local maxItems = 4 -- number for testing, can increase / decrease whenever
    local transItems = 0 -- trans is short for transaction eat shit lgbt community
    local stashItems = STASH.StashTotalCount(owner)

    local isTransactionValid = true

    -- Transaction validity checks

    for k, v in ipairs(deposits) do -- check if player has the shit
        
        transItems = transItems + 1 -- adding because this will add to the stash

        if !ply:HasWeapon(v) then isTransactionValid = false end

    end

    for k, v in ipairs(withdraws) do -- check if stash has the shit
        
        transItems = transItems - 1 -- subtracting because this will take from the stash

        if !STASH.StashHasItem(owner, v) then isTransactionValid = false end

    end

    if !isTransactionValid then print("transaction not valid") return end -- the player has the shit they wanna sell and doesnt have shit they wanna buy
    if transItems + stashItems > maxItems then ply:PrintMessage(HUD_PRINTCENTER, "Stash transaction failed, your stash can only hold 4 items, but you tried to hold ".. transItems + stashItems .."!") return end

    -- Transaction logic

    if !table.IsEmpty(deposits) then -- insert or update depending on if the count > 0
        for k, v in ipairs(deposits) do

            local count = STASH.StashItemCount(owner, v)

            if count > 0 then -- update
                
                sql.Query( "UPDATE Stash SET ItemCount = ".. count + 1 .." WHERE ItemOwner = ".. owner .." AND ItemName = ".. sql.SQLStr(v) ..";" )
                
            else -- insert

                sql.Query( "INSERT INTO Stash (ItemName, ItemCount, ItemType, ItemOwner) VALUES (".. SQLStr(v) ..", 1, 1, ".. owner ..");" )

            end

            ply:StripWeapon(v)

        end
    end

    if !table.IsEmpty(withdraws) then -- delete row or decrement the count
        for k, v in ipairs(withdraws) do

            local count = STASH.StashItemCount(owner, v)

            if count > 1 then -- update
                
                sql.Query( "UPDATE Stash SET ItemCount = ".. count - 1 .." WHERE ItemOwner = ".. owner .." AND ItemName = ".. sql.SQLStr(v) ..";" )
                
            else -- remove

                sql.Query( "DELETE FROM Stash WHERE ItemOwner = ".. owner .." AND ItemName = ".. sql.SQLStr(v) ..";" )

            end

            ply:Give(v)

        end
    end

    ply:PrintMessage(HUD_PRINTCENTER, "Stash transaction complete, you deposited ".. #deposits .." item(s) and withdrew ".. #withdraws .." item(s).")

end

concommand.Add("efgm_stash_transaction", function(ply, cmd, args)

    -- args is like [1] == +, [2] == "weapon_name", [3] == -, [4] == "weapon_name2" so no vSplit woohoo
    -- also + being to take from the stash (withdraw), and - being to put into the stash (deposit) because thats an established convention from the fucking shop end my life
    -- also also this shit isnt in concommands because fuck oop and its expectation of encapsulation of state and fuck you
    
    -- stash transaction will handle stash itself

    -- separate args into deposits table and withdraws table

    local deposits = {}
    local withdraws = {}

    for k, v in ipairs(args) do
        -- god i wish lua had fucking switches (i could easily make my own)
        if v == "+" then table.insert(withdraws, args[k + 1])
        elseif v == "-" then table.insert(deposits, args[k + 1]) end
    end

    -- PrintTable(deposits)
    -- PrintTable(withdraws)

    STASH.Transaction(ply, deposits, withdraws)

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