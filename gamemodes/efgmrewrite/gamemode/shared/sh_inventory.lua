-- file handles inventory systems (inventories, related functions, item creation and manipulation, sql integration, etc)
-- eventually this'll make the shop and stash system very easy to implement

local plyMeta = FindMetaTable( "Player" )
if not plyMeta then Error("Could not find player table") return end

INV = {}

function INV.__call( self, minCount ) -- __call just means doing just "INV(args)" would run this function

    local inventory = {}

    inventory.contents = {}
    inventory.minCount = minCount or 1

    function inventory:AddItem(item, type, count)

        self.contents[item] = {}

        self.contents[item].count = count
        self.contents[item].type = type

    end

    function inventory:EditCount(item, count)

        if self.contents[item] == nil then return end

        count = count or 0

        if count < self.minCount then self:RemoveItem(item) return end

        self.contents[item].count = count
        
    end

    return inventory

end

function INV.SQLToInventory(sqlData)

    local inventory = INV()

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