AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")

local contents = {}

function ENT:Initialize()

	self:SetModel(self.Model)
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)
    self:SetCollisionGroup(COLLISION_GROUP_DEBRIS)

	self:SetUseType(SIMPLE_USE)

	local phys = self:GetPhysicsObject()

	if (IsValid(phys)) then
		phys:Wake()
	end

	self:SetHealth(self.BaseHealth)

end

function ENT:SetBagContents(inventory)

    contents = inventory

end

function ENT:Use(activator)

    if !activator:IsPlayer() then return end

    if table.IsEmpty( contents ) then

        self:Remove()

        return

    end

    for k, v in ipairs( contents ) do

        activator:Give(v)
       
    end

    self:Remove()

end

ENT.OnTakeDamage = nil