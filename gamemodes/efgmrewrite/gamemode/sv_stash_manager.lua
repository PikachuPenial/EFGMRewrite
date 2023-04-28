
STASH = {}

hook.Add("Initialize", "StashInit", function()

    sql.Query( "CREATE TABLE IF NOT EXISTS Stash ( ItemName TEXT, ItemCount INTEGER, ItemType INTEGER, ItemOwner INTEGER )" )

end)

function STASH.GetPlayerStash(ply)

    return sql.Query( "SELECT ItemName, ItemCount, ItemType, ItemOwner FROM Stash WHERE ItemOwner = " .. ply:SteamID64() .. ";" )

end
concommand.Add("efgm_debug_getstash", function(ply, cmd, args)

    tbl = STASH.GetPlayerStash(ply)
    print( sql.LastError() )

    PrintTable( tbl )

end)

function STASH.Transaction(ply, deposits, withdraws)

    local owner = ply:SteamID64()
    local sqlDeposits = ""
    local sqlWithdraws = ""

    -- basically buying and selling, just with more sql eat shit penal

    local isTransactionValid = true

    local stashInventory = STASH.GetPlayerStash(ply) -- oh boy the mf sql (im gonna procrastinate on this) (also its a lookup table)
    print( sql.LastError() )

    -- transaction validity checks

    for k, v in ipairs(deposits) do -- check if player has the shit
        
        for k2, v2 in ipairs(stashInventory) do
            
            -- its now dawning on me that the shop transaction system is probably not gonna work well with sql without some tweaking
            -- im too tired for this shit
            if !ply:HasWeapon(v2[ItemName]) then isTransactionValid = false end

        end

        if sqlDeposits != "" then
            
            sqlDeposits = sqlDeposits .. ", "

        end

        sqlDeposits = "(".. sql.SQLStr(v, true) ..", ".. 1 ..", ".. 1 ..", ".. owner ..")"
        print(sqlDeposits)

    end

    for k, v in ipairs(withdraws) do -- check if stash has the shit
        
        if stashInventory[v] == nil then isTransactionValid = false end

    end

    -- actual sql shit

    -- assuming all of the stuff inserted is weapons, may change later
    sql.Query( "INSERT INTO Stash (ItemName, ItemCount, ItemType, ItemOwner) VALUES ".. sqlDeposits ..";" )
    print( sql.LastError() )

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