
util.AddNetworkString("PlayerReinstantiateInventory")
util.AddNetworkString("PlayerInventoryAddItem")
util.AddNetworkString("PlayerInventoryDropItem")
util.AddNetworkString("PlayerInventoryEquipItem")
util.AddNetworkString("PlayerInventoryConsumeItem")

hook.Add("PlayerSpawn", "InventorySetup", function(ply)
	ply.inventory = {}
end)

function ReinstantiateInventory(ply)

    print("server inventory flushed")
    ply.inventory = {}

end
concommand.Add("efgm_flush_inventory", function(ply, cmd, args) ReinstantiateInventory(ply) end)

hook.Add("OnReloaded", "InventoryReload", function()

    for k, ply in pairs(player.GetAll()) do
        ReinstantiateInventory(ply)
    end

    net.Start("PlayerReinstantiateInventory", false)
    net.Broadcast()

end)

hook.Add("PlayerCanPickupWeapon", "InventoryWeaponPickup", function(ply, wep)

    local wepClass = wep:GetClass()
    wep:Remove()

    local item = ITEM.Instantiate(wepClass, 1)

    local index = table.insert(ply.inventory, item)

    net.Start("PlayerInventoryAddItem", false)
    net.WriteString(wepClass)
    net.WriteUInt(1, 4)
    net.WriteTable({}) -- Writing a table isn't great but we ball for now
    net.WriteUInt(index, 16)
    net.Send(ply)

    return wepClass == "gmod_tool"

end)

net.Receive("PlayerInventoryDropItem", function(len, ply)

    local itemIndex = net.ReadUInt(16)
    local item = ply.inventory[itemIndex]

    local wep = ents.Create(item.name)
    wep:SetPos(ply:GetShootPos() + ply:GetForward() * 128)
    wep:Spawn()
    wep:PhysWake()

    table.remove(ply.inventory, itemIndex)

end)

net.Receive("PlayerInventoryEquipItem", function(len, ply)

    -- TODO

end)

net.Receive("PlayerInventoryConsumeItem", function(len, ply)

    local itemIndex = net.ReadUInt(16)
    local item = ply.inventory[itemIndex]

    -- TODO, prob store this stuff on the item itself, idrk tbh
    local i = EFGMITEMS[item.name]

    -- TODO, only consume some of the item if it has a durability and keep it in the inventory

    -- heal
    if i.consumableType == "heal" then ply:SetHealth(math.min(ply:Health() + i.consumableValue, 100)) end

    table.remove(ply.inventory, itemIndex)

end)

function GiveAmmo(ply)

    local ammoType = "efgm_ammo_556x45"

    local item = ITEM.Instantiate(ammoType, 1)

    local index = table.insert(ply.inventory, item)

    net.Start("PlayerInventoryAddItem", false)
    net.WriteString(ammoType)
    net.WriteUInt(1, 4)
    net.WriteTable({}) -- Writing a table isn't great but we ball for now
    net.WriteUInt(index, 16)
    net.Send(ply)

end
concommand.Add("giveammo", function(ply, cmd, args) GiveAmmo(ply) end)