
function CompareTable( input, expected )

    local jsonInput = util.TableToJSON( input )
    local jsonExpected = util.TableToJSON( expected )

    local areTablesEqual = jsonInput == jsonExpected

    if !areTablesEqual then

        return "Test failed: tables differ!/nTested table:/n ".. jsonInput .." /nExpected table:".. jsonExpected

    end

    return "Test succeeded!"

end

local function TestItems()

    local expectedItem = {}


end

-- todo: finish this shit later

concommand.Add("efgm_test_items", function(ply, cmd, args)
    
    -- ill finish this shit later

    -- local inventory = CONTAINER.NewContainer( 5, 10, 600 )
    -- local weapon = ITEM.CreateItem( "arc9_eft_akm", 1, {} )

    -- inventory:AddItem(weapon, 2, 2)

    -- PrintTable(inventory)
    -- PrintTable(weapon)

    -- local id = CONTAINER.GetSlotID( 2, 2, 5 )
    -- local x, y = CONTAINER.GetCoords( id, 5 )

    -- print( "Slot ID - " .. id )
    -- print( "Slot x - " .. x )
    -- print( "Slot y - " .. y )

end)