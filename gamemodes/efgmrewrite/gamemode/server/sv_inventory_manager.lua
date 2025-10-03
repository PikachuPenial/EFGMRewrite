
util.AddNetworkString("PlayerInventoryAddItem")

util.AddNetworkString("PlayerInventoryDropItem")

hook.Add("PlayerSpawn", "InventorySetup", function(ply)
	ply.inventory = {}
end)

hook.Add("PlayerCanPickupWeapon", "InventoryWeaponPickup", function(ply, wep)

    local wepClass = wep:GetClass()
    wep:Remove()

    local item = ITEM.Instantiate( wepClass, 1 )

    local index = table.insert( ply.inventory, item )

    net.Start( "PlayerInventoryAddItem", false )
        net.WriteString( wepClass )
        net.WriteUInt( 1, 4 )
        net.WriteTable( {} ) -- Writing a table isn't great but we ball for now
        net.WriteUInt(index, 16)
    net.Send(ply)

    return wepClass == "gmod_tool"

end)

net.Receive("PlayerInventoryDropItem", function( len, ply)
    
    local itemIndex = net.ReadUInt(16)
    local item = ply.inventory[itemIndex]

    local wep = ents.Create(item.name)
	wep:SetPos( ply:GetShootPos() + ply:GetForward() * 128 ) 
	wep:Spawn()
    wep:PhysWake()

    table.remove(ply.inventory, itemIndex)

end)