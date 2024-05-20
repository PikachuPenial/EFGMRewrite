-- file handles inventory systems (inventories, related functions, item creation and manipulation, sql integration, etc)
-- eventually this'll make the shop and stash system very easy to implement

local plyMeta = FindMetaTable( "Player" )
if not plyMeta then Error("Could not find player table") return end

INVRW = {} -- will be renamed to INV once the new system deprecates the old one

function INVRW:__call() -- __call just means doing just "INV(args)" would run this function

    local inventory = {}

    inventory.contents = {}

    function inventory:Add(item, type, count, pos)

        self.contents[item] = {}

        self.contents[item].count = count
        self.contents[item].type = type
        self.contents[item].pos = pos

    end

    function inventory:EditCount(item, count, pos)

        if self.contents[item] == nil then return end

        count = count or 0

        if count < 1 then self:RemoveItem(item) return end

        self.contents[item].count = count
        
    end

    function inventory:Move(oldPos, newPos)

        local item, type, count = inventory:CheckSlot(oldPos)
        
        if inventory:CheckSlot(newPos) != nil then return end

        if item != nil then
            
            inventory:EditCount(item, 0, oldPos)
            inventory:Add(k, v.type, v.count, newPos)

        end

    end

    function inventory:CheckSlot(pos)

        for k, v in pairs(self.contents) do
            
            if v.pos == pos then return k, v.type, v.count end

        end

        return nil

    end

    return inventory

end

-- SQLData: LocationInformation INTEGER, Name TEXT, Count INTEGER, Type INTEGER, Owner INTEGER
function INVRW.SQLToInventory(sqlData)

    local inventory = INVRW()

    for k, v in pairs( sqlData ) do

        inventory:AddItem(v.ItemName, tonumber( v.ItemType ), tonumber( v.ItemCount ))
        
    end

    return inventory

end

setmetatable(INV, INV)

if SERVER then

    function plyMeta:GetInventory(blacklist)
    
        blacklist = blacklist or {}
    
        -- blacklist is just a lookup table basically
    
        local inventory = INV()
    
        for k, v in pairs(self:GetWeapons()) do
    
            local wep = v:GetClass()
    
            if blacklist[wep] != true then
    
                inventory:AddItem(wep, 1, 1)
                
            end
            
        end
    
        for k, v in pairs(self:GetAmmo()) do
    
            if blacklist[game.GetAmmoName(k)] != true then
    
                inventory:AddItem(game.GetAmmoName(k), 2, v)
    
            end
            
        end

        if table.IsEmpty( inventory.contents ) then return nil end

        -- print("Getting inventory of " .. self:GetName())
        -- PrintTable(inventory.contents)

        return inventory
    
    end

    function plyMeta:GiveInventory(inventory)

        if inventory == nil then return nil end

        local remainingInventory = INV()

        for k, v in pairs(inventory.contents) do

            -- print(k..":")
            -- PrintTable(v)
            
            if self:HasWeapon(k) && v.type == 1 then

                remainingInventory:AddItem(k, 1, 1)

            else

                GiveItem[v.type](self, k, v.count)
                
            end

        end

        if table.IsEmpty( remainingInventory.contents ) then return nil end

        -- print("Giving inventory to " .. self:GetName())
        -- PrintTable(remainingInventory.contents)

        return remainingInventory

    end
    
end