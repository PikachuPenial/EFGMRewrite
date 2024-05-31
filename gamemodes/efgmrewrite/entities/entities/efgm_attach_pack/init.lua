AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")

local attachCount
local attachTable

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

    if !activator:IsPlayer() then return end

    attachCount = math.random(50, 150)
    attachTable = table.Copy(ARC9.Attachments_Index)
    table.Shuffle(attachTable)

    if table.IsEmpty( attachTable ) then

        return

    end

    for k, v in pairs( attachTable ) do

        if k > attachCount then continue end
        ARC9:PlayerGiveAtt(activator, v, 1)

    end

    activator:PrintMessage(HUD_PRINTTALK, "You looted " .. attachCount .. " attachments!")

    ARC9:PlayerSendAttInv(activator)
    self:Remove()

end

ENT.OnTakeDamage = nil