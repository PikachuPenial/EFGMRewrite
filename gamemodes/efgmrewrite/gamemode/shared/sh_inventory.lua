-- https://www.youtube.com/watch?v=Iv3F5ARdu58
-- code below is deprecated but is needed for the meantime to make deaths function

local plyMeta = FindMetaTable("Player")
if not plyMeta then Error("Could not find player table") return end

if SERVER then
    -- create inventory on connect
    function plyMeta:CreateInventory()
        self.inv = {}

        self.inv.containers = {}

        self.inv.containers.primary = nil
        self.inv.containers.secondary = nil
        self.inv.containers.holster = nil
        self.inv.containers.melee = nil

        self.inv.containers.backpack = {}
    end

    hook.Add("PlayerInitialSpawn", "CreatePlayerInventory", function(ply) ply:CreateInventory() end)
end

-- OLD SHIT
INV = {}

function INV.New()
    local inv = {}

    inv.contents = {} -- items within

    function inv:Add(name, type, count)
        local key = table.insert(self.contents, {})

        self.contents[key].name = name
        self.contents[key].type = type
        self.contents[key].count = count or 1
    end

    function inv:Remove(name, count)
        -- todo
        return false
    end

    return inv
end

GiveItem = {}

GiveItem[1] = function(ply, item, count, noReserveAmmo) -- weapons
    ply:Give(item, noReserveAmmo)
end

GiveItem[2] = function(ply, item, count, noReserveAmmo) -- ammo
    ply:GiveAmmo(count or 1, item, true)
end

GiveItem[3] = function(ply, item, count, noReserveAmmo) -- attatchment
    ARC9:PlayerGiveAtt(ply, item, count or 1)
end
