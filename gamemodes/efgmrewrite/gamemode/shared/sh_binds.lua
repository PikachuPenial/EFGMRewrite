-- self explanitory
if CLIENT then
    CreateClientConVar("efgm_bind_raidinfo", KEY_O, true, true, "Determines the keybind that will begin cocking a grenade")
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

        -- magazine check
        if button == ply:GetInfoNum("efgm_bind_magcheck", KEY_B) then
            return
        end
    end
end)    