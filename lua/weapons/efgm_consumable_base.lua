SWEP.Base = "weapon_base"
SWEP.Category = "Escape From Garry's Mod"
SWEP.Spawnable = false

SWEP.Primary.ClipSize = -1
SWEP.Primary.DefaultClip = -1
SWEP.Primary.Automatic = true
SWEP.Primary.Ammo = "none"

SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = -1
SWEP.Secondary.Automatic = true
SWEP.Secondary.Ammo = "none"

SWEP.ConsumableType = nil       -- type of consumable
SWEP.ConsumableDurability = 100 -- default durability of the consumable, used mostly as a failsafe
SWEP.ConsumableDelay = 1        -- delay between consuming an item and then being able to consume it again
SWEP.ConsumableTime = 1         -- the time it takes to complete item consumption fully, only matters when ticking
SWEP.ConsumableValue = 10       -- the amount of something when an item is consumed, probably health
SWEP.ConsumableTicks = 5        -- how many times a function will be ran when consuming an item, spaces out the value and how its applied
SWEP.ConsumableRange = 64       -- range in units for right clicking another player to apply the item to them
SWEP.DamageCancel = false       -- will stop the effects of item consumption upon taking damage

function SWEP:Initialize()

    self:SetHoldType(self.HoldType or "slam")
    self.Durability = self.ConsumableDurability
    self.Primary.ClipSize = self.ConsumableDurability

end

function SWEP:SetupDataTables()

    self:NetworkVar("Float", 0, "NextIdle")

end

function SWEP:SetDurability(val)

    self.Durability = val
    self:SetClip1(val)

end

function SWEP:UpdateDurability(val)

    local owner = self:GetOwner()

    self.Durability = self.Durability - val
    self:SetClip1(self.Durability)

    if self.Durability > 0 then

        owner.weaponSlots[5][1].data.durability = self.Durability

        net.Start("PlayerInventoryUpdateEquipped", false)
        net.WriteTable(owner.weaponSlots[5][1].data)
        net.WriteUInt(5, 16)
        net.WriteUInt(1, 16)
        net.Send(owner)

    else

        RemoveConsumable(owner)
        timer.Remove("Consume" .. owner:SteamID64())

    end

end

function SWEP:Deploy()

    return true

end

function SWEP:Reload()

    return true

end

function SWEP:Think()

    self:Idle()

end

function SWEP:Idle()

    local curtime = CurTime()

    if (curtime < self:GetNextIdle()) then return false end

    self:SendWeaponAnim(ACT_VM_IDLE)
    self:SetNextIdle(curtime + self:SequenceDuration())

    return true

end

function SWEP:TriggerConsumable(ent, type, ct)

    local owner = self:GetOwner()

    if type == CONSUMABLETYPES.MEDKIT then

        local currentHealth = ent:Health()
        local maxHealth = ent:GetMaxHealth()
        local amount = math.min(maxHealth - currentHealth, self.ConsumableValue)

        if amount <= 0 then

            self:SetNextPrimaryFire(CurTime())
            self:SetNextSecondaryFire(CurTime())
            return

        end

        if self.ConsumableTicks <= 1 then

            ent:SetHealth(amount)
            ent:SetNWInt("HealthHealed", ent:GetNWInt("HealthHealed") + amount)
            ent:SetNWInt("RaidHealthHealed", ent:GetNWInt("RaidHealthHealed") + amount)
            self:UpdateDurability(amount)

        else

            local amountPerTick = self.ConsumableValue / self.ConsumableTicks

            timer.Create("Consume" .. owner:SteamID(), self.ConsumableTime / self.ConsumableTicks, self.ConsumableTicks, function()

                if !self:IsValid() or !ent:IsValid() or !ent:Alive() then timer.Remove("Consume" .. owner:SteamID()) return end

                local tickAmount = math.min(maxHealth - (maxHealth - amountPerTick), maxHealth - ent:Health(), self.Durability)

                ent:SetHealth(ent:Health() + tickAmount)
                ent:SetNWInt("HealthHealed", ent:GetNWInt("HealthHealed") + tickAmount)
                ent:SetNWInt("RaidHealthHealed", ent:GetNWInt("RaidHealthHealed") + tickAmount)

                if ent:Health() < maxHealth then

                    self:UpdateDurability(tickAmount)

                else

                    timer.Remove("Consume" .. owner:SteamID())

                end

            end)

        end

        ent:EmitSound("items/medshot4.wav", 65, math.random(80, 120), 0.5, CHAN_WEAPON)
        ent:ScreenFade(SCREENFADE.IN, Color(0, 255, 0, 2), 0.1, 0)

    end

    self:SendWeaponAnim(ACT_VM_PRIMARYATTACK)

    if owner:IsValid() then owner:SetAnimation(PLAYER_ATTACK1) end

    local animtime = CurTime()
    local endtime = animtime + self:SequenceDuration()

    self:SetNextIdle(endtime)

end

function SWEP:PrimaryAttack()

    self:SetNextPrimaryFire(CurTime() + self.ConsumableDelay)
    self:SetNextSecondaryFire(CurTime() + self.ConsumableDelay)

    if !SERVER then return end

    local owner = self:GetOwner()
    local CT = CurTime()

    self:TriggerConsumable(owner, self.ConsumableType, CT)

end

function SWEP:SecondaryAttack()

    self:SetNextPrimaryFire(CurTime() + self.ConsumableDelay)
    self:SetNextSecondaryFire(CurTime() + self.ConsumableDelay)

    if !SERVER then return end

    local owner = self:GetOwner()
    local CT = CurTime()

    local lagcomp = owner:IsPlayer()

    if lagcomp then owner:LagCompensation(true) end

    local tr = owner:GetEyeTrace()
    local target = tr.Entity

    if lagcomp then owner:LagCompensation(false) end

    if IsValid(target) and target:IsPlayer() and owner:GetPos():DistToSqr(target:GetPos()) < (self.ConsumableRange * self.ConsumableRange) then

        self:TriggerConsumable(target, self.ConsumableType, CT)

    else

        self:SetNextPrimaryFire(CurTime())
        self:SetNextSecondaryFire(CurTime())

    end

end