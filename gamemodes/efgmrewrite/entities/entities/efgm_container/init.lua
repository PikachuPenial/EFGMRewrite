AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")

util.AddNetworkString("PlayerOpenContainer")

ENT.Inventory = {}
ENT.Name = ""
ENT.PlayersSearched = {}
ENT.LinkedLootEnt = NULL

function ENT:Initialize()

	self:SetModel(self.Model)
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)
    self:SetCollisionGroup(COLLISION_GROUP_PASSABLE_DOOR)

	self:SetUseType(SIMPLE_USE)

	local phys = self:GetPhysicsObject()

	if (IsValid(phys)) then

		phys:Wake()
		phys:SetMass(150)

	end

	self:SetHealth(self.BaseHealth)

end

function ENT:SetLinkedEnt(ent)

    self.LinkedLootEnt = ent

end

function ENT:SetContainerData(inventory, name)

    self.Inventory = inventory
    self.Name = name

end

function ENT:Use(activator)

    if !activator:IsPlayer() then return end

	if self.LinkedLootEnt != NULL then self.LinkedLootEnt:BeginLootCooldown() end

    self:EmitSound("containers/open" .. tostring(math.random(2)) .. ".wav")

	net.Start("PlayerOpenContainer", false)
		net.WriteEntity(self)
		net.WriteString(self.Name)
		net.WriteTable(self.Inventory, true)
	net.Send(activator)

	if self.PlayersSearched[activator:SteamID64()] == activator:GetNWInt("Level", 0) then return end

	activator:SetNWInt("RaidContainersLooted", activator:GetNWInt("RaidContainersLooted") + 1)

	for k, v in pairs(self.Inventory) do

		activator:SetNWInt("ExperienceLooting", activator:GetNWInt("ExperienceLooting") + math.random(3, 8))

	end

	self.PlayersSearched[activator:SteamID64()] = activator:GetNWInt("Level", 0)

end

ENT.OnTakeDamage = nil