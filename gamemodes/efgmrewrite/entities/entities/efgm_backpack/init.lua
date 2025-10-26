AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")

ENT.Inventory = {}
ENT.VictimName = ""

function ENT:Initialize()

	self:SetModel(self.Model)
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)
    self:SetCollisionGroup(COLLISION_GROUP_PASSABLE_DOOR) -- will collide with everything other than the player

	self:SetUseType(SIMPLE_USE)

	local phys = self:GetPhysicsObject()

	if (IsValid(phys)) then phys:Wake() end

	self:SetHealth(self.BaseHealth)

end

function ENT:SetBagData(inventory, name)

    self.Inventory = inventory
    self.VictimName = name

end

function ENT:Use(activator)

    if !activator:IsPlayer() then return end

end

ENT.OnTakeDamage = nil