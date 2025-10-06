AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")

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

function ENT:Use(activator)

    local ent = self:GetClass()
    self:Remove()

    local item = ITEM.Instantiate(ent, 1)
    local index = table.insert(activator.inventory, item)

    net.Start("PlayerInventoryAddItem", false)
    net.WriteString(ent)
    net.WriteUInt(1, 4)
    net.WriteTable({}) -- Writing a table isn't great but we ball for now
    net.WriteUInt(index, 16)
    net.Send(activator)

end

ENT.OnTakeDamage = nil