ENT.Type = "point"
ENT.Base = "base_point"

-- vars

ENT.SpawnChance = 100
ENT.ItemChancePerRoll = 10
ENT.LootType = 1
ENT.ContainerLoot = {}
ENT.ContainerName = ""
ENT.LinkedContainer = NULL
ENT.WaitingCooldown = false
ENT.CooldownMin = 480
ENT.CooldownMax = 780

-- flags

ENT.SpawnOnStart = false -- currently does nothing idrk why
ENT.HasValidType = true

function ENT:KeyValue(key, value)

	if key == "spawn_chance" then self.SpawnChance = tonumber(value) end

    if key == "item_chance_per_roll" then self.ItemChancePerRoll = tonumber(value) end

	if key == "loot_type" then self.LootType = tonumber(value) end

end

function ENT:Initialize()

    -- failsafe for unsupported loot types
    if self.LootType < 1 or self.LootType > 8 then self.LootType = 1 end

    if self.LootType == 1 then self.ContainerName = "ASSORTED BOX"
    elseif self.LootType == 2 then self.ContainerName = "MILITARY BOX"
    elseif self.LootType == 3 then self.ContainerName = "AMMUNITION BOX"
    elseif self.LootType == 4 then self.ContainerName = "MEDICAL BOX"
    elseif self.LootType == 5 then self.ContainerName = "BARTER BOX"
    elseif self.LootType == 6 then self.ContainerName = "ATTACHMENT BOX"
    elseif self.LootType == 7 then self.ContainerName = "SAFE" 
    elseif self.LootType == 8 then self.ContainerName = "FILING CABINET" end

	local flags = tonumber(self:GetSpawnFlags())

	self.SpawnOnStart = bit.band(flags, 1) == 1

end

function ENT:SelectItems()

    if self.SpawnChance < math.random(0, 100) then return nil end
    if table.IsEmpty(LOOT[self.LootType]) then print("loot table " .. self.LootType .. " is empty you fucking idiot") return nil end

    local containerLoot = {}
    local chance = 100
    local chanceRand = math.random(0, 100)

    while chance >= chanceRand do

        local itemVal, itemKey = table.Random(LOOT[self.LootType])
        local def = EFGMITEMS[itemKey]

        local itemChance = def.lootWeight or 100
        if itemChance < 100 and itemChance < math.random(0, 100) then continue end -- bad roll, replace with new item

        chance = chance - self.ItemChancePerRoll

        local data = {}
        data.count = math.Clamp(math.random(math.Round(def.stackSize / 6), def.stackSize), 1, def.stackSize)

        if def.consumableType == "heal" then

            data.durability = math.Clamp(math.random(math.Round(def.consumableValue / 4), def.consumableValue), 1, def.consumableValue)

        end

        if def.consumableType == "key" then

            data.durability = def.consumableValue

        end

        if def.equipType == EQUIPTYPE.Weapon and def.defAtts then

            data.att = def.defAtts

        end

        local item = ITEM.Instantiate(itemKey, def.equipType, data)
        table.insert(containerLoot, item)

        if def.ammoID then

            local ammoDef = EFGMITEMS[def.ammoID]

            local ammoData = {}
            ammoData.count = math.Clamp(math.random(math.Round(ammoDef.stackSize / 6), ammoDef.stackSize / 2), 1, ammoDef.stackSize / 2)

            local ammoItem = ITEM.Instantiate(def.ammoID, ammoDef.equipType, ammoData)
            table.insert(containerLoot, ammoItem)

        end

    end

    return containerLoot

end

function ENT:SpawnContainer(tbl)

    if tbl == nil or table.IsEmpty(tbl) then return end
    self.ContainerLoot = tbl

    local containerType = "efgm_container"
    if self.LootType == 7 then containerType = "efgm_safe" end
    if self.LootType == 8 then containerType = "efgm_filing_cabinet" end

    local container = ents.Create(containerType)
	container:SetPos(self:GetPos())
    container:SetAngles(self:GetAngles())
	container:Spawn()
	container:Activate()
    container:SetLinkedEnt(self)
	container:SetContainerData(self.ContainerLoot, self.ContainerName)
    self.LinkedContainer = container
    if self.LootType >= 1 and self.LootType <= 6 then container:SetSkin(self.LootType - 1) end

    self:TriggerOutput("OnSpawn", nil, nil)

end

function ENT:BeginLootCooldown()

    if !self.HasValidType then return end

    if self.WaitingCooldown == true then return end

    self.WaitingCooldown = true

    timer.Simple(math.random(self.CooldownMin, self.CooldownMax), function()

        if self.WaitingCooldown == false then return end

        self.WaitingCooldown = false

        local items = self:SelectItems()
        if items == nil then self:BeginLootCooldown() return end

        if self.LinkedContainer != NULL then

            self.LinkedContainer:Remove()

        end

        self:SpawnContainer(items)

    end )

end


function ENT:AcceptInput(name, activator, caller, data)

    if !self.HasValidType then return end

    -- map start
    if name == "SpawnStartLoot" then

        local items = self:SelectItems()
        if items == nil then self:BeginLootCooldown() return end
		self:SpawnContainer(items)

	end

    -- respawn
	if name == "SpawnLoot" then

        if self.LinkedContainer != NULL then

            self.LinkedContainer:Remove()

        end

        self.WaitingCooldown = false

        local items = self:SelectItems()
        if items == nil then self:BeginLootCooldown() return end
		self:SpawnContainer(items)

	end

end