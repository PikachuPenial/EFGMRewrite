
// because the word 'inventory' can be used for both an instance of an inventory and for the system itself,
// which I felt like got confusing, I'm just gonna call the former a 'container' and the latter 'inventory'


CONTAINER = {}

function CONTAINER.NewContainer( sizeX, sizeY, weightLimit )

    if sizeX == nil or sizeX < 1 or sizeX > 100 then return nil end
    if sizeY == nil or sizeY < 1 or sizeY > 100 then return nil end
    weightLimit = weightLimit or math.huge

    local container = {}
    container.contents = {}
    container.metadata = {}
    container.metadata.sizeX = sizeX
    container.metadata.sizeY = sizeY
    container.metadata.weightLimit = weightLimit

    // I think how I'ma do the grid is by having a number ID system, it's hard to explain but like this
    
    // 1  2  3  4  5  6
    // 7  8  9  10 11 12
    // 13 14 15 16 17 18
    // 19 20 21 22 23 24

    // x of 4 and y of 3 = id of 16
    // ID = ((Y - 1) * sizeX) + X

    // X  = ID % sizeX
    // Y  = ((ID - X) / sizeX) + 1

    // this function should add an item to a single slot, and then fill out all the other slots somehow
    function container:AddItem(item, x, y)

        if x > self.metadata.sizeX then return end
        if y > self.metadata.sizeY then return end

        local slotID = CONTAINER.GetSlotID(x, y, self.metadata.sizeX)

        self.contents[slotID] = self.contents[slotID] or item

    end

    function container:RemoveItem(x, y)

        if x > self.metadata.sizeX then return end
        if y > self.metadata.sizeY then return end

        local slotID = CONTAINER.GetSlotID(x, y, self.metadata.sizeX)

        self.contents[slotID] = nil

    end

    return container

end

// helpers

function CONTAINER.GetSlotID(x, y, sizeX)

    return ((y - 1) * sizeX) + x

end

function CONTAINER.GetCoords(ID, sizeX)

    local x = ID % sizeX

    return x, ((ID - x) / sizeX) + 1

end