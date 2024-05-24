-- self explanitory
if CLIENT then
    CreateClientConVar("efgm_bind_raidinfo", KEY_O, true, true, "Determines the keybind that will display available extracts and time remaining in the raid")
    CreateClientConVar("efgm_bind_leanleft", KEY_Q, true, true, "Determines the keybind that will begin a left lean")
    CreateClientConVar("efgm_bind_leanright", KEY_E, true, true, "Determines the keybind that will begin a right lean")
    CreateClientConVar("efgm_bind_freelook", MOUSE_MIDDLE, true, true, "Determines the keybind that will begin a free look")
end

hook.Add("PlayerButtonDown", "EFGMBinds", function(ply, button)

    if SERVER then
        -- raid information
        if button == ply:GetInfoNum("efgm_bind_raidinfo", KEY_O) then
            local raidTime = GetGlobalInt("RaidTimeLeft", -1)
            local raidStatus = GetGlobalInt("RaidStatus", 0)

            -- net.Start("ShowRaidInfo")
            -- net.WriteInt(raidTime)
            -- net.WriteInt(raidStatus)
            -- net.Send(ply)
        end
    end

    if CLIENT then
        if button == ply:GetInfoNum("efgm_bind_leanleft", KEY_Q) then
            ply:ConCommand("+alt1")

            hook.Add("PlayerButtonUp", "LeanLeftRelease", function(ply, button)
                if button == ply:GetInfoNum("efgm_bind_leanleft", KEY_Q) then
                    ply:ConCommand("-alt1")
                end
            end)
        end

        if button == ply:GetInfoNum("efgm_bind_leanright", KEY_E) then
            ply:ConCommand("+alt2")

            hook.Add("PlayerButtonUp", "LeanRightRelease", function(ply, button)
                if button == ply:GetInfoNum("efgm_bind_leanright", KEY_E) then
                    ply:ConCommand("-alt2")
                end
            end)
        end

        if button == ply:GetInfoNum("efgm_bind_freelook", MOUSE_MIDDLE) then
            ply:ConCommand("+freelook")

            hook.Add("PlayerButtonUp", "FreeLookRelease", function(ply, button)
                if button == ply:GetInfoNum("efgm_bind_freelook", MOUSE_MIDDLE) then
                    ply:ConCommand("-freelook")
                end
            end)
        end
    end

end)

-- client sided keybinds do not work in singleplayer, rewriting multiplayer based keybindings to work when playing in a singleplayer instance
if game.SinglePlayer() then

    hook.Remove("PlayerButtonDown", "EFGMBinds")
    hook.Add("PlayerButtonDown", "EFGMBindsSP", function(ply, button)

        if SERVER then
            -- raid information
            if button == ply:GetInfoNum("efgm_bind_raidinfo", KEY_O) then
                local raidTime = GetGlobalInt("RaidTimeLeft", -1)
                local raidStatus = GetGlobalInt("RaidStatus", 0)

                -- net.Start("ShowRaidInfo")
                -- net.WriteInt(raidTime)
                -- net.WriteInt(raidStatus)
                -- net.Send(ply)
            end

            if button == ply:GetInfoNum("efgm_bind_leanleft", KEY_Q) then
                ply:ConCommand("+alt1")

                hook.Add("PlayerButtonUp", "LeanLeftRelease", function(ply, button)
                    if button == ply:GetInfoNum("efgm_bind_leanleft", KEY_Q) then
                        ply:ConCommand("-alt1")
                    end
                end)
            end

            if button == ply:GetInfoNum("efgm_bind_leanright", KEY_E) then
                ply:ConCommand("+alt2")

                hook.Add("PlayerButtonUp", "LeanRightRelease", function(ply, button)
                    if button == ply:GetInfoNum("efgm_bind_leanright", KEY_E) then
                        ply:ConCommand("-alt2")
                    end
                end)
            end

            if button == ply:GetInfoNum("efgm_bind_freelook", MOUSE_MIDDLE) then
                ply:ConCommand("+freelook")

                hook.Add("PlayerButtonUp", "FreeLookRelease", function(ply, button)
                    if button == ply:GetInfoNum("efgm_bind_freelook", MOUSE_MIDDLE) then
                        ply:ConCommand("-freelook")
                    end
                end)
            end
        end

    end)

end