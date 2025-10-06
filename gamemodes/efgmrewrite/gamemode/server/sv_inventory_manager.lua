
util.AddNetworkString("PlayerReinstantiateInventory")
util.AddNetworkString("PlayerInventoryAddItem")
util.AddNetworkString("PlayerInventoryUpdateItem")
util.AddNetworkString("PlayerInventoryDeleteItem")
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

function AddItemToInventory(ply, name, type, data)

    local def = EFGMITEMS[name]

    data.count = math.Clamp(tonumber(data.count) or 1, 1, def.stackSize)

    local item = ITEM.Instantiate(name, type, data)
    local index = table.insert(ply.inventory, item)

    net.Start("PlayerInventoryAddItem", false)
    net.WriteString(name)
    net.WriteUInt(type, 4)
    net.WriteTable(data) -- Writing a table isn't great but we ball for now
    net.WriteUInt(index, 16)
    net.Send(ply)

end

net.Receive("PlayerInventoryDropItem", function(len, ply)

    local itemIndex = net.ReadUInt(16)
    local data = net.ReadTable()
    local item = ply.inventory[itemIndex]

    local wep = ents.Create(item.name)
    wep:SetPos(ply:GetShootPos() + ply:GetForward() * 128)
    wep:Spawn()
    wep:PhysWake()

    if type(wep.GetData) == "function" then wep:GetData(data) end

    table.remove(ply.inventory, itemIndex)

end)

net.Receive("PlayerInventoryEquipItem", function(len, ply)

    -- TODO

end)

net.Receive("PlayerInventoryConsumeItem", function(len, ply)

    local itemIndex = net.ReadUInt(16)
    local item = ply.inventory[itemIndex]
    local durability = item.data.durability

    local i = EFGMITEMS[item.name]

    -- heal
    if i.consumableType == "heal" then

        local healAmount = ply:GetMaxHealth() - ply:Health()

        if durability < healAmount then healAmount = durability end

        ply:SetHealth(math.min(ply:Health() + healAmount, 100))
        ply.inventory[itemIndex].data.durability = durability - healAmount

        if ply.inventory[itemIndex].data.durability > 0 then

            net.Start("PlayerInventoryUpdateItem", false)
            net.WriteTable(item.data)
            net.WriteUInt(itemIndex, 16)
            net.Send(ply)

        else

            net.Start("PlayerInventoryDeleteItem", false)
            net.WriteUInt(itemIndex, 16)
            net.Send(ply)

            table.remove(ply.inventory, itemIndex)

        end

    end

end)

function GiveAmmo(ply, count)

    local ammo = "efgm_ammo_556x45"
    local data = {}
    data.count = count

    AddItemToInventory(ply, ammo, EQUIPTYPE.Ammunition, data)

end
concommand.Add("efgm_giveammo", function(ply, cmd, args) GiveAmmo(ply, args[1]) end)