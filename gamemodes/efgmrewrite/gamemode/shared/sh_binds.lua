-- self explanitory (erm actually its explanatory 🤓) (fuck off porty)
if CLIENT then
    CreateClientConVar("efgm_bind_menu", KEY_TAB, true, true, "Determines the keybind that will display the menu")
    CreateClientConVar("efgm_bind_showcompass", KEY_M, true, true, "Determines the keybind that shows the compass")
    CreateClientConVar("efgm_bind_raidinfo", KEY_O, true, true, "Determines the keybind that will display available extracts and time remaining in the raid")
    CreateClientConVar("efgm_bind_leanleft", KEY_Q, true, true, "Determines the keybind that will begin a left lean")
    CreateClientConVar("efgm_bind_leanright", KEY_E, true, true, "Determines the keybind that will begin a right lean")
    CreateClientConVar("efgm_bind_freelook", MOUSE_MIDDLE, true, true, "Determines the keybind that will begin a free look")
    CreateClientConVar("efgm_bind_changesight", MOUSE_MIDDLE, true, true, "Determines the keybind that adjusts the zoom/reticle of your weapons sight")
    CreateClientConVar("efgm_bind_changefiremode", KEY_B, true, true, "Determines the keybind that toggles between available fire modes for your weapon")
    CreateClientConVar("efgm_bind_inspectweapon", KEY_I, true, true, "Determines the keybind that inspects your weapon")
    CreateClientConVar("efgm_bind_toggleubgl", KEY_N, true, true, "Determines the keybind that toggles to and from your UBGL")
    CreateClientConVar("efgm_bind_teaminvite", KEY_F3, true, true, "Determines the keybind that invites someone to your team")
    CreateClientConVar("efgm_bind_duelinvite", KEY_F4, true, true, "Determines the keybind that invites someone to a duel")
    CreateClientConVar("efgm_bind_viewprofile", KEY_P, true, true, "Determines the keybind that opens another players profile while looking at them")
    CreateClientConVar("efgm_bind_invites_accept", KEY_F1, true, true, "Determines the keybind that accepts an invite")
    CreateClientConVar("efgm_bind_invites_decline", KEY_F2, true, true, "Determines the keybind that declines an invite")
    CreateClientConVar("efgm_bind_dropitem", KEY_DELETE, true, true, "Determines the keybind that drops the hovered item in the menu")
    CreateClientConVar("efgm_bind_deleteitem", KEY_DELETE, true, true, "Determines the keybind that deletes the hovered item in the menu")

    CreateClientConVar("efgm_bind_equip_primary1", KEY_1, true, true, "Determines the keybind that equips your first primary")
    CreateClientConVar("efgm_bind_equip_primary2", KEY_2, true, true, "Determines the keybind that equips your second primary")
    CreateClientConVar("efgm_bind_equip_secondary", KEY_3, true, true, "Determines the keybind that equips your secondary")
    CreateClientConVar("efgm_bind_equip_melee", KEY_4, true, true, "Determines the keybind that equips your melee")
    CreateClientConVar("efgm_bind_equip_utility", KEY_5, true, true, "Determines the keybind that equips your grenade")
    CreateClientConVar("efgm_bind_equip_medical", KEY_H, true, true, "Determines the keybind that equips your medical item")
end

-- toggle crouch
local function CreateToggleDuckHook()

    hook.Add("PlayerBindPress", "ToggleDuck", function(ply, bind, pressed)

        if (GetConVar("efgm_controls_toggleduck"):GetBool() == false) then hook.Remove("PlayerBindPress", "ToggleDuck") return end

        if string.find(bind, "+duck") and ply:Crouching() == false then

            ply:ConCommand("+duck")

        elseif string.find(bind, "+duck") and ply:Crouching() == true then

            ply:ConCommand("-duck")

        end

    end)

end

CreateToggleDuckHook()

-- remove toggle crouch hook when not enabled
cvars.AddChangeCallback("efgm_controls_toggleduck", function(convar_name, value_old, value_new)

    if value_new == "1" then CreateToggleDuckHook() else hook.Remove("PlayerBindPress", "ToggleDuck") end

end)

hook.Add("PlayerSpawn", "UnduckOnSpawn", function(ply) ply:ConCommand("-duck") end)

