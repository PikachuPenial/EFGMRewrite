ENT.Type = "point"
ENT.Base = "base_point"

-- These are defined by the entity in hammer

ENT.SpawnType = 0 -- 0 = any, 1 = pmc, 2 = scav
ENT.SpawnGroup = ""
ENT.SpawnName = ""

function ENT:KeyValue(key, value)

    if key == "spawn_type" then
        self.SpawnType = tonumber(value)
    end

    if key == "spawn_group" then
        self.SpawnGroup = value
        print("Setting SpawnGroup to "..self.SpawnGroup)
    end

    if key == "targetname" then
        self.SpawnName = value
    end

end

function ENT:GetAllSpawns()

    local spawns = ents.FindByName( self.SpawnName )

    table.insert(spawns, self)

    return spawns

end