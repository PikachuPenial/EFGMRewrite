-- Todo: Set up tests for shit like the inventory system, raid system, etc, for easier debugging, better maintainability, idk read this shit https:--www.conformiq.com/resources/blog-the-six-benefits-of-test-driven-development-05-16-2023
-- for now ima just use this to draft inventory stuff with the console

if !SERVER then return end

concommand.Add("efgm_inventory_create", function(ply, cmd, args)
    if table.IsEmpty(args) then
        print("Arguments: Player name, rig, pocket type, backpack, secure container")
        return
    end

    local name = args[1]
    local rig = args[2]
    local pockets = args[3]
    local backpack = args[4]
    local secureContainer = args[5]

    local inventory = {}

    inventory.rig = {}
        inventory.rig.name = rig
        inventory.rig.contents = {}

    inventory.pockets = {}
        inventory.pockets.name = pockets
        inventory.pockets.contents = {}

    inventory.backpack = {}
        inventory.backpack.name = backpack
        inventory.backpack.contents = {}

    inventory.sc = {}
        inventory.sc.name = secureContainer
        inventory.sc.contents = {}

    inventories[name] = inventory

    PrintTable(inventories[name])
end)

concommand.Add("efgm_inventory_additem", function(ply, cmd, args)
    if table.IsEmpty(args) || #args != 7 then
        print("Arguments: Player name, item name, containerType, subcontainerID, positionX, positionY, rotated")
        return
    end

    local name = args[1]
    local itemName = args[2]
    local containerType = args[3]
    local subcontainerID = tonumber(args[4])
    local positionX = tonumber(args[5])
    local positionY = tonumber(args[6])
    local rotated = tonumber(args[7])

    if inventories[name] == nil then
        print("Enter a valid name")
        return
    end

    local inventory = inventories[name]

    local itemInfo = EFGMITEMS[itemName]

    local container = inventory[containerType].name

    local containerInfo = EFGMITEMS[container]

    -- Check whether player actually has the type of container
    if container == nil then print("Player doesn't have (" .. containerType .. ") container!") return end

    -- Check container type
    if inventory[containerType] == nil then print("Container (" .. containerType .. ") doesn't exist!") return end

    -- Check valid subcontainer
    if containerInfo.childContainers[subcontainerID] == nil then print("Subcontainer (" .. subcontainerID .. ") doesn't exist!") return end

    -- Check whether position inside subcontainer is valid
    if positionX < 1 || positionX > containerInfo.childContainers[subcontainerID].sizeX then print("X position of (" .. positionX .. ") is invalid!") return end
    if positionY < 1 || positionY > containerInfo.childContainers[subcontainerID].sizeY then print("Y position of (" .. positionY .. ") is invalid!") return end

    -- Check whether every slot item occupies is free
    -- Add item to contents
end)