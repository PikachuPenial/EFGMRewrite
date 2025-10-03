
util.AddNetworkString("ModifyPlayerInventory")

hook.Add("PlayerSpawn", "InventorySetup", function(ply)
	ply.inventory = {}
end)

hook.Add("PlayerCanPickupWeapon", "InventoryWeaponPickup", function(ply, wep)

    local item = ITEM.Instantiate( wep:GetClass(), 1 )

    table.insert( ply.inventory, item )

    net.Start("ModifyPlayerInventory", false)
        net.WriteString( wep:GetClass() )
        net.WriteUInt( 1, 4 )
        net.WriteTable( {} ) -- Writing a table isn't great but we ball for now
        net.WriteUInt(0, 4) -- For now, 0 is add, and 1 is remove
    net.Send(ply)

    return false

end)