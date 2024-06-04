AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")

ENT.Inventory = {}
ENT.Attachments = {}
ENT.VictimName = ""

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

function ENT:SetBagData( inventory, attachments, name )

    self.Inventory = inventory
    self.Attachments = attachments
    self.VictimName = name

end

function ENT:Use(activator)

    if !activator:IsPlayer() then return end

    local effectdata = EffectData()
    effectdata:SetOrigin(self:GetPos() + Vector(0, 0, 10))
    effectdata:SetMaterialIndex(0)

    local weaponCount = 0

    for k, v in ipairs( self.Inventory.contents ) do if v.type == 1 then weaponCount = weaponCount + 1 end end

    activator:SetHealth(activator:GetMaxHealth())
    activator:PrintMessage(HUD_PRINTTALK, "You looted " .. self.VictimName .. "! (" .. weaponCount .. " weapons, " .. table.Count( self.Attachments ) .. " attachments)")

    if table.IsEmpty( self.Inventory.contents ) and table.IsEmpty( self.Attachments ) then return end

    for k, v in ipairs( self.Inventory.contents ) do

        GiveItem[ v.type ]( activator, v.name, v.count, false )

    end

    for k, v in pairs( self.Attachments ) do

        ARC9:PlayerGiveAtt(activator, k, v)

    end

    ARC9:PlayerSendAttInv(activator)
    util.Effect("arc9_opencrate", effectdata)
    self:EmitSound("arc9/useatt.ogg")
    self:Remove()

end

ENT.OnTakeDamage = nil