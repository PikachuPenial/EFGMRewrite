
util.AddNetworkString( "RequestClientStash" )
util.AddNetworkString( "SendClientStash" )
util.AddNetworkString( "RequestTransactionStash" )

STASH = {}

hook.Add("Initialize", "StashInit", function()

    sql.Query( "CREATE TABLE IF NOT EXISTS Stash ( ItemName TEXT, ItemCount INTEGER, ItemType INTEGER, ItemOwner INTEGER );" )

end)

hook.Add("PlayerInitialSpawn", "SendClientStash", function(ply) -- sends a client their stash on joining the server (i have no idea how this is gonna work when like 20 people join after a map switch)

    STASH.SendToClient(ply)

end)

function STASH.SendToClient(ply)

    local stash = STASH.GetPlayerStashLimited(ply:SteamID64())

    if stash != nil then
        
        net.Start("SendClientStash")
        net.WriteTable(stash)
        net.Send(ply)

    end

end

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
    local isTransactionValid = true

    -- Transaction validity checks

    for k, v in pairs(deposits.contents) do -- check if player has the shit
        
        if !PlayerHasItem[v.type](ply, k, v.count) then
            isTransactionValid = false
        end

    end

    for k, v in pairs(withdraws.contents) do -- check if stash has the shit
        
        if !STASH.StashHasItem(owner, k, v.type, v.count) then
            isTransactionValid = false
        end

        if PlayerHasItem[v.type](ply, k, v.count) && v.type == 1 then
            isTransactionValid = false
        end

    end

    if isTransactionValid == false then print("transaction not valid") return end -- the player has the shit they wanna sell and doesnt have shit they wanna buy

    -- Transaction logic

    if !table.IsEmpty(deposits.contents) then -- insert or update depending on if the count > 0
        for k, v in pairs(deposits.contents) do

            local count = STASH.StashItemCount(owner, k)

            if count > 0 then -- update
                
                sql.Query( "UPDATE Stash SET ItemCount = ".. count + v.count .." WHERE ItemOwner = ".. owner .." AND ItemName = ".. sql.SQLStr(k) .." AND ItemType = ".. v.type ..";" )
                
            else -- insert

                sql.Query( "INSERT INTO Stash (ItemName, ItemCount, ItemType, ItemOwner) VALUES (".. SQLStr(k) ..", ".. v.count ..", ".. v.type ..", ".. owner ..");" )

            end

            TakeItem[v.type](ply, k, v.count)

        end
    end

    if !table.IsEmpty(withdraws.contents) then -- delete row or decrement the count
        for k, v in pairs(withdraws.contents) do

            local count = STASH.StashItemCount(owner, k)

            print("doing shat")

            if count > v.count then -- update
                
                sql.Query( "UPDATE Stash SET ItemCount = ".. count - v.count .." WHERE ItemOwner = ".. owner .." AND ItemName = ".. sql.SQLStr(k) .." AND ItemType = ".. v.type ..";" )
                
            else -- remove

                sql.Query( "DELETE FROM Stash WHERE ItemOwner = ".. owner .." AND ItemName = ".. sql.SQLStr(k) ..";" )

            end

            GiveItem[v.type](ply, k, v.count)

        end
    end

    ply:PrintMessage(HUD_PRINTCENTER, "Stash transaction complete, you deposited ".. table.Count(deposits.contents) .." item(s) and withdrew ".. table.Count(withdraws.contents) .." item(s).")

end

concommand.Add("efgm_debug_resetstash", function(ply, cmd, args)

    sql.Query( "DROP TABLE IF EXISTS Stash;" )
    sql.Query( "CREATE TABLE IF NOT EXISTS Stash ( ItemName TEXT, ItemCount INTEGER, ItemType INTEGER, ItemOwner INTEGER );" )

end)

net.Receive("RequestTransactionStash", function(len, ply)

    if !ply:CompareStatus(0) then return end
    
    local args = net.ReadTable()

    if args[1] == nil then
        
        ply:PrintMessage(HUD_PRINTCONSOLE, "Format: efgm_transaction_stash +/- itemType(integer) itemCount(integer) itemName(integer)")

        return

    end

    local deposits, withdraws = INV(), INV()

    -- cmd == -/+, type (number), count, weapon_name
    for k, v in ipairs(args) do
        if v == "+" then

            local name = args[k + 3]

            if withdraws.contents[name] == nil then

                local type = tonumber( args[k + 1] )
                local count = tonumber( args[k + 2] )

                if count < 1 then return end
                if count != 1 && type == 1 then return end
    
                withdraws:AddItem(name, type, count)
                print(table.Count(withdraws.contents) or 0)
                PrintTable(withdraws.contents or {})

            end

        elseif v == "-" then

            local name = args[k + 3]

            if deposits.contents[name] == nil then

                local type = tonumber( args[k + 1] )
                local count = tonumber( args[k + 2] )

                if count < 1 then return end
                if count != 1 && type == 1 then return end
    
                deposits:AddItem(name, type, count)
                print(table.Count(deposits.contents) or 0)
                PrintTable(deposits.contents or {})

            end

        end
    end

    STASH.Transaction(ply, deposits, withdraws)

end)

net.Receive("RequestClientStash", function(len, ply)

    STASH.SendToClient(ply)

end)