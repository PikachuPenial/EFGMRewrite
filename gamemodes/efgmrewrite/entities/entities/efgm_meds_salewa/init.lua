AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")

ENT.Durability = 100

function ENT:Initialize()

	self:SetModel(self.Model)
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)
    self:SetCollisionGroup(COLLISION_GROUP_PASSABLE_DOOR) -- will collide with everything other than the player

	self:SetUseType(SIMPLE_USE)

	local phys = self:GetPhysicsObject()

	if (IsValid(phys)) then
		phys:Wake()
	end

	self:SetHealth(self.BaseHealth)

end

function ENT:SetDurability(value) self.Durability = value end

function ENT:GetData(data) self:SetDurability(data.durability) end

function ENT:Use(activator)

    local entity = self:GetClass()
    self:Remove()

    local data = {}
    data.durability = self.Durability
    local item = ITEM.Instantiate(entity, EQUIPTYPE.Consumable, data)

    local index = table.insert(activator.inventory, item)

    net.Start("PlayerInventoryAddItem", false)
    net.WriteString(entity)
    net.WriteUInt(EQUIPTYPE.Consumable, 4)
    net.WriteTable(data) -- Writing a table isn't great but we ball for now
    net.WriteUInt(index, 16)
    net.Send(activator)

end

ENT.OnTakeDamage = nil