-- self explanitory
if CLIENT then
    CreateClientConVar("efgm_bind_raidinfo", KEY_O, true, true, "Determines the keybind that will display available extracts and time remaining in the raid")
    CreateClientConVar("efgm_bind_leanleft", KEY_Q, true, true, "Determines the keybind that will begin a left lean")
    CreateClientConVar("efgm_bind_leanright", KEY_E, true, true, "Determines the keybind that will begin a right lean")
    CreateClientConVar("efgm_bind_freelook", MOUSE_MIDDLE, true, true, "Determines the keybind that will begin a free look")
    CreateClientConVar("efgm_bind_changesight", MOUSE_MIDDLE, true, true, "Determines the keybind that adjust the zoom/reticle of your weapons sight")
end

hook.Add("PlayerButtonDown", "EFGMBinds", function(ply, button)

    if CLIENT then

        -- raid information
        if button == ply:GetInfoNum("efgm_bind_raidinfo", KEY_O) then
            ply:ConCommand("efgm_print_extracts")
        end

        -- switching sights
        if button == ply:GetInfoNum("efgm_bind_changesight", MOUSE_MIDDLE) then
            ply:ConCommand("+arc9_switchsights")
        end

        -- free looking
        if button == ply:GetInfoNum("efgm_bind_freelook", MOUSE_MIDDLE) then
            ply:ConCommand("+freelook")
        end

    end

end)

hook.Add("PlayerButtonUp", "EFGMBindsUp", function(ply, button)

    if CLIENT then

        -- switching sights
        if button == ply:GetInfoNum("efgm_bind_changesight", MOUSE_MIDDLE) then
            ply:ConCommand("-arc9_switchsights")
        end

        -- free looking
        if button == ply:GetInfoNum("efgm_bind_freelook", MOUSE_MIDDLE) then
            ply:ConCommand("-freelook")
        end

    end

end)

-- client sided keybinds do not work in singleplayer, rewriting multiplayer based keybindings to work when playing in a singleplayer instance
if game.SinglePlayer() then

    hook.Remove("PlayerButtonDown", "EFGMBinds")
    hook.Remove("PlayerButtonUp", "EFGMBindsUp")
    hook.Add("PlayerButtonDown", "EFGMBindsSP", function(ply, button)

        if SERVER then

            -- raid information
            if button == ply:GetInfoNum("efgm_bind_raidinfo", KEY_O) then
                ply:ConCommand("efgm_print_extracts")
            end

            -- switching sights
            if button == ply:GetInfoNum("efgm_bind_changesight", MOUSE_MIDDLE) then
                ply:ConCommand("+arc9_switchsights")
            end

            -- free looking
            if button == ply:GetInfoNum("efgm_bind_freelook", MOUSE_MIDDLE) then
                ply:ConCommand("+freelook")
            end

        end

    end)

    hook.Add("PlayerButtonUp", "EFGMBindsUp", function(ply, button)

        -- switching sights
        if button == ply:GetInfoNum("efgm_bind_changesight", MOUSE_MIDDLE) then
            ply:ConCommand("-arc9_switchsights")
        end

        -- free looking
        if button == ply:GetInfoNum("efgm_bind_freelook", MOUSE_MIDDLE) then
            ply:ConCommand("-freelook")
        end

    end)

end