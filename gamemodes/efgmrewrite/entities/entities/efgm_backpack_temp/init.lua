AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")

local contents = {}
local attachments = {}
local victimName

function ENT:Initialize()

	self:SetModel(self.Model)
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)
    self:SetCollisionGroup(COLLISION_GROUP_WEAPON) -- will collide with everything other than the player

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

function ENT:SetBagAttachments(inventory)

    attachments = inventory

end

function ENT:SetVictimName(name)

    victimName = name

end

function ENT:Use(activator)

    if !activator:IsPlayer() then return end
    activator:PrintMessage(HUD_PRINTCENTER, "You looted " .. victimName .. "! (" .. table.Count(contents) .. " items, " .. table.Count(attachments) .. " attachments)")

    if table.IsEmpty( contents ) and table.IsEmpty( attachments ) then

        return

    end

    for k, v in ipairs( contents ) do

        activator:Give(v)

    end

    for k, v in pairs( attachments ) do

        ARC9:PlayerGiveAtt(activator, k, v)

    end

    ARC9:PlayerSendAttInv(activator)
    self:Remove()

end

ENT.OnTakeDamage = nil