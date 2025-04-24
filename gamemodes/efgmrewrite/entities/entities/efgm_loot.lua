ENT.Type = "point"
ENT.Base = "base_point"

-- vars

ENT.SpawnChance = 100 -- this used a 1-5 range earlier? what the fuck? why not just use 1-100 lmao
ENT.LootType = 0
ENT.LootTier = 0

-- flags

ENT.SpawnOnStart = false
ENT.Crated = true

ENT.HasValidType = true

function ENT:KeyValue(key, value)
	if key == "spawn_chance" then
		self.SpawnChance = tonumber(value)
	end

	if key == "loot_type" then
		self.LootType = tonumber(value)
	end

	if key == "loot_tier" then
		self.LootTier = tonumber(value)
	end
end

function ENT:Initialize()
    if self.LootTier == 0 then self.LootTier = math.random(1, 3) end
    if self.LootType != 1 and self.LootType != 3 and self.LootType != 5 then -- placeholder until loot tables for other types are complete and until there is a reason to have literally anything other than guns
        self.HasValidType = false
        return
    end

	local flags = tonumber(self:GetSpawnFlags())

	self.SpawnOnStart = bit.band(flags, 1) == 1
	self.Crated = bit.band(flags, 2) == 2

    if self.SpawnOnStart then self:SpawnItem(self:SelectItem()) end
end

function ENT:SelectItem()
    if self.SpawnChance > math.random(0, 100) then return nil end

    local lootTable = LOOT[self.LootType]

    local tbl = {}

    for k, v in pairs(lootTable) do
        if v[1] == self.LootTier or v[1] == 0 then table.insert(tbl, k) end
    end

    if table.IsEmpty(tbl) then print("loot table " .. self.LootType .. " is empty you fucking idiot") return nil end

    local ent = ents.Create(tbl[math.random(#tbl)])

    print("Spawning " .. tostring(ent))
    return ent
end

function ENT:SpawnItem( item )
    if item == nil then return end

    item:SetPos(self:GetPos())
    item:SetAngles(self:GetAngles())

    item:Spawn()
    item:PhysWake()

	self:TriggerOutput("OnSpawn", nil, nil)
end

function ENT:AcceptInput(name, activator, caller, data)
	if name == "SpawnLoot" && self.HasValidType then
        local item = self:SelectItem()
		self:SpawnItem(item)
	end
end