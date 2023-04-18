include("shared.lua")
include("config.lua")

-- important ones first so lua doesnt get mad
include("cl_menu_manager.lua")
include("cl_menu_alias.lua")
-- include("cl_keybinds.lua")

include("cl_hud.lua")
include("cl_menu.lua")
-- include("cl_progression_menu.lua")
include("cl_raid_info.lua")
-- include("cl_scoreboard.lua")
-- include("cl_shop_menu.lua")
-- include("cl_stash_menu.lua")

-- Intel shit

include("intel/cl_intel.lua")
include("intel/info_concrete.lua")

-- free look
local freelooking = false
concommand.Add("+freelook", function(ply, cmd, args) freelooking = true end)
concommand.Add("-freelook", function(ply, cmd, args) freelooking = false end)

local LookX, LookY = 0, 0
local InitialAng, CoolAng = Angle(), Angle()
local ZeroAngle = Angle()

local function isinsights(ply)
    local weapon = ply:GetActiveWeapon()
    return blockads and (ply:KeyDown(IN_ATTACK2) or (weapon.GetInSights and weapon:GetInSights()) or (weapon.GetIronSights and weapon:GetIronSights()))
end

local function holdingbind(ply)
    if !input.LookupBinding("freelook") then
        return ply:KeyDown(IN_WALK)
    else
        return freelooking
    end
end

hook.Add("CalcView", "AltlookView", function(ply, origin, angles, fov)
    local smoothness = math.Clamp(smooth, 0.1, 2)

    CoolAng = LerpAngle(0.15 * smoothness, CoolAng, Angle(LookY, -LookX, 0))

    if !holdingbind(ply) and CoolAng.p < 0.05 and CoolAng.p > -0.05 or isinsights(ply) and CoolAng.p < 0.05 and CoolAng.p > -0.05 or !system.HasFocus() or ply:ShouldDrawLocalPlayer() then
        InitialAng = angles + CoolAng
        LookX, LookY = 0, 0

        CoolAng = ZeroAngle

        return
    end

    angles.p = angles.p + CoolAng.p
    angles.y = angles.y + CoolAng.y
end)

hook.Add("CalcViewModelView", "AltlookVM", function(wep, vm, oPos, oAng, pos, ang)
    local MWBased = wep.m_AimModeDeltaVelocity and -1.5 or 1

    ang.p = ang.p + CoolAng.p / 2.5 * MWBased
    ang.y = ang.y + CoolAng.y / 2.5 * MWBased
end)

hook.Add("InputMouseApply", "AltlookMouse", function(cmd, x, y, ang)
    local lp = LocalPlayer()
    if !holdingbind(lp) or isinsights(lp) or lp:ShouldDrawLocalPlayer() then LookX, LookY = 0, 0 return end

    InitialAng.z = 0
    cmd:SetViewAngles(InitialAng)

    LookX = math.Clamp(LookX + x * 0.02, -limH, limH)
    LookY = math.Clamp(LookY + y * 0.02, -limV, limV)

    return true
end)

hook.Add("StartCommand", "AltlookBlockShoot", function(ply, cmd)
    if !ply:IsPlayer() or !ply:Alive() then return end
    if !blockshoot then return end

    if !holdingbind(ply) or isinsights(ply) or ply:ShouldDrawLocalPlayer() then return end
    cmd:RemoveKey(IN_ATTACK)
end)