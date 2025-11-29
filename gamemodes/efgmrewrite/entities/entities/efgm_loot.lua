ENT.Type = "point"
ENT.Base = "base_point"

-- vars

ENT.SpawnChance = 100
ENT.ItemChancePerRoll = 10
ENT.LootType = 1
ENT.ContainerLoot = {}
ENT.ContainerName = ""

-- flags

ENT.SpawnOnStart = false
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

        chance = chance - self.ItemChancePerRoll

        local itemVal, itemKey = table.Random(LOOT[self.LootType])
        local def = EFGMITEMS[itemKey]

        local data = {}
        data.count = math.Clamp(math.random(math.Round(def.stackSize / 6), def.stackSize), 1, def.stackSize)

        if def.equipType == EQUIPTYPE.Consumable then

            data.durability = math.Clamp(math.random(math.Round(def.consumableValue / 4), def.consumableValue), 1, def.consumableValue)

        end

        if def.equipType == EQUIPTYPE.Weapon and def.defAtts then

            data.att = def.defAtts

        end

        local item = ITEM.Instantiate(itemKey, def.equipType, data)
        table.insert(containerLoot, item)

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
	container:SetContainerData(self.ContainerLoot, self.ContainerName)
    if self.LootType >= 1 and self.LootType <= 6 then container:SetSkin(self.LootType - 1) end

    self:TriggerOutput("OnSpawn", nil, nil)

end

function ENT:AcceptInput(name, activator, caller, data)

	if name == "SpawnLoot" && self.HasValidType then

        local items = self:SelectItems()
        if items == nil then return end
		self:SpawnContainer(items)

	end

end