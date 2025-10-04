
util.AddNetworkString("PlayerReloadInventory")
util.AddNetworkString("PlayerInventoryAddItem")
util.AddNetworkString("PlayerInventoryDropItem")

hook.Add("PlayerSpawn", "InventorySetup", function(ply)
	ply.inventory = {}
end)

-- for dev. purposes, dont need to start new map to give yourself items after a reload
hook.Add("OnReloaded", "InventoryReload", function()
    for k, ply in pairs(player.GetAll()) do
        table.Empty(ply.inventory)
        table.ClearKeys(ply.inventory)
        net.Start("PlayerReloadInventory", false)
        net.Send(ply)
    end
end)

hook.Add("PlayerCanPickupWeapon", "InventoryWeaponPickup", function(ply, wep)

    local wepClass = wep:GetClass()
    wep:Remove()

    local item = ITEM.Instantiate(wepClass, 1)

    local index = table.insert(ply.inventory, item)

    net.Start("PlayerInventoryAddItem", false)
        net.WriteString( wepClass )
        net.WriteUInt(1, 4)
        net.WriteTable( {} ) -- Writing a table isn't great but we ball for now
        net.WriteUInt(index, 16)
    net.Send(ply)

    return wepClass == "gmod_tool"

end)

net.Receive("PlayerInventoryDropItem", function( len, ply)

    local itemIndex = net.ReadUInt(16)
    local item = ply.inventory[itemIndex]

    local wep = ents.Create(item.name)
    wep:SetPos(ply:GetShootPos() + ply:GetForward() * 128)
    wep:Spawn()
    wep:PhysWake()

    table.remove(ply.inventory, itemIndex)

end)