hook.Add("PlayerButtonDown", "EFGMBinds", function(ply, button)

    if CLIENT and IsFirstTimePredicted() then

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

        -- toggle fire modes
        if button == ply:GetInfoNum("efgm_bind_changefiremode", KEY_B) then
            ply:ConCommand("+zoom")
            return
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

        -- toggle ubgl
        if button == ply:GetInfoNum("efgm_bind_toggleubgl", KEY_N) then
            ply:ConCommand("+arc9_ubgl")
            return
        end

        -- team inviting
        if button == ply:GetInfoNum("efgm_bind_teaminvite", KEY_F3) then

            if !ply:CompareStatus(0) and !ply:CompareStatus(3) then return end

            local ent = (ply:Alive() and ply:GetEyeTrace() or default_trace()).Entity
            if !ent:IsPlayer() then return end
            if !IsValid(ent) then return end
            if !ent:CompareStatus(0) and !ent:CompareStatus(3) then return end

            InvitePlayerToSquad(ply, ent)

            return

        end

        -- duel inviting
        if button == ply:GetInfoNum("efgm_bind_duelinvite", KEY_F4) then

            if !ply:CompareStatus(0) and !ply:CompareStatus(3) then return end

            local ent = (ply:Alive() and ply:GetEyeTrace() or default_trace()).Entity
            if !ent:IsPlayer() then return end
            if !IsValid(ent) then return end

            InvitePlayerToDuel(ply, ent)

            return

        end

        -- view profile
        if button == ply:GetInfoNum("efgm_bind_viewprofile", KEY_P) then

            if !ply:CompareStatus(0) and !ply:CompareStatus(3) then return end

            local ent = (ply:Alive() and ply:GetEyeTrace() or default_trace()).Entity
            if !ent:IsPlayer() then return end
            if !IsValid(ent) then return end

            CreateNotification("I do not work yet LOL!", Mats.dontEvenAsk, "ui/boo.wav")

            return

        end

        -- accept invite
        if button == ply:GetInfoNum("efgm_bind_invites_accept", KEY_F3) then

            if !ply:CompareStatus(0) and !ply:CompareStatus(3) then return end
            AcceptInvite(ply)

            return

        end

        -- decline invite
        if button == ply:GetInfoNum("efgm_bind_invites_decline", KEY_F4) then

            if !ply:CompareStatus(0) and !ply:CompareStatus(3) then return end
            DeclineInvite(ply)

            return

        end

        -- equip primary
        if button == ply:GetInfoNum("efgm_bind_equip_primary1", KEY_1) then
            ply:ConCommand("efgm_inventory_equip " .. WEAPONSLOTS.PRIMARY.ID .. " 1")
            return
        end

        if button == ply:GetInfoNum("efgm_bind_equip_primary2", KEY_2) then
            ply:ConCommand("efgm_inventory_equip " .. WEAPONSLOTS.PRIMARY.ID .. " 2")
            return
        end

        -- equip holster
        if button == ply:GetInfoNum("efgm_bind_equip_secondary", KEY_3) then
            ply:ConCommand("efgm_inventory_equip " .. WEAPONSLOTS.HOLSTER.ID)
            return
        end

        -- equip melee
        if button == ply:GetInfoNum("efgm_bind_equip_melee", KEY_4) then
            ply:ConCommand("efgm_inventory_equip " .. WEAPONSLOTS.MELEE.ID)
            return
        end

        -- equip grenade
        if button == ply:GetInfoNum("efgm_bind_equip_utility", KEY_5) then
            ply:ConCommand("efgm_inventory_equip " .. WEAPONSLOTS.GRENADE.ID)
            return
        end

        -- equip medical
        if button == ply:GetInfoNum("efgm_bind_equip_medical", KEY_H) then
            ply:ConCommand("efgm_inventory_equip " .. WEAPONSLOTS.MEDICAL.ID)
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

    if CLIENT and IsFirstTimePredicted() then

        -- switching sights
        if button == ply:GetInfoNum("efgm_bind_changesight", MOUSE_MIDDLE) then
            ply:ConCommand("-arc9_switchsights")
        end

        -- toggle fire modes
        if button == ply:GetInfoNum("efgm_bind_changefiremode", KEY_B) then
            ply:ConCommand("-zoom")
            return
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

        -- toggle ubgl
        if button == ply:GetInfoNum("efgm_bind_toggleubgl", KEY_N) then
            ply:ConCommand("-arc9_ubgl")
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

            -- toggle fire modes
            if button == ply:GetInfoNum("efgm_bind_changefiremode", KEY_B) then
                ply:ConCommand("+zoom")
                return
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

            -- toggle ubgl
            if button == ply:GetInfoNum("efgm_bind_toggleubgl", KEY_N) then
                ply:ConCommand("+arc9_ubgl")
                return
            end

        end

        -- SHARED (for networking/prediction)

        -- equip primary
        if button == ply:GetInfoNum("efgm_bind_equip_primary1", KEY_1) then
            ply:ConCommand("efgm_inventory_equip " .. WEAPONSLOTS.PRIMARY.ID .. " 1")
            return
        end

        if button == ply:GetInfoNum("efgm_bind_equip_primary2", KEY_2) then
            ply:ConCommand("efgm_inventory_equip " .. WEAPONSLOTS.PRIMARY.ID .. " 2")
            return
        end

        -- equip holster
        if button == ply:GetInfoNum("efgm_bind_equip_secondary", KEY_3) then
            ply:ConCommand("efgm_inventory_equip " .. WEAPONSLOTS.HOLSTER.ID)
            return
        end

        -- equip melee
        if button == ply:GetInfoNum("efgm_bind_equip_melee", KEY_4) then
            ply:ConCommand("efgm_inventory_equip " .. WEAPONSLOTS.MELEE.ID)
            return
        end

        -- equip grenade
        if button == ply:GetInfoNum("efgm_bind_equip_utility", KEY_5) then
            ply:ConCommand("efgm_inventory_equip " .. WEAPONSLOTS.GRENADE.ID)
            return
        end

        if button == ply:GetInfoNum("efgm_bind_equip_medical", KEY_H) then
            ply:ConCommand("efgm_inventory_equip " .. WEAPONSLOTS.MEDICAL.ID)
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

            -- toggle fire modes
            if button == ply:GetInfoNum("efgm_bind_changefiremode", KEY_B) then
                ply:ConCommand("-zoom")
                return
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

            -- toggle ubgl
            if button == ply:GetInfoNum("efgm_bind_toggleubgl", KEY_N) then
                ply:ConCommand("-arc9_ubgl")
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