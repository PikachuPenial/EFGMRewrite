AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")

ENT.AttachCount = 0
ENT.AttachTable = {}

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
    self:GetAttatchments( 50, 150)

end

function ENT:GetAttatchments( minCount, maxCount )

    self.AttachCount = math.random( minCount, maxCount )
    
    self.AttachTable = table.Copy(ARC9.Attachments_Index)
    table.Shuffle(self.AttachTable)

end

function ENT:Use(activator)

    if !activator:IsPlayer() then return end
    if table.IsEmpty( self.AttachTable ) then return end

    for k, v in pairs( self.AttachTable ) do

        if k > self.AttachCount then continue end
        ARC9:PlayerGiveAtt(activator, v, 1)

    end

    activator:PrintMessage(HUD_PRINTTALK, "You looted " .. self.AttachCount .. " attachments!")

    ARC9:PlayerSendAttInv(activator)
    self:Remove()

end

ENT.OnTakeDamage = nil