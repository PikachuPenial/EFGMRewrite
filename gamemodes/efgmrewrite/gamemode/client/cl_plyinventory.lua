-- shit here

local inventory = {}

activeSlots = {}

concommand.Add("efgm_inventory_print", function(ply, cmd, args)

    PrintTable(inventory)

end)

concommand.Add("efgm_inventory_update", function(ply, cmd, args)

    net.Start("RequestBackpack")
    net.SendToServer()

end)

concommand.Add("efgm_inventory_move", function(ply, cmd, args)
    
    local oldPos = args[1]
    local newPos = args[2]
    local count = tonumber( args[3] or 1 )

    net.Start("MoveBackpackItem")
        net.WriteString(oldPos)
        net.WriteString(newPos)
        net.WriteUInt(count, 32)
    net.SendToServer()

end)

concommand.Add("efgm_inventory_drop", function(ply, cmd, args)
    
    local pos = args[1]
    local count = tonumber( args[2] or 1 )

    net.Start("DropBackpackItem")
        net.WriteString(pos)
        net.WriteUInt(count, 32)
    net.SendToServer()

end)

concommand.Add("efgm_inventory_printactiveslots", function(ply, cmd, args)

    PrintTable( activeSlots )

end)

net.Receive("UpdateBackpack", function(len, ply)

    inventory = net.ReadTable()

end)

-- wip
hook.Add("Think", "CheckButtonPresses", function()

    if !isInventoryTesting then return end
    if table.IsEmpty( activeSlots ) then return end
    if LocalPlayer() == nil then return end

    -- todo: find a better way to do this (to put it another way, have fun penial)

    for k, v in pairs( activeSlots ) do
        if !ply:HasWeapon( tostring( v ) ) then
            activeSlots[k] = nil
        end
    end

    for k, v in pairs( activeSlots ) do
        
        if input.IsKeyDown( k ) && ply:HasWeapon( tostring( v ) ) then

            input.SelectWeapon( LocalPlayer():GetWeapon( v ) )
            print("Selecting "..v)

            return

        end

    end

end)

hook.Add("HUDWeaponPickedUp", "WeaponPickedUp", function( weapon )

    local name = weapon:GetClass()

    if flippedDebugPrimWep[name] != nil then

        if activeSlots[KEY_1] == nil then activeSlots[KEY_1] = name return false
        elseif activeSlots[KEY_2] == nil then activeSlots[KEY_2] = name return false
        else return false end

    end

    if flippedDebugSecWep[name] != nil then

        if activeSlots[KEY_3] == nil then activeSlots[KEY_3] = name return false
        else return false end

    end

    if flippedDebugNadeWep[name] != nil then

        if activeSlots[KEY_G] == nil then activeSlots[KEY_G] = name return false
        else return false end

    end

    if flippedDebugMeleeWep[name] != nil then

        if activeSlots[KEY_V] == nil then activeSlots[KEY_V] = name return false
        else return false end

    end

    return false

end)

concommand.Add("efgm_inventory_swapprimaries", function(ply, cmd, args)
    
    local primary1 = activeSlots[KEY_1]
    local primary2 = activeSlots[KEY_2]

    activeSlots[KEY_2] = primary1
    activeSlots[KEY_1] = primary2

end)