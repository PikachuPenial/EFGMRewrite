AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")

local backpackInventoryName = "Backpack"
local backpackInventory = {}

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

function ENT:SetContents(inventory, ply)

    if inventory == nil then
    
        self:Remove()

        return
        
    end

    if ply != nil then

        backpackInventoryName = ply:GetName()

    end

    backpackInventory = inventory

end

function ENT:Use(activator)

    if !activator:IsPlayer() then return end

    if table.IsEmpty( backpackInventory ) then
    
        self:Remove()

        return
    
    end

    local remainingInventory = activator:GiveInventory(backpackInventory)

    print(activator:GetName() .. " looted " .. backpackInventoryName)

    if remainingInventory == nil then
    
        self:Remove()

    else

        backpackInventory = remainingInventory
        
    end

end

ENT.OnTakeDamage = nil