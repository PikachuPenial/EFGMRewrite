
net.Receive("PlayerNetworkStash", function(len, ply)

    local stashStr = net.ReadString()

    stashStr = util.Base64Decode(stashStr)
    stashStr = util.Decompress(stashStr)

    if !stashStr then return end

    local stashTbl = util.JSONToTable(stashStr)

    playerStash = stashTbl
    if playerStash == nil then playerStash = {} end

end )

net.Receive("PlayerStashReload", function(len, ply)

    ReloadStash()

end )

net.Receive("PlayerStashAddItem", function(len, ply)

    local name, type, data, index

    name = net.ReadString()
    type = net.ReadUInt(4)
    data = net.ReadTable()
    index = net.ReadUInt(16)

    table.insert(playerStash, index, ITEM.Instantiate(name, type, data))
    ReloadStash()

end )

net.Receive("PlayerStashUpdateItem", function(len, ply)

    local newData, index

    newData = net.ReadTable()
    index = net.ReadUInt(16)

    playerStash[index].data = newData
    ReloadStash()

end )

net.Receive("PlayerStashDeleteItem", function(len, ply)

    local index

    index = net.ReadUInt(16)

    table.remove(playerStash, index)

    ReloadStash()

end )

function StashItemFromInventory(itemIndex)

    local item = playerInventory[itemIndex]
    if item == nil then return end

    net.Start("PlayerStashAddItemFromInventory", false)
        net.WriteUInt(itemIndex, 16)
    net.SendToServer()

    ReloadInventory()
    ReloadStash()

end

function ConsumeItemFromStash(itemIndex)

    net.Start("PlayerStashConsumeItem", false)
    net.WriteUInt(itemIndex, 16)
    net.SendToServer()
    ReloadStash()

end