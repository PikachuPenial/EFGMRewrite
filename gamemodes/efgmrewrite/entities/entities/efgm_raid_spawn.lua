ENT.Type = "point"
ENT.Base = "base_point"

-- These are defined by the entity in hammer

ENT.SpawnType = 0 -- 0 = any, 1 = pmc, 2 = scav
ENT.SpawnGroup = ""
ENT.SpawnName = ""
ENT.Pending = false -- if someone is intended to spawn there

ENT.Spawns = {}

function ENT:KeyValue(key, value)
    if key == "spawn_type" then
        self.SpawnType = tonumber(value)
    end

    if key == "spawn_group" then
        self.SpawnGroup = value
    end

    if key == "targetname" then
        self.SpawnName = value
    end

end

function ENT:Initialize()

    timer.Simple(1, function() -- gives all the team spawns a chance to initialize first
        for k, v in ipairs( ents.FindByClass("efgm_team_spawn")) do
            if v.MainSpawnName == self.SpawnName then table.insert(self.Spawns, v) end
        end

        table.insert(self.Spawns, self)
    end)
end