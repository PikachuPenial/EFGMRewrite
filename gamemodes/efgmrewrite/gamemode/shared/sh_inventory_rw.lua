-- file handles inventory systems (inventories, related functions, item creation and manipulation, sql integration, etc)
-- eventually this'll make the shop and stash system very easy to implement

local plyMeta = FindMetaTable( "Player" )
if not plyMeta then Error("Could not find player table") return end

INVG = {} -- will be renamed to INV once the new system deprecates the old one

-- just now realizing this entire structure isnt gonna work with the grid system :soggy:

function INVG:__call() -- __call just means doing just "INV(args)" would run this function

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

    function inventory:FindOpenSlot()

        for k, v in pairs(self.contents) do
            
            if v.pos == pos then return k, v.type, v.count end

        end

        return nil

    end

    return inventory

end

-- SQLData: LocationInformation INTEGER, Name TEXT, Count INTEGER, Type INTEGER, Owner INTEGER
function INVG.SQLToInventory(sqlData)

    -- deprecated, TODO later

end

setmetatable(INV, INV)

if SERVER then

    function plyMeta:GetInventory(blacklist)
    
        blacklist = blacklist or {}
    
        -- blacklist is just a lookup table basically
    
        local inventory = INVG()
    
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

        return inventory
    
    end

    function plyMeta:GiveInventory(inventory)

        -- TODO: add support for the grid

        if inventory == nil then return nil end

        local remainingInventory = INVG()

        for k, v in pairs(inventory.contents) do

            if self:HasWeapon(k) && v.type == 1 then

                remainingInventory:AddItem(k, 1, 1)

            else

                GiveItem[v.type](self, k, v.count)
                
            end

        end

        if table.IsEmpty( remainingInventory.contents ) then return nil end

        return remainingInventory

    end
    
end

function INVG.LocationInformationTOPos( locationInformation )

    -- handles overflows
    if locationInformation > 4294967295 then return nil end

    -- yeah this fuckery actually works im suprised too
    local pos = {}

    pos.y = bit.rshift( bit.band( locationInformation, 4294901760 ), 16 ) + 1 -- evil floating point bit level hacking
    pos.x = bit.band( locationInformation, 32767 ) + 1 -- what the fuck?
    pos.as = bit.rshift( bit.band( locationInformation, 32768 ), 15)

    return pos

end
concommand.Add("efgm_debug_loctopos", function(ply, cmd, args)

    local loadoutInformation = tonumber( args[1] )

    print("Input:")
    print( loadoutInformation )
    print("Output")
    PrintTable( INVG.LocationInformationTOPos( loadoutInformation ) or {"You broke it"} )

end)

function INVG.PosTOLocationInformation( pos )

    -- these handle overflows
    if pos.x > 32767 then return nil end
    if pos.y > 65535 then return nil end
    if pos.as > 1 then return nil end

    local locationInformation = (pos.x - 1) + ((pos.y - 1) * 65536) + (pos.as * 32768)

    return locationInformation

end
concommand.Add("efgm_debug_postoloc", function(ply, cmd, args)

    local pos = {}
    pos.x = tonumber( args[1] )
    pos.y = tonumber( args[2] )
    pos.as = tonumber( args[3] or 0 )

    print("Input:")
    PrintTable( pos )
    print("Output")
    print( INVG.PosTOLocationInformation( pos ) or -1 )

end)