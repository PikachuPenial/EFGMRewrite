-- self explanitory (erm actually its explanatory 🤓) (fuck off porty)
if CLIENT then
    CreateClientConVar("efgm_bind_menu", KEY_TAB, true, true, "Determines the keybind that will display the menu")
    CreateClientConVar("efgm_bind_showcompass", KEY_M, true, true, "Determines the keybind that shows the compass")
    CreateClientConVar("efgm_bind_raidinfo", KEY_O, true, true, "Determines the keybind that will display available extracts and time remaining in the raid")
    CreateClientConVar("efgm_bind_leanleft", KEY_Q, true, true, "Determines the keybind that will begin a left lean")
    CreateClientConVar("efgm_bind_leanright", KEY_E, true, true, "Determines the keybind that will begin a right lean")
    CreateClientConVar("efgm_bind_freelook", MOUSE_MIDDLE, true, true, "Determines the keybind that will begin a free look")
    CreateClientConVar("efgm_bind_changesight", MOUSE_MIDDLE, true, true, "Determines the keybind that adjusts the zoom/reticle of your weapons sight")
    CreateClientConVar("efgm_bind_inspectweapon", KEY_I, true, true, "Determines the keybind that inspects your weapon")
    CreateClientConVar("efgm_bind_dropweapon", KEY_MINUS, true, true, "Determines the keybind that drops your held weapon")
    CreateClientConVar("efgm_bind_teaminvite", KEY_PERIOD, true, true, "Determines the keybind that invites someone to your team, or accepts somebody else's team ivnite")


    CreateClientConVar("efgm_bind_equip_primary1", KEY_1, true, true, "Determines the keybind that equips your first primary")
    CreateClientConVar("efgm_bind_equip_primary2", KEY_2, true, true, "Determines the keybind that equips your second primary")
    CreateClientConVar("efgm_bind_equip_secondary", KEY_3, true, true, "Determines the keybind that equips your secondary")
    CreateClientConVar("efgm_bind_equip_melee", KEY_4, true, true, "Determines the keybind that equips your melee")
    CreateClientConVar("efgm_bind_equip_utility", KEY_G, true, true, "Determines the keybind that equips your grenade")
end

hook.Add("PlayerButtonDown", "EFGMBinds", function(ply, button)
    if SERVER then
        -- drop weapon
        if button == ply:GetInfoNum("efgm_bind_dropweapon", KEY_MINUS) then
            ply:DropWeapon(ply:GetActiveWeapon())
            return
        end
    end

    if CLIENT then
        -- toggle menu
        if button == ply:GetInfoNum("efgm_bind_menu", KEY_TAB) then
            ply:ConCommand("efgm_gamemenu Stats")
            return
        end

        -- show compass
        if button == ply:GetInfoNum("efgm_bind_showcompass", KEY_M) then
            RenderCompass(ply)
            return
        end

        -- show raid information
        if button == ply:GetInfoNum("efgm_bind_raidinfo", KEY_O) then
            RenderExtracts(ply)
            return
        end

        -- switching sights
        if button == ply:GetInfoNum("efgm_bind_changesight", MOUSE_MIDDLE) then
            ply:ConCommand("+arc9_switchsights")
        end

        -- free looking
        if button == ply:GetInfoNum("efgm_bind_freelook", MOUSE_MIDDLE) then
            ply:ConCommand("+freelook")
            return
        end

        -- weapon inspecting
        if button == ply:GetInfoNum("efgm_bind_inspectweapon", KEY_I) then
            ply:ConCommand("+arc9_inspect")
            return
        end

        -- team inviting / accepting
        if button == ply:GetInfoNum("efgm_bind_teaminvite", KEY_PERIOD) then
            -- todo (CHOP CHOP @portanator)
            return
        end

        -- equip primary #1
        if button == ply:GetInfoNum("efgm_bind_equip_primary1", KEY_1) then
            ply:ConCommand("efgm_inventory_equip 2")
            return
        end

        -- equip primary #2
        if button == ply:GetInfoNum("efgm_bind_equip_primary2", KEY_2) then
            ply:ConCommand("efgm_inventory_equip 3")
            return
        end

        -- equip secondary
        if button == ply:GetInfoNum("efgm_bind_equip_secondary", KEY_3) then
            ply:ConCommand("efgm_inventory_equip 4")
            return
        end

        -- equip melee
        if button == ply:GetInfoNum("efgm_bind_equip_melee", KEY_4) then
            ply:ConCommand("efgm_inventory_equip 5")
            return
        end

        -- equip utility
        if button == ply:GetInfoNum("efgm_bind_equip_utility", KEY_G) then
            ply:ConCommand("efgm_inventory_equip 17")
            return
        end
    end

    -- SHARED (for networking/prediction)

    -- lean left
    if button == ply:GetInfoNum("efgm_bind_leanleft", KEY_Q) then
        if ply:GetInfoNum("efgm_controls_togglelean", 1) == 0 then
            ply:SetNW2Var("leaning_left", true)
        else
            local state = not ply:GetNW2Var("leaning_left", false)
            ply:SetNW2Var("leaning_left", state)
            ply:SetNW2Var("leaning_right", false)
        end
        return
    end

    -- lean right
    if button == ply:GetInfoNum("efgm_bind_leanright", KEY_E) then
        if ply:GetInfoNum("efgm_controls_togglelean", 1) == 0 then
            ply:SetNW2Var("leaning_right", true)
        else
            local state = not ply:GetNW2Var("leaning_right", false)
            ply:SetNW2Var("leaning_right", state)
            ply:SetNW2Var("leaning_left", false)
        end
        return
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
            return
        end

        -- weapon inspecting
        if button == ply:GetInfoNum("efgm_bind_inspectweapon", KEY_I) then
            ply:ConCommand("-arc9_inspect")
            return
        end
    end

    -- SHARED (for networking/prediction)

    -- unlean left
    if button == ply:GetInfoNum("efgm_bind_leanleft", KEY_Q) then
        if ply:GetInfoNum("efgm_controls_togglelean", 1) == 1 then return end
        ply:SetNW2Var("leaning_left", false)
        return
    end

    -- unlean right
    if button == ply:GetInfoNum("efgm_bind_leanright", KEY_E) then
        if ply:GetInfoNum("efgm_controls_togglelean", 1) == 1 then return end
        ply:SetNW2Var("leaning_right", false)
        return
    end

end)

