ENT.Type = "point"
ENT.Base = "base_point"

-- vars

ENT.SpawnChance = 100 -- this used a 1-5 range earlier? what the fuck? why not just use 1-100 lmao
ENT.LootType = 0
ENT.LootTier = 0

-- flags

ENT.SpawnOnStart = false
ENT.Crated = true

ENT.StoredItem = nil -- will be generated when the server starts (provided i dont add loot respawning) so it only has to spawn it on crate break / loot spawn

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

	local flags = tonumber( self:GetSpawnFlags() )

	self.SpawnOnStart = bit.band(flags, 1) == 1

	self.Crated = bit.band(flags, 2) == 2

    local rand = math.random(0, 100)
    if self.SpawnChance > rand then return end

    if self.LootTier == 0 then self.LootTier = math.random(1, 3) end
    if self.LootType != 1 and self.LootType != 3 and self.LootType != 5 then return end -- placeholder until loot tables for other types are complete and until there is a reason to have litearlly anything other than guns
    -- if self.LootType == 0 then self.LootType = math.random(1, 5) end

    self.StoredItem = self:SelectItem() -- sets self.StoredItem to the entity of the weapon / item stored

    if self.SpawnOnStart then self:SpawnItem() end

end

function ENT:SelectItem()

    local lootTable = LOOT[self.LootType] -- LOOT[self.LootType] when i make this shit work

    local tbl = {}

    for k, v in pairs(lootTable) do

        if v[1] == self.LootTier or v[1] == 0 then table.insert(tbl, k) end

    end

    if table.IsEmpty( tbl ) then print("loot table " .. self.LootType .. " is empty you fucking idiot") return nil end

    local ent = ents.Create( tbl[ math.random(#tbl) ] )

    print("Spawning " .. tostring(ent))
    return ent

end

function ENT:SpawnItem()

    if self.StoredItem == nil then print("Loot entity failed to spawn item!") return end

    self.StoredItem:SetPos(self:GetPos())
    self.StoredItem:SetAngles(self:GetAngles())

    self.StoredItem:Spawn()
    self.StoredItem:PhysWake()

	self:TriggerOutput("OnSpawn", nil, nil)

end

function ENT:AcceptInput(name, activator, caller, data)
	if name == "SpawnLoot" then
		self:SpawnItem()
	end
end