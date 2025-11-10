
if SERVER then

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

    concommand.Add("efgm_debug_movetostash", function(ply, cmd, args)

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

    function DecodeStash(ply, str)

        if !str then return end
        str = util.Base64Decode(str)
        str = util.Decompress(str)

        if !str then return end

        local tbl = util.JSONToTable(str)

        return tbl

    end

end

if CLIENT then
    
end