-- client sided keybinds do not work in singleplayer, rewriting multiplayer based keybindings to work when playing in a singleplayer instance
if game.SinglePlayer() then
    hook.Remove("PlayerButtonDown", "EFGMBinds")
    hook.Remove("PlayerButtonUp", "EFGMBindsUp")
    hook.Add("PlayerButtonDown", "EFGMBindsSP", function(ply, button)

        if SERVER then
            -- drop weapon
            if button == ply:GetInfoNum("efgm_bind_dropweapon", KEY_MINUS) then
                ply:DropWeapon(ply:GetActiveWeapon())
                return
            end

            -- toggle menu
            if button == ply:GetInfoNum("efgm_bind_menu", KEY_TAB) then
                ply:ConCommand("efgm_gamemenu Stats")
                return
            end

            -- show compass
            if button == ply:GetInfoNum("efgm_bind_showcompass", KEY_M) then
                ply:SendLua("RenderCompass(ply)")
                return
            end

            -- show raid information
            if button == ply:GetInfoNum("efgm_bind_raidinfo", KEY_O) then
                ply:SendLua("RenderExtracts(ply)")
                return
            end

            -- switching sights
            if button == ply:GetInfoNum("efgm_bind_changesight", MOUSE_MIDDLE) then
                ply:ConCommand("+arc9_switchsights")
            end

            -- free looking
            if button == ply:GetInfoNum("efgm_bind_freelook", MOUSE_MIDDLE) then
                ply:ConCommand("+freelook")
                return
            end

            -- weapon inspecting
            if button == ply:GetInfoNum("efgm_bind_inspectweapon", KEY_I) then
                ply:ConCommand("+arc9_inspect")
                return
            end
        end

        -- SHARED (for networking/prediction)

        -- equip primary #1
        if button == ply:GetInfoNum("efgm_bind_equip_primary1", KEY_1) then
            ply:ConCommand("efgm_inventory_equip 2")
            return
        end

        -- equip primary #2
        if button == ply:GetInfoNum("efgm_bind_equip_primary2", KEY_2) then
            ply:ConCommand("efgm_inventory_equip 3")
            return
        end

        -- equip secondary
        if button == ply:GetInfoNum("efgm_bind_equip_secondary", KEY_3) then
            ply:ConCommand("efgm_inventory_equip 4")
            return
        end

        -- equip melee
        if button == ply:GetInfoNum("efgm_bind_equip_melee", KEY_4) then
            ply:ConCommand("efgm_inventory_equip 5")
            return
        end

        -- equip utility
        if button == ply:GetInfoNum("efgm_bind_equip_utility", KEY_G) then
            ply:ConCommand("efgm_inventory_equip 17")
            return
        end

        -- lean left
        if button == ply:GetInfoNum("efgm_bind_leanleft", KEY_Q) then
            if ply:GetInfoNum("efgm_controls_togglelean", 1) == 0 then
                ply:SetNW2Var("leaning_left", true)
            else
                local state = not ply:GetNW2Var("leaning_left", false)
                ply:SetNW2Var("leaning_left", state)
                ply:SetNW2Var("leaning_right", false)
            end
            return
        end

        -- lean right
        if button == ply:GetInfoNum("efgm_bind_leanright", KEY_E) then
            if ply:GetInfoNum("efgm_controls_togglelean", 1) == 0 then
                ply:SetNW2Var("leaning_right", true)
            else
                local state = not ply:GetNW2Var("leaning_right", false)
                ply:SetNW2Var("leaning_right", state)
                ply:SetNW2Var("leaning_left", false)
            end
            return
        end
    end)

    hook.Add("PlayerButtonUp", "EFGMBindsUp", function(ply, button)
        if SERVER then

            -- switching sights
            if button == ply:GetInfoNum("efgm_bind_changesight", MOUSE_MIDDLE) then
                ply:ConCommand("-arc9_switchsights")
            end

            -- free looking
            if button == ply:GetInfoNum("efgm_bind_freelook", MOUSE_MIDDLE) then
                ply:ConCommand("-freelook")
                return
            end

            -- weapon inspecting
            if button == ply:GetInfoNum("efgm_bind_inspectweapon", KEY_I) then
                ply:ConCommand("-arc9_inspect")
                return
            end
        end

        -- SHARED (for networking/prediction)

        -- unlean left
        if button == ply:GetInfoNum("efgm_bind_leanleft", KEY_Q) then
            if ply:GetInfoNum("efgm_controls_togglelean", 1) == 1 then return end
            ply:SetNW2Var("leaning_left", false)
            return
        end

        -- unlean right
        if button == ply:GetInfoNum("efgm_bind_leanright", KEY_E) then
            if ply:GetInfoNum("efgm_controls_togglelean", 1) == 1 then return end
            ply:SetNW2Var("leaning_right", false)
            return
        end
    end)
end