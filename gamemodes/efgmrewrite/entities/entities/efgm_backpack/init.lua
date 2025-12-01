AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")

util.AddNetworkString("PlayerOpenContainer")

ENT.Inventory = {}
ENT.Name = ""

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
		phys:SetMass(40)

	end

	self:SetHealth(self.BaseHealth)

end

function ENT:SetBagData(inventory, name)

    self.Inventory = inventory
    self.Name = name

end

function ENT:Use(activator)

    if !activator:IsPlayer() then return end

	net.Start("PlayerOpenContainer", false)
		net.WriteEntity(self)
		net.WriteString(self.Name)
		net.WriteTable(self.Inventory, true)
	net.Send(activator)

end

ENT.OnTakeDamage = nil