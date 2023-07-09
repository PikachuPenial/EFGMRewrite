-- file handles inventory systems (inventories, related functions, item creation and manipulation, sql integration, etc)
-- eventually this'll make the shop and stash system very easy to implement

INV = {}

function INV.__call( self, minCount ) -- __call just means doing just "INV" or "INV(args)" would run this function

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
        self.contents[item].tCount = 0
        
    end

    return inventory

end

setmetatable(INV, INV)

print("Doing inventory shat")