AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")

ENT.QuestItem = ""

function ENT:KeyValue(key, value)

	if key == "quest_item" then
		self.QuestItem = value
	end
end

function ENT:Initialize()

	self:SetModel(EFGMQUESTITEM[self.QuestItem].model)
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)
    self:SetCollisionGroup(COLLISION_GROUP_PASSABLE_DOOR)

	self:SetUseType(SIMPLE_USE)

	local phys = self:GetPhysicsObject()

	if (IsValid(phys)) then

		phys:Wake()

	end

    self:SetNWString("Item", self.QuestItem)

end

function ENT:Use(activator)

    hook.Run("TaskQuestItemPickup", activator, self.QuestItem)

end