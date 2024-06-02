-- shit here

local inventory = {}
local primary, secondary, pistol, utility, knife = "", "", "", "", ""

concommand.Add("efgm_inventory_print", function(ply, cmd, args)

    PrintTable(inventory)

end)

concommand.Add("efgm_inventory_update", function(ply, cmd, args)

    net.Start("RequestPlayerInventory")
    net.SendToServer()

end)

concommand.Add("efgm_inventory_move", function(ply, cmd, args)
    
    local oldPos = args[1]
    local newPos = args[2]
    local count = tonumber( args[3] or 1 )

    net.Start("MovePlayerInventory")
        net.WriteString(oldPos)
        net.WriteString(newPos)
        net.WriteUInt(count, 32)
    net.SendToServer()

end)

concommand.Add("efgm_inventory_drop", function(ply, cmd, args)
    
    local pos = args[1]
    local count = tonumber( args[2] or 1 )

    net.Start("DropPlayerInventory")
        net.WriteString(pos)
        net.WriteUInt(count, 32)
    net.SendToServer()

end)

net.Receive("UpdatePlayerInventory", function(len, ply)

    inventory = net.ReadTable()

end)

-- wip
-- hook.Add("Think", "CheckButtonPresses", function()

--     if input.IsKeyDown( KEY_1 ) && ply:HasWeapon( primary ) then
--         input.SelectWeapon( primary )
--     end

--     if input.IsKeyDown( KEY_2 ) && ply:HasWeapon( secondary ) then
--         input.SelectWeapon( secondary )
--     end

--     if input.IsKeyDown( KEY_3 ) && ply:HasWeapon( pistol ) then
--         input.SelectWeapon( pistol )
--     end

--     if input.IsKeyDown( KEY_G ) && ply:HasWeapon( utility ) then
--         input.SelectWeapon( utility )
--     end

--     if input.IsKeyDown( KEY_V ) && ply:HasWeapon( knife ) then
--         input.SelectWeapon( knife )
--     end

-- end)


hook.Add("HUDWeaponPickedUp", "WeaponPickedUp", function( weapon )

    -- local name = weapon:GetClass()
    -- print(name)

    -- if primary == "" then

    --     primary = name

    -- elseif secondary == "" then
        
    --     secondary = name

    -- else

    --     print("I fucked something up")
        
    -- end

    return false

end)