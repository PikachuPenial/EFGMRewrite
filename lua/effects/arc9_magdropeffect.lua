EFFECT.Type = 1

EFFECT.Model = "models/food/hotdog.mdl"

EFFECT.AlreadyPlayedSound = false
EFFECT.LifeTime = 3
EFFECT.SpawnTime = 0

EFFECT.VMContext = true

local arc9_eject_time = GetConVar("arc9_eject_time")

local FormatViewModelAttachment = ARC9.FormatViewModelAttachment

function EFFECT:Init(data)
    local att = data:GetAttachment()
    local ent = data:GetEntity()

    if !IsValid(ent) then self:Remove() return end
    local owner, lp = ent:GetOwner(), LocalPlayer()
    if owner != lp then self:Remove() return end
    if !IsValid(owner) then self:Remove() return end

    if owner != lp or lp:ShouldDrawLocalPlayer() then
        mdl = (ent.WModel or {})[1] or ent
        self.VMContext = false
    else
        mdl = lp:GetViewModel()

        if ent:ShouldTPIK() then
            self.VMContext = false
        else
            table.insert(ent.ActiveEffects, self)
        end
    end

    if !IsValid(ent) then self:Remove() return end
    if !mdl or !IsValid(mdl) then self:Remove() return end
    if !mdl:GetAttachment(att) then self:Remove() return end

    local origin, ang = mdl:GetAttachment(att).Pos, mdl:GetAttachment(att).Ang

    if (lp:ShouldDrawLocalPlayer() or owner != lp) then
        wm = true
        self.VMContext = false
    end
    
    local model = ent:GetProcessedValue("DropMagazineModel", true)
    local skinn = ent:GetProcessedValue("DropMagazineSkin", true)
    local sounds = ent:GetProcessedValue("DropMagazineSounds", true)

    local dir = ang:Forward()

    local correctpos = ent:GetProcessedValue("DropMagazinePos", true) or vector_origin
    local correctang = ent:GetProcessedValue("DropMagazineAng", true) or angle_zero
    ang:RotateAroundAxis(ang:Forward(), correctang.p)
    ang:RotateAroundAxis(ang:Right(), 90 + correctang.y)
    ang:RotateAroundAxis(ang:Up(), 90 + correctang.r)

    origin:Add(ang:Right() * correctpos.x)
    origin:Add(ang:Up() * correctpos.y)
    origin:Add(ang:Forward() * correctpos.z)

    if self.VMContext then origin = FormatViewModelAttachment(origin, false) end
    self:SetPos(origin)
    self:SetModel(model or "")
    self:SetSkin(skinn)
    self:DrawShadow(true)
    self:SetAngles(ang)

    if self.VMContext then self:SetNoDraw(true) end

    self.Sounds = sounds or ARC9.ShellSoundsTable

    -- self:SetSolid( SOLID_BBOX )
    -- self:SetMoveType( MOVETYPE_VPHYSICS )
    self:PhysicsInit(SOLID_VPHYSICS)
    -- local physbox = ent:GetProcessedValue("ShellPhysBox")

    -- local pb_z = physbox.z
    -- local pb_y = physbox.y
    -- local pb_x = physbox.x

    -- -- local mag = 150

    -- self:PhysicsInitBox(Vector(-pb_z,-pb_y,-pb_x), Vector(pb_z,pb_x,pb_y))

    -- self:SetCollisionGroup(COLLISION_GROUP_DEBRIS)

    local phys = self:GetPhysicsObject()
    if !IsValid(phys) then self:Remove() return end
    phys:Wake()

    local plyvel = owner:GetAbsVelocity() * 1.1

    -- phys:SetDamping(0, 0)
    -- phys:SetMass(1)
    phys:SetMaterial("gmod_silent")
    -- phys:SetMaterial("default_silent")

    local velocity = ent:GetProcessedValue("DropMagazineVelocity", true) or Vector(0, 0, 0)

    -- phys:SetVelocity((dir * mag * velocity) + plyvel)
    dir:Add(ang:Right() * velocity.x)
    dir:Add(ang:Up() * velocity.y)
    dir:Add(ang:Forward() * velocity.z)

    phys:SetVelocity(dir + plyvel)

    phys:AddAngleVelocity(VectorRand() * 10)
    -- phys:AddAngleVelocity(ang:Up() * 2500 * velocity/0.75)

    self.SpawnTime = CurTime()
    self.LifeTime = self.LifeTime + arc9_eject_time:GetFloat()

    self.weapon = ent -- for camos
end

function EFFECT:PhysicsCollide()
    if self.AlreadyPlayedSound then return end
    self:StopSound("Default.ImpactHard")

    self.VMContext = false
    self:SetNoDraw(false)

    local snd = self.Sounds[math.random(#self.Sounds)]
    if snd then sound.Play(snd, self:GetPos(), 75, 100, 1) end

    self.AlreadyPlayedSound = true
end

function EFFECT:Think()
    local vel = self:GetVelocity():Length()
    if vel > 20 then self.SpawnTime = CurTime() end
    if vel < 5 and self.VMContext then self.VMContext = false self:SetNoDraw(false) end

    self:StopSound("Default.ScrapeRough")

    if (self.SpawnTime + self.LifeTime) <= CurTime() then
        if !IsValid(self) then return end
        self:SetRenderFX( kRenderFxFadeFast )
        if (self.SpawnTime + self.LifeTime + 0.25) <= CurTime() then
            if !IsValid(self:GetPhysicsObject()) then return end
            self:GetPhysicsObject():EnableMotion(false)
            if (self.SpawnTime + self.LifeTime + 0.5) <= CurTime() then
                self:Remove()
                return
            end
        end
    end
    return true
end

function EFFECT:Render()
    if !IsValid(self) then return end
    self:DrawModel()
end

function EFFECT:DrawTranslucent()
    self:DrawModel()
end