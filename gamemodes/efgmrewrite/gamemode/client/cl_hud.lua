
local function DebugRaidTime()

    surface.SetTextColor(Color(255, 255, 255))
    surface.SetFont("DermaLarge")
    surface.SetTextPos(20 * MenuAlias.widthRatio, 300 * MenuAlias.heightRatio)

    -- time logic

    local raidTime = GetGlobalInt("RaidTimeLeft", -1)
    local raidStatus = GetGlobalInt("RaidStatus", 0)

    local tempStatusTable = {
        [0] = "Raid Pending",
        [1] = "Raid Active",
        [2] = "Raid Over"
    }

    surface.DrawText( string.FormattedTime( raidTime, "%2i:%02i" ) .. "\n" .. tempStatusTable[raidStatus] )

end
hook.Add("HUDPaint", "DrawTimer", DebugRaidTime)

function DrawTarget()
    return false
end
hook.Add("HUDDrawTargetID", "HidePlayerInfo", DrawTarget)

function DrawAmmoInfo()
    return false
end
hook.Add("HUDAmmoPickedUp", "AmmoPickedUp", DrawAmmoInfo)

function DrawWeaponInfo()
    return false
end
hook.Add("HUDWeaponPickedUp", "WeaponPickedUp", DrawWeaponInfo)

function DrawItemInfo()
    return false
end
hook.Add("HUDItemPickedUp", "ItemPickedUp", DrawItemInfo)

function HideHud(name)
    -- full: {"CHudHealth", "CHudBattery", "CHudAmmo", "CHudSecondaryAmmo", "CHudCrosshair"}
    for k, v in pairs({"CHudBattery", "CHudCrosshair"}) do
        if name == v then
            return false
        end
    end
end
hook.Add("HUDShouldDraw", "HideDefaultHud", HideHud)

net.Receive("VoteableMaps", function(len)

    local tbl = net.ReadTable()

    LocalPlayer():PrintMessage(HUD_PRINTCENTER, "Look in the console and (efgm_vote mapname) for a map, im not good at UI so fuck you.")
    PrintTable(tbl)

end)