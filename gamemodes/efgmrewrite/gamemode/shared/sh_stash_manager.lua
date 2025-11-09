
if SERVER then

    print("penis")

    concommand.Add("efgm_debug_addtostash", function(ply, cmd, args)

        local item = ITEM.Instantiate(args[1], tonumber(args[2]), {})
        table.insert( ply.stash, item)

        local stashString = util.TableToJSON(ply.stash)
        stashString = util.Compress(stashString)
        stashString = util.Base64Encode(stashString, true)
        ply:SetNWString("Stash", stashString)

        PrintTable(ply.stash)
        print(stashString)
    
    end)

    concommand.Add("efgm_debug_addtostash", function(ply, cmd, args)

        local index = tonumber(args[1])
        local item = DeleteItemFromInventory(ply, index, false)
        table.insert(ply.stash, item)

        local stashString = util.TableToJSON(ply.stash)
        stashString = util.Compress(stashString)
        stashString = util.Base64Encode(stashString, true)
        ply:SetNWString("Stash", stashString)

        PrintTable(ply.stash)
        print(stashString)
    
    end)

end

if CLIENT then
    
end